local ccIsaac = RegisterMod("CCIsaac", 1)

-- If adding a new module add a new import
local ccActivateables = require("ccActivateables")
local ccConsumables = require("ccConsumables")
local ccItems = require("ccItems")
local ccMisc = require("ccMisc")
local ccStats = require("ccStats")
local ccTrinkets = require("ccTrinkets")
local responseFormat = require("tcpResponse")
local responseCode = require("tcpResponseCode")

local socket = require("socket")

local json = require("json")


client =  socket.tcp()
client:settimeout(0)

client:connect("127.0.0.1", 58430)

player = Isaac.GetPlayer(0)

rng = RNG()

methodmap = {
}

function ccIsaac:mergeTables(source, dest)
    for k, v in pairs(source) do
        dest[k] = v
    end
end

--To add new methods or files add a new merge statement
ccIsaac:mergeTables( ccActivateables.methods, methodmap)
ccIsaac:mergeTables( ccConsumables.methods, methodmap)
ccIsaac:mergeTables( ccItems.methods, methodmap)
ccIsaac:mergeTables( ccMisc.methods, methodmap)
ccIsaac:mergeTables( ccStats.methods, methodmap)
ccIsaac:mergeTables( ccTrinkets.methods, methodmap)

function ccIsaac:Init()
    player = Isaac.GetPlayer(0)
    rng:SetSeed(RNG():GetSeed(), 0);
end


function ccIsaac:ParseMessages()
    local message, status, partial =  client:receive()
    local response = responseFormat
    if  partial ~= nil and string.len(partial) >0  then
        partialAsTable = json.decode(partial)
        local method = partialAsTable["code"]
        response["id"] = partialAsTable["id"]
        if method ~= nil then 
            response["code"], response["message"] = methodmap[method]()
        else
            response["code"] = responseCode.unavailable
            response["message"] = "Requested Method was not found"
        end
        responseAsString = json.encode(response)
        responseAsString = responseAsString .. "\0"
        client:send(responseAsString)
    end
end

ccIsaac:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, ccIsaac.Init )
ccIsaac:AddCallback(ModCallbacks.MC_POST_UPDATE , ccIsaac.ParseMessages)
