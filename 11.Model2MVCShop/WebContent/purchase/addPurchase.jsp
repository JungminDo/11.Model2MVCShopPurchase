<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="EUC-KR">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
       body > div.container{
        	border: 3px solid #D6CDB7;
            margin-top: 10px;
        }
    </style>
	<script type="text/javascript">
	
	
	 $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				self.location = "/product/listProduct?menu=search"
			});
		});	
	
	
	
	
	
	</script>
</head>

<body>
<div class="navbar  navbar-default">
        <div class="container">
        		<jsp:include page="/layout/toolbar.jsp" />
   		</div>
   	</div>
<div class="container">
<h1 class="bg-primary text-center">구매확인</h1>
<form class="form-horizontal">
<div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control"  value ="${purchase.purchaseProd.prodNo}" readonly >
		  	<!-- <span id="helpBlock" class="help-block"></span> --> 
		    </div>
		   
		  </div>
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">구매자아이디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control"  placeholder="${purchase.buyer.userId}" readonly >
		
		    </div>
		   
		  </div>
		  
	
		   <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-4">
		     
				<input type="text" class="form-control"  value="<c:if test="${fn:trim(purchase.paymentOption)=='0'}">현금구매 </c:if>" readonly >
		  
		    </div>
		  </div>
		  
		
		  <div class="form-group">
		    <label for=receiverName class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="${purchase.receiverName}"readonly>
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">전화번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="${purchase.receiverPhone}"readonly>	
		    </div>
		  </div> 
		  
		 <div class="form-group">
		    <label for=divyAddr class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="${purchase.divyAddr}"readonly>
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for=divyRequest class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="${purchase.divyRequest}"readonly>
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for=divyDate class="col-sm-offset-1 col-sm-3 control-label">배송날짜</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyDate" placeholder="${purchase.divyDate}"readonly>
		    </div>
		  </div>




	  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >확 &nbsp;인</button>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>





<!-- 
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
					<a href="/listPurchase.do?">확인</a>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				</tr>
				</table>
</form>
 -->
</body>
</html>