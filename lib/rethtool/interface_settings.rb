require 'rethtool'
require 'rethtool/ethtool_cmd'

# All of the settings of a network interface.  Ridiculous amounts of
# info is available; we only support a subset of them at present.
#
# Create an instance of this class with the interface name as the only
# parameter, then use the available instance methods to get the info you
# seek:
#
#    if = Rethtool::InterfaceSettings.new("eth0")
#    puts "Current link mode is #{if.current_mode}"
#
class Rethtool::InterfaceSettings
	Mode = Struct.new(:speed, :duplex, :media)

	# A struct to represent interface modes (supported, advertised, current)
	#
	# available fields are:
	#
	#  .speed -- integer link speed, in Mb (-1 if unknown)
	#  .duplex -- :full, :half, :fec, or :unknown
	#  .media -- A string, such as 'T', 'X', 'KX', etc, or nil if unknown
	#
	class Mode
		# Print out a more standard-looking representation for a mode
		def to_s
			if self.speed == :unknown
				"Unknown"
			else
				"#{self.speed}base#{self.media}/#{self.duplex}"
			end
		end
	end
	
	# Create a new InterfaceSettings object.  Simply pass it the name of the
	# interface you want to get the settings for.
	def initialize(interface)
		@interface = interface
		cmd = Rethtool::EthtoolCmd.new
		cmd.cmd = Rethtool::ETHTOOL_CMD_GSET
		@data = Rethtool.ioctl(interface, cmd)

		cmd_driver = Rethtool::EthtoolCmdDriver.new
		cmd_driver.cmd = Rethtool::ETHTOOL_CMD_GDRVINFO
		@driver_data = Rethtool.ioctl(interface, cmd_driver)
	end

        # Returns a string with the value of the interface driver (kernel module).
        def driver
		as_str(@driver_data.driver)
        end

        # Returns a string with the bus information of the interface.
        def bus_info
		as_str(@driver_data.bus_info)
        end
	
	# Return an array of the modes supported by the interface.  Returns an
	# array of Mode objects.
	def supported_modes
		modes(@data.supported)
	end
	
	# Return an array of the modes advertised by the interface.  Returns an
	# array of Mode objects.  If you know the difference between 'supported'
	# and 'advertised', you're one up on me.
	def advertised_modes
		modes(@data.advertising)
	end
	
	# Return a Mode object representing the current detected mode of the
	# interface.
	def current_mode
		speed = @data.speed
		speed = :unknown if speed == 65535
		
		duplex = case @data.duplex
			when 0 then :half
			when 1 then :full
			else        :unknown
		end
		
		port = case @data.port
			when 0   then 'T'
			when 1   then 'AUI'
			when 2   then 'MII'
			when 3   then 'F'
			when 4   then 'BNC'
			when 255 then 'Other'
			else          'Unknown'
		end
		
		Mode.new(speed, duplex, port)
	end
	
	# Return the "best" possible mode supported by this interface.
	# This is the highest speed mode with the "best" duplex
	# (fec > full > half).
	def best_mode
		modes = self.advertised_modes
		best_speed = modes.map { |m| m.speed }.sort.last
		high_speed_modes = modes.find_all { |m| m.speed == best_speed }

		# Somewhere recently, RHEL decided to release a kernel or libc update
		# that changes the behaviour of the ethtool ioctl so that instead of
		# returning EOPNOTSUPP when you ask for available speeds on an interface
		# that doesn't support that (like bonded NICs), it now returns success with
		# an empty list.  WHO DOES THAT SORT OF SHIT?!?  So we've got to fake it
		# ourselves.
		raise Errno::EOPNOTSUPP.new("#{@interface} doesn't support enumerating speed modes") if modes.empty?

		if high_speed_modes.length == 0
			raise RuntimeError.new("Can't happen: no modes with the best speed?!?")
		elsif high_speed_modes.length == 1
			high_speed_modes.first
		else
			duplexes = high_speed_modes.map { |m| m.duplex }
			best_duplex = if duplexes.include? :fec
				:fec
			elsif duplexes.include? :full
				:full
			else
				:half
			end
			high_speed_modes.find { |m| m.duplex == best_duplex }
		end
	end
	
	private
	
	PossibleModes = {
			  1 << 0  => Mode.new(10, :half, 'T'),
			  1 << 1  => Mode.new(10, :full, 'T'),
			  1 << 2  => Mode.new(100, :half, 'T'),
			  1 << 3  => Mode.new(100, :full, 'T'),
			  1 << 4  => Mode.new(1000, :half, 'T'),
			  1 << 5  => Mode.new(1000, :full, 'T'),
			  1 << 12 => Mode.new(10000, :full, 'T'),
			  1 << 15 => Mode.new(2500, :full, 'X'),
			  1 << 17 => Mode.new(1000, :full, 'KX'),
			  1 << 18 => Mode.new(10000, :full, 'KX4'),
			  1 << 19 => Mode.new(10000, :full, 'KR'),
			  1 << 20 => Mode.new(10000, :fec, 'R'),
			  1 << 21 => Mode.new(20000, :full, 'MLD2'),
			  1 << 22 => Mode.new(20000, :full, 'KR2'),
			  1 << 23 => Mode.new(40000, :full, 'KR4'),
			  1 << 24 => Mode.new(40000, :full, 'CR4'),
			  1 << 25 => Mode.new(40000, :full, 'SR4'),
			  1 << 26 => Mode.new(40000, :full, 'LR4'),
			  1 << 27 => Mode.new(56000, :full, 'KR4'),
			  1 << 28 => Mode.new(56000, :full, 'CR4'),
			  1 << 29 => Mode.new(56000, :full, 'SR4'),
			  1 << 30 => Mode.new(56000, :full, 'LR4'),
	}

	# Turn a uint32 of bits into a list of supported modes.  Sigh.
	def modes(data)
		PossibleModes.find_all { |m| (m[0] & data) > 0 }.map { |m| m[1] }
	end

        def as_str(str)
                str.pack('c*').delete("\000")
        end
end
