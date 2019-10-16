select * from quality_measure_new where qualification_status='DEN' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce'  
and date_trunc ('year',measurement_date::date)='2019-01-01' and time_window='ytd'
and member_empi in (select member_empi from quality_measure_new where qualification_status='NUM' and measure_id='cd66c533-a5fd-413d-b090-c78785cbadce' 
and date_trunc ('year',measurement_date::date)='2018-01-01' and time_window='ytd');
