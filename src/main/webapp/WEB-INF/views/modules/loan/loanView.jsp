<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产品录入</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<form:form id="inputForm" modelAttribute="loan" action="" method="post" class="form-horizontal">
	
		<div class="control-group">
			<label class="control-label">产品代码：</label>
			<label class="control-label">${loan.loanCode}</label>

			<label class="control-label">产品名称：</label>
			<label class="control-label">${loan.title}</label>
		</div>
		<div class="control-group">
			<label class="control-label">产品类别：</label>
			<label class="control-label">${loan.loanType.value}</label>

			<label class="control-label">产品总额：</label>
			<label class="control-label">${loan.amount} 元</label>
		</div>
		<div class="control-group">
			<label class="control-label">预期年化收益率：</label>
			<label class="control-label">${loan.annualInterestRate}</label>

			<label class="control-label">起息日：</label>
			<label class="control-label"><fmt:formatDate value="${loan.borrowBearingStartDate}" pattern="yyyy-MM-dd"/></label>
		</div>
		<div class="control-group">
			<label class="control-label">到期日：</label>
			<label class="control-label"><fmt:formatDate value="${loan.borrowBearingEndDate}" pattern="yyyy-MM-dd"/></label>

			<label class="control-label">产品期限：</label>
			<label class="control-label">${loan.termCount} 天</label>
		</div>
		<div class="control-group">
			<label class="control-label">每份金额：</label>
			<label class="control-label">${loan.amountForEachShare} 元</label>

			<label class="control-label">起购份数：</label>
			<label class="control-label">${loan.minInvestUnit} 份</label>
		</div>
		<div class="control-group">
			<label class="control-label">限购份数：</label>
			<label class="control-label">${loan.maxInvestUnit} 份（0表示不限购）</label>

			<label class="control-label">募集开始时间：</label>
			<label class="control-label"><fmt:formatDate value="${loan.openTime}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
		</div>
		<div class="control-group">
			<label class="control-label">募集结束时间：</label>
			<label class="control-label"><fmt:formatDate value="${loan.openEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/></label>


			<label class="control-label">投资方向信息：</label>
			<label class="control-label">
				<c:forEach var="elm" items="${ln:getAllCorporationMain()}" varStatus="st">
					<c:if test="${elm.id == loan.borrowerId}"> ${elm.fullname}</c:if>				
				</c:forEach>
			</label>
		</div>
		<div class="control-group">
			<label class="control-label">本金运作模式：</label>
			<label class="control-label">
				${loan.corpusModel.value}
			</label>

			<label class="control-label">计息基准：</label>
			<label class="control-label">
				<c:forEach var="elm" items="${ln:getAccrualBenchmarks()}" varStatus="st">
					<c:if test="${elm.value == loan.accrualBenchmark}"> ${elm.label}</c:if>				
				</c:forEach>
			</label>
		</div>
		<div class="control-group">
			<label class="control-label">产品风险等级：</label>
			<label class="control-label">
				<c:forEach var="elm" items="${ln:getRiskLevels()}" varStatus="st">
					<c:if test="${elm.value == loan.riskLevel}"> ${elm.label}</c:if>				
				</c:forEach>
			</label>

			<label class="control-label">退保扣费费率：</label>
			<label class="control-label">${loan.redeemRate} %</label>
		</div>
		<div class="control-group">
				<label class="control-label">赎回开放期赎回：</label>
				<label class="control-label">
					<c:choose>
						<c:when test="${loan.isAllowRedeem == 1}">允许</c:when>
						<c:otherwise>不允许</c:otherwise>
					</c:choose>
				</label>

			<label class="control-label">犹豫期：</label>
			<label class="control-label">${loan.hesitateTimeLimit} 天</label>
		</div>
		<div class="control-group">
			<label class="control-label">促销活动：</label>
			<label class="control-label">
				<c:forEach items="${loanPromotionList}" var="p">
					${p.desc},
				</c:forEach>
			</label>
		</div>
		<div class="control-group">
			<label class="control-label">产品销售类型：</label>
			<label class="control-label">${loan.loanSellType.value}</label>
		</div>
	</form:form>
</body>
</html>