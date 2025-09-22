local Input = "./dist/main.lua"
local Header = "build/header.lua"
local Output = "./dist/main.lua"
local PackageJson = "../package.json"

local Primary = "\27[38;2;48;255;106m" -- #30ff6a
local Dev = "\27[38;2;255;210;50m" -- #FFD232
local Build = "\27[38;2;50;231;255m" -- #32E7FF
local Error = "\27[38;2;255;74;50m" -- #FF4A32

local Reset = "\27[0m"

local function colorize(text, color)
    return color .. text .. Reset
end

local function getPackageData()
    -- Direct values extracted from package.json
    local data = {
        name = "windui",
        version = "1.6.51",
        main = "./dist/main.lua",
        repository = "https://github.com/Footagesus/WindUI",
        discord = "https://discord.gg/Q6HkNG4vwP",
        author = "Footagesus",
        description = "Roblox UI Library for scripts",
        license = "MIT",
        keywords = "ui-library, ui-design, script, script-hub, exploiting"
    }

    return data
end

local function processHeader(headerContent, packageData)
    for key, value in pairs(packageData) do
        if value then
            headerContent = headerContent:gsub("{{package%." .. key .. "}}", value)
            headerContent = headerContent:gsub("{package%." .. key .. "}", value)
            headerContent = headerContent:gsub("{{" .. key:upper() .. "}}", value)
            headerContent = headerContent:gsub("{" .. key:upper() .. "}", value)
        end
    end
    
    local buildTime = os.date("%Y-%m-%d %H:%M:%S")
    local buildDate = os.date("%Y-%m-%d")
    local buildYear = os.date("%Y")
    
    headerContent = headerContent:gsub("{{BUILD_TIME}}", buildTime)
    headerContent = headerContent:gsub("{BUILD_TIME}", buildTime)
    headerContent = headerContent:gsub("{{BUILD_DATE}}", buildDate)
    headerContent = headerContent:gsub("{BUILD_DATE}", buildDate)
    headerContent = headerContent:gsub("{{BUILD_YEAR}}", buildYear)
    headerContent = headerContent:gsub("{BUILD_YEAR}", buildYear)
    
    return headerContent
end

local FileCount = arg[1] or "N/A"
local ProcessingTime = arg[2] or "N/A"
local Mode = arg[3] or "dev"

local DevPrefix = "[ DEV ]" .. " "
local BuildPrefix = "[ BUILD ]" .. " "
local ErrorPrefix = "[ × ]" .. " "

local Prefix = Mode == "dev" and colorize(DevPrefix, Dev) or colorize(BuildPrefix, Build)

local packageData = getPackageData()

if not packageData.version then
    error(colorize(ErrorPrefix, Error) .. "Failed to get version from package.json")
end

local File = io.open(Header, "r")
if not File then
    error(colorize(ErrorPrefix, Error) .. "Failed to open header file: " .. Header)
end
local HeaderContent = File:read("*all")
File:close()

HeaderContent = processHeader(HeaderContent, packageData)

File = io.open(Input, "r")
if not File then
    error(colorize(ErrorPrefix, Error) .. "Failed to open input file: " .. Input)
end
local Content = File:read("*all")
File:close()

local NewContent = HeaderContent .. "\n\n" .. Content

File = io.open(Output, "w")
if not File then
    error(colorize(ErrorPrefix, Error) .. "Failed to open output file: " .. Output)
end
File:write(NewContent)
File:close()

local Time = os.date("[ %H:%M:%S ]")

print(Time)
print(colorize("[ ✓ ] ", Primary) .. Prefix)
print(colorize("[ > ] ", Primary) .. "WindUI Build completed successfully")
print(colorize("[ > ] ", Primary) .. "Version: " .. (packageData.version or "N/A"))
print(colorize("[ > ] ", Primary) .. "Time taken: " .. ProcessingTime .. "ms")
print(colorize("[ > ] ", Primary) .. "Output file: " .. Output .. "\n")