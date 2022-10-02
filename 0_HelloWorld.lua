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
local Win_LC = TextWindow.new("Title");

local function EmptyFunction()
	Win_LC:append("\n" .. os.date())
end

Win_LC:set("\nMessage")
Win_LC:prepend("\nPrepended Text")
Win_LC:set_editable(true)
Win_LC:add_button("Button Label", EmptyFunction)