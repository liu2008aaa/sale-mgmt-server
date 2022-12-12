<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>发货管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		var action = '${action}';
		if(action){
			var str = "<input id=\"action\" name=\"action\" type=\"hidden\" value=\"${action}\" />";
			$("#searchForm").append(str);
		}
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
	function toPrint(type) {
		var url = '${ctx}/order/list?print=1&act=' + type;
		$('#searchForm').attr("action", url);
		$('#searchForm').attr("target",'_blank');
		$('#searchForm').submit();
		resetFormAction();
	}
	//导出
	function toExport(type) {
		var url = '${ctx}/order/list?act=' + type + "&export=1";
		$('#searchForm').attr("action", url);
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
	<ul class="nav nav-tabs">
		<c:if test="${action == null}">
			<li class="active"><a href="${ctx}/order/list/">发货列表</a></li>
			<li><a href="${ctx}/order/form">发货录入</a></li>
		</c:if>
		<c:if test="${action == 'shou'}">
		</c:if>
	</ul>
	<form:form id="searchForm" modelAttribute="tabOrderform"
		action="${ctx}/order/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>发货单位：</label> <form:input path="shippername"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>收货单位：</label> <form:input path="receivingname"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>车牌号：</label> <form:input path="platenumber"
					style="width:100px" htmlEscape="false" maxlength="64"
					class="input-medium" /></li>
			<li><label>货运类型：</label> <form:select path="vecturatype"
					class="input-medium" style="width:80px">
					<form:option value="-1">全部</form:option>
					<form:option value="1">长途</form:option>
					<form:option value="2">短途</form:option>
				</form:select></li>
			<li><label>所属公司：</label> <form:input path="carhome"
					style="width:100px" htmlEscape="false" maxlength="64"
					class="input-medium" /></li>
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
				 <c:if test="${action == null }">
						<input class="btn btn-primary" type="button" value="打印本页"
							onclick="toPrint(1)" />
						<input class="btn btn-primary" type="button" value="打印全部"
							onclick="toPrint(2)" />
						<input class="btn btn-primary" type="button" value="导出本页"
							onclick="return confirmx('确认要导出吗？', 'javascript:toExport(1)');" />
						<input class="btn btn-primary" type="button" value="导出全部"
							onclick="return confirmx('确认要导出吗？', 'javascript:toExport(2)');" />
				</c:if>
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
				<c:if test="${action == null }">
					<th>净重</th>
				</c:if>
				<th>状态</th>
				<th>时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="loan">
				<tr>
					<td>${loan.dataIndex }</td>
					<td><c:if test="${action == null}">
							<a target="_blank" href="${ctx}/order/view?id=${loan.id}">${loan.shippername}</a>
						</c:if> <c:if test="${action != null}">
							${loan.shippername}
						</c:if></td>
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
					<td><c:if test="${action == null}">
							<a href="${ctx}/order/form?action=1&id=${loan.id}">修改</a> &nbsp;&nbsp; 
							<a href="javascript:;"
								onclick="return confirmx('确认要删除吗？', 'javascript:doRemove(${loan.id})');">删除</a>
						</c:if> <c:if test="${action == 'shou'}">
							<a href="${ctx}/order/view?action=shou&id=${loan.id}">收货</a> &nbsp;&nbsp; 
						</c:if> <c:if test="${action == 'losston'}">
							<a href="${ctx}/losston/form?orderId=${loan.id}">计算</a> &nbsp;&nbsp; 
						</c:if> <c:if test="${action == 'account'}">
							<a href="${ctx}/account/form?type=1&orderId=${loan.id}">与发货单位结算</a> &nbsp;
							<a href="${ctx}/account/form?type=2&orderId=${loan.id}">与司机结算</a> &nbsp;
							<a href="javascript:;"
								onclick="return confirmx('确认要删除吗？', 'javascript:doRemove(${loan.id})');">删除</a>
						</c:if></td>
				</tr>
			</c:forEach>
			<c:if test="${action == null}">
				<c:if test="${ orderStaResult.count > 0}">
					<tr>
						<td>统计：</td>
						<td colspan="3">总发货${ orderStaResult.count}次</td>
						<td style="text-align: right">&nbsp;</td>
						<td style="text-align: right">&nbsp;</td>
						<td style="text-align: right">&nbsp;</td>
						<td style="text-align: right">${ orderStaResult.totalSnw}</td>
						<td style="text-align: right">&nbsp;</td>
						<td style="text-align: right">&nbsp;</td>
						<td style="text-align: right">&nbsp;</td>
					</tr>
				</c:if>
			</c:if>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>