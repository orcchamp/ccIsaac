local ccTimed = {}

local responseCode = require("tcpResponseCode")

function ccTimed.test()
    player:AddCoins(1)
    return responseCode.success
end


function ccTimed.test_end()
    player:AddCoins(1)
    return responseCode.success
end

ccTimed.methods = {
    test_timed = ccTimed.test,
    test_timed_end = ccTimed.test_end
}

return ccTimed