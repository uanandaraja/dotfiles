local M = {}
local api = vim.api
local Split = require("nui.split")
local event = require("nui.utils.autocmd").event

-- Default configuration
local default_config = {
	api_key = os.getenv("OPENROUTER_API_KEY"),
	model = "google/gemini-2.0-flash-001",
	split_direction = "vertical",
	split_size = "40%",
	keymaps = {
		open = "<leader>lo",
		send = "<leader>ls",
	},
}

local config = default_config
local current_split = nil -- Keep track of the current split

-- Create a new split for the chat
local function create_chat_split()
	if current_split then
		current_split:show()
		return current_split
	end

	local split = Split({
		relative = "editor",
		position = "right",
		size = config.split_size,
		enter = true,
	})

	-- Set buffer options
	split:on(event.BufWinEnter, function()
		vim.opt_local.wrap = true
		vim.opt_local.filetype = "markdown"
		vim.opt_local.buftype = "nofile"
		vim.opt_local.buflisted = false
	end)

	split:mount()
	current_split = split
	return split
end

-- Function to make API request to OpenRouter
local function make_request(prompt)
	local curl = require("plenary.curl")

	local response = curl.post("https://openrouter.ai/api/v1/chat/completions", {
		headers = {
			["Content-Type"] = "application/json",
			["Authorization"] = "Bearer " .. config.api_key,
			["HTTP-Referer"] = "http://localhost:3000",
			["X-Title"] = "Neovim LLM Plugin",
		},
		body = vim.fn.json_encode({
			model = config.model,
			messages = {
				{ role = "user", content = prompt },
			},
		}),
	})

	if response.status == 200 then
		local data = vim.fn.json_decode(response.body)
		return data.choices[1].message.content
	else
		return "Error: " .. response.body
	end
end

-- Function to append text to buffer
local function append_to_buffer(bufnr, text)
	local lines = vim.split(text, "\n")
	api.nvim_buf_set_lines(bufnr, -1, -1, false, lines)
end

-- Function to send request
local function send_request()
	if not current_split then
		return
	end

	local bufnr = current_split.bufnr
	-- Get the current line
	local line = api.nvim_get_current_line()
	if line:match("^%s*$") then
		return
	end

	-- Append a visual separator
	append_to_buffer(bufnr, "\n---\n")

	-- Make the API request
	local response = make_request(line)

	-- Append the response
	append_to_buffer(bufnr, "\n" .. response .. "\n")
end

-- Main chat function
function M.start_chat()
	local split = create_chat_split()
	local bufnr = split.bufnr

	-- Set up buffer-local keymaps
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", config.keymaps.send, send_request, opts)
end

-- Setup function
function M.setup(user_config)
	config = vim.tbl_deep_extend("force", default_config, user_config or {})

	-- Create command
	vim.api.nvim_create_user_command("LLMChat", function()
		M.start_chat()
	end, {})

	-- Set up global keymap for opening chat
	vim.keymap.set("n", config.keymaps.open, function()
		M.start_chat()
	end, { noremap = true, silent = true })
end

return M
