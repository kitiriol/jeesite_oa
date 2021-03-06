<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oaproject/pmProjectFeedback/">单表列表</a></li>
		<li><a href="${ctx}/oaproject/pmProjectFeedback/form">单表添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmProjectFeedback" action="${ctx}/oaproject/pmProjectFeedback/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>任务名称</th>
				<th>反馈时间</th>
				<th>进展说明</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="pmProjectFeedback">
			<tr>
				<td><a href="${ctx}/oaproject/pmProjectFeedback/form?id=${pmProjectFeedback.id}">
					${pmProjectFeedback.taskName}
				</a></td>
				<td>
					<fmt:formatDate value="${pmProjectFeedback.feedbackTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${pmProjectFeedback.progress}</td>
				<td>
    				<a href="${ctx}/oaproject/pmProjectFeedback/form?id=${pmProjectFeedback.id}">修改</a>
					<a href="${ctx}/oaproject/pmProjectFeedback/delete?id=${pmProjectFeedback.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>