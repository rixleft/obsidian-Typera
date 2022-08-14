-- 通过 * 查询users中的所有数据
-- select * from users

-- 从 users 表中把 username 和 password 对应的数据查询出来
-- select username ,password from users

-- 向 users 表中插入新数据， username 的值为 tony stark password 的值为 098123
-- insert into users (username, password) values ('tony stark', '098123')
-- select * from users

-- 将 id 为 4 的用户密码，更新为 888888
-- update users set password='888888' where id=4
-- update users set password='admin123', status=1 where id=2
-- select * from users

-- 从 user 表中删除数据
-- delete from users where id=4
-- select * from users

-- 演示 where 子句的使用
-- select * from users where status=1
-- select * from users where id>2
-- select * from users where username<>'ls'
-- select * from users where username!='ls'
-- 演示 and 运算符
-- select * from users where status=0 and id<3
-- 演示 or 运算符
-- select * from users where username='zs' or status=0
-- 对 users 表中的数据，按照 status 字段进行升序排序
-- select * from users order by status ASC
-- 对 users 表中的数据，按照 id 字段进行降序排序
-- select * from users order by id DESC
-- 对 users 表中的数据，按照 status 字段进行升序排序，按照 id 字段进行降序排序
-- select * from users order by status DESC, username ASC

-- 使用 count(*) 来统计 users 表中，状态为0的用户的总数量
-- select count(*) from users where status=0

-- 使用 AS 关键字给列起别名
-- select count(*) as total from users where status=0
-- select username as uname, password as upwd from users 