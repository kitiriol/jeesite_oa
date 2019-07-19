<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default"/>
<title>报销管理</title>
	<script type="text/javascript">
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
		<li class="active"><a href="${ctx}/get/sale/">报销列表</a></li>
		 <li><a href="${ctx}/get/sale/listDraft">草稿列表</a></li>
		 <li><a href="${ctx}/get/sale/form">报销申请流程</a></li>
		 <shiro:hasAnyRoles name="seeEmployees,caiwuzhongnan">
			<li><a href="${ctx}/get/sale/CWSubList">员工报销列表</a></li>
		</shiro:hasAnyRoles>
		<shiro:hasAnyRoles name="xingzheng">
			<li class=""><a href="${ctx}/get/sale/getSaleList2">所属区域员工申请列表</a></li>
		</shiro:hasAnyRoles>
	</ul>
	<form:form id="searchForm" modelAttribute="getSale"
		action="${ctx}/get/sale/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	</form:form>	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>姓名</th><th>部门</th><th>标题</th><th>报销总金额</th><!-- <th>报销原因</th> --><th>申请时间</th><th>流程状态</th><th>附件</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="getSale">
			<tr>
				<td>${getSale.user.name}</td>
				<td>${getSale.office.name}</td>
				<td>${getSale.reason }</td>
				<td>
					<fmt:formatNumber type="number" value="${getSale.forMoney}" maxFractionDigits="2" pattern="#.00"/>元
				</td>
				<%--  <td>${getSale.reasonTitle}</td>  --%>
				<td><fmt:formatDate value="${getSale.createDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>
					<c:if test="${getSale.opt =='form1' }">
					<a href="${ctx}/get/sale/${getSale.opt}?id=${getSale.id}" style="color:red">请修改</a>
					</c:if>
					<c:if test="${getSale.opt !='form1' }">
					<a href="${ctx}/get/sale/${getSale.opt}?id=${getSale.id}">${getSale.statu}</a>
					</c:if>
				</td>
				<td>
					<c:if test="${getSale.address!=null }">
						<a href="${ctx}/get/sale/download?id=${getSale.id}">银行流水单下载</a>
					</c:if>
				</td>
				<td>
                    <a href="${ctx}/get/sale/${getSale.opt}?id=${getSale.id}">详情</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>