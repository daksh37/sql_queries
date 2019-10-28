insert into  network_leakage_output_v2  select track ,pa.rn as chapter,pa.orgn as pcp_org_name,pa.orgtin as pcp_org_tin,pa.slid as pcp_facility_id,pa.sln as pcp_facility_name,
pa.pcpnpi,pa.pcpn as pcp_name,sum(visitamount) as amount,
count(distinct visitid) as  visit_count,pv.ccsdiseasecode as ccs_code,pv.ccsdiseasecodedescription as ccs_name,
visittype,visitsubtype, ftnpi  as facility_npi, servicingproviderNPI,servicingProviderOrgtin,outorgflg,outftnpiflg,case when outorgflg ='IN' then 'ORG_IN'
when outftnpiflg = 'IN' then  'FACILITY_IN' else 'OUT' end as network_status,'2019-05-31' as measurementdate
from  
(
select distinct planname as track,empi, pas.visitid,ccsdiseasecode, ccsdiseasecodedescription,ftnpi,spnpi as servicingproviderNPI, activity_orgtin as servicingProviderOrgtin,
split_part(visittype,':',1) as visittype, visitsubtype, visitamount,outorgflg,outftnpiflg  from
(
select distinct planname,visitid,ccsdiseasecode, ccsdiseasecodedescription,ftnpi, spnpi, activity_orgtin,
row_number() over (partition by visitid order by claimamount desc) as w_rank,out.network as outftnpiflg,outorg.network outorgflg
from pd_claim_analytics_claim_line_snapshot
left join out_network_npi out on ftnpi=out.facility_npi and (claimlinegroupid like '%CCLF2%'  or
claimlinegroupid like  '%CCLF3%' or
claimlinegroupid like '%CCLF4%')
left join out_network_org_tin outorg on activity_orgtin=outorg.tin and claimlinegroupid like  '%CCLF5%'
where firstdateofservice between '2018-06-01' and '2019-05-31' and payerid = '1'
)x
inner join pd_claim_analytics_aggregate_snapshot pas on x.visitid = pas.visitid
where w_rank = '1'
) as pv
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
from pd_attribution_aco_020819 where atrdt <= '2019-05-01'
group by empi
)pa1 on (pa1.empi=paos.empi and pa1.maxatrdt=paos.atrdt)
) as pa on pv.empi=pa.empi
group by  track ,pa.rn ,pa.orgn,pa.orgtin ,pa.slid ,pa.sln ,
pa.pcpnpi,pa.pcpn ,pv.ccsdiseasecode,pv.ccsdiseasecodedescription ,
visittype,visitsubtype, ftnpi, servicingproviderNPI,servicingProviderOrgtin,outorgflg,outftnpiflg,measurementdate;
