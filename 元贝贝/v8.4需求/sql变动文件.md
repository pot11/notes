# sql变动文件

```sql
-- 权益规格表变动
ALTER TABLE spec_sku
ADD COLUMN inquiry_duration INT DEFAULT NULL COMMENT '问诊时长(小时)' AFTER service_flow_desc;
ALTER TABLE spec_sku
ADD COLUMN question_count INT DEFAULT NULL  COMMENT '提问次数' AFTER inquiry_duration;
ALTER TABLE spec_sku
ADD COLUMN show_flag TINYINT DEFAULT 1 NULL COMMENT '是否在患者端“我的权益”页面展示' AFTER purchase_flag;
alter table spec_sku
    add original_amount int null comment '权益原始价格(单位: 分' after show_flag;
alter table spec_sku
    modify purchase_amount int null comment '再次购买价格(单位: 分)';
-- 套餐权益规格(SKU)-变动
ALTER TABLE spec_package_sku
ADD COLUMN inquiry_duration INT DEFAULT NULL COMMENT '问诊时长(小时)' AFTER service_flow_desc;
ALTER TABLE spec_package_sku
ADD COLUMN question_count INT DEFAULT NULL  COMMENT '提问次数' AFTER inquiry_duration;
alter table spec_package_sku
    add original_amount int null comment '权益原始价格(单位: 分' after additional_info;
alter table spec_package_sku
    modify purchase_amount int null comment '再次购买价格(单位: 分)';
```