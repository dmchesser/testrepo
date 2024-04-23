
SELECT * FROM tbEmployeeColorID_RefreshLog WHERE ModifiedDate >= DATEADD(day,-7,GETDATE()) 

------------------------
-- New records
------------------------
SELECT RecAction 
 ,StatusNew		-- Should all be 'A'
 ,LastNameNew LastName
 ,FirstNameNew Firstname
 ,EmployeeCodeNew
 ,DptCodeNew
 ,CASE WHEN LEN(DptCodeNew)=4 THEN '01.'+DptCodeNew
	   WHEN DptCodeNew='' THEN '01.9999'
	   ELSE DptCodeNew END Workgroup
 ,ProxNew
 ,ISNULL(ProxNew,0) CardNumber
 ,CAST(ModifiedDate as date) StartDate
 ,CAST(ModifiedDate as date) StartDateTime
 ,CAST('2099-12-31' as date) EndDate
 ,CAST('2099-12-31' as date) EndDateTime
FROM tbEmployeeColorID_RefreshLog
WHERE ModifiedDate >= DATEADD(day,-7,GETDATE())
  AND RecAction='INSERT'

--------------------------
-- Update records
------------------------
SELECT RecAction
 ,StatusNew
 ,LastNameNew LastName
 ,FirstNameNew Firstname
 ,EmployeeCodeNew
 ,DptCodeNew
 ,CASE WHEN LEN(DptCodeNew)=4 THEN '01.'+DptCodeNew
	   WHEN DptCodeNew='' THEN '01.9999'
	   ELSE DptCodeNew END Workgroup
 ,ProxNew
 ,COALESCE(ProxNew,ProxOld,0) CardNumber
 ,CAST(ModifiedDate as date) StartDate
 ,CAST(ModifiedDate as date) StartDateTime
 ,CASE WHEN StatusNew='I' then CAST(ModifiedDate as date) ELSE CAST('2099-12-31' as date) END EndDate
 ,CASE WHEN StatusNew='I' then CAST(ModifiedDate as date) ELSE CAST('2099-12-31' as date) END EndDateTime
FROM tbEmployeeColorID_RefreshLog
WHERE ModifiedDate >= DATEADD(day,-7,GETDATE())
  AND RecAction='UPDATE'

--select * from tbEmployeeColorID where LastName='Zeiler'

select * from tbEmployeeColorID_RefreshLog where EmployeeCodeNew=93576