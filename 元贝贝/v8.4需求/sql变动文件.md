# sql变动文件

```sql
-- 权益规格表——新增字段
ALTER TABLE spec_sku
ADD COLUMN show_flag TINYINT DEFAULT 1 NULL COMMENT '是否在患者端“我的权益”页面展示' AFTER purchase_flag;

-- 用户使用套餐规格记录表-新增字段
ALTER TABLE spec_user_use_sku_record 
ADD COLUMN save_amount INT DEFAULT NULL 
COMMENT '已省金额（通过优惠券、折扣、权益等活动节省的总金额）单位：分' 
AFTER user_package_id;
```