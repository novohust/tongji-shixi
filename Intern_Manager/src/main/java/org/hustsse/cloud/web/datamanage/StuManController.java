package org.hustsse.cloud.web.datamanage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "/data-manage/stu")
public class StuManController {

	@RequestMapping(value="")
	public String queryStu(ModelMap map,
			@RequestParam(required=false,defaultValue="1") int pageNum,
			@RequestParam(required=false,defaultValue="20") int pageSize)
	{
		return "data-manage-stu";
	}

}
