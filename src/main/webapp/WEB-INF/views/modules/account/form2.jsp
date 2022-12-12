<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<!-- 与司机结算 -->
<title>发货单详情</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	//计算
	function calculateMoney(target) {
		//运费单价
		var price = target.value;
		if (!price) {
			return;
		}
		//实收净重
		var rnw = '${tabOrderform.rnw}';
		//煤型单价 
		var losstonPrice = '${tabLosston.price}';
		//超亏吨数
		var beyonds = '${tabLosston.beyonds}';
		//应收运费
		var cost = 0;
		if(beyonds!=null&&beyonds!=""&&!isNaN(beyonds)&&beyonds>0){//超亏吨 >0
			if(losstonPrice == null|| losstonPrice==""){
				 alert("煤型单价没有录入");
				 return;
			}else{
				//运费=运费单价*实收数量—超亏吨数*（运费单价+煤型单价）
				cost = price*rnw-beyonds*((losstonPrice-0)+(price-0));
			}
		}else{
			//运费=运费单价*实收数量				
			cost = price*rnw;
		}
		cost = cost.toFixed(2);
		$('#chauffeurcostLabel').html(cost);
		$('#chauffeurcost').val(cost);
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
		var chauffeurprice = $('#chauffeurprice').val();
		if (!chauffeurprice) {
			alert("运费单价不能为空");
			return;
		}
		$('#inputForm').submit();
	}
	//check
	function changeLossratio(target) {
		var isChecked = target.checked;
		$("#lossratio").attr("readonly", isChecked == false);
	}
</script>
</head>
<body>
	<p>&nbsp;</p>
	<table width="806" border="1" align="center">
		<form:form id="inputForm" modelAttribute="tabAccounts"
			action="${ctx}/account/save?type=2&orderid=${tabOrderform.id }"
			method="post" class="form-horizontal">
			<form:input path="id" type="hidden" />
			<tr>
				<td colspan="4"><div align="center">
						<strong style="font-size: 19px">与司机结算 </strong>
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
			<tr>
				<td colspan="2"><div align="center"
						style="font-weight: normal;">发货</div></td>
				<td colspan="2"><div align="center"
						style="font-weight: normal;">收货</div></td>
			</tr>
			<tr>
				<td>毛重：</td>
				<td><label class="control-label">${tabOrderform.sgw}</label></td>
			</tr>
			<tr>
				<td>皮重：</td>
				<td><label class="control-label">${tabOrderform.stw}</label></td>
			</tr>
			<tr>
				<td>净重(吨)：</td>
				<td><label class="control-label">${tabOrderform.snw}</label></td>
				<td>净重(吨)：</td>
				<td><label class="control-label">${tabOrderform.rnw}</label></td>
			</tr>
			<tr>
				<td>发货日期：</td>
				<td ><label class="control-label"><fmt:formatDate
							value="${tabOrderform.datetime}" pattern="yyyy-MM-dd HH:MM:SS" /></label></td>
				<td>亏吨：</td>
				<td><label id="losstonLabel" class="control-label">${tabOrderform.losston}</label>
				</td>
			</tr>
			<tr>
				<td>煤型单价：</td>
				<td >${tabLosston.price }
				</label></td>
				<td>超亏吨数：</td>
				<td><label id="losstonLabel" class="control-label">${tabLosston.beyonds}</label>
				</td>
			</tr>
			<tr>
				<td>运费单价：</td>
				<td ><label style="margin-top: 10px;"> <form:input
							path="chauffeurprice" maxlength="100" onkeyup="clearNoNum(this)"
							onblur="calculateMoney(this)" />
				</label></td>
			</tr>
			<tr>
				<td>应收运费：</td>
				<td ><label id="chauffeurcostLabel"
					class="control-label">${tabAccounts.chauffeurcost}</label> <form:input
						path="chauffeurcost" type="hidden" /></td>
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