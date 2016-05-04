<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Technicians</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
      	<!-- If we're doing an update -->
	<cfif IsDefined("Form.Update") AND IsDefined("Form.techid") AND IsDefined("Form.techname")> 
		<cfparam name="Form.techname" type="string" maxLength = "25">
		<cfparam name="Form.techid" type="integer" maxLength = "11">
		<cftry>
			<cfquery name="updatefpTechnician"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				update fpTechnician
				set
				tech_name = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.techname#" maxLength = "100">
				where tech_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.techid#" maxLength = "11">
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
	<cfif IsDefined("Form.Insert") AND IsDefined("Form.techname")> 
		<cfparam name="Form.techname" type="string" maxLength = "25">
		<cftry>
			<cfquery name="insertfpTechnician"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				insert into fpTechnician (tech_name)
				values(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.techname#" maxLength = "100">)
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
	<cfif IsDefined("Form.Delete") AND IsDefined("Form.techid")> 
		<cfparam name="Form.techid" type="integer" maxLength = "11">
		<cftry>
			<cfquery name="insertfpTechnician"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				Delete from fpTechnician
				where tech_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.techid#" maxLength = "11">
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
	
    <cfquery name="getTechnicians"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select * from fpTechnician
	 </cfquery>
  
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Technician List</h1>
		</div>
		<form action="AddUpdateTechnician.cfm" method="post">
			<button type="submit" value="Insert" name="Insert" class="btn btn-default" Title="Add a New Technician.">Add New</button>
		</form>
		<table class="table">
			<tr>
				<th style="text-align:Right; width:50%">Name</th>
				<th style="text-align:Left; width:500%">&nbsp;</th>
			</tr>
			<cfoutput query="getTechnicians">
				<CFFORM NAME="EditInsertTechnician" ACTION="AddUpdateTechnician.cfm">	
					<tr>
						<td style="text-align:right; width:50%">#tech_name#</td>
					<td style="text-align:Left; width:50%">

						<button type="submit" value="Update" name="Update" class="btn btn-default" Title="Edit This Technician.">Edit</button>
						<input type="hidden" name="techid" value="#tech_id#"/>
				</CFFORM>
				<CFFORM NAME="DeleteTechnician" ACTION="Technician.cfm">
						<button type="submit" value="Delete" name="Delete" class="btn btn-default" Title="Delete This Technician.">Delete</button>
						<input type="hidden" name="techid" value="#tech_id#"/>

				</CFFORM>
					</td>
					</tr>
				
			</cfoutput>
		</table>	
		</div>



	</div>
  </body>
</html>
