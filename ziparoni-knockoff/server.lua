-- server.lua
RegisterServerEvent('knockoff:log')
AddEventHandler('knockoff:log', function(playerId, collisionForce)
    local playerName = GetPlayerName(playerId)
    local coords = GetEntityCoords(GetPlayerPed(playerId))
    print(('[Knockoff] %s was knocked off at %.2f, %.2f, %.2f with force %.2f'):format(playerName, coords.x, coords.y, coords.z, collisionForce))
end)