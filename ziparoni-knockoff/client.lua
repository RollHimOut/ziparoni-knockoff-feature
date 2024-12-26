-- client.lua
local lastCollisionTime = 0
local playerCooldowns = {}

local function applyKnockoffLogic(ped, vehicle, collisionForce)
    if not Config.AllowKnockoff or Config.GlobalKnockoffDisable then return end

    -- Check if collision force exceeds threshold
    if collisionForce > Config.ForceThreshold then
        -- Calculate the velocity and whether the collision warrants a ragdoll
        local velocity = GetEntitySpeed(vehicle)

        if velocity > Config.MinimumSpeed then
            -- Knock the player off the bike in a ragdoll state
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, Config.RagdollTime, Config.RagdollTime, 0, true, true, false)

            -- Apply physics to simulate a realistic fall
            local forwardVector = GetEntityForwardVector(vehicle)
            ApplyForceToEntity(ped, 1, forwardVector.x * velocity * 5, forwardVector.y * velocity * 5, 0.0, 0.0, 0.0, 0.0, true, true, true, true, true)

            -- Simulate bike crash behavior
            if Config.ApplyBikeSpin then
                local bikeVelocity = GetEntityVelocity(vehicle)
                SetEntityVelocity(vehicle, bikeVelocity.x * 0.5, bikeVelocity.y * 0.5, bikeVelocity.z * 0.2)
            end

            -- Cooldown to prevent repeated knockoffs
            playerCooldowns[PlayerId()] = GetGameTimer() + Config.CooldownTime

            -- Debug logging
            if Config.DebugMode then
                print(('[Knockoff Debug] Collision Force: %.2f | Speed: %.2f'):format(collisionForce, velocity))
            end
        end
    end
end

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if IsPedOnAnyBike(playerPed) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if HasEntityCollidedWithAnything(vehicle) then
                -- Check cooldown for player
                if playerCooldowns[PlayerId()] and GetGameTimer() < playerCooldowns[PlayerId()] then
                    Wait(100)
                    goto continue
                end

                -- Calculate collision force
                local velocity = GetEntitySpeed(vehicle)
                local collisionForce = velocity * 10

                -- Environmental checks
                if IsEntityInWater(vehicle) or not IsVehicleOnAllWheels(vehicle) then
                    goto continue
                end

                applyKnockoffLogic(playerPed, vehicle, collisionForce)
            end
        end

        ::continue::
        Wait(100)
    end
end)