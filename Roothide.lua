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

--Enable colours in Console
util.ensure_package_is_installed("lua/luaffi")
local ffi = require "luaffi"
local kernel32 = ffi.open("kernel32")
$define STD_OUTPUT_HANDLE = -11
$define INVALID_HANDLE_VALUE = -1
$define ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x4
local hSTDOUT = kernel32:call("GetStdHandle", STD_OUTPUT_HANDLE)
if hSTDOUT ~= INVALID_HANDLE_VALUE then
    local mode = memory.alloc_int()
    if kernel32:call("GetConsoleMode", hSTDOUT, mode) ~= 0 then
        kernel32:call("SetConsoleMode", hSTDOUT, memory.read_int(mode) | ENABLE_VIRTUAL_TERMINAL_PROCESSING)
    end
end
local ANSI_RESET = "\x1b[0m" -- Reset to default colour
local ANSI_YELLOW = "\x1b[0;33m" -- Yellow Colour Code
local ANSI_GREEN = "\x1b[1;32m" -- Green Colour Code
local ANSI_RED = "\x1b[0;31m" -- Red Colour Code

--Functions
local function devmode()
    local developer = {0x0C6E0653, 0x0EE24B30}
    local user = players.get_rockstar_id(players.user())
    for developer as id do
        if user == id then
            return true
        end
    end
    return false
end
local function aboveMapToast(msg, title, subject, notificationColour, dict, dictName) -- credit to wiriscript
    title = title or 'Roothide'
    subject = subject or ''
    dict = dict or 'CHAR_MP_FM_CONTACT'
    dictName = dictName or 'CHAR_MP_FM_CONTACT'
    notificationColour = notificationColour or 2

    THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(notificationColour)
    util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
    END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(dict, dictName, true, 7, title, subject)
    END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
end

--Auto Updater
util.ensure_package_is_installed("lua/auto-updater")
local auto_updater = require("auto-updater")
local auto_update_config = {
    source_url="https://raw.githubusercontent.com/IlIlIlIIlIlIlIl/stand-roothidelua/main/Roothide.lua",
    script_relpath=SCRIPT_RELPATH
}
if async_http.have_access() then
    if not devmode() then
        auto_updater.run_auto_update(auto_update_config)
    else
        util.toast("\x1B[1;35m[Roothide] \x1B[0;30;42mDev Mode Enabled\x1B[0m", TOAST_CONSOLE)
    end
else
    util.toast("This Script needs Internet Access for the Auto Updater to work!")
end

-----Mᴇɴᴜ Sᴇᴛᴜᴘ-----

    local roothide_menu = menu.attach_before(menu.ref_by_path("Stand>Settings"), menu.list(menu.shadow_root(), "Roothide", {"roothidescript"}, "Roothide Script"))
    roothide_menu:action("Stop Script", {}, "Stop the script.", function()
        util.stop_script()
    end)
    menu.action(menu.my_root(), "Go To Script Menu", {}, "Go to the scripts main menu", function()
        menu.ref_by_path("Stand>Roothide"):trigger()
    end)
    menu.action(menu.my_root(), "Check for Updates", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
        auto_update_config.check_interval = 0
        util.toast("Checking for updates")
        if auto_updater.run_auto_update(auto_update_config) then
            util.toast("No updates have been found.")
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
        auto_update_config.check_interval = 0
        util.toast("Checking for updates")
        if auto_updater.run_auto_update(auto_update_config) then
            util.toast("No updates have been found.")
        end
    end)

-----Cʜɪʟᴅ Lɪsᴛs-----
    -----Sᴇʟғ Lɪsᴛ-----
        local weapons = selfList:list("Weapons", {}, "")
    -----Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs Lɪsᴛ---​​​​--
        local seatSwitcher = vehicleOptions:list("Switch Seat", {"switchseat", "seatswitch"}, "")
    -----Oɴʟɪɴᴇ Lɪsᴛ-----
        local protections = online:list("Protections",{"rhprotections"}, "")
        local traffic = online:list("Traffic", {}, "")
        local ChatList = online:list("Chat Options", {}, "")
        local kickAll = online:list("Kick All Options", {}, "")
    -----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----
        local clearAreaOptions = world:list("Clear Area Options", {}, "")

-----Sᴇʟғ Lɪsᴛ-----
    
    -----weapons-----
        -----sniperZoom-----
            local sniper_hashes = {
                100416529,  -- Sniper Rifle
                205991906,  -- Heavy Sniper
                177293209   -- Heavy Sniper MK2
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
                        if not zoomOut_pressed_value then
                            SET_FIRST_PERSON_AIM_CAM_ZOOM_FACTOR(6.0) -- Set the zoom level to maximum
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
                        if not zoomOut_pressed_value then
                            SET_CONTROL_VALUE_NEXT_FRAME(2, 42, 1.0)  -- Simulate holding the key to zoom in
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

    -----seatSwitcher-----
        seatSwitcher:action("Driver Seat", {"seatdriver"}, "Warp into driver seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), -1)end)
        seatSwitcher:action("Passenger Seat", {"seatpassenger"}, "Warp into passenger seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 0)end)
        seatSwitcher:toggle("Prevent Auto Seat Shuffle", {"noshuffle"}, "Prevents auto shuffling over to drivers seat if it becomes free.", function(toggled)
            SET_PED_CONFIG_FLAG(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 184, toggled)end)
        seatSwitcher:action("Left Rear", {}, "Warp into rear left seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 1)end)
        seatSwitcher:action("Right Rear", {}, "Warp into rear right seat.", function()
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 2)end)
        local seatIndices = {3, 4, 5, 6, 7}
        local seatLabels = {"Seat 5", "Seat 6", "Seat 7", "Seat 8", "Seat 9"}
        seatSwitcher:textslider_stateful("Other Seats", {}, "For anything larger than 4 seats", seatLabels, function(index, value)
            local selectedSeatIndex = seatIndices[index]
            SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), selectedSeatIndex)
        end)
    
    -----vehfly-----
    --function flyVehicle(speed)
    --    local player = players.user_ped()
    --    local vehicle = GET_VEHICLE_PED_IS_IN(player, false)
    --    if IS_PED_IN_VEHICLE(player, vehicle, false) == false then return end
    --    if NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) == false then return end
    --    local rotation = GET_ENTITY_ROTATION(vehicle, 2)
    --    local currentSpeed = GET_ENTITY_SPEED(vehicle) * 4.2
    --    local currentSpeedInt = math.floor(currentSpeed)
    --    -- Key bindings and control checks
    --    if IS_CONTROL_PRESSED(0, 209) then  -- LEFT SHIFT or L3
    --        local entitySpeed = GET_ENTITY_SPEED(vehicle)
    --        local newSpeed = entitySpeed + ((speed * 50) / 100)
    --        SET_VEHICLE_FORWARD_SPEED(vehicle, math.min(newSpeed, speed * 50))
    --    end
    --    if PAD.IS_CONTROL_PRESSED(0, 61) then  -- NUMPAD7
    --        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 50)
    --    end
    --    if PAD.IS_CONTROL_PRESSED(0, 76) or PAD.IS_CONTROL_PRESSED(0, 210) then  
    --        ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 0)
    --    end
    --    
    --    
    --    
    --    
    --end
    --vehicleOptions:action("test", {}, "", function()
    --    flyVehicle()
    --end)
    
    --impulse code
    --void FlyVehicle(float speed) {
	--	GetEntityControl()->SimpleRequestControl(GetLocalPlayer().m_vehicle);
	--	if (KeyDown(VK_NUMPAD9) || PAD::IsControlPressed(0, INPUT_FRONTEND_RT)) {
	--		float entitySpeed = ENTITY::GetEntitySpeed(GetLocalPlayer().m_vehicle);
	--		VEHICLE::SetVehicleForwardSpeed(GetLocalPlayer().m_vehicle, entitySpeed + ((speed * 50) / 100) < speed * 50 ? entitySpeed + ((speed * 50) / 100) : entitySpeed);
	--	}
	--	if (KeyDown(VK_NUMPAD7))ENTITY::SetEntityVelocity(GetLocalPlayer().m_vehicle, 0, 0, 50);
	--	if (KeyDown(VK_NUMPAD3) || PAD::IsControlPressed(0, INPUT_FRONTEND_LT))ENTITY::SetEntityVelocity(GetLocalPlayer().m_vehicle, 0, 0, 0);
	--}
    
    --void FlyVehicle() {
	--	static bool check = false;
	--	if (!GetLocalPlayer().m_isInVehicle)return;
	--		Vector3 Rot = ENTITY::GetEntityRotation(GetLocalPlayer().m_vehicle, 2);
	--		float currentSpeed = ENTITY::GetEntitySpeed(GetLocalPlayer().m_vehicle);
	--		currentSpeed = currentSpeed * 4.2;
	--		int currentSpeedInt = (int)currentSpeed;
	--		if (check) {
	--			if (currentSpeedInt < 28 && PAD::IsControlPressed(0, INPUT_FRONTEND_RT))
	--				VEHICLE::SetVehicleGravity(GetLocalPlayer().m_vehicle, true);
	--			if (currentSpeedInt > 28 || !VEHICLE::IsVehicleOnAllWheels(GetLocalPlayer().m_vehicle)) {
	--				if (KeyDown(0x57)) {
	--					VEHICLE::SetVehicleGravity(GetLocalPlayer().m_vehicle, false);
	--					VEHICLE::SetVehicleForwardSpeed(GetLocalPlayer().m_vehicle, 80);
	--					ENTITY::FreezeEntityPosition(GetLocalPlayer().m_vehicle, false);
	--				}
	--				else {
	--					if (currentSpeedInt < 15 || KeyDown(VK_SPACE))
	--						ENTITY::FreezeEntityPosition(GetLocalPlayer().m_vehicle, true);
	--				}
	--				if (KeyDown(0x44)) {
	--					ENTITY::SetEntityRotation(GetLocalPlayer().m_vehicle, Rot.x, 0, Rot.z - 28 + 27.5, 1, 0);
	--				}
	--				else if (KeyDown(0x41)) {
	--					ENTITY::SetEntityRotation(GetLocalPlayer().m_vehicle, Rot.x, 0, Rot.z + 28 - 27.5, 1, 0);
	--				}
	--			}
	--			if (VEHICLE::IsVehicleOnAllWheels(GetLocalPlayer().m_vehicle))
	--				VEHICLE::SetVehicleGravity(GetLocalPlayer().m_vehicle, true), check = false;
	--		}
	--		if (KeyDown(VK_SHIFT) && VEHICLE::IsVehicleOnAllWheels(GetLocalPlayer().m_vehicle)) {
	--			ENTITY::SetEntityRotation(GetLocalPlayer().m_vehicle, Rot.x + 10, Rot.y, Rot.z, 1, 1);
	--			VEHICLE::SetVehicleForwardSpeed(GetLocalPlayer().m_vehicle, currentSpeedInt + 10);
	--			check = true;
	--		}
	--}
    
    
    
    
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
        if current_vehicle ~= 0 then
            if last_vehicle_with_radio_off ~= current_vehicle and GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
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
    -----randomGarageVehicle-----
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

    -----Protections-----
        protections:action("Stop All Sounds", {"stopsounds"}, "", function()
            for i = -1,100 do
                STOP_SOUND(i)
            end
            util.toast("Stopped Sounds.")
        end)
    -----Traffic-----
        traffic:toggle("Stand NoModPop Shortcut", {}, "Enables Stands 'Delete Modded Pop Multiplier Areas' in Online > Protections > Delete Modded Pop Multiplier Areas.", function(on)
            if menu.ref_by_path("Online>Protections>Delete Modded Pop Multiplier Areas").value ~= on then menu.ref_by_path("Online>Protections>Delete Modded Pop Multiplier Areas").value = on end
        end)
        traffic:toggle_loop("Delete Modded Pop Multiplier Areas", {""}, "Deletes modded population multiplier areas that stand misses", function()
            for i = 0, 15 do
                if DOES_POP_MULTIPLIER_AREA_EXIST(i) then
                    if IS_POP_MULTIPLIER_AREA_NETWORKED(i) then
                        util.toast($"Found a NETWORKED Pop Multiplier Area with ID: {i}... Removing...")
                    else
                        util.toast($"Found a NON-NETWORKED Pop Multiplier Area with ID: {i}... Removing...")
                    end
                end
                REMOVE_POP_MULTIPLIER_AREA(i, true)
            end
        end)
        traffic:toggle("No Traffic", {}, "Clears traffic for all players by adding a networked population multiplier.", function(on)
            if on then
                ped_sphere = 0.0
                traffic_sphere = 0.0
                pop_multiplier_id = ADD_POP_MULTIPLIER_SPHERE(1.1, 1.1, 1.1, 15000.0, ped_sphere, traffic_sphere, false, true)
                CLEAR_AREA(1.1, 1.1, 1.1, 19999.9, true, false, false, true)
            else
                REMOVE_POP_MULTIPLIER_SPHERE(pop_multiplier_id, false);
            end
        end)
    -----chatList-----
        -----commandBoxChat-----
            local commandBoxChat = ChatList:list("Command Box Chat")
            local toggleChatHistory = menu.ref_by_path("Online>Chat>Always Open")
            local disableChatInputAll = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_ALL")
            local disableChatInputTeam = menu.ref_by_path("Game>Disables>Disable Game Inputs>MP_TEXT_CHAT_TEAM")
            local showTyping
            commandBoxChat:toggle_loop("Command Box Chat.", {""}, "Use the command box to chat. Useful if chat is not opening when pressing 'T'. This option disables the in game chat box to fix crashing issues when co-loading cherax and typing in chat.", function()
                disableChatInputAll.value = true
                disableChatInputTeam.value = true
                if not menu.command_box_is_open() then
                    if util.is_key_down(0x54) and not IS_SYSTEM_UI_BEING_DISPLAYED() then -- Key 'T'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) -- Start Typing
                                end
                            end
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
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) -- Stop Typing
                                end
                            end
                        end
                    elseif util.is_key_down(0x59) and not IS_SYSTEM_UI_BEING_DISPLAYED() then -- Key 'Y'
                        util.yield()
                        if showTyping.value then
                            for players.list(false) as pid do
                                if players.exists(pid) then
                                    util.trigger_script_event(1 << pid, {-1760661233, players.user(), pid, 8642}) -- Start Typing
                                end
                            end
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
                                    util.trigger_script_event(1 << pid, {476054205, players.user(), pid, 5689}) -- Stop Typing
                                end
                            end
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
    -----kickAll-----
        kickAll:action("Kick All (Love Letter)", {"llkickall"}, "Love Letter kicks everyone. Should only be used when host.", function()
            for _, pid in ipairs(players.list_except(true, false, false, false)) do
                menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger()
            end
        end)
        kickAll:action("Kick All (Smart Kick)", {"kickall"}, "Removes everyone that it can, excluding friends and modders.", function()
            for _, pid in ipairs(players.list_except(true, true, false, false)) do
                if not players.is_marked_as_modder(pid) then
                    menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger()
                end
            end
        end)
    local showspeakerson = online:toggle_loop("Show speakers", {"showspeakers"}, "Accurately shows who is talking as soon as it happens. Better than vanilla.", function()
        for players.list(true, true, true) as pid do
            if NETWORK_IS_PLAYER_TALKING(pid) then
                util.draw_debug_text(players.get_name(pid).." is talking")
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
    bst_detection = online:toggle("Detect BST", {"showbst", "detectbst"}, "Detect players using BST", function(state) --from mrRobot
        local size = 5
        local event_data = memory.alloc(size * 8)

        util.create_tick_handler(function()
            if not bst_detection.value then
                return false
            end

            for i = 0, GET_NUMBER_OF_EVENTS(1) do
                local event = GET_EVENT_AT_INDEX(1, i)
                if event == 174 and GET_EVENT_DATA(1, i, event_data, size) then
                    local event_hash = memory.read_int(event_data)
                    local pid = memory.read_int(event_data + (1 * 8))
        
                    if event_hash == 1489206770 then
                        aboveMapToast($'{players.get_name(pid)} has collected BST', 'Roothide', '', 2)
                    end
                end
            end
        end)
    end)
    -----scriptHostLoop-----
        local isScriptHostLoopActive = false
        local function scripthostloop()
            while isScriptHostLoopActive do
                if players.get_script_host() ~= players.user() then
                    local playerName = players.get_name(players.user())  -- Get the user's name
                    menu.trigger_commands("givesh" .. playerName)  -- Trigger the command to become script host
                    util.toast("Becoming script host...")
                end
                util.yield_once()
            end
        end
        online:toggle("Script Host Loop", {"scriptloop", "scripthostloop"}, "Constantly become the script host. This could break sessions.", function(state)
            isScriptHostLoopActive = state
            if state then
                util.create_thread(scripthostloop)
            end
        end)
    -----logChat-----
        local logChatEnabled = false
        local function onChatMessage(sender, reserved, text, team_chat, networked, is_auto)
            if logChatEnabled then
                local playerName = players.get_name(sender)
                local logColour = team_chat and ANSI_GREEN or ANSI_YELLOW
                local logChatMessage = logColour .. playerName .. " [" .. (team_chat and "TEAM" or "ALL") .. "] " .. text .. ANSI_RESET
                util.toast(logChatMessage, TOAST_CONSOLE)
            end
        end
        chat.on_message(onChatMessage)
        online:toggle("Log Chat To Console With Coloured Text", {}, "", function(on)
            logChatEnabled = on
        end)

-----Wᴏʀʟᴅ Lɪsᴛ​​​​​​​​​-----

    -----clearAreaOptions-----
        clearAreaOptions:textslider("Clear Area", {}, "", {"Peds", "Vehicles", "Objects", "Pickups", "Projectiles", "Sounds"}, function(index, name) --from jinxscript
            local counter = 0
            switch index do
                case 1:
                    for entities.get_all_peds_as_handles() as ped do
                        if ped ~= players.user_ped() and not IS_PED_A_PLAYER(ped) then
                            entities.delete_by_handle(ped)
                            counter += 1
                            util.yield()
                        end
                    end
                    break
                case 2:
                    for entities.get_all_vehicles_as_handles() as vehicle do    
	    			local owner = entities.get_owner(vehicle)
                        if vehicle ~= GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and (owner == players.user() or owner == -1) then
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
        clearAreaOptions:action("Super Cleanse", {"supercleanse"}, "Uses stand API to instantly delete EVERY entity it finds (including player vehicles!). \nIf control of entity cannot be obtained it will force deletion locally.", function(on_click)
            local counter = 0
            for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
                entities.delete(ent)
                counter = counter + 1
            end
            for k,ent in pairs(entities.get_all_peds_as_handles()) do
                if not IS_PED_A_PLAYER(ent) then
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

    -----baseballBatKnifeLiveries-----
        local originalGunVanValues = {}     
        local function setGlobalsForSpecialLiveries()
            -- Store the original values
            originalGunVanValues[34329] = memory.read_int(memory.script_global(262145 + 34329))
            originalGunVanValues[34330] = memory.read_int(memory.script_global(262145 + 34329 + 1))
        
            for i = 25, 75 do
                originalGunVanValues[34331 + i] = memory.read_int(memory.script_global(262145 + 34331 + i))
            end
        
            -- Set the new values (Credit to ToxikSkull)
            memory.write_int(memory.script_global(262145 + 34329), 2508868239) -- PLACES KNIFE AND BAT INTO GUN VAN USING THEIR HASHES
            memory.write_int(memory.script_global(262145 + 34329 + 1), 2578778090)
        
            for i = 25, 75 do
                memory.write_int(memory.script_global(262145 + 34331 + i), 0) -- ONE OF THESE ENABLES BAT & KNIFE LIVERIES LOL!
            end
        end
        local function restoreOriginalSpecialLiveriesGlobals()
            -- Restore the original values
            memory.write_int(memory.script_global(262145 + 34329), originalGunVanValues[34329])
            memory.write_int(memory.script_global(262145 + 34329 + 1), originalGunVanValues[34330])
        
            for i = 25, 75 do
                memory.write_int(memory.script_global(262145 + 34331 + i), originalGunVanValues[34331 + i])
            end
        end
        misc:toggle("Unlock Baseball Bat & Knife Liveries", {"weaponLiveries"}, "Temporarily unlocks liveries. Enable Before Going Into Gun Van Weapon Menu!\n!!!MAKE SURE YOU TURN OPTION OFF WHEN FINISHED!!!", function(on)
            if on then
                setGlobalsForSpecialLiveries()
            else
                restoreOriginalSpecialLiveriesGlobals()
            end
        end)

-----DebugList-----

    if devmode() then
        local debuglist = menu.list(roothide_menu, "Debug", {"rhdebug"}, "")

        debuglist:action("Restart Script", {}, "Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.", function()
            util.restart_script()
        end)
        debuglist:action("Log stand lang registered codes", {}, "", function()
            util.toast(lang.find_builtin("Movement"), TOAST_ABOVE_MAP | TOAST_CONSOLE)
        end)
        

        local libDir = filesystem.scripts_dir() .. "lib\\roothide\\"
            dofile(libDir .. "support.pluto")

    end

--Pʟᴀʏᴇʀ Oᴘᴛɪᴏɴs--

    local function handlePlayerOptions(pid)
        player_root = menu.player_root(pid)
        player_menu = player_root:list("Roothide")
        misc_list = player_menu:list("Misc")

        player_root:getChildren()[1]:attachBefore(menu.shadow_root():action("Spectate", {}, "Toggles 'Nuts Method' Spectate on the player.", function()
            menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"):trigger()
            --local nutsSpectate = menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method")
            --if nutsSpectate.value == true then 
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
            if not players.exists(pid) then
                ghostPlayer.value = false
                return
            end
            SET_REMOTE_PLAYER_AS_GHOST(pid, true)
        end, function()
            SET_REMOTE_PLAYER_AS_GHOST(pid, false)
        end)


    end
players.add_command_hook(handlePlayerOptions)


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
util.toast(ANSI_RED .. textLogo .. ANSI_RESET, TOAST_CONSOLE)
util.toast(string.format("\x1B[1;35m[Roothide] \x1B[0;37mScript loaded in %dms\x1B[0m", util.current_time_millis() - scriptStartTime), TOAST_CONSOLE)
