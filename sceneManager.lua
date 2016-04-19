require("bin/drawables")

sceneMaster = {
  scene = '',
  sceneTimer = 0,
  zEntropy = 0.001,
}

function switchScene( newScene )
  sceneMaster.sceneTimer = 0
  sceneMaster.sceneTimer2 = 0
  activeObjects = {}
  activeTexts = {}
  table.insert(activeObjects, drawableText:new{
    type = 'debug',
    shadowOffset = 1,
    update = function (self, dt, Keys)
      self.text = 'Current FPS: ' .. love.timer.getFPS()
    end
  })
  if newScene == 'mainMenu' then
    love.graphics.setBackgroundColor(188, 106, 80)
    table.insert(activeObjects, drawableText:new{
      type = 'shadow',
      font = fonts.openingNameFont,
      y = 235,
      update = function (self, dt, Keys)
        self.text = name
        self.x = (love.graphics.getWidth() / 2) - (self.font:getWidth(self.text) / 2)
      end,
    })
    table.insert(activeObjects, drawableText:new{
      type = 'shadow',
      font = fonts.hrdt,
      text = 'v' .. gameVersion,
      x = 557,
      y = 151
    })
    table.insert(activeObjects, drawableObject:new{
      sprite = love.graphics.newImage("images/menus/openingBackground.png"),
      z = 0,
      dy = 0,
      killOffscreen = 'bottom',
      -- draw = function (self, camera)
      --   love.graphics.draw(self.sprite, math.floor(self.x), self.y)
      -- end,
    })
    table.insert(activeObjects, drawableObject:new{
      sprite = love.graphics.newImage("images/menus/openingBackground.png"),
      y = -1 - love.graphics.getHeight(love.graphics.newImage("images/menus/openingBackground.png")),
      z = 0,
      dy = 0,
      killOffscreen = 'bottom',
      -- draw = function (self, camera)
      --   love.graphics.draw(self.sprite, math.floor(self.x), self.y)
      -- end,
    })
    cloudsLeft = 14
    while cloudsLeft > 1 do
      table.insert(activeObjects, drawableObject:new{
        sprite = love.graphics.newImage("images/menus/openingCloud.png"),
        x = math.random(-20, love.graphics.getWidth() - 70),
        y = (cloudsLeft * 63) - 100,
        z = 1,
        dy = -30,
        killOffscreen = 'top'})
      cloudsLeft = cloudsLeft - 1
    end
    table.insert(activeObjects, drawableObject:new{
      sprite = love.graphics.newImage("images/menus/openingTitle.png"),
      x = 48,
      y = 111,
      z = 2,
    })
  elseif newScene == 'play' then
    love.graphics.setBackgroundColor(230, 230, 230)

    player = baseCharacter:new{x = 100, y = 200}
    table.insert(activeObjects, player)
  end
  sceneMaster.scene = newScene
end

function manageScene( Keys , fonts, dt )
  if sceneMaster.scene == 'mainMenu' then
    function love.textinput(t)
      if sceneMaster.scene == 'mainMenu' and name.len(name) < tagLimit then
        name = name .. t
      end
    end
    if sceneMaster.sceneTimer > 6 then
    end
    if sceneMaster.sceneTimer2 > 1 then
    end
    if Keys.enter.value == 1 then
      switchScene('play', activeObjects)
    end
  elseif sceneMaster.scene == 'play' then
    if Keys.enter.value == 1 then
      switchScene('mainMenu', activeObjects)
    end
  end
  --sceneMaster.sceneTimer = sceneMaster.sceneTimer + 1 * dt
  --sceneMaster.sceneTimer2 = sceneMaster.sceneTimer2 + 1 * dt
end
