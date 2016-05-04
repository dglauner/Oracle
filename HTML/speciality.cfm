<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Appliances</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
  
       <cfquery name="getSpecialty"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		 select tech_name, APPL_DESC
		from FPSPECIALTY, FPAPPLIANCE, FPTECHNICIAN
		where FPSPECIALTY.APPL_ID = FPAPPLIANCE.APPL_ID
		and FPTECHNICIAN.TECH_ID = FPSPECIALTY.TECH_ID
		order by TECH_NAME
	 </cfquery>
  
	<div class="container">
    <cfinclude template = "helper/header.cfm">
		<div class="jumbotron">
		<div class="text-center" style="width:100%">
			<h1>Technician Specialities List</h1>
		</div>
		<table class="table">
			<tr>
				<th style="text-align:center; width:50%">Name</th>
				<th style="text-align:center; width:50%">Speciality</th>
			</tr>
			<cfoutput query="getSpecialty">
				<form action="index.cfm" method="post">
					<tr>
					<td style="text-align:center; width:50%">#tech_name#</td>
					<td style="text-align:center; width:50%">#APPL_DESC#</td>
					</tr>
				</form>
			</cfoutput>
		</table>		
		</div>
	</div>
  </body>
</html>