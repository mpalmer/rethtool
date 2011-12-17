require 'rethtool'
require 'rethtool/ethtool_value'

# Retrieve the current link status of an interface.
#
# Usage is very simple:
#
#   LinkStatus.new("eth0").up?
#
# or
#
#   LinkStatus.new("eth0").down?
#
class Rethtool::LinkStatus
	def initialize(interface)
		cmd = Rethtool::EthtoolValue.new
		cmd.cmd = Rethtool::ETHTOOL_CMD_GSET
		
		@status = Rethtool.ioctl(interface, cmd).value
	end
	
	def down?
		@status == 0
	end
	
	def up?
		!down?
	end
end
