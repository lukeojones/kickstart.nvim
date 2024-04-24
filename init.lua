vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Install Lazy Package Manager from Github Repo
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- Setup the Lazy command
local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
}
local opts = {}

-- Setup Lazy Package Manager
require("lazy").setup(plugins, opts)

-- Setup Catppuccin Colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Setup Telescope and associated keybindings
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- Requires ripgrep

-- Setup Treesitter Configs
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "html", "rust", "typescript" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },  
})
