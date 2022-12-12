<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>产品选择列表</title>
<meta name="decorator" content="default" />
<script type="text/javascript">

	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	
	function getRslt(){
		
		if(!getSelectedRow()){
			alertx("请选择一条记录");
			return;
		}
		
		var loanId = getSelectedRow().id.split("_")[1];
		var loanInvestorStatus = getSelectedRow().id.split("_")[2]

		var title = document.getElementById(loanId+"_"+loanInvestorStatus+"_title").innerText;
		var loanInvestorId = document.getElementById(loanId+"_"+loanInvestorStatus+"_loanInvestorId").value;
		
		var borrowBearingStartDate = document.getElementById(loanId+"_"+loanInvestorStatus+"_borrowBearingStartDate").value;					
		var borrowBearingEndDate = document.getElementById(loanId+"_"+loanInvestorStatus+"_borrowBearingEndDate").value;					
		var investTotalAmount = document.getElementById(loanId+"_"+loanInvestorStatus+"_investTotalAmount").value;					
		var annualInterestRate = document.getElementById(loanId+"_"+loanInvestorStatus+"_annualInterestRate").value;					
		var redeemRate = document.getElementById(loanId+"_"+loanInvestorStatus+"_redeemRate").value;	
		var loanInvestorId =  document.getElementById(loanId+"_"+loanInvestorStatus+"_loanInvestorId").value;

		var loan = {"title" : title,
					"loanInvestorId":loanInvestorId,
					"loanInvestorStatus":loanInvestorStatus,
					"borrowBearingStartDate" : borrowBearingStartDate,
					"borrowBearingEndDate":borrowBearingEndDate,
					"investTotalAmount":investTotalAmount,
					"annualInterestRate":annualInterestRate,
					"redeemRate":redeemRate,
					"loanInvestorId":loanInvestorId,
					"loanId":loanId
		};

		return loan;		
	}
	
	$(document).ready(function() {
		initTrStatus();
	});
	
	function initTrStatus(){
		var rows = document.getElementsByName("dataTr");
		for(var i=0;i<rows.length;i++){
			rows[i].selected = false;
		}
	}
	
	function getSelectedRow(){
		var rows = document.getElementsByName("dataTr");
		for(var i=0;i<rows.length;i++){
			if(rows[i].selected == true){
				return rows[i];
			}			
		}
		return null;

	}
	
	function clickRow(tr){
		cancerRowSelected();
		rowSelected(tr);
	}
	
	//设置行的背景色
	function setRowBgColor(tr, color){
		if(tr){
			for(var i=0;i<tr.childNodes.length;i++){
				if(tr.childNodes[i].tagName && tr.childNodes[i].tagName == "TD"){
					tr.childNodes[i].style.backgroundColor = color;
				}
			}			
		}
	}
	
	//取消已选行
	function cancerRowSelected(){
		var rowSelected = getSelectedRow();
		if(rowSelected){
			setRowBgColor(rowSelected, "");
			rowSelected.selected = false;
		}
	}
	
	//选中行
	function rowSelected(tr){
		tr.selected = true;
		setRowBgColor(tr, "#FFE4B5");
	}

</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="loanDto"
		action="${ctx}/loan/loan/selectInvested?investorId=${investorId}" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>产品ID：</label> <form:input path="loanId"
					htmlEscape="false" maxlength="64" class="input-medium" onkeyup="value=value.replace(/[^\d]/g,'') "   
                    onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  /></li>		
			<li><label>产品标题：</label> <form:input path="title"
					htmlEscape="false" maxlength="64" class="input-medium" /></li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />

	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>产品ID</th>
				<th>产品标题</th>
				<th>预期年化收益率</th>
				<th>购买金额</th>	
				<th>赎回状态</th>				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="loan">
				<tr name="dataTr" id="tr_${loan.loanId}_${loan.loanInvestorStatus}" onclick="clickRow(this)">
					<td>
						${loan.loanId}
					</td>
					<td>
						<span id="${loan.loanId}_${loan.loanInvestorStatus}_title" >${loan.title}</span>
						
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_loanInvestorId" value='${loan.loanInvestorId}'/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_borrowBearingStartDate" value='${loan.startDate}'/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_borrowBearingEndDate" value='${loan.endDate}'/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_investTotalAmount" value="${loan.investTotalAmount}"/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_annualInterestRate" value="${loan.annualInterestRate}"/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_redeemRate" value="${loan.redeemRate}"/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_loanInvestorId" value="${loan.loanInvestorId}"/>
						<input type="hidden" id="${loan.loanId}_${loan.loanInvestorStatus}_loanInvestorStatus" value="${loan.loanInvestorStatus}"/>
						
					</td>
					<td>
						${loan.annualInterestRate}
					</td>					
					<td>
						${loan.investTotalAmount}
					</td>
					<td>
						<c:if test = "${loan.loanInvestorStatus == 210}">
						  已赎回
						</c:if>
						<c:if test = "${loan.loanInvestorStatus == 350}">
						  已申请
						</c:if>
						<c:if test = "${loan.loanInvestorStatus != 210 && loan.loanInvestorStatus != 350}">
						  未赎回
						</c:if>
					</td>
				</tr>
			</c:forEach> 
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>