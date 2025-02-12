if vim.g.loaded_local_llm then
	return
end
vim.g.loaded_local_llm = true

require("local-llm")
