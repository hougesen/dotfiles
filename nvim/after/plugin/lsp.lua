local lsp = require("lsp-zero")
local util = require("lspconfig.util")
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local luasnip = require("luasnip")
local schemastore = require("schemastore")

lsp.preset("recommended")

local default_lsps = {
	"tsserver",
	"eslint",
	"rust_analyzer",
	"volar",
}

lsp.ensure_installed(default_lsps)

lsp.setup_servers(default_lsps)

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(_client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "<leader>pp", function()
		vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
	end, opts)
end)

local function get_typescript_server_path(root_dir)
	local global_ts = "/home/[yourusernamehere]/.npm/lib/node_modules/typescript/lib"
	-- Alternative location if installed as root:
	-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
	local found_ts = ""
	local function check_dir(path)
		found_ts = util.path.join(path, "node_modules", "typescript", "lib")
		if util.path.exists(found_ts) then
			return path
		end
	end
	if util.search_ancestors(root_dir, check_dir) then
		return found_ts
	else
		return global_ts
	end
end

lspconfig.volar.setup({
	filetypes = { "vue" },
	root_dir = util.root_pattern("package.json"),
	init_options = {
		vue = {
			hybridMode = false,
		},
		typescript = {
			tsdk = get_typescript_server_path(vim.fn.getcwd()),
		},
	},
})

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
		},
	},
})

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
			validate = { enable = true },
		},
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

local cmp_action = lsp.cmp_action()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp_action.tab_complete(),
		["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
	}),
})
