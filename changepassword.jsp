<%@ page language="java" import="java.io.*,java.util.*,com.saapps.login.Login"%>
<jsp:useBean id="Login" class="com.saapps.login.Login" scope="request"/>
<jsp:setProperty name="Login" property="*"/> 
<%
Integer sesSaUser_User_Id = (Integer)session.getAttribute("sesSaUser_User_Id");
if(sesSaUser_User_Id == null)sesSaUser_User_Id =0;
String sesSaUser_ReferenceNo = (String)session.getAttribute("sesSaUser_ReferenceNo");
if(sesSaUser_ReferenceNo == null)sesSaUser_ReferenceNo ="";

String User_Id = (String)request.getParameter("User_Id");
if(User_Id == null) User_Id = "0";
String Is_Reset_Password = (String)request.getParameter("Is_Reset_Password");
if(Is_Reset_Password == null) Is_Reset_Password = "";

String mode = (String)request.getParameter("pageaction");
if(mode == null) mode = "";
String source = (String)request.getParameter("source");
if(source == null) source = "";

List lstEditRecipient = new ArrayList();
String msg = "";
String password = "";

try
{
	if("UPDATE_PASSWORD".equals(mode.trim()))
	{
		if(Integer.parseInt(User_Id) > 0)
		{
			sesSaUser_User_Id = Integer.parseInt(User_Id);
			sesSaUser_ReferenceNo = Login.getUserReferenceNo(User_Id);
		}
		
		Login.updatePassword(sesSaUser_User_Id, sesSaUser_ReferenceNo);
		response.sendRedirect("login.jsp");
	}
}catch(Exception e)
{
	e.printStackTrace();
	System.out.println("Exception while getting information in changepassword.jsp :: " +e.getMessage());
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
@media screen and (min-width: 992px) 
{
	.modal-lg 
	{
	  width: 650px; /* New width for large modal */
	}
}
@media screen and (min-width: 1220px) 
{
	.modal-lg 
	{
	  width: 650px; /* New width for large modal */
	}
}
</style>
</head>

<body class="md-skin pace-done" onload="funInit();">
<form id="frmChangePassword" name="frmChangePassword" method="POST" autocomplete="off">
    <div id="wrapper">
 	<%
 	if(Is_Reset_Password.equals(""))
 	{
 	%>
 	<%@ include file="menubarside.jsp"%>
 	<%
 	} 
 	%>
 	
	<div id="page-wrapper" class="gray-bg">
		<%
	 	if(Is_Reset_Password.equals(""))
	 	{
	 	%>
	 	<%@ include file="menubartop.jsp"%>
	 	<%
	 	} 
	 	%>
		
		<div id="screenload">
			<div class="modal-backdrop in fv-modal-stack" style="z-index: 1049;"></div>	
			<div id="iconRepeatMain">
				 <a class="btn btn-lg btn-default has-spinner" style="color: #009688;">
			    	&nbsp;&nbsp;<span class="spinner"><i class="fa fa-spinner fa-spin"></i>&nbsp;&nbsp;&nbsp;Loading<span>.</span><span>.</span><span>.</span>&nbsp;&nbsp;</span>
			     </a>
			</div>
		</div>
		
		<%
	 	if(Is_Reset_Password.equals(""))
	 	{
	 	%>
 		<div class="row wrapper border-bottom white-bg page-heading">
	       	<div class="col-lg-9">
                  <h2>Reset Password</h2>
                  <ol class="breadcrumb">
                     <li class="breadcrumb-item">
                          <a href="dashboard.jsp">Dashboard</a>
                      </li>
                      <li class="breadcrumb-item active">
                          <strong>Reset Password</strong>
                      </li>
                  </ol>
              </div>
        </div>
        <%
	 	}
        %>
        
    	<div class="wrapper wrapper-content animated fadeInRight">
        	<div class="row">
             	<div class="ibox float-e-margins col-lg-12" id="listDiv">
					<div class="ibox-content">	
						 
						<!-- <div class="row" style="margin-bottom:20px;">
                         	<div class="col-lg-12">
                          		<div class="col-lg-2">
                          			<label class="control-label" style="margin-top: 7px;">Existing Password&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
                          		</div>
	                          	<div class="col-lg-4">  
	                          		<input class="form-control" type="password" name="oldPassword" id="oldPassword" maxlength="15" size="30" value="">   
	                          	</div>
	                          	<div class="col-lg-6">
	                          	</div>
	                         </div>
	                     </div> -->
	                     
	                     <div class="row" style="margin-bottom:0px;">
                         	<div class="col-lg-12">
                          		<div class="col-lg-2">
                          			<label class="control-label" style="margin-top: 7px;">Password&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
                          		</div>
	                          	<div class="col-lg-4">
	                          		<input class="form-control" type="password" name="password" id="password" maxlength="15" size="30" value="">
	                          	</div>
	                          	<div class="col-lg-6">
	                          		<font style="color: red;display: inline;">Enter between 6 - 15 characters</font>
	                          		<div class="form-group" id="spanPassword" style="display: inline;">
		                                <div class="pwstrength_viewport_progress"></div>
		                            </div>
	                          	</div>
	                         </div>
	                     </div>
	                     
	                     <div class="row" style="margin-bottom:0px;">
                         	<div class="col-lg-12">
                          		<div class="col-lg-2">
                          			<label class="control-label" style="margin-top: 7px;">Confirm Password&nbsp;&nbsp;<span style="color:red;font-size:18px;font-weight:bold;">*</span></label>
                          		</div>
	                          	<div class="col-lg-4">
	                          		<input class="form-control" type="password" name="confirmPassword" id="confirmPassword" maxlength="15" size="30" value="">
	                          	</div>
	                          	<div class="col-lg-6">
	                          		<font style="color: red;display: inline;">Enter between 6 - 15 characters</font>
	                          		<div class="form-group" id="spanConfirmPassword">
		                                <div class="pwstrength_viewport_progress"></div>
		                            </div>
	                          	</div>
	                         </div>	
	                     </div>
	                     
	                     <div class="row" style="margin-top:10px;">
                         	<div class="col-lg-12">
                          		<div class="col-lg-2">
                          		</div>
	                          	<div class="col-lg-10">
	                          		<input class="btn btn-primary" type="button" id="btnReset" name="btnReset" value="Change password" data-toggle="tooltip" data-placement="bottom"  data-original-title="Click to update password">
									&nbsp;&nbsp;<input class="btn btn-white" type="button" name="btncancle" value="Cancel" onclick="javascript:funClear();" data-toggle="tooltip" data-placement="bottom"  data-original-title="Click to cancel">
	                          	</div>
	                         </div>	
	                     </div>
	                     
					</div>
		 		</div>
        	</div>
     	</div>
     	
     	<input type='hidden' name='pageaction' id='pageaction' value=""/>
     	<input type='hidden' name='source' id='source' value="<%=source%>"/>
     	
     	<input type='hidden' name='User_Id' id='User_Id' value="<%=User_Id%>"/>
     	<input type='hidden' name='Is_Reset_Password' id='Is_Reset_Password' value="<%=Is_Reset_Password%>"/>
     	
     	     	
     </div>
     <div class="scroll-top-wrapper" style="background: #19c0a0;">
		<span class="scroll-top-inner">
			<i class="fa fa-2x fa-arrow-circle-up"></i>
		</span>
	</div>
	
</div>

</form>
</body>

 	<script src="js/jquery-1.12.4.min.js"></script>
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
	var options1 = {};
	options1.ui = {
	    container: "#spanPassword",
	    showVerdictsInsideProgressBar: true,
	    viewports: {
	        progress: ".pwstrength_viewport_progress"
	    }
	};
	options1.common = {
	    debug: false
	};
	$('#password').pwstrength(options1); 
	
	var options2 = {};
	options2.ui = {
	    container: "#spanConfirmPassword",
	    showVerdictsInsideProgressBar: true,
	    viewports: {
	        progress: ".pwstrength_viewport_progress"
	    }
	};
	options2.common = {
	    debug: false
	};
	
	$('#confirmPassword').pwstrength(options2); 
	
	$('[data-toggle="tooltip"]').tooltip({container: 'body'});
	
	$('#btnReset').click(function(e)
	{
		validate(e);
	});
	
	$(document).on('keydown', '#confirmPassword', function(e)
  	{
		if(e.keyCode == 13)
		{
			validate(e);
		}
  	});
});
    
function funInit()
{
	$("#password").focus();
	$("#screenload").hide();
	
	var msg = '<%=msg%>';
	if(msg != '')
	{
		funSuccessMsg(msg, 'Profile');
	}
}

function validate(e) 
{	   
    e.preventDefault(); // cancel default behavior
  
    var password = $.trim($("#password").val()); 
    var confirmPassword = $.trim($("#confirmPassword").val()); 
    
    var newPasswordLength = $.trim($("#password").val()).length;
    var confirmPasswordLength = $.trim($("#confirmPassword").val()).length;
    
    if(password == "")   
    {    		  
    	$("#password").focus();
    	funErrorMsg("Please enter password", "Change Password");
    	return false;
    }
    else if((password != "") && newPasswordLength < 6)
 	{    
    	$("#password").focus();
    	funErrorMsg("Please enter 6 and 15 characters long", "Change Password");
      	return false;
 	}
    else if(confirmPassword == "")   
    {    		  
    	$("#confirmPassword").focus();
    	funErrorMsg("Please enter password", "Change Password");
      	return false;
    }
 	else if((confirmPassword != "") && confirmPasswordLength < 6)
 	{    
    	$("#confirmPassword").focus();
    	funErrorMsg("Please enter 6 and 15 characters long", "Change Password");
    	return false;
 	}
    else if(password != confirmPassword)
    {                
    	$("#confirmPassword").focus();
    	funErrorMsg("New/Confirm Password do not match", "Change Password");
		return false;
    }
	
    $("#password").val(confirmPassword);
    
	$("#pageaction").val("UPDATE_PASSWORD");
	$("#frmChangePassword").attr("action", "changepassword.jsp"); 
	$("#frmChangePassword").submit();      
}

function funClear()        
{
	$("#password").val("");
	$("#confirmPassword").val("");
	
	$("#password").focus();
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