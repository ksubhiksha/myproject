<%@ page language="java" import="java.io.*,java.util.*,java.text.*,com.saapps.task.Timesheet"%>
<jsp:useBean id="TS" class="com.saapps.task.Timesheet" scope="request"/>
<jsp:setProperty name="TS" property="*"/> 
<%
Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;
Integer sesSaUser_UserTypeId = (Integer)session.getAttribute("sesSaUser_UserTypeId");
if(sesSaUser_UserTypeId == null)sesSaUser_UserTypeId =0;
String sesSaUser_FirstName = (String)session.getAttribute("sesSaUser_FirstName");
if(sesSaUser_FirstName == null)sesSaUser_FirstName ="";

String mode = (String)request.getParameter("pageaction");
if(mode == null) mode = "";


String msg = "";
DecimalFormat decimalFormat = new DecimalFormat("#0.00");
try
{
	if("".equals(mode.trim()))
	{
		
	}	
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception while getting information in tsentry.jsp :: " +e.getMessage());
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
<form id="frmTsEntry" name="frmTsEntry" method="POST" autocomplete="off">
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
                  <h2>Timesheet Entry</h2>
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item">
                          <a href="dashboard.jsp">Dashboard</a>
                      </li>
                      <li class="breadcrumb-item">
                          <a href="tslist.jsp">Timesheet</a>
                      </li>
                      <li class="breadcrumb-item active">
                          <strong>Timesheet Entry</strong>
                      </li>
                  </ol>
              </div>
        </div>
        
    	<div id="divTsEntyData">
    	<span id="spanTsEntyData"></span>
    	</div>
     	
     	<input type='hidden' name='pageaction' id='pageaction' value=""/>
     	     	
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
	
	$('#btnSubmit').click(function(){
		$("#frmTsEntry").attr("action", "tsentry.jsp");
		$("#frmTsEntry").submit();
    });
	$('#btnSave').click(function(){
		$("#pageaction").val("TS_ENTRY_SAVE");
		$("#screenload").show();
		$.ajax(
		{
			type	: 	"post",
			url		: 	"tsentryajax.jsp",
			data	: 	$("form#frmTsEntry").serialize(),
			beforeSend: function() {
			},
			complete: function() {					
			},
			success:function(data)
			{
				funSuccessMsg("Timesheet Saved Successfully");
			}
		});
    });
	
});
    
function funInit()
{
	funViewTsEntry();
	var msg = '<%=msg%>';
	if(msg != '')
	{
		funSuccessMsg(msg, 'Profile');
	}
	$("#screenload").hide();
}

function funViewTsEntry()
{
	$("#pageaction").val("TS_ENTRY_LIST");
	$("#screenload").show();
	$.ajax(
	{
		type	: 	"post",
		url		: 	"tsentryajax.jsp",
		data	: 	$("form#frmTsEntry").serialize(),
		beforeSend: function() {
		},
		complete: function() {					
		},
		success:function(data)
		{
			$("#spanTsEntyData").html($.trim(data));
			
		}
	});
}

/* function funClear()        
{
	$("#txtProjectName").focus();
} */

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
