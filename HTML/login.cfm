<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>Login</title>
<cfinclude template = "helper/links.cfm">

  <head>
    <title>In-A-Fix, Inc.</title>

    <cfinclude template = "css/general.css">
  </head>

  <body onLoad="document.login.userLogin.focus();">
	 <div class="container">
		<cfinclude template = "helper/header.cfm">

		<cfset myaction="home.cfm">
		<div class="jumbotron">
			<cfform action="#myaction#" name="login"
					method="post" preservedata="yes">
			
			<table>
			   <tr><th colspan="2" class="highlight">Please Log In</th></tr>
			   <tr>
				 <td>Username:</td>
				 <td>
				   <cfinput type="text" name="userLogin" size="10" value=""
							maxlength="10" required="yes"
							message="Please enter your USERNAME">
				   <input type="hidden" name="userLogin_required">
				 </td>
			   </tr>
			   <tr>
				 <td>Password:</td>
				 <td>
					<cfinput type="password" name="userPassword" size="10" value=""
							 maxlength="10" required="yes"
							 message="Please enter your PASSWORD">
					<input type="hidden" name="userPassword_required">
				 </td>
			   </tr>
			   <tr>
				 <td>&nbsp;</td>
				 <td>
				 	<input type="submit" name="login" value="Login" />
				 </td>
			   </tr>
			</table>
			</cfform>
		</div>
		
	</div>
  </body>
</html>
