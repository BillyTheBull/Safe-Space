-- PrivacyBox

PrivacyBox=PrivacyBox or {}
function PrivacyBox:LoadFolder(folder,addonly,noprefix)
	if folder then
		folder="privacybox/"..folder.."/"
	else
		folder="privacybox/"
	end
	local modules = file.Find(folder.."*.lua","LUA")
	for _, plugin in ipairs(modules) do
		if noprefix then
			if SERVER then
				AddCSLuaFile(folder..plugin)
			end
			if not addonly then
				include(folder..plugin)
			end
		else
			local prefix = string.Left( plugin, string.find( plugin, "_" ) - 1 )
			if (CLIENT and (prefix=="sh" or prefix=="cl")) then
				if not addonly then
					include(folder..plugin)
				end
			elseif (SERVER) then
				if (prefix=="sv" or prefix=="sh") and (not addonly) then
					include(folder..plugin)
				end
				if (prefix=="sh" or prefix=="cl") then
					AddCSLuaFile(folder..plugin)
				end
			end
		end
	end
end
PrivacyBox:LoadFolder("libraries/libraries")
PrivacyBox:LoadFolder("libraries")
PrivacyBox:LoadFolder()