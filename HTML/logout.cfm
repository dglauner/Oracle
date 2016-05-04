<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Log Out</title>
	<cfinclude template = "helper/links.cfm">
    <cfinclude template = "css/general.css">
  </head>

  <body>
	<div class="container">
    <cfinclude template = "helper/header.cfm">


       <cflogout>

       <cfcookie name="userview" expires="now">
 
	<cflocation url="login.cfm">
    <!--- Show user AFTER logout --->

    <h3><cfoutput>After logout: #getAuthUser()#</cfoutput></h3>


	</div>
  </body>
</html>