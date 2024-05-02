-- service/buy/init.lua脚本

local skynet = require "skynet"
local s = require "service"

s.cat_food_price = 5
s.cat_food_cnt = 0

s.resp.buy = function (source)
    -- 先扣费
    local left_money = skynet.call("worker1", "lua", "change_money", -s.cat_food_price)
    if left_money >= 0 then
        s.cat_food_cnt = s.cat_food_cnt + 1
        skynet.error("buy cat food ok, current cnt: " .. tostring(s.cat_food_cnt))
        return true
    end
    -- 购买失败，把钱加回去
    skynet.error("buy failed, money not enough")
    skynet.call("worker1", "lua", "change_money", s.cat_food_price)
    return false
end

s.start(...)