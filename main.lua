debug = true

modulePath = "bin/"

require("bin/settings")
require("bin/sceneManager")
require("bin/controller")
require("bin/drawables")

function love.load(arg, sprites)
  love.window.setIcon(love.image.newImageData('images/icon.png'))
  initiation()
  switchScene('mainMenu', activeObjects)
  love.graphics.setFont(fonts.hrdt)
end

-------------------------------------------

function love.update(dt)
  manageScene( Keys , dt )

  manageKeys( Keys )

  if Keys.f12.value == 1 then
    debug = not debug
    saveGame()
  end

  if Keys.backspace.value == 1 then
    name = name:sub(1, -2)
  end

  for i, object in ipairs(activeObjects) do
    object:update(dt, Keys)
  end
end

-------------------------------------------

function zOrder(a, b)
  if a.z == b.z then
    if a.y ~= b.y then return a.y < b.y
    else return a.x < b.x end
  else return a.z < b.z end
end

function love.draw(dt)
  --love.graphics.translate(math.random(-1, 1), math.random(-1, 1)) -- screen rumble! If we ever need to implement it.
  table.sort(activeObjects, zOrder)
  for i, object in ipairs(activeObjects) do
    object:draw(camera)
  end

  for i, object in ipairs(activeTexts) do
    object:draw(camera)
  end
end
