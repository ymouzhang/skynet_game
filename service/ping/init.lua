local skynet = require "skynet"

local CMD = {}

function CMD.start(source, target)
    skynet.send(target, "lua", "help", "Usage");
    skynet.send(target, "lua", "ping", 1)
end

function CMD.ping(source, count)
    local id = skynet.self()
    skynet.error("[" .. id .. "] recv ping count=" .. count)
    skynet.sleep(100)
    skynet.send(source, "lua", "ping", count + 1)
end

function CMD.help(source, name)
    print(name, "./skynet/skynet ./etc/config.game")
end

skynet.start(function()
    skynet.dispatch("lua", function(session, source, cmd, ...)
        print("func: ", cmd)
        local f = assert(CMD[cmd])
        f(source, ...)
    end)
end)
