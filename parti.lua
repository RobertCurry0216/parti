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

  gfx.pushContext(img)
    for i=l, 1, -1 do
      local particle = particles[i]
      particle:draw()
      if particle.isDone then
        table.remove(particles, i)
      end
    end
  gfx.popContext()
end

function PartiSystem:spawnParticle(particle)
  table.insert(self._particles, particle)
end

class("PartiParticle").extends()

function PartiParticle:init()
  self.isDone = false
end

function PartiParticle:draw() end