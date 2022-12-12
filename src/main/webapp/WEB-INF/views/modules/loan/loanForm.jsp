<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品录入</title>
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
			//产品标题 验证
		    $("#productNameInput").blur(function() {
		    	checkLoanTitle($("#productNameInput"));
		    });
			//总金额 验证
		    $("#totalMoneyInput").blur(function() {
		    	checkLoanAmount($("#totalMoneyInput"));
		    });
			//预期年化收益率 验证
		    $("#interestRateInput").blur(function() {
		    	checkAnnualinterestrate($("#interestRateInput"));
		    });
			//起息日 验证
			$("#interestStartTimeInput").blur(function() {
				if(checkBorrowbearingStartDate($("#interestStartTimeInput"))){
					//计算 投资期限
					calculateTermcount();
				}
		    });
			//到期日 验证
			$("#interestEndTimeInput").blur(function() {
		    	if(checkBorrowbearingEndDate($("#interestEndTimeInput"))){
					//计算 投资期限
					calculateTermcount();
				}
		    });
			//每份金额  验证			
			$("#eachUnitPriceInput").blur(function() {
				checkAmount($("#eachUnitPriceInput"));
		    });
			//最小投资份数  验证			
			$("#minimumUnitsInput").blur(function() {				
				checkInvestUnit($("#minimumUnitsInput"));
		    });
			//最大投资份数 验证			
			$("#maximumUnitsInput").blur(function() {	
				checkInvestUnit($("#maximumUnitsInput"));
		    });
			//募集开始时间 验证
			$("#collectionStartTimeInput").blur(function() {
				checkOpenTime($("#collectionStartTimeInput"));
		    });
			//募集结束时间 验证
			$("#collectionStopTimeInput").blur(function() {
		    	checkOpenEndTime($("#collectionStopTimeInput"));				
		    });
			
			
			if('${enable}' == 'false'){				
				document.getElementById('interestStartTimeInput').disabled='disabled';
				document.getElementById('interestEndTimeInput').disabled='disabled';
				document.getElementById('collectionStartTimeInput').disabled='disabled';
				document.getElementById('collectionStopTimeInput').disabled='disabled';		
			}
		});
		//表单验证
		function validateForm(){
			//产品 标题
			if(!checkLoanTitle($("#productNameInput"))){
				return false;
		    }
			//总金额 验证
		    if(!checkLoanAmount($("#totalMoneyInput"))){
				return false;
		    }
			
			//预期年化收益率 验证
		    if(!checkAnnualinterestrate($("#interestRateInput"))){
				return false;
			}
			
			//起息日 验证
			if(!checkBorrowbearingStartDate($("#interestStartTimeInput"))){
				return false;
			}
			
			//到期日 验证
			if(!checkBorrowbearingEndDate($("#interestEndTimeInput"))){
				return false;
			}
			//每份金额 验证			
			if(!checkAmount($("#eachUnitPriceInput"))){
				
				return false;
			}
			//每份金额能否被总额整除验证
			var amountForEachShareInput=$("#eachUnitPriceInput").val();
			var amountInput=$("#totalMoneyInput").val();
			if((amountInput%amountForEachShareInput)!=0){
				showErrorMsg($("#eachUnitPriceInput"),"总金额不能被每份金额整除 请重新输入！");
				return false;
			}
			//最小投资份数 验证			
			if(!checkInvestUnit($("#minimumUnitsInput"))){
				return false;
			}
			
			//最大投资份数 验证			
			if(!checkInvestUnit($("#maximumUnitsInput"))){
				return false;
			}
			
			//募集开始时间 验证
			if(!checkOpenTime($("#collectionStartTimeInput"))){
				return false;
			}
			
			//募集结束时间 验证
			if(!checkOpenEndTime($("#collectionStopTimeInput"))){
				return false;
			}
				
			return true;
		}
		// 审核
		function doAudit() {
			if ($("#auditStatus1").attr('checked') == 'checked') {
				$("#auditStatus").val('1');
			} else if ($("#auditStatus2").attr('checked') == 'checked') {
				$("#auditStatus").val('0');
			}
			document.getElementById('inputForm').action = "${ctx}/loan/loan/audit?action=${action }";
			$("#inputForm").submit();
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/loan/loan/">产品列表</a></li>
		<li class="active"><a href="${ctx}/loan/loan/form?id=${experienceFinancialProduct.productId}">产品<shiro:hasPermission name="loan:loan:edit">${not empty corporationMain.id?'修改':'录入'}</shiro:hasPermission><shiro:lacksPermission name="loan:loan:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="experienceFinancialProduct" action="${ctx}/loan/loan/save?action=${action }" method="post" class="form-horizontal">
		<form:hidden path="productId"/>
		<form:hidden path="version"/>
		<form:hidden path="productType"/>
		<form:hidden path="productStatus"/>
		<form:hidden path="boughtMoney"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">产品名称：</label>
			<div class="controls">
			
				<c:choose>
				    <c:when test="${edit}">
						<form:input id="productNameInput" readonly="true" path="productName" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				    </c:when>
				   <c:otherwise>  
						<form:input id="productNameInput" readonly="${!enable }" path="productName" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				   </c:otherwise>
     		 </c:choose>
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="loanTitleInput" class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">产品总额：</label>
			<div class="controls">
				<form:input id="totalMoneyInput" readonly="${!enable }" path="totalMoney" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				元
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="totalMoneyInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预期年化收益率：</label>
			<div class="controls">
				<form:input id="interestRateInput" readonly="${!enable }" path="interestRate" htmlEscape="false" maxlength="6" class="input-xlarge required"/>
				%
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="interestRateInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起息日：</label>
			<div class="controls">
			<input id="interestStartTimeInput" name="interestStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${experienceFinancialProduct.interestStartTime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<label  for="interestStartTimeInput" class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">到期日：</label>
			<div class="controls">
			<input id="interestEndTimeInput" readonly="${!enable }" name="interestEndTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${experienceFinancialProduct.interestEndTime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="interestEndTimeInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">产品期限：</label>
			<div class="controls">
				<form:input id="productDaysInput" readonly="true" path="productDays" htmlEscape="false" maxlength="10" class="input-xlarge required "/>
				天
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">每份金额：</label>
			<div class="controls">
				<form:input id="eachUnitPriceInput" readonly="${!enable }" path="eachUnitPrice" htmlEscape="false" maxlength="10" class="input-xlarge required"/>
				元
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="eachUnitPriceInput" class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起购份数：</label>
			<div class="controls">
				<form:input id="minimumUnitsInput" readonly="${!enable }" path="minimumUnits" htmlEscape="false" maxlength="10" class="input-xlarge  required"/>
				份
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="minimumUnitsInput" class="error"></label>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">限购份数：</label>
			<div class="controls">
				<form:input id="maximumUnitsInput" readonly="${!enable }" path="maximumUnits" htmlEscape="false" maxlength="10" class="input-xlarge "/>
				份
				<span class="help-inline"><font color="red">*</font> </span>
				0表示不限购			
				<label for="maximumUnitsInput"  class="error"></label>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">募集开始时间：</label>
			<div class="controls">
				<input id="collectionStartTimeInput" readonly="${!enable }" name="collectionStartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${experienceFinancialProduct.collectionStartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="collectionStartTimeInput"  class="error"></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">募集结束时间：</label>
			<div class="controls">
				<input id="collectionStopTimeInput" readonly="${!enable }" name="collectionStopTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${experienceFinancialProduct.collectionStopTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="collectionStopTimeInput"  class="error"></label>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">计息基准：</label>
			<div class="controls">
				 <form:select id="interestTypeSelect" path="interestType" disabled="${!enable }" class="input-medium">
					<form:option value = "0">ACT/360</form:option>
					<form:option value = "1">ACT/365</form:option>
				</form:select>
				
				
				<span class="help-inline"><font color="red">*</font> </span>
				<label for="interestTypeSelect"  class="error"></label>
			</div>
		</div>

		<c:if test="${action=='audit' }">
			<div class="control-group">
				<label class="control-label">审核结果：</label>
				<div class="controls">
					<input id="auditStatus1" type="radio" name="auditStatusHidden" checked="checked" />通过
					<input id="auditStatus2" type="radio" name="auditStatusHidden"/>不通过
					<input id="auditStatus" name="auditStatus" type="hidden" />
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<shiro:hasPermission name="loan:loan:edit">
				<c:if test="${enable }">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="return validateForm();"/>
				</c:if>
				<c:if test="${action=='audit' }">
					<input id="btnSubmit" class="btn btn-primary" type="button" value="提 交" onclick="return confirmx('确认要提交审核吗？', 'javascript:doAudit()');"/>
				</c:if>
				&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	
	
	
	
	

<!-- 表单 验证 -->
<script type="text/javascript">
	
	//产品标题 校验
	function checkLoanTitle(target){
		if(target.val() == null || target.val() == ''){
			showErrorMsg(target,"产品标题不能为空");
			return false;
		}				
		hiddenErrorMsg(target);
		return true;
	}
			
	//产品总额 校验
	function checkLoanAmount(target){
		var amount = target.val();
		if(!checkAmount(target)){
			return false;
		}else if((amount*100)%10000 != 0){
			showErrorMsg(target,"必须是100的整数倍");
			return false;
		}		
		hiddenErrorMsg(target);
		return true;
	}
	//预期年化收益率 校验
	function checkAnnualinterestrate(target){
		var amount = target.val();
		if(!checkBigDecimal6(amount)){
			showErrorMsg(target,"请输入正确的预期年化收益率");		
			return false;
		}		
		hiddenErrorMsg(target);
		return true;
	}
	//起息日 校验	
	function checkBorrowbearingStartDate(target){		
		//起息日
		var borrowbearingstartdate = target.val();
		//到期日
		var borrowbearingenddate = $("#interestEndTimeInput").val();
		//判断
		if(borrowbearingenddate){
			if(borrowbearingstartdate == borrowbearingenddate){
				showErrorMsg(target,"起息日不能与到期日相同");	
				return false;
			}
			if(isMaxDate(borrowbearingstartdate,borrowbearingenddate)){
				showErrorMsg(target,"起息日不能大于到期日");		
				return false;
			}
		}else if(borrowbearingstartdate == ""){
			showErrorMsg(target,"请输入起息日");		
			return false;
		}else if(borrowbearingenddate == ""){
			showErrorMsg($("#interestEndTimeInput"),"请输入到期日");		
			return false;
		}
		/**募集结束日与起息日校验*/
		//募集结束日
		var onpenEndTime = $("#collectionStopTimeInput").val();
		if(borrowbearingstartdate  && onpenEndTime ){
			if(!isMaxDate(borrowbearingstartdate,onpenEndTime)){
				showErrorMsg(target,"起息开始日不能小于等于募集结束日 ");
				return false;
			}
		}
		hiddenErrorMsg(target);
		//hiddenErrorMsg($("#borrowbearingenddateInput"));
		return true;
	}
	//到期日 校验	
	function checkBorrowbearingEndDate(target){		
		//起息日
		var borrowbearingstartdate = $("#interestStartTimeInput").val();
		//到期日
		var borrowbearingenddate = target.val();
		//判断
		if(borrowbearingstartdate){
			if(borrowbearingstartdate == borrowbearingenddate){
				showErrorMsg(target,"到期日不能与起息日相同");	
				return false;
			}
			if(isMaxDate(borrowbearingstartdate,borrowbearingenddate)){
				showErrorMsg(target,"到期日不能小于起息日");	
				return false;				
			}
		}
		hiddenErrorMsg(target);
		//hiddenErrorMsg($("#borrowbearingstartdateInput"));
		return true;
	}
	//计算 投资期限
	function calculateTermcount(){
		//起息日
		var borrowbearingstartdate = $("#interestStartTimeInput").val();
		//到期日
		var borrowbearingenddate = $("#interestEndTimeInput").val();
		if(borrowbearingstartdate && borrowbearingenddate){
			var termcount = GetDateDiff(borrowbearingstartdate,borrowbearingenddate,"day");
			$("#productDaysInput").val(termcount);
		}
	}	
	
	// 份数 校验
	function checkInvestUnit(target){
		var amount = target.val();
		if(!isNumber(amount)){
			showErrorMsg(target,"请输入正确的份数");
			return false;
		}
		hiddenErrorMsg(target);
		return true;
	}
	//募集开始时间 校验	
	function checkOpenTime(target){		
		//开始时间
		var onpenTime = target.val();
		//结束时间
		var onpenEndTime = $("#collectionStopTimeInput").val();
		//判断
		if(onpenEndTime){
			if(isMaxDate(onpenTime,onpenEndTime)){
				showErrorMsg(target,"募集开始时间不能大于结束时间");		
				return false;
			}
		}else if(onpenTime == ""){
			showErrorMsg(target,"请输入募集开始时间");
			return false;
		}else if(onpenEndTime == ""){
			showErrorMsg($("#collectionStopTimeInput"),"请输入募集结束时间");
			return false;
		}
		hiddenErrorMsg(target);
		//hiddenErrorMsg($("#openendtimeInput"));
		return true;
	}
	//募集结束时间 校验	
	function checkOpenEndTime(target){		
		//开始时间
		var onpenTime = $("#collectionStartTimeInput").val();
		//结束时间
		var onpenEndTime = target.val();		
		//判断
		if(onpenTime){
			if(isMaxDate(onpenTime,onpenEndTime)){
				showErrorMsg(target,"募集结束时间不能小于开始时时间");	
				return false;				
			}
		}
		/**募集结束日与起息日校验*/
		//起息开始日
		var borrowbearingstartdate = $("#interestStartTimeInput").val();
		if(borrowbearingstartdate  && onpenEndTime){
			if(!isMaxDate(borrowbearingstartdate,onpenEndTime)){
				showErrorMsg(target,"募集结束日不能大于等于起息开始日");
				return false;
			}
		}
		hiddenErrorMsg(target);	
		//hiddenErrorMsg($("#opentimeInput"));
		return true;
	}


	//判断 第一个日期 是否大于第二个
	function isMaxDate(maxDateStr,minDateStr){
		var date1 = new Date(maxDateStr.replace("-", "/").replace("-", "/"));  
		var date2 = new Date(minDateStr.replace("-", "/").replace("-", "/"));  
		return date1 > date2;
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
	// 金额BigDecimal(6,2)检查
	function checkBigDecimal6(amount) {
		if (amount == "" || amount == "0" || amount == "0.0" || amount == "0.00" || amount.trim().length == 0) {
			return false;
		} 
		var reg = /^([1-9][\d]{0,3}|0)(\.[\d]{1,2})?$/;
		var re = new RegExp(reg);
		if (!re.test(amount)) {
			return false;
		}
		return true;
	}
	//正整数 
	function isNumber(str){
		var type = /^[0-9]*[0-9][0-9]*$/;
		var re = new RegExp(type);
		if (str.match(re) == null) {
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
</body>
</html>