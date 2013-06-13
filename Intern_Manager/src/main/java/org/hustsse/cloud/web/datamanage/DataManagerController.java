package org.hustsse.cloud.web.datamanage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping(value = "/data-manage")
public class DataManagerController {

	@RequestMapping(value="")
	public ModelAndView dataManIndex()
	{
		return new ModelAndView("forward:/data-manage/student");
	}

}
