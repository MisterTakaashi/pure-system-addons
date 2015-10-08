AddCSLuaFile()
include("autorun/pure_config.lua")

local Color = Color;
local hook = hook;
local pgris = Color(18,21,25,254);
local psgris = Color(18,21,25,0);
local pbleu = Color(39,128,227,255);
local pdorl = Color(241,193,0,125);
local pdor = Color(241,193,0,255);
local ptgris = Color(18,21,25,255);
local pblack = Color(0,0,0,255);
local pwhite = Color(250,250,250,255)
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
	logoma:SetImage("resource/logo_marteaupure.png")

	logoma:AlphaTo( 125, 0, 0)
	logoma:AlphaTo( 10, 1, 1)
	logoma:AlphaTo( 255, 1, 2)
	logoma:AlphaTo( 10, 1, 3)
	logoma:AlphaTo( 255, 1, 4)
	logoma:AlphaTo( 10, 1, 5)
	logoma:AlphaTo( 255, 1, 6)
	logoma:AlphaTo( 10, 1, 7)
	logoma:AlphaTo( 255, 1, 8)

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
		purelogo:SetImage( "resource/logo_puresystem.png" )

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
		local logoser = vgui.Create("DImage")
		logoser:SetParent(base)
		logoser:SetPos(ScrW()/2 - 230,250)
		logoser:SetSize(460,215)
		logoser:SetImage(PURE.servlogo[math.random( 1, #PURE.servlogo )])
		logoser:AlphaTo(50,1,0)
		logoser:AlphaTo(255,3,1)
	end
end)

net.Receive("EndLoeading",function(len)
	lframe:Close()
	if net.ReadBool() then
		if net.ReadBool() then
			chat.AddText(Color(255,0,0,255),"[PS] Une erreur s'est produite lors du chargement de vos données, le serveur est-il bien reference ?")
		else
			chat.AddText(Color(255,0,0,255),"[PS] "..net.ReadString())
		end
	else
	chat.AddText(Color(0,255,0,255),"[PS] Vos données ont été chargées avec succès !")
	chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation est de : "..net.ReadInt(8))
	if net.ReadString() == "new" then
		chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation RP est de : new")
	else
		chat.AddText(Color(0,255,0,255),"[PS] Votre Reputation RP est de : "..net.ReadInt(8))
	end
	chat.AddText(Color(0,255,0,255),"[PS] Pour acceder a votre profil tapez !ppure. Bon jeu à vous")
	end
end)
