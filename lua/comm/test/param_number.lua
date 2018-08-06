--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/6
-- Time: 下午2:55
-- To change this template use File | Settings | File Templates.
--
local _M = {}

function _M.is_number(...)

    local arg = {...}

    local num
    for _,v in ipairs(arg) do
        num = tonumber(v)
        if nil == num then
            return false
        end
    end
    return true
end

return _M

