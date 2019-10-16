
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
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd') foo on foo.member_empi=qmo.member_empi 
where qmo.qualification_status='DEN' and qmo.measure_id='cd66c533-a5fd-413d-b090-c78785cbadce'  
and date_trunc ('month',measurement_date::date)='2019-06-01' and lower(time_window)='ytd' and payer_id='1' 
and qmo.member_empi in (select member_empi from quality_measure_new where qualification_status='NUM' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd')
;

//custom table query

create table quality_caregap_test as 
select sub19.member_empi,sub19.measure_id ,sub19.version_id,sub19.key_operand, '1' as caregap_flag from 
(select  * from quality_measure_new  qmo
where qmo.qualification_status='DEN' 
and lower(time_window)='ytd' and payer_id='1' and  measurement_date in (select max(measurement_date) from quality_measure_new where payer_id='1')) sub19
join 
(select * from quality_measure_new where qualification_status='NUM' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd') sub18 on sub19.member_empi=sub18.member_empi and sub18.measure_id=sub19.measure_id
;
