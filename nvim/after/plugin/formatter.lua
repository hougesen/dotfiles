local conform = require("conform")

local formatters_by_ft = {
	lua = { "stylua" },

	rust = { "rust_analyzer" },

	python = function(bufnr)
		if conform.get_formatter_info("ruff_format", bufnr).available then
			return { "ruff_format" }
		else
			return { "isort", "black" }
		end
	end,

	c = { "clang_format" },

	cpp = { "clang_format" },

	go = { "gofumpt", "goimports" },

	ruby = { "rubocop" },

	ocaml = { "ocamlformat" },

	crystal = {},

	dart = { "dart_format" },

	-- injected = {}

	sh = { "shellcheck" },

	toml = { "taplo" },

	["_"] = { "trim_whitespace" },
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

formatters_by_ft["markdown"] = { p, "injected" }

conform.setup({
	formatters_by_ft = formatters_by_ft,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

require("conform.formatters.injected").options.ignore_errors = false
