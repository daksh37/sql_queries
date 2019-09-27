CREATE view chapter_dimension_new AS select distinct rid AS chapter_id, upper(trim(rn)) as chapter_name from attribution_snapshot;

CREATE table org_dimension_new AS select distinct orgtin ,upper(trim(orgn)) as org_name from attribution_snapshot
union select distinct orgtin ,orgnm as org_name from pd_org_270919 where orgtin not in (select distinct orgtin from attribution_snapshot);

create table facility_dimension_new as select distinct slid as fcid, upper(trim(sln)) as facility_name from attribution_snapshot
union select distinct pcpservicelocationid as fcid, upper(trim(pcpservicelocationname)) as facility_name from pd_visit_combined
union select distinct slid as fcid,upper(trim(practice_name)) as facility_name from quality_measure_new;

CREATE table pcp_dimension_new AS (select distinct npi,upper(trim(name)) as pcp_name from pd_npi_270919 where npi in (select distinct pcpnpi from attribution_snapshot)); 
