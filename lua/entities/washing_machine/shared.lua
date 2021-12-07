ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName = "Washing Machine"
ENT.Author = "vikR"
ENT.Category = "Laundry Job"
ENT.Contact = "none"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "WashState")
	self:NetworkVar("Float", 1, "ClothType")
	self:NetworkVar("Bool", 2, "Washing")

	if SERVER then
		self:NetworkVarNotify("Washing", self.OnWash)
	end
end