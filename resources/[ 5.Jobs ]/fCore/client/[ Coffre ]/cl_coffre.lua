local inTrunk = false
local ESX = exports.es_extended:getSharedObject()

CreateThread(function()
    local vehicle, coords, playerIdPed
    while true do
        Wait(0)
        if inTrunk then
            playerIdPed = PlayerPedId()
            vehicle = GetEntityAttachedTo(playerIdPed)
            if DoesEntityExist(vehicle) or not IsPedDeadOrDying(playerIdPed) or not IsPedFatallyInjured(playerIdPed) then
                coords = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, 'boot'))
                SetEntityCollision(playerIdPed, false, false)
                ESX.Game.Utils.DrawText3D(coords, '[E] Sortir du coffre')

                if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                    SetEntityVisible(playerIdPed, false, false)
                else
                    if not IsEntityPlayingAnim(playerIdPed, 'timetable@floyd@cryingonbed@base', 3) then
                        ESX.Streaming.RequestAnimDict("timetable@floyd@cryingonbed@base")
                        TaskPlayAnim(playerIdPed, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)

                        SetEntityVisible(playerIdPed, true, false)
                    end
                end
                if IsControlJustReleased(0, 38) and inTrunk then
                    SetCarBootOpen(vehicle)
                    SetEntityCollision(playerIdPed, true, true)
                    Wait(750)
                    inTrunk = false
                    DetachEntity(playerIdPed, true, true)
                    SetEntityVisible(playerIdPed, true, false)
                    ClearPedTasks(playerIdPed)
                    SetEntityCoords(playerIdPed, GetOffsetFromEntityInWorldCoords(playerIdPed, 0.0, -0.5, -0.75))
                    Wait(250)
                    SetVehicleDoorShut(vehicle, 5)
                end
            else
                SetEntityCollision(playerIdPed, true, true)
                DetachEntity(playerIdPed, true, true)
                SetEntityVisible(playerIdPed, true, false)
                ClearPedTasks(playerIdPed)
                SetEntityCoords(playerIdPed, GetOffsetFromEntityInWorldCoords(playerIdPed, 0.0, -0.5, -0.75))
            end
        end
    end
end)   

CreateThread(function()
    local vehicle, lockStatus, playerCoords, trunk, coords, playerPed, player, playerIdPed
    while true do
        playerIdPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerIdPed)
        vehicle = GetClosestVehicle(playerCoords, 10.0, 0, 70)
		lockStatus = GetVehicleDoorLockStatus(vehicle)
        
        if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle,-1) then
            trunk = GetEntityBoneIndexByName(vehicle, 'boot')
            if trunk ~= -1 then
                coords = GetWorldPositionOfEntityBone(vehicle, trunk)
                if #(playerCoords - coords) <= 1.5 then
                    if not inTrunk then
                        if GetVehicleDoorAngleRatio(vehicle, 5) < 0.9 then
                            ESX.Game.Utils.DrawText3D(coords, '[E] Se cacher\n[H] Ouvrir')
								if IsControlJustReleased(0, 74)then
									if lockStatus == 1 then --unlocked
										SetCarBootOpen(vehicle)
									elseif lockStatus == 2 then -- locked
										ESX.ShowNotification('La voiture est fermé')
									end
								end
                        else
                            ESX.Game.Utils.DrawText3D(coords, '[E] Se cacher\n[H] Ouvrir')
                            if IsControlJustReleased(0, 74) then
                                SetVehicleDoorShut(vehicle, 5)
                            end
                        end
                    end
                    if IsControlJustReleased(0, 38) and not inTrunk then
                        player = ESX.Game.GetClosestPlayer()
                        playerPed = GetPlayerPed(player)
						if lockStatus == 1 then --unlocked
							if DoesEntityExist(playerPed) then
								if not IsEntityAttached(playerPed) or #(GetEntityCoords(playerPed) - playerCoords) >= 5.0 then
									SetCarBootOpen(vehicle)
									Wait(350)
									AttachEntityToEntity(playerIdPed, vehicle, -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20, true)	
                                    ESX.Streaming.RequestAnimDict("timetable@floyd@cryingonbed@base")
									TaskPlayAnim(playerIdPed, 'timetable@floyd@cryingonbed@base', 'base', 8.0, -8.0, -1, 1, 0, false, false, false)
									Wait(50)
									inTrunk = true

									Wait(1500)
									SetVehicleDoorShut(vehicle, 5)
								else
									ESX.ShowNotification('Il y a déjà quelqu\'un dans le coffre !')
								end
							end
						elseif lockStatus == 2 then -- locked
							ESX.ShowNotification('La voiture est verrouillée')
						end
                    end
                end
            end
        end
        Wait(0)
    end
end)