<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>运费统计</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	var isClicked = false;
	//删除
	function doRemove(id) {
		if (isClicked) {
			return;
		}
		isClicked = true;
		var ajaxurl = "${ctx}/order/doRemove";
		$.ajax({
			url : ajaxurl,
			dataType : "json",
			data : {
				id : id
			},
			type : "POST",
			success : function(ajaxobj) {
				isClicked = false;
				var type = 'error';
				if (ajaxobj.code == 'C00000') {
					type = 'success';
					setTimeout(function() {
						location.reload();
					}, 1000);
				}
				top.$.jBox.tip.mess = 1;
				top.$.jBox.tip(ajaxobj.msg, type, {
					persistent : true,
					opacity : 0
				});
				$("#messageBox").show();
				$("#messageBox").find(".content").html(ajaxobj.msg);
			},
			error : function(ajaxobj) {
				isClicked = false;
				top.$.jBox.tip.mess = 1;
				top.$.jBox.tip("发送失败，请重试", "error", {
					persistent : true,
					opacity : 0
				});
			}
		});
	}
	//弹出浮窗
	function openFW(title, url) {
		top.$.jBox.open("iframe:" + url, title, 800, 520, {
			ajaxData : {},
			buttons : {
				"确定" : "ok",
				"关闭" : true
			},
			submit : function(v, h, f) {
				if (v == "ok") {
				}
			},
			loaded : function(h) {
				$(".jbox-content", top.document).css("overflow-y", "hidden");
			}
		});
	}
	//去打印
	function toPrint(act){
		var url = '${ctx}/account/list?type=1&action=2&act=' + act;
		$('#searchForm').attr("action",url);
		$('#searchForm').attr("target","_blank");
		$('#searchForm').submit();
		resetFormAction();
	}
	//导出
	function toExport(act) {
		var url = '${ctx}/account/list?type=1&act=' + act + "&export=1";
		$('#searchForm').attr("action", url);
		//$('#searchForm').attr("target",'_blank');
		$('#searchForm').submit();
		resetFormAction();
	}
	//重置url
	function resetFormAction(){
		$('#searchForm').attr("action", '${ctx}/order/list');
		$('#searchForm').attr("target",'');
	}
</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="tabAccounts"
		action="${ctx}/account/list?type=1" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>发货单位：</label> <form:input path="shippername"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>收货单位：</label> <form:input path="receivingname"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>车牌号：</label> <form:input path="platenumber" style="width:100px"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>货运类型：</label> <form:select path="vecturatype"
					class="input-medium" style="width:80px">
					<form:option value="-1">全部</form:option>
					<form:option value="1">长途</form:option>
					<form:option value="2">短途</form:option>
				</form:select></li>
		</ul>
		<ul class="ul-form">
			<li><label>开始时间：</label> <form:input path="startDate"
					htmlEscape="false" maxlength="20" class="input-mini Wdate"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
			</li>
			<li><label>结束时间：</label> <form:input path="endDate" type="text"
					readonly="readonly" maxlength="20" class="input-mini Wdate"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
			</li>

			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary"
					type="submit" value="查询" />
				<input id="btnSubmitDayin" class="btn btn-primary"
					type="button" value="打印本页" onclick="toPrint(1)"/>
				<input id="btnSubmitDayin" class="btn btn-primary"
					type="button" value="打印全部" onclick="toPrint(2)"/>
				<input class="btn btn-primary" type="button" value="导出本页"
							onclick="return confirmx('确认要导出吗？', 'javascript:toExport(1)');" />
				<input class="btn btn-primary" type="button" value="导出全部"
					onclick="return confirmx('确认要导出吗？', 'javascript:toExport(2)');" />
			</li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<div id="msgBox" class="alert hide">
		<button data-dismiss="alert" class="close">×</button>
		<label id="msgLabel"></label>
	</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>编号</th>
				<th>发货单位</th>
				<th>收货单位</th>
				<th>公司</th>
				<th>车号</th>
				<th>煤型</th>
				<th>类型</th>
				<th>毛重</th>
				<th>皮重</th>
				<th>净重</th>
				<th>单价</th>
				<th>运费</th>
				<th>发货时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="loan">
				<tr>
					<td>${loan.dataIndex }</td>
					<td >
						${loan.shippername}
					</td>
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
					<td ><fmt:formatDate value="${loan.datetime}"  pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<c:if test="${ costStaResult.count > 0}">
				<tr >
					<td>总计：</td>
					<td colspan="8">共发货${ costStaResult.count}次</td>
					<td style="text-align: right">${ costStaResult.totalSnw}</td>
					<td style="text-align: right">&nbsp;</td>
					<td style="text-align: right">${ costStaResult.totalShipperCostStr}</td>
					<td style="text-align: right">&nbsp;</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>