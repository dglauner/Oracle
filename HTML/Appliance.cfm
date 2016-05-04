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
	<cfif IsDefined("Form.Update") AND IsDefined("Form.applid") AND IsDefined("Form.appldesc")> 
		<cfparam name="Form.appldesc" type="string" maxLength = "25">
		<cfparam name="Form.applid" type="integer" maxLength = "11">
		<cftry>
			<cfquery name="updatefpAppliance"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				update fpAppliance
				set
				appl_desc = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.appldesc#" maxLength = "100">
				where appl_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.applid#" maxLength = "11">
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
	<cfif IsDefined("Form.Insert") AND IsDefined("Form.appldesc")> 
		<cfparam name="Form.appldesc" type="string" maxLength = "25">
		<cftry>
			<cfquery name="insertfpAppliance"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				insert into fpAppliance (appl_desc)
				values(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.appldesc#" maxLength = "100">)
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
	<cfif IsDefined("Form.Delete") AND IsDefined("Form.applid")> 
		<cfparam name="Form.applid" type="integer" maxLength = "11">
		<cftry>
			<cfquery name="insertfpAppliance"
					 datasource=#APPLICATION.DSN#
					 username=#APPLICATION.username#
					 password=#APPLICATION.password#>
				Delete from fpAppliance
				where appl_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.applid#" maxLength = "11">
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
	
    <cfquery name="getAppliances"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select * from fpAppliance
	 </cfquery>
  
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Appliance List</h1>
		</div>
		<form action="AddUpdateAppliance.cfm" method="post">
			<button type="submit" value="Insert" name="Insert" class="btn btn-default" Title="Add a New Technician.">Add New</button>
		</form>
		<table class="table">
			<tr>
				<th style="text-align:Right; width:50%">Name</th>
				<th style="text-align:Left; width:500%">&nbsp;</th>
			</tr>
			<cfoutput query="getAppliances">
				<CFFORM NAME="EditInsertAppliance" ACTION="AddUpdateAppliance.cfm">	
					<tr>
						<td style="text-align:right; width:50%">
							#appl_desc#
						</td>
						<td style="text-align:Left; width:50%">
							<button type="submit" value="Update" name="Update" class="btn btn-default" Title="Edit This Technician.">Edit</button>
							<input type="hidden" name="applid" value="#appl_id#"/>
							</CFFORM>
							<CFFORM NAME="DeleteAppliance" ACTION="Appliance.cfm">
								<button type="submit" value="Delete" name="Delete" class="btn btn-default" Title="Delete This Technician.">Delete</button>
								<input type="hidden" name="applid" value="#appl_id#"/>
							</CFFORM>
						</td>
					</tr>
				
			</cfoutput>
		</table>	
		</div>



	</div>
  </body>
</html>
