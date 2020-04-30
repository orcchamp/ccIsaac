local ResponseCode = {
    -- Worked
    success = 0,
    -- Failed and refund but is available
    failure = 1,
    -- Failed and unavailable
    unavailable = 2,
    -- Try again later
    retry = 3
}

return ResponseCode