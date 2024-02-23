<%@ page language="java" import="java.io.*,java.util.*,com.saapps.task.Timesheet"%>
<jsp:useBean id="TS" class="com.saapps.task.Timesheet" scope="request"/>
<jsp:setProperty name="TS" property="*"/> 
<%
Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;
Integer sesSaUser_UserTypeId = (Integer)session.getAttribute("sesSaUser_UserTypeId");
if(sesSaUser_UserTypeId == null)sesSaUser_UserTypeId =0;
String sesSaUser_FirstName = (String)session.getAttribute("sesSaUser_FirstName");
if(sesSaUser_FirstName == null)sesSaUser_FirstName ="";

String sesSaUser_TsStatus = (String)session.getAttribute("sesSaUser_TsStatus");
if(sesSaUser_TsStatus == null)sesSaUser_TsStatus ="0";
String sesSaUser_TsViewBy = (String)session.getAttribute("sesSaUser_TsViewBy");
if(sesSaUser_TsViewBy == null)sesSaUser_TsViewBy ="WEEK";


String mode = (String)request.getParameter("pageaction");
if(mode == null) mode = "";
String source = (String)request.getParameter("source");
if(source == null) source = "";

//String tsStatusId = "0,1";
String msg = "";
List lstTs = new ArrayList();
try
{
	if("M".equals(source.trim()))
	{
		sesSaUser_FirstName = "0";
		sesSaUser_TsViewBy ="WEEK";
	}
	
	lstTs = TS.getUserTimesheetList(sesSaUser_User_Id, sesSaUser_UserTypeId, sesSaUser_TsStatus, sesSaUser_TsViewBy);
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
                  <h2>Task</h2>
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item">
                          <a href="dashboard.jsp">Dashboard</a>
                      </li>
                      <li class="breadcrumb-item active">
                          <strong>Task</strong>
                      </li>
                  </ol>
              </div>
        </div>
        
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
             	<div class="ibox float-e-margins col-lg-12" id="listDiv">
					<div class="ibox-content">	
						<!--  <div class="table-responsive" align="left" style="margin-bottom: 20px;">
								<button type="button" id="btnAddTask" name="btnAddTask" class="ladda-button btn btn-success" data-style="expand-left" data-toggle="tooltip" data-placement="bottom" title="Click to add task" onclick="javascript:funAddTask();"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;&nbsp;Add Task</button>
							</div> -->
						
	                     <div class="row" style="margin-bottom:0px;">
	                     <%
	                     if(lstTs.size() > 0)
	                     {
	                     %>
	                     	<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover" data-paging="true" data-filter=#filter id="tblTs">
									<thead>
		                           		<tr>
		                               		<th title="Sort by Date" class="text-center">Date</th>
		                               		<%
						                     if(sesSaUser_User_Id != 4)
						                     {
						                     %>
		                               		<th title="Sort by User" class="text-center">User</th>
		                               		<%
						                     }
		                               		%>
		                               		<th title="Sort by Hours" class="text-center">Hours</th>
		                               		<th title="Sort by Status" class="text-center">Status</th>
		                               		<th title="Sort by Subitted By" class="text-center">Subitted By</th>  
		                               		<th title="Sort by Subitted Date" class="text-center">Subitted Date</th>    
		                               		<th class="text-center" style="background-color: #fff;">Actions</th>                                      
		                           		</tr>
		                      		</thead>
									<tbody>
									<%
		                          		String statusLabelClass = "";String addIconClass = "";
		                          		
		                          		int task_main_id = 0;
		                          		String task_date = "";
		                          		int task_day_of_week = 0;
		                          		int user_id = 0;
		                          		String user_name = "";
		                          		double worked_hours = 0;
		                          		int task_status_id = 0;
		                          		String task_status = "";
		                          		int submitted_by_id =0;
		                          		String submitted_by = "";
		                          		String submitted_date = "";
		                          		int approved_by_id =0;
		                          		String approved_by = "";
		                          		String approved_date = "";
		                          		int is_current_week =0;
		                          		int is_enable_date =0;
		                          		
		                          		int is_ts_saved = 0;
		                          		Iterator itsTs = lstTs.iterator();
		                        		while(itsTs.hasNext())
		                        		{
		                        			task_main_id = (Integer)itsTs.next();
		                        			task_date = (String)itsTs.next();
		                        			task_day_of_week = (Integer)itsTs.next();
		                        			user_id = (Integer)itsTs.next();
		                        			user_name = (String)itsTs.next();
		                        			worked_hours = (Double)itsTs.next();
		                        			task_status_id = (Integer)itsTs.next();
		                        			task_status = (String)itsTs.next();
		                        			
		                        			submitted_by_id = (Integer)itsTs.next();
		                        			submitted_by = (String)itsTs.next();
		                        			submitted_date = (String)itsTs.next();
		                        			
		                        			approved_by_id = (Integer)itsTs.next();
		                        			approved_by = (String)itsTs.next();
		                        			approved_date = (String)itsTs.next();
		                        			
		                        			is_current_week = (Integer)itsTs.next();
		                        			is_enable_date = (Integer)itsTs.next();
		                        			is_ts_saved = (Integer)itsTs.next();
		                        			
		                        			statusLabelClass = "label-success"; // for open
		                        			if(task_status_id == 1)
		                           			{
		                           				statusLabelClass = "label-warning";
		                           			}else if(task_status_id == 2)
		                           			{
		                           				statusLabelClass = "label-primary";
		                           			}else if(task_status_id == 3){
		                           				statusLabelClass = "label-danger";
		                           			}else if(task_status_id == 4){
		                           				statusLabelClass = "label-default";
		                           			}
		                        			
		                        			addIconClass = "fa-plus";
		                        			if(is_ts_saved == 1)
		                           			{
		                        				addIconClass = "fa-pencil-square-o";
		                           			}
		                        			
										%>
											<tr class="gradeX">
										   		<td style="text-align:center;vertical-align: middle;"><%=task_date%></td>
										   		<%
							                     if(sesSaUser_User_Id != 4)
							                     {
							                     %>
										   		<td style="text-align:left;vertical-align: middle;"><%=user_name%></td>
										   		<%
							                     }
			                               		%>
										   		<td style="text-align:right;vertical-align: middle;"><%=worked_hours%></td>
										   		<td style="text-align:center;vertical-align: middle;"><span class="label label-primary" style="display:inline-block;width:80px;"><%=task_status%></span></td>
										   		<td style="text-align:left;vertical-align: middle;"><%=submitted_by%></td>
										   		<td style="text-align:center;vertical-align: middle;"><%=submitted_date%></td>
										   		<td style="text-align:center;vertical-align: middle;">
										   			<i class="fa <%=addIconClass%>" onclick="javascript:funEditProject('<%=task_main_id%>');" aria-hidden="true" data-toggle="tooltip" data-placement="left" data-original-title="Click to edit" style="color: #1c84c6;cursor: pointer;font-size: 16px;vertical-align: middle;"></i>
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
	<!-- <script src="js/datatables.min.js"></script> -->
	
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
	
	$('#tblTs').DataTable({
        responsive: true,
        "order"     : [[ 6, 'desc' ]],
        columnDefs: [
                     { orderable: false, targets: 6 }
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



/* function funClear()        
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
 */
</script>
</html>
