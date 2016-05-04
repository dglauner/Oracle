<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Jobs</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
    	<!-- If we're doing an update -->
	<cfif IsDefined("Form.Update") AND IsDefined("Form.JOBID")> 

			<cfparam name="Form.JOBDESC" type="string" maxLength = "25">
			<cfparam name="Form.custid" type="integer" maxLength = "11">
			<cfparam name="Form.jobdate" type="date" maxLength = "10">
			<cfparam name="Form.jobcompleted" type="boolean" maxLength = "1">
			<cfparam name="Form.jobinvoicesent" type="boolean" maxLength = "1">
			<cfparam name="Form.jobinvoicepaid" type="boolean" maxLength = "1">
			
				<cftry>
					<cfquery name="updatefpJob"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						update fpJob
						set
						job_desc = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.JOBDESC#" maxLength = "255">,
						cust_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.custid#" maxLength = "11">,
						job_completed = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobcompleted#" maxLength = "1">,
						job_invoice_sent = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobinvoicesent#" maxLength = "1">,
						job_invoice_paid = <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobinvoicepaid#" maxLength = "1">,
						job_date = <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Form.jobdate#" maxLength = "10">
						where job_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
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
	<cfif IsDefined("Form.Insert")> 
			<cfparam name="Form.JOBDESC" type="string" maxLength = "25">
			<cfparam name="Form.custid" type="integer" maxLength = "25">
			<cfparam name="Form.jobdate" type="date" maxLength = "10">
			<cfparam name="Form.jobcompleted" type="boolean" maxLength = "1">
			<cfparam name="Form.jobinvoicesent" type="boolean" maxLength = "1">
			<cfparam name="Form.jobinvoicepaid" type="boolean" maxLength = "1">
			
				<cftry>
					<cfquery name="InsertfpJob"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						Insert into fpJob (job_desc, cust_id, job_completed, job_invoice_sent, job_invoice_paid, job_date)
						values (
						  <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.JOBDESC#" maxLength = "255">,
						  <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.custid#" maxLength = "11">,
						  <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobcompleted#" maxLength = "1">,
						  <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobinvoicesent#" maxLength = "1">,
						  <cfqueryparam cfsqltype="CF_SQL_CHAR" value="#Form.jobinvoicepaid#" maxLength = "1">,
						  <cfqueryparam cfsqltype="CF_SQL_TIMESTAMP" value="#Form.jobdate#" maxLength = "10">)
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
	<cfif IsDefined("Form.Delete") AND IsDefined("Form.jobid")> 
		
				<cftry>
					<cfquery name="DeletefpJob"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						Delete From fpJob
						where job_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
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

  
       <cfquery name="getJobs"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select j.JOB_DESC,j.JOB_ID, c.CUST_NUMBER, concat(concat(c.cust_fname,' '), c.cust_lname) as fname, TO_CHAR(job_date, 'MM/DD/YYYY') as job_date,
		decode(j.JOB_COMPLETED,0,'False', 'True') as JOB_COMPLETED, 
		decode(j.JOB_INVOICE_SENT,0,'False', 'True') as JOB_INVOICE_SENT,  
		decode(j.JOB_INVOICE_PAID,0,'False', 'True') as JOB_INVOICE_PAID
		from FPJOB j, FPCUSTOMER c
		where j.CUST_ID = c.CUST_ID(+)
	 </cfquery>
  
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Job List</h1>
		</div>
		<form action="addJob.cfm" method="post">
			<button type="submit" value="Insert" name="Insert" class="btn btn-default" title="Add a New Job">Add New Job</button>
		</form>		
		<table class="table">
			<tr>
				<th style="text-align:center">Customer</th>
				<th style="text-align:center">Description</th>
				<th style="text-align:right">Date</th>
				<th style="text-align:right">Completed</th>
				<th style="text-align:right">Invoice Sent</th>
				<th style="text-align:right">Invoice Paid</th>
				<th style="text-align:right">&nbsp;</th>
				<th style="text-align:right">&nbsp;</th>
				<th style="text-align:right">&nbsp;</th>
			</tr>
			<cfoutput query="getJobs">
			<tr>
				<td style="text-align:center">#fname#</td>
				<td style="text-align:center">#JOB_DESC#</td>
				<td style="text-align:right">#job_date#</td>
				<td style="text-align:right">#JOB_COMPLETED#</td>
				<td style="text-align:right">#JOB_INVOICE_SENT#</td>
				<td style="text-align:right">#JOB_INVOICE_PAID#</td>
				<td style="text-align:right">
					<form action="jobdetails.cfm" method="post">
						<button type="submit" name="Submit" value="Submit" class="btn btn-default" title="View Job Details">Details</button>
						<input type="hidden" name="jobid" value='#JOB_ID#'/>
						<input type="hidden" name="custnumber" value='#CUST_NUMBER#'/>
						<input type="hidden" name="fname" value='#fname#'/>
						<input type="hidden" name="jobdesc" value='#JOB_DESC#'/>
					</form>
					<form action="addJob.cfm" method="post">
					<input type="hidden" name="jobid" value='#JOB_ID#'/>
					<button type="submit" value="Update" name="Update" class="btn btn-default" title="Edit The Job">Edit</button>
					</form>
					<form action="home.cfm" method="post">
					<input type="hidden" name="jobid" value='#JOB_ID#'/>
					<button type="submit" value="Delete" name="Delete" class="btn btn-default" title="Delete This Job">Delete</button>
					</form>
					<cfif  JOB_COMPLETED EQ "True">
					<button class="btn btn-default" onClick="window.open('http://cscie60.dce.harvard.edu/~dglauner/invoice.cfm?JOBID=#JOB_ID#');">Generate Invoice</button>
					</cfif>
				</td>					
			</tr>
			</cfoutput>
		</table>	
	
		</div>



	</div>
  </body>
</html>
