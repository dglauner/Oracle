<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <title>Edit Customer</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>
  <body>
	<cfparam name="doinsert" default="false">
	
	<cfparam name="number" default="">
	<cfparam name="fname" default="">
	<cfparam name="lname" default="">
	<cfparam name="address" default="">
	<cfparam name="city" default="">
	<cfparam name="state" default="">
	<cfparam name="Zip" default="">
	<cfparam name="phone" default="">
	
  	<!-- Validate input -->
	<cfif !IsDefined("Form.Submit") AND !IsDefined("Form.insert")>
		<cflocation url="customer.cfm">
	</cfif>
	<cfif IsDefined("Form.insert")>
		<cfset doinsert = "true"> 
	<cfelse>
		<cfquery name="getCustomer"
			 datasource=#APPLICATION.DSN#
			 username=#APPLICATION.username#
			 password=#APPLICATION.password#>
			select * from fpCustomer where cust_id = 
			<cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#Form.custid#" maxLength = "11">
		</cfquery>
		<cfoutput query="getCustomer">
			<cfset number = "#cust_number#">
			<cfset fname = "#cust_fname#">
			<cfset lname = "#cust_lname#">
			<cfset address = "#cust_addr#">
			<cfset city = "#cust_city#">
			<cfset state = "#cust_state#">
			<cfset zip = "#cust_zip#">
			<cfset phone = "#cust_phone#">			
		</cfoutput>
	</cfif>
  
  
  	<div class="container">
		<cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Customer List</h1>
		</div>
		<CFFORM NAME="EditInsertCustomer" ACTION="customer.cfm">
			<cfoutput>
			<table style="width: 100%">
			<tr>
				<td class="text-right" style="width: 25%"><label>Number:&nbsp;</label></td>
				<td style="width: 75%">
					<CFINPUT TYPE="Text"
					NAME="number"
					VALUE="#number#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25" 
					class="form-control">
					<input type="hidden" name="number_required">
				</td>
			</tr>
			<tr>
				<td class="text-right"><label>First Name:&nbsp;</label></td>
				<td>			
					<CFINPUT TYPE="Text"
					NAME="fname"
					VALUE="#fname#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25"
					class="form-control"><input type="hidden" name="fname_required"></td>
			</tr>
			<tr>
				<td class="text-right"><label>Last Name:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="lname"
					VALUE="#lname#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25"
					class="form-control"><input type="hidden" name="lname_required"></td>
			</tr>
			<tr>
				<td class="text-right"><label>Address:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="address"
					VALUE="#address#"					
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="100"
					class="form-control">
					<input type="hidden" name="address_required">
					</td>
			</tr>
			<tr>
				<td class="text-right"><label>City:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="city"
					VALUE="#city#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25"
					class="form-control">
					<input type="hidden" name="city_required">
					</td>
			</tr>
			<tr>
				<td class="text-right"><label>State:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="state"
					VALUE="#state#"					
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25"
					class="form-control">
					<input type="hidden" name="state_required">
					</td>
			</tr>
			<tr>
				<td class="text-right"><label>Zip:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="zip"
					VALUE="#zip#"
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="5"
					VALIDATE="zipcode"
					MESSAGE="Invalid Zip Code, 5 digit only"
					class="form-control">
					<input type="hidden" name="zip_required">
					</td>
			</tr>
			<tr>
				<td class="text-right"><label>Phone:&nbsp;</label></td>
				<td><CFINPUT TYPE="Text"
					NAME="phone"
					VALUE="#phone#"					
					REQUIRED="Yes"
					ONERROR="Error text"
					MAXLENGTH="25"
					VALIDATE="telephone"
					MESSAGE="Invalid phone number, can use hyphens."
					class="form-control">
					<input type="hidden" name="phone_required">
					</td>
			</tr>
			</cfoutput>
			<tr>
				<td class="text-right">
				<cfif doinsert is "false">
					<button type="submit" value="Update" name="Update" class="btn btn-default">Update</button>
				<cfelse>
					<button type="submit" value="Insert" name="Insert" class="btn btn-default">Insert</button>
				</cfif>
				</td>
				<td><a href="customer.cfm" class="btn btn-default">Cancel</a></td>
			</tr>
		</table>
		
			<cfif doinsert is "false">
				<input type="hidden" value="<cfoutput>#Form.custid#</cfoutput>" name="custid" />
			</cfif>	
			
		</CFFORM>	
		</div>
	</div>
  
  </body>
  </html>