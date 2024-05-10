util.keep_running()
util.require_natives("3095a", "g")

util.ensure_package_is_installed("lua/auto-updater")
local auto_updater = require("auto-updater")

auto_updater.run_auto_update({
    source_url="URLHERE",
    script_relpath=SCRIPT_RELPATH
})

local roothide_menu = menu.attach_before(menu.ref_by_path("Stand>Settings"), menu.list(menu.shadow_root(), "Roothide", {"roothidescript"}, "Roothide Script"))
roothide_menu:action("Stop Script", {}, "Stop the script.", function()
    util.stop_script()
end)

menu.action(menu.my_root(), "Go to menu", {}, "Go to the scripts main menu", function()
    menu.trigger_commands("roothidescript")
end)
menu.action(menu.my_root(), "Restart Script", {}, "Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.", function()
    util.restart_script()
end)
--menu.action(menu.my_root(), "Check for Update", {}, "The script will automatically check for updates at most daily, but you can manually check using this option anytime.", function()
--end)

local self = menu.list(roothide_menu, "Self", {}, "")
local vehicleoptions = menu.list(roothide_menu, "Vehicle Options", {}, "")
local seatswitcher = menu.list(vehicleoptions, "Switch Seat", {"switchseat", "seatswitch"}, "")
local online = menu.list(roothide_menu, "Online", {}, "")
local session = menu.list(online, "Session", {}, "")
local traffic = menu.list(online, "Traffic", {}, "")
local world = menu.list(roothide_menu, "World", {}, "")
local game = menu.list(roothide_menu, "Game", {}, "")
local debuglist = menu.list(roothide_menu, "Debug", {}, "")

if SCRIPT_MANUAL_START then
menu.trigger_commands("roothidescript")
end

---------
--Debug--
---------
debuglist:action("Restart Script", {}, "Goes through the script stop process, freshly loads the contents of the script file, and starts the main thread again.", function()
    util.restart_script()
end)
debuglist:toggle_loop("Display NAT Type In Overlay", {}, "", function()
	local natTypes = {"Open", "Moderate", "Strict"}
    local getNatType = util.stat_get_int64("_NatType")
    for nat, natType in natTypes do
        if getNatType == nat then
            util.draw_debug_text($"NAT Type: {natType}")
        end
    end
end)
debuglist:action("Log stand lang registered codes", {}, "", function()
    util.toast(lang.find_builtin("Movement"), TOAST_ABOVE_MAP | TOAST_CONSOLE)
end)
--------
--Sᴇʟғ--
--------
self:toggle_loop("True No Ragdoll", {}, "Speeds up getting up after being knocked down", function()
    SET_PED_CONFIG_FLAG(players.user_ped(), 227, IS_PLAYER_PLAYING(players.user()))
end)
self:action("Easy way out", {}, "", function()
    memory.write_int(memory.script_global(1574582+6), 1)
end)
-------------------
--Vᴇʜɪᴄʟᴇ Oᴘᴛɪᴏɴs​​​​--
-------------------
vehicleoptions:toggle_loop("Engine Always On", {"alwayson"}, "Current/Last vehicles engine and lights will always stay on.", function()
    local vehicle = GET_VEHICLE_PED_IS_IN(PLAYER_PED_ID(), false)
    if DOES_ENTITY_EXIST(vehicle) then
    SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
    SET_VEHICLE_LIGHTS(vehicle, 0)
    end
end)

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
vehicleoptions:action("Random Garage Vehicle", {"randomvehicle", "rv"}, "Picks a random vehicle from your Stand/Personal garage.", function()
        local vehicles_dir = filesystem.stand_dir() .. "Vehicles"
        local all_vehicles = get_all_vehicles(vehicles_dir)
        local random_vehicle = all_vehicles[math.random(#all_vehicles)]
        local stand_ref = vehicle_path_to_stand_ref(random_vehicle)
            menu.focus(stand_ref)
end)

-- Moreinfo of Seat Index
-- DriverSeat = -1
-- Passenger = 0
-- Left Rear = 1
-- RightRear = 2
seatswitcher:action("Driver Seat", {"seatdriver"}, "Warp into driver seat.", function()
SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), -1)end)
seatswitcher:action("Passenger Seat", {"seatpassenger"}, "Warp into passenger seat.", function()
SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 0)end)
seatswitcher:toggle("Prevent Auto Seat Shuffle", {"noshuffle"}, "Prevents auto shuffling over to drivers seat if it becomes free.", function(toggled)
SET_PED_CONFIG_FLAG(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 184, toggled)end)
seatswitcher:action("Left Rear", {}, "Warp into rear left seat.", function()
SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 1)end)
seatswitcher:action("Right Rear", {}, "Warp into rear right seat.", function()
SET_PED_INTO_VEHICLE(GET_PLAYER_PED_SCRIPT_INDEX(players.user()), entities.get_user_vehicle_as_handle(), 2)end)

----------
--Oɴʟɪɴᴇ--
----------
session:action("Kick All (Love Letter)", {"llkickall"}, "Love Letter kicks everyone. Should only be used when host.", function()
    for _, pid in ipairs(players.list_except(true, false, false, false)) do
        menu.ref_by_rel_path(menu.player_root(pid), "Kick>Love Letter"):trigger()
    end
end)
session:action("Kick All (Smart Kick)", {"kickall"}, "Removes everyone that it can, excluding friends and modders.", function()
    for _, pid in ipairs(players.list_except(true, true, false, false)) do
        if not players.is_marked_as_modder(pid) then
            menu.ref_by_rel_path(menu.player_root(pid), "Kick>Smart"):trigger()
        end
    end
end)
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
local showspeakerson = online:toggle_loop("Show speakers", {"showspeakers"}, "Accurately shows who is talking as soon as it happens. Better than vanilla.", function()
    for players.list(true, true, true) as pid do 
        if NETWORK_IS_PLAYER_TALKING(pid) then 
            util.draw_debug_text(GET_PLAYER_NAME(pid) .. ' is speaking')
        end
    end
end)
showspeakerson.value = true
online:toggle_loop("Hide Help Text", {"hidehelptext"}, "", function() 
	HIDE_HELP_TEXT_THIS_FRAME()
end)
online:toggle("Create Safe Session In Current Session", {}, "Create a tutorial session inside current session that other players cannot join giving you a safe space to go afk.", function(on)
    if on then
        NETWORK_START_SOLO_TUTORIAL_SESSION()
    else
        NETWORK_END_TUTORIAL_SESSION()
    end
end)
---------
--Wᴏʀʟᴅ​​​​​​​​​--
---------
world:action("Super Cleanse", {"supercleanse"}, "Uses stand API to instantly delete EVERY entity it finds (including player vehicles!).", function(on_click)
    local ct = 0
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        entities.delete(ent)
        ct = ct + 1
    end
    for k,ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_A_PLAYER(ent) then
            entities.delete(ent)
        end
        ct = ct + 1
    end
    for k,ent in pairs(entities.get_all_objects_as_handles()) do
        entities.delete(ent)
        ct = ct + 1
    end
    util.toast("Super cleanse is complete! " .. ct .. " entities removed.")
end)

--------
--Gᴀᴍᴇ--
--------


------------------
--Pʟᴀʏᴇʀ Oᴘᴛɪᴏɴs--
------------------
players.add_command_hook(function(pid, player_root)
    player_menu = player_root:list("Roothide")
    misc_list = player_menu:list("Misc")

    player_root:getChildren()[1]:attachBefore(menu.shadow_root():action("Spectate", {}, "Toggles 'Nuts Method' Spectate on the player.", function()
        menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"):trigger()
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
end)