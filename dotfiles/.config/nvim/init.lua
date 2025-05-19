vim.opt.runtimepath:prepend(vim.fn.expand('~') .. '/.vim')
vim.opt.runtimepath:append(vim.fn.expand('~') .. '/.vim/after')
vim.opt.packpath = vim.opt.runtimepath
vim.cmd('source ' .. vim.fn.expand('~') .. '/.vimrc')
