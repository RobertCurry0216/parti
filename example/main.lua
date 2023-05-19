import "init"

local pd <const> = playdate
local gfx <const> = pd.graphics

deltaTime = 1 / playdate.display.getRefreshRate()

class("PartiBall").extends(PartiParticle)

function PartiBall:init(x, y)
  self.x = x
  self.y = y
  self.dx = math.random(-3, 3)
  self.dy = math.random(-3, 3)
end

function PartiBall:draw()
  self.x += self.dx
  self.y += self.dy
  if self.x > 400 or self.x < 0 then return true end
  if self.y > 240 or self.y < 0 then return true end

  gfx.drawCircleAtPoint(self.x, self.y, 4)
end

local function init()
  parti = PartiSystem()
  parti:add()
end

init()

function playdate.update()
  if pd.buttonIsPressed(pd.kButtonA) then
    parti:spawnParticle(PartiBall(200, 120))
  end

  if pd.buttonIsPressed(pd.kButtonB) then
    parti:clear()
  end

	pd.timer.updateTimers()
	gfx.sprite.update()
	pd.drawFPS(2,0) -- FPS widget
end