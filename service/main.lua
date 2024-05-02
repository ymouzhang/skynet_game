local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"

skynet.start(function ()
    skynet.error("[start main] hello world")

    -- 集群配置
    cluster.reload({
        node1 = "127.0.0.1:7001",
        node2 = "127.0.0.1:7002",
    })

    local mynode = skynet.getenv("node")
    if "node1" == mynode then
        -- 启动集群节点
        cluster.open("node1")
        -- node1节点，开启打工服务
        local worker1 = skynet.newservice("worker", "worker", 1)
        skynet.name("worker1", worker1)
        skynet.send(worker1, "lua", "start_work")
        skynet.sleep(200)
        skynet.send(worker1, "lua", "stop_work")
    elseif "node2" == mynode then
        -- 启动集群节点
        cluster.open("node2")
        -- node2节点，开启买猫粮服务
        local buy1 = skynet.newservice("buy", "buy", 1)
        -- 请求买猫粮，买三次
        skynet.send(buy1, "lua", "buy")
        skynet.send(buy1, "lua", "buy")
        skynet.send(buy1, "lua", "buy")
    end
    skynet.exit()
end)