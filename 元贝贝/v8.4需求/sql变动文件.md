# sql变动文件

```sql
-- 权益规格表变动
ALTER TABLE spec_sku
ADD COLUMN show_flag TINYINT DEFAULT 0 NULL COMMENT '是否在患者端“我的权益”页面展示(默认0不展示)' AFTER tenant_id;
ALTER TABLE spec_sku
ADD COLUMN inquiry_duration INT DEFAULT NULL COMMENT '问诊时长(小时)' AFTER show_flag;
ALTER TABLE spec_sku
ADD COLUMN question_count INT DEFAULT NULL  COMMENT '提问次数' AFTER inquiry_duration;
ALTER TABLE spec_sku
    add read_time_flag tinyint default 0 null comment '是否实时读取（0否 1是 默认0）' after question_count;
alter table spec_sku
    add amount int null comment '权益原始价格(单位: 分）' after read_time_flag;
alter table spec_sku
    add inquiry_type varchar(16) null comment '问诊类型（图文问诊1 电话问诊2 视频问诊3' after amount;
alter table spec_sku
    modify purchase_amount int null comment '再次购买价格(单位: 分)';
-- 套餐权益规格(SKU)-变动
ALTER TABLE spec_package_sku
ADD COLUMN inquiry_duration INT DEFAULT NULL COMMENT '问诊时长(小时)' AFTER tenant_id;
ALTER TABLE spec_package_sku
ADD COLUMN question_count INT DEFAULT NULL  COMMENT '提问次数' AFTER inquiry_duration;
ALTER TABLE spec_package_sku
    add read_time_flag tinyint default 0 null comment '是否实时读取（0否 1是 默认0）' after question_count;
alter table spec_package_sku
    add amount int null comment '权益原始价格(单位: 分' after read_time_flag;
alter table spec_package_sku
    add inquiry_type varchar(16) null comment '问诊类型（图文问诊1 电话问诊2 视频问诊3' after amount;
alter table spec_package_sku
    modify purchase_amount int null comment '再次购买价格(单位: 分)';

```

```sql
-- 问诊详情表新增字段
alter table pt_inquiry_order_detail
    add consultation_amount decimal(10, 2) not null comment '问诊金额';

alter table pt_inquiry_order_detail
    add discount_amount decimal(10, 2) not null comment '优惠金额';

alter table pt_inquiry_order_detail
    add pay_amount decimal(10, 2) not null comment '实付金额';

```

```sql
-- 权益使用记录新增字段
alter table spec_user_use_sku_record
    add payAmount int null comment '实付价(单位: 分)' after save_amount;

alter table spec_user_use_sku_record
    add amount int null comment '原价(单位: 分)' after payAmount;

alter table spec_user_use_sku_record
    add user_package_sku_icon varchar(256) null comment '用户权益图标ICON' after amount;

alter table spec_user_use_sku_record
    add user_package_sku_name varchar(256) null comment '用户套餐权益名称' after user_package_sku_icon; 
```

```sql
-- 用户单独购买权益订单表
alter table spec_user_purchase_sku_order
    add used_flag tinyint default 0 null comment '权益已使用标识(默认未使用)';
```

```sql
-- 问诊详情表新增字段
alter table pt_inquiry_order_detail
    add user_package_sku_icon varchar(256) null comment '用户权益图标ICON' after pay_amount;

alter table pt_inquiry_order_detail
    add user_package_sku_name varchar(256) null comment '用户套餐权益名称' after user_package_sku_icon;
```