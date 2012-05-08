package au.com.dius.spike.nosql.web;

import au.com.dius.spike.nosql.domain.Order;
import org.springframework.roo.addon.web.mvc.controller.json.RooWebJson;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/orders")
@Controller
@RooWebScaffold(path = "orders", formBackingObject = Order.class)
@RooWebJson(jsonObject = Order.class)
public class OrderController {
}
