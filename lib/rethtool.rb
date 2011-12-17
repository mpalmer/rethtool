require 'socket'

# A (very) partial implementation of the functionality available in ethtool
# (and the associated ioctl interface) in pure Ruby.
#
# Why?  Because I like to do crazy things.
#
# All the functionality you're likely to actually want is in subclasses of
# Rethtool itself:
#
#  Rethtool::InterfaceSettings
#    Get the settings (speed, duplex, etc) of an interface
#
#  Rethtool::LinkStatus
#    Whether the link is up or down
#
class Rethtool
	# From /u/i/linux/sockios.h
	SIOCETHTOOL = 0x8946

	# From /u/i/linux/ethtool.h
	ETHTOOL_CMD_GLINK = 0x0000000a
	ETHTOOL_CMD_GSET  = 0x00000001

	class << self
		# Issue an SIOCETHTOOL ioctl.  ecmd must respond to #data (such
		# as a CStruct subclass instance).  The modified data will be
		# unserialized and returned.  The data you pass in WILL NOT be
		# modified, you *must* capture the return value if you want any
		# results.
		def ioctl(interface, ecmd)
			sock = Socket.new(Socket::AF_INET, Socket::SOCK_DGRAM, 0)

			ifreq = [interface, ecmd.data].pack("a16p")

			sock.ioctl(SIOCETHTOOL, ifreq)

			rv = ecmd.class.new
			rv.data = ifreq.unpack("a16p")[1]
			rv
		end
	end
end

require 'rethtool/interface_settings'
require 'rethtool/link_status'
