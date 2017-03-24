require 'rethtool'
require 'rethtool/ethtool_cmd'

class Rethtool::RingSettings
	def initialize(interface)
		@interface = interface
		cmd = Rethtool::EthtoolCmdRing.new
		cmd.cmd = Rethtool::ETHTOOL_CMD_GRINGPARAM
		@data = Rethtool.ioctl(interface, cmd)
	end

	def rx_max_pending
		@data.rx_max_pending
	end

	def rx_mini_max_pending
		@data.rx_mini_max_pending
	end

	def rx_jumbo_max_pending
		@data.rx_jumbo_max_pending
	end

	def tx_max_pending
		@data.tx_max_pending
	end

	def rx_pending
		@data.rx_pending
	end

	def rx_mini_pending
		@data.rx_mini_pending
	end

	def rx_jumbo_pending
		@data.rx_jumbo_pending
	end

	def tx_pending
		@data.tx_pending
	end

	def rx_pending=(value)
		set(:rx_pending, value)
	end

	def rx_mini_pending=(value)
		set(:rx_mini_pending, value)
	end

	def rx_jumbo_pending=(value)
		set(:rx_jumbo_pending, value)
	end

	def tx_pending=(value)
		set(:tx_pending, value)
	end

private

	def set(what, value)
    return if @data.send(what) == value
		cmd = @data.clone
		cmd.cmd = Rethtool::ETHTOOL_CMD_SRINGPARAM
		cmd.send(:"#{what}=", value)
		@data = Rethtool.ioctl(@interface, cmd)
	end
end
