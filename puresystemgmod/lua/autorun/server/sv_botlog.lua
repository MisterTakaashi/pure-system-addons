
print("Start of the Pure Bot !")
PureLog = "puresystem/log/"..os.date("%Y_%m_%d")..".txt"

if !file.IsDir("puresystem","DATA") then
	file.CreateDir("puresystem")
	file.CreateDir("puresystem/log")
	file.Write(PureLog, os.date().."Premier demarrage du Pure Bot sur ce serveur ! GG !")
	print("***Log file created***" )


else
	if file.Exists(PureLog, "DATA" ) == false then
		file.Write(PureLog,os.date().."\tPremier demarrage du Pure Bot aujourd'hui.")
		print("***Log system launched***" )
	else
		file.Append(PureLog,"\n"..os.date().."\tDemarrage du Pure Bot.")
		print("***Log system launched***" )
	end

end
