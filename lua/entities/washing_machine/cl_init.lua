include("shared.lua")
include("autorun/vikrlaundry_config.lua")

function ENT:Draw()
  self:DrawModel()

  local pos = self:LocalToWorld(self:OBBCenter())
  local ang = self:GetAngles()
  ang:RotateAroundAxis(ang:Up(), 90)
  ang:RotateAroundAxis(ang:Forward(), 90)
	local color = Color(255, 0, 0)
  local x, y, w, h = 0, 0, 30, 30

	if self:GetWashing() then
		color = Color(0, 255, 0)
	end

  cam.Start3D2D(pos + (ang:Up() * 20.75) + (ang:Forward() * 27.5) + (ang:Right() * 12.5), ang, 0.2)
    draw.RoundedBox(0, x - w / 2, y - h / 2, w + 2, h + 2, Color(10, 10, 10, 100))
    draw.RoundedBox(0, x - w / 2 + 1, y - h / 2 + 1, w, h, color)
  cam.End3D2D()
end

function ENT:Think()
  if not self.ClothModel then return end

  self.ClothModel:SetPos(self:LocalToWorld(self:OBBCenter()))

  if not self:GetWashing() then
    self.ClothModel:Remove()
  end
end
