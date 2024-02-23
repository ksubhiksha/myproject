<div class="row border-bottom">
	<nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
		<div class="navbar-header">
		  <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#" onclick="javascript:funToggleBodyClass();"><i class="fa fa-bars"></i> </a>
		</div>
	    <div class="form-group" style="margin-bottom:0px;margin-top:13px;">						  
			<div class="row" style="height:15px"></div>
		</div>    
	 
	 	<ul class="nav navbar-top-links navbar-right">
        	<li>
	            <a href="login.jsp">
	                <i class="fa fa-sign-out"></i> Exit
	            </a>
        	</li>
		</ul>
	</nav>
</div>
	 
<script>
   
function funToggleBodyClass()
{
	var miniNav = $("body").hasClass("mini-navbar");
	
	if($.trim(miniNav) == "true")
	{			
		localStorage.setItem("navBarClass", "md-skin pace-done");
	}
	else
	{	
		localStorage.setItem("navBarClass", "md-skin pace-done mini-navbar");
	}
}
  
</script>
   