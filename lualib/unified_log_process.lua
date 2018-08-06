--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/6
-- Time: 下午6:48
-- To change this template use File | Settings | File Templates.
--

local _LOG = {}

-- 添加日志
function _LOG.add(level,logStr,...)
    local logs = ngx.ctx.logs
    if logs == nil then
        logs = {}
    end
    local log_body = {level,logStr,... }

    logs[#logs+1] = log_body
    ngx.ctx.logs = logs
    return
end

-- 顺序打印日志
function _LOG.log()
    local logs = ngx.ctx.logs

    ngx.log(ngx.ERR,#logs)

    if nil ~= logs and #logs > 0 then
        for _,v in ipairs(logs) do
            local log_body = ''
            if #v > 1 then
                for i,str in ipairs(v) do
                    if i > 1 then
                        log_body = log_body .. str
                    end
                end
            end
            ngx.log(v[1],log_body)
        end
    end
end

return _LOG
