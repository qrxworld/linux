vim.opt.syntax = 'on'
vim.opt.termguicolors = true
vim.opt.clipboard = 'unnamedplus'

-- QRx
vim.filetype.add({
  extension = {
    qrx = "markdown",
  },
})

-- Autoupdates
vim.opt.autoread = true
vim.opt.updatetime = 1000

-- Autocommands for file checking
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = 'Check for external changes when gaining focus or entering a buffer'
})
vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = 'Check for external changes when the cursor is idle'
})

-- Wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false -- Turn off 'list' mode as it conflicts with linebreak

-- Formatting
vim.opt.relativenumber = true

-- Tabs
-- Autocommands for FileType settings
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
  desc = 'Set tab settings for all file types'
})

-- Keyboard shortcuts
vim.g.mapleader = ','

-- Using vim.keymap.set for all mappings
local mappings = {
  -- Normal mode mappings
  n = {
    -- Insert current time in HHMM format
    ['<leader>t'] = { 'strftime("%H%M")<CR>P', 'Insert current time (HHMM)' },
    -- Insert horizontal rule
    ['<leader>hr'] = { 'o<CR><CR><CR><Esc>40i=<Esc>o<CR><CR><CR><Esc>', 'Insert horizontal rule' },
    -- LLMs
    [',sum'] = { ':%w !hey \'summarize the current buffer\' --more<CR>', 'Summarize buffer with hey' },
    [',next'] = { ':%w !hey \'what should i work on next?\' --more<CR>', 'Ask hey what to work on next' },
    [',save'] = { ':!cd ~/oz/;clear;save<CR>', 'Save with custom script' },
    [',hey'] = { ':%w !hey --more --prompt \'<CR>', 'Prompt hey with current buffer' },
    -- Escape sequences
    ['<Find>'] = { '<Home>', 'Move to end of line in insert mode' },
    ['<Select>'] = { '<End>', 'Move to beginning of line in insert mode' },
  },
  -- Insert mode mappings
  i = {
    ['jj'] = { '<Esc>', 'Exit insert mode' },
    -- Escape sequences
    ['<Find>'] = { '<Home>', 'Move to end of line in insert mode' },
    ['<Select>'] = { '<End>', 'Move to beginning of line in insert mode' },
    -- Insert current time in HHMM format
    ['<leader>t'] = { '<C-R>=strftime("%H%M")<CR>', 'Insert current time (HHMM) in insert mode' },
    -- MARKDOWN
    [',['] = { '[ ]', 'Insert checkbox' },
  },
  -- Visual mode mappings
  v = {
    -- Escape sequences
    ['<Find>'] = { '<Home>', 'Move to end of line in insert mode' },
    ['<Select>'] = { '<End>', 'Move to beginning of line in insert mode' },
  }
}

-- Loop through mappings and set them
for mode, mode_mappings in pairs(mappings) do
  for lhs, rhs_and_desc in pairs(mode_mappings) do
    local rhs = rhs_and_desc[1]
    local desc = rhs_and_desc[2]
    local opts = { noremap = true, silent = true, desc = desc } -- Add `desc` for `:h key-notation` and improved discoverability

    -- For mappings that are functions, we need to pass them directly.
    -- For string mappings, we enclose them in a table to correctly pass to vim.keymap.set.
    if type(rhs) == 'function' then
      vim.keymap.set(mode, lhs, rhs, opts)
    else
      vim.keymap.set(mode, lhs, rhs, opts)
    end
  end
end

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
