<cfcomponent output="false">

   <!--- ########## Oracle Variables ########## --->

	<cfparam name="Request.DSN" default="cscie60">
	<cfparam name="Request.username" default="dglauner">
	<cfparam name="Request.password" default="5544">

   <!--- ########## Name this application ########## --->
   
   <cfset this.name="In_A_Fix_Site">
   
   <!--- ########## Turn on Session Management ########## --->

   <cfset this.sessionManagement=true>
  
   <!--- ########## Set Application Variables ########## --->

   <cffunction name="onApplicationStart" output="false" returnType="void">
       <cfset APPLICATION.DSN="cscie60">
       <cfset APPLICATION.username="dglauner">
       <cfset APPLICATION.password="5544">
       <cfset APPLICATION.clientmanagement="no">
       <cfset APPLICATION.sessionmanagement="yes">
       <cfset APPLICATION.setclientcookies="yes">
       <cfset APPLICATION.setdomaincookies="no">
       <cfset APPLICATION.sessiontimeout="#CreateTimeSpan(0,1,0,0)#">
       <cfset APPLICATION.applicationtimeout="#CreateTimeSpan(0,0,10,0)#">
   </cffunction>
   
   <!--- ########## Protect the whole application --->

   <cffunction name="onRequestStart" output="false" returnType="void">
      <cfinclude template="forceUserLogin.cfm">
   </cffunction>

</cfcomponent>
