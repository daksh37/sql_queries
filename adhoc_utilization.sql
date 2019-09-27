select lower(planname),lower(pcpregionname),count( visitid) 
from pd_visit_combined where visitstartdate between '2018-07-01' and '2019-06-30' 
and ip_readmission_flag_ip_to_ip='1' and payerid='1'
group by  lower(planname),lower(pcpregionname);


select lower(planname),lower(pcpregionname),count( visitid) from pd_visit_combined
where visitstartdate between '2018-07-01' and '2019-06-30' 
and visitsubtype ='Acute Inpatient' and payerid='1'
group by  lower(planname),lower(pcpregionname);

select lower(planname),lower(pcpregionname),count(visitid) from pd_visit_combined
where visitstartdate between '2018-07-01' and '2019-06-30' 
and visitsubtype ='SNF Inpatient Claim' and payerid='1'
group by  lower(planname),lower(pcpregionname);


select visitsubtype from pd_visit_combined group by visitsubtype;

select count(*)/12,plnm,rn from attribution_snapshot where prid='1' and rn is not null and atrdt between '2018-07-01' and '2019-06-30'
group by plnm,rn;



select visitsubtype from pd_visit_combined where payerid='1' group by visitsubtype;
