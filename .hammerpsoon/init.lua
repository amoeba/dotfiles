-- VARIABLES
local hyper = { "cmd", "alt", "ctrl", "shift" }

-- FUNCTIONS
-- TODO

-- KEYBINDS

-- Move window to left half of screen
hs.hotkey.bind(hyper, "I", function()
  local win = hs.window.focusedWindow()
  if not win then return end -- If no window is focused, do nothing

  local screen = win:screen()
  local screenFrame = screen:frame()

  -- Calculate new size (2/3 of screen dimensions)
  local newWidth = screenFrame.w * (2 / 3)
  local newHeight = screenFrame.h * (2 / 3)

  -- Calculate new position
  local newX = screenFrame.x + (screenFrame.w - newWidth) / 2
  local newY = screenFrame.y + (screenFrame.h - newHeight) / 2

  -- Set new frame
  win:setFrame({
    x = newX,
    y = newY,
    w = newWidth,
    h = newHeight
  })
end)

-- Reload Config
hs.hotkey.bind(hyper, "r", function()
  hs.reload()
end)

-- MOUSEBINDS
local mouseButton3 = 3
local mouseButton4 = 4

-- Extra mouse buttons
hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(event)
  -- Get modifier keys and button
  local flags = event:getFlags()
  local button = event:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)


  -- Mouse3
  if not flags.alt and button == mouseButton3 then
    hs.eventtap.keyStroke({ "cmd", "shift" }, "[", 0)
    return true
  end

  -- Mouse4
  if not flags.alt and button == mouseButton4 then
    hs.eventtap.keyStroke({ "cmd", "shift" }, "]", 0)
    return true
  end

  -- Option+Mouse3
  if flags.alt and button == mouseButton3 then
    hs.eventtap.keyStroke({ "cmd" }, "[", 0)
    return true
  end

  -- Option+Mouse4
  if flags.alt and button == mouseButton4 then
    hs.eventtap.keyStroke({ "cmd" }, "]", 0)
    return true
  end

  return false
end):start()

-- always announce on reload
hs.alert.show("Config Loaded")
