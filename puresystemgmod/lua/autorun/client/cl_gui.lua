local function getPlayerFromSteamId64(steamid64)
	for k,v in pairs(player.GetAll()) do
		if v:SteamID64() == steamid64 then
			return v
		end
	end

	return nil
end

local function freezetk(target)
	net.Start("freezetk")
	 net.WriteEntity(target)
	net.SendToServer()
end

local function unfreezetk(target)
	net.Start("unfreezetk")
		net.WriteEntity(target)
	net.SendToServer()
end

local function addAverto(target,detail,sev,rp)
	net.Start( "averto" )
	net.WriteEntity( target )
	net.WriteString( detail )
	net.WriteInt( sev, 4 )
	net.WriteBool( rp )
	net.SendToServer()
end

local function addKickto( target,raison,sev, rp)
	net.Start( "kickto" )
	net.WriteEntity( target )
	net.WriteString( raison )
	net.WriteInt( sev, 4 )
	net.WriteBool( rp )
	net.SendToServer()
end

local function addBanto(target,raison,sev,temp, rp)
	net.Start( "banto" )
	net.WriteEntity( target )
	net.WriteString( raison )
	net.WriteInt( sev, 4 )
	net.WriteFloat( temp )
	net.WriteBool( rp )
	net.SendToServer()
end

local function addBantoSteamID(target,raison,sev,temp, rp)
	net.Start( "bantosteamid" )
	net.WriteString( target )
	net.WriteString( raison )
	net.WriteInt( sev, 4 )
	net.WriteFloat( temp )
	net.WriteBool( rp )
	net.SendToServer()
end

local function addAFKick(target,raison)
	net.Start( "afkick" )
		net.WriteEntity( target )
		net.WriteString( raison )
	net.SendToServer()
end

local function PurePanel()
	local base = vgui.Create( "DFrame" )
	base:Center()
	base:SetPos(ScrW() / 2 - 400, ScrH() / 2 - 250)
	base:SetSize( 800, 500 )
	base:SetVisible( true )
	base:SetTitle( "Pure Admin Panel" )
	base:SetDraggable( true )
	base:ShowCloseButton( false )
	base:SetBackgroundBlur( true )
	base:MakePopup()
	base.Paint = function()
		draw.RoundedBox( 0, 0, 0, base:GetWide(), base:GetTall(), Color( 61, 61, 61, 255 ) )
		-- draw.RoundedBox(0, 0, 0, base:GetWide(), base:GetTall(), Color(170, 170, 170, 255))
		draw.RoundedBox( 0, 0, 0, base:GetWide(), 25, Color(0, 71, 152, 255) )
	end

	local ClosePurePanel = vgui.Create( "DButton" )
    ClosePurePanel:SetParent( base )
		ClosePurePanel:SetPos( base:GetWide() - 30, 0 )
		ClosePurePanel:SetText( "" )
		ClosePurePanel:SetSize( 45, 25 )
		ClosePurePanel.DoClick = function()
        base:Close()
    end
		ClosePurePanel.Paint = function()
        draw.RoundedBox( 0, 0, 0, ClosePurePanel:GetWide(), ClosePurePanel:GetTall(), Color(200,0,0,255) )
        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
    end

	local listh1 = vgui.Create("DPanel",base)
		listh1:SetPos(0,25)
		listh1:SetSize(160,25)
		listh1.Paint =  function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(80,80,80,255))
			draw.DrawText( "Joueurs","Trebuchet18",82,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end

	local listh2 = vgui.Create("DPanel",base)
		listh2:SetPos(160,25)
		listh2:SetSize(160,25)
		listh2.Paint =  function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(80,80,80,255))
			draw.DrawText( "Reputation","Trebuchet18",80,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end

	local listh3 = vgui.Create("DPanel",base)
		listh3:SetPos(320,25)
		listh3:SetSize(160,25)
		listh3.Paint =  function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(80,80,80,255))
			draw.DrawText( "Reputation RP","Trebuchet18",80,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end

	local listh4 = vgui.Create("DPanel",base)
		listh4:SetPos(480,25)
		listh4:SetSize(160,25)
		listh4.Paint =  function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(80,80,80,255))
			draw.DrawText( "SteamID","Trebuchet18",80,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end

	local listh5 = vgui.Create("DPanel",base)
		listh5:SetPos(640,25)
		listh5:SetSize(160,25)
		listh5.Paint =  function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,Color(80,80,80,255))
			draw.DrawText( "SteamID64","Trebuchet18",77,5,Color(255,255,255,255),TEXT_ALIGN_CENTER)
			surface.SetDrawColor(0,0,0)
			surface.DrawOutlinedRect(0,0,w,h)
		end


	local plylist = vgui.Create( "DListView" )
	plylist:SetParent( base )
	plylist:AddColumn( "Joueurs" )
	plylist:AddColumn( "Reputation" )
	plylist:AddColumn( "Reputation RP" )
	plylist:AddColumn( "SteamID" )
	plylist:AddColumn( "SteamID64" )
	plylist:SetHideHeaders(true)
	plylist:SetSize( base:GetWide(), 395 )
	plylist:SetPos( 0, 50 )
	plylist:SetBackgroundColor( Color( 18, 19, 21, 255 ) )
	plylist.Paint = function()
		draw.RoundedBox(0, 0, 0, plylist:GetWide(), plylist:GetTall(), Color(61,61,61,255))
	end

	for k,v in pairs(player.GetAll()) do
		reput = v:GetNWInt('reputation', 0 )
		reputrp = v:GetNWInt('reputationrp',"new")
		local lignePlayer = plylist:AddLine(v:Nick(),reput,reputrp,v:SteamID(),v:SteamID64())
		lignePlayer.Paint = function()
			draw.RoundedBox( 0, 0, 0, plylist:GetWide(), 20, Color( 150, 150, 150, 255 ) )
		end
	end

	plylist.OnClickLine = function(parent, line, isselected)
		steamworks.RequestPlayerInfo( line:GetValue(5) )
		local menu = DermaMenu()
		menu.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h , Color(100,100,100,255))
		end

		local btnInfos = menu:AddOption("Infos sur le joueur", function()


			local infopan = vgui.Create ( "DFrame" )
			infopan:SetParent( base )
			infopan:SetSize( 400, 300 )
			infopan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 150)
			infopan:SetTitle( "Panneau d'info Joueur" )
			infopan:SetDraggable( true )
			infopan:SetBackgroundBlur( true )
			infopan:ShowCloseButton( false )
			infopan:MakePopup()
			infopan.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
				draw.RoundedBox( 0, 0, 0, w, 25, Color(0, 76, 153, 255) )
			end

			local CloseInfoPanel = vgui.Create( "DButton" )
		    CloseInfoPanel:SetParent( infopan )
		    CloseInfoPanel:SetPos(infopan:GetWide() - 30, 0 )
		    CloseInfoPanel:SetText( "" )
		    CloseInfoPanel:SetSize( 45, 25 )
		    CloseInfoPanel.DoClick = function()
		        infopan:Close()
		    end
		    CloseInfoPanel.Paint = function()
		        draw.RoundedBox( 0, 0, 0, CloseInfoPanel:GetWide(), CloseInfoPanel:GetTall(), Color(200,0,0,255) )
		        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		    end

			local infotab = vgui.Create( "DPropertySheet")
			infotab:SetParent( infopan )
			infotab:Dock( FILL )

			local infopnl1 = vgui.Create( "DPanel" )
			infopnl1:SetParent ( infotab )
			infopnl1.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 180, 180, 180 ) ) end
			infotab:AddSheet( "Infos", infopnl1, "icon16/group.png" )

			local infopnl3 = vgui.Create( "DPanel" )
			infopnl3:SetParent ( infotab )
			infopnl3.Paint = function( self, w, h ) draw.RoundedBox( 0, 0, 0, w, h, Color( 180, 180, 180 ) ) end
			infotab:AddSheet( "Identités", infopnl3, "icon16/group.png" )


			local infoava = vgui.Create ( "AvatarImage" )
			infoava:SetParent( infopnl1 )
			infoava:SetPos( 10, 10 )
			infoava:SetSize( 64, 64 )
			infoava:SetSteamID( line:GetValue(5), 64 )

			local infopseu = vgui.Create( "DLabel" )
			infopseu:SetParent( infopnl1 )
			infopseu:SetPos( 84, 0 )
			infopseu:SetSize(300, 50)
			infopseu:SetText( "Pseudo Steam :\n"..steamworks.GetPlayerName( line:GetValue(5) ) )
			infopseu:SetColor( Color( 255, 255, 255, 255 ) )
			infopseu:SetWrap( true )
			infopseu:SetFont( "CenterPrintText" )
			infopseu.DoClick = function()
				SetClipboardText( steamworks.GetPlayerName( line:GetValue(5) ) )
			end

			local infonom = vgui.Create( "DLabel" )
			infonom:SetParent( infopnl1 )
			infonom:SetPos( 84, 40 )
			infonom:SetSize(300, 50)
			infonom:SetText( "Nom RP :\n"..line:GetValue(1) )
			infonom:SetColor( Color( 255, 255, 255, 255 ) )
			infonom:SetFont( "CenterPrintText" )

			local infosid = vgui.Create( "DLabel" )
			infosid:SetParent( infopnl1 )
			infosid:SetPos( 20, 70 )
			infosid:SetSize(300, 50)
			infosid:SetText( "SteamID: "..line:GetValue(4) )
			infosid:SetColor( Color( 255, 255, 255, 255 ) )
			infosid:SetFont( "CenterPrintText" )
			infosid.DoClick = function()
				SetClipboardText( line:GetValue(4) )
			end

			local infosid64 = vgui.Create( "DLabel" )
			infosid64:SetParent( infopnl1 )
			infosid64:SetPos( 20, 90 )
			infosid64:SetSize(300, 50)
			infosid64:SetText( "SteamID64: "..line:GetValue(5) )
			infosid64:SetColor( Color( 255, 255, 255, 255 ) )
			infosid64:SetFont( "CenterPrintText" )
			infosid64.DoClick = function()
				SetClipboardText( line:GetValue(5) )
			end

			local inforep = vgui.Create( "DLabel" )
			inforep:SetParent( infopnl1 )
			inforep:SetPos( 20, 110 )
			inforep:SetSize(300, 50)
			inforep:SetText( "Réputation: "..line:GetValue(2) )
			inforep:SetFont( "CenterPrintText" )
			inforep:SetColor( Color( 255, 255, 255, 255 ) )

			local inforeprp = vgui.Create( "DLabel" )
			inforeprp:SetParent( infopnl1 )
			inforeprp:SetPos( 20, 130 )
			inforeprp:SetSize(300, 50)
			inforeprp:SetText( "Réputation RP: "..line:GetValue(3) )
			inforeprp:SetColor( Color( 255, 255, 255, 255 ) )
			inforeprp:SetFont( "CenterPrintText" )

			local infourl = vgui.Create( "DLabelURL")
			infourl:SetParent( infopnl1 )
			infourl:SetPos( 20, 150 )
			infourl:SetSize( 300, 50 )
			infourl:SetColor( Color( 0, 128, 255, 255 ) )
			infourl:SetText( "Profil sur le Site PureSystem !" )
			infourl:SetURL( "http://puresystem.fr/id/"..line:GetValue(5).."/" )
		end)
		btnInfos:SetIcon("icon16/user.png")
			/*local infoban = vgui.Create( "DLabel" )
			infoban:SetParent( infopnl1 )
			infoban:SetPos( 150, 170 )
			infoban:SetText( "Bans : 0 " ) -- Compabilisation des bans aprendre en compte
			infoban:SetColor( Color( 255, 255, 255, 255 ) )
			infoban:SetFont( "Trebuchet24" )
			infoban:SizeToContents()

			local infoav = vgui.Create( "DLabel" )
			infoav:SetParent( infopnl1 )
			infoav:SetPos( 150, 190 )
			infoav:SetText( "Avertissements : 0 " ) -- Compabilisation des avertissements aprendre en compte
			infoav:SetColor( Color( 255, 255, 255, 255 ) )
			infoav:SetFont( "Trebuchet24" )
			infoav:SizeToContents()*/

		-- local btnGoto = menu:AddOption("Goto", Goto(LocalPlayer(), getPlayerFromSteamId64(line:GetValue(5)) ))
		-- btnGoto:SetIcon("icon16/arrow_merge.png")

		-- local btnSpec = menu:AddOption( "Observer" )
		-- btnSpec:SetIcon("icon16/eye.png")

		local btnAvert = menu:AddOption("Avertissement", function()

			local msgRaisonAverto = "Rentrez ici les details de votre avertissement, cela doit être très explicite !"

			local averpan = vgui.Create ( "DFrame" )
			averpan:SetParent( base )
			averpan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 135)
			averpan:SetSize( 400, 270 )
			averpan:SetTitle( "Panneau d'Avertissement" )
			averpan:SetDraggable( true )
			averpan:SetBackgroundBlur( true )
			averpan:ShowCloseButton( false )
			averpan:MakePopup()
			averpan.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
				draw.RoundedBox(0, 0, 0, w, 25 , Color(0, 71, 152, 255))
			end

			local CloseAverPanel = vgui.Create( "DButton" )
		    CloseAverPanel:SetParent( averpan )
				CloseAverPanel:SetPos(averpan:GetWide() - 30, 0 )
				CloseAverPanel:SetText( "" )
				CloseAverPanel:SetSize( 45, 25 )
				CloseAverPanel.DoClick = function()
		        averpan:Close()
		    end
				CloseAverPanel.Paint = function()
		        draw.RoundedBox( 0, 0, 0, CloseAverPanel:GetWide(), CloseAverPanel:GetTall(), Color(200,0,0,255) )
		        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		    end

			local avertlbl = vgui.Create ( "DLabel" )
			avertlbl:SetParent( averpan )
			avertlbl:SetPos( 10, 30 )
			avertlbl:SetSize( averpan:GetWide() - 20, 20)
			avertlbl:SetFont( "Trebuchet18" )
			avertlbl:SetText( "Inscrivez les détails de l'avertissement : ")

			local avertxt = vgui.Create ( "DTextEntry" )
			avertxt:SetParent( averpan )
			avertxt:SetPos( 10, 60 )
			avertxt:SetSize( averpan:GetWide() - 20, 30)
			avertxt:SetText( msgRaisonAverto )
			avertxt.OnGetFocus = function()
				if (avertxt:GetValue() == msgRaisonAverto) then
					avertxt:SetText( "" )
				end
			end

			local avertSevlbl = vgui.Create ( "DLabel" )
			avertSevlbl:SetParent( averpan )
			avertSevlbl:SetPos( 10, 100 )
			avertSevlbl:SetSize( averpan:GetWide() - 20, 20)
			avertSevlbl:SetFont( "Trebuchet18" )
			avertSevlbl:SetText( "Sévérité de l'avertissement : ")

			/*local aversev = vgui.Create ("Slider")
			aversev:SetParent( averpan )
			aversev:SetPos( 10, 130 )
			aversev:SetWide( averpan:GetWide() - 20 )
			aversev:SetMin( 1 )
			aversev:SetMax( 3 )
			aversev:SetValue( 1 )
			aversev:SetDecimals( 0 )*/

			local asev = 0

			local aversev1 = vgui.Create("DButton")
			local aversev2 = vgui.Create("DButton")
			local aversev3 = vgui.Create("DButton")

			aversev1:SetParent(averpan)
			aversev1:SetPos(10, 130)
			aversev1:SetText("Mineur")
			aversev1:SetTextColor( Color(250, 250, 250, 255) )
			aversev1:SetSize((averpan:GetWide() - 20) / 3, 40)
			aversev1.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			aversev1.DoClick = function()
				aversev1.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				aversev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev1:SetDisabled(true)
				aversev2:SetDisabled(false)
				aversev3:SetDisabled(false)
				asev = 1
			end

			aversev2:SetParent(averpan)
			aversev2:SetPos(aversev1:GetWide() + 10, 130)
			aversev2:SetSize((averpan:GetWide() - 20) / 3, 40)
			aversev2:SetText( "Majeur" )
			aversev2:SetTextColor( Color(250, 250, 250, 255) )
			aversev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			aversev2.DoClick = function()
				aversev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				aversev1.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev1:SetDisabled(false)
				aversev2:SetDisabled(true)
				aversev3:SetDisabled(false)
				asev = 2
			end

			aversev3:SetParent(averpan)
			aversev3:SetPos(aversev2:GetWide() * 2 + 10, 130)
			aversev3:SetSize((averpan:GetWide() - 20) / 3, 40)
			aversev3:SetText( "Critique" )
			aversev3:SetTextColor( Color(250, 250, 250, 255) )
			aversev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			aversev3.DoClick = function()
				aversev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(250, 0, 0, 255))
				end
				aversev1.Paint = function(self, w, h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				aversev1:SetDisabled(false)
				aversev2:SetDisabled(false)
				aversev3:SetDisabled(true)
				asev = 3
			end

			local averRpLbl = vgui.Create("DLabel")
			averRpLbl:SetParent(averpan)
			averRpLbl:SetPos(10, 180)
			averRpLbl:SetFont( "Trebuchet18" )
			averRpLbl:SetText( "L'avertissement est il en rapport avec le RP du joueur ?" )
			averRpLbl:SizeToContents()

			local averRpCheck = vgui.Create( "DCheckBox" )
			averRpCheck:SetParent(averpan)
			averRpCheck:SetPos(335, 180)
			averRpCheck:SetValue(0)

			local averRpCheckLbl = vgui.Create("DLabel")
			averRpCheckLbl:SetParent(averpan)
			averRpCheckLbl:SetPos(355, 180)
			averRpCheckLbl:SetFont( "Trebuchet18" )
			averRpCheckLbl:SetText( "Oui" )
			averRpCheckLbl:SizeToContents()

			local averbtn = vgui.Create ( "DButton" )
			averbtn:SetParent( averpan )
			averbtn:SetPos( 10, 210 )
			averbtn:SetSize( averpan:GetWide() - 20, 40 )
			averbtn:SetText( "" )
			averbtn.DoClick = function()
				adetail = avertxt:GetValue()
				arp = averRpCheck:GetChecked()
				addAverto(getPlayerFromSteamId64(line:GetValue(5)),adetail,asev,arp)
				averpan:Close()
			end
			averbtn.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color(0,200,0,255) )
        draw.DrawText( "Valider l'Avertissement", "CloseCaption_Bold", w / 2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    	end
		end )
		btnAvert:SetIcon("icon16/photo.png")

		local btnKick = menu:AddOption("Kick", function()

			local msgRaisonKick = "Rentrez ici les details du kick, cela doit être très explicite !"
			freezetk(getPlayerFromSteamId64(line:GetValue(5)))

			local kickpan = vgui.Create( "DFrame" )
			kickpan:SetParent( base )
			kickpan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 135)
			kickpan:SetSize( 400, 270 )
			kickpan:SetTitle( "Panneau de Kick" )
			kickpan:SetBackgroundBlur( true )
			kickpan:SetDraggable( true )
			kickpan:ShowCloseButton( false )
			kickpan:MakePopup()
			kickpan.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
				draw.RoundedBox(0, 0, 0, w, 25 , Color(0, 71, 152, 255))
			end

			local CloseKickPanel = vgui.Create( "DButton" )
		    CloseKickPanel:SetParent( kickpan )
				CloseKickPanel:SetPos(kickpan:GetWide() - 30, 0 )
				CloseKickPanel:SetText( "" )
				CloseKickPanel:SetSize( 45, 25 )
				CloseKickPanel.DoClick = function()
		        kickpan:Close()
						unfreezetk(getPlayerFromSteamId64(line:GetValue(5)))
		    end
				CloseKickPanel.Paint = function(self, w, h)
		        draw.RoundedBox( 0, 0, 0, w, h, Color(200,0,0,255) )
		        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		    end

			local kicklbl = vgui.Create ( "DLabel" )
			kicklbl:SetParent( kickpan )
			kicklbl:SetPos( 10, 30 )
			kicklbl:SetSize( kickpan:GetWide() - 20, 20)
			kicklbl:SetFont( "Trebuchet18" )
			kicklbl:SetText( "Inscrivez les détails du kick : ")

			local kickres = vgui.Create( "DTextEntry" )
			kickres:SetParent( kickpan )
			kickres:SetPos( 10, 60 )
			kickres:SetSize( kickpan:GetWide() - 20, 30 )
			kickres:SetText(msgRaisonKick)
			kickres.OnGetFocus = function()
				if (kickres:GetValue() == msgRaisonKick) then
					kickres:SetText( "" )
				end
			end

			local kserlab = vgui.Create( "DLabel" )
			kserlab:SetParent( kickpan )
			kserlab:SetPos( 10, 100 )
			kserlab:SetFont( "Trebuchet18" )
			kserlab:SetText( "Sévérité du kick :" )
			kserlab:SizeToContents()

			/*local kickser = vgui.Create( "Slider" )
			kickser:SetParent( kickpan )
			kickser:SetPos ( 10, 130 )
			kickser:SetWide( kickpan:GetWide() - 20 )
			kickser:SetMin( 1 )
			kickser:SetMax( 3 )
			kickser:SetValue( 1 )
			kickser:SetDecimals( 0 )*/

			local ksev = 0

			local kicksev1 = vgui.Create("DButton")
			local kicksev2 = vgui.Create("DButton")
			local kicksev3 = vgui.Create("DButton")

			kicksev1:SetParent(kickpan)
			kicksev1:SetPos(10, 130)
			kicksev1:SetSize((kickpan:GetWide() - 20) / 3, 40)
			kicksev1:SetText( "Mineur" )
			kicksev1:SetTextColor( Color(250, 250, 250, 255) )
			kicksev1.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			kicksev1.DoClick = function()
				kicksev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				kicksev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev1:SetDisabled(true)
				kicksev2:SetDisabled(false)
				kicksev3:SetDisabled(false)
				ksev = 1
			end

			kicksev2:SetParent(kickpan)
			kicksev2:SetPos(kicksev1:GetWide() + 10, 130)
			kicksev2:SetSize((kickpan:GetWide() - 20) / 3, 40)
			kicksev2:SetText( "Majeur" )
			kicksev2:SetTextColor( Color(250, 250, 250, 255) )
			kicksev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			kicksev2.DoClick = function()
				kicksev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				kicksev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev1:SetDisabled(false)
				kicksev2:SetDisabled(true)
				kicksev3:SetDisabled(false)
				ksev = 2
			end

			kicksev3:SetParent(kickpan)
			kicksev3:SetPos(kicksev2:GetWide() * 2 + 10, 130)
			kicksev3:SetSize((kickpan:GetWide() - 20) / 3, 40)
			kicksev3:SetText( "Critique" )
			kicksev3:SetTextColor( Color(250, 250, 250, 255) )
			kicksev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			kicksev3.DoClick = function()
				kicksev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				kicksev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				kicksev1:SetDisabled(false)
				kicksev2:SetDisabled(false)
				kicksev3:SetDisabled(true)
				ksev = 3
			end

			local kickRpLbl = vgui.Create("DLabel")
			kickRpLbl:SetParent(kickpan)
			kickRpLbl:SetPos(10, 180)
			kickRpLbl:SetFont( "Trebuchet18" )
			kickRpLbl:SetText( "Le kick est il en rapport avec le RP du joueur ?" )
			kickRpLbl:SizeToContents()

			local kickRpCheck = vgui.Create( "DCheckBox" )
			kickRpCheck:SetParent(kickpan)
			kickRpCheck:SetPos(335, 180)
			kickRpCheck:SetValue(0)

			local kickRpCheckLbl = vgui.Create("DLabel")
			kickRpCheckLbl:SetParent(kickpan)
			kickRpCheckLbl:SetPos(355, 180)
			kickRpCheckLbl:SetFont( "Trebuchet18" )
			kickRpCheckLbl:SetText( "Oui" )
			kickRpCheckLbl:SizeToContents()

			local kickbut = vgui.Create( "DButton")
			kickbut:SetParent( kickpan )
			kickbut:SetPos( 10, 210 )
			kickbut:SetSize( kickpan:GetWide() - 20, 40 )
			kickbut:SetText( "" )
			kickbut.DoClick = function()
				kraison = kickres:GetValue()
				krp = kickRpCheck:GetChecked()
				unfreezetk(getPlayerFromSteamId64(line:GetValue(5)))
				addKickto(getPlayerFromSteamId64(line:GetValue(5)),kraison,ksev,krp)
				kickpan:Close()
			end
			kickbut.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color(0,200,0,255) )
        draw.DrawText( "Valider le Kick", "CloseCaption_Bold", w / 2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    	end
		end )
		btnKick:SetIcon("icon16/door.png")

		local btnBan = menu:AddOption("Ban", function()

			local msgRaisonBan = "Rentrez ici les details du ban, cela doit être très explicite !"
			freezetk(getPlayerFromSteamId64(line:GetValue(5)))
			local banpan = vgui.Create( "DFrame" )
			banpan:SetParent( base )
			banpan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 170)
			banpan:SetSize( 400, 340 )
			banpan:SetTitle( "Panneau de Ban " )
			banpan:SetBackgroundBlur( true )
			banpan:SetDraggable( true )
			banpan:ShowCloseButton( false )
			banpan:MakePopup()
			banpan.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
				draw.RoundedBox(0, 0, 0, w, 25 , Color(0, 71, 152, 255))
			end

			local CloseBanPanel = vgui.Create( "DButton" )
		    CloseBanPanel:SetParent( banpan )
				CloseBanPanel:SetPos(banpan:GetWide() - 30, 0 )
				CloseBanPanel:SetText( "" )
				CloseBanPanel:SetSize( 45, 25 )
				CloseBanPanel.DoClick = function()
		        banpan:Close()
						unfreezetk(getPlayerFromSteamId64(line:GetValue(5)))
		    end
				CloseBanPanel.Paint = function(self, w, h)
		        draw.RoundedBox( 0, 0, 0, w, h, Color(200,0,0,255) )
		        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		    end

			local banlbl = vgui.Create ( "DLabel" )
			banlbl:SetParent( banpan )
			banlbl:SetPos( 10, 30 )
			banlbl:SetSize( banpan:GetWide() - 20, 20)
			banlbl:SetFont( "Trebuchet18" )
			banlbl:SetText( "Inscrivez les détails du ban : ")

			local banres = vgui.Create( "DTextEntry" )
			banres:SetParent( banpan )
			banres:SetPos( 10, 60 )
			banres:SetSize( banpan:GetWide() - 20, 30 )
			banres:SetText(msgRaisonBan)
			banres.OnGetFocus = function()
				if (banres:GetValue() == msgRaisonBan) then
					banres:SetText( "" )
				end
			end

			local banlab1 = vgui.Create( "DLabel" )
			banlab1:SetParent( banpan )
			banlab1:SetPos( 10, 100 )
			banlab1:SetFont( "Trebuchet18" )
			banlab1:SetText( "Sévérité du ban :" )
			banlab1:SizeToContents()

			/*local banser = vgui.Create( "Slider" )
			banser:SetParent( banpan )
			banser:SetPos ( 10, 130 )
			banser:SetWide( banpan:GetWide() - 20 )
			banser:SetMin( 1 )
			banser:SetMax( 3 )
			banser:SetValue( 1 )
			banser:SetDecimals( 0 )*/

			local bsev = 0

			local bansev1 = vgui.Create("DButton")
			local bansev2 = vgui.Create("DButton")
			local bansev3 = vgui.Create("DButton")

			bansev1:SetParent(banpan)
			bansev1:SetPos(10, 130)
			bansev1:SetSize((banpan:GetWide() - 20) / 3, 40)
			bansev1:SetText( "Mineur" )
			bansev1:SetTextColor( Color( 250, 250, 250, 255))
			bansev1.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev1.DoClick = function()
				bansev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				bansev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev1:SetDisabled(true)
				bansev2:SetDisabled(false)
				bansev3:SetDisabled(false)
				bsev = 1
			end

			bansev2:SetParent(banpan)
			bansev2:SetPos(bansev1:GetWide() + 10, 130)
			bansev2:SetSize((banpan:GetWide() - 20) / 3, 40)
			bansev2:SetText( "Majeur" )
			bansev2:SetTextColor( Color( 250, 250, 250, 255))
			bansev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev2.DoClick = function()
				bansev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				bansev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev1:SetDisabled(false)
				bansev2:SetDisabled(true)
				bansev3:SetDisabled(false)
				bsev = 2
			end

			bansev3:SetParent(banpan)
			bansev3:SetPos(bansev2:GetWide() * 2 + 10, 130)
			bansev3:SetSize((banpan:GetWide() - 20) / 3, 40)
			bansev3:SetText( "Critique" )
			bansev3:SetTextColor( Color( 250, 250, 250, 255))
			bansev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev3.DoClick = function()
				bansev1.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev2.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
				end
				bansev3.Paint = function(self, w , h)
					draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
				end
				bansev1:SetDisabled(false)
				bansev2:SetDisabled(false)
				bansev3:SetDisabled(true)
				bsev = 3
			end

			local banlab2 = vgui.Create( "DLabel" )
			banlab2:SetParent( banpan )
			banlab2:SetPos( 10, 180 )
			banlab2:SetText( "Durée du ban :" )
			banlab2:SizeToContents()

			local bantim = vgui.Create( "DNumberWang" )
			bantim:SetParent( banpan )
			bantim:SetPos( 10, 210 )
			bantim:SetSize( 50, 25 )
			bantim:SetMin( 0 )
			bantim:SetFraction( 1 )
			bantim:SetDecimals( 0 )

			local bancon = vgui.Create( "DComboBox" )
			bancon:SetParent( banpan )
			bancon:SetPos( 100, 210 )
			bancon:SetSize( 150, 25 )
			bancon:SetValue( "Minute" )

			bancon:AddChoice( "Minute" )
			bancon:AddChoice( "Heure" )
			bancon:AddChoice( "Jour" )
			bancon:AddChoice( "Semaine" )
			bancon:AddChoice( "Mois" )
			bancon:AddChoice( "Année" )
			bancon:AddChoice( "Permanent" )

			local banRpLbl = vgui.Create("DLabel")
			banRpLbl:SetParent(banpan)
			banRpLbl:SetPos(10, 250)
			banRpLbl:SetFont( "Trebuchet18" )
			banRpLbl:SetText( "Le bannissement est il en rapport avec le RP du joueur ?" )
			banRpLbl:SizeToContents()

			local banRpCheck = vgui.Create( "DCheckBox" )
			banRpCheck:SetParent(banpan)
			banRpCheck:SetPos(335, 250)
			banRpCheck:SetValue(0)

			local banRpCheckLbl = vgui.Create( "DLabel" )
			banRpCheckLbl:SetParent(banpan)
			banRpCheckLbl:SetPos(355, 250)
			banRpCheckLbl:SetFont( "Trebuchet18" )
			banRpCheckLbl:SetText( "Oui" )
			banRpCheckLbl:SizeToContents()

			local banbut = vgui.Create( "DButton")
			banbut:SetParent( banpan )
			banbut:SetPos( 10, 280 )
			banbut:SetSize( banpan:GetWide() - 20, 40 )
			banbut:SetText( "" )
			banbut.Paint = function(self, w, h)
        draw.RoundedBox( 0, 0, 0, w, h, Color(0,200,0,255) )
        draw.DrawText( "Valider le Ban", "CloseCaption_Bold", w / 2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    	end
			banbut.DoClick = function()
				braison = banres:GetValue()
				textb = bancon:GetValue()
				tem = bantim:GetValue()
				brp = banRpCheck:GetChecked()
				if ( string.sub( textb, 1, 5 ) == "Heure" ) then
					btemp = tem * 60
				elseif ( string.sub( textb, 1, 4 ) == "Jour" ) then
					btemp = tem * 1440
				elseif ( string.sub( textb, 1, 7 ) == "Semaine" ) then
					btemp = tem * 10080
				elseif ( string.sub( textb, 1, 4 ) == "Mois" ) then
					btemp = tem * 40320
				elseif ( string.sub( textb, 1, 5 ) == "Année" ) then
					btemp = tem * 483840
				elseif ( string.sub( textb, 1, 9 ) == "Permanent" ) then
					btemp = 0
				else
					btemp = tem
				end
				unfreezetk(getPlayerFromSteamId64(line:GetValue(5)))
				addBanto(getPlayerFromSteamId64(line:GetValue(5)),braison,bsev,btemp,brp)
				banpan:Close()
			end
		end )
		btnBan:SetIcon("icon16/delete.png")

		local btnAFKick = menu:AddOption("AFKick", function()


			local AFKpan = vgui.Create( "DFrame" )
			AFKpan:SetParent( base )
			AFKpan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 170)
			AFKpan:SetSize( 400, 210 )
			AFKpan:SetTitle( "Panneau de AFKick" )
			AFKpan:SetBackgroundBlur( true )
			AFKpan:SetDraggable( true )
			AFKpan:ShowCloseButton( false )
			AFKpan:MakePopup()
			AFKpan.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
				draw.RoundedBox(0, 0, 0, w, 25 , Color(0, 71, 152, 255))
			end

			local CloseAFKPanel = vgui.Create( "DButton" )
		    CloseAFKPanel:SetParent( AFKpan )
				CloseAFKPanel:SetPos(AFKpan:GetWide() - 30, 0 )
				CloseAFKPanel:SetText( "" )
				CloseAFKPanel:SetSize( 45, 25 )
				CloseAFKPanel.DoClick = function()
		        AFKpan:Close()
		    end
				CloseAFKPanel.Paint = function(self, w, h)
		        draw.RoundedBox( 0, 0, 0, w, h, Color(200,0,0,255) )
		        draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		    end

			local AFKlbl2 = vgui.Create( "DLabel",AFKpan)
				AFKlbl2:SetPos( 10, 30 )
				AFKlbl2:SetText( "Ce kick ne sera PAS reference sur le Pure,\nil sert a kick les AFK et n'inflige aucune sanction !" )
				AFKlbl2:SetFont( "Trebuchet18" )
				AFKlbl2:SizeToContents()

			local AFKlbl1 = vgui.Create("DLabel",AFKpan)
				AFKlbl1:SetPos(10,75)
				AFKlbl1:SetFont("Trebuchet18")
				AFKlbl1:SetText("Inscrivez tout de meme la raison :")
				AFKlbl1:SizeToContents()

			local AFKres = vgui.Create( "DTextEntry" )
				AFKres:SetParent( AFKpan )
				AFKres:SetPos( 10, 95 )
				AFKres:SetSize( AFKpan:GetWide() - 20, 30 )
				AFKres:SetText("Raison ...")

			local AFKbut = vgui.Create( "DButton")
				AFKbut:SetParent( AFKpan )
				AFKbut:SetPos( 10, 160 )
				AFKbut:SetSize( AFKpan:GetWide() - 20, 40 )
				AFKbut:SetText( "" )
				AFKbut.Paint = function(self, w, h)
	        draw.RoundedBox( 0, 0, 0, w, h, Color(0,200,0,255) )
	        draw.DrawText( "Valider le Kick", "CloseCaption_Bold", w / 2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER )
	    	end
				AFKbut.DoClick = function()
					AFKr = AFKres:GetValue()
					addAFKick(getPlayerFromSteamId64(line:GetValue(5)),AFKr)
					AFKpan:Close()
				end
		end)
		btnAFKick:SetIcon("icon16/control_eject.png")

		local btnferm = menu:AddOption("Fermer", function()  end)
		btnferm:SetIcon("icon16/door_out.png")

		menu:Open()
	end

	local check = vgui.Create( "DTextEntry" )
	check:SetParent( base )
	check:SetPos( 10, 460 )
	check:SetSize( 200, 25 )
	check:SetText( "Recherche..." )
	check.OnEnter = function()
		nom = check:GetValue()
		for k,line in pairs( plylist:GetLines() ) do
			if line:GetValue( 1 ) == nom then
				plylist:SelectItem( line )
			end
		end
	end
	check.OnChange = function()
		local valueSearch = check:GetValue()
		for k,line in pairs( plylist:GetLines() ) do
			if (string.find(string.lower(line:GetValue(1)), string.lower(valueSearch)) == nil) then
				line:SetVisible(false)
			else
				line:SetVisible(true)
			end
		end
	end
	check.OnGetFocus = function()
		check:SetText( "" )
	end


local banSteamid = vgui.Create( "DButton" )
	banSteamid:SetParent( base )
	banSteamid:SetPos( 580, 460 )
	banSteamid:SetSize( 200, 25 )
	banSteamid:SetText( "" )
    banSteamid.Paint = function()
        draw.RoundedBox( 0, 0, 0, banSteamid:GetWide(), banSteamid:GetTall(), Color( 200, 0, 0, 255 ) )
        draw.DrawText( "Bannir par SteamID", "TargetID", banSteamid:GetWide()/2, 3, Color(255,255,255,255), TEXT_ALIGN_CENTER )
    end
    banSteamid.DoClick = function()
        /*local BanIDPanel = vgui.Create( "DFrame" )
        BanIDPanel:SetParent( base )
        BanIDPanel:SetPos( 100, 100 )
        BanIDPanel:SetSize( 300, 200 )
        BanIDPanel:Center(  )
        BanIDPanel:SetTitle( "Ban par SteamID64" )
        BanIDPanel:SetDraggable( true )
        BanIDPanel:MakePopup()
		BanIDPanel:ShowCloseButton( false )
		BanIDPanel.Paint = function()
			draw.RoundedBox( 0, 0, 0, BanIDPanel:GetWide(), BanIDPanel:GetTall(), Color( 0, 0, 0, 255 ) )
			draw.RoundedBox( 0, 1, 1, BanIDPanel:GetWide() - 2, BanIDPanel:GetTall() - 2 , Color( 61, 61, 61, 255 ) )
			draw.RoundedBox( 0, 1, 1, BanIDPanel:GetWide() - 2, 24, Color(0, 71, 152, 255) )
		end

		local CloseBanIDPanel = vgui.Create( "DButton" )
		CloseBanIDPanel:SetParent( BanIDPanel )
			CloseBanIDPanel:SetPos(BanIDPanel:GetWide() - 30, 0 )
			CloseBanIDPanel:SetText( "" )
			CloseBanIDPanel:SetSize( 45, 25 )
			CloseBanIDPanel.DoClick = function()
			BanIDPanel:Close()
		end
			CloseBanIDPanel.Paint = function()
			draw.RoundedBox( 0, 0, 1, CloseBanIDPanel:GetWide()-2, CloseBanIDPanel:GetTall()-1, Color(200,0,0,255) )
			draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		end

        local BanIDLbl = vgui.Create( "DLabel" )
        BanIDLbl:SetParent(BanIDPanel)
        BanIDLbl:SetPos( 10, 35 )
		BanIDLbl:SetSize( BanIDPanel:GetWide() - 20, 20)
        BanIDLbl:SetText( "" )
		BanIDLbl.Paint = function()
			draw.DrawText( "Entrez le SteamID du joueur", "CenterPrintText", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT )
		end

		local BanIDBox = vgui.Create( "DTextEntry" )
		BanIDBox:SetParent(BanIDPanel)
		BanIDBox:SetPos( 10, 60 )
		BanIDBox:SetSize( BanIDPanel:GetWide() - 20, 25 )

		local BanIDButton = vgui.Create( "DButton" )
		BanIDButton:SetParent( BanIDPanel )
		BanIDButton:SetPos( 10, 90 )
		BanIDButton:SetSize( BanIDPanel:GetWide() - 20, 25 )
		BanIDButton:SetText( "Bannir par SteamID" )
		BanIDButton.DoClick = function()
			print("Steamid a bannir: " .. BanIDBox:GetText())
			addBantoSteamID(BanIDBox:GetText(), "Test !", 1, 120, "true")
		end*/




		local msgRaisonBan = "Rentrez ici les details du ban, cela doit être très explicite !"

		local banpan = vgui.Create( "DFrame" )
		banpan:SetParent( base )
		banpan:SetPos(ScrW() / 2 - 200, ScrH() / 2 - 170)
		banpan:SetSize( 400, 340 )
		banpan:SetTitle( "Ban par SteamID " )
		banpan:SetBackgroundBlur( true )
		banpan:SetDraggable( true )
		banpan:ShowCloseButton( false )
		banpan:MakePopup()
		banpan.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h , Color(61,61,61,255))
			draw.RoundedBox(0, 0, 0, w, 25 , Color(0, 71, 152, 255))
		end

		local CloseBanPanel = vgui.Create( "DButton" )
		CloseBanPanel:SetParent( banpan )
			CloseBanPanel:SetPos(banpan:GetWide() - 30, 0 )
			CloseBanPanel:SetText( "" )
			CloseBanPanel:SetSize( 45, 25 )
			CloseBanPanel.DoClick = function()
			banpan:Close()
		end
			CloseBanPanel.Paint = function(self, w, h)
			draw.RoundedBox( 0, 0, 0, w, h, Color(200,0,0,255) )
			draw.DrawText( "X", "HudHintTextLarge", 10, 5, Color(128,128,128,255), TEXT_ALIGN_LEFT )
		end

		local BanIDBox = vgui.Create( "DTextEntry" )
		BanIDBox:SetParent( banpan )
		BanIDBox:SetPos( 10, 25 )
		BanIDBox:SetSize( banpan:GetWide() - 20, 30 )
		BanIDBox:SetText("SteamID a rentrer ici")
		BanIDBox.OnGetFocus = function()
			if (BanIDBox:GetValue() == "SteamID a rentrer ici") then
				BanIDBox:SetText( "" )
			end
		end

		-- local banlbl = vgui.Create ( "DLabel" )
		-- banlbl:SetParent( banpan )
		-- banlbl:SetPos( 10, 40 )
		-- banlbl:SetSize( banpan:GetWide() - 20, 20)
		-- banlbl:SetFont( "Trebuchet18" )
		-- banlbl:SetText( "Inscrivez les détails du ban : ")

		local banres = vgui.Create( "DTextEntry" )
		banres:SetParent( banpan )
		banres:SetPos( 10, 60 )
		banres:SetSize( banpan:GetWide() - 20, 30 )
		banres:SetText(msgRaisonBan)
		banres.OnGetFocus = function()
			if (banres:GetValue() == msgRaisonBan) then
				banres:SetText( "" )
			end
		end

		local banlab1 = vgui.Create( "DLabel" )
		banlab1:SetParent( banpan )
		banlab1:SetPos( 10, 100 )
		banlab1:SetFont( "Trebuchet18" )
		banlab1:SetText( "Sévérité du ban :" )
		banlab1:SizeToContents()

		/*local banser = vgui.Create( "Slider" )
		banser:SetParent( banpan )
		banser:SetPos ( 10, 130 )
		banser:SetWide( banpan:GetWide() - 20 )
		banser:SetMin( 1 )
		banser:SetMax( 3 )
		banser:SetValue( 1 )
		banser:SetDecimals( 0 )*/

		local bsev = 0

		local bansev1 = vgui.Create("DButton")
		local bansev2 = vgui.Create("DButton")
		local bansev3 = vgui.Create("DButton")

		bansev1:SetParent(banpan)
		bansev1:SetPos(10, 130)
		bansev1:SetSize((banpan:GetWide() - 20) / 3, 40)
		bansev1:SetText( "Mineur" )
		bansev1:SetTextColor( Color( 250, 250, 250, 255))
		bansev1.Paint = function(self, w , h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
		end
		bansev1.DoClick = function()
			bansev1.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
			end
			bansev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev1:SetDisabled(true)
			bansev2:SetDisabled(false)
			bansev3:SetDisabled(false)
			bsev = 1
		end

		bansev2:SetParent(banpan)
		bansev2:SetPos(bansev1:GetWide() + 10, 130)
		bansev2:SetSize((banpan:GetWide() - 20) / 3, 40)
		bansev2:SetText( "Majeur" )
		bansev2:SetTextColor( Color( 250, 250, 250, 255))
		bansev2.Paint = function(self, w , h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
		end
		bansev2.DoClick = function()
			bansev1.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
			end
			bansev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev1:SetDisabled(false)
			bansev2:SetDisabled(true)
			bansev3:SetDisabled(false)
			bsev = 2
		end

		bansev3:SetParent(banpan)
		bansev3:SetPos(bansev2:GetWide() * 2 + 10, 130)
		bansev3:SetSize((banpan:GetWide() - 20) / 3, 40)
		bansev3:SetText( "Critique" )
		bansev3:SetTextColor( Color( 250, 250, 250, 255))
		bansev3.Paint = function(self, w , h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
		end
		bansev3.DoClick = function()
			bansev1.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev2.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 71, 152, 255))
			end
			bansev3.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(200, 0, 0, 255))
			end
			bansev1:SetDisabled(false)
			bansev2:SetDisabled(false)
			bansev3:SetDisabled(true)
			bsev = 3
		end

		local banlab2 = vgui.Create( "DLabel" )
		banlab2:SetParent( banpan )
		banlab2:SetPos( 10, 180 )
		banlab2:SetText( "Durée du ban :" )
		banlab2:SizeToContents()

		local bantim = vgui.Create( "DNumberWang" )
		bantim:SetParent( banpan )
		bantim:SetPos( 10, 210 )
		bantim:SetSize( 50, 25 )
		bantim:SetMin( 0 )
		bantim:SetFraction( 1 )
		bantim:SetDecimals( 0 )

		local bancon = vgui.Create( "DComboBox" )
		bancon:SetParent( banpan )
		bancon:SetPos( 100, 210 )
		bancon:SetSize( 150, 25 )
		bancon:SetValue( "Minute" )

		bancon:AddChoice( "Minute" )
		bancon:AddChoice( "Heure" )
		bancon:AddChoice( "Jour" )
		bancon:AddChoice( "Semaine" )
		bancon:AddChoice( "Mois" )
		bancon:AddChoice( "Année" )
		bancon:AddChoice( "Permanent" )

		local banRpLbl = vgui.Create("DLabel")
		banRpLbl:SetParent(banpan)
		banRpLbl:SetPos(10, 250)
		banRpLbl:SetFont( "Trebuchet18" )
		banRpLbl:SetText( "Le bannissement est il en rapport avec le RP du joueur ?" )
		banRpLbl:SizeToContents()

		local banRpCheck = vgui.Create( "DCheckBox" )
		banRpCheck:SetParent(banpan)
		banRpCheck:SetPos(335, 250)
		banRpCheck:SetValue(0)

		local banRpCheckLbl = vgui.Create("DLabel")
		banRpCheckLbl:SetParent(banpan)
		banRpCheckLbl:SetPos(355, 250)
		banRpCheckLbl:SetFont( "Trebuchet18" )
		banRpCheckLbl:SetText( "Oui" )
		banRpCheckLbl:SizeToContents()

		local banbut = vgui.Create( "DButton")
		banbut:SetParent( banpan )
		banbut:SetPos( 10, 280 )
		banbut:SetSize( banpan:GetWide() - 20, 40 )
		banbut:SetText( "" )
		banbut.Paint = function(self, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color(0,200,0,255) )
		draw.DrawText( "Valider le Ban", "CloseCaption_Bold", w / 2, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER )
		end
		banbut.DoClick = function()
			braison = banres:GetValue()
			textb = bancon:GetValue()
			tem = bantim:GetValue()
			brp = banRpCheck:GetChecked()
			if ( string.sub( textb, 1, 5 ) == "Heure" ) then
				btemp = tem * 60
			elseif ( string.sub( textb, 1, 4 ) == "Jour" ) then
				btemp = tem * 1440
			elseif ( string.sub( textb, 1, 7 ) == "Semaine" ) then
				btemp = tem * 10080
			elseif ( string.sub( textb, 1, 4 ) == "Mois" ) then
				btemp = tem * 40320
			elseif ( string.sub( textb, 1, 5 ) == "Année" ) then
				btemp = tem * 483840
			elseif ( string.sub( textb, 1, 9 ) == "Permanent" ) then
				btemp = 0
			else
				btemp = tem
			end
			addBantoSteamID(BanIDBox:GetText(),braison,bsev,btemp,brp)
			//addBantoSteamID(BanIDBox:GetText(), "Test !", 1, 120, "true")
			banpan:Close()
		end
    end

end


net.Receive("OpenGuiPure", function(length)
	chat.AddText( Color( 100, 100, 255 ), "Ouverture du menu Pure System...")

	PurePanel();
end);
