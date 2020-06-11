package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	public ProductController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	@RequestMapping(value = "addProductView")
	public String addUserView() throws Exception {

		System.out.println("/product/addProductView");

		return "redirect:/product/addProductView.jsp";
	}

	@RequestMapping(value = "addProduct", method = RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct: GET");

		return "redirect:/product/addProduct.jsp";
	}
/*
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/addProduct:POST");
		productService.addProduct(product);

		return "forward:/product/addProduct.jsp";
	}
*/
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product, @RequestParam(value="file", required = false) MultipartFile mf , HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("/product/addProduct : POST");
		
		if(mf != null) {
			System.out.println("fileName : "+ mf); //이게 위에서 멀티파일로 가져온 파일이름
			System.out.println(product);
			
			//이게 파일 넣을 위치 C 밑에 프로젝트 밑에 웹텐츠 밑에 이미지파일 밑에 업로드파일 안에 넣는다는 뜻
			String savePath = "C:\\workspace\\11.Model2MVCShopPurchasego\\WebContent\\images\\";
			
			String originalFileName = mf.getOriginalFilename();
			long fileSize = mf.getSize(); //파일 크기
			String safeFile = savePath+originalFileName; //파일 넣을 위치랑 파일 이름
			
			System.out.println("originalFileName : "+originalFileName); //이게 파일본래 이름
			System.out.println("fileSize : "+fileSize);
			System.out.println("safeFile : "+safeFile);
			
				
			try {
				mf.transferTo(new File(safeFile)); //이게 파일 넣는거
			} catch(IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			product.setFileName(originalFileName);
		
		}
		productService.addProduct(product);
		
		
		
		return "forward:/product/addProduct.jsp";
	}
	
	
	@RequestMapping(value = "getProduct", method = RequestMethod.GET)
	public String getProduct(Product product, Model model) throws Exception {

		System.out.println("/product/getProduct : GET");

		Product getProduct = productService.getProduct(product.getProdNo());
		model.addAttribute("product", getProduct);
		System.out.println("상품커트롤2" + getProduct);

		return "forward:/product/getProduct.jsp";

		/*
		 * Product getProduct = productService.getProduct(product.getProdNo());
		 * model.addAttribute("product", getProduct);
		 * System.out.println("상품커트롤2"+product);
		 * 
		 * 
		 * return "forward:/product/getProduct.jsp";
		 * 
		 */
	}

	@RequestMapping(value = "updateProductView")
	public String updateProductView(Product product, Model model) throws Exception {

		System.out.println("/product/updateProductView : GET ");
		Product getProduct = productService.getProduct(product.getProdNo());
		System.out.println("상품업데이트뷰" + getProduct);
		model.addAttribute("product", getProduct);

		return "forward:/product/updateProductView.jsp";
	}

	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/updateProduct : POST");
		productService.updateProduct(product);

		return "forward:/product/getProduct.jsp";

	}

	@RequestMapping(value = "listProduct")
	public String listProduct(@ModelAttribute("search") Search search,

			Model model, HttpServletRequest request) throws Exception {

		System.out.println("/product/listProduct");
		// System.out.println("여기가 메뉴"+menu);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = productService.getProductList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println("페이지" + resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/product/listProduct.jsp";
	}

	/*
	@RequestMapping(value="/addProduct",method=RequestMethod.POST)
	public String addProduct(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		System.out.println("/product/addProduct : POST");
		
		if(FileUpload.isMultipartContent(request)) {
			String temDir ="C:\\Users\\wjddb\\git\\mvcMINIPJT\\01.Model2MVCShop(stu)\\WebContent\\images\\uploadFiles";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setSizeMax(1024*1024*10);
			fileUpload.setSizeThreshold(1024*100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				Product prod = new Product();
				
				StringTokenizer token = null;
				
				java.util.List fileItemList = fileUpload.parseRequest(request);
				int Size = fileItemList.size();
				for(int i =0; i<Size;i++) {
					FileItem fileItem = (FileItem)fileItemList.get(i);
					
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"),"-");
							System.out.println("\n!!!!!"+token+"\n");
							String manuDate = token.nextToken()+token.nextToken()+token.nextToken();
							prod.setManuDate(manuDate);
							System.out.println("\n!!!!!!!!"+manuDate);
						}else if(fileItem.getFieldName().equals("prodName"))
							prod.setProdName(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("prodDetail"))
							prod.setProdDetail(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("price"))
							prod.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
					}else {
						if(fileItem.getSize()>0) {
							int idx=fileItem.getName().lastIndexOf("\\");
							if(idx==-1) {
								idx=fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx+1);
							prod.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir,fileName);
								fileItem.write(uploadedFile);
							}catch(IOException e) {
								System.out.println(e);
							}
							
						}else {
							prod.setFileName("../../images/empty.GIF");
						}
						
					}
					
				}				
				
				System.out.println("!)@(#*@"+prod);
				productService.addProduct(prod);
				
				System.out.println("\n\n ssss"+prod.getProdNo());
				prod = productService.getProduct(prod.getProdNo()+1);
				
				System.out.println("\n!######"+prod+"\n");
				request.setAttribute("prod", prod);
			}else {
				int overSize = (request.getContentLength()/1000000);
				System.out.println("<script>alert('파일의 크기는 1MB 까지 입니다. 올리신 파일 용량은 ')"+overSize+" MB 입니다.");
				System.out.println("history.back()</script>");
			}
		}else {
			System.out.println("인코딩 타입이 multipart/form-data 가 아닙니다.");
		}
		return "forward:/product/addProduct.jsp";
	}
	*/
}
