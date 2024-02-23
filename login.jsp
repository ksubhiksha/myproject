<%@ page language="java" import="java.io.*,java.util.*,com.saapps.login.Login"%>
<jsp:useBean id="Login" class="com.saapps.login.Login" scope="request"/>
<jsp:setProperty name="Login" property="*"/> 

<%
String mode=(String)request.getParameter("hidMode");
if(mode==null)mode="";

String email = (String)request.getParameter("email");
if(email == null)email="";
String password =(String)request.getParameter("password");       
if(password==null)password="";
ArrayList<Login> listLoginDetails = new ArrayList<Login>();
String resultMsg = "";
String msg = "";
int currentYear = 0;
int user_id=0;	
String empId="";
String firstName="";
String lastName="";
String emailId="";
String referenceNo="";
int userTypeId=0;
String userType="";
String empPhoto="";

try{
	if(!mode.trim().equals("") && mode.trim().equals("LOGIN"))
	{
		resultMsg = Login.validateUser();
		
		//if(resultMsg.trim().equals("SUCCESS"))
		//{
			
			listLoginDetails = Login.getUserDetails();
			
			if(listLoginDetails.size() > 0)
			{
				for(int i=0;i<listLoginDetails.size();i++)
			    {
					Login = (Login)listLoginDetails.get(i);
					
					user_id = (Integer)Login.getUser_id();
					empId = (String)Login.getEmpId();
					firstName = (String)Login.getFirstName();
					lastName = (String)Login.getLastName();
					emailId = (String)Login.getEmail();
					referenceNo = (String)Login.getReferenceNo();
					userTypeId = (Integer)Login.getUserTypeId();
					userType = (String)Login.getUserType();
					empPhoto = (String)Login.getEmpPhoto();
					
			    }
				
				if(listLoginDetails.size() > 0)
				{
					session.setMaxInactiveInterval(8*60*60);
					
					user_id = (Integer)Login.getUser_id();
					empId = (String)Login.getEmpId();
					firstName = (String)Login.getFirstName();
					lastName = (String)Login.getLastName();
					emailId = (String)Login.getEmail();
					referenceNo = (String)Login.getReferenceNo();
					userTypeId = (Integer)Login.getUserTypeId();
					userType = (String)Login.getUserType();
					empPhoto = (String)Login.getEmpPhoto();
					
					session.setAttribute("sesSaUser_User_Id", user_id);
					session.setAttribute("sesSaUser_EmpId", empId);
					session.setAttribute("sesSaUser_FirstName", firstName);
					session.setAttribute("sesSaUser_LastName", lastName);
					session.setAttribute("sesSaUser_EmailId", emailId);
					session.setAttribute("sesSaUser_ReferenceNo", referenceNo);
					session.setAttribute("sesSaUser_UserTypeId", userTypeId); 
					session.setAttribute("sesSaUser_UserType", userType);
					session.setAttribute("sesSaUser_EmpPhoto", empPhoto);

				}
				
		    }
			
			response.sendRedirect("dashboard.jsp");
		//}
		/* else if(resultMsg.trim().equals("INCORRECT"))
		{
			msg = "Incorrect Password";
		}
		else if(resultMsg.trim().equals("INVALID"))
		{
			msg = "Invalid User Id";
		} */
	}
	currentYear = Calendar.getInstance().get(Calendar.YEAR);
	
}catch(Exception e){
	
	System.out.println("Exception while validating the login:: "+e.getMessage());
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
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<body class="gray-bg" onload="funInit();">
    <div class="middle-box text-center loginscreen animated fadeInDown">
        <div style="margin-top: 20%;">
            <div style="margin-bottom: 25px;height: 50px;">
                <img src="images/sachinalogo.png" alt="sachina_logo" style="width: 300px;display: none;" >
            </div>
            
           <!--  <h3>Welcome to Sachina</h3>
            <div>In our experience, there is no 'one-size-fits-all' approach. We help our clients...</div> -->
            
            <form name="frmLoginForm"  id="frmLoginForm"  method="post" autocomplete="off" role="form">
                <div class="form-group" style="margin-bottom: 0px;">
                    <div style="height: 22px;"><span class="text-danger pull-right" id="spanEmpId" style="margin-right: 5px;font-size: 15px;color: red;display: none;" ><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;Enter Emp Id</span></div>
                    <input type="text" id="empId" name="empId" class="form-control" placeholder="Emp Id">  
                </div>
                <div class="form-group">
                	<div style="height: 22px;"><span class="text-danger pull-right" id="spanPassword" style="margin-right: 5px;font-size: 15px;color: red;display: none;" ><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;Enter Password</span></div>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Password">
                </div>
                
                <a id="btnLogin" name="btnLogin" class="btn btn-primary full-width m-b" style="color: #fff;">Login</a>
                <a href="forgotpassword.jsp"><small>Forgot password?</small></a>
                
                <div class="alertMsg">
			  		<div class="alert alert-danger" id="alertMessage" align="center" style="margin-top: 15px;line-height: 5px;border-radius: 0.2rem;display: none;">
						<i class="fa fa-exclamation-triangle" style=""></i>
					    &nbsp;<span id="msg" style="font-size: 14.5px;">Incorrect Email / Password</span>
				  	</div>
				 </div>
                
                <input type='hidden' name='hidMode' id='hidMode' value=""/>
                
            </form>
            
            <div class="m-t"> <small>© <%=currentYear%> Sachina. All Rights Reserved. </small> </div>
        </div>
    </div>
    
    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    <script type="text/javascript">
	$(document).ready(function() {
		
		$(document).keydown(function(e)
	  	{    		
	   		if(e.keyCode === 8) { ///This prevent back page  
		        var element = e.target.nodeName.toLowerCase();
		        if((element != 'input' && element != 'textarea') || $(e.target).attr("readonly")) {
		            return false;
		        }
	  	    }
	    });
	  	
	  	$('#btnLogin').click(function(e)
	  	{
	  		validate(e);
	    });
	  	
	   	$('#empId').keyup(function(e)
	   	{
		  	if($.trim($("#empId").val()) != "")
		    {    
		  		$("#empId").css("border", "1px solid #1ab394");
	  			$("#spanEmpId").css("display", "none");
			}
		});
	 	       		  	
	  	$('#password').keyup(function(e)
	  	{
	  		if($.trim($("#password").val()) != "")
	      	{    
	  			$("#password").css("border", "1px solid #1ab394");
	  			$("#spanPassword").css("display", "none");
	      	}
	  	});
	  	       		  	
	  	$(document).on('keydown', '#empId', function(e)
	  	{
			if(e.keyCode == 13)
			{
		      	validate(e);
			}
	  	});
	 
	  	$(document).on('keydown', '#password', function(e)
	  	{
			if(e.keyCode == 13) 
			{
			      validate(e);
			}
	  	});
	  	
	});
	
	function validate(e) 
	{	   
	    e.preventDefault(); // cancel default behavior
	    
	    if($.trim($("#empId").val()) == "")
	    {    		  
	        $("#empId").focus();
	        $("#empId").css("border", "1px solid #ed5565");
	        $("#spanEmpId").css("display", "");
	        return false;
	    }  
		else if($.trim($("#password").val()) == "")
	    {    		  
	        $("#password").focus();
	        $("#password").css("border", "1px solid #ed5565");
	        $("#spanPassword").css("display", "");
	        return false;
	    }   
	    
		 $("#hidMode").val("LOGIN");
		 $("#frmLoginForm").attr("action","login.jsp");
		 $("#frmLoginForm").submit();      
	}
	
	function funInit()
	{
		$("#empId").focus();
	  	 var msg = '<%=msg%>';
	  	  	
	  	 if($.trim(msg) != "")
	  	 { 
	  		$("#msg").text(msg);
	  		$("#alertMessage").show();
	  		
	  		setTimeout(function() 
	  		{ 
	  			//$("#alertMessage").hide();
	  	 	}, 5000); 
	  	 }
	}
	
	</script>
   
</body>
</html>