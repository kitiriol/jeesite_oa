<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">客户详情</a></li>
		<li><a href="${ctx}/customer/customerAnalysisDetail?customerId=${customerId}&customerName=${customerName}">客户分析</a></li>
	</ul><br/>
	<div style="text-align: center"><span style="font-size: 24px;color: blue">客户详情</span></div>
	<span style="font-size: 14px">基本信息</span>
	<form action="${ctx }/customer/customerInfoSave" method="post" class="form-horizontal">
		<table class="table-form">
			<tr>
				<td class="tit">客户姓名</td>
				<td>
					<input name="customerName" value="${customerInfo.customerName }" type="text" readonly="readonly">
				</td>
				<td class="tit">部门</td>
				<td>
					<select name='parentId' id="'parentId'" class="input-xlarge required" disabled="disabled">
						<c:forEach  items="${ztreeInfoList}" var="item"  >
					      <c:if test="${item.parentId == customerInfo.parentId}">
					       	<option value="${item.parentId}" selected>${item.nodeName }</option>
					   	  </c:if>
					    </c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="tit">就职单位</td>
				<td>
					<input name="company" value="${customerInfo.company }" type="text" readonly="readonly">
				</td>
				<td class="tit">职位</td>
				<td>
					<input name="position" value="${customerInfo.position }" type="text" readonly="readonly">
				</td>			
			</tr>
			<tr>
				<td class="tit">性别</td>
				<td>
					<select name="sex" style="width: 220px" disabled="disabled">
						<c:if test="${customerInfo.sex == 1}">
							<option>---请选择---</option>
							<option value="1" selected="selected">男</option>
							<option value="0">女</option>
						</c:if>
						<c:if test="${customerInfo.sex == 0}">
							<option>---请选择---</option>
							<option value="1">男</option>
							<option value="0" selected="selected">女</option>
						</c:if>
					</select>
				</td>
				<td class="tit">兴趣爱好</td>
				<td>
					<input name="hobby" value="${customerInfo.hobby }" type="text" readonly="readonly"> 
				</td>
			</tr>
			<tr>
				<td class="tit">联系电话</td>
				<td>
					<input name="phone" value="${customerInfo.phone }" type="text" readonly="readonly">
				</td>
				<td class="tit">联系地址</td>
				<td>
					<input name="adress" value="${customerInfo.adress }" type="text" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td class="tit">出生日期</td>
				<td>
					<input name="customerBrithday" type="text" readonly="readonly" value="${customerInfo.customerBrithday }" maxlength="20" class="Wdate required"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</td>
			</tr>
			<tr>
				<td class="tit">备注</td>
				<td colspan="3">
					<textarea name="remarks" rows="6" style="width: 1080px" readonly="readonly">${customerInfo.remarks }</textarea>
				</td>
			</tr>
		</table><br/>
		
		<div style="text-align: left;float: left;">
			<span style="font-size: 14px">履&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历</span>
		</div>
		<!-- 
		<div style="text-align: right;float: right;">
			<input type="button" id="btnAdd" class="btn btn-primary" value="添加" onclick="addResume()" />
		</div>
		 -->
		<table class="table-form">
		<thead>
			<tr>
				<td class="tit">单位名称</td>
				<td class="tit">职位名称</td>
				<td class="tit">任职时间</td>
				<!--  <td class="tit">操作</td>-->
			</tr>
		</thead>
		<tbody id="resume">
		<c:forEach items="${resumeList }" var="resume">
			<tr>
				<td class="tit">
					<input name="customerCompany" value="${resume.customerCompany }" type="text" readonly="readonly">
				</td>
				<td class="tit">
					<input name="customerPosition" value="${resume.customerPosition }" type="text" readonly="readonly">
				</td>
				<td class="tit">
					<input name="positionTime" value="${resume.positionTime }" type="text" readonly="readonly">
				</td>
				<!--  
				<td class="tit">
					<a href="#">修改</a>
					<a href="#" onclick="return confirmx('确认要删除该条履历吗？', this.href)">删除</a>
					<a href="#">更多</a>
				</td>
				-->
			</tr>
		</c:forEach>
		</tbody>
		</table><br/>	
		
		<div style="text-align: left;float: left;">
			<span style="font-size: 14px">社会关系</span>
		</div>
		<!--  
		<div style="text-align: right;float: right;">
			<input type="button" id="btnAdd" class="btn btn-primary" value="添加" onclick="addFamily()" />
		</div>
		-->
		<table class="table-form">
		<thead>
			<tr>
				<td class="tit">姓名</td>
				<td class="tit">出生日期</td>
				<td class="tit">关系</td>
				<!--<td class="tit">操作</td>  -->
			</tr>
		</thead>
		<tbody id="family">
		<c:forEach items="${familyList }" var="family">
			<tr>
				<td class="tit">
					<input name="familyName" value="${family.familyName }" type="text" readonly="readonly">
				</td>
				<td class="tit">
					<input name="familyBirthday" type="text" readonly="readonly" value="${family.familyBrithday }" maxlength="20" class="Wdate required"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</td>
				<td class="tit">
					<input name="relationship" value="${family.relationship }" type="text" readonly="readonly">
				</td>
				<!--  
				<td class="tit">
					<a href="#">修改</a>
					<a href="#" onclick="return confirmx('确认要删除该家庭成员信息吗？', this.href)">删除</a>
					<a href="#">更多</a>
				</td>-->
			</tr>
		</c:forEach>
		</tbody>
		</table><br/>
		
		<!-- 
		<div style="text-align: center;">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		-->
	</form>
	
	<script type="text/javascript">
	function addFamily() {
		htmlstr = '<tr>'
			+'<td class="tit"><input name="familyName" type="text"></td>'
			+'<td class="tit">'
			+'<input id="familyBrithday" name="familyBrithday" type="text" readonly="readonly" maxlength="20" class="Wdate required"'
			+'onclick="WdatePicker({dateFmt:"yyyy-MM-dd",isShowClear:false})"/></td>'
			+'<td class="tit"><input name="relationship" type="text"></td>'
			+'<td class="tit">'
			+'<a href="#">修改</a>'
			+'<a href="#" onclick="return confirmx("确认要删除该条履历吗？", this.href)">删除</a>'
			+'<a href="#">更多</a></td>'
			+'</tr>';
		$("#family").append(htmlstr);
	}
	
	function addResume() {
		htmlstr = '<tr>'
			+'<td class="tit"><input name="customerCompany" type="text"></td>'
			+'<td class="tit"><input name="customerPosition" type="text"></td>'
			+'<td class="tit"><input name="positionTime" type="text"></td>'
			+'<td class="tit">'
			+'<a href="#">修改</a>'
			+'<a href="#" onclick="return confirmx("确认要删除该条履历吗？", this.href)">删除</a>'
			+'<a href="#">更多</a></td>'
			+'</tr>';
		$("#resume").append(htmlstr);
	}
	</script>
</body>
</html>