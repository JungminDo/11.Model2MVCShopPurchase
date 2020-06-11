<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncGetUserList(currentPage) {

		/* 	document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.submit();	 */	
		   	$("#currentPage").val(currentPage)
		   	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase?menu=${param.menu}").submit();
		}
	
	
	$(function() {
		 
		//==> �˻� Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
		
		//$( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			$( "button.btn.btn-default" ).on("click" , function() {
					fncGetUserList(1);
			});
		
			
		});
		
		 $(function() {
				
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "td:nth-child(2)" ).on("click" , function() {
					$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
					 
				});
							
				//==> userId LINK Event End User ���� ���ϼ� �ֵ��� 
				$( "td:nth-child(2)" ).css("color" , "red");
				
			});	
		

		 $(function() {
		//==> userId LINK Event ����ó��
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 �� 1 ��� ���� : $(".className tagName:filter�Լ�") �����.
		 	$( "td:nth-child(7) > i" ).on("click" , function() {
					//Debug..
					//alert($(this).children("#pdNo").val());
				/*  self.location="/product/getProduct?prodNo="+$(this).text().trim()+"&menu="+$("input[type='hidden'][name='menu']").val(); */
				// 	self.location ="/product/getProduct?prodNo="+$(this).children("#pdNo").val()+"&menu=<c:out value="${param.menu}" />";
		 
			
		 	//var prodNo = $(this).children("#prodNo").val();
			var userId = $(this).next().val();
		 	$.ajax( 
					{
						url : "/user/json/getUser/"+userId ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {
							
							
							//Debug...
							//alert(status);
							//Debug...
							//alert("JSONData : \n"+JSONData);
							
							var displayValue = "<h6>"
								+"���̵� : "+JSONData.userId+"<br/>"
								+"��  �� : "+JSONData.userName+"<br/>"
								+"�̸��� : "+JSONData.email+"<br/>"
								+"����� : "+JSONData.role+"<br/>"
								+"����� : "+JSONData.regDate+"<br/>"
								+"</h6>";
							$("h6").remove();
							$( "#"+userId+"" ).html(displayValue);
					}
				});
		 	});
		
			//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			
			//==> �Ʒ��� ���� ������ ������ ??
			//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");

	});	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	

	    
	    <div class="page-header text-info">
		<%-- <c:if test="${param.menu=='search'}"> --%>
	       <h3>��ǰ���Ÿ��</h3>
	      <%--  </c:if> --%>
	    </div>
	    
	    
	    
	    
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>�����ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>������̸�</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ȣ</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >�����ID</th>
            <th align="left">������̸�</th>
            <th align="left">��ȭ��ȣ</th>
            <th align="left">��ۻ���</th>
            <th align="left">������</th>
            <th align="left">���������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />s
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" >${ i }</td>
			  <td align="left"  title="Click : ��������� Ȯ��">
			 
				${user.userId}
				
			</td>	
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
			  <c:if test="${!empty purchase.tranCode}"> </c:if>
			<c:if test="${(purchase.tranCode)=='0'}"> ���� ������ �Դϴ�. </c:if>
			<c:if test="${(purchase.tranCode)=='1'}"> ���� ���ſϷ� �Դϴ�. </c:if>
			<c:if test="${(purchase.tranCode)=='2'}"> ���� ��� �� �Դϴ�. </c:if>
			<c:if test="${(purchase.tranCode)=='3'}"> ���� ��ۿϷ� �Դϴ�. </c:if>
			  
			  

			  	<c:choose>
			<c:when test="${product.proTranCode=='0'}">
				�Ǹ���
			</c:when>
			
			<c:when test="${param.menu=='manage'}">
				<c:if test="${product.proTranCode=='1  '}">
					<!-- ���ſϷ� <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
					 -->
					 ����ϱ�
				</c:if>
				<c:if test="${product.proTranCode=='2  '}">
					�����
				</c:if>
				<c:if test="${product.proTranCode=='3  '}">
					��ۿϷ�
				</c:if>			
			</c:when>
			
			<c:when test="${param.menu=='search' && user.role=='admin'}">
				<c:if test="${product.proTranCode=='1  '}">
					���ſϷ�
				</c:if>
				<c:if test="${product.proTranCode=='2  '}">
					�����
				</c:if>
				<c:if test="${product.proTranCode=='3  '}">
					��ۿϷ�
				</c:if>	
			</c:when>
			
			<c:otherwise>
			<td>	������    </td>
			</c:otherwise>
			
		</c:choose>
		<td> ���������
			  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
			  	
			 </td>
		
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>