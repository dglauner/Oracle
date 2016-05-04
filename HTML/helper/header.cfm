	<div class="panel panel-default" style="margin-bottom:0px">
	  <div class="panel-body">
	    <div class="text-center">
			<h1>In-A-Fix, Inc.</h1>Appliance Repair
		</div>
	  </div>
	</div>
	
	<div class="navbar navbar-default">
	  <div class="container-fluid">
		  <cfif getAuthUser() EQ "">
			<a href="index.cfm" type="button" class="btn btn-default navbar-btn">Login</a>
		  <cfelse>
			<a href="./home.cfm" type="button" class="btn btn-default navbar-btn">Jobs</a>
			<a href="./customer.cfm" type="button" class="btn btn-default navbar-btn">Customers</a>
			<a href="./Appliance.cfm" type="button" class="btn btn-default navbar-btn">Appliances</a>
			<a href="./Technician.cfm" type="button" class="btn btn-default navbar-btn">Technicians</a>
			<a href="./speciality.cfm" type="button" class="btn btn-default navbar-btn">Specialities</a>
			<a href="./logout.cfm" type="button" class="btn btn-default navbar-btn">logout</a>
		  </cfif>
	  </div><!-- /.container-fluid -->
	</div>
