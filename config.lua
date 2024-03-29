--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.terminal.open_mapping = "<leader>t"
-- 保存之后在切换buffer
lvim.keys.normal_mode["<S-l>"] = ":w<cr>:BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":w<cr>:BufferLineCyclePrev<CR>"
-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- 插入模式下移动光标
lvim.keys.insert_mode["<C-h>"] = "<Left>"
lvim.keys.insert_mode["<C-j>"] = "<Down>"
lvim.keys.insert_mode["<C-k>"] = "<up>"
lvim.keys.insert_mode["<C-l>"] = "<Right>"

-- -- 主题
lvim.colorscheme = "onedark"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.ensure_installed = {
	"vim",
	"lua",
	"go",
	"gomod",
	"javascript",
	"typescript",
	"tsx",
	"http",
	"html",
	"css",
	"markdown",
	"json",
	"jsonc",
	"yaml",
	"regex",
	"dockerfile",
}

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }
-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ filetypes = { "go" }, command = "gofmt" },
	{ filetypes = { "lua" }, command = "stylua" },
	{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "prettier" },
	{ filetypes = { "html", "css", "markdown" }, command = "prettier" },
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ filetypes = { "go" }, command = "golangci_lint" },
	{ filetypes = { "markdown" }, command = "markdownlint", args = { "--disable", "MD013" } },
	{ filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }, command = "eslint" },
	{ filetypes = { "html" }, command = "tidy" },
	{ filetypes = { "css" }, command = "stylelint" },
})

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "deep",
				-- 代码样式
				code_style = {
					comments = "bold",
					keywords = "none",
					functions = "bold",
					strings = "none",
					variables = "none",
				},
				-- Custom Highlights --
				colors = {},
				-- Override default colors
				highlights = {
					["@comment"] = { fg = "#16a085", fmt = "bold" },
				},
				-- Override highlight groups

				-- Plugins Config --
				diagnostics = {
					darker = true, -- darker colors for diagnostic
					undercurl = true, -- use undercurl instead of underline for diagnostics
					background = true, -- use background color for virtual text
				},
			})
		end,
	},
	-- 自动保存
	-- {
	-- 	"Pocco81/auto-save.nvim",
	-- 	config = function()
	-- 		require("auto-save").setup()
	-- 	end,
	-- },
	-- 记住上一次编辑的地方
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	-- todo 高亮
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- 自动闭合html 标签
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
