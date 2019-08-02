
--create krna h abhi fir insert 
--insert alaag alag krke for diff tracks taaki -- na ho baad me ki duplicate h as 1 empi can be in more tha n 1 track
--need to fix attribution ka order ka column for good results

insert into pd_claim_analytics_claims
(
select distinct billtype,claimprocessdate,revenuecentrecode, activity_rxc, serviceproviderspecialitycode,
activity_uqt, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8,ad9,ad10,ad11,ad12,ad13,ad14,ad15,ad16,ad17,ad18,ad19,ad20,ad21,ad22,ad23,ad24, 
adjustmentstatuscode, ap1, ap2, ap3, ap4,ap5,
aja.atrdt as attributiondate, aja.z_elg_flg, ccsdiseasecode, ccsdiseasecodedescription, claimamount, claimid, claimlinegroupid,
claimsubtype, claimtype, dateofbirth, diagnosisrelatedgroupcode, diagnosisrelatedgroupname, pdu.empi, firstdateofservice,
firstname, ftnpi,ftnpi_name, ftnpi_speciality, ftnpi_type, gender, lastdateofservice, lastname, 
measureconfigid,measureid, measureversionid, middlename,  opnpi,  opnpi_name,
opnpi_speciality, opnpi_type, outofnetworkstatusoption, aja.prid as payerid,aja.prnm as payername,aja.acoid as
pcpacoid,aja.acon as pcpaconame,aja.pcpnpi, aja.pcpn as pcpname,aja.orgid as pcporganizationid,aja.orgn as
pcporganizationname,aja.orgtin as pcporganizationtin,aja.rid as pcpregionid,aja.rn as pcpregionname,aja.slid as
pcpservicelocationid, aja.sln as pcpservicelocationname,aja.pcpsc as pcpspecialitycode,aja.pcps as
pcpspecialityname,'ytd' as periodmode,aja.plid as planid,aja.plnm as planname, pm1, pm2, pm3, pm4, primarydiagnosis,
primarydiagnosiscodingsystem, primaryprocedure, primaryprocedurecodingsystem, pdu.sno, sourcetype, spnpi, spnpi_name,
spnpi_speciality, spnpi_type, subsourcetype, visitid
from pd_claim_analytics_claim_line_0807 pdu
inner join attribution_18_19 aja on pdu.empi = aja.empi and date_trunc('month',firstdateofservice) = date_trunc('month',atrdt)
and prid = '1' and plid = '1' and subsourcetype = 'Medicare Shared Savings Track 3');


-- Aggregate  data ingestion

insert into pd_claim_analytics_aggregate
select empi, episodeamount, episodeenddate, episodeexecutionmode, episodeid, episodenpi, episodenpientitytype, episodenpiname,
episodenpispeciality, episodepcpeventid, episodestartdate, episodesubtype, episodetype, eventamount, eventenddate,
eventid, eventstartdate, eventsubtype, eventtype, measureconfigid, null as measuredate, measureid, measureversionid,
null as measurewindow, sno, visitamount, visitenddate, visitid, visitstartdate, visitsubtype, visittype
from pd_claim_analytics_aggregate_0807 where visitid in (select distinct visitid from pd_claim_analytics_claims);

/*
Medicare Shared Savings Track 1 +
Medicare Shared Savings Track 1 Rural
Medicare Shared Savings Track 3
Medicare Shared Savings Track 1 Urban 
*/