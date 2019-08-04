	--//subquery
select * from 
(select pas.empi,max(pas.atrdt) as atrdt from (select * from pd_attribution_aco_020819 where atrdt <= '2019-04-01' ) pas group by pas.empi) paos
inner join pd_attribution_aco_020819 paoos on (paoos.empi=paos.empi and paoos.atrdt=paos.atrdt);

--finalquery with newpd visit but its not right enough 
select pv.planname as track ,pa.rn as chapter,pa.orgn as pcp_org_name,pa.slid as pcp_facility_id,
pa.sln as pcp_facility_name,
pa.pcpnpi,pv.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,
ftnpi  as facility_npi
from pd_visit_new_01 pv
left join (	
select paoos.empi,paoos.rn,paoos.orgtin,paoos.orgn,paoos.slid,paoos.sln,paoos.pcpnpi,paoos.orgtin from 
(select pas.empi,max(pas.atrdt) as atrdt from (select * from pd_attribution_aco_020819 where atrdt <= '2019-04-01' ) pas group by pas.empi) paos
inner join pd_attribution_aco_020819 paoos on (paoos.empi=paos.empi and paoos.atrdt=paos.atrdt)
) as pa on pv.empi=pa.empi 
where pv.visitstartdate between '2018-05-01' and '2019-04-30' and pv.payerid = '1'
group by
facility_npi,
pa.pcpnpi,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,pa.rn,pa.slid,pv.pcpname,pa.orgn,pa.sln,chapter;

--final query bilkul i think perfect/orgtin add krna h bas abhi isme

select pv.planname as track ,pa.rn as chapter,pa.orgn as pcp_org_name,pa.slid as pcp_facility_id,
pa.sln as pcp_facility_name,
pa.pcpnpi,pv.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,
ftnpi  as facility_npi
from pd_visit_1 pv
inner join (	
select paoos.empi,paoos.rn,paoos.orgtin,paoos.orgn,paoos.slid,paoos.sln,paoos.pcpnpi,paoos.orgtin from 
(select pas.empi,max(pas.atrdt) as atrdt from (select * from pd_attribution_aco_020819 where atrdt <= '2019-04-01' ) pas group by pas.empi) paos
inner join pd_attribution_aco_020819 paoos on (paoos.empi=paos.empi and paoos.atrdt=paos.atrdt)
) as pa on pv.empi=pa.empi 
where pv.visitstartdate between '2018-05-01' and '2019-04-30' and pv.payerid = '1'
group by
facility_npi,
pa.pcpnpi,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,pa.rn,pa.slid,pv.pcpname,pa.orgn,pa.sln;

