return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		sidebar_filetypes = {
			["neo-tree"] = { event = "BufWipeout" },
		},
	},
	keys = {
		{ "<leader>[", "<Cmd>BufferPrevious<CR>", mode = "n" },
		{ "<leader>]", "<Cmd>BufferNext<CR>", mode = "n" },
		{ "<leader>1", "<Cmd>BufferGoto 1<CR>", mode = "n" },
		{ "<leader>2", "<Cmd>BufferGoto 2<CR>", mode = "n" },
		{ "<leader>3", "<Cmd>BufferGoto 3<CR>", mode = "n" },
		{ "<leader>4", "<Cmd>BufferGoto 4<CR>", mode = "n" },
		{ "<leader>5", "<Cmd>BufferGoto 5<CR>", mode = "n" },
	},
	version = "^1.0.0",
}
