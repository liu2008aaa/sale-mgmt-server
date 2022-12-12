<%@ page import="com.msyd.common.enums.PromotionTypeEnum" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>促销</title>
  <script src="/static/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
  <script src="/static/jquery-ui/jquery-ui.js"></script>
  <link href="/static/jquery-ui/jquery-ui.css" rel="stylesheet">
  <%--<link href="http://jqueryui.com/resources/demos/style.css" rel="stylesheet">--%>
</head>
<body>
  <c:forEach items="<%=PromotionTypeEnum.values()%>" var="p" varStatus="s">
    <div id="accordion" style='font: 62.5% "Trebuchet MS", sans-serif;margin: 50px;'>
      <h3><input id="check${s.index}" name="${p.NAME }" type="checkbox" value="${p.TYPE }"/>${p.NAME }</h3>
      <div>${p.DESC}</div>
    </div>
  </c:forEach>
<%--  <input type="checkbox" id="check"><label for="check">Toggle</label>
  <div id="format">
    <input type="checkbox" id="check2"><label for="check2">I</label>
    <input type="checkbox" id="check3"><label for="check3">U</label>
  </div>--%>
</body>

<script type="application/javascript">
/*  $("[id*='check']").button({ text: false }).click(function( event ) {
    event.preventDefault();
  });
  $("#format" ).buttonset();*/
  $("#accordion" ).accordion();

  $("h3").click(function(){
    $("#check0").attr("checked", !$("#check0").attr("checked"));
  })
</script>
</html>
