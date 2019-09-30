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


select count(*),lower(foo.chapter),lower(foo.planname) from (
select distinct t2.visitid, 1 as ip_readmission_flag_ip_to_ip,t3.chapter,t3.planname from      
        (select empi,visitstartdate,visitenddate,visitid,pcpregionname as chapter,planname
        from pd_visit_combined
         where visitsubtype='Acute Inpatient' and visitstartdate between '2018-07-01' and '2019-06-30') t3
        left join         
        (select empi,visitstartdate,visitenddate,visitid,diagnosisrelatedgroupcode,pcpservicelocationname as chapter
        from pd_visit_combined where visitsubtype='Acute Inpatient' and visitstartdate between '2018-07-01' and '2019-06-30') t2       
        on (t3.empi=t2.empi and (t2.visitstartdate-t3.visitenddate)<=30
        and (t2.visitstartdate-t3.visitenddate)>0 and t3.visitid!=t2.visitid) where t2.visitid is not null) foo group by lower(foo.chapter),lower(foo.planname);
