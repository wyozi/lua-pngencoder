local begin = require("pngencoder")

local function writebuf(buf, w, h, fname)
  -- write to png
  local png = begin(w, h)
  for i = 1, w * h do
    local v = buf[i]
    if not v then
      png:write({ 0, 0, 0 })
    else
      png:write({ math.floor(v[1] + 0.5), math.floor(v[2] + 0.5), math.floor(v[3] + 0.5) })
    end
  end

  assert(png.done)
  local pngbin = table.concat(png.output)
  local file = assert(io.open(fname, "wb"))
  file:write(pngbin)
  file:close()
end

-- test passed on luajit, lua5.2, lua5.3, lua5.4, macOS14.6
local function test()
  local w, h = 128, 128
  local buf = {}
  local n = 8
  for i = 1, w do
    for j = 1, h do
      local color = { 0xFF, 0xFF, 0xFF }
      local u, v = i / (w + 1), j / (h + 1)
      local d = math.floor(u * n) + math.floor(v * n)
      if d % 2 == 0 then
        color[1], color[2], color[3] = 0x40, 0x40, 0x40
      end
      buf[(h - i) * w + j] = color
    end
  end

  writebuf(buf, w, h, "testpng.png")
end

test()
