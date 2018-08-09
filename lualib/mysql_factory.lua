--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/7
-- Time: 下午4:59
-- To change this template use File | Settings | File Templates.
--

local mysql= require('resty.mysql')
local _MYSQL = {}


function _MYSQL.close(db)
    if not db then
        return
    end
    --释放连接(连接池实现)
    local pool_max_idle_time = 100000 --毫秒
    local pool_size = 1000 --连接池大小
    local ok, err = db:set_keepalive(pool_max_idle_time, pool_size)
    if not ok then
        ngx.log(ngx.ERR,"set keepalive error : ", err)
    end
end

function _MYSQL.conn()

    local db, err = mysql:new()
    if not db then
        ngx.say("new mysql error : ", err)
        return
    end

    --设置超时时间(毫秒)
    db:set_timeout(10000)

    local props = {
        host = "192.168.3.9",
        port = 3306,
        database = "permission",
        user = "root",
        password = "0708"
    }

    local res, err, errno, sqlstate = db:connect(props)

    if not res then
        ngx.log(ngx.ERR,"connect to mysql error : ", err, " , errno : ", errno, " , sqlstate : ", sqlstate)
        return _MYSQL.close(db)
    end

    return db , "connect to mysql success "
end


return _MYSQL