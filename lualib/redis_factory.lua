--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/7
-- Time: 上午10:45
-- To change this template use File | Settings | File Templates.
--

local redis= require('resty.redis')

local _REDIS = {}

function _REDIS.close(red)
    if not red then
        return
    end
    --释放连接(连接池实现)
    local pool_max_idle_time = 100000 --毫秒
    local pool_size = 1000 --连接池大小
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)
    if not ok then
        ngx.log(ngx.ERR,"set keepalive error : ", err)
    end
end


function _REDIS.conn()
    --创建实例
    local red = redis:new()
    --设置超时（毫秒）
    red:set_timeout(1000)
    --建立连接
    local ip = "127.0.0.1"
    local port = 6379
    local ok, err = red:connect(ip, port)
    if not ok then
        ngx.log(ngx.ERR,"connect to redis error : ", err)
        return _REDIS.close(red)
    else
        local count
        count, err = red:get_reused_times()
        if 0 == count then
            ok, err = red:auth("password")
            if not ok then
                return
            end
            return red,"connect to redis success"
        elseif err then
            ngx.log(ngx.ERR,"failed to get reused times: ", err)
            return nil , err
        end
        return red
    end
end

return _REDIS