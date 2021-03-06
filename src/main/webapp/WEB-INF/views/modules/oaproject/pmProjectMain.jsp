<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<script type="text/javascript">
		var listDescription = {};
		$(document).ready(function() {
			$.ajax({
				type : 'post',
				async:false,
				url : '${ctx}/customer/pmCustomerZtree/getCustomerZtree',
				dataType : 'json',
				success : function(data) {
					listDescription = data;
				},
				error : function(data) {
					alert("错误信息");
				}
			});
		});
	
		function getCustomerZtree(btn){
			var costTypeId = $(btn).val();
			var costType=$(btn).find("option:selected").val();
			$.each(listDescription[1], function(i, item) {
				if(item.id == costType){
					$("#projectIndustry").children("input").val(item.label);
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/oaproject/pmProjectMain/">单表列表</a></li>
		<li class="active"><a href="${ctx}/oaproject/pmProjectMain/form?id=${pmProjectMain.id}">单表查看</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="pmProjectMain" action="${ctx}/oaproject/pmProjectMain/save" method="post" class="form-horizontal">
		<table class="table-form">
			<tr>
				<td class="tit">项目名称</td>
				<td class="tit">${pmProjectMain.projectName}</td>
				<td class="tit">项目编号</td>
				<td class="tit">${pmProjectMain.projectId}</td>
			</tr>
			<tr>
				<td class="tit">项目类型</td>
				<td class="tit">${fns:getDictLabel(pmProjectMain.projectType,'project_class','')}</td>
				<td class="tit">关系群</td>
				<td class="tit">
					<c:forEach var="pmCustomerZtreeList" items="${pmCustomerZtreeList}">
						<c:if test="${pmProjectMain.projectCunstomer == pmCustomerZtreeList.id }">
							${pmCustomerZtreeList.name}
						</c:if>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td class="tit">项目行业</td>
				<td class="tit">${pmProjectMain.projectIndustry}</td>
				<td class="tit">项目阶段</td>
				<td class="tit">${fns:getDictLabel(pmProjectMain.projectStage,'project_stage','')}</td>
			</tr>
			<tr>
				<td class="tit">项目金额</td>
				<td class="tit">${pmProjectMain.projectMoney}</td>
				<td class="tit">办事处</td>
				<td class="tit">${fns:getDictLabel(pmProjectMain.projectStage,'project_stage','')}</td>
			</tr>
			<tr>
				<td class="tit">项目行业</td>
				<td class="tit">${pmProjectMain.projectIndustry}</td>
				<td class="tit">项目阶段</td>
				<td class="tit">${fns:getDictLabel(pmProjectMain.projectStage,'project_stage','')}</td>
			</tr>
		</table>
		
		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				<form:input path="projectName" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目类型：</label>
			<div class="controls">
				<form:select path="projectType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('project_class')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关系群：</label>
			<div class="controls">
				<select name=projectCunstomer class="myselect" onchange="getCustomerZtree(this)" style="width: 270px;">
					<c:forEach var="pmCustomerZtreeList" items="${pmCustomerZtreeList}">
						<option value="${pmCustomerZtreeList.id}">${pmCustomerZtreeList.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目行业：</label>
			<div class="controls" id="projectIndustry">
				<form:input path="projectIndustry" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目阶段：</label>
			<div class="controls">
				<form:select path="projectStage" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('project_stage')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目金额：</label>
			<div class="controls">
				<form:input path="projectMoney" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">办事处：</label>
			<div class="controls">
				<sys:treeselect id="projectAddress" name="projectAddress.id" value="${pmProjectMain.projectAddress.id}" labelName="projectAddress.name" labelValue="${pmProjectMain.projectAddress.name}" 
				title="办事处" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">项目概述：</label>
			<div class="controls">
				<form:textarea path="projectSummary" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>