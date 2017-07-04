<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>登录</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">  
    <link href="css/bootstrap.min.css" rel="stylesheet" media="screen">	
    <link href="css/jy_style.css" rel="stylesheet" media="screen">
    <script type="text/javascript" src="js/jquery.min.js" ></script>
    <script src="${url }js/plugins/layer/layer.js"></script>
</head>
<script language="javascript" type="text/javascript">
        var code;
        function createCode() {
            code = "";
            var codeLength = 4; //验证码的长度
            var checkCode = document.getElementById("checkCode");
            var codeChars = new Array('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
            for (var i = 0; i < codeLength; i++) 
            {
                var charNum = Math.floor(Math.random() * 52);
                code += codeChars[charNum];
            }
            if (checkCode) 
            {
                checkCode.className = "code";
                checkCode.innerHTML = code;
            }
        }
        
        function keyLogin(){
          if (event.keyCode==13){   //回车键的键值为13
            document.getElementById("login").click(); 
        }
        }//调用登录按钮的登录事件
        function login(){
        	var username=$("#inputEmail").val();
        	if(username==null || username==''){
        		layer.alert("请输入用户名!");
        		return false;
        	}
        	var password=$("#inputPassword").val();
        	if(password==null || password==''){
        		layer.alert("请输入密码!");
        		return false;
        	}
        	 var code=$("#checkCode").text();
        	 var inputCode = $("#inputCode").val();
             if (inputCode==null || inputCode=="") 
             {
                 layer.alert("请输入验证码！");
                 return false;
             }
             else if (inputCode.toUpperCase() != code.toUpperCase()) 
             {
                 layer.alert("验证码输入有误！");
                 return false;
             }
        	$.ajax({
                url : 'checkLogin',
                type:'post',
                data:{username:username,password:password},
                success:function(result)
                {
                  if(result.message==1){
                	  window.location.href="admin/index?username="+result.username;
                  }else{
                	  layer.alert("用户名或密码错误!");
                	  window.location.href="login";
                  }
                }
            });
        }
     </script>

</head>
<body class="jy_login" onload="createCode();" onkeydown="keyLogin();">
	<div class="login-from">
		<div class="login-top"></div>
		<div class="control-group">
		    <div class="controls">
		   		<b></b>
			    <input type="text" id="inputEmail" name="username" placeholder="用户名">
		    </div>
		</div>
	   <div class="control-group">
		    <div class="controls">
		    	<b></b>
		        <input type="password" id="inputPassword" name="password" placeholder="密码">
		    </div>
		</div>
		<!-- 验证码 -->
		<div class="control-group" style="margin-top:15px;">
		    <div class="controls">
		        <input type="text" class="verification" placeholder="输入验证码" id="inputCode">	
		        <span class="verification-cue"><span id="checkCode" onclick="createCode()">DHCH</span></span>
		        <a href="#" onclick="createCode()">看不清</a>
		    </div>
		</div>
		 <div class="control-group">
		    <div class="controls">
		      <label class="checkbox">
		        <input type="checkbox">下次自动登陆
		      </label>
		    </div>
		  </div>
		 <div class="control-group">
		    <div class="controls">
		       <div class="btn btn-block " id="login" onclick="login()">登录</div>
		    </div>
		  </div>
		  <img src="images/bg-font.png">
	</div>
</body>
</html>