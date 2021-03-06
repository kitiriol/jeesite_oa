<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<title>证照管理</title>
</head>
<body>
	<ul class="nav nav-tabs" id="list">
		<li class="active"><a href="">印章刻制列表</a></li>
		<li><a href="${ctx}/tb/signet/toAdd">印章刻制申请流程</a></li>
		<shiro:hasRole name="caiwuzhongnan">
		<li><a href="${ctx}/tb/signet/employeesList">员工印章刻制列表</a></li>
		</shiro:hasRole>
		<shiro:hasRole name="xingzheng">
			<li class=""><a href="${ctx}/tb/signet/list2">所属区域员工印章刻制列表</a></li>
		</shiro:hasRole>
	</ul>	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
			<th>申请人</th>
			<th>申请日期</th>
			<th>刻制印章名称</th>
			<th>流程状态</th>
			<th>操作</th>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="signet">
			<tr>
				<td>${signet.user.name}</td>
				<td><fmt:formatDate value="${signet.applyDate }" type="both" pattern="yyyy-MM-dd"/></td>
				<td>
					${signet.signetName }
				</td>
				<td>${signet.statu}</td>
				<td>
				<c:choose>
					<c:when test="${signet.statu=='驳回' }">
	                    <a href="${ctx}/tb/signet/toAdd?id=${signet.id}">详情</a>
					</c:when>
					<c:otherwise>
						<a href="${ctx}/tb/signet/form?id=${signet.id}">详情</a>
					</c:otherwise> 
				</c:choose>
				<c:if test="${empty signet.proneText and empty signet.prtwoText}">
				<a href="${ctx }/tb/roll/withdraw?id=${signet.id }&tableName=tb_signet&view=signet">撤回</a>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>