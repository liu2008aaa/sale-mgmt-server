<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发货</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/DateDiff.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');						
					form.submit();	
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
		});
		//表单验证
		function validateForm(){
			var target = $("#shipperid");
			var shipperid = target.val();
			if(shipperid == -1){
				showErrorMsg(target,"请选择发货单位");
				return false;
			}else{
				hiddenErrorMsg(target);
			}
			target = $("#vecturatype");
			var vecturatype = target.val();
			if(vecturatype == -1){
				showErrorMsg(target,"请选择货运类型");
				return false;
			}else{
				hiddenErrorMsg(target);
			}
			var snw = $("#snw").val();
			if(!snw || snw <= 0){
				showErrorMsg($("#snw"),"计算的净重金额有误");
				return false;
			}else{
				hiddenErrorMsg($("#snw"));
			}
			return true;
		}
		//计算净重
		function calculateSnw(){
			var sgw = $("#sgw").val();//   发货 毛重
			var stw= $("#stw").val();//   发货 皮重
			//发货 净重
			$("#snw").val((sgw - stw).toFixed(3));
		}
		//数字小数点
		function clearNoNum(obj){  
			 obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
			 obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
		     obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
			 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		}
		//显示错误 消息
		function showErrorMsg(target, msg) {		
			target.parent().find(".error").html(msg);
			target.parent().find(".error").show();
		}
		//隐藏错误 消息
		function hiddenErrorMsg(target) {		
			target.parent().find(".error").hide();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/order/list">发货列表</a></li>
		<li class="active"><a href="${ctx}/order/form?id=${tabOrderform.id}">发货${not empty tabOrderform.id?'修改':'录入'}</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="tabOrderform" action="${ctx}/order/save?action=${action }" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">发货单位：</label>
			<div class="controls">
				<form:select  path="shipperid" class="input-medium">
		    		<form:option value = "-1">请选择</form:option>
					<form:options items="${ln:getAllTabShippers()}" itemValue="id" itemLabel="name" htmlEscape="false"  class="input-medium"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货单位：</label>
			<div class="controls">
				<form:input id="receivingname"  path="receivingname" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货运类型：</label>
			<div class="controls">
				<form:select path="vecturatype" class="input-medium" style="width:100px">
		    		<form:option value = "-1">请选择</form:option>
					<form:option class="input-medium" value = "1">长途</form:option>
					<form:option class="input-medium" value = "2">短途</form:option>
				</form:select>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆所属公司：</label>
			<div class="controls">
				<form:input  path="carhome" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车牌号：</label>
			<div class="controls">
				<form:input  path="platenumber" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">煤型：</label>
			<div class="controls">
				<form:input  path="coaltype" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">毛重：</label>
			<div class="controls">
				<form:input id="sgw"  path="sgw"  
				 onblur="calculateSnw()" 
				 onkeyup="clearNoNum(this)"
				 htmlEscape="false"  maxlength="100" class="input-xlarge required"/>
				 吨
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">皮重：</label>
			<div class="controls">
				<form:input id="stw" path="stw" 
				onblur="calculateSnw()" 
				onkeyup="clearNoNum(this)"
				htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				吨
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">净重：</label>
			<div class="controls">
				<form:input id="snw" readonly="true" path="snw" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				吨
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="return validateForm();"/>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
<!-- 表单 验证 -->
<script type="text/javascript">
</script>
</body>
</html>