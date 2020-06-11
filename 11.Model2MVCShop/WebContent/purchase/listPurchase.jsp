<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
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
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
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
		 
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		
		//$( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			$( "button.btn.btn-default" ).on("click" , function() {
					fncGetUserList(1);
			});
		
			
		});
		
		 $(function() {
				
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "td:nth-child(2)" ).on("click" , function() {
					$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
					 
				});
							
				//==> userId LINK Event End User 에게 보일수 있도록 
				$( "td:nth-child(2)" ).css("color" , "red");
				
			});	
		

		 $(function() {
		//==> userId LINK Event 연결처리
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 3 과 1 방법 조합 : $(".className tagName:filter함수") 사용함.
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
								+"아이디 : "+JSONData.userId+"<br/>"
								+"이  름 : "+JSONData.userName+"<br/>"
								+"이메일 : "+JSONData.email+"<br/>"
								+"사용자 : "+JSONData.role+"<br/>"
								+"등록일 : "+JSONData.regDate+"<br/>"
								+"</h6>";
							$("h6").remove();
							$( "#"+userId+"" ).html(displayValue);
					}
				});
		 	});
		
			//==> UI 수정 추가부분  :  userId LINK Event End User 에게 보일수 있도록 
			$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
			$("h7").css("color" , "red");
			
			
			//==> 아래와 같이 정의한 이유는 ??
			//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
			$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");

	});	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	

	    
	    <div class="page-header text-info">
		<%-- <c:if test="${param.menu=='search'}"> --%>
	       <h3>상품구매목록</h3>
	      <%--  </c:if> --%>
	    </div>
	    
	    
	    
	    
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>사용자ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>사용자이름</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>번호</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >사용자ID</th>
            <th align="left">사용자이름</th>
            <th align="left">전화번호</th>
            <th align="left">배송상태</th>
            <th align="left">재고상태</th>
            <th align="left">사용자정보</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />s
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center" >${ i }</td>
			  <td align="left"  title="Click : 사용자정보 확인">
			 
				${user.userId}
				
			</td>	
			  <td align="left">${purchase.receiverName}</td>
			  <td align="left">${purchase.receiverPhone}</td>
			  <td align="left">
			  <c:if test="${!empty purchase.tranCode}"> </c:if>
			<c:if test="${(purchase.tranCode)=='0'}"> 현재 구매전 입니다. </c:if>
			<c:if test="${(purchase.tranCode)=='1'}"> 현재 구매완료 입니다. </c:if>
			<c:if test="${(purchase.tranCode)=='2'}"> 현재 배송 중 입니다. </c:if>
			<c:if test="${(purchase.tranCode)=='3'}"> 현재 배송완료 입니다. </c:if>
			  
			  

			  	<c:choose>
			<c:when test="${product.proTranCode=='0'}">
				판매중
			</c:when>
			
			<c:when test="${param.menu=='manage'}">
				<c:if test="${product.proTranCode=='1  '}">
					<!-- 구매완료 <a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">배송하기</a>
					 -->
					 배송하기
				</c:if>
				<c:if test="${product.proTranCode=='2  '}">
					배송중
				</c:if>
				<c:if test="${product.proTranCode=='3  '}">
					배송완료
				</c:if>			
			</c:when>
			
			<c:when test="${param.menu=='search' && user.role=='admin'}">
				<c:if test="${product.proTranCode=='1  '}">
					구매완료
				</c:if>
				<c:if test="${product.proTranCode=='2  '}">
					배송중
				</c:if>
				<c:if test="${product.proTranCode=='3  '}">
					배송완료
				</c:if>	
			</c:when>
			
			<c:otherwise>
			<td>	재고없음    </td>
			</c:otherwise>
			
		</c:choose>
		<td> 사용자정보
			  	<i class="glyphicon glyphicon-ok" id= "${user.userId}"></i>
			  	<input type="hidden" value="${user.userId}">
			  	
			 </td>
		
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>

</html>