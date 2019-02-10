# lua-pngencoder

Extremely simple PNG encoder for Lua. Inspired (read: directly transpiled) from https://www.nayuki.io/page/tiny-png-output

## Usage

Import into your project, change usage of `bit` library to whatever suits your platform (by default it uses LuaJIT compatible `bit` library), use like this:
```lua
local encode = require "pngencoder"

local png = encode(64, 64) -- width, height
png:write { 0xFF, 0, 0 } -- RGB(255, 0, 0) pixel at 0x0
png:write { 0, 0xFF, 0 } -- RGB(0, 255, 0) pixel at 1x0
-- TODO: write rest of the pixels to fill rest of the 64x64 canvas

assert(png.done) -- just a failsafe to make sure we've filled the whole allocated PNG space

local data = png.output -- table containing raw PNG data
```

Note that the `output` table is populated in streaming fashion as you call `write`. You __must__ write all
the `width * height * 3` bytes before doing anything with the output to make sure the footer is properly written and the PNG file is complete. You can use the `done` flag to make sure you're done writing.
