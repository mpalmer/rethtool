require 'rethtool'
require 'rethtool/ethtool_cmd'

# Driver settings of a network interface.
#
# Create an instance of this class with the interface name as the only
# parameter, then use the available instance methods to get the info you
# seek:
#
#    if = Rethtool::DriverSettings.new("eth0")
#    puts "Bus info is #{if.bus_info}"
#
class Rethtool::DriverSettings

	# Create a new DriverSettings object.  Simply pass it the name of the
	# interface you want to get the settings for.
	def initialize(interface)
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

	def as_str(str)
		str.pack('c*').delete("\000")
	end
end
