AddCSLuaFile()
include("autorun/pure_config.lua")

local Color = Color;
local hook = hook;
local pgris = Color(18,21,25,254);
local psgris = Color(18,21,25,0);
local pvgris = Color(60,60,60,255);
local pbleu = Color(39,128,227,255);
local pdorl = Color(241,193,0,125);
local pdor = Color(241,193,0,255);
local ptgris = Color(18,21,25,255);
local pblack = Color(0,0,0,255);
local pwhite = Color(250,250,250,255);
local ReturnedHTMl = "";
local version = "Beta-6.2";
local ply = LocalPlayer();

local function OutlinedBox( x, y, w, h, thickness, clr )
		surface.SetDrawColor( clr )
		for i=0, thickness - 1 do
			surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
		end
end

function sload()
	lframe = vgui.Create("DFrame")
	lframe:SetPos(0,0)
	lframe:SetSize(ScrW(),ScrH())
	lframe:ShowCloseButton( false )
	lframe:SetTitle("")
	lframe:SetVisible( true )
	lframe:MakePopup()
	lframe.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
	end

	logoma = vgui.Create("DImage",lframe)
	logoma:SetPos(ScrW()/2 - 250,ScrH()/2 - 250)
	logoma:SetSize(500,500)
	logoma:SetImage("materials/puresystem/logo_marteaupure.png")


	timer.Create( "charglogo", 1, 1, function()

		logoma:AlphaTo(10,1,0)
		logoma:AlphaTo(255,1,1)
		timer.Adjust( "charglogo", 3, 0, function()
			logoma:AlphaTo(10,1,1)
			logoma:AlphaTo(255,1,2)
		end)
	end)
end

local function sov(http)
	if webpl != nil and webpl:IsVisible() then
		webpl:Remove()
	end
	gui.OpenURL(http)
end

local function webpan(http)
	if webpl != nil and webpl:IsVisible() then
		webpl:Remove()
	end
	webpl = vgui.Create("DFrame",base)
	webpl:SetPos(250,150)
	webpl:SetSize(ScrW()-250,ScrH()-150)
	webpl:SetDraggable(false)
	webpl:SetTitle("")
	webpl:ShowCloseButton(false)
	webpl:SetVisible(true)
	webpl:SetDeleteOnClose( true )
	webpl:MakePopup()
	webpl.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,pdor)
	end

	local html = vgui.Create( "HTML", webpl )
	html:Dock( FILL )
	html:OpenURL( http )
end

net.Receive("OpenPureLoading",function(len)
	local base = vgui.Create("DFrame")
	base:SetPos(0,0)
	base:SetSize(ScrW(),ScrH())
	base:SetVisible( true )
	base:ShowCloseButton( false )
	base:MakePopup()
	base.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,pgris)
	end

	local logserv = vgui.Create("DPanel",base)
	logserv:SetSize(ScrW(),150)
	logserv:SetPos(0,-150)
	logserv.Paint = function(self, w, h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
	end
	logserv:MoveTo( 0, 0, 3, 0, -1)

	local purelogo = vgui.Create( "DImage", logserv )	-- Add image to Frame
		purelogo:SetPos( (ScrW()/2 - 175), 30 )	-- Move it into frame
		purelogo:SetSize( 350, 75 )	-- Size it to 150x150
		purelogo:SetImage( "materials/puresystem/logo_puresystem.png" )

	local panint = vgui.Create("DPanel",base)
	panint:SetPos(- 250,150)
	panint:SetSize(250,ScrH() - 150)
	panint.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
	end
	panint:MoveTo(0,150,3,0,-1)

	local ovcheck = vgui.Create( "DCheckBox",panint )// Create the checkbox
		ovcheck:SetPos( 20, 470 )// Set the position
		ovcheck:SetValue( 0 )// Initial value ( will determine whether the box is ticked too )

	local chlbl = vgui.Create("DLabel",panint)
		chlbl:SetPos(45,470)
		chlbl:SetSize(150,20)
		chlbl:SetText("Afficher les pages dans Steam")

		local thpanel = vgui.Create("DCheckBox",panint)
		thpanel:SetPos(20,500)
		thpanel:SetValue(0)
		thpanel.OnChange = function()
		  if thpanel:GetChecked() then
				sound.PlayFile( "sound/puresystem/puresystemtheme.wav","", function( station )
					if ( IsValid( station ) ) then station:Play() end
					end )
		  else
		    RunConsoleCommand( "stopsound" )
		  end
		end

	local thlbl = vgui.Create("DLabel",panint)
	thlbl:SetPos(45,500)
	thlbl:SetSize(150,20)
	thlbl:SetText("Activer le PureMusiqueTheme")

	local cobutt = vgui.Create("DButton",panint)
	cobutt:SetPos(50,200)
	cobutt:SetSize(150,40)
	cobutt:SetText("")
	cobutt.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
		draw.DrawText("Entrer Serveur","Trebuchet24",w/2,h/2,pwhite,TEXT_ALIGN_CENTER)
	end
	cobutt.DoClick = function()
		if webpl != nil then
			webpl:Remove()
		end
		net.Start("PConnect")
		net.SendToServer()
		sload()
		base:Close()
	end

	local cgulab = vgui.Create("DButton",panint)
	cgulab:SetPos(50,260)
	cgulab:SetSize(150,40)
	cgulab:SetText("")
	cgulab.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
		draw.DrawText("Page CGU","Trebuchet24",w/2,h/2-5,pwhite,TEXT_ALIGN_CENTER)
		draw.RoundedBox(0,0,0,w,1,pdor)
	end
	cgulab.DoClick = function()
		local http = "http://puresystem.fr/cgu.html"
		if ovcheck:GetChecked() then
			sov(http)
		else
			webpan(http)
		end
	end

	local sitlab = vgui.Create("DButton",panint)
	sitlab:SetPos(50,310)
	sitlab:SetSize(150,40)
	sitlab:SetText("")
	sitlab.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
		draw.RoundedBox(0,0,0,w,1,pdorl)
		draw.DrawText("Page Du Site","Trebuchet24",w/2,h/2-5,pwhite,TEXT_ALIGN_CENTER)
	end
	sitlab.DoClick = function()
		local http = "http://puresystem.fr"
		if ovcheck:GetChecked() then
			sov(http)
		else
			webpan(http)
		end
	end


		local prolab = vgui.Create("DButton",panint)
		prolab:SetPos(50,360)
		prolab:SetSize(150,40)
		prolab:SetText("")
		prolab.Paint = function(self,w,h)
			draw.RoundedBox(0,0,0,w,h,ptgris)
			draw.DrawText("Votre Profil","Trebuchet24",w/2,h/2-5,pwhite,TEXT_ALIGN_CENTER)
			draw.RoundedBox(0,0,0,w,1,pdorl)
		end
		prolab.DoClick = function()
			local http = "http://puresystem.fr/id/"..ply:GetNWInt("St64").."/"
			if ovcheck:GetChecked() then
				sov(http)
			else
				webpan(http)
			end
		end

	local decobut = vgui.Create("DButton",panint)
	decobut:SetPos(50,410)
	decobut:SetSize(150,40)
	decobut:SetText("")
	decobut.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,ptgris)
		draw.DrawText("Deconnexion","Trebuchet24",w/2,h/2-5,pwhite,TEXT_ALIGN_CENTER)
		draw.RoundedBox(0,0,0,w,1,pdorl)
	end
	decobut.DoClick = function()
		net.Start("Discon")
		net.SendToServer()
	end

	local servipan = vgui.Create("DPanel",base)
	servipan:SetPos(250,500)
	servipan:SetSize(ScrW()-250,250)
	servipan.Paint = function(self,w,h)
		draw.RoundedBox(0,0,0,w,h,psgris)
		draw.DrawText("Bienvenue sur le Serveur : "..PURE.servname,"DermaLarge",(w/2 - 125),h/2,pbleu,TEXT_ALIGN_CENTER)
	end

	if PURE.servlogo != nil then
		local logoser = vgui.Create("DImage",base)
		logoser:SetPos(ScrW()/2 - 230,250)
		logoser:SetSize(460,215)
		logoser:SetImage(PURE.servlogo[math.random( 1, #PURE.servlogo )])
		logoser:AlphaTo(50,1,0)
		logoser:AlphaTo(255,3,1)
	end


	http.Fetch( "https://api.github.com/repos/MisterTakaashi/pure-system-addons/releases/latest",
		function( body, len, headers, code )
	  	local TheReturnedHTML = body
	  	local retourquipese = util.JSONToTable(TheReturnedHTML)
			PrintTable( retourquipese )
	  		if version and retourquipese["tag_name"] != version then
					verlbl = vgui.Create( "DButton", base )
					verlbl:SetPos( (ScrW()/2 - 250), 515 )
					verlbl:SetSize( 500, 50 )
					verlbl:SetText("")
					verlbl.Paint = function(self,w,h)
						draw.RoundedBox(0,0,0,w,h,pvgris)
						draw.DrawText("Mise a jour du PureSystem disponible","Trebuchet24",w/2,h/2 - 12,pwhite,TEXT_ALIGN_CENTER)
					end
					verlbl.DoClick = function()
						local http = "https://github.com/MisterTakaashi/pure-system-addons/releases/latest"
						if ovcheck:GetChecked() then
							sov(http)
						else
							webpan(http)
						end
					end
				end
			end,
			function(error)
			end);
end)

net.Receive("EndLoeading",function(len)
	timer.Remove( "charglogo" )
	lframe:Close()
	RunConsoleCommand( "stopsound" )
	print("temps connecte : "..os.difftime(ply:GetNWInt("timenserv"), os.time()))
	local recTab = net.ReadTable()
	if recTab.State == "Error1" then
		chat.AddText(Color(255,0,0,255),"[PS] "..recTab.Error)
	elseif recTab.State == "Error2" then
			chat.AddText(Color(255,0,0,255),"[PS] Une erreur s'est produite lors du chargement de vos données, le serveur est-il bien reference ?")
	else
		chat.AddText(Color(0,255,0,255),"[PS] Vos données ont été chargées avec succès !")
		chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation est de : "..recTab.Rep)
		if errortype == "new" then
			chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation RP est de : new")
		else
			chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation RP est de : "..recTab.RepRp)
		end
		chat.AddText(Color(0,255,0,255),"[PS] Pour acceder a votre profil tapez !ppure. Bon jeu à vous")
	end
end)
