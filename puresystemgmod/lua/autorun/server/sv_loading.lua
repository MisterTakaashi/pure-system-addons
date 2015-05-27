AddCSLuaFile("autorun/client/cl_loading.lua");

util.AddNetworkString("OpenLoadingScreen");

hook.Add("PlayerInitialSpawn","Loading_Initial_Spawn",function(ply)
	ply:PrintMessage(HUD_PRINTCENTER, "Veuillez patienter PSB0t charge vos données...");
	
	net.Start("OpenLoadingScreen")
	net.Send(ply)
end);