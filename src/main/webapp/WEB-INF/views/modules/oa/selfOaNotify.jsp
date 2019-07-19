<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>通知管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {
				$("[for='status1']").css("display", "none");
				//$("#name").focus();
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script>
<style type="text/css">
#status1 {
	display: none
}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">通知
				</li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="oaNotify"
		action="${ctx}/oa/oaNotify/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('oa_notify_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="content" htmlEscape="true" path="content"
					rows="4" maxlength="200" class="input-xxlarge" />
				<sys:ckeditor replace="content" uploadPath="/oa/oaNotify/" />
			</div>
		</div>
		
		<c:if test="${oaNotify.status eq '1'}">

		<div class="control-group">
			<label class="control-label">历史附件：</label>
			<div class="controls">
				<c:forEach items="${filelist}" var="fileModel">
					<a href="${ctx}/oa/weekly/download3?fileid=${fileModel.id}">${fileModel.name}</a> &nbsp;&nbsp;&nbsp;&nbsp;
					<br>
				</c:forEach>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">接受人：</label>
				<div class="controls">
					<table id="contentTable"
						class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>接受人</th>
								<th>接受部门</th>
								<th>阅读状态</th>
								<th>阅读时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${oaNotify.oaNotifyRecordList}"
								var="oaNotifyRecord">
								<tr>
									<td>${oaNotifyRecord.user.name}</td>
									<td>${oaNotifyRecord.user.office.name}</td>
									<td>${fns:getDictLabel(oaNotifyRecord.readFlag, 'oa_notify_read', '')}
									</td>
									<td><fmt:formatDate value="${oaNotifyRecord.readDate}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					已查阅：${oaNotify.readNum} &nbsp; 未查阅：${oaNotify.unReadNum} &nbsp;
					总共：${oaNotify.readNum + oaNotify.unReadNum}
				</div>
			</div>
		</c:if>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
<script type="text/javascript" defer="defer">
	if (document.readyState == "complete") {
		var content = $("#oaNotify").val();
		alert("content" + content);
		$("#content").html(content);
	}
</script>
</html>