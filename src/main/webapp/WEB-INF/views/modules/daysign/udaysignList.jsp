<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>签到管理</title>
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

	$(function() {
		$("#btn1").click(function() {
			$.ajax({
				url : "${ctx}/daysign/udaysign/save",
				type : "post",
				dataType : "json",
				data : "",
				success : function(data) {
					if (data == false) {
						alert("不能重复打卡！");
					} else {
						alert("打卡成功！");
						$(location).attr('href', '${ctx}/daysign/udaysign/');
					}
				},
				error : function() {
					alert("error!!!");
				}

			});

		});

		$("#btn2").click(function() {
			$.ajax({
				url : "${ctx}/daysign/udaysign/update",
				type : "post",
				dataType : "json",
				data : "",
				success : function(data) {
					if (data == 0) {//0签到正常，1不能重复签到，2不在签到范围,3今日未签到不能签退
						alert("签退成功！");
						$(location).attr('href', '${ctx}/daysign/udaysign/');
					}
					if (data == 1) {
						alert("不能重复签退！");
					}
					if (data == 3) {
						alert("今日未签到不能签退！");
					}

				},
				error : function() {
					alert("error!!!");
				}

			});

		});

	});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li style="font-size: 15px"><a href="${ctx}/daysign/udaysign/">个人签到</a></li>
	</ul>
	<br />

	<form:form id="searchForm" modelAttribute="udaysign"
		action="${ctx}/daysign/udaysign/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			
			<li><label>状态：</label> <form:select path="state"
					class="input-medium">
					<form:option value="" label="" />
					<form:option value="0" label="正常" />
					<form:option value="1" label="迟到" />
					<form:option value="2" label="早退" />

				</form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed"
		style="width: 70%">
		<thead>
			<tr>
				<th>用户ID</th>
				<th>用户名</th>
				<th>ip地址</th>
				<th>签到状态</th>
				<th>签到时间</th>
				<th>签退时间</th>
				<th>签退状态</th>
				<th>备注</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="udaysign">
				<tr>
					<td>${udaysign.user.name}</td>
					<td>${udaysign.name}</td>
					<td>${udaysign.ip}</td>
					<c:if test="${udaysign.state eq 0}">
						<td>正常</td>
					</c:if>
					<c:if test="${udaysign.state eq 1}">
						<td>迟到</td>
					</c:if>
					<td><fmt:formatDate value="${udaysign.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				    <td><fmt:formatDate value="${udaysign.end}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<c:if test="${udaysign.endState eq 4}">
						<td>早退</td>
					</c:if>
					<c:if test="${udaysign.endState eq 0}">
						<td>正常</td>
					</c:if>
					<c:if test="${udaysign.endState eq null}">
						<td></td>
					</c:if>
							
					<td>${udaysign.remarks}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<input id="btn1" class="btn btn-primary" type="button"
		style="float: right; margin-right: 20%; margin-top: -40px;" value="签到" />
	<input id="btn2" class="btn btn-primary" type="button"
		style="float: right; margin-right: 10%; margin-top: -40px;" value="签退" />
	<div class="pagination">${page}</div>
</body>
</html>