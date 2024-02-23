<%@page import="java.util.Calendar, java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", 0);

String SessionEmployeeName = "";

String menu_sesRdirectPage = "";
String menu_sesEmpType = (String)session.getAttribute("sesSaUser_UserType");
if(menu_sesEmpType == null)menu_sesEmpType="";

String menu_sesLastName = (String)session.getAttribute("sesSaUser_LastName");
if(menu_sesLastName == null)menu_sesLastName="";
String menu_sesFirstName = (String)session.getAttribute("sesSaUser_FirstName");
if(menu_sesFirstName == null)menu_sesFirstName="";


SessionEmployeeName =  menu_sesFirstName + ' ' + menu_sesLastName;	

%>
 	<!-- Mainly scripts -->
<script src="js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">

$(function() {
	var str=location.href.toLowerCase();
	$(".nav li a").each(function() {
		if (str.indexOf(this.href.toLowerCase()) > -1) {				
			$(this).parents('.nav').find('.active').removeClass('active').end().end().addClass('active');
		}
	});
}); 
 
$(window).load(function(){
	
	var navBarClass = localStorage.getItem("navBarClass");
	
	if($.trim(navBarClass) != "")
	{
		$("body").removeClass();
		$("body").addClass(navBarClass);
	}

	var url = $.trim(location.href.toLowerCase());
	systemURL = url.substring(0,url.lastIndexOf("/")+1);
	
	if(url == systemURL+"dashboard.jsp")
	{
		$("#navHome").addClass('active');
		$("#navDashboard").addClass('active');
	}
	else if(url == systemURL+"project.jsp")
	{
		$("#navHome").addClass('active');
		$("#navProject").addClass('active');
	}
	else if(url == systemURL+"module.jsp")
	{
		$("#navHome").addClass('active');
		$("#navModule").addClass('active');
	}
	else if(url == systemURL+"task.jsp")
	{
		$("#navHome").addClass('active');
		$("#navTask").addClass('active');
	}
	else if(url.indexOf(systemURL+"tslist.jsp") >= 0)
	{
		$("#navHome").addClass('active');
		$("#navTs").addClass('active');
	}	
	else if(url == systemURL+"changepassword.jsp")
	{
		$("#navChangePassword").addClass('active');
	} 
});

function funChangePassword()
{
	var formId = "#"+$("form").attr("id");
	$(formId).attr("action","changepassword.jsp");   	                
	$(formId).submit();
}

function funEditProfile()
{
	var formId = "#"+$("form").attr("id");
	$(formId).attr("action","viewprofile.jsp");   	                
	$(formId).submit();
}

function funRedirect(page)
{
 	$("#action").val("");
	var formId = "#"+$("form").attr("id");
	$(formId).attr("action",page+".jsp");   	                
	$(formId).submit();
}

</script>

<nav class="navbar-default navbar-static-side" role="navigation" style="position:fixed">
	<div class="sidebar-collapse">
    	<ul class="nav metismenu" id="side-menu">
        	<li class="nav-header">
	            <div class="dropdown profile-element">
	            	<span>
					<%
					if(menu_sesEmpType.equals("USER"))
					{
					%>
						<img alt="image" onclick="javascript:funEditProfile();" data-toggle="tooltip" data-placement="right" data-original-title="Edit profile" name="navProfileImage" class="img-circle" src="images/ctllogo.png" style="background-color:white;width:48px;height: 48px;cursor: pointer;"/>
					<%
					}else{
					%>
						<img alt="image" name="navProfileImage" class="img-circle" src="images/sachinalogo.png" style="background-color:white;width:48px;height: 48px;"/>
					<%
					}
					%>
	                </span> 
	                <a data-toggle="dropdown" class="dropdown-toggle" href="#" style = "cursor:auto;">
	                <span class="clear"> <span class="block m-t-xs"> <strong class="font-bold"><%=SessionEmployeeName%></strong>
	                </span></span> <span class="text-muted text-xs block">&nbsp;&nbsp;</span></a>
	            </div>
                 <div class="logo-element" style="">
                 	 <strong class="font-bold">SA</strong>
                 </div>
             </li>
             
            <%
			//if(menu_sesEmpType.equals("Team Lead"))
			{
			%>
			 <li id="navHome">
                 	<a href="#"><i class="fa fa-th-large"></i> <span class="nav-label">Home</span><span class="fa arrow"></span></a>
                 	<ul class="nav nav-second-level collapse in" style="">
                        <li id="navDashboard">
                        	<a href="dashboard.jsp" data-toggle="tooltip" data-placement="right" data-original-title="Dashboard" style="cursor: pointer;">Dashboard</a>
                        </li>
                        <li id="navToDoList">
                        	<a href="todolist.jsp" data-toggle="tooltip" data-placement="right" data-original-title="View To Do List" style="cursor: pointer;">To Do List</a>
                        </li>
                        <li id="navTs">
                        	<a href="tslist.jsp?source=M" data-toggle="tooltip" data-placement="right" data-original-title="View Task" style="cursor: pointer;">Timesheet</a>
                        </li>
                        <li id="navTask">
                        	<a href="task.jsp?source=M" data-toggle="tooltip" data-placement="right" data-original-title="View Task" style="cursor: pointer;">Task</a>
                        </li>
                        <li id="navProject">
                        	<a href="project.jsp" data-toggle="tooltip" data-placement="right" data-original-title="View project" style="cursor: pointer;">Project</a>
                        </li>
                        <li id="navModule">
                        	<a href="module.jsp" data-toggle="tooltip" data-placement="right" data-original-title="View Module" style="cursor: pointer;">Module</a>
                        </li>                       
                        
                    </ul>
             </li>
			<%}%>
            
            <li id="navChangePassword" >
                 <a onclick="javascripr:funChangePassword();" data-toggle="tooltip" data-placement="right" data-original-title="Change password" style="cursor: pointer;"><i class="fa fa-key"></i> <span class="nav-label">Change Password</span></a>
             </li>
             
         </ul>
	</div>	
</nav>

<style>
.tooltip-inner {
  background-color: #18a689;
}
.tooltip.top .tooltip-arrow {
  border-top-color: #18a689;
}
.tooltip.right .tooltip-arrow {
  border-right-color: #18a689;
}
.tooltip.bottom .tooltip-arrow {
  border-bottom-color: #18a689;
}
.tooltip.left .tooltip-arrow {
  border-left-color: #18a689;
}
.mini-navbar .nav .nav-second-level {
    padding: 10px 0px 10px 10px;
}
</style>

