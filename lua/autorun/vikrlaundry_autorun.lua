if SERVER then
	AddCSLuaFile("vikrlaundry_config.lua")

	include("vikrlaundry_config.lua")
elseif CLIENT then
	include("vikrlaundry_config.lua")
end
