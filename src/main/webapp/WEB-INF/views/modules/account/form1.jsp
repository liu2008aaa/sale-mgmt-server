<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<!-- 与发货单位结算 -->
<title>发货单详情</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	//计算
	function calculateMoney(target) {
		//运费单价
		var shipperprice = target.value;
		if (!shipperprice) {
			return;
		}
		//发货净重
		var snw = '${tabOrderform.snw}';
		//应收运费 = 净重 ×　运费单价
		var shippercost = snw*shipperprice;
		shippercost = shippercost.toFixed(2);
		var money = '${tabShipper.money}' - shippercost;
		money = money.toFixed(2);
		$('#shippercostLabel').html(shippercost);
		$('#shippercost').val(shippercost);
		$('#moneyLabel').html(money);
		$('#money').val(money);
	}
	//数字小数点
	function clearNoNum(obj) {
		obj.value = obj.value.replace(/[^\d.]/g, ""); //清除“数字”和“.”以外的字符  
		obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是. 
		obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.   
		obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace(
				"$#$", ".");
	}
	function submit() {
		var shipperprice = $('#shipperprice').val();
		if (!shipperprice) {
			alert("运费单价不能为空");
			return;
		}
		$('#inputForm').submit();
	}
	//check
	function changeLossratio(target){
		var isChecked = target.checked;
		$("#lossratio").attr("readonly",isChecked == false);
	}
</script>
</head>
<body>
	<p>&nbsp;</p>
	<table width="806" border="1" align="center">
		<form:form id="inputForm" modelAttribute="tabAccounts"
			action="${ctx}/account/save?type=1&orderid=${tabOrderform.id }" method="post"
			class="form-horizontal">
			<form:input path="id" type="hidden" />
			<tr>
				<td colspan="4"><div align="center">
						<strong style="font-size: 19px">与发货单位结算 </strong>
					</div></td>
			</tr>
			<tr>
				<td width="100" valign="middle">发货单位：</td>
				<td width="168"><label class="control-label">${tabOrderform.shippername}</label></td>
				<td width="100">收货单位：</td>
				<td width="168"><label class="control-label">${tabOrderform.receivingname}</label></td>
			</tr>
			<tr>
				<td>车辆所属公司：</td>
				<td><label class="control-label">${tabOrderform.carhome}</label></td>
				<td>货运类型：</td>
				<td><c:if test="${tabOrderform.vecturatype==0}">长途</c:if> <c:if
						test="${tabOrderform.vecturatype==1}">长途</c:if> <c:if
						test="${tabOrderform.vecturatype==2}">短途</c:if></td>
			</tr>
			<tr>
				<td>煤型：</td>
				<td><label class="control-label">${tabOrderform.coaltype}</label></td>
				<td>车牌号：</td>
				<td><label class="control-label">${tabOrderform.platenumber}</label></td>
			</tr>
			<tr >
				<td >毛重：</td>
				<td colspan="3"><label class="control-label">${tabOrderform.sgw}</label></td>
			</tr>
			<tr>
				<td>皮重：</td>
				<td colspan="3"><label class="control-label">${tabOrderform.stw}</label></td>
			</tr>
			<tr>
				<td>净重(吨)：</td>
				<td colspan="3"><label class="control-label">${tabOrderform.snw}</label></td>
			</tr>
			<tr>
				<td>发货日期：</td>
				<td colspan="3"><label class="control-label"><fmt:formatDate
							value="${tabOrderform.datetime}" pattern="yyyy-MM-dd HH:MM:SS" /></label></td>
			</tr>
			<tr>
				<td>运费单价：</td>
				<td colspan="3"><label style="margin-top: 10px;"> <form:input
							path="shipperprice" maxlength="100" 
							onkeyup="clearNoNum(this)"
							onblur="calculateMoney(this)"
							 />
				</label></td>
			</tr>
			<tr>
				<td>应收运费：</td>
				<td colspan="3"><label id="shippercostLabel" class="control-label">${tabAccounts.shippercost}</label>
				 	<form:input path="shippercost" type="hidden"/>
				</td>
			</tr>
			<tr>
				<td>帐户余额：</td>
				<td colspan="3"><label id="moneyLabel" class="control-label"
<%-- ${tabAccounts.money} --%>
</label>
				 	<form:input path="money" type="hidden"/>
				</td>
			</tr>
		</form:form>
	</table>
	<div class="form-actions" align="center">
		<input class="btn btn-primary" onClick="javascript:submit();"
			type="button" value="提交" name="button_shou" />
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="btn" value="返回" onclick="history.go(-1)">
	</div>
</body>
</html>