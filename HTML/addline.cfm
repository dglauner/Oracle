<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />

  <head>
    <title>Add Job Line</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
	<!-- Validate input -->
	<cfif !IsDefined("Form.jobid") AND !IsDefined("Form.Add")>
		<cflocation url="home.cfm">
	</cfif>
	
	<cfif !IsDefined("Form.jobid") AND !IsDefined("Form.lineid") AND !IsDefined("Form.Update")>
		<cflocation url="home.cfm">
	</cfif>
	
	<cfparam name="doinsert" default="false">
	
	<cfparam name="LINEACTUAL" default="">
	<cfparam name="LINEDESC" default="">
	<cfparam name="LINEESTIMATE" default="">
	<cfparam name="LINENOTES" default="">
	<cfparam name="APPLDESC" default="Unassigned">
	<cfparam name="APPLID" default="-1">
	<cfparam name="techid" default="-1">
	<cfparam name="techname" default="Unassigned">
	
	
	<cfif IsDefined("Form.Add")>
		<cfset doinsert = "true"> 
	<cfelse>
		<cfif !IsDefined("Form.jobid") AND !IsDefined("Form.Add")>
			<cflocation url="index.cfm">
		</cfif>
		
		<cfquery name="getJobLines"
			 datasource=#APPLICATION.DSN#
			 username=#APPLICATION.username#
			 password=#APPLICATION.password#>
			select j.LINE_ACTUAL, j.LINE_DESC, j.LINE_ESTIMATE, j.LINE_NOTES, nvl(a.APPL_DESC,'Unassigned') as APPL_DESC, 
			nvl(t.TECH_NAME,'Unassigned') as TECH_NAME, nvl(j.APPL_ID,-1) as APPL_ID, nvl(j.TECH_ID,-1) as TECH_ID
			from FPJOB_LINE j, FPAPPLIANCE a, FPTECHNICIAN t
			where j.APPL_ID = a.APPL_ID(+)
			and j.TECH_ID = t.TECH_ID(+)
			and j.JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
			and j.line_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.lineid#" maxLength = "11">
		</cfquery>
		<cfoutput query="getJobLines">
			<cfset LINEDESC = "#LINE_DESC#">
			<cfset LINENOTES = "#LINE_NOTES#">
			<cfset LINEESTIMATE = "#LINE_ESTIMATE#">
			<cfset LINEACTUAL = "#LINE_ACTUAL#">
			<cfset APPLDESC = "#APPL_DESC#">
			<cfset APPLID = "#APPL_ID#">	
			<cfset techname = "#tech_name#">
			<cfset techid = "#tech_id#">			
		</cfoutput>
	</cfif>

	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<cfif doinsert is "false">
				<h1>Update Job Line</h1>
			<cfelse>
				<h1>Add New Job Line</h1>
			</cfif>
		</div>
		<cfoutput>
		<cfset myaction="jobdetails.cfm">
		<CFFORM NAME="UpdateLine" ACTION="#myaction#">
			<table style="width: 100%">
				<tr>
					<td class="text-right" style="width: 25%"><label>Description:&nbsp;</label></td>
					<td style="width: 75%">
						<CFINPUT TYPE="Text"
						NAME="desc"
						VALUE="#LINEDESC#"
						REQUIRED="Yes"
						ONERROR="Error text"
						MAXLENGTH="100"
						size="100"
						validate="regex" 
						pattern="/^[a-zA-Z]{1,}$/"		
						message="A Description is Required"						
						class="form-control">
						<input type="hidden" name="desc_required">
					</td>
				</tr>
				<tr>
					<td class="text-right" style="width: 25%"><label>Notes:&nbsp;</label></td>
					<td style="width: 75%">
						<CFINPUT TYPE="Text"
						NAME="notes"
						VALUE="#LINENOTES#"
						REQUIRED="No"
						ONERROR="Error text"
						MAXLENGTH="100" 
						class="form-control">
					</td>
				</tr>
				<tr>
					<td class="text-right" style="width: 25%"><label>ESTIMATE:&nbsp;</label></td>
					<td style="width: 75%">
						<CFINPUT TYPE="Text"
						NAME="ESTIMATE"
						VALUE="#LINEESTIMATE#"
						REQUIRED="Yes"
						ONERROR="Error text"
						MAXLENGTH="12" 
						message="A ESTIMATE is Required"
						class="form-control">
						<input type="hidden" name="ESTIMATE_required">
					</td>
				</tr>
				<tr>
					<td class="text-right" style="width: 25%"><label>ACTUAL:&nbsp;</label></td>
					<td style="width: 75%">
						<CFINPUT TYPE="Text"
						NAME="ACTUAL"
						VALUE="#LINEACTUAL#"
						REQUIRED="No"
						ONERROR="Error text"
						MAXLENGTH="12" 
						class="form-control">
					</td>
				</tr>
				<tr>
					<td class="text-right" style="width: 25%"><label>Technician:&nbsp;</label></td>
					<td style="width: 75%">#techname#</td>
				</tr>
				<tr>
					<td class="text-right" style="width: 25%"><label>Appliance:&nbsp;</label></td>
					<td style="width: 75%">#APPLDESC#</td>
				</tr>				
			</table>
				<cfif doinsert is "true">
					<button type="submit" value="Add" name="Add" class="btn btn-default">Save</button> 
				<cfelse>
					<button type="submit" value="Update" name="Update" class="btn btn-default">Update</button>
					<input type="hidden" name="lineid" value="#Form.lineid#"/>
				</cfif>
				<input type="hidden" name="jobid" value="#Form.jobid#"/>		
		</CFFORM>
		
			<form action="jobdetails.cfm" method="post">
				<button type="Cancel" value="Cancel" class="btn btn-default">Cancel</button>
				<cfoutput>
				<input type="hidden" name="jobid" value="#Form.jobid#"/>
				</cfoutput>
			</form>	
		</cfoutput>			
		</div>
	</div>
	
  </body>
</html>