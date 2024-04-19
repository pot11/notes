 

2021年12月16日

18:57

 

update econ_inpatient_charge z

set z.doctor_code =

(select b.create_user

from clinic_imp_order_list b

where b.id = z.order_id)

where z.order_id in

(select a.order_id

from econ_inpatient_charge a, clinic_imp_order_list b

where a.visit_code = b.visit_code

and a.order_id = b.id

and a.system_type=\'03\'

and a.doctor_code is null

and a.visit_code = \'1311920\');
