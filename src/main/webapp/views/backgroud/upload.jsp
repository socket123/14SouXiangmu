<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%@ include file="../base.jsp" %>
<body>
<div>
	<div class="" style="padding: 10px;">
		<div style="padding: 10px 10px 10px 10px">
			<form id="dataForm" method="post">
				<!-- 隐藏表单域存放位置 -->
				<table cellpadding="3">
					<tr>
						<td>上传文件:</td>
						<td><input type="file" name="uploadFile" id="uploadFile" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><a href="javascript:void(0)"
							class="easyui-linkbutton" style="width: 100px; height: 30px;"
							id="subDataForm">上传</a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	//ajax异步上传附件
	$("#subDataForm").click(
			function() {
				//判断是否有选择上传文件  
				var uploadFile = $("#uploadFile").val();
				if (uploadFile == "") {
					alert("提示", "请上传excel！");
					return;
				}
				//判断上传文件的后缀名  
				var strExtension = (uploadFile
						.substr(uploadFile.lastIndexOf('.') + 1)).toLowerCase();
				if (strExtension != 'xls' && strExtension != 'xlsx') {
					alert("提示", "上传的文件格式不对");
					return;
				}
				var data = new FormData();
				$.each($('#uploadFile')[0].files, function(i, file) {
					data.append('file', file);
				});

				$.ajax({
					url : "${url}admin/user/importUser",
					type : 'POST',
					data : data,
					cache : false,
					contentType : false, //不可缺
					processData : false, //不可缺
					success : function(data) {
						if (1 == data.message) {
							alert("添加成功!");
							window.location.href="${url}admin/user";
						} else  if(0==data.message){
							alert("添加失败!");
							window.location.href="${url}admin/user";
						}
					}
				});
			});
</script>
</html>