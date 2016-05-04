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
	<cfif !IsDefined("Form.jobid") AND !IsDefined("Form.lineid")>
		<cflocation url="home.cfm">
	</cfif>
	<cfparam name="didupdate" default="false">
	<!-- Do an update -->
	<cfif IsDefined("Form.techid") AND IsDefined("Form.applid") AND IsDefined("Form.jobid") AND IsDefined("Form.lineid") AND IsDefined("Form.Update")>
	<cfset didupdate = "true"> 
	<cftry>
					<cfquery name="updatefpJobLine"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						update fpJob_Line
						set
						<cfif Form.applid EQ -1 AND Form.techid EQ -1> 
							appl_id = NULL,
							tech_id = NULL
						<cfelse>
							appl_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.applid#" maxLength = "11">,
							tech_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.techid#" maxLength = "11">
						</cfif>
						where job_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
						AND line_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.lineid#" maxLength = "11">
					</cfquery>
					
					<cfcatch type = "Database"> 
						<!--- The message to display. ---> 
						<h3>You've Thrown a Database <b>Error</b></h3> 
						<cfoutput> 
							<!--- The diagnostic message from ColdFusion. ---> 
							<p>Caught an exception, type = #CFCATCH.TYPE#</p> 
							<p>#cfcatch.message#</p> 
							<p>#cfcatch.Sql#</p> 
							<p>#cfcatch.detail#</p> 
							
						</cfoutput> 
					</cfcatch> 
				<!--- Use cfcatch with type="Any" ---> 
				<!--- to find unexpected exceptions. ---> 
					<cfcatch type="Any"> 
						<cfoutput> 
							<hr> 
							<h1>Other Error: #cfcatch.Type#</h1> 
							<ul> 
								<li><b>Message:</b> #cfcatch.Message# 
								<li><b>Detail:</b> #cfcatch.Detail# 
							</ul> 
						</cfoutput> 
						<cfset errorCaught = "General Exception"> 
					</cfcatch>  
				</cftry>

	</cfif>

	<cfquery name="getAssignedSpeciality"
		 datasource=#APPLICATION.DSN#
		 username=#APPLICATION.username#
		 password=#APPLICATION.password#>
		 select nvl(tech_id,-1) as tech_id, nvl(appl_id,-1) as appl_id
		from FPJOB_LINE
		where JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
		and LINE_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.lineid#" maxLength = "11">
	</cfquery>
	
	<cfquery name="getSpecialities"
		 datasource=#APPLICATION.DSN#
		 username=#APPLICATION.username#
		 password=#APPLICATION.password#>
		 select s.APPL_ID, s.TECH_ID, a.APPL_DESC, t.TECH_NAME 
		from FPSPECIALTY s, FPAPPLIANCE a, FPTECHNICIAN t
		where s.APPL_ID = a.APPL_ID
		and t.TECH_ID = s.TECH_ID
	</cfquery>

	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
		<h1>Assign Specialist</h1>
		</div>
			<table style="width: 100%">
			<cfoutput query="getSpecialities">	
				<tr>
					<td class="text-right" style="width: 25%">
					<cfif #APPL_ID# eq #getAssignedSpeciality.APPL_ID# AND #TECH_ID# eq #getAssignedSpeciality.TECH_ID#>
						<label>#TECH_NAME#,&nbsp; #APPL_DESC#:&nbsp;</label>
					<cfelse>
						#TECH_NAME#,&nbsp; #APPL_DESC#:&nbsp;
					</cfif>
					</td>
					<td style="width: 75%">
						<CFFORM ACTION="AssignSpeciality.cfm">
							<button type="submit" value="Update" name="Update" class="btn btn-default">Assign</button>
							<input type="hidden" name="lineid" value="#Form.lineid#"/>
							<input type="hidden" name="jobid" value="#Form.jobid#"/>
							<input type="hidden" name="applid" value="#APPL_ID#"/>
							<input type="hidden" name="techid" value="#TECH_ID#"/>
						</CFFORM>
					</td>
				</tr>
			</cfoutput>
				<tr>
					<td class="text-right" style="width: 25%">
					<cfif -1 eq #getAssignedSpeciality.APPL_ID# AND -1 eq #getAssignedSpeciality.TECH_ID#>
						<label>Unassigned:&nbsp;</label>
					<cfelse>
						Unassigned:&nbsp;
					</cfif>
					</td>
					<td style="width: 75%">
						<CFFORM ACTION="AssignSpeciality.cfm">
							<button type="submit" value="Update" name="Update" class="btn btn-default">Assign</button>
							<cfoutput>
							<input type="hidden" name="lineid" value="#Form.lineid#"/>
							<input type="hidden" name="jobid" value="#Form.jobid#"/>
							<input type="hidden" name="applid" value="-1"/>
							<input type="hidden" name="techid" value="-1"/>
							</cfoutput>
						</CFFORM>
					</td>
				</tr>
			</table>
		<form action="jobdetails.cfm" method="post">
			<cfif didupdate is "true">
				<button type="submit" value="Cancel" name="Cancel" class="btn btn-default">back</button> 
			<cfelse>
				<button type="Cancel" value="Cancel" class="btn btn-default">Cancel</button>
			</cfif>
			<cfoutput>
			<input type="hidden" name="jobid" value="#Form.jobid#"/>
			</cfoutput>
		</form>	
					
		</div>
	</div>
	
  </body>
</html>