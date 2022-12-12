<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>发货单详情</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function printsetup() {
		// 打印页面设置 
		wb.execwb(8, 1);
	}
	function printpreview() {
		// 打印页面预览 
		wb.execwb(7, 1);
	}

	function printit() {
		if (confirm('确定打印吗？')) {
			wb.execwb(6, 6)
		}
	}
	function doReport() {
		window.location = '${ctx}/order/report?id=${tabOrderform.id}'
	}
	//计算亏吨
	function calculateLosston(target) {
		var value = target.value;
		if (!value) {
			return;
		}
		var losstion = '${tabOrderform.snw}' - value;
		if(losstion){
			losstion = losstion.toFixed(3);
		}
		$('#losston').val(losstion);
		$('#losstonLabel').html(losstion);
	}
	//数字小数点
	function clearNoNum(obj) {
		obj.value = obj.value.replace(/[^\d.]/g, ""); //清除“数字”和“.”以外的字符  
		obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是. 
		obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的.   
		obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace(
				"$#$", ".");
	}
	function shouhuo() {
		//收货净重
		var rnw = $('#rnw').val();
		if (!rnw) {
			alert("请输入收货净重");
			return;
		}
		$('#inputForm').submit();
	}
</script>
</head>
<body>
	<OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0
		id=wb name=wb width=3></OBJECT>
	<p>&nbsp;</p>
	<table width="806" border="1" align="center">
		<form:form id="inputForm" modelAttribute="tabOrderform"
			action="${ctx}/order/shouHuo?action=${action }" method="post"
			class="form-horizontal">
			<tr>
				<td colspan="4"><div align="center">
						<strong style="font-size: 19px">发货单详情 </strong>
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
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>皮重：</td>
				<td><label class="control-label">${tabOrderform.stw}</label></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>净重(吨)：</td>
				<td><label class="control-label">${tabOrderform.snw}</label></td>
				<td>净重(吨)：</td>
				<td><c:if test="${action == null || action == 'losston' || action == 'account'}">
						<label class="control-label">${tabOrderform.rnw}</label>
					</c:if> <c:if test="${action == 'shou' }">
						<label style="margin-top: 15px;"> <form:input path="rnw"
								maxlength="100" style="width:100px"
								onblur="calculateLosston(this)" onkeyup="clearNoNum(this)" />
							<form:input path="losston" type="hidden" /> <form:input path="id"
								type="hidden" />
						</label>
					</c:if></td>
			</tr>
			<tr>
				<td>发货日期：</td>
				<td><label class="control-label"><fmt:formatDate
							value="${tabOrderform.datetime}" pattern="yyyy-MM-dd HH:MM:SS" /></label></td>
				<td>亏吨：</td>
				<td><label id="losstonLabel" class="control-label">${tabOrderform.losston}</label>
				</td>
			</tr>
		</form:form>
	</table>
	<div class="form-actions" align="center">
		<c:if test="${action == null }">
<!-- 			<strong> <input class="btn btn-primary" -->
<!-- 				onClick="javascript:printpreview();" type="button" value="打印本页面" -->
<!-- 				name="button_print" /> &nbsp;&nbsp;&nbsp;&nbsp; -->
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
				class="btn btn-primary" onClick="doReport()" type="button"
				value="固定格式打印" />
			</strong>
		</c:if>
		<c:if test="${action == 'shou' }">
			<input class="btn btn-primary" onClick="javascript:shouhuo();"
				type="button" value="提交" name="button_shou" />
		</c:if>
<!-- 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!-- 		<input type="button" class="btn" value="返回" onclick="history.go(-1)"> -->
	</div>
</body>
</html>