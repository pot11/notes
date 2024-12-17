```sql

-- 更新授权运营人抖音授权时间为抖音账号更新时间
UPDATE wechat_mini_program_project_account_operator_douyin_account AS pa
JOIN wechat_mini_program_douyin_account AS da
  ON pa.douyin_account_id = da.douyin_account_id
JOIN wechat_mini_program_project_account_operator AS po
  ON pa.account_operator_id = po.account_operator_id
  AND pa.project_id = po.project_id
SET
  pa.douyin_authorization_time = da.update_time,
  pa.update_by = '里维1210',
  pa.update_time = NOW()
WHERE
  da.del_flag = 0
  AND po.del_flag = 0
  AND pa.publish_capability_authorization_status = 1;

-- 更新取消授权运营人抖音授权时间为抖音账号更新时间
UPDATE wechat_mini_program_project_account_operator_douyin_account AS pa
JOIN wechat_mini_program_douyin_account AS da
  ON pa.douyin_account_id = da.douyin_account_id
JOIN wechat_mini_program_project_account_operator AS po
  ON pa.account_operator_id = po.account_operator_id
  AND pa.project_id = po.project_id
SET
  pa.cancel_douyin_authorization_time = da.update_time,
  pa.update_by = '里维1210',
  pa.update_time = NOW()
WHERE
  da.del_flag = 0
  AND po.del_flag = 0
  AND pa.publish_capability_authorization_status = 3;

-- 插入数据分析
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