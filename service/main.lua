local skynet = require "skynet"
local runconfig = require "runconfig"

skynet.start(function ()
    skynet.error("[start main] hello world")
    skynet.error(runconfig.agentmgr.node)
    skynet.newservice("gateway","gateway",1)

    -- 退出主服务
    skynet.exit()
end)