-- Import existing vim configs
vim.opt.runtimepath:prepend(vim.fn.expand('~') .. '/.vim')
vim.opt.runtimepath:append(vim.fn.expand('~') .. '/.vim/after')
vim.opt.packpath = vim.o.runtimepath
vim.cmd('source ' .. vim.fn.expand('~') .. '/.vimrc')

-- Define your time thresholds
local morning_hour = 7
local night_hour = 20

-- Function to set colorscheme based on current hour
local function set_colorscheme_by_time()
  local hour = tonumber(os.date("%H"))
  if hour >= morning_hour and hour < night_hour then
    vim.cmd("colorscheme blue")
  else
    vim.cmd("colorscheme elflord")
  end
end

-- Call once on startup
set_colorscheme_by_time()

-- Set up a timer to check every 5 minutes (300000 ms)
local timer = vim.loop.new_timer()
timer:start(0, 300000, vim.schedule_wrap(function()
  set_colorscheme_by_time()
end))
