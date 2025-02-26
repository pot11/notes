# 项目集客优化sql

## 项目集客id补全sql
```sql
update wechat_mini_program_account_operator_extend_field_option_value as e
join wechat_mini_program_project_account_operator pa
on pa.account_operator_id = e.account_operator_id and pa.project_id = e.project_id
set
    e.project_jike_id = pa.project_jike_id
WHERE
  pa.del_flag = 0 and e.del_flag = 0;
```  

## 扩展字段sql

```sql
update wechat_mini_program_account_operator_extend_field  set visible = 0 where extend_field_name='phone';

update wechat_mini_program_account_operator_extend_field  set required = 0 where extend_field_name='memberCode';

```

## 平台集客表数据处理

```sql
UPDATE wechat_mini_program_account_operator AS ao
JOIN wechat_mini_program_user AS user
  ON ao.user_id = user.user_id
SET
  ao.wechat_avatar = user.wechat_avatar,
  ao.wechat_nickname = user.wechat_nickname
WHERE
  ao.del_flag = 0
  AND user.del_flag = 0;
```
