--[[

	Author: Luke Chikkala

	How to use:
		* Save the plugin in:
			C:\Users\Chikkala\AppData\Roaming\Wireshark\plugins\3.6\
		* Launch Wireshark
		  If Wireshark is already running, use the following shortcut
		  to reload the Lua engine on the Wireshark:
			Ctrl + Shift + L

	new_dialog(title, action, ...)
		title	: <string>
		action	: <function>
		...		: <string> / 

]]--
local Options = {
					"IP Address",
					"Port"
				}

local function Window_LC(ip, port)
	local Splash_Screen = TextWindow.new("Info");
	Splash_Screen:set("IP Address : " .. ip .. "\n")
	Splash_Screen:append("Port       : " .. port)
end

new_dialog("Enter IP address", Window_LC, Options[1], Options[2]);
