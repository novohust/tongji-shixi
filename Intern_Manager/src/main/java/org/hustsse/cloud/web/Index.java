package org.hustsse.cloud.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/")
public class Index {

	@RequestMapping(value = "")
	public String index() {
		return "redirect:/intern-query";
	}
}
