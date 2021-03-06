<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<style type="text/css">
		.ztree {overflow:auto;margin:0;_margin-top:10px;padding:10px 0 0 10px;}
	</style>
</head>
<body>
	<sys:message content="${message}"/>
	<div id="content" class="row-fluid">
		<div id="left" class="accordion-group">
			<div class="accordion-heading">
		    	<a class="accordion-toggle">客户信息<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
		    </div>
			<div id="ztree" class="ztree"></div>
		</div>
		<div id="openClose" class="close">&nbsp;</div>
		<div id="right">
			 <iframe id="customerContent" src="${ctx}/customer/mycustomerList" width="100%" height="91%" frameborder="0"></iframe> 
		</div>
	</div>
	<script >
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick,
			beforeClick: zTreeBeforeClick
		}
	};
	var zNodes = new Array();
	$.ajax({
		async: false,  
		type : "POST",  
		url : "${ctx}/customer/mycustomerajax",  
		dataType : 'json',  
		success : function(data) {
			 for(var i=0;i<data.length;i++){
				 zNodes.push({id:data[i].nodeCode,pId:data[i].parentId,name:data[i].nodeName,open:true});
			} 
		}  
	}); 
	function onClick(event, treeId, treeNode, clickFlag) {
		$('#customerContent').attr("src","${ctx}/customer/mycustomerList?ParentId="+treeNode.id);
	}
	function zTreeBeforeClick(treeId, treeNode, clickFlag) {
	    return (treeNode.pId == 1);
	};
	$(document).ready(function(){
		$.fn.zTree.init($("#ztree"), setting, zNodes);
	});
	</script>
	<script type="text/javascript">
	var leftWidth = 180; // 左侧窗口大小
	var htmlObj = $("html"), mainObj = $("#main");
	var frameObj = $("#left, #openClose, #right, #right iframe");
	function wSize(){
		var strs = getWindowSize().toString().split(",");
		htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
		mainObj.css("width","auto");
		frameObj.height(strs[0] - 5);
		var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
		$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
		$(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
	}
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>