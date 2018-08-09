--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/7
-- Time: 上午11:03
-- To change this template use File | Settings | File Templates.
--

local factory = require('redis_factory')



local redis, error = factory.conn()

if not redis then
    ngx.log(ngx.ERR,"redis conn failed :",error)
    return
end

local ok,err = redis:set("dog"," is an a")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

ok,err = redis:get("dog")

if not ok then
    ngx.say("failed to get dog: ", err)
    return
end

ngx.say("dog:",ok)

factory.close(redis)