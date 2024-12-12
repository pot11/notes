# 数据处理sql

```sql
INSERT INTO wechat_mini_program_douyin_account_data_analysis (
    douyin_account_id,
    douyin_open_id,
    douyin_code,
    account_operator_id,
    project_id,
    remark
)
SELECT
    pda.douyin_account_id,
    da.douyin_open_id,
    da.douyin_code,
    pda.account_operator_id,
    pda.project_id,
    'xxx'
FROM wechat_mini_program_project_account_operator_douyin_account pda
INNER JOIN wechat_mini_program_douyin_account da
ON pda.douyin_account_id = da.douyin_account_id
WHERE
    da.del_flag = 0
ON DUPLICATE KEY UPDATE
    douyin_open_id = VALUES(douyin_open_id),
    douyin_code = VALUES(douyin_code),
    account_operator_id = VALUES(account_operator_id),
    project_id = VALUES(project_id);
```