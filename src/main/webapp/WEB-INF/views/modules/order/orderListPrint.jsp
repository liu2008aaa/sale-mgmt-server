<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>发货管理</title>
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
	<table width="750" border="1" cellpadding="0" cellspacing="0"
		align="center">
		<tr>
			<td colspan="10" height="30"><div align="center" class="STYLE1">
					<strong>巨野县广通达物流有限公司发货单统计</strong>
			</td>
		</tr>
		<tr align="center">
			<td align="center">编号</td>
			<td>发货单位</td>
			<td>收货单位</td>
			<td>公司</td>
			<td>车号</td>
			<td>煤型</td>
			<td>类型</td>
			<td>净重</td>
			<td>状态</td>
			<td>时间</td>
		</tr>
		<c:forEach items="${page.list}" var="loan">
			<tr align="center">
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
				<c:if test="${action == null }">
					<td style="text-align: right">${loan.snw}</td>
				</c:if>
				<td><c:if test="${loan.status==1}">   
								已发货
						 </c:if> <c:if test="${loan.status==2}">   
								已收货
						 </c:if> <c:if test="${loan.status==3}">   
								已计算
						 </c:if></td>
				<td><fmt:formatDate value="${loan.datetime}"
						pattern="yyyy-MM-dd" /></td>
			</tr>
		</c:forEach>
		<c:if test="${ orderStaResult.count > 0}">
			<tr>
				<td align="center">统计：</td>
				<td colspan="3">总发货${ orderStaResult.count}次</td>
				<td style="text-align: right">&nbsp;</td>
				<td style="text-align: right">&nbsp;</td>
				<td style="text-align: right">&nbsp;</td>
				<td style="text-align: right">${ orderStaResult.totalSnw}</td>
				<td style="text-align: right">&nbsp;</td>
				<td style="text-align: right">&nbsp;</td>
			</tr>
		</c:if>
	</table>
<!-- 		<div class="form-actions" align="center"> -->
<!-- 		<input type="button" class="btn" value="返回" onclick="history.go(-1)"> -->
<!-- 	</div> -->
</body>
</html>