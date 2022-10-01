--[[

	Author: Luke Chikkala

	How to use:
		* Save the plugin in:
			C:\Users\Chikkala\AppData\Roaming\Wireshark\plugins\3.6\
		* Launch Wireshark
		  If Wireshark is already running, use the following shortcut
		  to reload the Lua engine on the Wireshark:
		  	Ctrl + Shift + L

]]--
local Title = "Luke Chikkala's Wireshark Plugins"
local msg   = "Hello World"

if gui_enabled() == true then
	local Win_LC = TextWindow.new(Title);
	Win_LC:set(msg);
end