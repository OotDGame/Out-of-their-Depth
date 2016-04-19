--require "love.graphics"

local SourceImage = love.graphics.newImage("images/plane.png")

local image_w = SourceImage:getWidth()
local image_h = SourceImage:getHeight()

drawableObject = {
  new = function (self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.sprite = love.graphics.newImage("images/blank.png")
    self.x = 0
    self.y = 0
    self.z = 0
    self.dx = 0
    self.dy = 0
    self.killOffscreen = nil
    return o
  end,

  update = function (self, dt, Keys)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
    if self.killOffscreen == 'top' then
      if (self.y + self.sprite.getHeight(self.sprite)) < 0 then
        self.x = math.random(0, love.graphics.getWidth() - 50)
        self.y = love.graphics.getHeight()
      end
    elseif self.killOffscreen == 'bottom' then
      if (self.y >= love.graphics.getHeight()) then
        self.y = 0 - self.sprite.getHeight(self.sprite)
      end
    end
  end,

  draw = function (self, camera)
    love.graphics.draw(self.sprite, math.floor(self.x), math.floor(self.y))
  end,
}

drawableText= {
  new = function (self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.type = ''
    self.font = fonts.hrdt
    self.text = 'text'
    self.color = {255, 255, 255, 255}
    self.shadowColor = {0, 0, 0, 125}
    self.shadowOffset = 2
    self.x = 5
    self.y = 5
    self.z = 500
    self.rotation = 0
    self.scalex = 1
    self.scaley = 1
    return o
  end,

  update = function (self, dt, Keys)
  end,

  draw = function (self, camera)
    love.graphics.setFont(self.font)
    if self.type ~= 'debug' then
      if self.type == 'shadow' then
        love.graphics.setColor(self.shadowColor)
        love.graphics.print(self.text, self.x, (self.y + self.shadowOffset), self.rotation, self.scalex, self.scaley)
      end
      love.graphics.setColor(self.color)
      love.graphics.print(self.text, self.x, self.y, self.rotation, self.scalex, self.scaley)
    else
      if debug then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.shadowColor)
        love.graphics.print(self.text, self.x, self.y + self.shadowOffset, self.rotation, self.scalex, self.scaley)
        love.graphics.print(self.text, self.x, self.y - self.shadowOffset, self.rotation, self.scalex, self.scaley)
        love.graphics.print(self.text, self.x + self.shadowOffset, self.y, self.rotation, self.scalex, self.scaley)
        love.graphics.print(self.text, self.x - self.shadowOffset, self.y, self.rotation, self.scalex, self.scaley)
        love.graphics.setColor(self.color)
        love.graphics.print(self.text, self.x, self.y, self.rotation, self.scalex, self.scaley)
      end
    end
    --love.graphics.printf(self.text, 0, 240, love.graphics.getWidth(), 'center')
  end,
}


baseCharacter = drawableObject:new{
  new = function (self, o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.sprite = love.graphics.newImage("images/plane.png")
    self.x = 0
    self.y = 0
    self.dx = 0
    self.dy = 0
    self.orthSpd = 220
    self.diagSpd = math.sqrt((self.orthSpd^2)/2)
    return o
  end,

  update = function (self, dt, Keys)
    self.walk(self, dt, Keys)
    --self.sprite = sprites.planeSprite

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
  end,

  walk = function (self, dt, Keys)
    if (Keys.left.value == 1 or Keys.left.value == 2) and not (Keys.right.value == 1 or Keys.right.value == 2) then
      self.dx = (-self.orthSpd )
    elseif (Keys.right.value == 1 or Keys.right.value == 2) and not (Keys.left.value == 1 or Keys.left.value == 2) then
      self.dx = ( self.orthSpd )
    else
      self.dx = 0
    end
    if (Keys.up.value == 1 or Keys.up.value == 2) and not (Keys.down.value == 1 or Keys.down.value == 2) then
      self.dy = (-self.orthSpd )
    elseif (Keys.down.value == 1 or Keys.down.value == 2) and not (Keys.up.value == 1 or Keys.up.value == 2) then
      self.dy = ( self.orthSpd )
    else
      self.dy = 0
    end
  end
}
--player = baseCharacter:new{x = 100, y = 200}
