package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value = "addPurchaseView")
	public ModelAndView addPurchaseView( HttpSession session, @RequestParam("prodNo") int prodNo) throws Exception{
		
		System.out.println("/purchase/addPurchaseView");
		
		ModelAndView modelAndView = new ModelAndView();
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		User user = userService.getUser(userId);
		
		Product product = productService.getProduct(prodNo);
		
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("product", product);
		modelAndView.addObject("user", user);
	
		return modelAndView;
	}
	/*
	@RequestMapping(value = "addPurchase")
	public ModelAndView addPurchase(Product product, String buyerId, Purchase purchase, HttpSession session ) throws Exception{
		
		System.out.println("/purchase/addPurchase");
		
		User user = userService.getUser(buyerId);
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		ModelAndView modelAndView = new ModelAndView();
		
		purchaseService.addPurchase(purchase);
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
	
		
		return modelAndView;
		
	}
	*/
	
	@RequestMapping(value = "addPurchase")
	public ModelAndView addPurchase(Purchase purchase, HttpSession session, Product product ) throws Exception{
		
		System.out.println("/purchase/addPurchase");
		
	
		ModelAndView modelAndView = new ModelAndView();
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		User user = userService.getUser(userId);
		
		Product getProduct = productService.getProduct(product.getProdNo());
	

		modelAndView.addObject("product", getProduct);
		modelAndView.addObject("user", user);

		 //purchaseService.addPurchase(purchase);
		modelAndView.setViewName("/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
	
		
		return modelAndView;
		
	}
	
	@RequestMapping(value = "listPurchase")
	public ModelAndView listPurchase(@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		
		return modelAndView;
	}
	
	
	
	
	/*
	@RequestMapping(value = "listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search,
			 HttpSession session, 
			Model model, HttpServletRequest request) throws Exception {
		
	//	HttpSession session = request.getSession(true);
	//	User user = (User)session.getAttribute("user");
		
			
		System.out.println("/purchase/listPurchase");
		// System.out.println("여기가 메뉴"+menu);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		
	//	buyerId.setUser(buyerId);
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println("페이지" + resultPage);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("buyerId", buyerId);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
	*/
	
	
	
	@RequestMapping(value = "getPurchase")
	public ModelAndView getPurchase(@RequestParam("tranNo") int tranNo) throws Exception{
		
		System.out.println("/purchase/getPurchase");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value = "updatePurchaseView")
	public ModelAndView updatePurchaseView(@RequestParam("tranNo") int tranNo) throws Exception{
		
		System.out.println("/purchase/updatePurchaseView");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		
		return modelAndView;
	}
	
	@RequestMapping(value = "updatePurchase")
	public ModelAndView updatePurchase(Product product, User user, Purchase purchase, @RequestParam("tranNo") int tranNo) throws Exception{
		
		System.out.println("/purcahse/updatePurchase");
		
		ModelAndView modelAndView = new ModelAndView();
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		purchaseService.updatePurcahse(purchase);
		
		purchase = purchaseService.getPurchase(tranNo);
		
		modelAndView.setViewName("/purchase/updatePurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	
	
//	@RequestMapping("/listSale.do")
//	public ModelAndView listSale() throws Exception{
//		
//		System.out.println("/listSale.do");
//		
//		ModelAndView modelAndView = new ModelAndView();
//		modelAndView.setViewName("/purchase/getPurchase.jsp");
//		
//		return modelAndView;
//	}
	
	@RequestMapping(value = "updateTranCode")
	public ModelAndView updateTranCode(@ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println("/purchase/updateTranCode");
		
		ModelAndView modelAndView = new ModelAndView();
		
		purchaseService.updateTranCode(purchase);
		
		modelAndView.setViewName("redirect:/purchase/listPurchase.do");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "updateTranCodeByProd")
	public ModelAndView updateTranCodeByProd(Purchase purchase, Search search, HttpSession session) throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd");
		
		
		
		purchaseService.updateTranCode(purchase);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/purchase/updateTranCodeByProd.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);		
		
		return modelAndView;
	}
	
}
