<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>发货单位录入</title>
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
			if(!checkAmount($('money')) || !checkAmount($('restriction'))){
				return false;
			}
			return true;
		}
		//数字小数点
		function clearNoNum(obj){  
			 obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
			 obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
		     obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
			 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		}
		//金额 校验
		function checkAmount(target){
			var amount = target.val();
			if(!checkBigDecimal14(amount)){
				showErrorMsg(target,"请输入正确的金额");
				return false;
			}
			hiddenErrorMsg(target);
			return true;
		}
		// 金额BigDecimal(14,2)检查
		function checkBigDecimal14(amount) {
			if (amount == "" || amount == "0" || amount == "0.0" || amount == "0.00" || amount.trim().length == 0) {
				return false;
			} 
			var reg = /^([1-9][\d]{0,11}|0)(\.[\d]{1,2})?$/;
			var re = new RegExp(reg);
			if (!re.test(amount)) {
				return false;
			}
			return true;
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
		<li><a href="${ctx}/shipper/list">发货单位列表</a></li>
		<li class="active"><a href="${ctx}/shipper/form?id=${tabShipper.id}">发货单位${not empty tabShipper.id?'修改':'录入'}</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="tabShipper" action="${ctx}/shipper/save?action=${action }" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">发货单位：</label>
			<div class="controls">
				<form:input id="receivingname"  path="name" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预付金额：</label>
			<div class="controls">
				<form:input path="money" 
				 onkeyup="clearNoNum(this)"
				 htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				元
				<label for="receivingnameInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">超额提醒：</label>
			<div class="controls">
				<form:input  
				onkeyup="clearNoNum(this)"
				path="restriction" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font></span>
				元
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