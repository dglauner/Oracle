<!--- ### File adapted from Forta & Camdem --->

<!--- Force the user to log in --->
<!--- ### Code only executes if the user has not logged in ### --->
<!--- Code is skipped once the user is logged in via cfloginuser> --->
<cflogin>

 <!--- If the user hasn't gotten the login form yet, display it --->
 <cfif not (isDefined("FORM.userLogin") and isDefined("FORM.userPassword"))>
    <cfinclude template="login.cfm">
    <cfabort>

 <!--- Otherwise, the user is submitting the login form --->
 <!--- Code evaluates whether the username and password are valid --->
 <cfelse>

   <!--- Find record with this Username/Password --->
   <!--- If no rows returned, password not valid --->
   <cfquery name="getUser"
         datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
          select user_number, user_pass, concat(USER_FNAME, concat(' ', USER_LNAME)) as fname
             from fpUser
			 where user_number = <cfqueryparam cfsqltype="CF_SQL_VARCHAR2" value="#Form.userLogin#">
			       and user_pass = <cfqueryparam cfsqltype="CF_SQL_VARCHAR2" value="#Form.userPassword#">
   </cfquery>

   <!--- If the username and password are correct... --->
   <cfif getUser.recordCount EQ 1>
     <!--- Tell ColdFusion to consider the user "logged in" --->
     <!--- NAME may be retrieved via GetAuthUser() --->
     <cfloginuser
     name="#getUser.fname#"
     password="#FORM.userPassword#"
	 roles="ALL">

     <cfcookie name="userview" value="ALL">

   <!--- Otherwise, re-prompt for a valid username and password --->
   <cfelse>
     <div class="errorMsg">Sorry, the username and password combination are not recognized.<br />
     Please try again.</div>
     <cfinclude template="login.cfm">
     <cfabort>
   </cfif>
 </cfif>
</cflogin>

