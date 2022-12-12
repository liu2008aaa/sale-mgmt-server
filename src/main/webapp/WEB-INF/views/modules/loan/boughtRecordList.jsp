<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>投资人列表</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnExport").click(function(){
			top.$.jBox.confirm("确认导出EXCEl?","系统提示",function(v,h,f){
				if(v=="ok"){
					$("#searchForm").attr("action","${ctx}/loan/loan/chargeExport?loanId=${loanId}");
					$("#searchForm").submit();
				}
			},{buttonsFocus:1});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action",'${ctx}/deal/repayManage/queryInvestorlist?loanId='+$("#loanId").val());
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
		<%-- <input type="hidden" id="loanId" name="loanId" value="${loanId}">	
		<form:form id="searchForm" modelAttribute="eList"
		action="${ctx}/deal/repayManage/queryInvestorlist?loanId=${loanId}" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<li><label>投资人姓名</label>
			<input id="realName" name="realName" type="text" value="${realName}" maxlength="20" class="input-medium"/>
		</li>
		<li><label>投资人电话</label>
			<input id="mobile" name="mobile" type="text" value="${mobile}" maxlength="20" class="input-medium"/>
		</li>	
			
		
		

		<li class="btns">
			<input id="btnExport" class="btn btn-primary" type="button" value="导出Excel"/>
		</li>	
			
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" onclick="return page();" value="查询"/>
		</li>
		
	</form:form> --%>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>记录ID</th>
				<th>投资人ID</th>
				<th>产品ID</th>
				<th>投资份数</th>
				<th>购买总额</th>
				<th>应收利息</th>
				<th>还款时间</th>
				<th>是否还款</th>
				<th>购买时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boughtRecordList}" var="boughtRecord">
				<tr>
					<td>${boughtRecord.boughtRecordId}</td>
					<td>${boughtRecord.userId}</td>
					<td>${boughtRecord.productId}</td>
					<td style="text-align: right">${boughtRecord.boughtUnits}</td>
					<td style="text-align: right">${boughtRecord.boughtTotal}</td>
					<td style="text-align: right">${boughtRecord.totalInterest}</td>
					<td style="text-align: right">${boughtRecord.interestHandleTime}</td>
					<td style="text-align: right">
					<c:if test="${boughtRecord.isInterestHandled==0}">未还</c:if>
					<c:if test="${boughtRecord.isInterestHandled==1}">已还</c:if>
					</td>
					<td style="text-align: right">${boughtRecord.boughtTime}</td>
				
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>