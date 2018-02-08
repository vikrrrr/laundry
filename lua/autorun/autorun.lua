if SERVER then
	AddCSLuaFile("config.lua")

	include("config.lua")
elseif CLIENT then
	include("config.lua")
end
