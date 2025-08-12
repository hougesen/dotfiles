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

	just = { "just" },
	justfile = { "just" },

	crystal = {},

	dart = { "dart_format" },

	nim = { "nimpretty" },

	haskell = { "ormolu" },

	-- injected = {}

	sh = { "shfmt" },

	toml = { "taplo" },

	php = { "pretty-php", "php_cs_fixer" },

	gleam = { "gleam" },

	["_"] = { "trim_whitespace", "trim_newlines" },

	kotlin = { "ktfmt" },
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
	"jsonc",
	"json5",
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
		timeout_ms = 5000,
		lsp_fallback = true,
	},
})

require("conform.formatters.injected").options.ignore_errors = false
