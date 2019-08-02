CREATE TABLE pd_visit_new_01
(
empi text,
pcpregionname text,
pcporganizationid text,
pcporganizationname text,
pcporganizationtin text,
pcpservicelocationid text,
pcpservicelocationname text,
pcpregionid text,
pcpnpi text,
pcpname text,
payerid text,
payername text,
planid text,
planname text,
opnpi text,
spnpi text,
ftnpi text,
episodenpi text ,
diagnosisrelatedgroupcode text ,
primarydiagnosis text ,
primaryprocedure text ,
ccsdiseasecode text ,
ccsdiseasecodedescription text ,
claimamount float, 
visitid text ,
visitamount float ,
length_of_stay int,
visittype text,
visitsubtype text ,
visitstartdate DATE,
visitenddate DATE,
episodeamount FLOAT,
episodeenddate  DATE,
episodeexecutionmode text,
episodeid text ,
episodestartdate  DATE,
episodesubtype text ,
episodetype text ,
out_of_network_flag INT ,
ip_readmission_flag_ip_to_ip INT ,
ip_readmission_flag_ip_to_snf INT,
visitsubtype1 TEXT,
qexpu_cost_centre TEXT,
ed_flag INT);

--Truncate pd_visit_1;

Insert into pd_visit_new_01
(empi ,pcpregionname ,pcporganizationid ,pcporganizationname ,pcporganizationtin ,pcpservicelocationid ,pcpservicelocationname ,pcpregionid ,pcpnpi ,pcpname ,payerid ,payername ,planid ,planname ,opnpi ,spnpi ,ftnpi ,episodenpi  ,diagnosisrelatedgroupcode  ,primarydiagnosis  ,primaryprocedure  ,ccsdiseasecode  ,ccsdiseasecodedescription,  claimamount, visitid  ,visitamount ,length_of_stay ,visittype ,visitsubtype  ,visitstartdate ,visitenddate ,episodeamount ,episodeenddate  ,episodeexecutionmode ,episodeid  ,episodestartdate  ,episodesubtype  ,episodetype  ,out_of_network_flag ,visitsubtype1,qexpu_cost_centre,ed_flag)
select distinct
t2.empi ,
t2.pcpregionname ,
t2.pcporganizationid ,
t2.pcporganizationname ,
t2.pcporganizationtin ,
t2.pcpservicelocationid ,
t2.pcpservicelocationname ,
t2.pcpregionid ,
t2.pcpnpi ,
t2.pcpname ,
t2.payerid ,
t2.payername,
t2.planid ,
t2.planname ,
t2.opnpi ,
t2.spnpi ,
t2.ftnpi ,
t1.episodenpi  ,
t2.diagnosisrelatedgroupcode  ,
t2.primarydiagnosis  ,
t2.primaryprocedure  ,
t2.ccsdiseasecode  ,
t2.ccsdiseasecodedescription  , 
t2.claimamount,
t1.visitid  ,
t1.visitamount ,
(t1.visitenddate - t1.visitstartdate) length_of_stay ,
t1.visittype ,
Case when t1.visitsubtype = 'Acute Inpatient Claim' then 'Acute Inpatient' else t1.visitsubtype end as visitsubtype,
t1.visitstartdate ,
t1.visitenddate ,
t1.episodeamount,
t1.episodeenddate  ,
t1.episodeexecutionmode ,
t1.episodeid  ,
t1.episodestartdate  ,
t1.episodesubtype  ,
t1.episodetype  ,
case when t2.spnpi in (select prnpi from pd_org) then 0 else 1 end out_of_network_flag,
case 
when primaryprocedure in ('G0438','G0439','G0402') then 'Annual wellness Visits' 
when diagnosisrelatedgroupcode in ('637','638','639') then 'Diabetes Admits'
when diagnosisrelatedgroupcode in ('291','292','293') then 'Heart Failure Admits'
When diagnosisrelatedgroupcode in ('190','191','192') then 'COPD'
when primarydiagnosis in (  'A1810', 'A1811', 'A1812', 'A1813', 'A3685', 'A5275', 'A5401', 'A5611', 'A5619', 'A985', 'B650', 'B901', 'N10', 'N110', 'N118', 'N119', 'N12', 'N135', 'N136', 'N151', 'N2884', 'N2885', 'N2886', 'N3000', 'N3001', 'N3010', 'N3011', 'N3020', 'N3021', 'N3030', 'N3031', 'N3080', 'N3081', 'N3090', 'N3091', 'N340', 'N342', 'N343', 'N390', 'C600', 'C601', 'C602', 'C608', 'C609', 'C61', 'C6200', 'C6201', 'C6202', 'C6210', 'C6211', 'C6212', 'C6290', 'C6291', 'C6292', 'C6300', 'C6301', 'C6302', 'C6310', 'C6311', 'C6312', 'C632', 'C637', 'C638', 'C639', 'C763', 'C7982', 'D074', 'D075', 'D0760', 'D0761', 'D0769', 'D400', 'D4010', 'D4011', 'D4012', 'D408', 'D409', 'E164', 'K2210', 'K2211', 'K2270', 'K2271', 'K2271', 'K2271', 'K251', 'K253', 'K255', 'K257', 'K259', 'K261', 'K263', 'K265', 'K267', 'K269', 'K271', 'K273', 'K275', 'K277', 'K279', 'K281', 'K283', 'K285', 'K287', 'K289', 'K311', 'K315', 'Q430', 'A3700', 'A3701', 'A3710', 'A3711', 'A3780', 'A3781', 'A3790', 'A3791', 'J0410', 'J0411', 'J200', 'J201', 'J202', 'J203', 'J204', 'J205', 'J206', 'J207', 'J208', 'J209', 'J210', 'J211', 'J218', 'J219', 'J398', 'J4', 'B', 'J410', 'J4520', 'J4521', 'J4522', 'J4530', 'J4531', 'J4532', 'J4540', 'J4541', 'J4542', 'J4550', 'J4551', 'J4552', 'J4590', 'J4590', 'J4590', 'J4599', 'J4599', 'J4599', 'J9801', 'J9809', 'J930', 'J9311', 'J9312', 'J9381', 'J9382', 'J9383', 'J939', 'J9581', 'J9581', 'J982', 'S270XXA', 'S271XXA', 'S272XXA', 'T797XXA', 'B4481', 'B909', 'D860', 'D861', 'D862', 'D863', 'D8681', 'D8682', 'D8683', 'D8684', 'D8685', 'D8686', 'D8687', 'D8689', 'D869', 'J6', 'C', 'J6', 'P', 'J620', 'J628', 'J630', 'J631', 'J632', 'J633', 'J634', 'J635', 'J636', 'J64', 'J65', 'J660', 'J661', 'J662', 'J668', 'J670', 'J671', 'J672', 'J673', 'J674', 'J675', 'J676', 'J677', 'J678', 'J679', 'J701', 'J82', 'J8401', 'J8402', 'J8403', 'J8409', 'J8410', 'J84111', 'J84112', 'J84113', 'J84114', 'J84115', 'J84116', 'J84117', 'J8417', 'J842', 'J8481', 'J8482', 'J8483', 'J84841', 'J84842', 'J84843', 'J84848', 'J8489', 'J849', 'J99', 'M0510', 'M0511', 'M0511', 'M0511', 'M0512', 'M0512', 'M0512', 'M0513', 'M0513', 'M0513', 'M0514', 'M0514', 'M0514', 'M0515', 'M0515', 'M0515', 'M0516', 'M0516', 'M0516', 'M0517', 'M0517', 'M0517', 'M0519', 'M3481', 'P270', 'P271', 'P278', 'P279', 'B4481', 'B909', 'D860', 'D861', 'D862', 'D863', 'D8681', 'D8682', 'D8683', 'D8684', 'D8685', 'D8686', 'D8687', 'D8689', 'D869', 'J60', 'J61', 'J620', 'J628', 'J630', 'J631', 'J632', 'J633', 'J634', 'J635', 'J636', 'J64', 'J65', 'J660', 'J661', 'J662', 'J668', 'J670', 'J671', 'J672', 'J673', 'J674', 'J675', 'J676', 'J677', 'J678', 'J679', 'J701', 'J82', 'J8401', 'J8402', 'J8403', 'J8409', 'J8410', 'J84111', 'J84112', 'J84113', 'J84114', 'J84115', 'J84116', 'J84117', 'J8417', 'J842', 'J8481', 'J8482', 'J8483', 'J84841', 'J84842', 'J84843', 'J84848', 'J8489', 'J849', 'J99', 'M0510', 'M0511', 'M05112', 'M05119', 'M05121', 'M05122', 'M05129', 'M05131', 'M05132', 'M05139', 'M05141', 'M05142', 'M05149', 'M05151', 'M05152', 'M05159', 'M05161', 'M05162', 'M05169', 'M05171', 'M05172', 'M05179', 'M0519', 'M3481', 'P270', 'P271', 'P278', 'P279', 'B330', 'J09X1', 'J09X2', 'J1000', 'J1001', 'J1008', 'J101', 'J1100', 'J1108', 'J120', 'J121', 'J122', 'J123', 'J1281', 'J1289', 'J129', 'J1', 'P', 'J1', 'P', 'J153', 'J154', 'J157', 'J159', 'J160', 'J168', 'J180', 'J181', 'J188', 'J189', 'J920', 'J929', 'J941', 'J949', 'R091', 'J411', 'J418', 'J4', 'U', 'J430', 'J431', 'J432', 'J438', 'J439', 'J440', 'J441', 'J449', 'J470', 'J471', 'J479', 'J684', 'J688', 'J689', 'Q334', 'J411', 'J418', 'J4', 'U', 'J430', 'J431', 'J432', 'J438', 'J439', 'J440', 'J441', 'J449', 'J470', 'J471', 'J479', 'J684', 'J688', 'J689', 'Q334', 'C700', 'C701', 'C709', 'C710', 'C711', 'C712', 'C713', 'C714', 'C715', 'C716', 'C717', 'C718', 'C719', 'C720', 'C721', 'C7220', 'C7221', 'C7222', 'C7230', 'C7231', 'C7232', 'C7240', 'C7241', 'C7242', 'C7250', 'C7259', 'C729', 'C753', 'C754', 'C755', 'C7931', 'C7932', 'C7940', 'C7949', 'D320', 'D321', 'D329', 'D330', 'D331', 'D332', 'D333', 'D334', 'D337', 'D339', 'D354', 'D355', 'D356', 'D420', 'D421', 'D429', 'D430', 'D431', 'D432', 'D433', 'D434', 'D438', 'D439', 'D445', 'D446', 'D447', 'D496', 'G041', 'G800', 'G801', 'G802', 'G8220', 'G8221', 'G8222', 'G8250', 'G8251', 'G8252', 'G8253', 'G8254', 'G830', 'R532', 'S140XXA', 'S140XXS', 'S14101A', 'S14101S', 'S14102A', 'S14102S', 'S14103A', 'S14103S', 'S14104A', 'S14104S', 'S14105A', 'S14105S', 'S14106A', 'S14106S', 'S14107A', 'S14107S', 'S14108A', 'S14108S', 'S14109A', 'S14109S', 'S14111A', 'S14111S', 'S14112A', 'S14112S', 'S14113A', 'S14113S', 'S14114A', 'S14114S', 'S14115A', 'S14115S', 'S14116A', 'S14116S', 'S14117A', 'S14117S', 'S14118A', 'S14118S', 'S14119A', 'S14119S', 'S14121A', 'S14121S', 'S14122A', 'S14122S', 'S14123A', 'S14123S', 'S14124A', 'S14124S', 'S14125A', 'S14125S', 'S14126A', 'S14126S', 'S14127A', 'S14127S', 'S14128A', 'S14128S', 'S14129A', 'S14129S', 'S14131A', 'S14131S', 'S14132A', 'S14132S', 'S14133A', 'S14133S', 'S14134A', 'S14134S', 'S14135A', 'S14135S', 'S14136A', 'S14136S', 'S14137A', 'S14137S', 'S14138A', 'S14138S', 'S14139A', 'S14139S', 'S14141A', 'S14141S', 'S14142A', 'S14142S', 'S14143A', 'S14143S', 'S14144A', 'S14144S', 'S14145A', 'S14145S', 'S14146A', 'S14146S', 'S14147A', 'S14147S', 'S14148A', 'S14148S', 'S14149A', 'S14149S', 'S14151A', 'S14151S', 'S14152A', 'S14152S', 'S14153A', 'S14153S', 'S14154A', 'S14154S', 'S14155A', 'S14155S', 'S14156A', 'S14156S', 'S14157A', 'S14157S', 'S14158A', 'S14158S', 'S14159A', 'S14159S', 'S240XXA', 'S240XXS', 'S24101A', 'S24101S', 'S24102A', 'S24102S', 'S24103A', 'S24103S', 'S24104A', 'S24104S', 'S24109A', 'S24109S', 'S24111A', 'S24111S', 'S24112A', 'S24112S', 'S24113A', 'S24113S', 'S24114A', 'S24114S', 'S24119A', 'S24119S', 'S24131A', 'S24131S', 'S24132A', 'S24132S', 'S24133A', 'S24133S', 'S24134A', 'S24134S', 'S24139A', 'S24139S', 'S24141A', 'S24141S', 'S24142A', 'S24142S', 'S24143A', 'S24143S', 'S24144A', 'S24144S', 'S24149A', 'S24149S', 'S24151A', 'S24151S', 'S24152A', 'S24152S', 'S24153A', 'S24153S', 'S24154A', 'S24154S', 'S24159A', 'S24159S', 'S3401XA', 'S3401XS', 'S3402XA', 'S3402XS', 'S34101A', 'S34101S', 'S34102A', 'S34102S', 'S34103A', 'S34103S', 'S34104A', 'S34104S', 'S34105A', 'S34105S', 'S34109A', 'S34109S', 'S34111A', 'S34111S', 'S34112A', 'S34112S', 'S34113A', 'S34113S', 'S34114A', 'S34114S', 'S34115A', 'S34115S', 'S34119A', 'S34119S', 'S34121A', 'S34121S', 'S34122A', 'S34122S', 'S34123A', 'S34123S', 'S34124A', 'S34124S', 'S34125A', 'S34125S', 'S34129A', 'S34129S', 'S34131A', 'S34131S', 'S34132A', 'S34132S', 'S34139A', 'S34139S', 'S343XXA', 'A1810', 'A1811', 'A1812', 'A1813', 'A3685', 'A5275', 'A5401', 'A5611', 'A5619', 'A985', 'B650', 'B901', 'N10', 'N110', 'N118', 'N119', 'N12', 'N135', 'N136', 'N151', 'N2884', 'N2885', 'N2886', 'N3000', 'N3001', 'N3010', 'N3011', 'N3020', 'N3021', 'N3030', 'N3031', 'N3080', 'N3081', 'N3090', 'N3091', 'N340', 'N342', 'N343', 'N390', 'C600', 'C601', 'C602', 'C608', 'C609', 'C61', 'C6200', 'C6201', 'C6202', 'C6210', 'C6211', 'C6212', 'C6290', 'C6291', 'C6292', 'C6300', 'C6301', 'C6302', 'C6310', 'C6311', 'C6312', 'C632', 'C637', 'C638', 'C639', 'C763', 'C7982', 'D074', 'D075', 'D0760', 'D0761', 'D0769', 'D400', 'D4010', 'D4011', 'D4012', 'D408', 'D409', 'E164', 'K2210', 'K2211', 'K2270', 'K2271', 'K2271', 'K2271', 'K251', 'K253', 'K255', 'K257', 'K259', 'K261', 'K263', 'K265', 'K267', 'K269', 'K271', 'K273', 'K275', 'K277', 'K279', 'K281', 'K283', 'K285', 'K287', 'K289', 'K311', 'K315', 'Q430', 'A3700', 'A3701', 'A3710', 'A3711', 'A3780', 'A3781', 'A3790', 'A3791', 'J0410', 'J0411', 'J200', 'J201', 'J202', 'J203', 'J204', 'J205', 'J206', 'J207', 'J208', 'J209', 'J210', 'J211', 'J218', 'J219', 'J398', 'J4', 'B', 'J410', 'J4520', 'J4521', 'J4522', 'J4530', 'J4531', 'J4532', 'J4540', 'J4541', 'J4542', 'J4550', 'J4551', 'J4552', 'J4590', 'J4590', 'J4590', 'J4599', 'J4599', 'J4599', 'J9801', 'J9809', 'J930', 'J9311', 'J9312', 'J9381', 'J9382', 'J9383', 'J939', 'J9581', 'J9581', 'J982', 'S270XXA', 'S271XXA', 'S272XXA', 'T797XXA', 'B4481', 'B909', 'D860', 'D861', 'D862', 'D863', 'D8681', 'D8682', 'D8683', 'D8684', 'D8685', 'D8686', 'D8687', 'D8689', 'D869', 'J6', 'C', 'J6', 'P', 'J620', 'J628', 'J630', 'J631', 'J632', 'J633', 'J634', 'J635', 'J636', 'J64', 'J65', 'J660', 'J661', 'J662', 'J668', 'J670', 'J671', 'J672', 'J673', 'J674', 'J675', 'J676', 'J677', 'J678', 'J679', 'J701', 'J82', 'J8401', 'J8402', 'J8403', 'J8409', 'J8410', 'J84111', 'J84112', 'J84113', 'J84114', 'J84115', 'J84116', 'J84117', 'J8417', 'J842', 'J8481', 'J8482', 'J8483', 'J84841', 'J84842', 'J84843', 'J84848', 'J8489', 'J849', 'J99', 'M0510', 'M0511', 'M0511', 'M0511', 'M0512', 'M0512', 'M0512', 'M0513', 'M0513', 'M0513', 'M0514', 'M0514', 'M0514', 'M0515', 'M0515', 'M0515', 'M0516', 'M0516', 'M0516', 'M0517', 'M0517', 'M0517', 'M0519', 'M3481', 'P270', 'P271', 'P278', 'P279', 'B4481', 'B909', 'D860', 'D861', 'D862', 'D863', 'D8681', 'D8682', 'D8683', 'D8684', 'D8685', 'D8686', 'D8687', 'D8689', 'D869', 'J60', 'J61', 'J620', 'J628', 'J630', 'J631', 'J632', 'J633', 'J634', 'J635', 'J636', 'J64', 'J65', 'J660', 'J661', 'J662', 'J668', 'J670', 'J671', 'J672', 'J673', 'J674', 'J675', 'J676', 'J677', 'J678', 'J679', 'J701', 'J82', 'J8401', 'J8402', 'J8403', 'J8409', 'J8410', 'J84111', 'J84112', 'J84113', 'J84114', 'J84115', 'J84116', 'J84117', 'J8417', 'J842', 'J8481', 'J8482', 'J8483', 'J84841', 'J84842', 'J84843', 'J84848', 'J8489', 'J849', 'J99', 'M0510', 'M0511', 'M05112', 'M05119', 'M05121', 'M05122', 'M05129', 'M05131', 'M05132', 'M05139', 'M05141', 'M05142', 'M05149', 'M05151', 'M05152', 'M05159', 'M05161', 'M05162', 'M05169', 'M05171', 'M05172', 'M05179', 'M0519', 'M3481', 'P270', 'P271', 'P278', 'P279', 'B330', 'J09X1', 'J09X2', 'J1000', 'J1001', 'J1008', 'J101', 'J1100', 'J1108', 'J120', 'J121', 'J122', 'J123', 'J1281', 'J1289', 'J129', 'J1', 'P', 'J1', 'P', 'J153', 'J154', 'J157', 'J159', 'J160', 'J168', 'J180', 'J181', 'J188', 'J189', 'J920', 'J929', 'J941', 'J949', 'R091', 'J411', 'J418', 'J4', 'U', 'J430', 'J431', 'J432', 'J438', 'J439', 'J440', 'J441', 'J449', 'J470', 'J471', 'J479', 'J684', 'J688', 'J689', 'Q334', 'J411', 'J418', 'J4', 'U', 'J430', 'J431', 'J432', 'J438', 'J439', 'J440', 'J441', 'J449', 'J470', 'J471', 'J479', 'J684', 'J688', 'J689', 'Q334', 'C700', 'C701', 'C709', 'C710', 'C711', 'C712', 'C713', 'C714', 'C715', 'C716', 'C717', 'C718', 'C719', 'C720', 'C721', 'C7220', 'C7221', 'C7222', 'C7230', 'C7231', 'C7232', 'C7240', 'C7241', 'C7242', 'C7250', 'C7259', 'C729', 'C753', 'C754', 'C755', 'C7931', 'C7932', 'C7940', 'C7949', 'D320', 'D321', 'D329', 'D330', 'D331', 'D332', 'D333', 'D334', 'D337', 'D339', 'D354', 'D355', 'D356', 'D420', 'D421', 'D429', 'D430', 'D431', 'D432', 'D433', 'D434', 'D438', 'D439', 'D445', 'D446', 'D447', 'D496', 'G041', 'G800', 'G801', 'G802', 'G8220', 'G8221', 'G8222', 'G8250', 'G8251', 'G8252', 'G8253', 'G8254', 'G830', 'R532', 'S140XXA', 'S140XXS', 'S14101A', 'S14101S', 'S14102A', 'S14102S', 'S14103A', 'S14103S', 'S14104A', 'S14104S', 'S14105A', 'S14105S', 'S14106A', 'S14106S', 'S14107A', 'S14107S', 'S14108A', 'S14108S', 'S14109A', 'S14109S', 'S14111A', 'S14111S', 'S14112A', 'S14112S', 'S14113A', 'S14113S', 'S14114A', 'S14114S', 'S14115A', 'S14115S', 'S14116A', 'S14116S', 'S14117A', 'S14117S', 'S14118A', 'S14118S', 'S14119A', 'S14119S', 'S14121A', 'S14121S', 'S14122A', 'S14122S', 'S14123A', 'S14123S', 'S14124A', 'S14124S', 'S14125A', 'S14125S', 'S14126A', 'S14126S', 'S14127A', 'S14127S', 'S14128A', 'S14128S', 'S14129A', 'S14129S', 'S14131A', 'S14131S', 'S14132A', 'S14132S', 'S14133A', 'S14133S', 'S14134A', 'S14134S', 'S14135A', 'S14135S', 'S14136A', 'S14136S', 'S14137A', 'S14137S', 'S14138A', 'S14138S', 'S14139A', 'S14139S', 'S14141A', 'S14141S', 'S14142A', 'S14142S', 'S14143A', 'S14143S', 'S14144A', 'S14144S', 'S14145A', 'S14145S', 'S14146A', 'S14146S', 'S14147A', 'S14147S', 'S14148A', 'S14148S', 'S14149A', 'S14149S', 'S14151A', 'S14151S', 'S14152A', 'S14152S', 'S14153A', 'S14153S', 'S14154A', 'S14154S', 'S14155A', 'S14155S', 'S14156A', 'S14156S', 'S14157A', 'S14157S', 'S14158A', 'S14158S', 'S14159A', 'S14159S', 'S240XXA', 'S240XXS', 'S24101A', 'S24101S', 'S24102A', 'S24102S', 'S24103A', 'S24103S', 'S24104A', 'S24104S', 'S24109A', 'S24109S', 'S24111A', 'S24111S', 'S24112A', 'S24112S', 'S24113A', 'S24113S', 'S24114A', 'S24114S', 'S24119A', 'S24119S', 'S24131A', 'S24131S', 'S24132A', 'S24132S', 'S24133A', 'S24133S', 'S24134A', 'S24134S', 'S24139A', 'S24139S', 'S24141A', 'S24141S', 'S24142A', 'S24142S', 'S24143A', 'S24143S', 'S24144A', 'S24144S', 'S24149A', 'S24149S', 'S24151A', 'S24151S', 'S24152A', 'S24152S', 'S24153A', 'S24153S', 'S24154A', 'S24154S', 'S24159A', 'S24159S', 'S3401XA', 'S3401XS', 'S3402XA', 'S3402XS', 'S34101A', 'S34101S', 'S34102A', 'S34102S', 'S34103A', 'S34103S', 'S34104A', 'S34104S', 'S34105A', 'S34105S', 'S34109A', 'S34109S', 'S34111A', 'S34111S', 'S34112A', 'S34112S', 'S34113A', 'S34113S', 'S34114A', 'S34114S', 'S34115A', 'S34115S', 'S34119A', 'S34119S', 'S34121A', 'S34121S', 'S34122A', 'S34122S', 'S34123A', 'S34123S', 'S34124A', 'S34124S', 'S34125A', 'S34125S', 'S34129A', 'S34129S', 'S34131A', 'S34131S', 'S34132A', 'S34132S', 'S34139A', 'S34139S', 'S343XX')
then 'Potentially Preventable Admits' 
when diagnosisrelatedgroupcode in ('001','005','011','016','020','023','025','028','031','034','037','040','052','054','056','058','061','064','067','070','073','075','077','080','082','085','088','091','094','097','100','102','113','116','121','124','129','131','133','135','137','146','150','152','154','157','163','166','175','177','180','183','186','190','193','196','199','202','205','216','219','222','224','226','228','231','233','235','239','242','246','248','250','252','255','258','260','266','280','283','286','288','291','294','296','299','302','304','306','308','314','326','329','332','335','338','341','344','347','350','353','356','368','371','374','377','380','383','385','388','391','393','405','408','411','414','417','420','423','432','435','438','441','444','453','456','459','461','463','466','469','471','474','477','480','485','488','492','495','498','500','503','507','510','513','515','518','533','535','537','539','542','545','548','551','553','555','557','559','562','564','570','573','576','579','582','584','592','595','597','600','602','604','606','614','616','619','622','625','628','637','640','643','653','656','659','662','665','668','671','673','682','686','689','691','693','695','698','707','709','711','713','715','717','722','725','727','729','734','736','739','742','744','746','749','754','757','760','765','799','802','808','811','814','820','823','826','829','834','837','840','843','846','853','856','862','865','867','871','896','901','904','907','913','915','917','919','922','928','939','945','947','949','957','963','969','974','981','984','987') then 'Multi-Chronic Admits' 
when t1.visitsubtype = 'Acute Inpatient Claim' then 'Acute Inpatient'
else t1.visitsubtype end as visitsubtype1,
Case 
when visittype in ('Inpatient:Long-term stay hospital others','Inpatient:Psychiatric hospital or unit others',
	'Inpatient:Rehabilitation hospital or unit others','Inpatient:Short-term stay hospital others') then 'Hospital Inpatient Facility,Total'
when visittype in ('Inpatient:SNF Inpatient Claim') then 'Skilled Nursing Facility or Unit'
when visittype in ('Outpatient:Critical Access Hospital Others','Outpatient:Outpatient dialysis facility','Outpatient:Outpatient others') then 'Outpatient Facility'
when visittype in ('Outpatient:Home Health Outpatient') then 'Home Health Agency'
when visittype in ('Durable medical equipment:Durable medical equipment') then 'Durable Medical Equipment'
when visittype in ('Inpatient:Hospice Inpatient Claim') then 'Hospice'
when visittype in ('Professional:Part B Drugs others','Professional:Evaluation and management others','Professional:Procedures others','Professional:Laboratories others',
'Professional:Ambulance others','Professional:Professional others','Professional:Imaging others','Professional:Imaging; MRI','Professional:Imaging; CT',
'Professional:Specialist physician; Imaging') then 'Part B Physician/Supplier' else 'Others' end as qexpu_cost_centre,
case when ed_flag = 1  then ed_flag 
when payerid <> '1' and visitsubtype = 'ER Hospital' then 1 
else 0 end as ed_flag
from pd_claim_analytics_aggregate t1
left join
(select empi ,pcpregionname ,pcporganizationid ,pcporganizationname ,pcporganizationtin ,pcpservicelocationid ,pcpservicelocationname ,pcpregionid ,pcpnpi ,pcpname ,payerid ,payername ,planid ,planname ,opnpi ,spnpi ,ftnpi  ,diagnosisrelatedgroupcode  ,primarydiagnosis  ,primaryprocedure  ,ccsdiseasecode  ,ccsdiseasecodedescription , claimamount, visitid
		from (
				select empi ,pcpregionname ,pcporganizationid ,pcporganizationname ,pcporganizationtin ,pcpservicelocationid ,pcpservicelocationname ,pcpregionid ,pcpnpi ,pcpname ,payerid ,payername ,planid ,planname ,opnpi ,spnpi ,ftnpi  ,diagnosisrelatedgroupcode  ,primarydiagnosis  ,primaryprocedure  ,ccsdiseasecode  ,ccsdiseasecodedescription , claimamount, visitid,
					   ROW_NUMBER() over (partition by visitid order by claimamount desc) as weight_rank
				From pd_claim_analytics_claims) t1
		where t1.weight_rank = 1
) t2 on (t1.visitid=t2.visitid)
left join (select distinct visitid,1 as ed_flag from pd_claim_analytics_claims where  claimsubtype <> 'pair-cancelled' 
and (claimtype like '%Emergency%' or claimsubtype like '%Emergency%')) as t3 on t1.visitid = t3.visitid
;


update pd_visit_new_01
set pcpnpi = '-1'
where pcpnpi is null
or pcpnpi='';

update pd_visit_new_01
set pcpregionid = '-1'
where pcpregionid is null
or pcpregionid='';

update pd_visit_new_01
set pcporganizationid = '-1'
where pcporganizationid is null
or pcporganizationid='';

update pd_visit_new_01
set pcpservicelocationid = '-1'
where pcpservicelocationid is null
or pcpservicelocationid='';


ALTER TABLE pd_visit_new_01
ADD key text;

update pd_visit_new_01
set key = pcpregionid || '|' || pcporganizationid|| '|' || pcpservicelocationid || '|' || pcpnpi || '|' || substring(cast(visitstartdate as text) from 1 for 7);



----unused

update pd_visit_new_01
set ip_readmission_flag_ip_to_ip=t1.ip_readmission_flag_ip_to_ip
from (select distinct t2.visitid, 1 as ip_readmission_flag_ip_to_ip from      
        (select empi,visitstartdate,visitenddate,visitid 
        from pd_visit_new_01
         where visitsubtype='Acute Inpatient') t3
        left join         
        (select empi,visitstartdate,visitenddate,visitid,diagnosisrelatedgroupcode
        from pd_visit_new_01 where visitsubtype='Acute Inpatient') t2       
        on (t3.empi=t2.empi and (t2.visitstartdate-t3.visitenddate)<=30
        and (t2.visitstartdate-t3.visitenddate)>0 and t3.visitid!=t2.visitid) where t2.visitid is not null
     ) t1
     where pd_visit_new_01.visitid = t1.visitid;

update pd_visit_new_01
set ip_readmission_flag_ip_to_snf=t1.ip_readmission_flag_ip_to_snf
from (select distinct t3.visitid, 1 as ip_readmission_flag_ip_to_snf from
        (select empi,visitstartdate,visitenddate,visitid
        from pd_visit_new_01 where visitsubtype='Acute Inpatient') t3
        left join
        (select empi,visitstartdate,visitenddate,visitid,diagnosisrelatedgroupcode
        from pd_visit_new_01 where visitsubtype='SNF Inpatient Claim') t2
        on (t3.empi=t2.empi and (t2.visitstartdate-t3.visitenddate)<=30
        and (t2.visitstartdate-t3.visitenddate)>0 and t3.visitid!=t2.visitid) where t2.visitid is not null
     ) t1
     where pd_visit_new_01.visitid = t1.visitid;







