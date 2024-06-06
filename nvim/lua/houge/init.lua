require("houge.remap")
require("houge.set")

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

local plugins = {
	{ "wakatime/vim-wakatime", lazy = false },

	{ "olimorris/onedarkpro.nvim", priority = 1000 },

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	{
		"hougesen/blame-me.nvim",
		-- dir = "/home/geg/Desktop/projects/blame-me.nvim",
		opts = {},
	},

	{
		"hougesen/hitt",
		-- dir = "/home/geg/Desktop/projects/hitt",
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},

	"echasnovski/mini.pairs",

	{ "nvim-telescope/telescope.nvim", tag = "0.1.4", dependencies = { "nvim-lua/plenary.nvim" } },

	{ "stevearc/conform.nvim", opts = {} },

	"mg979/vim-visual-multi",

	{ "folke/neodev.nvim", opts = {} },

	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		opts = {},
	},

	"b0o/schemastore.nvim",

	{
		"https://git.sr.ht/~swaits/zellij-nav.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{ "<A-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
			{ "<A-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
			{ "<A-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
			{ "<A-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
		},
		opts = {},
	},
}

local opts = {
	-- defaults = { lazy = true },
	-- performance = {
	-- cache = { enabled = true },
	-- },
}

require("lazy").setup(plugins, opts)

require("houge.colorscheme")
