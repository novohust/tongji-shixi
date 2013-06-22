package org.hustsse.cloud.web.internship;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.hustsse.cloud.entity.Internship;
import org.hustsse.cloud.service.DepartmentService;
import org.hustsse.cloud.service.InternshipService;
import org.hustsse.cloud.web.print.PrintController.InternRange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping(value = "/intern-add")
public class InternAddController {
	static ObjectMapper mapper = new ObjectMapper();

	public static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {
		return mapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);
	}

	@Autowired
	DepartmentService departmentService;
	@Autowired
	InternshipService internshipService;

	@RequestMapping(value = "")
	public String index(ModelMap map) {
		map.put("allDept", departmentService.findAll());
		return "intern-add";
	}

	@RequestMapping(value = "/find-by-month")
	@ResponseBody
	public List<Internship> findInternships(Long stuId,Integer year,Integer month){
		return internshipService.findByMonth(stuId,year,month);
	}

	@RequestMapping(value = "/add")
	public String add(String internsAdd,String internsDel) throws JsonParseException, JsonMappingException, IOException {
		List<Internship> internAddList;
		JavaType javaType = getCollectionType(ArrayList.class, Internship.class);
		internAddList = (List<Internship>) mapper.readValue(internsAdd, javaType);

		List<Long> internDelIdList;
		internDelIdList = (List<Long>) mapper.readValue(internsDel, getCollectionType(ArrayList.class, Long.class));

		internshipService.add(internAddList,internDelIdList);
		return "redirect:/intern-add";
	}
}
