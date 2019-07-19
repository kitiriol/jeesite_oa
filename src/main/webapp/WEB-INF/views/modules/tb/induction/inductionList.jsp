<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<title>录用/转正管理</title>
</head>
<body>
	<ul class="nav nav-tabs" id="list">
		<li class="active"><a href="">录用列表</a></li>
		<li><a href="${ctx}/tb/induction/toAdd">录用申请</a></li>
		<shiro:hasRole name="caiwu">
		<li class="active"><a href="${ctx}/tb/induction/list3">员工录用列表</a></li>
		</shiro:hasRole>
		<shiro:hasAnyRoles name="xingzheng">
			<li class=""><a href="${ctx}/tb/induction/list2">所属区域员工录用列表</a></li>
		</shiro:hasAnyRoles>
	</ul>	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
			<th>录用人姓名</th>
			<th>录用部门</th>
			<th>录用岗位</th>
			<th>联系电话</th>
			<th>到岗日期</th>
			<th>流程状态</th>
			<th>操作</th>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="induction">
		<tr>
			<td>${induction.employedName }</td>
			<td>${induction.employedOffice.name }</td>
			<td>${induction.employedJob }</td>
			<td>${induction.phone }</td>
			<td><fmt:formatDate value="${induction.workDate }" type="both" pattern="yyyy-MM-dd"/></td>
			<td>${induction.statu }</td>
			<td>
				<c:choose>
				<c:when test="${induction.statu=='驳回' }">
                    <a href="${ctx}/tb/induction/toAdd?id=${induction.id}">详情</a>
				</c:when>
				<c:otherwise>
					<a href="${ctx}/tb/induction/form?id=${induction.id}">详情</a>
				</c:otherwise>
				</c:choose>
				<c:if test="${empty induction.proneText and empty induction.prthreeText and empty induction.prfourText and empty induction.prfiveText}">
				<a href="${ctx }/tb/roll/withdraw?id=${induction.id }&tableName=tb_induction&view=induction">撤回</a>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>