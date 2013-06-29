package org.hustsse.cloud.web.auth;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/auth")
public class AuthController {

	@RequestMapping(value = "/login")
	public String loginPage(@RequestParam(value = "error", required = false) boolean error, ModelMap map) {
		map.put("error", error ? "用户名或密码错误" : null);
		return "login";
	}

	@RequestMapping(value = "/denied")
	public String denied() {
		return "denied";
	}
}
