local sp_gui = gui.get_tab("Single Player")

local singleplayer_global  = 113969
local crew_unlocked_bitset = singleplayer_global + 1 + 116 --MISC::REGISTER_INT_TO_SAVE(&(Global_113969.f_1.f_116), "Crew_Unlocked_Bitset");
local car_mods_bitset      = singleplayer_global + 2366 + 539 + 2241 --STREAMING::REQUEST_NAMED_PTFX_ASSET("scr_indep_wheelsmoke"); shop_controller.c

sp_gui:add_imgui(function()

    if ImGui.Button("Max Character Stats") then
        script.run_in_fiber(function()
            for i = 0, 2, 1 do
                stats.set_int("SP"..tostring(i).."_SPECIAL_ABILITY_UNLOCKED", 100)
                stats.set_float("SP"..tostring(i).."_DIST_RUNNING", 175 * 100)
                stats.set_int("SP"..tostring(i).."_TIME_UNDERWATER", 30 * 60 * 1000 * 100)
                stats.set_int("SP"..tostring(i).."_UNARMED_HITS", 20 * 100)
                stats.set_int("SP"..tostring(i).."_NUMBER_NEAR_MISS", 50 * 100)
                stats.set_int("SP"..tostring(i).."_PLANE_LANDINGS", 10 * 100)
                stats.set_int("SP"..tostring(i).."_KILLS_STEALTH", 2 * 100)
                stats.set_int("SP"..tostring(i).."_HITS_MISSION", 40 * 100)
                stats.set_int("SP"..tostring(i).."_HITS_PEDS_VEHICLES", 80 * 100)
            end
        end)
    end

    if ImGui.Button("Add 1 Million Dollars") then
        script.run_in_fiber(function()
            local model = ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID())
            local i
            if model == joaat("Player_Zero") then
                i = 0
            elseif model == joaat("Player_One") then
                i = 1
            elseif model == joaat("Player_Two") then
                i = 2
            else
                return
            end
            local money_string = "SP"..tostring(i).."_TOTAL_CASH"
            stats.set_int(money_string, stats.get_int(money_string) + 1000000)
        end)
    end
    
    if ImGui.Button("Unlock All Heist Crew") then
        globals.set_int(crew_unlocked_bitset, -1)
    end
    
    if ImGui.Button("Unlock All Car Mods") then
        for i = 1, 4, 1 do
            globals.set_int(car_mods_bitset + i, -1)
        end
    end
    
    if ImGui.Button("Unlock all SP Exclusives") then
        script.run_in_fiber(function()
            stats.set_int("SP_UNLOCK_EXCLUS_CONTENT", -1)
        end)
    end
	
	if ImGui.Button("Skip stupid yoga mission") then
        locals.set_int("family5", 591, 18)
    end
end)