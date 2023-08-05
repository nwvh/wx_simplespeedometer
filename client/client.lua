local isInVeh = false
local ped = PlayerPedId()
local speed = nil
local units = nil
local gear = nil

Citizen.CreateThread(function ()
    while true do Wait(10)
        if IsPedInAnyVehicle(ped,false) then
            isInVeh = true
            local veh = GetVehiclePedIsIn(ped,false)
            gear = GetVehicleCurrentGear(veh)
            if string.lower(wx.Units) == 'kmh' then
                speed = GetEntitySpeed(veh)*3.6
                units = 'KM/H'
            else
                speed = GetEntitySpeed(veh)*2.236936
                units = 'MPH'
                
            end
        else isInVeh = false end
    end
end)

Citizen.CreateThread(function ()
    while true do Wait(wx.UpdateTime)
    if isInVeh then
        lib.showTextUI('['..gear..'] | '..math.floor(speed+0.5)..' '..units, {
            position = "top-center",
            icon = 'gauge',
            style = {
                borderRadius = 0,
                backgroundColor = '#1E1E2E',
                color = 'white'
            }
            })
    else
        lib.hideTextUI()
    end
end
end)