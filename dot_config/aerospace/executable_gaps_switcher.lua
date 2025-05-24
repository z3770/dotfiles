#!/usr/bin/env lua

-- Получаем абсолютный путь к директории скрипта
local function get_script_dir()
	local str = debug.getinfo(1, "S").source
	if str:sub(1, 1) == "@" then
		local script_path = str:sub(2)
		return script_path:match("(.*/)")
	end
	return "./"
end

local script_dir = get_script_dir() or "./"
local config_file = script_dir .. "aerospace.toml"

local bordless_gaps = {
	"[gaps] #bordless",
	"   inner.horizontal = 0",
	"   inner.vertical =   0",
	"   outer.left =       0",
	"   outer.bottom =     0",
	"   outer.top =        0",
	"   outer.right =      0",
}

local normal_gaps = {
	"[gaps] #normal",
	"    inner.horizontal = 10",
	"    inner.vertical =   10",
	"    outer.left =       20",
	"    outer.bottom =     10",
	"    outer.top =        35",
	"    outer.right =      20",
}

local function get_current_gaps(filename)
	local current_gaps = nil
	local f = io.open(filename, "r")
	if not f then
		return nil
	end
	for line in f:lines() do
		local type = line:match("%[gaps%][^#]*#%s*(.-)%s*$")
		if type then
			current_gaps = type
			break
		end
	end
	f:close()
	return current_gaps
end

local function get_new_gaps(current_type)
	if current_type == "bordless" then
		return normal_gaps
	else
		return bordless_gaps
	end
end

local function update_config(filename, new_gaps)
	local lines = {}
	local f = io.open(filename, "r")
	if not f then
		return
	end
	for line in f:lines() do
		table.insert(lines, line)
	end
	f:close()

	local start_idx, end_idx
	for i, line in ipairs(lines) do
		if line:match("^%[gaps%]") then
			start_idx = i
			for j = i + 1, #lines do
				if lines[j]:match("^%[.+%]") then
					end_idx = j - 1
					break
				end
			end
			if not end_idx then
				end_idx = #lines
			end
			break
		end
	end

	local new_lines = {}
	if start_idx then
		for i = 1, start_idx - 1 do
			table.insert(new_lines, lines[i])
		end
		for _, l in ipairs(new_gaps) do
			table.insert(new_lines, l)
		end
		for i = end_idx + 1, #lines do
			table.insert(new_lines, lines[i])
		end
	else
		for _, l in ipairs(lines) do
			table.insert(new_lines, l)
		end
		if #lines > 0 then
			table.insert(new_lines, "")
		end
		for _, l in ipairs(new_gaps) do
			table.insert(new_lines, l)
		end
	end

	local f = io.open(filename, "w")
	if not f then
		return
	end
	for _, l in ipairs(new_lines) do
		f:write(l .. "\n")
	end
	f:close()
end

local current_type = get_current_gaps(config_file)
local new_gaps = get_new_gaps(current_type)
update_config(config_file, new_gaps)
