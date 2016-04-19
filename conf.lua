-- Configuration
function love.conf(t)
  t.identity = "OotD"
  t.version = "0.10.1" -- The LOVE version this game was made for (string)
  t.window.width = 600
  t.window.height = 460
  t.window.fullscreentype = "desktop"
  t.window.fullscreen = false

  t.modules.joystick = false

  -- For Windows debugging
  t.console = true
end
