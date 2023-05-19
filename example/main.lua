import "init"

local gfx <const> = pd.graphics

deltaTime = 1 / playdate.display.getRefreshRate()

class("PartiBall").extends(PartiParticle)

function PartiBall:init()
  self.x = math.random(400)
  self.y = math.random(240)
  self.dx = math.random(-3, 3)
  self.dy = math.random(-3, 3)
end

function PartiBall:draw()
  self.x += self.dx
  if self.x > 400 then self.x -= 400
  elseif self.x < 0 then self.x += 400
  end

  self.y += self.dy
  if self.y > 240 then self.y -= 240
  elseif self.y < 0 then self.y += 240
  end

  gfx.drawCircleAtPoint(self.x, self.y, 4)
end

local function init()
  parti = PartiSystem()
  parti:add()

  for i=1, 50 do
    parti:spawnParticle(PartiBall())
  end
end

init()

function playdate.update()
	pd.timer.updateTimers()
	gfx.sprite.update()
	pd.drawFPS(2,0) -- FPS widget
end