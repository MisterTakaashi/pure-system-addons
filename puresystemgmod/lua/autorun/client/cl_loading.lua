AddCSLuaFile()
include("autorun/pure_config.lua")


closed = false
chargementTermine = false

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end

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

    closed = false

	lgui = vgui.Create("DPanel")
	lgui:SetParent(base)
	lgui:SetPos(ScrW()/2 - 200,ScrH() - 100)
	lgui:SetSize(400,100)
	lgui.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,Color(250, 250, 250,255))
        if (chargementTermine == false) then
            draw.DrawText( "Chargement ...", "CloseCaption_Bold", w/2, h/2 - 10, Color(160,160,160,255), TEXT_ALIGN_CENTER )
        else
            draw.DrawText( "Chargement terminé !", "CloseCaption_Bold", w/2, h/2 - 10, Color(160,160,160,255), TEXT_ALIGN_CENTER )
        end
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
	lgui:AlphaTo( 255 , 2, 18)
	lgui:AlphaTo( 50 , 2, 20)
	lgui:AlphaTo( 255 , 2, 22)
	lgui:AlphaTo( 50 , 2, 24)
	lgui:AlphaTo( 255 , 2, 26)


	logserv = vgui.Create("DPanel")
	logserv:SetParent(base)
	logserv:SetSize(ScrW(),150)
	logserv:SetPos(0,-150)
	logserv.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,Color(0, 71, 152, 255))
		if chargementTermine == false then
			draw.DrawText( "Le Pure System charge vos données. Patientez SVP !", "DermaLarge", w/2, h/2 - 10, Color(250,250,250,255), TEXT_ALIGN_CENTER )
		else
			draw.DrawText( "Le Pure System a chargé vos données !", "DermaLarge", w/2, h/2 - 10, Color(250,250,250,255), TEXT_ALIGN_CENTER )
		end
	end
	logserv:MoveTo( 0, 0, 10, 0, -1)

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
		draw.DrawText( "Serveur protégé par PureSystem.fr", "DermaLarge", w/2, h/2 - 10, Color(0, 71, 152, 255), TEXT_ALIGN_CENTER )
	end

	local cdutil = vgui.Create("DFrame", base)
		cdutil:SetPos(100,600)
		cdutil:SetSize(ScrW() - 200, 350)
		cdutil:SetVisible( true )
		cdutil:SetTitle( "" )
		cdutil:SetDraggable( false )
		cdutil:ShowCloseButton( false )
		cdutil.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(255,255,255,250))
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
			draw.OutlinedBox( 0, 0, w, h,2,Color(0, 71, 152, 255) )
		end

	local cdutilh = vgui.Create("HTML",cdutil)
	cdutilh:SetPos( 2, 2 )
	cdutilh:SetSize(ScrW() - 204, 346)
	cdutilh:OpenURL("puresystem.fr/cgu.html")

	local cguok = vgui.Create("DCheckBoxLabel",base)
		cguok:SetPos( 100, 1025 )						// Set the position
		cguok:SetText( "J'ai lu les Conditions Generales d'Utilisation" )					// Set the text next to the box
		cguok:SetValue( 0 )
		cguok:SizeToContents()

	timer.Simple(8,function()
		local cgubutt1 = vgui.Create("DButton", base)
			cgubutt1:SetPos(100,950)
			cgubutt1:SetSize((cdutil:GetWide() /2),50)
			cgubutt1:SetText("")
			cgubutt1.Paint = function(self,w,h)
				draw.RoundedBoxEx( 8, 0, 0, w, h, Color(0,190,0,210), false, false, true,false)
				draw.DrawText( "Accepter les CGU", "DermaLarge", w/2 - 10, 10, Color(250,250,250,255), TEXT_ALIGN_CENTER )
			end
			cgubutt1.DoClick = function()
				if cguok:GetChecked() == true then
					base:Close()
				else
					cavt = vgui.Create("DPanel",base)
					cavt:SetPos(90,1010)
					cavt:SetSize(250,50)
					cavt.Paint = function(self,w,h)
						draw.OutlinedBox(0,0,w,h,2,Color(255,0,0,255))
					end
					cavt:SetAlpha(0)
					cavt:AlphaTo( 255 , 1, 0)
					timer.Simple(2,function()
						cavt:Remove()
					end)
				end
			end

		local cgubutt2 = vgui.Create("DButton",base)
			cgubutt2:SetPos(cgubutt1:GetWide() + 100 ,950)
			cgubutt2:SetSize((cdutil:GetWide() /2),50)
			cgubutt2:SetText("")
			cgubutt2.Paint = function(self,w,h)
				draw.RoundedBoxEx( 8, 0, 0, w, h, Color(190,0,0,210), false, false, false,true)
				draw.DrawText( "Refuser les CGU", "DermaLarge", w/2 - 10, 10, Color(250,250,250,255), TEXT_ALIGN_CENTER )
			end
			cgubutt2.DoClick = function()
				if cguok:GetChecked() == true then
					net.Start("rcgu")
					net.SendToServer()
				else
					cavt = vgui.Create("DPanel",base)
					cavt:SetPos(90,1010)
					cavt:SetSize(250,50)
					cavt.Paint = function(self,w,h)
						draw.OutlinedBox(0,0,w,h,2,Color(255,0,0,255))
					end
					cavt:SetAlpha(0)
					cavt:AlphaTo( 255 , 1, 0)
					timer.Simple(2,function()
						cavt:Remove()
					end)
				end
			end

	end)

end);

net.Receive("CloseLoadingScreen", function(length)
	ply = LocalPlayer();
	chargementTermine = true
	timer.Simple(3, function()
		local reputation = ply:GetNWInt('reputation');
		local reputationrp = ply:GetNWInt('reputationrp', 'new');
		chat.AddText( Color( 0, 250, 0 ), "[PS] Chargement des données terminé, Bon jeu !");
		chat.AddText( Color( 0, 250, 0 ), "[PS] Réputation: " .. reputation);
		chat.AddText( Color( 0, 250, 0 ), "[PS] Réputation RolePlay: " .. reputationrp);
		chat.AddText( Color( 0, 250, 0 ), "[PS] Votre profil Web: http://puresystem.fr/id/" .. ply:SteamID64() .. "/");
		chat.AddText( Color( 0, 250, 0 ), "[PS] Tapez !ppure dans le chat pour acceder directement a votre profil")
	end)
end);

net.Receive("CloseLoadingScreenErr", function(length)
	timer.Simple(1, function()
		ply = LocalPlayer();
		base:Close()
		chat.AddText( Color( 250, 0, 0 ), "[PS] Ce serveur n'est pas répertorié sur le Pure System");
	end)
end);
