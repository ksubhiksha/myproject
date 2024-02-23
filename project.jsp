<%@ page language="java" import="java.io.*,java.util.*,com.saapps.task.Project, com.saapps.login.User"%>
<jsp:useBean id="Project" class="com.saapps.task.Project" scope="request"/>
<jsp:useBean id="User" class="com.saapps.login.User" scope="request"/>
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
List lstUserPermission = new ArrayList();

try
{
	if(!"".equals(mode.trim()))
	{
		if("SAVE".equals(mode.trim()))
		{
			msg = Project.insertProject(sesSaUser_User_Id);			
		}
		else if("UPDATE".equals(mode.trim()))
		{
			msg = Project.updateProject(sesSaUser_User_Id);
		}
		else if("DELETE".equals(mode.trim()))
		{
			msg = Project.deleteProject();
		}
		else if("UPDATE_STATUS".equals(mode.trim()))
		{
			msg = Project.updateProjectStatus();
		}
	}
	
	lstProject = Project.getProjectList();
	lstUserPermission = User.getUserPermissionList();
	
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception while getting information in project.jsp :: " +e.getMessage());
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
	<link href="css/datatables.min.css" rel="stylesheet">
	<link href="css/awesome-bootstrap-checkbox.css" rel="stylesheet">
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

.popover-header
{
    padding: 8px 14px;
    margin: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 18px;
    background-color: #f7f7f7;
    border-bottom: 1px solid #ebebeb;
    border-radius: 5px 5px 0 0;
}
div.dataTables_paginate {float: right;}
 
</style>
</head>

<body class="md-skin pace-done" onload="funInit();">
<form id="frmProject" name="frmProject" method="POST" autocomplete="off">
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
                  <h2>Project</h2>
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item">
                          <a href="dashboard.jsp">Dashboard</a>
                      </li>
                      <li class="breadcrumb-item active">
                          <strong>Project</strong>
                      </li>
                  </ol>
              </div>
        </div>
        
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
             	<div class="ibox float-e-margins col-lg-12" id="listDiv">
					<div class="ibox-content">	
						<div align="left">
							<button type="button" id="btnAddProject" name="btnAddProject" class="ladda-button btn btn-success" data-style="expand-left" data-toggle="tooltip" data-placement="bottom" title="Click to add project" onclick="javascript:funAddProject();"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;&nbsp;Add Project</button>
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
		                          		int projectId = 0;
		                          		String projectName = "";
		                          		String projectDesc = "";
		                          		String userPermission = "";
		                          		String userPermissionIds = "";
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
		                        			userPermissionIds = (String)itrProject.next();
		                        			isActive = (Integer)itrProject.next();
		                        			createdBy = (String)itrProject.next();
		                        			createdDate = (String)itrProject.next();
										%>
											<tr class="gradeX">
										   		<td style="text-align:left;vertical-align: middle;">	 
										   			<span id="spanProjectName<%=projectId%>" style=""><%=projectName%></span>								   			
										   			<span id="spanProjectDesc<%=projectId%>" style="display:none"><%=projectDesc%></span>
										   			<span id="spanUserPermissionIds<%=projectId%>" style="display:none"><%=userPermissionIds%></span>
										   		</td>
										   		<td style="text-align: left;vertical-align: middle;"><%=projectDesc%></td>
										   		<td style="text-align: left;vertical-align: middle;"><%=userPermission%></td>
										   		<td style="text-align: left;vertical-align: middle;"><%=createdBy%></td>
										   		<td style="text-align: center;vertical-align: middle;"><%=createdDate%></td>
										   		<td style="text-align: center;vertical-align: middle;">
										   			<i class="fa fa-pencil-square-o" onclick="javascript:funEditProject(<%=projectId%>);" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" data-original-title="Click to edit" style="color: #1c84c6;cursor: pointer;font-size: 16px;vertical-align: middle;"></i>&nbsp;
	                   								<a class="spanDelete" id="spanProjectDelete<%=projectId%>" data-toggle="tooltip" data-placement="bottom" data-Title="Click to delete" ><i class="fa fa fa-trash-o" style="color:#ed5565;cursor: pointer;font-size:16px;vertical-align: middle;"></i></a>&nbsp;
	                   								<%
		               									if(isActive > 0)
		               									{
	                   								%>
	                   									<a class="spanStatus" id="spanChangeStatus<%=projectId%>" onclick="javascript:funUpdateStatus(<%=projectId%>, 0);" data-toggle="tooltip" data-placement="bottom" data-original-title="Change status to In-Active?"><i class="fa fa-thumbs-up" aria-hidden="true" style="color: #009284;cursor: pointer;font-size: 16px;vertical-align: middle;"></i></a>
	                   								<%
	                   									}else{
	                   								%>
	                   									<a class="spanStatus" id="spanChangeStatus<%=projectId%>" onclick="javascript:funUpdateStatus(<%=projectId%>, 1);"  data-toggle="tooltip" data-placement="bottom" data-original-title="Change status to Active?"><i class="fa fa-thumbs-down" aria-hidden="true" style="color: #ff5959;cursor: pointer;font-size: 16px;vertical-align: middle;"></i></a>
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
     	
     	<div class="modal inmodal fade" id="myModalProject" tabindex="-1" role="dialog"  aria-hidden="true">
	        <div class="modal-dialog modal-lg">
	            <div class="modal-content">
	                <div class="modal-header" style="padding: 15px 15px;">
                    	<button type="button" class="close" data-dismiss="modal" data-toggle="tooltip" data-placement="bottom" title="Click to close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    	<h4 class="modal-title" data-dismiss="modal">Project</h4>
	                </div>
	                <div class="modal-body">
                    	<div style="margin-right: -20px;margin-left: -20px;">
							<div class="col-lg-12">
			                	<div class="contact-box" style="margin-bottom: -10px;">
	                                <div class="form-group row">
	                                 	<div class="col-lg-3">
	                                 		<label class="col-form-label control-label">Project Name&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
	                                 	</div>
	                                 	<div class="col-lg-9">
	                                 		<input type="text" id="txtProjectName" name="txtProjectName" placeholder="Project Name" class="form-control" value="">
	                                 	</div>
	                                </div>
	                                <div class="form-group row">
	                                 	<div class="col-lg-3">
	                                 		<label class="col-form-label control-label">Project Description&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
	                                 	</div>
	                                 	<div class="col-lg-9">
	                                 		<input type="text" id="txtProjectDescription" name="txtProjectDescription" placeholder="Project Description" class="form-control" value="">
	                                 	</div>
	                                </div> 
	                                <div class="form-group row">
	                                 	<div class="col-lg-3">
	                                 		<label class="control-label">User Permission&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
	                                 	</div>
	                                 	<div class="col-lg-9">
		                                 	 <div class="form-group row">
		                                 		<%
					    						if(lstUserPermission.size() > 0)
					    						{
					    							int userId = 0;
					    							String userName = "";
					    							
					    							Iterator itrList = lstUserPermission.iterator();
													 while(itrList.hasNext())
													 { 
														userId = (Integer)itrList.next(); 
														userName = (String)itrList.next();
					    						%>
					    							 <div class="col-lg-3 col-md-4">
						    							 <div class="checkbox checkbox-success" style="padding-left: 10px;">
						                                     <input class="chkUserPermission" name="chkUserPermission" id="chkUserPermission<%=userId%>" type="checkbox" value="<%=userId%>" >
						                                     <label for="chkUserPermission<%=userId%>">
						                                         <%=userName%>
						                                     </label>
						                                 </div>
						                              </div>
					    						<%
													}
					    						}
												%>
											</div>
	                                 	</div>
	                                </div> 
			               		</div>
                        	</div>
                        </div>
	                </div>
	
	                <div class="modal-footer">
	                    <button type="button" id="btnSave" name="btnSave" class="ladda-button btn btn-primary" data-style="expand-left" data-toggle="tooltip" data-placement="bottom" title="Click to save" onclick="javascript:funSaveProject();">Save</button>
                    	<button type="button" id="btnClose" id="btnClose" class="btn btn-white" data-dismiss="modal" data-toggle="tooltip" data-placement="bottom" title="Click to close">Cancel</button>
	                </div>
	            </div>
	        </div>
	    </div>
     	
     	
     	<input type='hidden' name='pageaction' id='pageaction' value=""/>
     	<input type='hidden' name='source' id='source' value="<%=source%>"/>
     	<input type='hidden' name='hidMode' id='hidMode' value=""/>
     	<input type='hidden' name='hidProjectId' id='hidProjectId' value="0"/>
     	<input type='hidden' name='isActive' id='isActive' value="0"/>
     	<input type='hidden' name='hidCombineUserPermissionIds' id='hidCombineUserPermissionIds' value=""/>
     	     	
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
	
	<script src="js/datatables.min.js"></script>
    <script src="js/dataTables.bootstrap4.min.js"></script>
	
	<script src="js/inspinia.js"></script>
	
	<script src="js/jquery.popconfirms.js"></script>  
	
<script>
$(document).ready(function() 
{
	$('[data-toggle="tooltip"]').tooltip({container: 'body'});
	$(".popconfirm").popConfirm();

	$('#tblProject').DataTable( {
		 responsive: true,
		 "order"     : [[ 0, 'asc' ]],
		 columnDefs: [
	                     { orderable: false, targets: 5 }
	                  ]
	});
	
	$(document).on('keydown', '.chkUserPermission', function(e)
  	{
		if(e.keyCode == 13)
		{
			funSaveProject();
		}
  	});
	 
	var yesBtnVal = "Delete";
    var noBtnVal = "Close";
    var data = "<div style='text-align:center;'><span onclick='javascript:funDeleteProject();' class='btn btn-primary btn-sm' style='width: 70px;'>"+yesBtnVal+"</span>&nbsp;&nbsp;<span onclick='javascript:funCloseDelete();' class='btn btn-default btn-sm' style='width: 70px;'>"+noBtnVal+"</span><div>";
    
	$(".spanDelete").popConfirm(
	{
	    title: "Click to delete",
	    content:data,
	    placement: "left",
	    trigger: 'toggle'
	}); 
	
	$(".spanDelete").click(function(e)
	{
		var projectId = $(this).attr("id");
		projectId = projectId.replace('spanProjectDelete',"");
        $("#hidProjectId").val(projectId);
        
	});
	
});

function funDeleteProject()
{
	$("#pageaction").val("DELETE");
	
	$("#frmProject").attr("action","project.jsp");
	$("#frmProject").submit(); 
}

function funCloseDelete()
{
	$(".spanDelete").popConfirm('hide');
}

function funUpdateStatus(projectId, isActive)
{
	 $("#hidProjectId").val(projectId);
	 $("#isActive").val(isActive);
	 $("#pageaction").val("UPDATE_STATUS");
	 
	 $("#frmProject").attr("action","project.jsp");
	 $("#frmProject").submit(); 
}
      
function funInit()
{
	$("#screenload").hide();
	
	var msg = '<%=msg%>';
	if(msg != '')
	{
		funSuccessMsg(msg, 'Project');
	}
}

function funAddProject()
{
	$("#txtProjectName").val("");
	$("#txtProjectDescription").val("");
	$("[name=chkUserPermission]").prop('checked', false);
	$("#hidMode").val("");
	
	$("#btnSave").text("Save");
	$("#btnSave").attr('data-original-title', "Click to save");
	
	$("#myModalProject").modal('show');
	
	setTimeout(function(){
		$("#txtProjectName").focus();		
	}, 500);
}

function funSaveProject()
{
	var txtProjectName = $.trim($("#txtProjectName").val());
	var txtProjectDescription = $.trim($("#txtProjectDescription").val());
	var chkedUserPermission = $('[name=chkUserPermission]:checked').length; 
	
	if(txtProjectName == "")
	{
		$("#txtProjectName").focus();
		funErrorMsg("Please enter project name");
		return false;
	}
	else if(txtProjectDescription == "")
	{
		$("#txtProjectDescription").focus();
		funErrorMsg("Please enter project description");
		return false;
	}
	else if(parseInt(chkedUserPermission) == 0)
	{
		funErrorMsg("Please check atleast one user permission");
		return false;
	}
	
	var combinePemissionIds = "";
	$("[name=chkUserPermission]").each(function(index) 
	{
		if($(this).prop('checked')) 
		{
			var chkPemissionId = $.trim($(this).val());
			
			if(combinePemissionIds == "")
			{
				combinePemissionIds = chkPemissionId;
			}else{
				combinePemissionIds = combinePemissionIds + "," + chkPemissionId; 
			}
		}
	});
	
	$("#hidCombineUserPermissionIds").val(combinePemissionIds);

	var hidMode = $.trim($("#hidMode").val());
	if(hidMode == "")
	{
		$("#pageaction").val("SAVE");
	}else{
		$("#pageaction").val("UPDATE");
	}
	
	$("#frmProject").attr("action","project.jsp");
	$("#frmProject").submit(); 
}

function funEditProject(projectId)
{
	var spanProjectName = $.trim($("#spanProjectName"+projectId).text()); 
	var spanProjectDesc = $.trim($("#spanProjectDesc"+projectId).text()); 
	var spanUserPermissionIds = $.trim($("#spanUserPermissionIds"+projectId).text()); 
	
	$("[name=chkUserPermission]").prop('checked', false);
	
	$("#txtProjectName").val(spanProjectName);
	$("#txtProjectDescription").val(spanProjectDesc);
	$("#hidProjectId").val(projectId);
	
	$("#hidMode").val("UPDATE");
	$("#btnSave").text("Update");
	$("#btnSave").attr('data-original-title', "Click to update");
	
	if(spanUserPermissionIds != '')
	{
		var splitArray = $.trim(spanUserPermissionIds).split(",");
	    for(var i=0; i<splitArray.length; i++)
	    {
	    	$('#chkUserPermission'+splitArray[i]).prop('checked', true);
	    }
	}
	
	$("#myModalProject").modal('show');
	
	setTimeout(function(){
		$("#txtProjectName").focus();		
	}, 500);
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
