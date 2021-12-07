ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName = "Cloth"
ENT.Author = "vikR"
ENT.Category = "Laundry Job"
ENT.Contact = "none"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Clean")
	self:NetworkVar("Int", 1, "ClothType") -- 1 = prisonnier, 2 = garde

	if SERVER then
		self:NetworkVarNotify("Clean", self.OnClothChangeState)
	end
end