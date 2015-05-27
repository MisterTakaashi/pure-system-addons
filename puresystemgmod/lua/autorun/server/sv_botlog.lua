
print("Start of the Pure Bot !")
PureLog = "puresystem/log/"..os.date("%d_%m_%Y")..".txt"

if !file.IsDir("puresystem","DATA") then
	file.CreateDir("puresystem")
	file.CreateDir("puresystem/log")
	file.CreateDir("puresystem/plycache")
	file.Write(PureLog, os.date().."First start of Pure bot !")
	print("***Log file created***" )

	
else
	if !PureLog then
		file.Write(PureLog,os.date().."\tFirst Pure Bot Start today.")
		print("***Log system launched***" )
	else
		file.Append(PureLog,"\n"..os.date().."\tPure Bot Started.")
		print("***Log system launched***" )
	end

end