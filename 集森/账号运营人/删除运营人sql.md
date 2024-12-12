# 删除运营人相关sql

```sql
-- 运营人id:80 项目id:175 员工id:230 抖音accout_id:1003

-- 账号运营人表
select * from wechat_mini_program_project_account_operator where account_operator_id='80' and project_id='175' ;
-- 运营人抖音账号关联表
select * from wechat_mini_program_project_account_operator_douyin_account where account_operator_id='80' and project_id='175';
-- 数据分析
select * from wechat_mini_program_douyin_account_data_analysis where account_operator_id='80' and project_id='175';
-- 扩展字段值 
select * from wechat_mini_program_account_operator_extend_field_option_value where account_operator_id='33' and project_id='241' ;


-- 任务奖励相关
select * from task_task where project_id='175';
select * from task_task_record where account_operator_id='80' and task_id in(select task_id from task_task where project_id='175' and del_flag = 0) ;

select * from reward where task_id in(select task_id from task_task where project_id='175' and del_flag = 0) ;
select * from reward_account_operator where account_operator_id = '80'and reward_id in (select reward_id from reward where task_id in (select task_id from task_task where project_id = '175' and del_flag = 0));
```