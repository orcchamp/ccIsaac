local ccIsaac = RegisterMod("CCIsaac", 1)

-- If adding a new module add a new import
local ccActivateables = require("ccActivateables")
local ccConsumables = require("ccConsumables")
local ccItems = require("ccItems")
local ccMisc = require("ccMisc")
local ccStats = require("ccStats")
local ccTrinkets = require("ccTrinkets")
local ccTimed = require("ccTimed")
local responseFormat = require("tcpResponse")
local responseCode = require("tcpResponseCode")

local socket = require("socket")

local json = require("json")


client = socket.tcp()
client:settimeout(0)
client:setoption('keepalive',true)
client:setoption('tcp-nodelay',true)

client:connect("127.0.0.1", 58430)


rng = RNG() --General RNG method used by all functions
methodmap = {} --Will contain all functions
timed_effects = {} --Table containing all currently running effects name = (duration_left_ms, id)
last_frame_time = 0 --Used to keep track of time since last frame


timed_effects["test_timed"] = {5000, 1}

function ccIsaac:mergeTables(source, dest)
    for k, v in pairs(source) do
        dest[k] = v
    end
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end


--To add new methods or files add a new merge statement
ccIsaac:mergeTables(ccActivateables.methods, methodmap)
ccIsaac:mergeTables(ccConsumables.methods, methodmap)
ccIsaac:mergeTables(ccItems.methods, methodmap)
ccIsaac:mergeTables(ccMisc.methods, methodmap)
ccIsaac:mergeTables(ccStats.methods, methodmap)
ccIsaac:mergeTables(ccTrinkets.methods, methodmap)
ccIsaac:mergeTables(ccTimed.methods, methodmap)

function ccIsaac.Init()
    rng:SetSeed(Random(), 1)
end

function OnRender()
    if timed_effects["test_timed"] ~= nil then
        Isaac.RenderText("Timer: " .. timed_effects["test_timed"][1], 100, 30, 1 , 1, 1, 1)
    end
end

function SendResponse(id, status, message, timeRemaining, type)
    timeRemaining = timeRemaining or 0
    type = type or 0x00

    local finishedResponse = responseFormat
    finishedResponse["id"] = id
    finishedResponse["status"] = status
    finishedResponse["message"] = message
    finishedResponse["timeRemaining"] = timeRemaining
    finishedResponse["type"] = type

    local responseAsString = json.encode(finishedResponse)
    responseAsString = responseAsString .. "\0"
    client:send(responseAsString)
end

function OnPause()
    for effect, info in pairs(timed_effects) do
        local time_remaining = info[1]
        local id = info[2]
        SendResponse(id, responseCode.paused, nil, time_remaining)
    end
end

function UnPause()
    for effect, info in pairs(timed_effects) do
        local time_remaining = info[1]
        local id = info[2]
        SendResponse(id, responseCode.resumed, nil, time_remaining)
    end
end

function ccIsaac.ParseMessages()
    local time = Isaac.GetTime() --current time in ms!
    if last_frame_time == 0 then last_frame_time = Isaac.GetTime() end --Set first last frame time

	player = Isaac.GetPlayer(0) --Player object. Coop maybe coming, someday

    --Parse Messages
    local message, status, partial =  client:receive()
    local response = responseFormat
    if  partial ~= nil and string.len(partial) > 0  then
        local partialAsTable = json.decode(partial)
        Isaac.DebugString("Dump:" .. dump(partialAsTable))
        local method = partialAsTable["code"]
        response["id"] = partialAsTable["id"]
        if method ~= nil then
			if partialAsTable["parameters"] ~= nil then
				local argumentValue = partialAsTable["parameters"][1]
				response["status"], response["message"] = methodmap[method](argumentValue)
            elseif string.find(method, "timed") then
                if timed_effects[method] ~= nil then --Already present
                    response["status"], response["message"] = responseCode.retry, "Effect already active"
                end
                Isaac.DebugString("Timed effect: " .. method)

                local duration = 5000
                timed_effects[method] = {duration, partialAsTable["id"]} --Set duration

				response["status"], response["message"] = methodmap[method]()
                response["timeRemaining"] = duration
                response["type"] = 0xFF
			else
				response["status"], response["message"] = methodmap[method]()
			end
        else
            response["status"] = responseCode.unavailable
            response["message"] = "Requested Method was not found"
        end
        local responseAsString = json.encode(response)
        responseAsString = responseAsString .. "\0"
        client:send(responseAsString)
    end

    --Handle timed effects
    if Game():IsPaused() == false then --Only decrement values if game is not paused
        local passed_time = time - last_frame_time
        for method, info in pairs(timed_effects) do
            local time_remaining = info[1]
            local id = info[2]
            if time_remaining - passed_time < 0 then
                timed_effects[method] = nil
                methodmap[method .. "_end"]()
                SendResponse(id, responseCode.finished, nil, 0)
            else
                timed_effects[method] = {time_remaining - passed_time, id}
            end
        end
    end


    last_frame_time = time
end

ccIsaac.Init()
--ccIsaac:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ccIsaac.Init )
ccIsaac:AddCallback(ModCallbacks.MC_POST_UPDATE , ccIsaac.ParseMessages)
ccIsaac:AddCallback(ModCallbacks.MC_POST_RENDER, OnRender)
