<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>运费统计</title>
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
</script>
</head>
<body>
	<p>&nbsp;</p>
	<object id=wb height=0 width=0
		classid=clsid:8856f961-340a-11d0-a96b-00c04fd705a2 name=wb></object>
	<table width="800" border="1" cellpadding="0" cellspacing="0"
		align="center">
		<tr>
			<td colspan="13" height="30"><div align="center" class="STYLE1">
					<strong>巨野县广通达物流有限公司发货单位运费</strong>
		    </td>
		</tr>
		<tr height="25">
			<td height="25" width="50"><div align="center">编号</div></td>
			<td height="25" width="125"><div align="center">发货单位</div></td>
			<td height="25" width="90"><div align="center">收货单位</div></td>
			<td height="25" width="70"><div align="center">公司</div></td>
			<td height="25" width="80"><div align="center">车牌号</div></td>
			<td height="25" width="60"><div align="center">煤型</div></td>
			<td height="25" width="40">类型</td>
			<td height="25" width="60"><div align="center">毛重</div></td>
			<td height="25" width="60"><div align="center">皮重</div></td>
			<td height="25" width="60"><div align="center">净重</div></td>
			<td height="25" width="60"><div align="center">单价</div></td>
			<td height="25" width="60"><div align="center">运费</div></td>
			<td height="25" width="75"><div align="center">发货时间</div></td>
		</tr>
		<c:forEach items="${page.list}" var="loan">
			<tr height="25">
				<td align="center">${loan.dataIndex }</td>
				<td>${loan.shippername}</td>
				<td>${loan.receivingname}</td>
				<td>${loan.carhome}</td>
				<td>${loan.platenumber}</td>
				<td>${loan.coaltype}</td>
				<td><c:if test="${loan.vecturatype==1}">   
								长途
						 </c:if> <c:if test="${loan.vecturatype==2}">   
								短途
						 </c:if></td>
				<td style="text-align: right">${loan.sgw}</td>
				<td style="text-align: right">${loan.stw}</td>
				<td style="text-align: right">${loan.snw}</td>
				<td style="text-align: right">${loan.shipperprice}</td>
				<td style="text-align: right">${loan.shippercost}</td>
				<td style="text-align: center"><fmt:formatDate value="${loan.datetime}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>
		<tr height="25">
			<td>总计：</td>
			<td colspan="8">共发货${ costStaResult.count}次</td>
			<td style="text-align: right">${ costStaResult.totalSnw}</td>
			<td style="text-align: right">&nbsp;</td>
			<td style="text-align: right">${ costStaResult.totalShipperCostStr}</td>
			<td style="text-align: right">&nbsp;</td>
		</tr>
	</table>
<!-- 	<div class="form-actions" align="center"> -->
<!-- 		<input type="button" class="btn" value="返回" onclick="history.go(-1)"> -->
<!-- 	</div> -->
</body>
</html>