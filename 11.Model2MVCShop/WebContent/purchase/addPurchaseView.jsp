<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
		//============= "����"  Event ���� =============
		 $(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$( "button.btn.btn-primary" ).on("click" , function() {
				fncAddPurchase();
			});
		});	
		
		
		//============= "���"  Event ó�� ��  ���� =============
		$(function() {
			//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			$("a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
		});	
	
		
		
	
		function fncAddPurchase() {
			
			var paymentOption = $("input[name='paymentOption']").val();
			var receiverName = $("input[name='receiverName']").val();
			var receiverPhone = $("input[name='receiverPhone']").val();	
			var divyAddr = $("input[name='divyAddr']").val();
			
			
			
		
		if(receiverName == null || receiverName.length <1){
				alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
				return;
		}
			
			
/* 		var value = "";	
		if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-" 
								+ $("input[name='phone2']").val() + "-" 
								+ $("input[name='phone3']").val();
		}

		$("input:hidden[name='phone']").val( value ); */
		
		
			$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
		}
		
function execDaumPostcode() {
			
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	
	                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
	
	                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
	                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
	                var fullAddr = ''; // ���� �ּ� ����
	                var extraAddr = ''; // ������ �ּ� ����
	
	                // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
	                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
	                    fullAddr = data.roadAddress;
	
	                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
	                if(data.userSelectedType === 'R'){
	                    //���������� ���� ��� �߰��Ѵ�.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // �ǹ����� ���� ��� �߰��Ѵ�.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
	                document.getElementById('postcode').value = data.zonecode; //5�ڸ� �������ȣ ���
	                document.getElementById('divyAddr').value = fullAddr;
	
	                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
	                document.getElementById('divyAddr_detail').focus();
	            },
	        
	            theme: {
	    	 		bgColor: "#ECECEC", //���� ����
	    	 		searchBgColor: "#0B65C8", //�˻�â ����
	    	 		contentBgColor: "#FFFFFF", //���� ����(�˻����,��l������,ùȭ��,�˻�������Ʈ)
	    	 		pageBgColor: "#FAFAFA", //������ ����
	    	 		textColor: "#333333", //�⺻ ���ڻ�
	    	 		queryTextColor: "#FFFFFF", //�˻�â ���ڻ�
	    	 		postcodeTextColor: "#FA4256", //�����ȣ ���ڻ�
	    	 		emphTextColor: "#008BD3", //���� ���ڻ�
	    	 		outlineColor: "#E0E0E0" //�׵θ�
	    		}   
            
	        }).open();
	    }


		
	</script>		
    
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        		<jsp:include page="/layout/toolbar.jsp" />
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->

	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">��������</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" value ="${product.prodNo}" readonly >
		  	<!-- <span id="helpBlock" class="help-block"></span> --> 
		    </div>
		   
		  </div>
		   <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">��ǰ��</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="${product.prodName}" readonly >
		
		    </div>
		   
		  </div>
		   <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="${product.prodDetail}" readonly >
		
		    </div>
		   
		  </div>
		   <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="${product.manuDate}" readonly >
		
		    </div>
		   
		  </div>
		  
		    <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" value="${product.price}" readonly >
	
		    </div>
		   
		  </div>
		  
		  <div class="form-group">
		    <label for="regDate" class="col-sm-offset-1 col-sm-3 control-label">�����</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="regDate" name="regDate" value="${product.regDate}" readonly >
		
		    </div>
		   
		  </div>
		  
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�����ھ��̵�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="${user.userId}" readonly >
		  	
		    </div>
		   
		  </div>
		  
		  <div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
		     <div class="col-sm-3">
		      <select class="form-control" name="paymentOption" id="paymentOption">
				  	<option value="0" >���ݱ���</option>
					<option value="1" >�ſ뱸��</option>
					<option value="2" >QR�ڵ屸��</option>
					<option value="3" >App����</option>
					
				</select>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for=receiverName class="col-sm-offset-1 col-sm-3 control-label">�������̸�</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�������̸�">
		    </div>
		  </div>
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">��ȭ��ȣ</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="��ȭ��ȣ">	
		    </div>
		  </div> 
		  
		  
		   <div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="receiverPhone" id="receiverPhone">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="012" >012</option>
					<option value="063" >063</option>
					
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="receiverPhone2" name="receiverPhone2" placeholder="��ȣ">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="receiverPhone3" name="receiverPhone3" placeholder="��ȣ">
		    </div>
		    <input type="hidden" name="receiverPhone"  />
		  </div>
		
		  
		  
		  
		  <div class="form-group">
		  
		  
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">�������ּ�</label>
		    <div class="col-sm-2">
		    <input type="button" onclick="execDaumPostcode()" value="�����ȣ ã��" readonly="readonly" ><br/>
		       <input type="text" class="form-control" id="postcode" placeholder="�����ȣ" readonly="readonly"  > 
		     	
		   </div>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="�ּ��Է�">
		       <input type="text" class="form-control" id="divyAddr_detail" name="divyAddr_detail" placeholder="���ּ�">
		    </div>
		    </div>
		    </div>
		    
		 
		  </div>
		
		  
		  
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >�� &nbsp;��</button>
			  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  ȭ�鱸�� div end /////////////////////////////////////-->
	
</body>

</html>