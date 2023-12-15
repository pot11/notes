
# 批量插入

- mapper文件  
  
```xml
<insert id="insertList" parameterType="list">
        insert into CLINIC_AMB_ORDER_EXEC_LOG(
        ID,ORDER_ID,ORDER_NO,ORDER_GROUP_NO,VISIT_CODE,ORDER_NAME,
        EXEC_LOG_TYPE,REMARK,CREATE_USER,CREATE_DATE
        )
        SELECT CLINIC_AMB_ORDER_EXEC_LOG_ID.nextval AS ID,A.* FROM (
        <foreach collection="list" item="item" index="index" separator="union all" >
            select
                #{item.orderId,jdbcType=DECIMAL},
                #{item.orderNo,jdbcType=DECIMAL},
                #{item.orderGroupNo,jdbcType=DECIMAL},
                #{item.visitCode,jdbcType=VARCHAR},
                #{item.orderName,jdbcType=VARCHAR},
                #{item.execLogType,jdbcType=VARCHAR},
                #{item.remark,jdbcType=VARCHAR},
                #{item.createUser,jdbcType=VARCHAR},
                #{item.createDate,jdbcType=TIMESTAMP}
            from dual
        </foreach>
        ) A
    </insert>
```

- sql文件  
  
```sql
insert into CLINIC_AMB_ORDER_EXEC_LOG( ID,ORDER_ID,ORDER_NO,ORDER_GROUP_NO,VISIT_CODE,ORDER_NAME, EXEC_LOG_TYPE,REMARK,CREATE_USER,CREATE_DATE ) SELECT CLINIC_AMB_ORDER_EXEC_LOG_ID.nextval AS ID,A.*
 FROM ( select 8066509, 1.0, 1.0, '1985938', '辅酶Q10胶囊', '医嘱提交', null, , 008008
 FROM dual
 UNION all select 2023-12-15 14:57:16.0, 8066510, 2.0, 2.0, 1985938, 磁共振胸背部平扫, 医嘱提交, null, 008008, 2023-12-15 14:57:16.0
 FROM dual ) A;
```
