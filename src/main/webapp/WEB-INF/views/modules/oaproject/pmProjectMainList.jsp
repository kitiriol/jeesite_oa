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
		<li class="active"><a href="${ctx}/oaproject/pmProjectMain/">项目列表</a></li>
		<li><a href="${ctx}/oaproject/pmProjectMain/form">项目添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmProjectMain" action="${ctx}/oaproject/pmProjectMain/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>项目名称：</label>
				<form:input path="projectName" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>项目名称</th>
				<th>项目阶段</th>
				<th>产品类型</th>
				<th>审核状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="pmProjectMain">
			<tr>
				<td><a href="${ctx}/oaproject/pmProjectMain/look?id=${pmProjectMain.id}">
					${pmProjectMain.projectName}
				</a></td>
				<td>${fns:getDictLabel(pmProjectMain.projectStage,'project_stage','')}</td>
				<td>${fns:getDictLabel(pmProjectMain.projectType,'project_class','')}</td>
				<td>
					<c:choose>
						<c:when test="${pmProjectMain.examine == '待审核'}">
							<a href="${ctx}/oaproject/pmProjectMain/examination?id=${pmProjectMain.id}">${pmProjectMain.examine}</a>
						</c:when>
						<c:otherwise>
							${pmProjectMain.examine}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
    				<a href="${ctx}/oaproject/pmProjectMain/form?id=${pmProjectMain.id}">修改</a>
					<a href="${ctx}/oaproject/pmProjectMain/delete?id=${pmProjectMain.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>