--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/6
-- Time: 下午2:37
-- To change this template use File | Settings | File Templates.
--
local args = ngx.req.get_uri_args()
ngx.say(args.a + args.b)
