Create table payer_attribution_2_test as select distinct empi as member_empi,
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
UPPER(TRIM(Rn)) as chapter  from attribution_total where atrl = 'Payer' ;


create table payer_attribution_3_test (like payer_attribution_2_test);

alter table payer_attribution_3_test add column attribution_date1 varchar(255);
alter table payer_attribution_3_test add column key varchar(1000);


insert into payer_attribution_3_test (member_empi,attribution_date1,plan_id,attribution_logic,plan_name,payer_id,payer_name,pcp_npi,pcp_name,practice_npi,practice_name,org_tin,org_name,aco_id,aco_name,pipeline_id,date_of_death,empi_month_year_payer_plan,fcid,orgid,rgid,chapter,attribution_date,z_elg_flg,z_active_flg)
select member_empi,attribution_date,plan_id,attribution_logic,plan_name,payer_id,payer_name,pcp_npi,pcp_name,practice_npi,practice_name,org_tin,org_name,aco_id,aco_name,pipeline_id,date_of_death,empi_month_year_payer_plan,fcid,orgid,rgid,chapter,attribution_date,z_elg_flg,z_active_flg
from payer_attribution_2_test;

update payer_attribution_3_test
set pcp_npi = '-1'
where pcp_npi is null
or pcp_npi = '';

update payer_attribution_3_test
set fcid = '-1'
where fcid is null
or fcid = '';

update payer_attribution_3_test
set orgid= '-1'
where orgid is null
or orgid = '';

update payer_attribution_3_test
set rgid = '-1'
where rgid is null
or rgid = '';

update payer_attribution_3_test
set attribution_date1 = '-1'
where attribution_date1 is null
or attribution_date1 = '';

update payer_attribution_3_test
set key = rgid || '|' || orgid || '|' || fcid || '|' || pcp_npi || '|' || substring(attribution_date1 from 1 for 7);



create view member_one_test as 
WITH summary AS (
    select *,ROW_NUMBER() OVER(PARTITION by empi ORDER BY atrdt DESC) AS rk from
		(
		SELECT distinct empi,fn,ln,dob,gn,atrdt,pcpn,pcpnpi,rid,rn,prid,prnm,plid,plnm,id from attribution_total where atrl = 'Payer'
		) a
      )SELECT empi,
fn as first_name,
ln as last_name,
dob as date_of_birth,
gn as gender,
UPPER(TRIM(pcpn)) as pcp_name,
pcpnpi as pcp_npi,
rid as chapter_id,
UPPER(TRIM(rn)) as chapter,
prid as payer_id,
UPPER(TRIM(prnm)) as payer_name,
plid as plan_id,
UPPER(TRIM(plnm)) as plan_name,
atrdt as attribution_date,id as id
FROM summary
WHERE summary.rk = 1;



select * from member_one_test;
