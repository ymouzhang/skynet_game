local skynet = require "skynet"

skynet.start(function ()
    skynet.error("[start main] hello world")
    -- 启动打工服务
    local worker1 = skynet.newservice("worker", "worker", 1)
    -- 启动买猫粮服务
    local buy1 = skynet.newservice("buy", "buy", 1)

    -- 开始打工
    skynet.send(worker1, "lua", "start_work")
    skynet.sleep(200)
    -- 结束打工
    skynet.send(worker1, "lua", "stop_work")

    -- 买猫粮
    skynet.send(buy1, "lua", "buy")

    -- 退出主服务
    skynet.exit()
end)