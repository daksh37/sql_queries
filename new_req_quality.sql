
//hb1ac
select plan_name,count(*) from quality_measure_new where qualification_status='DEN' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce'  
and date_trunc ('month',measurement_date::date)='2019-06-01' and lower(time_window)='ytd' and payer_id='1'
and member_empi in (select member_empi from quality_measure_new where qualification_status='NUM' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd') group by plan_name;


select *
from quality_measure_new qmo join  
(select qo.* from quality_measure_new qm
join quality_measure_operand qo on qm.key_operand=qo.key_operand
where qm.qualification_status='NUM' and qm.measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd') foo on qmo.key_operand= foo.key_operand
where qmo.qualification_status='DEN' and qmo.measure_id='cd66c533-a5fd-413d-b090-c78785cbadce'  
and date_trunc ('month',measurement_date::date)='2019-06-01' and lower(time_window)='ytd' and payer_id='1' 
and qmo.member_empi in (select member_empi from quality_measure_new where qualification_status='NUM' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd')
;
