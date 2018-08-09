--
-- Created by IntelliJ IDEA.
-- User: zhangbin
-- Date: 2018/8/7
-- Time: 下午5:28
-- To change this template use File | Settings | File Templates.
--

local factory = require('mysql_factory')

local db,err = factory.conn()

if not db then
    ngx.say("创建数据库连接失败:",err)
    return
end

local args = ngx.req.get_uri_args();

local select_sql = "select id,a,b from my_test where a = "
        .. ngx.quote_sql_str(args.a) .. " and b ="
        .. ngx.quote_sql_str(args.b)

local res, err, errno, sqlstate = db:query(select_sql)
if not res then
    ngx.say("select error : ", err, " , errno : ", errno, " , sqlstate : ", sqlstate)
    return factory.close(db)
end

if #res == 0 then
    local insert_sql = "insert into my_test (a,b) values ("
            ..ngx.quote_sql_str(args.a)..","
            .. ngx.quote_sql_str(args.b)..")"
    res, err, errno, sqlstate = db:query(insert_sql)
    if not res then
        ngx.say("insert error : ", err, " , errno : ", errno, " , sqlstate : ", sqlstate)
        return factory.close(db)
    end

    ngx.say("a,b xxxx 存储成功",args.a,"_",args.b)
else
    ngx.say("a,b yyyy 已经存在",args.a,"_",args.b)
end

factory.close(db)
return
