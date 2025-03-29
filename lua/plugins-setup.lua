-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")        -- lua functions that many plugins use

    use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

    -- use("vague2k/vague.nvim") -- preferred colorscheme
    -- use("ptdewey/darkearth-nvim") -- preferred colorscheme
    -- use("AlexvZyl/nordic.nvim") -- preferred colorscheme
    -- use ({ 'projekt0n/caret.nvim' })
    -- use("ttak0422/morimo")
    use("sainnhe/everforest")

    -- file explorer
    use { "nvim-tree/nvim-tree.lua" }

    -- vim-maximizer
    use("szw/vim-maximizer")

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })      -- fuzzy finder

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...

    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

    -- lua line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    if packer_bootstrap then
        require("packer").sync()
    end
end)
