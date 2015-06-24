net.Receive("OpenCGuiPureP",function(len)
  ply = LocalPlayer()
  gui.OpenURL("http://puresystem.fr/id/"..ply:SteamID64().."/")
end)
