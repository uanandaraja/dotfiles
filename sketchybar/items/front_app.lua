local settings = require("settings")
local app_icons = require("helpers.app_icons")
local default_font = require("helpers.default_font")
local colors = require("colors")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = {
		font = default_font.icons,
		size = 16.0,
		padding_left = 8,
		padding_right = 4,
	},
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	local app_name = env.INFO
	local icon = app_icons[app_name] or app_icons["default"] -- Fallback to default icon if not found

	front_app:set({
		icon = {
			string = icon,
		},
		background = {
			height = 28,
			corner_radius = 8,
			border_color = colors.grey,
			border_width = 1,
		},
	})
end)

front_app:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
