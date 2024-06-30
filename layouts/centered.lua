local layout = {
  name = "centered",
  magnifier_factor = 0.55,
  icon = "",
  icon_focus = "",
}

function layout.arrange(p)
  local t = p.tag or screen[p.screen].selected_tag
  local cls = p.clients
  local area = p.workarea
  local n = #cls

  if n == 0 then
    return
  end

  -- Determine the focused client
  local focused_idx = 1
  for i, c in ipairs(cls) do
    if c == client.focus then
      focused_idx = i
      break
    end
  end

  -- Arrange the focused client
  local focused_client = cls[focused_idx]
  focused_client:geometry({
    x = area.x + (area.width * (1 - layout.magnifier_factor) / 2),
    y = area.y,
    width = area.width * layout.magnifier_factor,
    height = area.height,
  })

  -- Arrange the non-focused clients
  local non_focused_clients = {}
  for i, c in ipairs(cls) do
    if i ~= focused_idx then
      table.insert(non_focused_clients, c)
    end
  end

  local non_focused_height = area.height / (#non_focused_clients > 0 and #non_focused_clients or 1)
  for i, c in ipairs(non_focused_clients) do
    c:geometry({
      x = area.x,
      y = area.y + (i - 1) * non_focused_height,
      width = area.width,
      height = non_focused_height,
    })
  end
end

return layout
