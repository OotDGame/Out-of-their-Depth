--require("bin/save")

function initiation()
  --print(love.filesystem.getSaveDirectory())
  math.randomseed(os.time())
  gameVersion = 0.049
  love.window.setTitle("Out of their Depth v" .. gameVersion)
  love.graphics.setBackgroundColor(50, 50, 50)
  fonts = {
    openingNameFont = love.graphics.newFont("fonts/He Really Did Tho.ttf", 32),
    wusads = love.graphics.newFont("fonts/Walk up slowly and down smash.ttf", 16),
    hrdt = love.graphics.newFont("fonts/He Really Did Tho.ttf", 16)
  }
  Keys = {
    left = { reference = 'a', value = 0 },
    right = { reference = 'd', value = 0 },
    up = { reference = 'w', value = 0 },
    down = { reference = 's', value = 0 },
    enter = { reference = 'return', value = 0},
    backspace = { reference = 'backspace', value = 0},
    f12 = { reference = 'f12', value = 0}
  }
  activeObjects = {}
  activeTexts = {}
  scene = ''
  sceneTimer = 0
  name = 'New User'
  local loadData = love.filesystem.load('saves/save1.lua')
  loadData()
  tagLimit = 12
end

function saveGame()
  local outputString = string.format('name = "%s"', name)
  print(outputString)
  local success = love.filesystem.write(
    'saves/save1.lua',
    outputString
    )
  print(success)
end
