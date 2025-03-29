require('plugins-setup')
require('core.options')
require('core.keymaps')
require('core.colorscheme')
-- require("plugins.nvim-tree")
-- require("plugins.lualine")
-- require("plugins.nvim-tmux-navigator")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
