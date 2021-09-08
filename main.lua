ccIsaac = RegisterMod("CCIsaac", 1)

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

time_table = {
    ["inverted_timed"] = 60000,
    ["invulnerable_timed"] = 15000,
    ["pixelation_timed"] = 30000,
    ["flipped_timed"] = 30000,
    ["flight_timed"] = 30000
}
timed_effects = {} --Table containing all currently running effects name = (duration_left_ms, id)
last_frame_time = 0 --Used to keep track of time since last frame
was_paused = false

pixelation_active = false
active_flight = false
invulnerable = false
shader_inverted = 0

inverted_controls = false --Global for inverted controls
currently_pressed = {0, 0, 0, 0, 0, 0, 0, 0} --Map of pressed controls
input_map = { --Map for inverted controls
    [ButtonAction.ACTION_LEFT + 1] = ButtonAction.ACTION_RIGHT,
    [ButtonAction.ACTION_RIGHT + 1] = ButtonAction.ACTION_LEFT,
    [ButtonAction.ACTION_UP + 1] = ButtonAction.ACTION_DOWN,
    [ButtonAction.ACTION_DOWN + 1] = ButtonAction.ACTION_UP,
    [ButtonAction.ACTION_SHOOTLEFT + 1] = ButtonAction.ACTION_SHOOTRIGHT,
    [ButtonAction.ACTION_SHOOTRIGHT + 1] = ButtonAction.ACTION_SHOOTLEFT,
    [ButtonAction.ACTION_SHOOTUP + 1] = ButtonAction.ACTION_SHOOTDOWN,
    [ButtonAction.ACTION_SHOOTDOWN + 1] = ButtonAction.ACTION_SHOOTUP
} 


--RenderDebugString = ""
RenderDebugString =  currently_pressed[1] .. currently_pressed[2] .. currently_pressed[3] .. currently_pressed[4] .. currently_pressed[5] .. currently_pressed[6] .. currently_pressed[7] .. currently_pressed[8]


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



function SendResponse(id, status, message, timeRemaining, type)
    type = type or 0x00

    local finishedResponse = responseFormat
    finishedResponse["id"] = id
    finishedResponse["status"] = status
    finishedResponse["message"] = message
    finishedResponse["timeRemaining"] = timeRemaining
    finishedResponse["type"] = type

    local responseAsString = json.encode(finishedResponse)
    responseAsString = responseAsString .. "\0"
    Isaac.DebugString("Sent Packet: " .. responseAsString)
    client:send(responseAsString)
end

function OnPause()
    for effect, info in pairs(timed_effects) do
        local time_remaining = info[1]
        local id = info[2]
        SendResponse(id, responseCode.paused, nil, time_remaining, 0xFF)
    end
end

function UnPause()
    for effect, info in pairs(timed_effects) do
        local time_remaining = info[1]
        local id = info[2]
        SendResponse(id, responseCode.resumed, nil, time_remaining, 0xFF)
    end
end



function ccIsaac:ParseMessages() --Function is called 30 times per second, and only when NOT paused
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
                response["status"], response["message"] = methodmap[method]()

                if response["status"] == responseCode.failure then
                    response["timeRemaining"] = 0
                    response["type"] = 0x00
                else
                    local duration = time_table[method]
                    timed_effects[method] = {duration, partialAsTable["id"]} --Set duration
                             
                    response["timeRemaining"] = duration
                    response["type"] = 0xFF
                end
			else
				response["status"], response["message"] = methodmap[method]()
			end
        else
            response["status"] = responseCode.unavailable
            response["message"] = "Requested Method was not found"
        end
        local responseAsString = json.encode(response)
        responseAsString = responseAsString .. "\0"
        Isaac.DebugString("Sent Packet: " .. responseAsString)
        client:send(responseAsString)
    end

    --Handle timed effects
    local passed_time = time - last_frame_time
    for method, info in pairs(timed_effects) do
        local time_remaining = info[1]
        local id = info[2]
        if time_remaining - passed_time < 0 then
            timed_effects[method] = nil
            methodmap[method .. "_end"]()
            SendResponse(id, responseCode.finished, nil, 0, 0x00)
        else
            timed_effects[method] = {time_remaining - passed_time, id}
        end
    end

    last_frame_time = time
end

function ccIsaac:OnRender()
    if was_paused == false and Game():IsPaused() == true  then
        OnPause()
        was_paused = true
    elseif was_paused == true and Game():IsPaused() == false then
        UnPause()
        was_paused = false
    end

    if Game():IsPaused() then
        last_frame_time = Isaac.GetTime()
    end
end

function ccIsaac:OnInput(entity, inputHook, buttonAction)
    if inverted_controls == true and inputHook==InputHook.GET_ACTION_VALUE then
        currently_pressed[buttonAction + 1] = Input.IsActionPressed(buttonAction, 0) and 1 or 0
        return currently_pressed[input_map[buttonAction + 1] + 1]
    end
end

function ccIsaac:OnDamage(TookDamage, DamageAmoujt, DamageFlags, DamageSource, DamageCountdownFrames)
    if invulnerable == true and TookDamage:ToPlayer() ~= nil then
        return false
    end
end


function ccIsaac:GetShaderParams(shaderName)
    if shaderName == 'Inverted' then
        if shaderAPI then
            shaderAPI.Shader("Inverted", {inverted = shader_inverted})
        else
            return {inverted = shader_inverted};
        end
    end
end

ccIsaac.Init()
--ccIsaac:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ccIsaac.Init )
ccIsaac:AddCallback(ModCallbacks.MC_POST_UPDATE, ccIsaac.ParseMessages)
ccIsaac:AddCallback(ModCallbacks.MC_POST_RENDER, ccIsaac.OnRender)
ccIsaac:AddCallback(ModCallbacks.MC_INPUT_ACTION, ccIsaac.OnInput)
ccIsaac:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, ccIsaac.OnDamage)
ccIsaac:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, ccIsaac.GetShaderParams)
