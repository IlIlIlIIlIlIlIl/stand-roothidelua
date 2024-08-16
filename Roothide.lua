--[[
⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤
⣿⡁⠶⢶⡖⠒⠒⠒⠒⠒⠒⠒⠖⣲⠶⠆⣿⣿⡇⠶⢶⣖⠒⠒⠒⢒⡶⠶⠀⣿
⠛⠛⠻⢦⡙⣦⡀⠀⠀⠀⠀⠀⢰⠡⣾⣿⣿⣿⣿⣿⣶⠘⡆⠀⡴⢫⡶⠛⠛⠛
⠀⠀⠀⠀⢹⡼⢷⡄⠀⠀⠀⠀⠘⣆⢻⣿⣿⣿⣿⣿⡟⣰⡇⡞⣱⠟⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠹⡌⢿⡄⠀⠀⠀⠀⠘⣆⢻⣿⣿⣿⡿⣱⣿⡞⣰⡟⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠹⣌⢻⡄⠀⠀⠀⠀⠘⣆⢻⣿⡿⢡⣿⡟⢠⡟⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠹⣆⢻⣄⠀⠀⠀⠀⠘⢆⠻⢣⣿⡿⢡⡟⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠹⣆⢻⣆⠀⠀⠀⠀⠈⢦⣾⡿⢡⡟⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣆⢻⣆⠀⠀⠀⠀⠀⢻⢡⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣦⢻⣆⠀⠀⠀⢰⢃⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣧⢻⣆⠀⢠⢃⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣧⠹⠦⠃⣾⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]
local scriptStartTime = util.current_time_millis()
local nativeRequireStartTime = util.current_time_millis()
util.require_natives("3274a.g")
local nativeRequireEndTime = util.current_time_millis() - nativeRequireStartTime
AMT_id = 0
function cleanupAboveMapToasts()
    if AMT_id != 0 then
        THEFEED_REMOVE_ITEM(AMT_id)
    end
end
function aboveMapToast(msg, title, subject, notificationColour, txrDictName, txrName)
    title = title or "Roothide"
    subject = subject or ""
    txrDictName = txrDictName or "CHAR_MP_FM_CONTACT"
    txrName = txrName or "CHAR_MP_FM_CONTACT"  --! https://wiki.rage.mp/index.php?title=Notification_Pictures
    notificationColour = notificationColour or 69 --! https://docs.fivem.net/docs/game-references/hud-colors/
    THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
    AMT_id = END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(txrDictName, txrName, true, 1, title, subject)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
end
function aboveMapToastRequestTxr(msg, title, subject, notificationColour, txrDictName, txrName)
    title = title or "Roothide"
    subject = subject or ""
    txrDictName = txrDictName or "CHAR_MP_FM_CONTACT"
    txrName = txrName or "CHAR_MP_FM_CONTACT"  --! https://wiki.rage.mp/index.php?title=Notification_Pictures
    notificationColour = notificationColour or 69 --! https://docs.fivem.net/docs/game-references/hud-colors/
    THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
    REQUEST_STREAMED_TEXTURE_DICT(txrDictName, false)
    while not HAS_STREAMED_TEXTURE_DICT_LOADED(txrDictName) do
        util.yield()
    end
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
    AMT_id = END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(txrDictName, txrName, true, 1, title, subject)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
    SET_STREAMED_TEXTURE_DICT_AS_NO_LONGER_NEEDED(txrDictName)
end
function aboveMapToastNoTitle(msg, notificationColour)
    notificationColour = notificationColour or 69 --! https://docs.fivem.net/docs/game-references/hud-colors/
    THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
    AMT_id = END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
end
local function luaStats(input)
    async_http.init("https://roothidelua.glitch.me", "/")
    async_http.set_post("application/json", string.format('{"input": "%s"}', input))
    async_http.dispatch()
end
function devmode()
    local developer = {0x0EE24B30, 0xF1FC04D, 0xF2475BB}
    local user = players.get_rockstar_id(players.user())
    for developer as id do if user == id then return true end end
    return false
end
util.ensure_package_is_installed("lua/auto-updater")
local auto_updater = require("auto-updater")
local auto_update_config = {
    source_url="https://raw.githubusercontent.com/IlIlIlIIlIlIlIl/stand-roothidelua/main/Roothide.lua",
    script_relpath=SCRIPT_RELPATH,
    project_url="https://github.com/IlIlIlIIlIlIlIl/stand-roothidelua",
    branch="main",
    dependencies={
        "store/Roothide/rhTables.pluto",
    }
}
if async_http.have_access() then
    if !devmode() then
        if auto_updater.run_auto_update(auto_update_config) then
            util.toast("No updates found. You are already running the latest version.")
        end
    else
        aboveMapToastNoTitle("[Roothide] Dev Mode Enabled")
    end
    luaStats(players.get_name(players.user()))
else
    aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the 'Disable Internet Access' option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
end
local rhDir = $"{filesystem.scripts_dir()}Roothide\\"
local rhStoreDir = $"{filesystem.store_dir()}Roothide\\"
if !filesystem.is_dir(rhDir) then filesystem.mkdirs(rhDir) end
if !filesystem.is_dir(rhStoreDir) then filesystem.mkdirs(rhStoreDir) end
if !filesystem.exists($"{filesystem.store_dir()}Roothide\\rhTables.pluto") then
    util.toast("Required file is missing. Please ensure 'rhTables.pluto' is located in the 'Roothide' directory within the store folder. (Lua Scripts/store/Roothide/rhTables.pluto)", TOAST_ALL)
    util.stop_script()
else
    require("store.roothide.rhTables")
end
-----𝑓ᴜɴᴄᴛɪᴏɴs​​​​​-----
    function devLog(msg)
        if devmode() then util.toast(msg, TOAST_CONSOLE) end
    end
    function playerRefTrigger(pid, ref, value)
        local menu_ref = menu.ref_by_rel_path(pid, ref)
        if menu_ref:isValid() then
            if value != nil then
                menu_ref.value = value
            else
                menu_ref:trigger()
            end
        else
            util.toast($"Ref is invalid!\nRef Found: {ref}", TOAST_DEFAULT | TOAST_CONSOLE)
        end
    end
    local function loadAnimationDict(dict)
        if !HAS_ANIM_DICT_LOADED(dict) then
            REQUEST_ANIM_DICT(dict)
            local startTime = os.clock()
            while !HAS_ANIM_DICT_LOADED(dict) do
                util.yield()
                if os.clock() - startTime > 5000 / 1000 then
                    util.toast($"Failed to load animation dictionary: {dict}")
                    return false
                end
            end
        end
        return true
    end
    local function getOffsetFromCam(distance)
        if type(distance) != "table" then
            distance = {x=distance, y=distance, z=distance}
        end
        local camRot = GET_FINAL_RENDERED_CAM_ROT(2)
        local camPos = GET_FINAL_RENDERED_CAM_COORD()
        local direction = v3.toDir(camRot)
        local destination = {
            x = camPos.x + (direction.x * distance.x),
            y = camPos.y + (direction.y * distance.y),
            z = camPos.z + (direction.z * distance.z)
        }
        return destination
    end

-----Eɴᴀʙʟᴇ Cᴏʟᴏᴜʀs Iɴ Cᴏɴsᴏʟᴇ​​​​​-----
    util.ensure_package_is_installed("lua/luaffi")
    local ffi = require "luaffi"
    local kernel32 = ffi.open("kernel32")
    $define STD_OUTPUT_HANDLE = -11
    $define INVALID_HANDLE_VALUE = -1
    $define ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x4
    function colourConsole()
        local hSTDOUT = kernel32:call("GetStdHandle", STD_OUTPUT_HANDLE)
        if hSTDOUT != INVALID_HANDLE_VALUE then
            local mode = memory.alloc_int()
            if kernel32:call("GetConsoleMode", hSTDOUT, mode) != 0 then
                kernel32:call("SetConsoleMode", hSTDOUT, memory.read_int(mode) | ENABLE_VIRTUAL_TERMINAL_PROCESSING)
            end
        end
    end
    colourConsole()
    local consoleToggled = menu.ref_by_path("Stand>Console", 55).value
    util.create_tick_handler(function() --! Tɪᴄᴋ Hᴀɴᴅʟᴇʀ ᴛᴏ ᴇɴᴀʙʟᴇ ᴄᴏʟᴏᴜʀs ᴡʜᴇɴ ᴄᴏɴsᴏʟᴇ ɪs ᴇɴᴀʙʟᴇᴅ
        if menu.ref_by_path("Stand>Console", 55).value and !consoleToggled then
            util.yield()
            colourConsole()
        end
        consoleToggled = menu.ref_by_path("Stand>Console", 55).value
    end)

-----Mᴇɴᴜ Sᴇᴛᴜᴘ-----
    local roothide_menu = menu.attach_before(menu.ref_by_path("Stand>Settings", 55), menu.list(menu.shadow_root(), "Roothide", {"roothidescript"}, "Roothide Script"))
    roothide_menu:action("Stop Script", {}, "Stop the script.", function()
        menu.focus(menu.ref_by_path($"Stand>Lua Scripts>{SCRIPT_NAME}>Stop Script", 55))
        util.stop_script()
    end)
    menu.action(menu.my_root(), "Go To Script Menu", {}, "Go to the scripts main menu", function()
        menu.ref_by_path("Stand>Roothide", 55):trigger()
    end)
    menu.action(menu.my_root(), "Check for Updates", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
        if async_http.have_access() then
            auto_update_config.check_interval = 0
            util.toast("Checking for updates")
            if auto_updater.run_auto_update(auto_update_config) then
                util.toast("No updates found. You are already running the latest version.")
            end
        else
            aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the 'Disable Internet Access' option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
        end
    end)
    if SCRIPT_MANUAL_START then
        menu.ref_by_path("Stand>Roothide", 55):trigger()
        PLAY_SOUND_FRONTEND(-1, "SPAWN", "BARRY_01_SOUNDSET", true)
    end

-----Mᴇɴᴜ Rᴏᴏᴛ-----
    local selfList = menu.list(roothide_menu, "Self", {}, "")
    local vehicleOptions = menu.list(roothide_menu, "Vehicle", {}, "")
    local online = menu.list(roothide_menu, "Online", {}, "")
    local world = menu.list(roothide_menu, "World", {}, "")
    --local game = menu.list(roothide_menu, "Game", {}, "")
    --local misc = menu.list(roothide_menu, "Misc", {}, "")
    roothide_menu:action("Check for Updates", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
        if async_http.have_access() then
            auto_update_config.check_interval = 0
            util.toast("Checking for updates")
            if auto_updater.run_auto_update(auto_update_config) then
                util.toast("No updates found. You are already running the latest version.")
            end
        else
            aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the 'Disable Internet Access' option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
        end
    end)

-----Cʜɪʟᴅ Lɪsᴛs-----
    -----Sᴇʟғ Lɪsᴛ-----
        local weapons = selfList:list("Weapons")
        local paintGun = weapons:list("Paint Gun", {}, "Shoot paint instead of bullets.")
        local ragdollOptions = selfList:list("Ragdoll Options")
    -----Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs Lɪsᴛ---​​​​--
        local seatSwitcher = vehicleOptions:list("Switch Seat", {"switchseat", "seatswitch"})
        local breakDoors = vehicleOptions:list("Break Off Vehicle Parts", {"breakdoors"})
    -----Oɴʟɪɴᴇ Lɪsᴛ-----
        local protections = online:list("Protections",{"rhprotections"})
        local chatList = online:list("Chat Options")
    -----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----
        local traffic = world:list("Traffic")
        local rqControlSettings = world:list("Entity Control")
        local clearAreaOptions = world:list("Clear Area Options")

-----Sᴇʟғ Lɪsᴛ-----
    -----ᴡᴇᴀᴘᴏɴs-----
        -----sɴɪᴘᴇʀZᴏᴏᴍ-----
            local sniper_hashes = {
                100416529,  --! Sɴɪᴘᴇʀ Rɪғʟᴇ
                205991906,  --! Hᴇᴀᴠʏ Sɴɪᴘᴇʀ
                177293209   --! Hᴇᴀᴠʏ Sɴɪᴘᴇʀ MK2
            }
            local function is_sniper_weapon(weapon_hash)
                for _, hash in ipairs(sniper_hashes) do
                    if weapon_hash == hash then
                        return true
                    end
                end
                return false
            end
            local zoomOut_pressed_value = false
            weapons:toggle_loop("Instant Sniper Zoom", {}, "Sets your sniper rifle zoom level to maximum when scoping in.", function()
                if is_sniper_weapon(GET_SELECTED_PED_WEAPON(players.user_ped())) then
                    if IS_AIM_CAM_ACTIVE() then
                        if IS_CONTROL_JUST_PRESSED(2, 43) then --! INPUT_SNIPER_ZOOM_OUT_SECONDARY
                            zoomOut_pressed_value = true
                        end
                        if !zoomOut_pressed_value then
                            SET_FIRST_PERSON_AIM_CAM_ZOOM_FACTOR(6.0) --! Sᴇᴛ ᴛʜᴇ ᴢᴏᴏᴍ ʟᴇᴠᴇʟ ᴛᴏ ᴍᴀxɪᴍᴜᴍ
                        end
                    else
                        zoomOut_pressed_value = false
                    end
                else
                    zoomOut_pressed_value = false
                end
            end)
            weapons:toggle_loop("Sniper Auto Zoom", {}, "Automatically zooms in when scoping in with sniper rifles.", function()
                if is_sniper_weapon(GET_SELECTED_PED_WEAPON(players.user_ped())) then
                    if IS_AIM_CAM_ACTIVE() then
                        if IS_CONTROL_JUST_PRESSED(2, 43) then --! INPUT_SNIPER_ZOOM_OUT_SECONDARY
                            zoomOut_pressed_value = true
                        end
                        if !zoomOut_pressed_value then
                            SET_CONTROL_VALUE_NEXT_FRAME(2, 42, 1.0)  --! Sɪᴍᴜʟᴀᴛᴇ ʜᴏʟᴅɪɴɢ ᴛʜᴇ ᴋᴇʏ ᴛᴏ ᴢᴏᴏᴍ ɪɴ
                        end
                    else
                        zoomOut_pressed_value = false
                    end
                else
                    zoomOut_pressed_value = false
                end
            end)
        -----paintgun-----
            local paintColour = {r = 255, g = 0, b = 255, a = 1.0}
            local paintDecal = 1030
            local paintScale = 0.5
            local coordsPTG = nil
            paintGun:toggle_loop("Paint Gun", {"paintgun"}, "Local only! Shoots paint instead of bullets. Works best with rapid fire enabled.\nNote: Other players won't see it & doesn't work on walls.", function()
                coordsPTG = memory.alloc()
                SET_DECAL_BULLET_IMPACT_RANGE_SCALE(0.0)
                if coordsPTG and coordsPTG != 0 then
                    if GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), coordsPTG) then
                        if memory.read_float(coordsPTG) != 0.0 then
                            local coords = v3.new(coordsPTG)
                            ADD_DECAL(paintDecal, coords.x, coords.y, coords.z, 0, 0, -1, 0, 1.0, 0.0, paintScale, paintScale - 0.1, paintColour.r / 255, paintColour.g / 255, paintColour.b / 255, 1, -1, true, false, false)
                            REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 1.0)
                        end
                    end
                end
            end, function()
                SET_DECAL_BULLET_IMPACT_RANGE_SCALE(1.0)
                coordsPTG = nil
            end)
            paintGun:action("Clear Paint", {"clearpaint"}, "Clear All Paint.", function()
                REMOVE_DECALS_IN_RANGE(0.0, 0.0, 0.0, 10000.0)
            end)
            paintGun:divider("Options")
            paintGun:colour("Paint Colour", {}, "Change the colour of the paint.", paintColour.r / 255, paintColour.g / 255, paintColour.b / 255, 1.0, false, function(colour)
                paintColour = {r = colour.r * 255, g = colour.g * 255, b = colour.b * 255}
            end):rainbow()
            paintGun:list_select("Paint Type", {}, "", paintDecals, 1030, function(value)
                paintDecal = value
            end)
            paintGun:slider_float("Paint Scale", {"paintscale"}, "Adjust the size of the paint splatter.", 5, 1000, paintScale * 10, 1, function(value)
                paintScale = value / 10.0
            end)

    -----ʀᴀɢᴅᴏʟʟOᴘᴛɪᴏɴs-----
        local ragdollKey = 0x51 --! Default key is 'Q'
        local ragdollType = 0
        local playerIsRagdoll = false
        ragdollOptions:toggle_loop("Quick Stand", {}, "Allows you to get up faster when knocked down.", function()
            SET_PED_CONFIG_FLAG(players.user_ped(), 227, IS_PLAYER_PLAYING(players.user())) end, function() SET_PED_CONFIG_FLAG(players.user_ped(), 227, false)
        end)
        ragdollOptions:toggle("Clumsiness [Shortcut]", {}, "Toggles the 'Clumsiness' option in Stand's Self tab, making your character more prone to tripping and falling.", function(toggle)
            menu.ref_by_path("Self>Clumsiness").value = toggle
        end)
        ragdollOptions:toggle_loop("Stay Down", {}, "Prevents you from getting back up after being ragdolled.", function()
            if menu.ref_by_path("Self>Gracefulness").value then
                util.toast("Pro Tip: Don't enable Gracefulness and Stay Down simultaneously. ;)")
                menu.ref_by_path("Stand>Roothide>Self>Ragdoll Options>Stay Down", 55).value = false
            end
            if IS_PED_RAGDOLL(players.user_ped()) then
                playerIsRagdoll = true
            end
            if playerIsRagdoll then
                SET_PED_TO_RAGDOLL(players.user_ped(), 750, 750, 0, false, false, false)
            end
        end, function() playerIsRagdoll = false end)
        ragdollOptions:divider("Ragdoll Toggle")
        ragdollOptions:toggle_loop("Ragdoll Toggle", {"ragdolltoggle"}, "Hold the specified key to make your character ragdoll and release to recover.", function()
            if menu.ref_by_path("Self>Gracefulness").value then
                util.toast("Pro Tip: Don't enable Gracefulness and Ragdoll Toggle simultaneously. ;)")
                menu.ref_by_path("Stand>Roothide>Self>Ragdoll Options>Ragdoll Toggle", 55).value = false
            end
            if !menu.command_box_is_open() and !IS_MP_TEXT_CHAT_TYPING() and !IS_SYSTEM_UI_BEING_DISPLAYED() and util.is_key_down(ragdollKey) then
                SET_PED_TO_RAGDOLL(players.user_ped(), 750, 750, ragdollType, false, false, false)
            end
            if ragdollKey == 0xA2 then
                menu.ref_by_path("Game>Disables>Disable Game Inputs>DUCK", 55).value = true
            else
                menu.ref_by_path("Game>Disables>Disable Game Inputs>DUCK", 55).value = false
            end
        end, function() menu.ref_by_path("Game>Disables>Disable Game Inputs>DUCK", 55).value = false end)
        ragdollOptions:list_select("Ragdoll Toggle Key", {}, "Change the key used for Ragdoll Toggle.", {
            {0x51, "Q"},{0x45, "E"},{0x52, "R"},{0x58, "X"},{0xA2, "Left Control"}}, 0x51, function(value, menu_name)
            ragdollKey = value
        end)
        ragdollOptions:list_select("Ragdoll Type", {}, "Change the type of ragdoll used for Ragdoll Toggle.", {
            {0, "Normal"},{2, "Narrow leg stumble"},{3, "Wide leg stumble"}}, 0, function(value, menu_name)
            ragdollType = value
        end)

-----Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs Lɪsᴛ---​​​​--
    -----sᴇᴀᴛSᴡɪᴛᴄʜᴇʀ-----
        seatSwitcher:action("Driver Seat", {"seatdriver"}, "Warp into driver seat.", function() if entities.get_user_vehicle_as_handle() != -1 then SET_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), -1) else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        seatSwitcher:action("Passenger Seat", {"seatpassenger"}, "Warp into passenger seat.", function() if entities.get_user_vehicle_as_handle() != -1 then SET_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), 0) else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        seatSwitcher:toggle("Prevent Auto Seat Shuffle", {"noshuffle"}, "Prevents auto shuffling over to drivers seat if it becomes free.", function(on) SET_PED_CONFIG_FLAG(players.user_ped(), 184, on) end)
        seatSwitcher:action("Back Left", {}, "Warp into Back left seat.", function() if entities.get_user_vehicle_as_handle() != -1 then SET_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), 1) else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        seatSwitcher:action("Back Right", {}, "Warp into Back right seat.", function() if entities.get_user_vehicle_as_handle() != -1 then SET_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), 2) else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        local seatIndices = {3, 4, 5, 6, 7}
        local seatLabels = {"Seat 5", "Seat 6", "Seat 7", "Seat 8", "Seat 9"}
        seatSwitcher:textslider_stateful("Other Seats", {}, "For anything larger than 4 seats", seatLabels, function(index, value) local selectedSeatIndex = seatIndices[index] if entities.get_user_vehicle_as_handle() != -1 then SET_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), selectedSeatIndex) else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
    -----BʀᴇᴀᴋOғғVᴇʜɪᴄʟᴇPᴀʀᴛs-----
        local bvpOptions = {
            "Break All Parts",
            "Break Driver Door",
            "Break Passenger Door",
            "Break Back Left Door",
            "Break Back Right Door",
            "Break Hood",
            "Break Trunk",
            "Break Trunk2"
        }
        breakDoors:textslider("Break Vehicle Parts", {}, "", bvpOptions, function(index)
            local vehicleHandle = entities.get_user_vehicle_as_handle()
            if vehicleHandle != -1 then
                if index == 1 then
                    for i = -1, 6 do
                        SET_VEHICLE_DOOR_BROKEN(vehicleHandle, i, false)
                    end
                    util.toast("All parts broken.")
                else
                    local partName = bvpOptions[index]:gsub("Break ", "")
                    SET_VEHICLE_DOOR_BROKEN(vehicleHandle, index-2, false)
                    util.toast($"{partName} broken.")
                end
            else
                util.toast("Player is not in a vehicle or has no recent vehicle.")
            end
        end)
        breakDoors:divider("Delete Vehicle Parts")
        breakDoors:action("Delete All Parts", {}, "", function() if entities.get_user_vehicle_as_handle() != -1 then for i = -1, 6 do SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), i, true) end util.toast("All parts deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Driver Door", {}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 0, true) util.toast("Driver door deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Passenger Door", {}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 1, true) util.toast("Passenger door deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Back Left Door", {}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 2, true) util.toast("Back left door deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Back Right Door", {}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 3, true) util.toast("Back right door deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Hood", {"nohood", "breakhood"}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 4, true) util.toast("Vehicle hood deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Trunk", {"notrunk", "breaktrunk"}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 5, true) util.toast("Vehicle trunk deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
        breakDoors:action("Delete Trunk2", {"notrunk2", "breaktrunk2"}, "", function() if entities.get_user_vehicle_as_handle() != -1 then SET_VEHICLE_DOOR_BROKEN(entities.get_user_vehicle_as_handle(), 6, true) util.toast("Trunk2 deleted.") else util.toast("Player is not in a vehicle or has no recent vehicle.") end end)
    vehicleOptions:toggle_loop("Engine Always On", {"alwayson"}, "Keeps the engine and lights running when you exit the vehicle.", function()
        local vehicle = entities.get_user_vehicle_as_handle()
        if vehicle != -1 then
            SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
            SET_VEHICLE_LIGHTS(vehicle, 0)
        end
    end, function()
        local vehicle = entities.get_user_vehicle_as_handle()
        if vehicle != -1 and !IS_PED_IN_VEHICLE(players.user_ped(), vehicle, false) then
            SET_VEHICLE_ENGINE_ON(vehicle, false, true, false)
        end
    end)
    local last_vehicle_with_radio_off = 0
    vehicleOptions:toggle_loop("Turn Radio Off When Entering A Vehicle", {}, "Turns off the radio each time you get in a vehicle.", function()
        local current_vehicle = GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if current_vehicle != 0 then
            if last_vehicle_with_radio_off != current_vehicle and GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
                if IS_VEHICLE_RADIO_ON(current_vehicle) then
                    util.yield(850)
                    SET_RADIO_TO_STATION_NAME("OFF")
                    util.toast("Radio off")
                end
                last_vehicle_with_radio_off = current_vehicle
            end
        else
            last_vehicle_with_radio_off = 0
        end
    end)
    -----ʀᴀɴᴅᴏᴍGᴀʀᴀɢᴇVᴇʜɪᴄʟᴇ-----
        local function get_all_vehicles(dir)
            local paths = {}
            local stack = {dir}
            while #stack > 0 do
                local current_dir = table.remove(stack)
                for _, file in ipairs(filesystem.list_files(current_dir)) do
                    if filesystem.is_dir(file) then
                        table.insert(stack, file)
                    elseif string.sub(file, -4) == ".txt" then
                        table.insert(paths, file)
                    end
                end
            end
            return paths
        end
        local function vehicle_path_to_stand_ref(path)
            local vehiclesDir = $"{filesystem.stand_dir()}Vehicles\\"
            local relativePath = path:sub(#vehiclesDir + 1, -5):gsub("\\", ">")
            return menu.ref_by_path($"Vehicle>Garage>{relativePath}", 55)
        end
        vehicleOptions:action("Random Stand Garage Vehicle", {"rv", "randomvehicle"}, "Selects a random vehicle from your Stand garage and highlights it in the menu.", function()
            local vehiclesDir = $"{filesystem.stand_dir()}Vehicles"
            local allVehicles = get_all_vehicles(vehiclesDir)
            if #allVehicles == 0 then
                util.toast("No vehicles found in the Stand garage.")
                return
            end
            local randomVehicle = allVehicles[math.random(#allVehicles)]
            local ref = vehicle_path_to_stand_ref(randomVehicle)
            menu.focus(ref)
        end)
    -----RandomPersonalVehicle-----
        vehicleOptions:action("Random Personal Vehicle", {"rpv", "randompersonalvehicle"}, "Selects a random vehicle from your in-game owned vehicles and highlights it in the menu.", function()
            if !util.is_session_started() or util.is_session_transition_active() then
                util.toast(lang.get_localised(280744635))
                return
            end
            local personalVehicles = menu.ref_by_path("Vehicle>Personal Vehicles", 55):getChildren()
            if #personalVehicles <= 4 then
                util.toast("No personal vehicles available to select.")
                return
            end
            local random = math.random(5, #personalVehicles)
            menu.focus(personalVehicles[random])
        end)

-----Oɴʟɪɴᴇ Lɪsᴛ-----
    -----Pʀᴏᴛᴇᴄᴛɪᴏɴs-----
        protections:action("Stop All Sounds", {"stopsounds"}, "", function()
            for i = -1,100 do
                STOP_SOUND(i)
                RELEASE_SOUND_ID(i)
            end
            util.toast("All sounds stopped.")
        end)
    -----ᴄʜᴀᴛLɪsᴛ-----
        -----ᴄᴏᴍᴍᴀɴᴅBᴏxCʜᴀᴛ-----
            local commandBoxChat = chatList:list("Command Box Chat")
            local toggleChatHistory = menu.ref_by_path("Online>Chat>Always Open", 55)
            local disableChatInputAll = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_ALL", 55)
            local disableChatInputTeam = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_TEAM", 55)
            local showTyping
            commandBoxChat:toggle_loop("Command Box Chat", {"commandboxchat"}, "Use the command box to chat. Useful if chat is not opening when pressing 'T'. This option disables the in game chat box to prevent crashing when co-loading cherax and typing in chat.", function()
                disableChatInputAll.value = true
                disableChatInputTeam.value = true
                if !menu.command_box_is_open() then
                    if util.is_key_down(0x54) and !IS_SYSTEM_UI_BEING_DISPLAYED() then --! Kᴇʏ 'T'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) --! Sᴛᴀʀᴛ Tʏᴘɪɴɢ
                                end
                            end
                            util.yield()
                        end
                        menu.show_command_box("gmsg ")
                        while menu.command_box_is_open() do
                            toggleChatHistory.value = true
                            util.yield()
                        end
                        toggleChatHistory.value = false
                        util.yield(40)
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) --! Sᴛᴏᴘ Tʏᴘɪɴɢ
                                end
                            end
                            util.yield()
                        end
                    elseif util.is_key_down(0x59) and !IS_SYSTEM_UI_BEING_DISPLAYED() then --! Kᴇʏ 'Y'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) --! Sᴛᴀʀᴛ Tʏᴘɪɴɢ
                                end
                            end
                            util.yield()
                        end
                        menu.show_command_box("tmsg ")
                        while menu.command_box_is_open() do
                            toggleChatHistory.value = true
                            util.yield()
                        end
                        toggleChatHistory.value = false
                        util.yield(40)
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) --! Sᴛᴏᴘ Tʏᴘɪɴɢ
                                end
                            end
                            util.yield()
                        end
                    end
                end
            end, function()
                disableChatInputAll.value = false
                disableChatInputTeam.value = false
            end)
            showTyping = commandBoxChat:toggle("Show typing", {"showtyping"}, "Should other players see if you are typing?", function()end, true)
            gMsgHidden = commandBoxChat:action("Send a Global Message", {"globalmessage", "gmsg"}, "", function(click_type)
                menu.show_command_box("gmsg "); end, function(input)
                chat.send_message(input, false, true, true)
            end)
            tMsgHidden = commandBoxChat:action("Send a Team Message", {"teammessage", "tmsg"}, "", function(click_type)
                menu.show_command_box("tmsg "); end, function(input)
                chat.send_message(input, true, true, true)
            end)
            menu.set_visible(gMsgHidden, false)
            menu.set_visible(tMsgHidden, false)
        -----ʟᴏɢCʜᴀᴛ-----
            local chatColours = {[1] = ANSI.RED, [2] = ANSI.DARK_RED, [3] = ANSI.DARK_ORANGE, [4] = ANSI.ORANGE, [5] = ANSI.LIGHT_ORANGE, [6] = ANSI.GOLD, [7] = ANSI.YELLOW, [8] = ANSI.LIGHT_GREEN, [9] = ANSI.GREEN, [10] = ANSI.DARK_GREEN, [11] = ANSI.LIGHT_BLUE, [12] = ANSI.BLUE, [13] = ANSI.CYAN, [14] = ANSI.DARK_CYAN, [15] = ANSI.LIGHT_PURPLE, [16] = ANSI.PURPLE, [17] = ANSI.DARK_PURPLE, [18] = ANSI.LIGHT_MAGENTA, [19] = ANSI.MAGENTA, [20] = ANSI.DARK_MAGENTA, [21] = ANSI.LIGHT_PINK, [22] = ANSI.PINK, [23] = ANSI.DARK_PINK, [24] = ANSI.LIGHT_BROWN, [25] = ANSI.BROWN, [26] = ANSI.LIGHT_GREY, [27] = ANSI.GREY, [28] = ANSI.DARK_GREY, [29] = ANSI.WHITE}
            chatList:divider("Chat Logging")
            local logChatEnabled = false
            local team_chat_colour = 9
            local global_chat_colour = 7
            chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
                if logChatEnabled then
                    local playerName = players.get_name(sender)
                    local logColour = team_chat and chatColours[team_chat_colour] or chatColours[global_chat_colour]
                    local logChatMessage = $"{logColour}{playerName} [{(team_chat and "TEAM" or "ALL")}] {text}{ANSI.RESET}"
                    util.toast(logChatMessage, TOAST_CONSOLE)
                end
            end)
            chatList:toggle("Log To Console With Coloured Text", {}, "Logs all chat messages to the console with coloured text.", function(on)
                if on and !menu.ref_by_path("Stand>Console", 55).value then
                    util.toast("Enabled Stand Console At 'Stand > Console'.")
                    menu.ref_by_path("Stand>Console", 55).value = true
                end
                logChatEnabled = on
            end)
            chatList:list_select("Global Chat Colour", {}, "Change the colour of global [All] chat messages.", {
                {1, "Red"},{2, "Dark Red"},{3, "Dark Orange"},{4, "Orange"},{5, "Light Orange"},{6, "Gold"},{7, "Yellow"},{8, "Light Green"},{9, "Green"},{10, "Dark Green"},{11, "Light Blue"},{12, "Blue"},{13, "Cyan"},{14, "Dark Cyan"},{15, "Light Purple"},{16, "Purple"},{17, "Dark Purple"},{18, "Light Magenta"},{19, "Magenta"},{20, "Dark Magenta"},{21, "Light Pink"},{22, "Pink"},{23, "Dark Pink"},{24, "Light Brown"},{25, "Brown"},{26, "Light Grey"},{27, "Grey"},{28, "Dark Grey"},{29, "White"}
            }, 7, function(value, menu_name)
                global_chat_colour = value
            end)
            chatList:list_select("Team Chat Colour", {}, "Change the colour of team/org chat messages.", {
                {1, "Red"},{2, "Dark Red"},{3, "Dark Orange"},{4, "Orange"},{5, "Light Orange"},{6, "Gold"},{7, "Yellow"},{8, "Light Green"},{9, "Green"},{10, "Dark Green"},{11, "Light Blue"},{12, "Blue"},{13, "Cyan"},{14, "Dark Cyan"},{15, "Light Purple"},{16, "Purple"},{17, "Dark Purple"},{18, "Light Magenta"},{19, "Magenta"},{20, "Dark Magenta"},{21, "Light Pink"},{22, "Pink"},{23, "Dark Pink"},{24, "Light Brown"},{25, "Brown"},{26, "Light Grey"},{27, "Grey"},{28, "Dark Grey"},{29, "White"}
            }, 9, function(value, menu_name)
                team_chat_colour = value
            end)
    local showspeakerson = online:toggle_loop("Show Who's Using Voice Chat", {"showvc"}, "Accurately shows who is talking in voice chat as soon as it happens. Better than vanilla. The speakers name will be shown in stands info overlay.", function()
        for players.list() as pid do
            if NETWORK_IS_PLAYER_TALKING(pid) then
                util.draw_debug_text($"{players.get_name(pid)} is talking")
            end
        end
    end)
    showspeakerson.value = true
    online:toggle_loop("Typing Notifications", {}, "Displays a notification when someone in the session is typing a message.", function()
        for players.list(false) as pid do
            if players.is_typing(pid) then
                util.toast($"{players.get_name(pid)} is typing...")
            end
        end
    end)
    online:toggle("AFK Safe Session", {"afk"}, "Create a tutorial session inside current session that other players cannot join giving you a safe space to go afk.", function(on)
        if on then
            NETWORK_START_SOLO_TUTORIAL_SESSION()
        else
            NETWORK_END_TUTORIAL_SESSION()
        end
    end)
    online:toggle_loop("Detect BST", {"showbst", "detectbst"}, "Detect players using BST", function()
        if !bst_detection_data then
            bst_detection_data = memory.alloc(5 * 8)
        end
        local data = bst_detection_data
        for i = 0, GET_NUMBER_OF_EVENTS(1) - 1 do
            local event = GET_EVENT_AT_INDEX(1, i)
            if event == 174 and GET_EVENT_DATA(1, i, data, 5) then
                local event_hash = memory.read_int(data)
                local pid = memory.read_int(data + (1 * 8))
                if event_hash == 1489206770 then
                    aboveMapToast($"{players.get_name(pid)} has collected BST", "Roothide", "", 2)
                end
            end
        end
    end, function()
        bst_detection_data = nil
    end)
    online:toggle_loop("Script Host Rotation", {"rotatesh"}, "Gives each player in the session script host sequentially, with a 20-second delay between each transfer. Useful if the session is broken.", function()
        for players.list() as pid do
            if players.exists(pid) then
                util.toast($"Giving script host to player: {players.get_name(pid)}")
                menu.trigger_commands($"givesh {players.get_name(pid)}")
                util.yield(20000)
            end
        end
    end)
    online:toggle_loop("Aggressive Script Host", {"scriptloop", "aggressivescripthost"}, "Constantly become the script host. This will break sessions.", function()
        if players.get_script_host() != players.user() then
            local playerName = players.get_name(players.user())
            menu.trigger_commands($"givesh {playerName}")
            util.toast("Becoming script host...")
            util.yield()
        end
    end)

-----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----
    -----Tʀᴀғғɪᴄ-----
        traffic:toggle_loop("Delete Modded Population Multipliers", {""}, "Deletes modded population multiplier areas that stand misses.", function()
            standNoModPopRef = menu.ref_by_path("Online>Protections>Delete Modded Pop Multiplier Areas", 55)
            if !standNoModPopRef.value then standNoModPopRef.value = true end
            for i = -1, 100 do
                if DOES_POP_MULTIPLIER_AREA_EXIST(i) then
                    if IS_POP_MULTIPLIER_AREA_NETWORKED(i) then
                        util.toast($"Found a Modded Pop Multiplier Area with ID: {i}... Removing...")
                    end
                    REMOVE_POP_MULTIPLIER_AREA(i, true)
                end
            end
        end, function()
            standNoModPopRef.value = false
        end)
        traffic:toggle("No Traffic", {}, "Clears traffic for all players by adding a networked population multiplier.", function(on)
            if on then
                CTpop_multiplier_id = ADD_POP_MULTIPLIER_SPHERE(1.1, 1.1, 1.1, 15000.0, 0.0, 0.0, false, true)
                CLEAR_AREA(1.1, 1.1, 1.1, 19999.9, true, false, false, true)
            else
                REMOVE_POP_MULTIPLIER_SPHERE(CTpop_multiplier_id, false)
                for i = -1, 100 do
                    if DOES_POP_MULTIPLIER_AREA_EXIST(i) then
                        REMOVE_POP_MULTIPLIER_AREA(i, true)
                    end
                end
            end
        end)
    -----EɴᴛɪᴛʏCᴏɴᴛʀᴏʟ-----
        local rqControlActive = false
        local rqControlPeds = true
        local rqControlVehicles = true
        local rqControlObjects = true
        local rqControlCanMigrate = false
        local rqControlThread = nil
        rqControlSettings:toggle("Control Entities", {"controlallentities"}, "Continuously attempts to gain control of entities within a 250 meter range. Excludes vehicles being driven by players. \n(Not Recommended)", function(on)
            if on then
                rqControlActive = true
                rqControlThread = util.create_thread(function() 
                    local canMigrateReset = {}
                    while rqControlActive do
                        local playerCoords = GET_ENTITY_COORDS(players.user_ped())
                        local entitiesToControl = {}
                        local allEntities = {}
                        if rqControlPeds then
                            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                                if !IS_PED_A_PLAYER(ped) then
                                    table.insert(allEntities, ped)
                                end
                            end
                        end
                        if rqControlVehicles then
                            for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
                                local driverPed = GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
                                if driverPed == 0 or !IS_PED_A_PLAYER(driverPed) then
                                    table.insert(allEntities, vehicle)
                                end
                            end
                        end
                        if rqControlObjects then
                            for _, object in pairs(entities.get_all_objects_as_handles()) do
                                table.insert(allEntities, object)
                            end
                        end
                        for _, entity in pairs(allEntities) do
                            local entityCoords = GET_ENTITY_COORDS(entity)
                            local distance = VDIST2(playerCoords.x, playerCoords.y, playerCoords.z, entityCoords.x, entityCoords.y, entityCoords.z)
                            if distance <= 62500.0 then
                                table.insert(entitiesToControl, entity)
                            end
                        end
                        for _, entity in pairs(entitiesToControl) do
                            if !NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                                NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                                util.yield(10)
                            end
                            if rqControlCanMigrate and NETWORK_HAS_CONTROL_OF_ENTITY(entity) and entities.get_can_migrate(entity) then
                                table.insert(canMigrateReset, entity)
                                entities.set_can_migrate(entity, false)
                            end
                        end
                        entitiesToControl = nil
                        allEntities = nil
                        util.yield(200)
                    end
                    for _, entity in pairs(canMigrateReset) do
                        entities.set_can_migrate(entity, true)
                    end
                    canMigrateReset = nil
                    util.yield()
                end)
            else
                rqControlActive = false
                if rqControlThread and util.is_scheduled_in(rqControlThread) then
                    util.shoot_thread(rqControlThread)
                    rqControlThread = nil
                end
            end
        end)
        rqControlSettings:divider("Settings")
        rqControlSettings:toggle("Peds", {}, "", function(value)
            rqControlPeds = value
        end, true)
        rqControlSettings:toggle("Vehicles", {}, "", function(value)
            rqControlVehicles = value
        end, true)
        rqControlSettings:toggle("Objects", {}, "", function(value)
            rqControlObjects = value
        end, true)
        rqControlSettings:toggle("Prevent Entity Ownership Changes", {}, "CAUTION: Using this can disrupt normal gameplay for other players. They will not be able to drive vehicles you control.", function(value)
            rqControlCanMigrate = value
        end)
    
    -----ᴄʟᴇᴀʀAʀᴇᴀOᴘᴛɪᴏɴs-----
        clearAreaOptions:textslider("Clear Area", {}, "", {"Peds", "Vehicles", "Objects", "Pickups", "Projectiles", "Sounds"}, function(index, name) --! ғʀᴏᴍ ᴊɪɴxsᴄʀɪᴘᴛ
            local counter = 0
            switch index do
                case 1:
                    for entities.get_all_peds_as_handles() as ped do
                        if ped != players.user_ped() and !IS_PED_A_PLAYER(ped) then
                            entities.delete_by_handle(ped)
                            counter += 1
                            util.yield()
                        end
                    end
                break
                case 2:
                    for entities.get_all_vehicles_as_handles() as vehicle do    
	    			local owner = entities.get_owner(vehicle)
                        if vehicle != GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and (owner == players.user() or owner == -1) then
                            entities.delete_by_handle(vehicle)
                            counter += 1
                        end
                        util.yield()
                    end
                break
                case 3:
                    for entities.get_all_objects_as_handles() as object do
                        entities.delete_by_handle(object)
                        counter += 1
                        util.yield()
                    end
                break
                case 4:
                    for entities.get_all_pickups_as_handles() as pickup do
                        entities.delete_by_handle(pickup)
                        counter += 1
                        util.yield()
                    end
                break
                case 5:
                    CLEAR_AREA_OF_PROJECTILES(players.get_position(players.user()), 1000.0, 0)
                    counter = "all"
                break
                case 6:
                    for i = -1, 99 do
                        STOP_SOUND(i)
                        util.yield()
                    end
                break
            end
            util.toast($"Cleared {tostring(counter)} {name:lower()}.")
        end)
        clearAreaOptions:action("Super Cleanse", {"supercleanse"}, "Instantly deletes EVERY entity it finds (including player vehicles!). \nIf control of entity cannot be obtained it will force deletion locally.", function(on_click)
            local counter = 0
            for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
                entities.delete(ent)
                counter = counter + 1
            end
            for k,ent in pairs(entities.get_all_peds_as_handles()) do
                if !IS_PED_A_PLAYER(ent) then
                    entities.delete(ent)
                end
                counter = counter + 1
            end
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                entities.delete(ent)
                counter = counter + 1
            end
            util.toast($"Super cleanse is complete! {counter} entities removed.")
        end)

-----Gᴀᴍᴇ Lɪsᴛ-----

-----Mɪsᴄ Lɪsᴛ-----
    -----ʙᴀsᴇʙᴀʟʟBᴀᴛ+KɴɪғᴇLɪᴠᴇʀɪᴇs-----
        --local originalGunVanValues = {}     
        --local function setGlobalsForSpecialLiveries()
        --    -- Sᴛᴏʀᴇ ᴛʜᴇ ᴏʀɪɢɪɴᴀʟ ᴠᴀʟᴜᴇs
        --    originalGunVanValues[34329] = memory.read_int(memory.script_global(262145 + 34329))
        --    originalGunVanValues[34330] = memory.read_int(memory.script_global(262145 + 34329 + 1))
        --
        --    for i = 25, 75 do
        --        originalGunVanValues[34331 + i] = memory.read_int(memory.script_global(262145 + 34331 + i))
        --    end
        --
        --    -- Sᴇᴛ ᴛʜᴇ ɴᴇᴡ ᴠᴀʟᴜᴇs (Cʀᴇᴅɪᴛ ᴛᴏ TᴏxɪᴋSᴋᴜʟʟ)
        --    memory.write_int(memory.script_global(262145 + 34329), 2508868239) --! PLACES KNIFE AND BAT INTO GUN VAN USING THEIR HASHES
        --    memory.write_int(memory.script_global(262145 + 34329 + 1), 2578778090)
        --
        --    for i = 25, 75 do
        --        memory.write_int(memory.script_global(262145 + 34331 + i), 0) --! ONE OF THESE ENABLES BAT & KNIFE LIVERIES LOL!
        --    end
        --end
        --local function restoreOriginalSpecialLiveriesGlobals()
        --    -- Rᴇsᴛᴏʀᴇ ᴛʜᴇ ᴏʀɪɢɪɴᴀʟ ᴠᴀʟᴜᴇs
        --    memory.write_int(memory.script_global(262145 + 34329), originalGunVanValues[34329])
        --    memory.write_int(memory.script_global(262145 + 34329 + 1), originalGunVanValues[34330])
        --
        --    for i = 25, 75 do
        --        memory.write_int(memory.script_global(262145 + 34331 + i), originalGunVanValues[34331 + i])
        --    end
        --end
        --misc:toggle("Unlock Baseball Bat & Knife Liveries For Purchase In GunVan", {}, "Temporarily unlocks liveries. Enable Before Going Into Gun Van Weapon Menu!\n!!!MAKE SURE YOU TURN OPTION OFF WHEN FINISHED!!!", function(on)
        --    if on then
        --        setGlobalsForSpecialLiveries()
        --    else
        --        restoreOriginalSpecialLiveriesGlobals()
        --    end
        --end)

-----DᴇᴠDʙɢ-----
    if devmode() then
        local debuglist = menu.list(roothide_menu, "Debug", {"rhdebug"}, "")
        debuglist:action("Restart Script", {"rs", "rhrs"}, "Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.", function()
            util.restart_script()
        end)
        debuglist:action("Log stand lang registered codes", {}, "", function()
            util.toast(lang.find_builtin("This command is only available in GTA Online."), TOAST_CONSOLE)
        end)
        debuglist:toggle_loop("Log Nearby Peds", {}, "50 Meters", function()
            local playerPed = players.user_ped()
            local playerPos = GET_ENTITY_COORDS(playerPed, false)
            for _, ped in ipairs(entities.get_all_peds_as_handles()) do
                if DOES_ENTITY_EXIST(ped) and ped != playerPed and !IS_PED_A_PLAYER(ped) then
                    local pedPos = GET_ENTITY_COORDS(ped, false)
                    local distance = VDIST(playerPos.x, playerPos.y, playerPos.z, pedPos.x, pedPos.y, pedPos.z)
                    if distance <= 50.0 then
                        util.log($"{ANSI.RED}[DEBUG]{ANSI.RESET} Nearby NPC - Distance: {distance}")
                    end
                end
            end
        end)
        require("lib.roothide.support")
        require("lib.roothide.dev")
    end

-----Sʜᴀᴅᴏᴡ Rᴏᴏᴛ-----
    local allPlayersTrolling = menu.ref_by_path("Players>All Players>Trolling", 55)
    -----ᴋɪᴄᴋAʟʟ-----
        local kickAll = menu.ref_by_path("Players>All Players", 55):getChildren()[1]:attachBefore(menu.shadow_root():list("Kick", {}, ""))
        kickAll:action("Kick All", {"kick"}, "Removes everyone that it can.", function()
            for _, pid in ipairs(players.list_except(true, false, false, false)) do --! Loop through all players except the user
                if players.get_host() == players.user() then --! If the user is the session host
                    playerRefTrigger(menu.player_root(pid), "Kick>Love Letter") --! Kick the player using the "Love Letter" method
                else --! If the user is not the session host
                    if players.get_host() != pid then --! If the player is not the host
                        if !players.is_marked_as_modder(pid) then
                            playerRefTrigger(menu.player_root(pid), "Kick>Smart") --! If the player is not marked as a modder, kick using the "Smart" method
                        else
                            playerRefTrigger(menu.player_root(pid), "Kick>Love Letter") --! If the player is marked as a modder, kick using the "Love Letter" method
                        end
                    else --! If the player is the host
                        if !players.is_marked_as_modder(pid) then --! If the host is not marked as a modder
                            playerRefTrigger(menu.player_root(pid), "Kick>Smart") --! Kick the host using the "Smart" method
                        end
                    end
                    util.yield(200) --! Wait for 200 milliseconds between each kick
                end
            end
        end)
        kickAll:action("Kick All Strangers", {}, "Removes all players not added as a friend.", function()
            for _, pid in ipairs(players.list_except(true, true, false, false)) do --! Loop through all players except the user and friends
                if players.get_host() == players.user() then --! If the user is the session host
                    playerRefTrigger(menu.player_root(pid), "Kick>Love Letter") --! Kick the player using the "Love Letter" method
                else --! If the user is not the session host
                    if players.get_host() != pid then --! If the player is not the host
                        if !players.is_marked_as_modder(pid) then
                            playerRefTrigger(menu.player_root(pid), "Kick>Smart") --! If the player is not marked as a modder, kick using the "Smart" method
                        else
                            playerRefTrigger(menu.player_root(pid), "Kick>Love Letter") --! If the player is marked as a modder, kick using the "Love Letter" method
                        end
                    else --! If the player is the host
                        if !players.is_marked_as_modder(pid) then --! If the host is not marked as a modder
                            playerRefTrigger(menu.player_root(pid), "Kick>Smart") --! Kick the host using the "Smart" method
                        end
                    end
                    util.yield(200) --! Wait for 200 milliseconds between each kick
                end
            end
        end)
    -----AllPlayers>Trolling-----
        allPlayersTrolling:action("Send Sext", {"sext"}, "Sends a random sext (with an image attachment) to the player.", function()
            local randomIndex = math.random(#sext)
            for players.list(false) as pid do
                util.trigger_script_event(1 << pid, sext[randomIndex])
            end
        end)

-----Pʟᴀʏᴇʀ Oᴘᴛɪᴏɴs-----
    players.add_command_hook(function(pid, player_root)
        local crashes_root = menu.ref_by_rel_path(menu.player_root(pid), "Crash")
        local kicks_root = menu.ref_by_rel_path(menu.player_root(pid), "Kick")
        
        local player_menu = player_root:list("Roothide")
        
        player_root:getChildren()[1]:attachBefore(menu.shadow_root():action("Spectate", {}, "Toggles 'Nuts Method' Spectate on the player.", function()
            playerRefTrigger(menu.player_root(pid), "Spectate>Nuts Method")
        end))

        kicks_root:action("Block Join Kick", {"bjk"}, "Kicks the player and blocks their join in player history.", function()
            if pid == players.user() then
                return util.toast(lang.get_localised(-1974706693))
            end
            local player = players.get_name(pid)
            menu.trigger_commands($"historyblock{player} on")
            aboveMapToastNoTitle($"Enabled block join for {player}. :)", 135)
            util.toast($"{ANSI.MAGENTA}Enabled block join for {player}. :){ANSI.RESET}", TOAST_CONSOLE)
            if players.get_host() == players.user() then
                playerRefTrigger(menu.player_root(pid), "Kick>Love Letter")
            else
                if players.is_marked_as_modder(pid) then
                    playerRefTrigger(menu.player_root(pid), "Kick>Love Letter")
                else
                    playerRefTrigger(menu.player_root(pid), "Kick>Smart")
                end
            end
        end)
        player_menu:action("LoveLetterKick Quick Access Command [llk player]", {"llk"}, "", function()
            playerRefTrigger(menu.player_root(pid), "Kick>Love Letter")
        end)
        player_menu:action("Set Waypoint", {"swp"}, "", function()
            local pos = players.get_position(pid)
            SET_NEW_WAYPOINT(pos.x, pos.y)
        end)
        local ghostPlayer
        ghostPlayer = player_menu:toggle_loop("Ghost Player", {"ghost"}, "Ghosts the selected player.", function()
            if pid == players.user() then
                util.toast(lang.get_localised(-1974706693))
                ghostPlayer.value = false
                return
            end
            if !players.exists(pid) then
                ghostPlayer.value = false
                return
            end
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        end, function()
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end)
        player_menu:action("Send Sext", {"sext"}, "Sends a random sext (with an image attachment) to all players.", function()
            local randomIndex = math.random(#sext)
            util.trigger_script_event(1 << pid, sext[randomIndex])
        end)
        
    end)

-----ᴄᴏɴsᴏʟᴇLᴏɢᴏ-----
local function applyGradient(text, Lcolours)
    local lines = {}
    for line in text:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    local colouredText = $"{lines[1]}\n"
    local colourCount = #Lcolours
    local lineCount = #lines - 1
    for i = 2, #lines do
        local colourIndex = math.floor((i - 2) / (lineCount - 1) * (colourCount - 1)) + 1
        colouredText = $"{colouredText}{Lcolours[colourIndex]}{lines[i]}{ANSI.RESET}\n"
    end
    return colouredText
end
if !SCRIPT_SILENT_START then util.toast(applyGradient(textLogo, gradientColours), TOAST_CONSOLE) end
if !SCRIPT_SILENT_START then util.toast($"{ANSI.DARK_GREEN}[Roothide]{ANSI.RESET} Natives loaded in {nativeRequireEndTime}ms", TOAST_CONSOLE) end
if !SCRIPT_SILENT_START then util.toast($"{ANSI.DARK_GREEN}[Roothide]{ANSI.RESET} Player History loaded in {phLoadTimeEnd}ms", TOAST_CONSOLE) end
if !SCRIPT_SILENT_START then util.toast($"{ANSI.DARK_GREEN}[Roothide]{ANSI.RESET} Script loaded in {(util.current_time_millis() - scriptStartTime)}ms", TOAST_CONSOLE) end
util.keep_running() --! Kᴇᴇᴘ ᴛʜᴇ sᴄʀɪᴘᴛ ʀᴜɴɴɪɴɢ
util.on_stop(function()
    cleanupAboveMapToasts()
end)
