require 'cstruct'

class Rethtool::EthtoolValue < CStruct
	uint32 :cmd
	uint32 :data
end