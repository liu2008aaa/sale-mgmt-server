<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>运费统计</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	
</script>
</head>
<body>
	<p>&nbsp;</p>
	<object id=wb height=0 width=0
		classid=clsid:8856f961-340a-11d0-a96b-00c04fd705a2 name=wb></object>
	<table width="850" border="1" cellpadding="0" cellspacing="0"
		align="center">
		<tr>
			<td colspan="17" height="30"><div align="center" class="STYLE1">
					<strong>巨野县广通达物流有限公司司机运费</strong></td>
		</tr>
			<tr  height="25">
				<td align="center">编号</td>
				<td>发货单位</td>
				<td>收货单位</td>
				<td>公司</td>
				<td>车号</td>
				<td>煤型</td>
				<td>类型</td>
				<td>毛重</td>
				<td>皮重</td>
				<td>净重</td>
				<td>收货净重</td>
				<td>亏吨</td>
				<td>正常亏吨</td>
				<td>超亏吨</td>
				<td>单价</td>
				<td>运费</td>
				<td>发货时间</td>
			</tr>
			<c:forEach items="${page.list}" var="loan">
				<tr  height="25">
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
					<td style="text-align: right">${loan.rnw}</td>
					<td style="text-align: right">${loan.losston}</td>
					<td style="text-align: right">${loan.normallosston}</td>
					<td style="text-align: right">${loan.beyonds}</td>
					<td style="text-align: right">${loan.chauffeurprice}</td>
					<td style="text-align: right">${loan.chauffeurcost}</td>
					<td><fmt:formatDate value="${loan.datetime}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<c:if test="${ costStaResult.count > 0}">
				<tr  height="25">
					<td>总计：</td>
					<td colspan="8">共发货${ costStaResult.count}次</td>
					<td style="text-align: right">${ costStaResult.totalSnw}</td>
					<td style="text-align: right">${ costStaResult.totalRnw}</td>
					<td style="text-align: right">${ costStaResult.totalLosston}</td>
					<td style="text-align: right">&nbsp;</td>
					<td style="text-align: right">${ costStaResult.totalBeyonds}</td>
					<td style="text-align: right">&nbsp;</td>
					<td style="text-align: right">${ costStaResult.totalChauffeurCostStr}</td>
					<td style="text-align: right">&nbsp;</td>
				</tr>
			</c:if>
	</table>
<!-- 	<div class="form-actions" align="center"> -->
<!-- 		<input type="button" class="btn" value="返回" onclick="history.go(-1)"> -->
<!-- 	</div> -->
</body>
</html>