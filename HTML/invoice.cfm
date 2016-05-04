<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<html>
<head>
    <meta charset="utf-8">
    <title>Invoice</title>
    
    <style>
    .invoice-box{
        max-width:800px;
        margin:auto;
        padding:30px;
        border:1px solid #eee;
        box-shadow:0 0 10px rgba(0, 0, 0, .15);
        font-size:16px;
        line-height:24px;
        font-family:'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
        color:#555;
		min-height:9in;
    }
    
    .invoice-box table{
        width:100%;
        line-height:inherit;
        text-align:left;
    }
    
    .invoice-box table td{
        padding:5px;
        vertical-align:top;
    }
    
    .invoice-box table tr td:nth-child(2){
        text-align:right;
    }
    
    .invoice-box table tr.top table td{
        padding-bottom:20px;
    }
    
    .invoice-box table tr.top table td.title{
        font-size:45px;
        line-height:45px;
        color:#333;
    }
    
    .invoice-box table tr.information table td{
        padding-bottom:40px;
    }
    
    .invoice-box table tr.heading td{
        background:#eee;
        border-bottom:1px solid #ddd;
        font-weight:bold;
    }
    
    .invoice-box table tr.details td{
        padding-bottom:20px;
    }
    
    .invoice-box table tr.item td{
        border-bottom:1px solid #eee;
    }
    
    .invoice-box table tr.item.last td{
        border-bottom:none;
    }
    
    .invoice-box table tr.total td:nth-child(2){
        border-top:2px solid #eee;
        font-weight:bold;
    }
    
    @media only screen and (max-width: 600px) {
        .invoice-box table tr.top table td{
            width:100%;
            display:block;
            text-align:center;
        }
        
        .invoice-box table tr.information table td{
            width:100%;
            display:block;
            text-align:center;
        }
    }
    </style>
</head>

<body>
	 <cfquery name="getJoblines"
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#>
		select l.LINE_DESC, l.LINE_NOTES, decode(l.LINE_ACTUAL, null, l.LINE_ESTIMATE, l.LINE_ACTUAL) as line_price
		from FPJOB_LINE l
		where l.JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#url.jobid#" maxLength = "11">
	</cfquery>

	<cfstoredproc procedure="TotalCost" 
		 datasource=#APPLICATION.DSN#
         username=#APPLICATION.username#
         password=#APPLICATION.password#> 
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" value="#url.jobid#"> 
	<cfprocparam cfsqltype="CF_SQL_DECIMAL" type="out" variable="total_cost"> 
	</cfstoredproc> 

	<cfquery name="getJobInfo"
		datasource=#APPLICATION.DSN#
        username=#APPLICATION.username#
        password=#APPLICATION.password#>
		select j.JOB_DESC, j.JOB_DATE, c.*
		from FPJOB j, FPCUSTOMER c
		where j.CUST_ID = c.CUST_ID
		and j.JOB_ID = <cfqueryparam cfsqltype="CF_SQL_DECIMAL" value="#url.jobid#" maxLength = "11">
	</cfquery>


    <div class="invoice-box">
        <table cellpadding="0" cellspacing="0">
            <tr class="top">
                <td colspan="2">
                    <table>
                        <tr>
                            <td class="title">
                                In-A-Fix, INC.
                            </td>
                            
                            <td>
                                Invoice #: 123<br>
                                Created: <cfoutput>#DateFormat(now() , "mmmm dd yyyy" )#</cfoutput>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <cfoutput query="getJobInfo">
            <tr class="information">
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                In-A-Fix, Inc.<br>
                                12345 Sunny Road<br>
                                Sunnyville, MA 12345
                            </td>
                            
                            <td>
                                
								#cust_fname#&nbsp;#cust_lname#<br>
                                #cust_Addr#<br>
                                #cust_city#, #cust_state#  #cust_zip#<br>
                                #cust_Phone#
								
                            </td>
							
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="heading">
                <td>
                    Job Description
                </td>
                
                <td>
                    Date
                </td>
            </tr>
            
            <tr class="item">
                
				<td> 
					#job_desc#
                </td>
                
                <td>
                    #DateFormat(job_date , "mmmm dd yyyy" )#
                </td>

            </tr>
            </cfoutput>
            <tr class="heading">
                <td>
                    Items
                </td>
                
                <td>
                    Price
                </td>
            </tr>
            <cfoutput query="getJoblines">
            <tr class="item">
                <td>
                    #LINE_DESC#
					<cfif len(LINE_NOTES) GT 0>
					<br>#LINE_NOTES#
					</cfif>
                </td>
                
                <td>
                    #line_price#
                </td>
            </tr>
            </cfoutput>
            
            <tr class="total">
                <td></td>
                
                <td>
                   Total: $<cfoutput>#total_cost#</cfoutput>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
