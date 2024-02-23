<%@ page import ="java.util.*,javax.servlet.*,java.text.SimpleDateFormat,java.text.DecimalFormat,java.text.*,javax.mail.*, javax.mail.internet.*,javax.servlet.http.*"%>
<%@ page language="java" import="java.io.*,java.util.*,com.saapps.login.Login"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.text.*,com.saapps.db.ReadProperties" session="true"%>
<jsp:useBean id="Login" class="com.saapps.login.Login" scope="request"/>
<jsp:setProperty name="Login" property="*"/>

<%

String msg = "";
%>

<!DOCTYPE html>
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
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet">
	<link href="css/login.css" rel="stylesheet">
	
	<script src="js/jquery-1.12.4.min.js"></script>

<style type="text/css">
.panel-heading a{
    /* background: -webkit-repeating-linear-gradient(-45deg, 
    rgb(18, 83, 93) , 
    rgb(18, 83, 93) 20px, 
    rgb(64, 111, 118) 20px, 
    rgb(64, 111, 118) 40px, 
    rgb(18, 83, 93) 40px);
    -webkit-text-fill-color: transparent;
    -webkit-background-clip: text; */
    background: -webkit-repeating-linear-gradient(-45deg, 
    rgb(8, 77, 88) , 
    rgb(22, 141, 158) 20px, 
    rgb(67, 128, 136) 20px, 
    rgb(24, 132, 148) 40px, 
    rgb(16, 25, 27) 40px);
    -webkit-background-clip: text;
}
</style>	
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
</head>
<body onload="funInit();">
	<div id="fullscreen_bg" class="fullscreen_bg">
		<div id="regContainer" class="container">
		      <div class="row">
		      <div class="col-md-6 col-md-offset-3">
		        <div class="panel panel-login">
		        
		        
		        			<%
			                if(msg.equals("Email Send"))
			                {
			                %>
			                	<div class="panel-heading">
			                		<div class="row">
					               	 <a href="#" class="active" id="login-form-link" style="font-size: 26px;cursor: default;">Password Recovery</a>
					            	</div>
				                </div>
				                
				                <div class="panel-body">
					            <div class="row">
					            	<div class="col-lg-12" align="center">
						              	<h3><i class="glyphicon glyphicon-ok-sign" style="color:green;"></i>&nbsp;&nbsp;An email has been sent.</h3><br>
						              	<p>Follow the link in your mail to reset the password.<br/>Click&nbsp;<a href="login.jsp">here</a> to login</p>
						             </div>
					            </div>
					          </div>
			                <%
			                }else{
			                %>
		        
					          <div class="panel-heading">
					            <div class="row">
					                <a href="#" class="active" id="login-form-link" style="font-size: 26px;cursor: default;">Forgot Password</a>
					            </div>
					            <hr>
					          </div>
					          <div class="panel-body">
					            <div class="row">
					              <div class="col-lg-12">
					                <form id="frmForgotPassword" action="#" method="post" role="form" style="display: block;" >
					                  <div class="form-group">
					                    <div><label for="username">Email</label><span class="text-danger pull-right" id="spanEmail" style="margin-right: 5px;font-size: 15px;color: red;display: none;" ><i class="fa fa-exclamation-circle" aria-hidden="true"></i>&nbsp;Enter Valid Email</span></div>
					                    <input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="Email Id" value="">
					                  </div>
					                  
					                  <div class="form-group" style="margin-top: 30px;" align="center">
					                    <div class="row">
					                      <div class="col-sm-6 col-sm-offset-3">
					                        <input type="button" name="btnRecover" id="btnRecover" tabindex="4" class="form-control btn btn-login" value="Recover Password" title="Click to Recover Password" style="text-transform: capitalize;max-width: 150px;">
					                      </div>
					                    </div>
					                  </div>
					                  
					                  <div class="form-group text-center" style="margin-bottom: 0px;">
					                   		<a href="#" class="btn btn-link btn-primary btn-lg" style="text-decoration: none;color: #2b879c;font-size: 16px;" onclick="javascript:funLogin();" >Login</a>
					                  </div>
					                  
					                  <div class="alertMsg">
									  	  <div class="alert alert-danger" id="alertMessage" align="center" style="line-height: 5px;height: 45px;border-radius: 0.2rem;display: none;">
											     <i class="fa fa-exclamation-triangle" style=""></i>
											     &nbsp;<span id="msg" style="font-size: 14.5px;"></span>
										  </div>
									 </div>
									 
									 <input type='hidden' name='hidMode' id='hidMode' value=""/>
			  	
					                </form>
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
	
	
</body>
</html>