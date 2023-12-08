local conform = require("conform")

local formatters_by_ft = {
	lua = { "stylua" },
	rust = { "rust_analyzer" },

	python = { { "ruff_fix", "isort" }, { "ruff_format", "black" } },

	cpp = { "clang_format" },
	c = { "clang_format" },

	go = { "gofumpt", "goimports" },

	cs = { "csharpier" },
}

local prettier_file_types = {
	"angular",
	"css",
	"flow",
	"graphql",
	"html",
	"javascript",
	"javascriptreact",
	"json",
	"less",
	"markdown",
	"markdown.mdx",
	"scss",
	"typescript",
	"typescriptreact",
	"vue",
	"yaml",
}

local p = { "prettierd", "prettier" }

for _, ft in pairs(prettier_file_types) do
	formatters_by_ft[ft] = p
end

conform.setup({
	formatters_by_ft = formatters_by_ft,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})
