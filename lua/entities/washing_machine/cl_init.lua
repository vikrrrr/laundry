include("shared.lua")

local colBlack = Color(10, 10, 10, 100)
local colRed = Color(255, 0, 0)
local colGreen = Color(0, 255, 0)

function ENT:Draw()
    self:DrawModel()

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Up(), 90)
    ang:RotateAroundAxis(ang:Forward(), 90)
    
    local x, y, w, h = 0, 0, 30, 30

    cam.Start3D2D(self:LocalToWorld(self:OBBCenter()) + (ang:Up() * 20.75) + (ang:Forward() * 27.5) + (ang:Right() * 12.5), ang, 0.2)
        draw.RoundedBox(0, x - w / 2, y - h / 2, w + 2, h + 2, colBlack)
        draw.RoundedBox(0, x - w / 2 + 1, y - h / 2 + 1, w, h, self:GetWashing() and colGreen or colRed)
    cam.End3D2D()
end