<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Work Order Request System - Add Contact - Bind</title>
</head>
<body>

<style>
#DisplayLookUp div{float:left; width:225px; padding:2px;}
.LookUBtn{
  background-color:transparent;
  text-transform:uppercase; text-decoration:none; color:#004080; font-weight:bold;
  cursor:pointer;
  margin:2px 1px 1px 1px;
  border:none;
  display:inline-block;
}
#DisplayHeader{background-color:#C6E2FF; text-transform:uppercase; padding:3px;}
</style>

<cfset ReqID = #trim(GetAuthUser())#>
<cfparam name="url.LookThisUp" default="">
<cfset url.LookThisUp = htmlEditFormat(url.LookThisUp)>
<cfset url.LookThisUp = left(url.LookThisUp,255)>

<cfoutput>
<cfif #url.LookThisUp# IS ''>
  <!---Bind on Load show my frequent contacts--->
  <cfset myVar_DisplayHeader = 'my frequent contacts and wistar email lists'>
  <cfquery name="qLookUpUsers" datasource="HKWO">
    SELECT ContactEmail AS EMAIL, ContactName AS FULLNAME
    FROM AddressBook_WO
    WHERE ReqID = '#ReqID#' OR ReqID = 'Everybody'
    ORDER BY CASE WHEN ReqID = 'Everybody' THEN 1 ELSE 0 END, EMAIL
  </cfquery>	
<cfelse>  
  <!---Looking for Internal Users--->
  <cfset myVar_DisplayHeader = 'Wistar Employee directory'>
  <cfquery name="qLookUpUsers" datasource="General" maxrows="30">
    SELECT FIRST_NAME+' '+LAST_NAME AS FULLNAME, EMAIL
    FROM General.Central_Employees CE
    WHERE Wistar_Flag = 'Y' AND Term_Date IS NULL AND EMAIL != ''
      AND (CE.FIRST_NAME LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.LookThisUp#%" maxlength="255">
      OR CE.LAST_NAME LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.LookThisUp#%" maxlength="255">
      OR CE.EMAIL LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.LookThisUp#%" maxlength="255">)    
    ORDER BY CE.LAST_NAME
  </cfquery>
</cfif>

<!---DISPLAYING--->
<DIV id="DisplayHeader">
  #myVar_DisplayHeader#
</DIV>
<DIV id="DisplayLookUp">
  <!--LEFT BOX-->
  <div id="BoxOne">
	<cfif #qLookUpUsers.RecordCount# IS 0>
      <i>No contacts found.</i>	
    <cfelse>
	  <cfset myCnt_Box1 = 1><!--Counter for Left Box-->
      <cfloop query="qLookUpUsers" startrow="1" endrow="14">
        <cfif #trim(qLookUpUsers.FULLNAME)# IS 'N/A'> <!--From Frequent Contact Table-->
          <cfset myVar_showValue = #trim(qLookUpUsers.EMAIL)#>	
        <cfelse>
          <cfset myVar_showValue = #trim(qLookUpUsers.FULLNAME)#>
        </cfif>
        <input name="FullName#myCnt_Box1#" value="#myVar_showValue#" type="button" class="LookUBtn" id="NameIs#myCnt_Box1#"/>
        <input name="Email#myCnt_Box1#" value="#trim(qLookUpUsers.EMAIL)#" type="hidden" class="ABC" id="EmailIs#myCnt_Box1#"/>
        <input name="Cnter" value="#myCnt_Box1#" type="hidden" class="BBS" id="Cnter_ID" />
      <br />
      <cfset #myCnt_Box1# = #myCnt_Box1# + 1>
      </cfloop>
    </cfif>
  </div>    
      
  <!--RIGHT BOX-->
  <div id="BoxTwo">
	<cfset myCnt_Box2 = 1><!--Counter for Left Box-->
    <cfloop query="qLookUpUsers" startrow="15" endrow="30">
      <cfif #trim(qLookUpUsers.FULLNAME)# IS 'N/A'> <!--From Frequent Contact Table-->
        <cfset myVar_showValue = #trim(qLookUpUsers.EMAIL)#>	
      <cfelse>
        <cfset myVar_showValue = #trim(qLookUpUsers.FULLNAME)#>
      </cfif>      
      <input name="FullName#myCnt_Box2#" value="#myVar_showValue#" type="button" class="LookUBtn" id="NameIs#myCnt_Box2#"/>
      <input name="Email#myCnt_Box2#" value="#trim(qLookUpUsers.EMAIL)#" type="hidden" id="EmailIs#myCnt_Box2#"/>
      <br />
      <cfset #myCnt_Box2# = #myCnt_Box2# + 1>
    </cfloop>
  </div>    
</DIV>
</cfoutput>
</body>
</html>
