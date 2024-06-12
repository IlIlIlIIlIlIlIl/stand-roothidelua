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

util.keep_running()
util.require_natives("3095a", "g")
local scriptStartTime = util.current_time_millis()

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
    -----Cᴏʟᴏᴜʀ Cᴏᴅᴇs----- https://talyian.github.io/ansicolors/    https://bixense.com/clicolors/
        local ANSI = {RED="\27[38;5;196m",DARK_RED="\27[38;5;160m",DARK_ORANGE="\27[38;5;202m",
        ORANGE="\27[38;5;208m",LIGHT_ORANGE="\27[38;5;214m",GOLD="\27[38;5;220m",YELLOW="\27[38;5;226m",
        LIGHT_YELLOW="\27[38;5;154m",LIGHT_GREEN="\27[38;5;82m",GREEN="\27[38;5;46m",DARK_GREEN="\27[38;5;34m",
        LIGHT_BLUE="\27[38;5;45m",BLUE="\27[38;5;21m",DARK_BLUE="\27[38;5;19m",LIGHT_CYAN="\27[38;5;87m",
        CYAN="\27[38;5;51m",DARK_CYAN="\27[38;5;30m",LIGHT_PURPLE="\27[38;5;177m",PURPLE="\27[38;5;93m",
        DARK_PURPLE="\27[38;5;55m",LIGHT_MAGENTA="\27[38;5;213m",MAGENTA="\27[38;5;201m",DARK_MAGENTA="\27[38;5;90m",
        LIGHT_PINK="\27[38;5;218m",PINK="\27[38;5;205m",DARK_PINK="\27[38;5;162m",LIGHT_BROWN="\27[38;5;137m",
        BROWN="\27[38;5;94m",DARK_BROWN="\27[38;5;52m",LIGHT_GREY="\27[38;5;250m",GREY="\27[38;5;244m",
        DARK_GREY="\27[38;5;236m",WHITE="\27[38;5;15m",RESET="\27[0m"}

-----𝑓ᴜɴᴄᴛɪᴏɴs​​​​​-----
    function devmode()
        local developer = {0x0C6E0653, 0x0EE24B30}
        local user = players.get_rockstar_id(players.user())
        for developer as id do
            if user == id then
                return true
            end
        end
        return false
    end
    function aboveMapToast(msg, title, subject, notificationColour, txrDictName, txrName)
        title = title or "Roothide"
        subject = subject or ""
        txrDictName = txrDictName or "CHAR_MP_FM_CONTACT"
        txrName = txrName or "CHAR_MP_FM_CONTACT"  -- https://wiki.rage.mp/index.php?title=Notification_Pictures
        notificationColour = notificationColour or 69 -- https://docs.fivem.net/docs/game-references/hud-colors/
        THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
        util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
        END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(txrDictName, txrName, true, 1, title, subject)
        END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
    end
    function aboveMapToastRequestTxr(msg, title, subject, notificationColour, txrDictName, txrName)
        title = title or "Roothide"
        subject = subject or ""
        txrDictName = txrDictName or "CHAR_MP_FM_CONTACT"
        txrName = txrName or "CHAR_MP_FM_CONTACT"  -- https://wiki.rage.mp/index.php?title=Notification_Pictures
        notificationColour = notificationColour or 69 -- https://docs.fivem.net/docs/game-references/hud-colors/
        THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
        REQUEST_STREAMED_TEXTURE_DICT(txrDictName, false)
        while not HAS_STREAMED_TEXTURE_DICT_LOADED(txrDictName) do
            util.yield()
        end
        util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
        END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(txrDictName, txrName, true, 1, title, subject)
        END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
        SET_STREAMED_TEXTURE_DICT_AS_NO_LONGER_NEEDED(txrDictName)
    end
    function luaStats(player_name)
        async_http.init("https://spectrum-oceanic-radish.glitch.me", "/")
        async_http.set_post("application/json", string.format('{"player_name": "%s"}', player_name))
        async_http.dispatch()
    end

-----Aᴜᴛᴏ Uᴘᴅᴀᴛᴇʀ​​​​​-----
    util.ensure_package_is_installed("lua/auto-updater")
    local auto_updater = require("auto-updater")
    local auto_update_config = {
        source_url="https://raw.githubusercontent.com/IlIlIlIIlIlIlIl/stand-roothidelua/main/Roothide.lua",
        script_relpath=SCRIPT_RELPATH
    }
    if async_http.have_access() then
        if !devmode() then
            if auto_updater.run_auto_update(auto_update_config) then
                util.toast("No updates found. You are already running the latest version.")
            end
        else
            util.toast(ANSI.YELLOW .. "[Roothide] \x1b[0;30;42mDev Mode Enabled" .. ANSI.RESET, TOAST_CONSOLE)
        end
        luaStats(players.get_name(players.user()))
    else
        aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the `Disable Internet Access` option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
    end

-----Mᴇɴᴜ Sᴇᴛᴜᴘ-----

    local roothide_menu = menu.attach_before(menu.ref_by_path("Stand>Settings"), menu.list(menu.shadow_root(), "Roothide", {"roothidescript"}, "Roothide Script"))
    roothide_menu:action("Stop Script", {}, "Stop the script.", function()
        menu.focus(menu.ref_by_path("Stand>Lua Scripts>" .. SCRIPT_NAME .. ">Stop Script"))
        util.stop_script()
    end)
    menu.action(menu.my_root(), "Go To Script Menu", {}, "Go to the scripts main menu", function()
        menu.ref_by_path("Stand>Roothide"):trigger()
    end)
    menu.action(menu.my_root(), "Check for Updates", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
        if async_http.have_access() then
            auto_update_config.check_interval = 0
            util.toast("Checking for updates")
            if auto_updater.run_auto_update(auto_update_config) then
                util.toast("No updates found. You are already running the latest version.")
            end
        else
            aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the `Disable Internet Access` option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
        end
    end)
    if SCRIPT_MANUAL_START then
        menu.ref_by_path("Stand>Roothide"):trigger()
        PLAY_SOUND_FRONTEND(-1, "SPAWN", "BARRY_01_SOUNDSET", true)
    end

-----Mᴇɴᴜ Rᴏᴏᴛ-----

    local selfList = menu.list(roothide_menu, "Self", {}, "")
    local vehicleOptions = menu.list(roothide_menu, "Vehicle", {}, "")
    local online = menu.list(roothide_menu, "Online", {}, "")
    local world = menu.list(roothide_menu, "World", {}, "")
    --local game = menu.list(roothide_menu, "Game", {}, "")
    local misc = menu.list(roothide_menu, "Misc", {}, "")
    roothide_menu:action("Check for Updates", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
        if async_http.have_access() then
            auto_update_config.check_interval = 0
            util.toast("Checking for updates")
            if auto_updater.run_auto_update(auto_update_config) then
                util.toast("No updates found. You are already running the latest version.")
            end
        else
            aboveMapToastRequestTxr("This Script needs Internet Access for the Auto Updater to work! Please stop the script and uncheck the `Disable Internet Access` option.", "Roothide", "~u~Auto-Updater", 6, "CHAR_BLOCKED", "CHAR_BLOCKED")
        end
    end)

-----Cʜɪʟᴅ Lɪsᴛs-----
    -----Sᴇʟғ Lɪsᴛ-----
        local weapons = selfList:list("Weapons", {}, "")
    -----Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs Lɪsᴛ---​​​​--
        local seatSwitcher = vehicleOptions:list("Switch Seat", {"switchseat", "seatswitch"}, "")
    -----Oɴʟɪɴᴇ Lɪsᴛ-----
        local protections = online:list("Protections",{"rhprotections"}, "")
        local chatList = online:list("Chat Options", {}, "")
    -----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----
        local traffic = world:list("Traffic", {}, "")    
        local clearAreaOptions = world:list("Clear Area Options", {}, "")

-----Sᴇʟғ Lɪsᴛ-----

    -----ᴡᴇᴀᴘᴏɴs-----
        -----sɴɪᴘᴇʀZᴏᴏᴍ-----
            local sniper_hashes = {
                100416529,  -- Sɴɪᴘᴇʀ Rɪғʟᴇ
                205991906,  -- Hᴇᴀᴠʏ Sɴɪᴘᴇʀ
                177293209   -- Hᴇᴀᴠʏ Sɴɪᴘᴇʀ MK2
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
                        if IS_CONTROL_JUST_PRESSED(2, 43) then -- INPUT_SNIPER_ZOOM_OUT_SECONDARY
                            zoomOut_pressed_value = true
                        end
                        if !zoomOut_pressed_value then
                            SET_FIRST_PERSON_AIM_CAM_ZOOM_FACTOR(6.0) -- Sᴇᴛ ᴛʜᴇ ᴢᴏᴏᴍ ʟᴇᴠᴇʟ ᴛᴏ ᴍᴀxɪᴍᴜᴍ
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
                        if IS_CONTROL_JUST_PRESSED(2, 43) then -- INPUT_SNIPER_ZOOM_OUT_SECONDARY
                            zoomOut_pressed_value = true
                        end
                        if !zoomOut_pressed_value then
                            SET_CONTROL_VALUE_NEXT_FRAME(2, 42, 1.0)  -- Sɪᴍᴜʟᴀᴛᴇ ʜᴏʟᴅɪɴɢ ᴛʜᴇ ᴋᴇʏ ᴛᴏ ᴢᴏᴏᴍ ɪɴ
                        end
                    else
                        zoomOut_pressed_value = false
                    end
                else
                    zoomOut_pressed_value = false
                end
            end)
    selfList:toggle_loop("True No Ragdoll", {}, "Speeds up getting up after being knocked down.", function()
        SET_PED_CONFIG_FLAG(players.user_ped(), 227, IS_PLAYER_PLAYING(players.user()))
    end)

-----Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs Lɪsᴛ---​​​​--

    -----sᴇᴀᴛSᴡɪᴛᴄʜᴇʀ-----
        seatRef = seatSwitcher:action("Driver Seat", {"seatdriver"}, "Warp into driver seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), -1)end)
        seatRef0 = seatSwitcher:action("Passenger Seat", {"seatpassenger"}, "Warp into passenger seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 0)end)
        seatSwitcher:toggle("Prevent Auto Seat Shuffle", {"noshuffle"}, "Prevents auto shuffling over to drivers seat if it becomes free.", function(toggled)
            SET_PED_CONFIG_FLAG(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 184, toggled)end)
        seatRef1 = seatSwitcher:action("Left Rear", {}, "Warp into rear left seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 1)end)
        seatRef2 = seatSwitcher:action("Right Rear", {}, "Warp into rear right seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 2)end)
        local seatIndices = {3, 4, 5, 6, 7}
        local seatLabels = {"Seat 5", "Seat 6", "Seat 7", "Seat 8", "Seat 9"}
        seatSwitcher:textslider_stateful("Other Seats", {}, "For anything larger than 4 seats", seatLabels, function(index, value)
            local selectedSeatIndex = seatIndices[index]
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), selectedSeatIndex)
        end)
    vehicleOptions:toggle_loop("Engine Always On", {"alwayson"}, "Keeps the engine and lights running when you exit the vehicle.", function()
        local vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID(), false)
        if DOES_ENTITY_EXIST(vehicle) then
            SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
            SET_VEHICLE_LIGHTS(vehicle, 0)
        end
    end)
    local last_vehicle_with_radio_off = 0
    vehicleOptions:toggle_loop("Turn Radio Off Automatically", {}, "Turns off the radio each time you get in a vehicle.", function()
        local current_vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID(), false)
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
            for filesystem.list_files(dir) as file do
                if filesystem.is_dir(file) then
                    for get_all_vehicles(file) as subfile do
                        table.insert(paths, subfile)
                    end
                else
                    if string.sub(file, -4) == ".txt" then
                        table.insert(paths, file)
                    end
                end
            end
            return paths
        end
        local function vehicle_path_to_stand_ref(path)
            return menu.ref_by_path("Vehicle>Garage>" .. string.gsub(string.sub(string.sub(path, -((#path) - (#(filesystem.stand_dir() .. [[Vehicles\]])))), 1, -5), "\\", ">"))
        end
        vehicleOptions:action("Random Stand Garage Vehicle", {"randomvehicle", "rv"}, "Picks a random vehicle from your Stand garage.", function()
            local vehicles_dir = filesystem.stand_dir() .. "Vehicles"
            local all_vehicles = get_all_vehicles(vehicles_dir)
            local random_vehicle = all_vehicles[math.random(#all_vehicles)]
            local stand_ref = vehicle_path_to_stand_ref(random_vehicle)
            menu.focus(stand_ref)
        end)

-----Oɴʟɪɴᴇ Lɪsᴛ-----

    -----Pʀᴏᴛᴇᴄᴛɪᴏɴs-----
        protections:action("Stop All Sounds", {"stopsounds"}, "", function()
            for i = -1,100 do
                STOP_SOUND(i)
            end
            util.toast("Stopped Sounds.")
        end)
    -----ᴄʜᴀᴛLɪsᴛ-----
        -----ᴄᴏᴍᴍᴀɴᴅBᴏxCʜᴀᴛ-----
            local commandBoxChat = chatList:list("Command Box Chat")
            local toggleChatHistory = menu.ref_by_path("Online>Chat>Always Open")
            local disableChatInputAll = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_ALL")
            local disableChatInputTeam = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_TEAM")
            local showTyping
            commandBoxChat:toggle_loop("Command Box Chat", {""}, "Use the command box to chat. Useful if chat is not opening when pressing 'T'. This option disables the in game chat box to fix crashing issues when co-loading cherax and typing in chat.", function()
                disableChatInputAll.value = true
                disableChatInputTeam.value = true
                if !menu.command_box_is_open() then
                    if util.is_key_down(0x54) and !IS_SYSTEM_UI_BEING_DISPLAYED() then -- Kᴇʏ 'T'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) -- Sᴛᴀʀᴛ Tʏᴘɪɴɢ
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
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) -- Sᴛᴏᴘ Tʏᴘɪɴɢ
                                end
                            end
                            util.yield()
                        end
                    elseif util.is_key_down(0x59) and !IS_SYSTEM_UI_BEING_DISPLAYED() then -- Kᴇʏ 'Y'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) -- Sᴛᴀʀᴛ Tʏᴘɪɴɢ
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
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) -- Sᴛᴏᴘ Tʏᴘɪɴɢ
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
            showTyping = commandBoxChat:toggle("Show typing", {"showtyping"}, "Should other players see if you are typing?", function()end)
            showTyping.value = true
            gMsgHidden = commandBoxChat:action("Send a Global Message", {"globalmessage", "gmsg"}, "", function(click_type)
                menu.show_command_box($"gmsg "); end, function(input)
                chat.send_message(input, false, true, true)
            end)
            tMsgHidden = commandBoxChat:action("Send a Team Message", {"teammessage", "tmsg"}, "", function(click_type)
                menu.show_command_box($"tmsg "); end, function(input)
                chat.send_message(input, true, true, true)
            end)
            menu.set_visible(gMsgHidden, false)
            menu.set_visible(tMsgHidden, false)
        -----ʟᴏɢCʜᴀᴛ-----
            local logChatEnabled = false
            local function onChatMessage(sender, reserved, text, team_chat, networked, is_auto)
                if logChatEnabled then
                    local playerName = players.get_name(sender)
                    local logColour = team_chat and ANSI.GREEN or ANSI.YELLOW
                    local logChatMessage = logColour .. playerName .. " [" .. (team_chat and "TEAM" or "ALL") .. "] " .. text .. ANSI.RESET
                    util.toast(logChatMessage, TOAST_CONSOLE)
                end
            end
            chat.on_message(onChatMessage)
            chatList:toggle("Log Chat To Console With Coloured Text", {}, "Restart script if chat is not coloured in console.", function(on)
                if !menu.ref_by_path("Stand>Console").value then
                    util.toast("Enabled Stand Console At 'Stand > Console'.")
                    menu.ref_by_path("Stand>Console").value = true
                end
                logChatEnabled = on
            end)
    local showspeakerson = online:toggle_loop("Show speakers", {"showspeakers"}, "Accurately shows who is talking in voice chat as soon as it happens. Better than vanilla. The speakers name will be shown in stands info overlay for easy visibility.", function()
        for players.list() as pid do
            if NETWORK_IS_PLAYER_TALKING(pid) then
                util.draw_debug_text(players.get_name(pid) .. " is talking")
            end
        end
    end)
    showspeakerson.value = true
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
    online:toggle_loop("Script Host Rotation", {"rotatesh"}, "Gives each player in the session script host sequentially, with a 20-second delay between each transfer.", function()
        for _, pid in ipairs(players.list()) do
            if players.exists(pid) then
                util.toast("Giving script host to player: " .. players.get_name(pid))
                menu.trigger_commands("givesh" .. players.get_name(pid))
                util.yield(20000)
            end
        end
    end)
    online:toggle_loop("Aggressive Script Host", {"scriptloop", "aggressivescripthost"}, "Constantly become the script host. This will break sessions.", function()
        if players.get_script_host() != players.user() then
            local playerName = players.get_name(players.user())
            menu.trigger_commands("givesh " .. playerName)
            util.toast("Becoming script host...")
            util.yield_once()
        end
    end)

-----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----

    -----Tʀᴀғғɪᴄ-----
    traffic:toggle_loop("Delete Modded Population Multipliers", {""}, "Deletes modded population multiplier areas that stand misses.", function()
        standNoModPopRef = menu.ref_by_path("Online>Protections>Delete Modded Pop Multiplier Areas")
        if !standNoModPopRef.value then standNoModPopRef.value = true end
        for i = 0, 15 do
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
            CTped_sphere = 0.0
            CTtraffic_sphere = 0.0
            CTpop_multiplier_id = ADD_POP_MULTIPLIER_SPHERE(1.1, 1.1, 1.1, 15000.0, CTped_sphere, CTtraffic_sphere, false, true)
            CLEAR_AREA(1.1, 1.1, 1.1, 19999.9, true, false, false, true)
        else
            REMOVE_POP_MULTIPLIER_SPHERE(CTpop_multiplier_id, false);
        end
    end)
    -----ᴄʟᴇᴀʀAʀᴇᴀOᴘᴛɪᴏɴs-----
        clearAreaOptions:textslider("Clear Area", {}, "", {"Peds", "Vehicles", "Objects", "Pickups", "Projectiles", "Sounds"}, function(index, name) -- ғʀᴏᴍ ᴊɪɴxsᴄʀɪᴘᴛ
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
            util.toast("Super cleanse is complete! " .. counter .. " entities removed.")
        end)

-----Gᴀᴍᴇ Lɪsᴛ-----

-----Mɪsᴄ Lɪsᴛ-----

    -----ʙᴀsᴇʙᴀʟʟBᴀᴛ+KɴɪғᴇLɪᴠᴇʀɪᴇs-----
        local originalGunVanValues = {}     
        local function setGlobalsForSpecialLiveries()
            -- Sᴛᴏʀᴇ ᴛʜᴇ ᴏʀɪɢɪɴᴀʟ ᴠᴀʟᴜᴇs
            originalGunVanValues[34329] = memory.read_int(memory.script_global(262145 + 34329))
            originalGunVanValues[34330] = memory.read_int(memory.script_global(262145 + 34329 + 1))
        
            for i = 25, 75 do
                originalGunVanValues[34331 + i] = memory.read_int(memory.script_global(262145 + 34331 + i))
            end
        
            -- Sᴇᴛ ᴛʜᴇ ɴᴇᴡ ᴠᴀʟᴜᴇs (Cʀᴇᴅɪᴛ ᴛᴏ TᴏxɪᴋSᴋᴜʟʟ)
            memory.write_int(memory.script_global(262145 + 34329), 2508868239) -- PLACES KNIFE AND BAT INTO GUN VAN USING THEIR HASHES
            memory.write_int(memory.script_global(262145 + 34329 + 1), 2578778090)
        
            for i = 25, 75 do
                memory.write_int(memory.script_global(262145 + 34331 + i), 0) -- ONE OF THESE ENABLES BAT & KNIFE LIVERIES LOL!
            end
        end
        local function restoreOriginalSpecialLiveriesGlobals()
            -- Rᴇsᴛᴏʀᴇ ᴛʜᴇ ᴏʀɪɢɪɴᴀʟ ᴠᴀʟᴜᴇs
            memory.write_int(memory.script_global(262145 + 34329), originalGunVanValues[34329])
            memory.write_int(memory.script_global(262145 + 34329 + 1), originalGunVanValues[34330])
        
            for i = 25, 75 do
                memory.write_int(memory.script_global(262145 + 34331 + i), originalGunVanValues[34331 + i])
            end
        end
        misc:toggle("Unlock Baseball Bat & Knife Liveries For Purchase In GunVan", {}, "Temporarily unlocks liveries. Enable Before Going Into Gun Van Weapon Menu!\n!!!MAKE SURE YOU TURN OPTION OFF WHEN FINISHED!!!", function(on)
            if on then
                setGlobalsForSpecialLiveries()
            else
                restoreOriginalSpecialLiveriesGlobals()
            end
        end)

-----DᴇᴠDʙɢ-----

    if devmode() then
        local debuglist = menu.list(roothide_menu, "Debug", {"rhdebug"}, "")

        debuglist:action("Restart Script", {}, "Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.", function()
            util.restart_script()
        end)
        debuglist:action("Log stand lang registered codes", {}, "", function()
            util.toast(lang.find_builtin("Movement"), TOAST_CONSOLE)
        end)
        local libDir = filesystem.scripts_dir() .. "lib\\roothide\\"
            dofile(libDir .. "support.pluto")
            dofile(libDir .. "dev.pluto")

    end

-----Sʜᴀᴅᴏᴡ Rᴏᴏᴛ-----
    -----ᴋɪᴄᴋAʟʟ-----
        local kickAll = menu.ref_by_path("Players>All Players"):getChildren()[1]:attachBefore(menu.shadow_root():list("Kick", {}, ""))
        kickAll:action("Kick All", {"kickall"}, "Removes everyone that it can.", function()
            for _, pid in ipairs(players.list_except(true, false, false, false)) do -- Loop through all players except the user
                if players.get_host() == players.user() then -- If the user is the session host
                    menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger() -- Kick the player using the "Love Letter" method
                else -- If the user is not the session host
                    if players.get_host() != pid then -- If the player is not the host
                        if !players.is_marked_as_modder(pid) then
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger() -- If the player is not marked as a modder, kick using the "Smart" method
                        else
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger() -- If the player is marked as a modder, kick using the "Love Letter" method
                        end
                    else -- If the player is the host
                        if !players.is_marked_as_modder(pid) then -- If the host is not marked as a modder
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger() -- Kick the host using the "Smart" method
                        end
                    end
                end
                util.yield(200) -- Wait for 200 milliseconds between each kick
            end
        end)
        kickAll:action("Kick All Strangers", {}, "Removes all players not added as a friend.", function()
            for _, pid in ipairs(players.list_except(true, true, false, false)) do -- Loop through all players except the user and friends
                if players.get_host() == players.user() then -- If the user is the session host
                    menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger() -- Kick the player using the "Love Letter" method
                else -- If the user is not the session host
                    if players.get_host() != pid then -- If the player is not the host
                        if !players.is_marked_as_modder(pid) then
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger() -- If the player is not marked as a modder, kick using the "Smart" method
                        else
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger() -- If the player is marked as a modder, kick using the "Love Letter" method
                        end
                    else -- If the player is the host
                        if !players.is_marked_as_modder(pid) then -- If the host is not marked as a modder
                            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger() -- Kick the host using the "Smart" method
                        end
                    end
                end
                util.yield(200) -- Wait for 200 milliseconds between each kick
            end
        end)

-----Pʟᴀʏᴇʀ Oᴘᴛɪᴏɴs-----

    local function handlePlayerOptions(pid)
        player_root = menu.player_root(pid)
        crashes_root = menu.ref_by_rel_path(menu.player_root(pid), "Crash")
        player_menu = player_root:list("Roothide")
        misc_list = player_menu:list("Misc")
        
        player_root:getChildren()[1]:attachBefore(menu.shadow_root():action("Spectate", {}, "Toggles 'Nuts Method' Spectate on the player.", function()
            menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"):trigger()
        end))


        crashes_root:getChildren()[4]:attachAfter(menu.shadow_root():action("ScriptEvent Crash", {}, "Funny scriptevent", function()
            if pid == players.user() then return util.toast(lang.get_localised(-1974706693)) end
            menu.ref_by_rel_path(menu.player_root(pid), "Friendly>Give Script Host"):trigger()
            util.yield(1000)
            if players.get_script_host() != pid then return end
            util.trigger_script_event(1 << pid, {323285304, players.user(), 2147483647, 0, 0, 0, 2147483647, -1008861746})
            util.yield(250)
            util.trigger_script_event(1 << pid, {-1604421397, players.user(), 2, 0, 0, 0, 0, 0})
        end))
        crashes_root:getChildren()[5]:attachAfter(menu.shadow_root():action("ScriptEvent v2 Crash", {"se2", "sc2", "script2"}, "Funny Scriptevent v2", function()
            if pid == players.user() then return util.toast(lang.get_localised(-1974706693)) end
            menu.ref_by_rel_path(menu.player_root(pid), "Friendly>Give Script Host"):trigger()
            util.yield(1000)
            if players.get_script_host() != pid then return end
            util.trigger_script_event(1 << pid, {323285304, players.user(), -4640169, 0, 0, 0, -36565476, -53105203})
            util.yield(250)
            util.trigger_script_event(1 << pid, {323285304, players.user(), 2147483647, 0, 0, 0, 2147483647, -1008861746})
        end))
        misc_list:action("LoveLetterKick Quick Access Command", {"llk"}, "", function()
            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger()
        end)
        misc_list:action("Set Waypoint", {"swp"}, "", function()
            local pos = players.get_position(pid)
            SET_NEW_WAYPOINT(pos.x, pos.y)
        end)
        local ghostPlayer
        ghostPlayer = misc_list:toggle_loop("Ghost Player", {"ghost"}, "Ghosts the selected player.", function()
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


    end
    players.add_command_hook(handlePlayerOptions)

-----ᴄᴏɴsᴏʟᴇLᴏɢᴏ-----
    local gradientColours = {
        "\x1b[38;5;196m", -- Red
        "\x1b[38;5;160m", -- Dark Red
        "\x1b[38;5;202m", -- Dark Orange
        "\x1b[38;5;208m", -- Orange
        "\x1b[38;5;214m", -- Light Orange
        "\x1b[38;5;220m", -- Gold
        "\x1b[38;5;226m", -- Yellow
        "\x1b[38;5;154m", -- Light Yellow
        "\x1b[38;5;82m",  -- Light Green
        "\x1b[38;5;46m",  -- Green
        "\x1b[38;5;34m",  -- Dark Green
    }
    local textLogo = [[ 
     ..      ...                                  s                   .       ..                  
  :~"8888x :"%888x                               :8      .uef^"      @88>   dF                    
 8    8888Xf  8888>         u.          u.      .88    :d88E         %8P   '88bu.                 
X88x. ?8888k  8888X   ...ue888b   ...ue888b    :888ooo `888E          .    '*88888bu        .u    
'8888L'8888X  '%88X   888R Y888r  888R Y888r -*8888888  888E .z8k   .@88u    ^"*8888N    ud8888.  
 "888X 8888X:xnHH(``  888R I888>  888R I888>   8888     888E~?888L ''888E`  beWE "888L :888'8888. 
   ?8~ 8888X X8888    888R I888>  888R I888>   8888     888E  888E   888E   888E  888E d888 '88%" 
 -~`   8888> X8888    888R I888>  888R I888>   8888     888E  888E   888E   888E  888E 8888.+"    
 :H8x  8888  X8888   u8888cJ888  u8888cJ888   .8888Lu=  888E  888E   888E   888E  888F 8888L      
 8888> 888~  X8888    "*888*P"    "*888*P"    ^%888*    888E  888E   888&  .888N..888  '8888c. .+ 
 48"` '8*~   `8888!`    'Y"         'Y"         'Y"    m888N= 888>   R888"  `"888*""    "88888%   
  ^-==""      `""                                       `Y"   888     ""       ""         "YP'    
                                                             J88"                                 
                                                             @%                                   
                                                           :"                                     
]]
    local function applyGradient(text, Lcolours)
        local lines = {}
        for line in text:gmatch("[^\r\n]+") do
            table.insert(lines, line)
        end
        local colouredText = lines[1] .. "\n"
        local colourCount = #Lcolours
        local lineCount = #lines - 1
        for i = 2, #lines do
            local colourIndex = math.floor((i - 2) / (lineCount - 1) * (colourCount - 1)) + 1
            colouredText = colouredText .. Lcolours[colourIndex] .. lines[i] .. ANSI.RESET .. "\n"
        end

        return colouredText
    end
    local gradientTextLogo = applyGradient(textLogo, gradientColours)
    if !SCRIPT_SILENT_START then util.toast(gradientTextLogo, TOAST_CONSOLE) end
if !SCRIPT_SILENT_START then util.toast(string.format(ANSI.DARK_GREEN .. "[Roothide]" .. ANSI.RESET .. " Script loaded in %dms", util.current_time_millis() - scriptStartTime), TOAST_CONSOLE) end
