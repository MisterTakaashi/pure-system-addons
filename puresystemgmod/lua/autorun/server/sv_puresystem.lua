AddCSLuaFile("autorun/client/cl_gui.lua")
AddCSLuaFile()
include("autorun/pure_config.lua")

util.AddNetworkString("OpenGuiPure")

hook.Add( "PlayerSay", "OpenPurePanel", function(ply, text, public)
	text = string.lower(text)
	if (string.sub(text, 1,5) == "!pure") and table.HasValue(PURE.authgrp, ply:GetUserGroup()) then
		net.Start("OpenGuiPure")
		net.Send(ply)
	end
end)
