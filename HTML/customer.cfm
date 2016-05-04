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
	<cfif IsDefined("Form.Update") AND IsDefined("Form.custid")> 
	
			<cfparam name="Form.number" type="string" maxLength = "25">
			<cfparam name="Form.fname" type="string" maxLength = "25">
			<cfparam name="Form.lname" type="string" maxLength = "25">
			<cfparam name="Form.address" type="string" maxLength = "100">
			<cfparam name="Form.city" type="string" maxLength = "25">
			<cfparam name="Form.state" type="string" maxLength = "25">
			<cfparam name="Form.zip" type="string" maxLength = "5">
			<cfparam name="Form.phone" type="string" maxLength = "25">	
				<cftry>
					<cfquery name="updatefpCustomer"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						update fpCustomer
						set
						cust_number = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.number#" maxLength = "25">,
						cust_fname  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.fname#" maxLength = "25">,
						cust_lname  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.lname#" maxLength = "25">,
						cust_addr   = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.address#" maxLength = "100">,
						cust_city	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.city#" maxLength = "25">,
						cust_state 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.state#" maxLength = "25">,
						cust_zip 	= <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.zip#" maxLength = "5">,
						cust_phone  = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.phone#" maxLength = "25">
						where cust_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.custid#" maxLength = "11">
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

	<!-- If we're doing an Insert -->
	<cfif IsDefined("Form.Insert")> 
			<cfparam name="Form.number" type="string" maxLength = "25">
			<cfparam name="Form.fname" type="string" maxLength = "25">
			<cfparam name="Form.lname" type="string" maxLength = "25">
			<cfparam name="Form.address" type="string" maxLength = "100">
			<cfparam name="Form.city" type="string" maxLength = "25">
			<cfparam name="Form.state" type="string" maxLength = "25">
			<cfparam name="Form.zip" type="string" maxLength = "5">
			<cfparam name="Form.phone" type="string" maxLength = "25">	
				<cftry>
					<cfquery name="inserfpCustomer"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						Insert into fpCustomer (cust_number,cust_fname,cust_lname,cust_addr,cust_city,cust_state,cust_zip,cust_phone)
						values (<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.number#" maxLength = "25">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.fname#" maxLength = "25">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.lname#" maxLength = "25">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.address#" maxLength = "100">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.city#" maxLength = "25">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.state#" maxLength = "25">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.zip#" maxLength = "5">,
								<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.phone#" maxLength = "25">)
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
	
	<!-- If we're doing an Delete -->
	<cfif IsDefined("Form.Delete") AND IsDefined("Form.custid")> 
		
				<cftry>
					<cfquery name="DeletefpCustomer"
							 datasource=#APPLICATION.DSN#
							 username=#APPLICATION.username#
							 password=#APPLICATION.password#>
						Delete From fpCustomer
						where cust_id = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.custid#" maxLength = "11">
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
    <cfquery name="getCustomers"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select concat(concat(cust_fname,' '), cust_lname) as fname, fpCustomer.* from fpCustomer
	 </cfquery>
  
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Customer List</h1>
		</div>
		<form action="editcustomer.cfm" method="post">
			<button type="submit" value="Insert" name="Insert" class="btn btn-default">Add New Customer</button>
		</form>
		
		<table class="table">
			<tr>
				<th class="text-center">Number</th>
				<th class="text-center">Name</th>
				<th class="text-center">address</th>
				<th class="text-center">City</th>
				<th class="text-center">State</th>
				<th class="text-center">Zip</th>
				<th class="text-center">Phone</th>
				<th class="text-center"></th>
				<th class="text-center"></th>
			</tr>
			<cfoutput query="getCustomers">
			<tr>
				<td class="text-center">#cust_number#</td>
				<td class="text-center">#fname#</td>
				<td class="text-center">#cust_addr#</td>
				<td class="text-center">#cust_city#</td>
				<td class="text-center">#cust_state#</td>
				<td class="text-center">#cust_zip#</td>
				<td class="text-center">#cust_phone#</td>
				<td class="text-right">
					<form action="editcustomer.cfm" method="post">
						<button type="submit" value="Submit" name="Submit" class="btn btn-default">Edit</button>
						<input type="hidden" name="custid" value='#cust_id#'/>
					</form>
				</td>
				<td class="text-right">
					<form action="customer.cfm" method="post">
						<button type="submit" value="Delete" name="Delete" class="btn btn-default">Delete</button>
						<input type="hidden" name="custid" value='#cust_id#'/>
					</form>
				</td>		
			</tr>
			</cfoutput>
		</table>	
		
		</div>



	</div>
  </body>
</html>
