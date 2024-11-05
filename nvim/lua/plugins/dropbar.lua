return {
	"Bekaboo/dropbar.nvim",
	config = function()
		require("dropbar").setup({})
	end,
	ft_ignore = { "nvim-tree", "help", "lazy" },
}
