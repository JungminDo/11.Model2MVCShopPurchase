package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

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

	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute("product") Product product) throws Exception {

		System.out.println("/product/addProduct:POST");
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
}
