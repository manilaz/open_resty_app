--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/6
-- Time: 下午2:38
-- To change this template use File | Settings | File Templates.
--
local param = require('comm.test.param_number')
local logger = require('unified_log_process')
local args = ngx.req.get_uri_args()

if not args.a or not args.b or not param.is_number(args.a, args.b) then
    ngx.exit(ngx.HTTP_BAD_REQUEST)
    logger.add(ngx.ERR,"参数[",args.a,",", args.b,"]格式错误")
    return
end
