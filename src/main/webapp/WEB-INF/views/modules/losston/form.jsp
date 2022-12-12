<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>发货单详情</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	//计算亏吨
	function calculateLosston(target) {
		//煤型亏吨率
		var lossratio = target.value;
		if (!lossratio) {
			return;
		}
		//发货净重
		var snw = '${tabOrderform.snw}';
		//正常亏吨=煤型亏吨率*实发数量
		var normallosston = (snw*lossratio).toFixed(3);
		//第二步中 的亏吨
		var losston = '${tabOrderform.losston}';
		if(losston){
			var beyonds = 0;
			//第二步中 亏吨数 > 正常亏吨数
			if(losston > normallosston){
				//超亏吨数=当第二步中计算出的亏顿数—正常亏吨数
				beyonds = (losston-normallosston).toFixed(3);
			}
			$('#beyondsLabel').html(beyonds);
			$('#beyonds').val(beyonds);
		}
		$('#normallosstonLabel').html(normallosston);
		$('#normallosston').val(normallosston);
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
		var price = $('#price').val();
		if (!price) {
			alert("煤型单价不能为空");
			return;
		}
		var lossratio = $('#lossratio').val();
		if (!lossratio) {
			alert("煤型亏吨率不能为空");
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
		<form:form id="inputForm" modelAttribute="tabLosston"
			action="${ctx}/losston/save?orderid=${tabOrderform.id }" method="post"
			class="form-horizontal">
			<form:input path="id" type="hidden" />
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
				<td><label class="control-label">${tabOrderform.rnw}</label></td>
			</tr>
			<tr>
				<td>发货日期：</td>
				<td><label class="control-label"><fmt:formatDate
							value="${tabOrderform.datetime}" pattern="yyyy-MM-dd HH:MM:SS" /></label></td>
				<td>亏吨：</td>
				<td><label id="losstonLabel" class="control-label">${tabOrderform.losston}</label>
				</td>
			</tr>
			<tr>
				<td>煤型单价：</td>
				<td><label style="margin-top: 10px;"> <form:input
							path="price" maxlength="100" style="width:100px"
							onkeyup="clearNoNum(this)" />
				</label></td>
				<td><form:checkbox path="checked" label="煤型亏损率：" onchange="changeLossratio(this)"/></td>
				<td><label style="margin-top: 10px;">
				 <form:input readonly="true"
							path="lossratio" maxlength="100" style="width:100px"
							onkeyup="clearNoNum(this)"
							onblur="calculateLosston(this)"
							 />
				</label></td>
			</tr>
			<tr>
				<td>正常亏顿数：</td>
				<td><label id="normallosstonLabel" class="control-label">${tabLosston.normallosston}</label>
				 	<form:input path="normallosston" type="hidden"/>
				</td>
				<td>超亏吨数：</td>
				<td><label id="beyondsLabel" class="control-label">${tabLosston.beyonds}</label>
				<form:input path="beyonds" type="hidden"/>
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