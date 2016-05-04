<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />


  <head>
    <title>Job Details</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
  
	<!-- Validate input -->
	<cfif !IsDefined("Form.jobid")>
		<cflocation url="home.cfm">
	</cfif>
	
	<!-- If we're doing an update -->
	<cfif IsDefined("Form.Update") AND IsDefined("Form.jobid") AND IsDefined("Form.lineid")> 		
			
				<cftry>
					<cfquery name="updatefpJobLine"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						update fpJob_Line
						set
						<cfif len("Form.desc")> 
							line_desc = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.desc#" maxLength = "100">,
						<cfelse>
							line_desc = NULL,
						</cfif>
						<cfif len("Form.notes")> 
							line_notes = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.notes#" maxLength = "100">,
						<cfelse>
							line_notes = NULL,
						</cfif>
						line_estimate = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.ESTIMATE#" maxLength = "12">,
						<cfif len("Form.ACTUAL")>
							line_actual = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.ACTUAL#" maxLength = "12">
						<cfelse>
							line_actual = NULL
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
	
	<!-- If we're doing an Insert -->
	<cfif IsDefined("Form.Add") AND IsDefined("Form.jobid")> 
			
				<cftry>
					<cfquery name="updatefpJobLine"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						insert into fpJob_Line (line_desc,line_notes,line_estimate,line_actual,job_id)
						values(
						 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.desc#" maxLength = "100">,
						 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.notes#" maxLength = "100">,
						 <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.ESTIMATE#" maxLength = "12">,
						 <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.ACTUAL#" maxLength = "12">,
						 <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">)
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

	<!-- If we're doing an Delete -->
	<cfif IsDefined("Form.Delete") AND IsDefined("Form.jobid") AND IsDefined("Form.lineid")> 
		
				<cftry>
					<cfquery name="DeletefpJobLine"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						Delete From fpJob_Line
						where job_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
						AND line_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.lineid#" maxLength = "11">
					</cfquery>
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
	
	 
	 <cfquery name="getJoblines"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select job_id, line_id, Line_Desc, nvl(tech_name,'Unassigned') as tech_name, line_estimate, line_actual, line_notes 
		from FPJOB_LINE j, FPSPECIALTY s, FPTECHNICIAN t, FPAPPLIANCE a
		where j.TECH_ID = s.TECH_ID(+)
		and j.APPL_ID = s.APPL_ID(+)
		and s.APPL_ID = a.APPL_ID(+)
		and s.TECH_ID = t.TECH_ID(+)
		and JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
	 </cfquery>
	 <cfquery name="getJobInfo"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select c.CUST_NUMBER, concat(concat(c.CUST_FNAME,' '),c.CUST_LNAME) as fname, j.JOB_DESC  
		from FPCUSTOMER c, FPJOB j
		where j.CUST_ID = c.CUST_ID
		and j.JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
	</cfquery>

	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Job Details</h1>
		</div>
		<cfoutput query="getJobInfo">
		<h3>Customer:&nbsp;#CUST_NUMBER#: #fname#</h3> 
		<h3>Job Description:&nbsp;#JOB_DESC#</h3>
		</cfoutput>
		<cfif getJoblines.RecordCount eq 0>
			<h5>No lines added Yet.  Please add a line.</h5>
		<cfelse>
			<table class="table">
				<tr>
					<th style="text-align:center">Description</th>
					<th style="text-align:center">Assigned To</th>
					<th style="text-align:center">Estimated</th>
					<th style="text-align:center">Actual</th>	
					<th style="text-align:center">Notes</th>				
					<th style="text-align:right">&nbsp;</th>
				</tr>
				<cfoutput query="getJoblines">
					<form action="addline.cfm" method="post">
						<tr>
						<td style="text-align:center">#Line_Desc#</td>
						<td style="text-align:center">#tech_name#</td>
						<td style="text-align:center">#line_estimate#</td>
						<td style="text-align:center">#line_actual#</td>
						<td style="text-align:center">#line_notes#</td>
						<td style="text-align:right">
						<button type="submit" name="Update" value="Update" class="btn btn-default" title="Edit Line Details">Edit Details</button>
						<input type="hidden" name="jobid" value='#job_id#'/>
						<input type="hidden" name="lineid" value='#line_id#'/>
					</form>
					<form action="jobdetails.cfm" method="post">
						<button type="submit" name="Delete" value="Delete" class="btn btn-default" title="Delete Line">Delete Line</button>
						<input type="hidden" name="jobid" value='#job_id#'/>
						<input type="hidden" name="lineid" value='#line_id#'/>					
					</form>
					<form action="AssignSpeciality.cfm" method="post">
						<button type="submit" name="Submit" value="Submit" class="btn btn-default" title="Delete Line">Assign Specialist</button>
						<input type="hidden" name="jobid" value='#job_id#'/>
						<input type="hidden" name="lineid" value='#line_id#'/>					
					</form>					
					</td></tr>
				</cfoutput>
			</table>
		</cfif>
		<table><tr><td>
			<form action="addline.cfm" method="post">
				<button type="submit" value="Add" name="Add" class="btn btn-default">Add to Job</button>
				<input type="hidden" name="jobid" value="<cfoutput>#Form.jobid#</cfoutput>"/>
			</form>
			</td>
			<td>
			<a href="home.cfm" class="btn btn-default">Cancel</a>
			</td></tr></table>
		</div>
	</div>
  </body>
</html>
