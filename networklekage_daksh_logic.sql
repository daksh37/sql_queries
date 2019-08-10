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

--final sent to client

select pv.planname as track ,pa.rn as chapter,pa.orgn as pcp_org_name,pa.orgtin as pcp_org_tin,pa.slid as pcp_facility_id,
pa.sln as pcp_facility_name,
pa.pcpnpi,pa.pcpn as pcp_name,pv.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,po.orgtin as serviceproviderorgtin,
ftnpi  as facility_npi
from pd_visit_new_01 pv
left join 
(	
select distinct pa1.empi, 
first_value(rn) over (partition by pa1.empi order by (case when rn is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as rn,
first_value(orgtin) over (partition by pa1.empi order by (case when orgtin is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as orgtin,
first_value(orgn) over (partition by pa1.empi order by (case when orgn is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as orgn,
first_value(slid) over (partition by pa1.empi order by (case when slid is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as slid,
first_value(sln) over (partition by pa1.empi order by (case when sln is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as sln,
first_value(pcpnpi) over (partition by pa1.empi order by (case when pcpnpi is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as pcpnpi,
first_value(pcpn) over (partition by pa1.empi order by (case when pcpn is not null then 1 else 0 end) desc range between unbounded preceding and unbounded following) as pcpn
from pd_attribution_aco_020819 paos
inner join 
(
select empi, max(atrdt) as maxatrdt
from pd_attribution_aco_020819 where atrdt <= '2019-04-01' 
group by empi
)pa1 on (pa1.empi=paos.empi and pa1.maxatrdt=paos.atrdt)
) as pa on pv.empi=pa.empi 
left join pd_org po on pv.spnpi = po.prnpi
where pv.visitstartdate between '2018-05-01' and '2019-04-30' and pv.payerid = '1'
group by
facility_npi,
pa.pcpnpi,pa.pcpn,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,po.orgtin,pa.rn,pa.slid,pv.pcpname,pa.orgn,pa.orgtin,pa.sln;
