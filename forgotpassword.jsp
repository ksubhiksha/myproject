<%@ page language="java" import="java.io.*,java.util.*,com.saapps.login.Login"%>
<jsp:useBean id="Login" class="com.saapps.login.Login" scope="request"/>
<jsp:setProperty name="Login" property="*"/> 

<%
String mode=(String)request.getParameter("hidMode");
if(mode==null)mode="";

String email = (String)request.getParameter("email");
if(email == null)email="";

String msg = "";

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SA APPS</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen   animated fadeInDown">
        <div  style="margin-top: 20%;">
        	
        	<div style="margin-bottom: 25px;height: 50px;">
            </div>
            
            <h3>Forgot Password</h3>
            
            <form id="frmForgotPassword" class="m-t" role="form">
                
                <div class="form-group">
                    <div style="height: 22px;"><span class="text-danger pull-right" id="spanEmail" style="margin-right: 5px;font-size: 15px;color: red;display: none;" ><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;Enter Valid Email</span></div>
                    <input type="text" id="email" name="email" class="form-control" placeholder="Email">
                </div>
                
                <a class="btn btn-primary full-width m-b" id="btnRecover" style="color: #fff;">Recover Password</a>

                <p class="text-muted text-center"><small>Already have an account?</small></p>
                <a class="btn btn-sm btn-white btn-block" href="#" onclick="javascript:funLogin();">Login</a>
                
                <input type='hidden' name='hidMode' id='hidMode' value=""/>
            </form>
        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="js/jquery-1.12.4.min.js"></script>
 	<script src="js/popper.min.js"></script>
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
    
    <script>
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
	  	
	  	
	   	$('#email').keyup(function(event){
		  	if($.trim($("#email").val()) != "")
		    {    
	    		var email = $.trim($('#email').val());
	    	    if(isValidEmailAddress(email))
	    	    {
	    	    	$("#email").css("border", "1px solid #1ab394");
	    	    	$("#spanEmail").css("display", "none");
	    	    }else{
	       		  	$("#email").focus();
	       		 	$("#email").css("border", "1px solid #ed5565");
	       		  	$("#spanEmail").css("display", "");
	              	return false;
	    	    }    	
			}
		});
	 	       		  	
	   	    	
		$(document).on('blur', '#email', function(e)
	  	{
			var email = $.trim($('#email').val());
	    	if(isValidEmailAddress(email))
	    	{
	    		$("#email").css("border", "1px solid #1ab394");
		    	$("#spanEmail").css("display", "none");
		    }else if(email != "")
		    {
	   		  	$("#email").focus();
	   		 	$("#email").css("border", "1px solid #ed5565");
	   		  	$("#spanEmail").css("display", "");
	          	return false;
		    } 
	 	});
	  	       		  	
	  	$(document).on('keydown', '#email', function(e)
	  	{
			if(e.keyCode == 13)
			{
		      	validate(e);
			}
	  	});
	  	
	  	$('#btnRecover').click(function(event)
		{
			validate(event);
	    });
	
	});
	
	function validate(e) 
	{	   
	    e.preventDefault(); // cancel default behavior
	    
	    if($.trim($("#email").val()) == "")
	    {    		  
	        $("#email").focus();
	        $("#email").css("border", "1px solid #ed5565");
	        $("#spanEmail").css("display", "");
	        return false;
	    }  
		else if($.trim($("#email").val()) != "")
	    {	             
	        var email = $.trim($('#email').val());
	   	   	if(!isValidEmailAddress(email))
	   	   	{
	   		   $("#email").focus();
	   		   $("#email").css("border", "1px solid #ed5565");
	   		   $("#spanEmail").css("display", "");
	           return false;
	   	   	}
	     } 
	    
		 $("#hidMode").val("RECOVER");
		 $("#frmForgotPassword").attr("action","forgotpassword.jsp");
		 $("#frmForgotPassword").submit();      
	}
	
	function isValidEmailAddress(emailAddress) 
	{
	    var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
	    return pattern.test(emailAddress);
	};
	
	function funInit()
	{
		 $("#email").focus();
	  	 var msg = '<%=msg%>';
	  	  	
	  	 if($.trim(msg) != "")
	  	 { 
	  		$("#msg").text(msg);
	  		$("#alertMessage").show();
	  		
	  		setTimeout(function() { 
	  			$("#alertMessage").hide();
	  	 	}, 5000); 
	  	 }
	}
	
	function funLogin()
	{
		 $("#frmForgotPassword").attr("action","login.jsp");
		 $("#frmForgotPassword").submit();  
	}
	
	</script>
</body>

</html>
