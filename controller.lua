require("love.keyboard")

-- Key state handling. 0 = up, 1 = pressed, 2 = down, 3 = released
function manageKeys( Keys )
  for ak, Key in pairs(Keys) do
    if love.keyboard.isDown(Key.reference) then
      if Key.value == 1 then
        Key.value = 2
      elseif Key.value ~= 2 then
        Key.value = 1
      end
    else
      if Key.value == 3 then
        Key.value = 0
      elseif Key.value ~= 0 then
        Key.value = 3
      end
    end
  end
end
