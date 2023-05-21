import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class("PartiSystem").extends(gfx.sprite)

function PartiSystem:init(w, h)
  PartiSystem.super.init(self)

  self._img = gfx.image.new(w or 400, h or 240, gfx.kColorClear)
  self:setImage(self._img)
  self:setCenter(0,0)
  self:setIgnoresDrawOffset(true)
  self:setZIndex(32767)

  self._particles = {}
  self.count = 0
end

function PartiSystem:update()
  local particles = self._particles
  local l = #particles
  if self._last_count == 0 and l == 0 then
    return
  end
  self._last_count = l

  self:markDirty()
  local img = self._img
  img:clear(gfx.kColorClear)
  local offx, offy = gfx.getDrawOffset()

  gfx.pushContext(img)
    for i=l, 1, -1 do
      local particle = particles[i]
      local isDone = particle:draw(offx, offy)
      if isDone then
        table.remove(particles, i)
        self.count -= 1
      end
    end
  gfx.popContext()
end

function PartiSystem:clear()
  self._particles = {}
  self.count = 0
end

function PartiSystem:spawnParticle(particle)
  table.insert(self._particles, particle)
  self.count += 1
end

class("PartiParticle").extends()

function PartiParticle:draw(offx, offy) end
