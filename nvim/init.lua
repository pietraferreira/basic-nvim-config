-- MAPPINGS
-- Make mapping nice
local M = {}

function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
	  options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map = M.map

-- Map leader key
vim.g.mapleader = ","

-- Telescope
map("n", "<Leader>ff", ":Telescope find_files<CR>", { silent = true })
map("n", "<Leader>fg", ":Telescope live_grep<CR>", { silent = true })

-- Turn numbers on/off
map("n", "<Leader>N", ":setlocal number!<CR>", { silent = true })

-- Nvim Tree
map("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- SETTINGS
-- Defining alias for vim.opt.
local set = vim.opt

-- Choose theme
vim.cmd[[colorscheme tokyonight]]

-- Using new filetype detection system(written in lua).
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- Decrease time of completion menu.
set.updatetime = 300

-- Set cursorhold updatetime(:  .
vim.g.cursorhold_updatetime = 100

-- Set file encoding to utf-8.
set.fileencoding = "utf-8"

-- Line number settings.
set.number = true
set.numberwidth = 2
set.relativenumber = false

-- Always show the column else it would shift the text each time
vim.opt.signcolumn = "yes"

-- Remove showing mode.
set.showmode = false

-- Adding true color to NeoVim.
set.termguicolors = true

-- Enable clipboard.
set.clipboard = "unnamedplus"

-- Set indentation stuf.
set.tabstop = 2
set.shiftwidth = 2
set.textwidth = 80
set.smartindent = true
set.smartcase = true
-- Tab to spaces
set.expandtab = true
-- Setting completion menu height.
set.pumheight = 20 -- pop up menu height.

-- Set searching stuf.
set.hlsearch = true
set.incsearch = true
set.ignorecase = true

-- Without this option some times backspace did not work correctly.
set.backspace = "indent,eol,start"

-- For opening splits on right or bottom.
set.splitbelow = true
set.splitright = true

-- Setting time that Neovim wait after each keystroke.
set.timeoutlen = 200

-- Setting up autocomplete menu.
set.completeopt = { "menuone", "noselect" }

-- Testing
set.visualbell = true
vim.o.cursorline = true
set.guicursor = "n-v-c:block"

-- Creates a backup file
set.backup = false

-- Allow access to system clipboard
set.clipboard = "unnamedplus"

-- So that `` is visible in markdown files
set.fileencoding = "utf-8"

-- Creates a swap file
set.swapfile = false

-- Enable persistent undo
set.undofile = true

-- Display lines as one long line
set.wrap = false

-- Start scrolling 8 before the end of page
set.scrolloff = 8

-- Column so I know the limit
set.colorcolumn = "80"

-- Don't continue comment on next line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- PLUGINS
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

  -- Have packer use a popup window
packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
}

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-lua/plenary.nvim'
	use {
          'windwp/nvim-autopairs',
	  keys = {
        	{ "i", "(" },
		{ "i", "[" },
		{ "i", "{" },
		{ "i", "'" },
		{ "i", '"' },
		{ "i", "<BS>" },
	      },
          config = function()
	    require('plugins.autopairs')
	  end
	}
	use {
	  'kyazdani42/nvim-tree.lua',
	  config = function()
	    require('plugins.nvim-tree')
	  end
	}
	use {
          'nvim-telescope/telescope.nvim',
	  requires = { { 'nvim-lua/plenary.nvim' } },
	  config = function()
	    require('plugins.telescope')
	  end
        }
end)
