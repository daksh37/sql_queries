
//hb1ac
select plan_name,count(*) from quality_measure_new where qualification_status='DEN' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce'  
and date_trunc ('month',measurement_date::date)='2019-06-01' and lower(time_window)='ytd' and payer_id='1'
and member_empi in (select member_empi from quality_measure_new where qualification_status='NUM' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('month',measurement_date::date)='2018-12-01' and lower(time_window)='ytd') group by plan_name;
