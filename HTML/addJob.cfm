<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Jobs</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
  	<cfparam name="doinsert" default="false">
	
	<cfparam name="custid" default="-1">
	<cfparam name="jobdesc" default="">
	<cfparam name="jobdate" default="">
	<cfparam name="jobcompleted" default="0">
	<cfparam name="jobinvoicesent" default="0">
	<cfparam name="jobinvoicepaid" default="0">

	<!-- Validate input -->
	<cfif !IsDefined("Form.Submit") AND !IsDefined("Form.insert") AND !IsDefined("Form.Update")>
		<cflocation url="home.cfm">
	</cfif>
	<cfif IsDefined("Form.insert")>
		<cfset doinsert = "true"> 
	<cfelse>
		<cfquery name="getJob"
			 datasource=#APPLICATION.DSN#
			 username=#APPLICATION.username#
			 password=#APPLICATION.password#>
			select j.JOB_DESC, j.JOB_INVOICE_PAID, nvl(j.CUST_ID,'-1') as CUST_ID,
			TO_CHAR(j.JOB_DATE, 'MM/DD/YYYY') AS JOB_DATE, j.JOB_COMPLETED, j.JOB_INVOICE_SENT, j.JOB_INVOICE_PAID
			from FPJOB j WHERE j.job_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.jobid#" maxLength = "11">
		</cfquery>
		<cfoutput query="getJob">
			<cfset custid = "#CUST_ID#">
			<cfset jobdesc = "#JOB_DESC#">
			<cfset jobdate = "#JOB_DATE#">
			<cfset jobcompleted = "#JOB_COMPLETED#">
			<cfset jobinvoicesent = "#JOB_INVOICE_SENT#">
			<cfset jobinvoicepaid = "#JOB_INVOICE_PAID#">		
		</cfoutput>
	</cfif>
	
		<cfquery name="getCustomers"
			 datasource=#APPLICATION.DSN#
			 username=#APPLICATION.username#
			 password=#APPLICATION.password#>
			 select c.*, concat(concat(c.cust_fname,' '), c.cust_lname) as fname 
			 from FPCustomer c
		</cfquery>
	
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<cfif doinsert is "false">
				<h1>Update Job Information</h1>
			<cfelse>
				<h1>Add New Job</h1>
			</cfif>
			
		</div>
		<CFFORM NAME="EditInsertJob" ACTION="home.cfm">
			<cfoutput>
			<table style="width: 100%">
			<tr>
				<td class="text-right" style="width: 25%"><label>Description:&nbsp;</label></td>
				<td style="width: 75%">
					<CFINPUT TYPE="Text"
					NAME="JOBDESC"
					VALUE="#jobdesc#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="255" 
					class="form-control">
				</td>
			</tr>
						<tr>
				<td class="text-right" style="width: 25%"><label>Date:&nbsp;</label></td>
				<td style="width: 75%">
					<CFINPUT TYPE="datefield"
					NAME="JOBDATE"
					VALUE="#jobdate#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="10" 
					class="form-control">
				</td>
			</tr>
			</cfoutput>
			<tr>
				<td class="text-right"><label>Customer:&nbsp;</label></td>
				<td>			
				<select name="custid" class="form-control" style="width:3in">
					<cfoutput query="getCustomers">
						<cfif custid EQ getCustomers.cust_id>  
							<option value=#getCustomers.cust_id# selected="selected">#getCustomers.fname#</option>  
						<cfelse>  
							<option value=#getCustomers.cust_id#>#getCustomers.fname#</option> 
						</cfif>  
					</cfoutput>
				</select>
			</tr>
			<tr>
				<td class="text-right"><label>Job Completed:&nbsp;</label></td>
				<td>
					
					<select name="jobcompleted" class="form-control" style="width:2in">
						<cfif jobinvoicesent NEQ 0>
							<option value=1 selected="selected">True</option>
						<cfelse>	
							<cfif jobcompleted EQ 0>  
								<option value=0 selected="selected">False</option>  
							<cfelse>  
								<option value=0>False</option> 
							</cfif>
							<cfif jobcompleted EQ 1>  
								<option value=1 selected="selected">True</option>  
							<cfelse>  
								<option value=1>True</option> 
							</cfif>
						</cfif>
					</select>			
				</td>
			</tr>
			
			<tr>
				<td class="text-right"><label>Invoice Sent:&nbsp;</label></td>
				<td>
					<select name="jobinvoicesent" class="form-control" style="width:2in">
						<cfif jobinvoicepaid EQ 0>
							<cfif jobcompleted NEQ 0> 
								<cfif jobinvoicesent EQ 0>  
									<option value=0 selected="selected">False</option>  
								<cfelse>  
									<option value=0>False</option> 
								</cfif>
								<cfif jobinvoicesent EQ 1>  
									<option value=1 selected="selected">True</option>  
								<cfelse>  
									<option value=1>True</option> 
								</cfif>
							<cfelse>
								<option value=0 selected="selected">False</option>
							</cfif>		
						<cfelse>
							<option value=1 selected="selected">True</option>
						</cfif>
					</select>
				</td>
			</tr>
			<tr>
				<td class="text-right"><label>Invoice Paid:&nbsp;</label></td>
				<td>
					<select name="jobinvoicepaid" class="form-control" style="width:2in">
						<cfif jobinvoicesent NEQ 0>
							<cfif jobinvoicepaid EQ 0>  
								<option value=0 selected="selected">False</option>  
							<cfelse>  
								<option value=0>False</option> 
							</cfif>
							<cfif jobinvoicepaid EQ 1>  
								<option value=1 selected="selected">True</option>  
							<cfelse>  
								<option value=1>True</option> 
							</cfif>
						<cfelse>
							<option value=0 selected="selected">False</option>
						</cfif>	
					</select>			
				</td>
			</tr>
			
			<tr>
				<td class="text-right">
				<cfif doinsert is "false">
					<button type="submit" value="Update" name="Update" class="btn btn-default">Update</button>
				<cfelse>
					<button type="submit" value="Insert" name="Insert" class="btn btn-default">Insert</button>
				</cfif>
				</td>
				<td><a href="home.cfm" class="btn btn-default">Cancel</a></td>
			</tr>
		</table>
		
			<cfif doinsert is "false">
				<input type="hidden" value="<cfoutput>#Form.jobid#</cfoutput>" name="jobid" />
			</cfif>	
		</CFFORM>
	</div>
  </body>
</html>
