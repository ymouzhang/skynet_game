local skynet = require "skynet"
local s = require "service"

s.money = 0
s.isworking = false

s.update = function(frame)
    if s.isworking then
        s.money = s.money + 1
        skynet.error(s.name .. tostring(s.id) .. ", money: " .. tostring(s.money))
    end
end

s.init = function ()
    skynet.fork(s.timer)
end

s.timer = function()
    local stime = skynet.now()
    local frame = 0
    while true do
        frame = frame + 1
        local isok, err = pcall(s.update, frame)
        if not isok then
            skynet.error(err)
        end
        local etime = skynet.now()
        local waittime = frame * 20 - (etime - stime)
        if waittime <= 0 then
            waittime = 2
        end
        skynet.sleep(waittime)
    end
end

s.resp.start_work = function(source)
    s.isworking = true
end

s.resp.stop_work = function(source)
    s.isworking = false
end

s.resp.change_money = function(source, delta)
    s.money = s.money + delta
    return s.money
end

s.start(...)