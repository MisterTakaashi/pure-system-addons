include("autorun/pure_config.lua")

for i,line in ipairs(PURE.servlogo) do
      resource.AddSingleFile(line)
    end
resource.AddSingleFile("resource/logo_puresystem.png")
resource.AddSingleFile("resource/logo_marteaupure.png")
