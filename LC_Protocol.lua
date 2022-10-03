local Dissector_LC = Proto( "LC", "Luke Chikkala" )

local NameField_LC = ProtoField.new( "Name", "GivenName", ftypes.STRING )
local AgeField_LC  = ProtoField.new( "Age" , "GivenAge" , ftypes.STRING )

Dissector_LC.fields = {
                           NameField_LC
                           ,AgeField_LC
                       }

function Dissector_LC.dissector( buffer, pinfo, tree )
    -- <Tvb>
    local length = buffer:len()

    -- <Pinfo>
    pinfo.cols.protocol = Dissector_LC.name

    -- <TreeItem>
    local subtree = tree:add( Dissector_LC, buffer(), "Luke Chikkala Protocol" )
    local eth_withoutfcs = Dissector.get( "eth_withoutfcs" )
    subtree:add( NameField_LC, buffer(  0, 12 ) )
    subtree:add( AgeField_LC , buffer( 13,  2 ) )
end

ether_table = DissectorTable.get( "udp.port" ):add(54321, Dissector_LC)