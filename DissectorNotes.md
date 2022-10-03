# Writing a Packet Dissector

## Types of Dissections
Dissection
Heuristic Dissection
Post Dissection

## Setup Wireshark to Look for new Protocol
Create a variable and assign the `Proto()` function.
```Lua
--                        Protocol  Description
local MyDissector = Proto(<string>, <string>)
```
This is used in the `Analyze` -> `Enabled Protocols...` dialog.<br>
The 1st string is shown in the `Protocol` column.
The 2nd string is shown in the `Description` column.

<p align="center">
    <img src="rsc/EnabledProtocols.png" width=50% height=50%>
</p>

## Adding items to the dissection tree
```Lua
local TreeItem1 = ProtoField.uint8(
                                    <string>     -- Name of the Field
                                   ,<string>     -- Filter Name
                                   ,type         -- Field Type, e.g.: int, bool, ...
                                   [<string>]    -- Value
                                   ,[base()]     -- base.NONE, base.DEC, base.HEX, ...
                                   ,[mask()]     -- Bitmask to be used
                                   ,[<string>]   -- Description of the Field
                                   )

local TreeItem2 = ProtoField.uint8(
                                    <string>     -- Name of the Field
                                   ,<string>     -- Filter Name
                                   ,type         -- Field Type, e.g.: int, bool, ...
                                   [<string>]    -- Value
                                   ,[base()]     -- base.NONE, base.DEC, base.HEX, ...
                                   ,[mask()]     -- Bitmask to be used
                                   ,[<string>]   -- Description of the Field
                                   )
```

## Combine tree items into protocol
We should now assign the tree items, `TreeItem1` & `TreeItem2` to our protocol using the `fields` method.
```Lua
MyDissector.fields( TreeItem1, TreeItem2 )
```

## Start Dissection
We should now start dissecting the protocol using the `dissector` method.
```Lua
function MyDissector.dissector(
                               <Tvb>           -- an object that represents the packet's buffer.
                               ,<Pinfo>        -- an object that represents the packet's information.
                               ,<TreeItem>     -- an object that represents the ppacket's details
                               )
```
### `<Tvb>`
An object that represents packet's buffer.<br>
It is passed as an argument to listeners and dissectors.<br>
It is used to extract information from the packet's data.<br>
It must be called with an offset and length as it's optional arguments.<br>
The offset's default value is `0`.<br>
The length's default value is `tvb:captured_len()`; basically the entire length of the packet.<br>

**Members**
<details>
<summary>(click to expand)</summary>
<table>
    <tr>
        <td align="center"><b>Method</b></td>
        <td align="center"><b>Arguments</b></td>
        <td align="center"><b>Description</b></td>
        <td align="center"><b>Return</b></td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:__tostring()</code></td>
        <td>Convert the bytes of a <code>Tvb</code> into a string.<br>
        This is primarily useful for debugging purposes since the string will be truncated if it is too long.</td>
        <td>The string.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:reported_len()</code></td>
        <td>Obtain the reported length (length on the network) of a <code>Tvb</code>.</td>
        <td>The reported length of the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:captured_len()</code></td>
        <td>Obtain the captured length (amount saved in the capture process) of a <code>Tvb</code>.</td>
        <td>The captured length of the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:len()</code></td>
        <td>Obtain the captured length (amount saved in the capture process) of a <code>Tvb</code>.<br>
        Same as <code>captured_len</code>; kept only for backwards compatibility</td>
        <td>The captured length of the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:reported_length_remaining()</code></td>
        <td>Obtain the reported (not captured) length of packet data to end of a <code>Tvb</code> or <code>0</code> if the offset is beyond the end of the <code>Tvb</code>.</td>
        <td>The captured length of the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:bytes([int], [int])</code></td>
        <td>Obtain a ByteArray from a <code>Tvb</code>.</td>
        <td>The ByteArray object or nil.</td>
    </tr>
    <tr>
        <td></td>
        <td><code>[offset]</code></td>
        <td>The offset (in octets) from the beginning of the <code>Tvb</code>.<br>Default: <code>0</code>.</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td><code>[length]</code></td>
        <td>The offset (in octets) from the beginning of the <code>Tvb</code>.<br>Default: <code>0</code>.</td>
        <td></td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:offset()</code></td>
        <td>Returns the raw offset (from the beginning of the source <code>Tvb</code>) of a sub <code>Tvb</code>.</td>
        <td>The raw offset of the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:__call()</code></td>
        <td>Equivalent to <code>tvb:range(…)</code></td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:range([int], [int])</code></td>
        <td>Creates a <code>TvbRange</code> from this <code>Tvb</code>.</td>
        <td>The <code>TvbRange</code></td>
    </tr>
    <tr>
        <td></td>
        <td><code>[offset]</code></td>
        <td>The offset (in octets) from the beginning of the <code>Tvb</code>.<br>Default: <code>0</code>.</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td><code>[length]</code></td>
        <td>The length (in octets) of the range.<br>
        Default: <code>-1</code> (specifies remaining bytes in the <code>Tvb</code>).</td>
        <td></td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:raw([int], [int])</code></td>
        <td>Obtain a Lua string of the binary bytes in a <code>Tvb</code>.</td>
        <td>A Lua string of the binary bytes in the <code>Tvb</code>.</td>
    </tr>
    <tr>
        <td></td>
        <td><code>[offset]</code></td>
        <td>The position of the first byte.<br>Default: <code>0</code> (first byte)</td>
        <td></td>
    </tr>
    <tr>
        <td></td>
        <td><code>[length]</code></td>
        <td>The length of the segment to get.<br>
        Default: <code>-1</code> (remaining bytes) in the <code>Tvb</code>.</td>
        <td></td>
    </tr>
    <tr>
        <td colspan=2><code>tvb:__eq()</code></td>
        <td></td>
        <td>Checks whether contents of two <code>Tvb</code>s are equal.</td>
    </tr>
</table>
</details>

> [Source](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Tvb.html#lua_class_Tvb:~:text=11.8.2.-,Tvb,-A%20Tvb%20represents)

### `<Pinfo>`
An object that represents packet's information.

**Members**
<details>
<summary>(click to expand)</summary>
<table>
    <tr>
        <td align="center"><b>Method</b></td>
        <td align="center"><b>Mode</b></td>
        <td align="center"><b>Description</b></td>
    </tr>
    <tr>
        <td><code>pinfo.visited</code></td>
        <td>Retrieve only</td>
        <td>Whether this packet has been already visited.</td>
    </tr>
    <tr>
        <td><code>pinfo.number</code></td>
        <td>Retrieve only</td>
        <td>The number of this packet in the current file.</td>
    </tr>
    <tr>
        <td><code>pinfo.len</code></td>
        <td>Retrieve only</td>
        <td>The length of the frame.</td>
    </tr>
    <tr>
        <td><code>pinfo.caplen</code></td>
        <td>Retrieve only</td>
        <td>The captured length of the frame.</td>
    </tr>
    <tr>
        <td><code>pinfo.abs_ts</code></td>
        <td>Retrieve only</td>
        <td>When the packet was captured.</td>
    </tr>
    <tr>
        <td><code>pinfo.rel_ts</code></td>
        <td>Retrieve only</td>
        <td>Number of seconds passed since beginning of capture.</td>
    </tr>
    <tr>
        <td><code>pinfo.delta_ts</code></td>
        <td>Retrieve only</td>
        <td>Number of seconds passed since the last captured packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.delta_dis_ts</code></td>
        <td>Retrieve only</td>
        <td>Number of seconds passed since the last displayed packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.curr_proto</code></td>
        <td>Retrieve only</td>
        <td>Which Protocol are we dissecting.</td>
    </tr>
    <tr>
        <td><code>pinfo.can_desegment</code></td>
        <td>Retrieve or assign</td>
        <td>Set if this segment could be desegmented.</td>
    </tr>
    <tr>
        <td><code>pinfo.desegment_len</code></td>
        <td>Retrieve or assign</td>
        <td>Estimated number of additional bytes required for completing the PDU.</td>
    </tr>
    <tr>
        <td><code>pinfo.desegment_offset</code></td>
        <td>Retrieve or assign</td>
        <td>Offset in the tvbuff at which the dissector will continue processing when next called.</td>
    </tr>
    <tr>
        <td><code>pinfo.fragmented</code></td>
        <td>Retrieve only</td>
        <td>If the protocol is only a fragment.</td>
    </tr>
    <tr>
        <td><code>pinfo.in_error_pkt</code></td>
        <td>Retrieve only</td>
        <td>If we’re inside an error packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.match_uint</code></td>
        <td>Retrieve only</td>
        <td>Matched uint for calling subdissector from table.</td>
    </tr>
    <tr>
        <td><code>pinfo.match_string</code></td>
        <td>Retrieve only</td>
        <td>Matched string for calling subdissector from table.</td>
    </tr>
    <tr>
        <td><code>pinfo.port_type</code></td>
        <td>Retrieve or assign</td>
        <td>Type of Port of <code>.src_port</code> and <code>.dst_port</code>.</td>
    </tr>
    <tr>
        <td><code>pinfo.src_port</code></td>
        <td>Retrieve or assign</td>
        <td>Source Port of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.dst_port</code></td>
        <td>Retrieve or assign</td>
        <td>Destination Port of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.dl_src</code></td>
        <td>Retrieve or assign</td>
        <td>Data Link Source Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.dl_dst</code></td>
        <td>Retrieve or assign</td>
        <td>Data Link Destination Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.net_src</code></td>
        <td>Retrieve or assign</td>
        <td>Network Layer Source Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.net_dst</code></td>
        <td>Retrieve or assign</td>
        <td>Network Layer Destination Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.src</code></td>
        <td>Retrieve or assign</td>
        <td>Source Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.dst</code></td>
        <td>Retrieve or assign</td>
        <td>Destination Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.p2p_dir</code></td>
        <td>Retrieve or assign</td>
        <td>Direction of this Packet. (incoming / outgoing)</td>
    </tr>
    <tr>
        <td><code>pinfo.match</code></td>
        <td>Retrieve only</td>
        <td>Port/Data we are matching.</td>
    </tr>
    <tr>
        <td><code>pinfo.columns</code></td>
        <td>Retrieve only</td>
        <td>Access to the packet list columns.</td>
    </tr>
    <tr>
        <td><code>pinfo.cols</code></td>
        <td>Retrieve only</td>
        <td>Access to the packet list columns (equivalent to pinfo.columns).</td>
    </tr>
    <tr>
        <td><code>pinfo.private</code></td>
        <td>Retrieve only</td>
        <td>Access to the private table entries.</td>
    </tr>
    <tr>
        <td><code>pinfo.hi</code></td>
        <td>Retrieve or assign</td>
        <td>Higher Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.lo</code></td>
        <td>Retrieve only</td>
        <td>Lower Address of this Packet.</td>
    </tr>
    <tr>
        <td><code>pinfo.conversation</code></td>
        <td>Assign only</td>
        <td>Sets the packet conversation to the given Proto object.</td>
    </tr>
</table>
<br>
</details>

> [Source](https://www.wireshark.org/docs/wsdg_html_chunked/lua_module_Pinfo.html#lua_class_Pinfo:~:text=11.5.5.-,Pinfo,-Packet%20information.)

### `<TreeItem>`
An object that represents information in packet details pane.<br>
It represents a node in the tree.<br>
A node can have sub-nodes and a list of children.
```
Node
  ⤷ Sub-Node
    Child 1
    Child 2
      ⤷ Sub-Child 1
```
A Tree object is not always needed to be added.<br>
The `<TreeItem>:add()` can still be called to return the objects, but info is not added to the tree.<br>
`TreeItem.visible` attribute will retrieve the state.