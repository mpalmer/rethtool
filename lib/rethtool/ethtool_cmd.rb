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

class Rethtool::EthtoolCmdDriver < CStruct
        uint32 :cmd
        char   :driver,[32]
        char   :version,[32]
        char   :fw_version,[32]
        char   :bus_info,[32]
        char   :reserved1,[32]
        char   :reserved2,[16]
        uint32 :n_stats
        uint32 :testinfo_len
        uint32 :eedump_len
        uint32 :regdump_len
end

class Rethtool::EthtoolCmdRing < CStruct
	uint32 :cmd
	uint32 :rx_max_pending
	uint32 :rx_mini_max_pending
	uint32 :rx_jumbo_max_pending
	uint32 :tx_max_pending
	uint32 :rx_pending
	uint32 :rx_mini_pending
	uint32 :rx_jumbo_pending
	uint32 :tx_pending
end
