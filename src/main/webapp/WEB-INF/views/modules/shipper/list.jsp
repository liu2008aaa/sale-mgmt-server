<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>发货单位管理</title>
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
		var ajaxurl = "${ctx}/shipper/doRemove";
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
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/shipper/list">发货单位列表</a></li>
		<li><a href="${ctx}/shipper/form">发货单位录入</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="tabShipper"
		action="${ctx}/shipper/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>发货单位：</label> <form:input path="name"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>余额少于：</label> <form:input path="lessMoney"  style="width:80px"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>
		<li><label>开始时间：</label> <form:input path="startDate"
				htmlEscape="false" maxlength="20" class="input-mini Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
		</li>
		<li><label>结束时间：</label> <form:input path="endDate" type="text"
				readonly="readonly" maxlength="20" class="input-mini Wdate"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
		</li>

		<li class="btns"><input id="btnSubmit" class="btn btn-primary"
			type="submit" value="查询" /></li>
		<li class="clearfix"></li>
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
				<th>发货单位</th>
				<th>余额</th>
				<th>超额限定</th>
				<th>时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="loan">
				<tr>
					<td style="text-align: left">${loan.name}</td>
					<td style="text-align: right">${loan.money}</td>
					<td style="text-align: right">${loan.restriction}</td>
					<td><fmt:formatDate value="${loan.datetime}"
							pattern="yyyy-MM-dd" /></td>
					<td><a href="${ctx}/shipper/form?action=1&id=${loan.id}">修改</a>
						&nbsp;&nbsp; <a href="javascript:;"
						onclick="return confirmx('确认要删除吗？', 'javascript:doRemove(${loan.id})');">删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>