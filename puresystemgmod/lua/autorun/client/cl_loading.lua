AddCSLuaFile()
include("autorun/pure_config.lua")
net.Receive("OpenLoadingScreen", function(length)

	base = vgui.Create("DFrame")
	base:SetPos(0,0)
	base:SetSize(ScrW(),ScrH())
	base:SetVisible( true )
	base:SetTitle( "" )
	base:SetDraggable( false )
	base:ShowCloseButton( true )
	base:MakePopup()
	base.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(250,250,250,255))
	end

	lgui = vgui.Create("DPanel")
	lgui:SetParent(base)
	lgui:SetPos(ScrW()/2 - 200,ScrH() - 150)
	lgui:SetSize(400,100)
	lgui.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(250, 250, 250,255))
		draw.DrawText( "Chargement ...", "CloseCaption_Bold", w/2, h/2 - 10, Color(160,160,160,255), TEXT_ALIGN_CENTER )
	end
	lgui:AlphaTo( 50, 2, 0)
	lgui:AlphaTo( 255, 2, 2)
	lgui:AlphaTo( 50 , 2, 4)
	lgui:AlphaTo( 255 , 2, 6)
	lgui:AlphaTo( 50 , 2, 8)
	lgui:AlphaTo( 255 , 2, 10)
	lgui:AlphaTo( 50 , 2, 12)
	lgui:AlphaTo( 255 , 2, 14)
	lgui:AlphaTo( 50 , 2, 16)

	logserv = vgui.Create("DPanel")
	logserv:SetParent(base)
	logserv:SetSize(ScrW(),150)
	logserv:SetPos(0,-150)
	logserv.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(0, 71, 152, 255))
		draw.DrawText( "Le Pure System charge vos données. Patientez SVP !", "DermaLarge", w/2, h/2 - 10, Color(250,250,250,255), TEXT_ALIGN_CENTER )
	end
	logserv:MoveTo( 0, 0, 5, 0, -1)

	logoser = vgui.Create("DImage")
	logoser:SetParent(base)
	logoser:SetPos(ScrW()/2 - 230,250)
	logoser:SetSize(460,215)
	logoser:SetImage(PURE.servlogo[math.random( 1, #PURE.servlogo )])
	logoser:AlphaTo(50,1,0)
	logoser:AlphaTo(255,3,1)

	msgpro = vgui.Create("DPanel")
	msgpro:SetParent(base)
	msgpro:SetPos(0,500)
	msgpro:SetSize(ScrW(), 100)
	msgpro.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(250, 250, 250, 255))
		draw.DrawText( "Serveur protégé par le Pure System", "DermaLarge", w/2, h/2 - 10, Color(0, 71, 152, 255), TEXT_ALIGN_CENTER )
	end


end);

net.Receive("CloseLoadingScreen", function(length)
	timer.Simple(9, function()
		ply = LocalPlayer();
		base:Close()
		local reputation = ply:GetNWInt('reputation');
		local reputationrp = ply:GetNWInt('reputationrp', 'new');
		chat.AddText( Color( 0, 250, 0 ), "[PS] Chargement des données terminé, Bon jeu !");
		chat.AddText( Color( 0, 250, 0 ), "[PS] Réputation: " .. reputation);
		chat.AddText( Color( 0, 250, 0 ), "[PS] Réputation RolePlay: " .. reputationrp);
	end)
end);
