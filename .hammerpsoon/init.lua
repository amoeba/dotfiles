local hyper = {"cmd", "alt", "ctrl", "shift"}

-- Move window to left half of screen
hs.hotkey.bind(hyper, "I", function()
  local win = hs.window.focusedWindow()
  if not win then return end  -- If no window is focused, do nothing

  local screen = win:screen()
  local screenFrame = screen:frame()

  -- Calculate new size (2/3 of screen dimensions)
  local newWidth = screenFrame.w * (2/3)
  local newHeight = screenFrame.h * (2/3)

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
