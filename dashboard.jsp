<%@ page language="java" import="java.io.*,java.util.*,com.saapps.task.Dashboard"%>
<jsp:useBean id="DB" class="com.saapps.task.Dashboard" scope="request"/>
<jsp:setProperty name="DB" property="*"/> 
<%
Integer sesEmpId = (Integer)session.getAttribute("sesftp_EmpId");
if(sesEmpId == null)sesEmpId =0;
String sesFirstName = (String)session.getAttribute("sesftp_FirstName");
if(sesFirstName == null)sesFirstName ="";
String sesLastName = (String)session.getAttribute("sesftp_LastName");
if(sesLastName == null)sesLastName ="";

Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;
Integer sesSaUser_UserTypeId = (Integer)session.getAttribute("sesSaUser_UserTypeId");
if(sesSaUser_UserTypeId == null)sesSaUser_UserTypeId =0;

String userName = "";
userName = sesFirstName + " " + sesLastName;

String strAction=(String)request.getParameter("pageAction");
if(strAction==null)strAction="";

String hidRPId =(String)request.getParameter("hidRPId");
if(hidRPId==null)hidRPId="";

/* ArrayList<RequestProject> listProjectDetails = new ArrayList<RequestProject>(); */
/* List lstRecipient = new ArrayList();

List lstLogActivity = new ArrayList(); */

/* String appPath = getServletContext().getRealPath("/");
String strOSName = System.getProperty("os.name");
 */
String msg = "";
/* int rpId = 0;
int ownerId = 0;
int projectId = 0;
String projectName = "";

String fromDate = "";
String toDate = "";
String notes = "";
int createdBy = 0;
String createdName = "";
String createdDate = "";
int lockDays = 0;
int approvedBy = 0;  
String approvedDate = "";
int isApproved = 0;
String projectRecipientIds = "";
int folderCount = 0;
int fileCount = 0;
int isActive = 0;
String totalFileSize = "";

int logId = 0;
int empId = 0;
String logUserName = "";  
String logType = "";
String logAction = "";
String logDate = ""; */

List lstDBCount = new ArrayList();
int WEEKLY_NOT_SUBMITTED_COUNT = 0;
int WEEKLY_SUBMITTED_COUNT = 0;
int WEEKLY_TOTAL_COUNT = 0;
double WEEKLY_TOTAL_HOURS = 0;
int MONTHLY_NOT_SUBMITTED_COUNT = 0;
int MONTHLY_SUBMITTED_COUNT = 0;
int MONTHLY_TOTAL_COUNT = 0;
double MONTHLY_TOTAL_HOURS = 0;
List listToDo = new ArrayList();
try
{
	if(!"".equals(strAction.trim()))
	{
		/* if("SAVE".equals(strAction.trim()))
		{
			msg = RP.insertRequestProject(sesEmpId);
			
		}else if("UPDATE".equals(strAction.trim()))
		{
			msg = RP.updateRequestProject(hidRPId, sesEmpId);
			
		}else if("UPDATE_STATUS".equals(strAction.trim()))
		{
			msg = RP.updateStatus(hidRPId, sesEmpId);
		}
		else if("DELETE".equals(strAction.trim()))
		{
			msg = RP.deleteRequestProject(hidRPId, sesEmpId);
		}  */
	}
	
	lstDBCount = DB.getUserDashboardDetails(sesSaUser_User_Id, sesSaUser_UserTypeId);
	if(lstDBCount.size() > 0)
	{
		Iterator itrCount = lstDBCount.iterator();
		while(itrCount.hasNext())
		{
			WEEKLY_NOT_SUBMITTED_COUNT = (Integer)itrCount.next();
			WEEKLY_SUBMITTED_COUNT = (Integer)itrCount.next();
			WEEKLY_TOTAL_COUNT = (Integer)itrCount.next();
			WEEKLY_TOTAL_HOURS = (Double)itrCount.next();
			MONTHLY_NOT_SUBMITTED_COUNT = (Integer)itrCount.next();
			MONTHLY_SUBMITTED_COUNT = (Integer)itrCount.next();
			MONTHLY_TOTAL_COUNT = (Integer)itrCount.next();
			MONTHLY_TOTAL_HOURS = (Double)itrCount.next();
		}
	}
	
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception while getting information in pmdashboard.jsp :: " +e.getMessage());
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
    <!-- <link href="css/datatables.min.css" rel="stylesheet">
    <link href="css/datepicker3.css" rel="stylesheet">
    <link href="css/toastr.min.css" rel="stylesheet"> -->
    <link href="css/scrolltop.css" rel="stylesheet">
    <link href="css/awesome-bootstrap-checkbox.css" rel="stylesheet">
    
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
	  width: 990px; /* New width for large modal */
	}
}
@media screen and (min-width: 1220px) {
	.modal-lg {
	  width: 1200px; /* New width for large modal */
	}
}
.dataTables_length
{
	display: none;
}
</style>
</head>

<body class="md-skin pace-done" onload="funInit();">
<form id="frmDashboard" name="frmDashboard" method="POST" autocomplete="off">
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
                  <h2>Dashboard</h2>
                  <ol class="breadcrumb">
                     <!--  <li class="breadcrumb-item">
                          <a href="index.html">Home</a>
                      </li> -->
                      <li class="breadcrumb-item active">
                          <strong>Dashboard</strong>
                      </li>
                  </ol>
              </div>
        </div>
        
        
                
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
        		
        		
        		<div class="col-lg-12">
                	 <div class="ibox float-e-margins">
            			<div class="ibox-content">
            				<div class="row">
			               <div class="col-lg-4">
				                <div class="widget style1 red-bg" style="cursor:pointer;" onclick="javascript:funViewTask('0','<%=WEEKLY_NOT_SUBMITTED_COUNT%>','WEEK');">
				                    <div class="row">
				                        <div class="col-4">
				                            <i class="fa fa-envelope-o fa-5x"></i>
				                        </div>
				                        <div class="col-8 text-right">
				                            <span> Open Task </span>
				                            <h2 class="font-bold"><%=WEEKLY_NOT_SUBMITTED_COUNT%></h2>
				                        </div>
				                    </div>
				                </div>
				            </div>
				            
				            <div class="col-lg-4">
				                <div class="widget style1 navy-bg" style="cursor:pointer;" onclick="javascript:funViewTask('1','<%=WEEKLY_SUBMITTED_COUNT%>','WEEK');">
				                    <div class="row">
				                        <div class="col-4">
				                            <i class="fa fa-thumbs-up fa-5x"></i>
				                        </div>
				                        <div class="col-8 text-right">
				                            <span> Closed Task </span>
				                            <h2 class="font-bold"><%=WEEKLY_SUBMITTED_COUNT%></h2>
				                        </div>
				                    </div>
				                </div>
				            </div>
				            
				            <div class="col-lg-4">
				                <div class="widget style1 blue-bg" style="cursor:pointer;" onclick="javascript:funViewTask('101','<%=WEEKLY_SUBMITTED_COUNT%>');">
				                    <div class="row">
				                        <div class="col-4">
				                            <i class="fa fa-search fa-5x"></i>
				                        </div>
				                        <div class="col-8 text-right">
				                            <span> Search Task </span>
				                            <!-- <h2 class="font-bold">0</h2> -->
				                        </div>
				                    </div>
				                </div>
				            </div>
            
               			  </div>
                        </div>
                    </div>
                </div>
                
               </div>
               
               <div class="row">
	               <div class="col-lg-6 col-md-4">
				        <div class="ibox-content">
				            <h2>TODO List</h2>
				            <small>This is you and your team to do list</small>
				            <ul class="todo-list m-t">
				                <%
				                listToDo = DB.getDashboardToDoList(sesSaUser_User_Id, sesSaUser_UserTypeId);
				            	if(listToDo.size() > 0)
				            	{
				            		int tdl_id = 0;
				            		String to_do_task = "";
				            		String task_assigned_users = "";
				            		String created_date = "";
				            		String created_by = "";
				            		String To_Do_Difference_Time = "";
				            		int Is_Assigned = 0;
				            		String assignedTo = "";
				            		String assignedToCls = "";
				            		String timeDiffCls = "";
				            		
				            		Iterator itrToDo = listToDo.iterator();
				            		while(itrToDo.hasNext())
				            		{
				            			tdl_id = (Integer)itrToDo.next();
				            			to_do_task = (String)itrToDo.next();
				            			task_assigned_users = (String)itrToDo.next();
				            			created_date = (String)itrToDo.next();
				            			created_by = (String)itrToDo.next();
				            			To_Do_Difference_Time = (String)itrToDo.next();
				            			Is_Assigned = (Integer)itrToDo.next();
				            			
				            			assignedTo = "O";	// Others under by me.
				            			assignedToCls = "btn-danger";
				            			if(Is_Assigned > 0)
				            			{
				            				assignedTo = "M";	 // Mine
				            				assignedToCls = "btn-success";
				            			}
				            			timeDiffCls = "label-primary";
				            			if(To_Do_Difference_Time.indexOf("hour") >= 0)
				            			{
				            				timeDiffCls = "label-info";
				            			}else if(To_Do_Difference_Time.indexOf("day") >= 0)
				            			{
				            				timeDiffCls = "label-warning";
				            			}else if(To_Do_Difference_Time.indexOf("month") >= 0)
				            			{
				            				timeDiffCls = "label-danger";
				            			}else if(To_Do_Difference_Time.indexOf("year") >= 0)
				            			{
				            				timeDiffCls = "label-danger";
				            			}
				            	%>
				            	<li>
				                    <div class="icheckbox_square-green" style="position: relative;"><input type="checkbox" class="ng-pristine ng-untouched ng-valid ng-empty" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins></div>
				                    <span class="m-l-xs"><button type="button" class="btn btn-circle <%=assignedToCls%>" data-toggle="tooltip" data-placement="bottom" title="<%=task_assigned_users%>" ><%=assignedTo%></button>&nbsp;&nbsp;<%=to_do_task%></span>
				                    <small class="label <%=timeDiffCls%>"><i class="fa fa-clock-o"></i> <%=To_Do_Difference_Time%></small>
				                </li>	
				            	<%		
				            		}
				            	}else
				            	{
				            	%>
				            	<li>
				                    <div class="icheckbox_square-green" style="position: relative;"><input type="checkbox" class="ng-pristine ng-untouched ng-valid ng-empty" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins></div>
				                    <span class="m-l-xs">No to do list available.</span>
				                </li>
				            	<%	
				            	}
				                %>
				            </ul>
				        </div>
				        
				    </div>
				    
				    
				    <div class="col-lg-3 col-md-4">
				        <div class="ibox-content">
				            <h2>THIS WEEK <small style="float:right;font-size:15px;"><a href="#">Download</a></small></h2>
				            <small>This is you and your team current week status</small>				            
				            <div>
					            <table class="table">
					                <tbody>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-primary m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0,1,2,3,4','<%=WEEKLY_TOTAL_COUNT%>','WEEK');"><%=WEEKLY_TOTAL_COUNT%></button>
					                        Total Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-danger m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0','<%=WEEKLY_NOT_SUBMITTED_COUNT%>','WEEK');"><%=WEEKLY_NOT_SUBMITTED_COUNT%></button>
					                        Open Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-warning m-r-sm" style="width:60px;" onclick="javascript:funViewTask('1','<%=WEEKLY_SUBMITTED_COUNT%>','WEEK');"><%=WEEKLY_SUBMITTED_COUNT%></button>
					                        Submitted Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-success m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0,1,2,3,4','<%=WEEKLY_SUBMITTED_COUNT%>','WEEK');"><%=WEEKLY_TOTAL_HOURS%></button>
					                        Total Hours
					                    </td>
					                </tr>
					                </tbody>
					            </table>
					        </div>
        
				        </div>				        
				    </div>
				    
				    <div class="col-lg-3 col-md-4">
				        <div class="ibox-content">
				            <h2>THIS MONTH <small style="float:right;font-size:15px;"><a href="#">Download</a></small></h2>
				            <small>This is you and your team current month status</small>				            
				            <div>
					            <table class="table">
					                <tbody>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-primary m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0,1,2,3,4','<%=MONTHLY_TOTAL_COUNT%>','MONTH');"><%=MONTHLY_TOTAL_COUNT%></button>
					                        Total Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-danger m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0','<%=MONTHLY_NOT_SUBMITTED_COUNT%>','MONTH');"><%=MONTHLY_NOT_SUBMITTED_COUNT%></button>
					                        Open Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-warning m-r-sm" style="width:60px;" onclick="javascript:funViewTask('1','<%=MONTHLY_SUBMITTED_COUNT%>','MONTH');"><%=MONTHLY_SUBMITTED_COUNT%></button>
					                        Submitted Tasks
					                    </td>
					                </tr>
					                <tr>
					                    <td>
					                        <button type="button" class="btn btn-success m-r-sm" style="width:60px;" onclick="javascript:funViewTask('0,1,2,3,4','<%=MONTHLY_TOTAL_HOURS%>','MONTH');"><%=MONTHLY_TOTAL_HOURS%></button>
					                        Total Hours
					                    </td>
					                </tr>
					                </tbody>
					            </table>
					        </div>
        
				        </div>				        
				    </div>
				    
				    
				    <!-- <div class="col-lg-6">
        <div>
            <table class="table">
                <tbody>
                <tr>
                    <td>
                        <button type="button" class="btn btn-danger m-r-sm">12</button>
                        Total messages
                    </td>
                    <td>
                        <button type="button" class="btn btn-primary m-r-sm">28</button>
                        Posts
                    </td>
                    <td>
                        <button type="button" class="btn btn-info m-r-sm">15</button>
                        Comments
                    </td>
                </tr>
                <tr>
                    <td>
                        <button type="button" class="btn btn-info m-r-sm">20</button>
                        News
                    </td>
                    <td>
                        <button type="button" class="btn btn-success m-r-sm">40</button>
                        Likes
                    </td>
                    <td>
                        <button type="button" class="btn btn-danger m-r-sm">30</button>
                        Notifications
                    </td>
                </tr>
                <tr>
                    <td>
                        <button type="button" class="btn btn-warning m-r-sm">20</button>
                        Albums
                    </td>
                    <td>
                        <button type="button" class="btn btn-default m-r-sm">40</button>
                        Groups
                    </td>
                    <td>
                        <button type="button" class="btn btn-warning m-r-sm">30</button>
                        Permissions
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div>

        </div>
    </div> -->
    
			   </div>
    
     	</div>
     	
     	
     	
     </div>
     <div class="scroll-top-wrapper" style="background: #19c0a0;">
		<span class="scroll-top-inner">
			<i class="fa fa-2x fa-arrow-circle-up"></i>
		</span>
	</div>
	
	<input type='hidden' name='pageaction' id='pageaction' value=""/>
	<input type='hidden' name='status' id='status' value=""/> 
	<input type='hidden' name='viewBy' id='viewBy' value=""/>
	
</div>

</form>
</body>

 	<!-- <script src="js/jquery-1.12.4.min.js"></script> -->
 	<script src="js/popper.min.js"></script>
 	
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.metisMenu.js"></script>
	<script src="js/jquery.slimscroll.js"></script>
	
	<!-- <script src="js/datatables.min.js"></script>
	<script src="js/bootstrap-datepicker.js"></script>
	<script src="js/toastr.min.js"></script>
	<script src="js/bootstrap3-typeahead.min.js"></script>  --> 
	<script src="js/scrolltop.js"></script>
	
	<script src="js/inspinia.js"></script>
	

<script>
$(document).ready(function() 
{
	$('[data-toggle="tooltip"]').tooltip({container: 'body'});
	
	/* $('#tblViewProject').DataTable({
        responsive: true,
        "order"     : [[ 6, 'desc' ]],
        columnDefs: [
                     { orderable: false, targets: 7 }
                  ]
    });
	
	$('#datepicker .input-daterange').datepicker({
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
	
	$(document).on("click", ".spanDelete",function(e)
	{
        $(".spanDelete").popover('destroy');
        
        var rpId = $(this).attr("id");
        rpId = rpId.replace('spanProjectDelete',"");
        $("#hidRPId").val(rpId);
        
        var yesBtnVal = "Delete";
        var noBtnVal = "Close";
        var data = "<div style='text-align:center;'><span onclick='javascript:funDeleteRequestProject();' class='btn btn-danger btn-sm' style='width: 70px;'>"+yesBtnVal+"</span>&nbsp;&nbsp;<span onclick='javascript:funCloseDelete();' class='btn btn-default btn-sm' style='width: 70px;'>"+noBtnVal+"</span><div>";
        $(this).popover('destroy').popover({
            html: true,
            placement : 'left',
            template: '<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            content : data
         }).popover('show');
    });

    $(document).on("click", ".spanStatus",function(e)
    {
        $(".spanStatus").popover('destroy');
        
        var combineVal = $(this).attr("id");
        
        var rpId = combineVal.substring(0, combineVal.indexOf("~^"));
        var isactive = combineVal.substring(combineVal.lastIndexOf("~^")+2);
        
        rpId = rpId.replace('spanChangeStatus',"");
        $("#hidRPId").val(rpId);
        
        var yesBtnVal = "Active";var noBtnVal = "Close"; var btnClass = "btn-primary"; 
		if(parseInt(isactive) == 1)
		{
			yesBtnVal = "In-Active";btnClass = "btn-danger"; 
		}
        var data = "<div style='text-align:center;'><span onclick='javascript:funChangeStatus();' class='btn "+btnClass+" btn-sm' style='width: 80px;'>"+yesBtnVal+"</span>&nbsp;&nbsp;<span onclick='javascript:funCloseStatus();' class='btn btn-default btn-sm' style='width: 80px;'>"+noBtnVal+"</span><div>";
        $(this).popover('destroy').popover({
            html: true,
            placement : 'left',
            template: '<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>',
            content : data
         }).popover('show');
   }); */
	
		 
	
});
    
function funInit()
{
	$("#screenload").hide();
	
	var msg = '<%=msg%>';
	if(msg != '')
	{
		funSuccessMsg(msg);
	}
}

function funViewTask(status, count, viewBy)
{
	if(status != "101" && (viewBy == "WEEK" || viewBy == "MONTH"))
	{
		if(parseInt(count) > 0)
		{
			$("#pageaction").val("DB_VIEW_TS");
			$("#status").val(status);
			$("#viewBy").val(viewBy);
			$("#screenload").show();
			$.ajax(
			{
				type	: 	"post",
				url		: 	"setsessionvariables.jsp",
				data	: 	$("form#frmDashboard").serialize(),
				beforeSend: function() {
				},
				complete: function() {					
				},
				success:function(data)
				{
					$("#frmDashboard").attr("action", "tslist.jsp");
					$("#frmDashboard").submit();
				}
			});
			
		}
	}else if(status == "101")
	{
		
	}
}

/* function funRequestProject()
{
	$("#hidRPId").val("");
	$("#projectName").val("");
	$("#fromDate").val("");
	$("#toDate").val("");
	$("#notes").val("");
	$("#pageaction").val("");
	
	$('#fromDate').datepicker('setDate', '');
	$('#toDate').datepicker('setDate', '');
	
	$("#projectName").removeAttr("disabled"); 
	$("#fromDate").removeAttr("disabled"); 
	
	setTimeout(function(){
		$("#projectName").focus();
	}, 500);
	
	$("#myModalRequestProject").modal('show');
}

function funSaveRequestProject()
{
	$("#projectName").removeAttr("disabled"); 
	$("#fromDate").removeAttr("disabled");
	
	var projectName = $.trim($("#projectName").val());
	var fromDate = $.trim($("#fromDate").val());
	var toDate = $.trim($("#toDate").val());
	var notes = $.trim($("#notes").val());
	
	if(projectName == "")
	{
		$("#projectName").focus();
		funErrorMsg("Please enter project");
		return false;
		
	}else if(fromDate == "")
	{
		$("#fromDate").focus();
		funErrorMsg("Please select from date");
		return false;
		
	}else if(toDate == "")
	{
		$("#toDate").focus();
		funErrorMsg("Please select todate");
		return false;
		
	}else if(Date.parse(fromDate) > Date.parse(toDate))
	{
		$("#toDate").focus();
		funErrorMsg("Start date cannot be after end date");
		return false;
		
	}else if(notes == "")
	{
		$("#notes").focus();
		funErrorMsg("Please enter notes");
		return false;
	}
	
	var pageaction = $.trim($("#pageaction").val());
	if(pageaction == "")
	{
		$("#pageAction").val("SAVE");
	}else{
		$("#pageAction").val("UPDATE");
	}
	
	$("#frmDashboard").attr("action","pmdashboard.jsp");
	$("#frmDashboard").submit(); 
}

function funQuickViewProject(rpId, lockDays, isApproved)
{
	var project = $("#spanProjectName"+rpId).text();
	var fromDate = $("#spanFromDate"+rpId).text();
	var toDate = $("#spanToDate"+rpId).text();
	var notes = $("#spanNotes"+rpId).text();
	var createdName = $("#spanCreatedName"+rpId).text();
	var createdDate = $("#spanCreatedDate"+rpId).text();
	
	var status = "";
	var statusLabel = "";
	if(parseInt(isApproved) > 0)
	{
		status = "Approved";
		statusLabel = "#1ab394";
		
	}else{
		status = "Awaiting Approval";
		statusLabel = "#ed5565";
	}
	
	$("#txtQVProject").text(project);
	$("#txtQVDuration").text(fromDate +" To "+ toDate);
	$("#txtQVLockDays").text(lockDays);
	$("#txtQVNotes").text(notes);
	$("#txtQVStatus").text(status);
	$("#txtQVStatus").css("color", statusLabel);
	$("#txtQVCreatedName").text(createdName);
	$("#txtQVCreatedDate").text(createdDate);
	
	$("#quickViewModal").modal("show");
}

function funEditProject(rpId, projectId, isApproved)
{
	var project = $("#spanProjectName"+rpId).text();
	var fromDate = $("#spanFromDate"+rpId).text();
	var toDate = $("#spanToDate"+rpId).text();
	var notes = $("#spanNotes"+rpId).text();
	    
	$("#hidRPId").val(rpId);
	$("#projectId").val(projectId);
	$("#projectName").val(project);
	$("#notes").val(notes);
	
	$("#fromDate").datepicker('setDate', fromDate);
	$("#toDate").datepicker('setDate', toDate);
	
	$("#pageaction").val("UPDATE");
	
	if(parseInt(isApproved) > 0)
	{
		$("#projectName").attr("disabled", "disabled");
		$("#fromDate").attr("disabled", "disabled");
		
		setTimeout(function(){
			$("#toDate").focus();
		}, 500);
	}else{
		$("#projectName").removeAttr("disabled"); 
		$("#fromDate").removeAttr("disabled");
		
		setTimeout(function(){
			$("#projectName").focus();
		}, 500);
	}
	
	$("#myModalRequestProject").modal('show');
}


function funDeleteRequestProject()
{
	$("#pageAction").val("DELETE");
	$("#frmDashboard").attr("action","pmdashboard.jsp");
	$("#frmDashboard").submit(); 
}

function funChangeStatus()   
{
	$("#pageAction").val("UPDATE_STATUS");
	$("#frmDashboard").attr("action","pmdashboard.jsp");
	$("#frmDashboard").submit(); 
}

function funCloseDelete()
{
	$(".spanDelete").popover('destroy');
}

function funCloseStatus()  
{
	$(".spanStatus").popover('destroy');
}

function funViewProjects(rpId, ownerId, projectName)
{
	$("#hidRPId").val(rpId);
	$("#hidOwnerId").val(ownerId);
	$("#hidProjectName").val(projectName);
	
	$("#frmDashboard").attr("action","viewproject.jsp");
	$("#frmDashboard").submit(); 
}

function funViewLog()
{
	$("#frmDashboard").attr("action", "logactivities.jsp");
	$("#frmDashboard").submit();
}

function funSuccessMsg(successMsg)
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
	 toastr.success(successMsg, 'Request Project!');
}

function funErrorMsg(Msg)
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
	 toastr.error(Msg, 'Request Project!');
} */
       
</script>
</html>
