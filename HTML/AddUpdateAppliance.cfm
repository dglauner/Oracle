<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Appliances</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
	  <cfparam name="doinsert" default="false">
	  <cfparam name="appldesc" default="">
	  <cfparam name="applid" default="-1">
  
  	<!-- Validate input -->
	<cfif !IsDefined("Form.Insert") AND !IsDefined("Form.Update")>
		<cflocation url="home.cfm">
	</cfif>
	<cfif IsDefined("Form.insert")>
		<cfset doinsert = "true"> 
	<cfelse>
       <cfquery name="getAppliance"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		 select * from fpAppliance
		 where APPL_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.APPLID#" maxLength = "11">
	  </cfquery>
  		<cfoutput query="getAppliance">
			<cfset appldesc = "#appl_desc#">
			<cfset applid = "#appl_id#">
		</cfoutput>
	</cfif>
 
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<cfif doinsert is "false">
				<h1>Update Appliance Name</h1>
			<cfelse>
				<h1>Add New Appliance</h1>
			</cfif>
		</div>
		<CFFORM NAME="EditInsertAppliance" ACTION="Appliance.cfm">
			<table class="table">
				<tr>
					<th style="text-align:center; width:100%">Appliance Name</th>
				</tr>
				<cfoutput>
					<tr>
						<td style="text-align:center; width:100%">
						<CFINPUT TYPE="Text"
						NAME="appldesc"
						VALUE="#appldesc#"
						REQUIRED="Yes"
						ONERROR="Error text"
						MAXLENGTH="100" 
						class="form-control">
						<input type="hidden" name="appldesc_required">
						</td>
					</tr>
				</cfoutput>
			</table>
			<cfif doinsert is "false">
				<button type="submit" value="Update" name="Update" class="btn btn-default">Save</button> 	
			<cfelse>
				<button type="submit" value="Insert" name="Insert" class="btn btn-default">Save</button>
			</cfif>	
			<input type="hidden" name="applid" value="<cfoutput>#applid#</cfoutput>"/>			
		</CFFORM>
		
		<form action="Appliance.cfm" method="post">
			<button type="Cancel" value="Cancel" class="btn btn-default">Cancel</button>
		</form>	
		</div>
	</div>
  </body>
</html>
