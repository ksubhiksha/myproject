<%@ page language="java" import="java.io.*,java.util.*,com.saapps.task.Project"%>
<jsp:useBean id="Project" class="com.saapps.task.Project" scope="request"/>
<jsp:setProperty name="Project" property="*"/> 
<%
Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;

String sesSaUser_FirstName = (String)session.getAttribute("sesSaUser_FirstName");
if(sesSaUser_FirstName == null)sesSaUser_FirstName ="";


String mode = (String)request.getParameter("pageaction");
if(mode == null) mode = "";
String source = (String)request.getParameter("source");
if(source == null) source = "";

String msg = "";
List lstProject = new ArrayList();
try
{
	if("".equals(mode.trim()))
	{
		
	}
	
	lstProject = Project.getProjectList();
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception while getting information in todolist.jsp :: " +e.getMessage());
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SA APPS</title>
	<LINK REL="SHORTCUT ICON" HREF="images/ftp.ico" type="image/x-icon">
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/toastr.min.css" rel="stylesheet">
    <link href="css/scrolltop.css" rel="stylesheet">
    
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/sauser.css" rel="stylesheet">
    
<style type="text/css">
.sorting_asc
{
	color:#1ab394;
}
.sorting_desc
{
	color:#ed5565;
}
@media screen and (min-width: 992px) {
	.modal-lg {
	  width: 650px; /* New width for large modal */
	}
}
@media screen and (min-width: 1220px) {
	.modal-lg {
	  width: 650px; /* New width for large modal */
	}
}
</style>
</head>

<body class="md-skin pace-done" onload="funInit();">
<form id="frmToDolist" name="frmToDolist" method="POST" autocomplete="off">
    <div id="wrapper">
 	<%@ include file="menubarside.jsp"%>
 	    
	<div id="page-wrapper" class="gray-bg">
		<%@ include file="menubartop.jsp"%>
		<div id="screenload">
			<div class="modal-backdrop in fv-modal-stack" style="z-index: 1049;"></div>	
			<div id="iconRepeatMain">
				 <a class="btn btn-lg btn-default has-spinner" style="color: #009688;">
			    	&nbsp;&nbsp;<span class="spinner"><i class="fa fa-spinner fa-spin"></i>&nbsp;&nbsp;&nbsp;Loading<span>.</span><span>.</span><span>.</span>&nbsp;&nbsp;</span>
			     </a>
			</div>
		</div>
		
 		<div class="row wrapper border-bottom white-bg page-heading">
	       	<div class="col-lg-9">
                  <h2>To Do List</h2>
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item">
                          <a href="dashboard.jsp">Dashboard</a>
                      </li>
                      <li class="breadcrumb-item active">
                          <strong>To Do List</strong>
                      </li>
                  </ol>
              </div>
        </div>
        
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
             	<div class="ibox float-e-margins col-lg-12" id="listDiv">
					<div class="ibox-content">	
						 <div class="table-responsive" align="left" style="margin-bottom: 20px;">
								<button type="button" id="btnAddToDoList" name="btnAddToDoList" class="ladda-button btn btn-success" data-style="expand-left" data-toggle="tooltip" data-placement="bottom" title="Click to add To Do List" onclick="javascript:funAddToDoList();"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;&nbsp;Add To Do List</button>
							</div>
						
	                     <div class="row" style="margin-bottom:0px;">
	                     <%
	                     if(lstProject.size() > 0)
	                     {
	                     %>
	                     	<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover" data-paging="true" data-filter=#filter id="tblProject">
									<thead>
		                           		<tr>
		                               		<th title="Sort by Project Name" class="text-center">Project Name</th>
		                               		<th title="Sort by Project Description" class="text-center">Project Description</th>
		                               		<th title="Sort by User Permission" class="text-center">User Permission</th>
		                               		<th title="Sort by Created By" class="text-center">Created By</th>  
		                               		<th title="Sort by Created Date" class="text-center">Created Date</th>    
		                               		<th class="text-center" style="background-color: #fff;">Actions</th>                                      
		                           		</tr>
		                      		</thead>
									<tbody>
									<%
		                          		String statusLabel = "";
		                          		String statusLabelClass = "";
		                          		
		                          		int projectId = 0;
		                          		String projectName = "";
		                          		String projectDesc = "";
		                          		String userPermission = "";
		                          		String createdBy = "";
		                          		String createdDate = "";
		                          		
		                          		int isActive = 0;
		                          		
		                          		Iterator itrProject = lstProject.iterator();
		                        		while(itrProject.hasNext())
		                        		{
		                        			projectId = (Integer)itrProject.next();
		                        			projectName = (String)itrProject.next();
		                        			projectDesc = (String)itrProject.next();
		                        			userPermission = (String)itrProject.next();
		                        			isActive = (Integer)itrProject.next();
		                        			createdBy = (String)itrProject.next();
		                        			createdDate = (String)itrProject.next();
		                           			
		                           			if(isActive == 1)
		                           			{
		                           				statusLabel = "Approved";
		                           				statusLabelClass = "label-primary";
		                           			}else{
		                           				statusLabel = "Awaiting Approval";
		                           				statusLabelClass = "label-danger";
		                           			}
										%>
											<tr class="gradeX">
										   		<td style="text-align:left;vertical-align: middle;">	
										   			<span id="spanProjectName<%=projectId%>" style=""><%=projectName%></span>								   			
										   			<span id="spanCreatedDate<%=projectId%>" style="display:none"><%=createdDate%></span>
										   		</td>
										   		<td style="text-align: left;vertical-align: middle;"><%=projectDesc%></td>
										   		<td style="text-align: left;vertical-align: middle;"><%=userPermission%></td>
										   		<td style="text-align: left;vertical-align: middle;"><%=createdBy%></td>
										   		<td style="text-align: center;vertical-align: middle;"><%=createdDate%></td>
										   		<td style="text-align: center;vertical-align: middle;">
										   			<i class="fa fa-pencil-square-o" onclick="javascript:funEditProject('<%=projectId%>');" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" data-original-title="Click to edit" style="color: #1c84c6;cursor: pointer;font-size: 16px;vertical-align: middle;"></i>&nbsp;
	                   								<a class="spanDelete" id="spanProjectDelete<%=projectId%>" data-toggle="tooltip" data-placement="bottom" data-Title="Click to delete" ><i class="fa fa fa-trash-o" style="color:#ed5565;cursor: pointer;font-size:16px;vertical-align: middle;"></i></a>&nbsp;
	                   								<%
		               									if(isActive > 0)
		               									{
	                   								%>
	                   									<a class="spanStatus" id="spanChangeStatus<%=projectId%>~^<%=isActive%>" data-toggle="tooltip" data-placement="bottom" data-original-title="Change status to In-Active?"><i class="fa fa-thumbs-up" aria-hidden="true" style="color: #009284;cursor: pointer;font-size: 16px;vertical-align: middle;"></i></a>
	                   								<%
	                   									}else{
	                   								%>
	                   									<a class="spanStatus" id="spanChangeStatus<%=projectId%>~^<%=isActive%>" data-toggle="tooltip" data-placement="bottom" data-original-title="Change status to Active?"><i class="fa fa-thumbs-down" aria-hidden="true" style="color: #ff5959;cursor: pointer;font-size: 16px;vertical-align: middle;"></i></a>
	                   								<%
	                   									}
	                   								%>
										   		</td>
										   		
										 	</tr>						  
										<%
											}
										%>  
		                     		</tbody>
								</table>
							</div>
	                     <%
	                     }else
	                     {
	                     %>
	                     	<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xl-12">
									<div class="float-e-margins">									
											<div class="col-lg-3 col-md-3 col-sm-2 col-xl-1"></div>
											<div class="col-lg-6 col-md-6 col-sm-8 col-xl-10">
												<div class="alert alert-danger" style="text-align:center">
													Projects not available.
												</div>
											</div>
											<div class="col-lg-3 col-md-3 col-sm-2 col-xl-1"></div>									
									</div>
								</div>
							</div>
	                     <%
	                     }
	                     %>
                         	
                         </div>
					</div>
		 		</div>
        	</div>
     	</div>
     	
     	
     	<input type='hidden' name='pageaction' id='pageaction' value=""/>
     	<input type='hidden' name='source' id='source' value="<%=source%>"/>
     	<%-- <input type='hidden' name='source' id='source' value="<%=source%>"/>
     	<input type="hidden" name="hidPassword" id="hidPassword" value="<%=password%>"/>
     	<input type="hidden" name="password" id="password" value=""/> --%>
     	     	
     </div>
     <div class="scroll-top-wrapper" style="background: #19c0a0;">
		<span class="scroll-top-inner">
			<i class="fa fa-2x fa-arrow-circle-up"></i>
		</span>
	</div>
	
</div>

</form>
</body>

 	<!-- <script src="js/jquery-1.12.4.min.js"></script> -->
 	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.metisMenu.js"></script>
	<script src="js/jquery.slimscroll.js"></script>
	
	<script src="js/toastr.min.js"></script>
	<script src="js/scrolltop.js"></script>
	<script src="js/pwstrength-bootstrap.min.js"></script>
	
	<script src="js/inspinia.js"></script>

<script>
$(document).ready(function() 
{
$('[data-toggle="tooltip"]').tooltip({container: 'body'});
	
	$('#tblProject').DataTable({
        responsive: true,
        "order"     : [[ 6, 'desc' ]],
        columnDefs: [
                     { orderable: false, targets: 5 }
                  ]
    });
});
    
function funInit()
{
	$("#newPassword").focus();
	$("#screenload").hide();
	
	var msg = '<%=msg%>';
	if(msg != '')
	{
		funSuccessMsg(msg, 'Profile');
	}
}



function funClear()        
{
	$("#txtProjectName").focus();
}

function funSuccessMsg(successMsg, alertMsg)
{
	 toastr.options = {
		closeButton: true,
	 	  	debug: false,
	 	 	progressBar: true,
	 	  	preventDuplicates: true,
	 	  	positionClass: "toast-bottom-right",
	 	  	showDuration: "400",
	 	  	hideDuration: "1000",
	 	  	timeOut: "7000",
	 	  	extendedTimeOut: "1000",
	 	  	showEasing: "swing",
	 	 	ideEasing: "linear",
	 	  	showMethod: "fadeIn",
	 	  	hideMethod: "fadeOut",
          onclick: null
     };
	 toastr.success(successMsg, alertMsg);
}

function funErrorMsg(errorMsg, alertMsg)
{
	 toastr.options = {
		closeButton: true,
	 	  	debug: false,
	 	 	progressBar: true,
	 	  	preventDuplicates: true,
	 	  	positionClass: "toast-bottom-right",
	 	  	showDuration: "400",
	 	  	hideDuration: "1000",
	 	  	timeOut: "7000",
	 	  	extendedTimeOut: "1000",
	 	  	showEasing: "swing",
	 	 	ideEasing: "linear",
	 	  	showMethod: "fadeIn",
	 	  	hideMethod: "fadeOut",
          onclick: null
     };
	 toastr.error(errorMsg, alertMsg);
}

</script>
</html>
