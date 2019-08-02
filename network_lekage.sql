

--shilpi
select pv.planname as track ,pa.chapter,pa.pcporgtin,pa.pcporgname,pa.pcpfacilityid,pa.pcpfacilityname,
pa.pcpnpi,pa.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,po.orgtin as serviceproviderorgtin,
ftnpi 
from pd_visit_new_01 pv
left join
(select empi,orgn as pcporgname, orgtin as pcporgtin,pcpn as pcpname,pcpnpi,rn as chapter,
slid as pcpfacilityid,sln as pcpfacilityname, max(atrdt) as last_attribution_date 
from pd_attribution_aco_020819 group by empi,orgn,orgtin,pcpn,pcpnpi,rn,slid,sln
) pa on pv.empi=pa.empi 
left join pd_org po on pv.spnpi = po.prnpi 
where visitstartdate between '2018-05-01' and '2019-04-30' and payerid = '1'
group by
pa.pcporgname,pa.pcporgtin,ftnpi,
pa.pcpname,pa.pcpnpi,pa.pcpname,pa.pcpfacilityid,pa.pcpfacilityname,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,pa.chapter,po.orgtin;

--prashant
select pv.empi,pv.planname as track ,pa.chapter,pa.pcporgtin,pa.pcporgname,pa.pcpfacilityid,pa.pcpfacilityname,
pa.pcpnpi,pa.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,po.orgtin as serviceproviderorgtin,
ftnpi 
from pd_visit_new_01 pv
left join
(select empi,orgn as pcporgname, orgtin as pcporgtin,pcpn as pcpname,pcpnpi,rn as chapter,
slid as pcpfacilityid,sln as pcpfacilityname
from pd_attribution_aco_020819 where atrdt='2018-04-01' and prid='1' group by empi,orgn,orgtin,pcpn,pcpnpi,rn,slid,sln
) pa on pv.empi=pa.empi 
left join pd_org po on pv.spnpi = po.prnpi 
where visitstartdate between '2018-05-01' and '2019-04-30' and payerid = '1'
group by
pv.empi,pa.pcporgname,pa.pcporgtin,ftnpi,
pa.pcpname,pa.pcpnpi,pa.pcpname,pa.pcpfacilityid,pa.pcpfacilityname,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,pa.chapter,po.orgtin;

--daksh

select pv.planname as track ,pa.rn as chapter,pa.orgtin as pcp_org_tin,pa.orgn as pcp_org_name,pa.slid as pcp_facility_id,
pa.sln as pcp_facility_name,
pa.pcpnpi,pv.pcpname,sum(visitamount) as amount, 
count(distinct visitid) as visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
split_part(visittype,':',1) as visittype,visitsubtype,pa.orgtin as serviceproviderorgtin,
ftnpi  as facility_npi
from pd_visit_new_01 pv
left join pd_attribution_aco_020819 pa on pv.empi=pa.empi and atrdt='2019-04-01'
where pv.visitstartdate between '2018-05-01' and '2019-04-30' and pv.payerid = '1'
group by
facility_npi,
pa.pcpnpi,split_part(visittype,':',1),
visitsubtype,pv.planname,pv.ccsdiseasecode,pv.ccsdiseasecodedescription,pa.rn,pa.slid,pv.pcpname,pa.orgtin,pa.orgn,pa.sln;

