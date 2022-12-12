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
</script>
</head>
<body>
	<p>&nbsp;</p>
	<object id=wb height=0 width=0
		classid=clsid:8856f961-340a-11d0-a96b-00c04fd705a2 name=wb></object>
	<table width="720" border="1" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td height="30" colspan="8"><div align="center">
					<span class="STYLE3">巨野县广通达物流有限公司发货单</span>
				</div></td>
		</tr>
		<tr>
			<td width="115" height="25">单据编号</td>
			<td colspan="7">${tabOrderform.dataIndex}
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<fmt:formatDate
						value="${tabOrderform.datetime}" pattern="yyyy年MM月dd日" />
				</td>
		</tr>
		<tr>
			<td height="25">发货单位</td>
			<td height="25" colspan="4">${tabOrderform.shippername}</td>
			<td width="73" height="25"><div align="right">收货单位</div></td>
			<td height="25" colspan="2">${tabOrderform.receivingname}</td>
		</tr>
		<tr>
			<td height="25">车辆所属公司</td>
			<td width="71" height="25">车号</td>
			<td width="68" height="25">煤种</td>
			<td width="65" height="25">毛重</td>
			<td width="67" height="25">皮重</td>
			<td height="25">净重</td>
			<td width="73" height="25">净重</td>
			<td width="80" height="25">亏吨</td>
		</tr>
		<tr>
			<td height="25">${tabOrderform.carhome}</td>
			<td height="25">${tabOrderform.platenumber}</td>
			<td height="25">${tabOrderform.coaltype}</td>
			<td height="25">${tabOrderform.sgw}</td>
			<td height="25">${tabOrderform.stw}</td>
			<td height="25">${tabOrderform.snw}</td>
			<td height="25"><div align="right">${tabOrderform.rnw}</div></td>
			<td height="25"><div align="right">${tabOrderform.losston}</div></td>
		</tr>
		<tr>
			<td height="25" colspan="2">车主签字</td>
			<td height="25">&nbsp;</td>
			<td height="25">&nbsp;</td>
			<td height="25">&nbsp;</td>
			<td height="25"><div align="right">收货方签字</div></td>
			<td height="25" colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td height="25" colspan="5">&nbsp;</td>
			<td height="25"><div align="right">制单人</div></td>
			<td height="25" colspan="2">${fns:getUser().name}</td>
		</tr>
	</table>
<!-- 	<div class="form-actions" align="center"> -->
<!-- 		<input type="button" class="btn" value="返回" onclick="history.go(-1)"> -->
<!-- 	</div> -->
</body>
</html>