Dict_Element语句

2021年10月9日

11:30

 

create or replace view hipip_dict_element as

select \"SYSCODE\",\"DICT_CODE\",\"ELEMENT_CODE\",\"ELEMENT_NAME\",\"DICT_NAME\"

from HIPIP_DICT_ELEMENT_PF m

union all

select \'HIP\' AS SYSCODE,

T.DICT_CODE,

T.ELEMENT_CODE,

T.ELEMENT_NAME,

D.DICT_NAME

from hipcs.dict_element@db_his t, hipcs.DICT@db_his D

WHERE T.DICT_CODE = D.DICT_CODE and D.status_code=\'ACTIVE\';
