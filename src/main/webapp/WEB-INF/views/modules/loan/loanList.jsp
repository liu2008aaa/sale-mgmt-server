<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>产品列表</title>
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
	//结束募集请求
	function doFinish(loanId){
		if(isClicked){
			return;
		}
		isClicked = true;
		var ajaxurl = "${ctx}/loan/loan/doFinish";
		$.ajax({
			url : ajaxurl,
			dataType : "json",
			data : {
				loanId : loanId
			},
			type : "POST",
			success : function(ajaxobj) {
				isClicked = false;
				var type = 'error';
				if(ajaxobj.code == 'C00000'){
					type = 'success';
					setTimeout(function(){
						location.reload();
					},1000);
				}
				top.$.jBox.tip.mess=1;
				top.$.jBox.tip(ajaxobj.msg,type,{persistent:true,opacity:0});
				$("#messageBox").show();
				$("#messageBox").find(".content").html(ajaxobj.msg);				
			},
			error : function(ajaxobj) {
				isClicked = false;			
				top.$.jBox.tip.mess=1;
				top.$.jBox.tip("发送失败，请重试","error",{persistent:true,opacity:0});
			}
		});
	}
	//弹出浮窗
	function openFW(title, url) {
		top.$.jBox.open(
			"iframe:" + url,
			title,
			800,
			520,
			{
				ajaxData: {
				},
				buttons:{"确定":"ok","关闭":true}, 
				submit:function(v, h, f){
					if (v=="ok"){
					}
				}, 
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			}
		);
	}
	
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/loan/loan/">产品列表</a></li>
		<shiro:hasPermission name="loan:loan:edit">
			<li><a href="${ctx}/loan/loan/form">产品录入</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="experienceFinancialProduct"
		action="${ctx}/loan/loan/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>产品名称：</label> <form:input path="productName"
					htmlEscape="false" maxlength="64" class="input-medium" />
			</li>
			<li><label>产品总额：</label> <form:input path="totalMoney"
					htmlEscape="false" maxlength="64" class="input-medium"   onkeyup="value=value.replace(/[^\d]/g,'') "   
                    onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"   />
            </li>
			<li><label>起息日范围：</label>
				<form:input path="interestStartTimeStart" htmlEscape="false" maxlength="20" class="input-mini Wdate"
				    onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li>&nbsp;&nbsp;--&nbsp;&nbsp;
				<form:input path="interestStartTimeEnd"  type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li> 
<%-- 			<li><label>产品状态：</label>
		    	<form:select path="status" class="input-medium">
		    		<form:option value = "-1">全部</form:option>
					<form:options items="${ln:loanStatusForSearch()}" itemLabel="value" itemValue="code" htmlEscape="false"/>
				</form:select>
		   </li> --%>
		 </ul>
		 <ul class="ul-form">
			
			<li><label style="width: auto" >预期年化收益率：</label> <form:input path="interestRate"
					htmlEscape="false" maxlength="64" class="input-medium"   onkeyup="if(isNaN(value))execCommand('undo')"   
                    onbeforepaste="if(isNaN(value))execCommand('undo')"   />
            </li>
            <li><label>到期日范围：</label>
				<form:input path="interestEndTimeStart" htmlEscape="false" maxlength="20" class="input-mini Wdate"
				    onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li>
			<li>&nbsp;&nbsp;--&nbsp;&nbsp;
				<form:input path="interestEndTimeEnd" type="text" readonly="readonly" maxlength="20" class="input-mini Wdate"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
				<th>产品ID</th>
				<th>产品名称</th>
			<!-- 	<th>产品类型</th> -->
				<th>产品状态</th>
				<th>年化利率</th>
				<th>产品总额</th>
				<th>已购买金额</th>
				<th>每份金额</th>
				<th>最小购买份数</th>
				<th>最大购买份数</th>
				<th>产品说明</th>
				<th>创建时间</th>
				<th>募集开始日</th>
				<th>募集结束日</th>
				<th>起息日</th>
				<th>到期日</th>
				<th>版本</th>
				<shiro:hasPermission name="loan:loan:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="loan">
				<tr>
					<td>
						${loan.productId}
					</td>
					<td style="text-align: left">
						<a href="javascript:openFW('产品详情', '${ctx}/loan/loan/view?id=${loan.productId}');">
							${loan.productName} 
						</a>
					</td>
		<%-- 			<td>
						${loan.productType}
					</td> --%>
					<td>
						 <c:if test="${loan.productStatus==100}">   
								待审核
						 </c:if>
						 <c:if test="${loan.productStatus==101}">   
								审核不通过
						 </c:if>
						 <c:if test="${loan.productStatus==200}">   
								募集中
						 </c:if>
						  <c:if test="${loan.productStatus==300}">   
								募集结束
						 </c:if>
						 <c:if test="${loan.productStatus==400}">   
								已起息
						 </c:if>
						 <c:if test="${loan.productStatus==500}">   
								已兑付
						 </c:if>
					</td>
					<td>
							${loan.interestRate}
					</td>
					<td>
							${loan.totalMoney}
					</td>
					<td>
						 	${loan.boughtMoney}
					</td>
					<td>
							${loan.eachUnitPrice}
					</td>
					
					<td>
							${loan.minimumUnits}
					</td>
					
					<td>
							${loan.maximumUnits}
					</td>
					
							
					<td>
							${loan.productComments}
					</td>
					
					<td>
						<fmt:formatDate value="${loan.publishTime}" pattern="yyyy-MM-dd"/>
					</td>
					
					<td>
						<fmt:formatDate value="${loan.collectionStartTime}" pattern="yyyy-MM-dd"/>
					</td>
					<td> 
						<fmt:formatDate value="${loan.collectionStopTime}" pattern="yyyy-MM-dd"/>
					</td>
					
					
					<td>
						<fmt:formatDate value="${loan.interestStartTime}" pattern="yyyy-MM-dd"/>
					</td>
					<td> 
						<fmt:formatDate value="${loan.interestEndTime}" pattern="yyyy-MM-dd"/>
					</td>
					
					<td>
							${loan.version}
					</td>
					<shiro:hasPermission name="loan:loan:edit">
						<td>
							<c:if test="${loan.productStatus==100}">
								<shiro:hasPermission name="loan:loan:audit">
									<a href="${ctx}/loan/loan/form?id=${loan.productId}&action=audit">审核</a>
								</shiro:hasPermission>
							</c:if>
							<c:if test="${loan.productStatus==101}">
								<shiro:hasPermission name="loan:loan:view">
									<a href="${ctx}/loan/loan/form?id=${loan.productId}&action=modifyByUnAudited">修改</a>
								</shiro:hasPermission>
							</c:if>
							<c:if test="${loan.productStatus>101}">
								<shiro:hasPermission name="loan:loan:view">
									<a href="${ctx}/loan/loan/form?id=${loan.productId}&action=modify">修改</a>
								</shiro:hasPermission>
							</c:if>
							 <c:if test="${loan.productStatus==400}"> 
							 	<shiro:hasPermission name="loan:loan:view">  
									<a href="${ctx}/loan/loan/pay?loanId=${loan.productId}">还款</a>
								</shiro:hasPermission>
							 </c:if>
							<a href="javascript:openFW('投资人列表', '${ctx}/loan/loan/queryBoughtRecordlist?loanId=${loan.productId}');">投资人列表</a>
						</td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>