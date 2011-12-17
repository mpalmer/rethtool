require 'rethtool'
require 'cstruct'

class Rethtool::EthtoolCmd < CStruct
	uint32 :cmd
	uint32 :supported
	uint32 :advertising
	uint16 :speed
	uint8  :duplex
	uint8  :port
	uint8  :phy_address
	uint8  :transceiver
	uint8  :autoneg
	uint8  :mdio_support
	uint32 :maxtxpkt
	uint32 :maxrxpkt
	uint16 :speed_hi
	uint8  :eth_tp_mdix
	uint8  :reserved
	uint32 :lp_advertising
	uint32 :reserved2
	uint32 :reserved3
end
