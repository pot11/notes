# 表索引

```sql
-- ----------------------------
-- 项目表
-- ----------------------------
ALTER TABLE `enterprise-admin`.`enterprise_admin_project`
    ADD INDEX `idx_enterprise_id`(`enterprise_id`) USING BTREE,
    ADD INDEX `idx_project_resource_id`(`project_resource_id`) USING BTREE;

-- ----------------------------
-- 账号表
-- ----------------------------
ALTER TABLE `enterprise-admin`.`enterprise_admin_account`
    ADD INDEX `idx_enterprise_id`(`enterprise_id`) USING BTREE,
    ADD INDEX `idx_role_id`(`role_id`) USING BTREE;

-- ----------------------------
-- 区域表
-- ----------------------------
ALTER TABLE `enterprise-admin`.`enterprise_admin_area`
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 账号运营人表
-- ----------------------------
ALTER TABLE `wechat-mini-program`.`wechat_mini_program_account_operator`
    ADD INDEX `idx_user_id`(`user_id`) USING BTREE;

-- ----------------------------
-- 项目账号运营人表
-- ----------------------------
ALTER TABLE `wechat-mini-program`.`wechat_mini_program_project_account_operator`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE,
    ADD INDEX `idx_area_id`(`area_id`) USING BTREE,
    ADD INDEX `idx_store_id`(`store_id`) USING BTREE;

-- ----------------------------
-- 抖音账号表
-- ----------------------------
ALTER TABLE `wechat-mini-program`.`wechat_mini_program_douyin_account`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 账号运营人扩展字段表
-- ---------------------------
ALTER TABLE `wechat-mini-program`.`wechat_mini_program_account_operator_extend_field`
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 抖音账号每日数据分析
-- ---------------------------
ALTER TABLE `wechat-mini-program`.`data_analysis_douyin_video_by_day_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 抖音账号七日数据分析
-- ---------------------------
ALTER TABLE `wechat-mini-program`.`data_analysis_douyin_video_by_seven_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 抖音账号三十日数据分析
-- ---------------------------
ALTER TABLE `wechat-mini-program`.`data_analysis_douyin_video_by_thirty_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 抖音账号每日数据分析（数据分析库）
-- ---------------------------
ALTER TABLE `data-analysis`.`data_analysis_douyin_video_by_day_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 抖音账号七日数据分析（数据分析库）
-- ---------------------------
ALTER TABLE `data-analysis`.`data_analysis_douyin_video_by_seven_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 抖音账号三十日数据分析（数据分析库）
-- ---------------------------
ALTER TABLE `data-analysis`.`data_analysis_douyin_video_by_thirty_data_analysis`
    ADD INDEX `idx_douyin_code`(`douyin_code`) USING BTREE;

-- ----------------------------
-- 现金表
-- ---------------------------
ALTER TABLE `point`.`point_user_cash`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 现金明细表
-- ---------------------------
ALTER TABLE `point`.`point_cash_detail`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE,
    ADD INDEX `idx_cash_withdraw_record_id`(`cash_withdraw_record_id`) USING BTREE;

-- ----------------------------
-- 提现记录表
-- ---------------------------
ALTER TABLE `point`.`point_cash_withdraw_record`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE,
    ADD INDEX `idx_out_batch_no`(`out_batch_no`) USING BTREE;

-- ----------------------------
-- 积分表
-- ---------------------------
ALTER TABLE `point`.`point_user_point`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 积分明细表
-- ---------------------------
ALTER TABLE `point`.`point_point_detail`
    ADD INDEX `idx_account_operator_id`(`account_operator_id`) USING BTREE,
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 脚本表
-- ---------------------------
ALTER TABLE `task`.`task_script`
    ADD INDEX `idx_project_id`(`project_id`) USING BTREE;

-- ----------------------------
-- 镜头分组表
-- ---------------------------
ALTER TABLE `task`.`task_shot_group`
    ADD INDEX `idx_script_id`(`script_id`) USING BTREE;

-- ----------------------------
-- 镜头表
-- ---------------------------
ALTER TABLE `task`.`task_shot`
    ADD INDEX `idx_shot_group_id`(`shot_group_id`) USING BTREE;

-- ----------------------------
-- 字幕表
-- ---------------------------
ALTER TABLE `task`.`task_subtitle`
    ADD INDEX `idx_shot_id`(`shot_id`) USING BTREE;

-- ----------------------------
-- 脚本快照表
-- ---------------------------
ALTER TABLE `task`.`task_script_snapshot`
    ADD INDEX `idx_script_id`(`script_id`) USING BTREE,
    ADD INDEX `idx_task_id`(`task_id`) USING BTREE;
```