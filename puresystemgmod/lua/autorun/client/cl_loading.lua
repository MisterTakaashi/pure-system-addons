net.Receive("OpenLoadingScreen", function(length)
	chat.AddText( Color( 100, 100, 255 ), "[PS] Chargement de vos données en cours par notre robot...");
	chat.AddText( Color( 100, 100, 255 ), "[PS] Ceci peut durer quelques secondes.");
end);

net.Receive("CloseLoadingScreen", function(length)
	timer.Simple(9, function()
		ply = LocalPlayer();

		local reputation = ply:GetNWInt('reputation');
		local reputationrp = ply:GetNWInt('reputationrp', 'new');
		chat.AddText( Color( 100, 100, 255 ), "[PS] Chargement des données terminé, Bon jeu !");
		chat.AddText( Color( 100, 100, 255 ), "[PS] Réputation: " .. reputation);
		chat.AddText( Color( 100, 100, 255 ), "[PS] Réputation RolePlay: " .. reputationrp);
	end)
end);
