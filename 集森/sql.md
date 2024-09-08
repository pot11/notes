# sql

## 项目管理sql

```script
-- 菜单 SQL
insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目', '3', '1', 'project', 'enterprise/project/index', 1, 0, 'C', '0', '0', 'enterprise:project:list', '', 'admin', sysdate(), '', null, '项目菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目查询', @parentId, '1',  '', '', 0, 1, 'F', '1', '1', 'enterprise:project:query',        '', 'admin', sysdate(), '', null, '');

insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目新增', @parentId, '2',  '', '', 0, 1, 'F', '1', '1', 'enterprise:project:add',          '', 'admin', sysdate(), '', null, '');

insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('项目修改', @parentId, '3',  '', '', 0, 1, 'F', '1', '1', 'enterprise:project:edit',         '', 'admin', sysdate(), '', null, '');
```  

## 区域管理

```script
-- 菜单 SQL
insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('区域', '3', '1', 'area', 'enterprise/area/index', 1, 0, 'C', '0', '0', 'enterprise:area:list', '', 'admin', sysdate(), '', null, '区域菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('区域查询', @parentId, '1',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:query',        '', 'admin', sysdate(), '', null, '');

insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('区域新增', @parentId, '2',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:add',          '', 'admin', sysdate(), '', null, '');

insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('区域修改', @parentId, '3',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:edit',         '', 'admin', sysdate(), '', null, '');

insert into enterprise_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('区域删除', @parentId, '4',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:remove',       '', 'admin', sysdate(), '', null, '');



-- 菜单 SQL
insert into operate_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('账号区域关联', '3', '1', 'area', 'enterprise/area/index', 1, 0, 'C', '0', '0', 'enterprise:area:list', '', 'admin', sysdate(), '', null, '账号区域关联菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into operate_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('账号区域关联查询', @parentId, '1',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:query',        '', 'admin', sysdate(), '', null, '');

insert into operate_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('账号区域关联新增', @parentId, '2',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:add',          '', 'admin', sysdate(), '', null, '');

insert into operate_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('账号区域关联修改', @parentId, '3',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:edit',         '', 'admin', sysdate(), '', null, '');

insert into operate_admin_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, menu_status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('账号区域关联删除', @parentId, '4',  '', '', 0, 1, 'F', '1', '1', 'enterprise:area:remove',       '', 'admin', sysdate(), '', null, '');


```
