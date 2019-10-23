Create table payer_attribution_2_snapshot as select distinct empi as member_empi,
Atrdt as attribution_date,
Plid as plan_id,
Atrl as attribution_logic,
UPPER(TRIM(Plnm)) as plan_name,
Prid as payer_id,
UPPER(TRIM(Prnm)) as payer_name,
Pcpnpi as pcp_npi,
UPPER(TRIM(Pcpn)) as pcp_name,
slnpi as practice_npi,
UPPER(TRIM(sln)) as practice_name,
Orgtin as org_tin, 
UPPER(TRIM(Orgn)) as org_name ,
Acoid as aco_id,
UPPER(TRIM(Acon)) as aco_name,
Pipid as pipeline_id,
Dod as date_of_death,
empi || '|' || substring(cast(atrdt as text) from 1 for 7) || prid || plid as empi_month_year_payer_plan,
slid as fcid,
orgid as orgid,
rid as rgid,
z_active_flg,
z_elg_flg as z_elg_flg,
UPPER(TRIM(Rn)) as chapter  from attribution_snapshot where atrl = 'Payer' 
and ((prid='1' and z_active_flg='Y' and z_elg_flg<>'0') or (prid<>'1')) ;


truncate payer_attribution_3_snapshot;
insert into payer_attribution_3_snapshot (member_empi,attribution_date1,plan_id,attribution_logic,plan_name,payer_id,payer_name,pcp_npi,pcp_name,practice_npi,practice_name,org_tin,org_name,aco_id,aco_name,pipeline_id,date_of_death,empi_month_year_payer_plan,fcid,orgid,rgid,chapter,attribution_date,z_elg_flg,z_active_flg)
select member_empi,attribution_date,plan_id,attribution_logic,plan_name,payer_id,payer_name,pcp_npi,pcp_name,practice_npi,practice_name,org_tin,org_name,aco_id,aco_name,pipeline_id,date_of_death,empi_month_year_payer_plan,fcid,orgid,rgid,chapter,attribution_date,z_elg_flg,z_active_flg
from payer_attribution_2_snapshot;


update payer_attribution_3_snapshot
set pcp_npi = '-1'
where pcp_npi is null
or pcp_npi = '';

update payer_attribution_3_snapshot
set fcid = '-1'
where fcid is null
or fcid = '';

update payer_attribution_3_snapshot
set orgid= '-1'
where orgid is null
or orgid = '';

update payer_attribution_3_snapshot
set rgid = '-1'
where rgid is null
or rgid = '';

update payer_attribution_3_snapshot
set attribution_date1 = '-1'
where attribution_date1 is null
or attribution_date1 = '';

update payer_attribution_3_snapshot
set key = rgid || '|' || orgid || '|' || fcid || '|' || pcp_npi || '|' || substring(attribution_date1 from 1 for 7);
