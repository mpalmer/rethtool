require 'rethtool'
require 'cstruct'

class Rethtool::EthtoolValue < CStruct
	uint32 :cmd
	uint32 :value
end
