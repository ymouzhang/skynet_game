local skynet = require "skynet"
local s = require "service"

s.cat_food_price = 5
s.cat_food_cnt = 0

s.resp.buy = function (source)
    local left_money = s.call("node1", "worker1", "change_money", -s.cat_food_price)
    if left_money >= 0 then
        s.cat_food_cnt = s.cat_food_cnt + 1
        skynet.error("buy cat food ok, current cnt: " .. tostring(s.cat_food_cnt))
        return true
    end
    skynet.error("buy cat food failed, money not enough")
    s.call("node1", "worker1", "change_money", s.cat_food_price)
    return false
end

s.start(...)