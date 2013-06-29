package org.hustsse.cloud.web.internship;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Internship;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.entity.Teacher;
import org.hustsse.cloud.enums.WeekEnum;
import org.hustsse.cloud.service.DepartmentService;
import org.hustsse.cloud.service.InternshipService;
import org.hustsse.cloud.service.MajorService;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.hustsse.cloud.service.TeacherService;
import org.hustsse.cloud.web.view.InternExportExcelView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/intern-query")
public class InternQueryController {

	@Autowired
	DepartmentService departmentService;
	@Autowired
	InternshipService internshipService;
	@Autowired
	SecondarySubjectService secondarySubjectService;
	@Autowired
	TeacherService teacherService;
	@Autowired
	MajorService majorService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map, Internship internship, Integer startYear, Integer startMonth, WeekEnum startWeek, Integer endYear,
			Integer endMonth, WeekEnum endWeek, Integer pageNum, Integer pageSize) {
		List<SecondarySubject> allSS = secondarySubjectService.findAll();
		List<Teacher> allTeacher = teacherService.findAll();
		List<Major> allMajor = majorService.findAll();
		map.put("allSS", allSS);
		map.put("allMajor", allMajor);
		map.put("allTeacher", allTeacher);
		map.put("query", internship);
		if (pageNum == null)
			pageNum = 1;
		if (pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Internship> page = internshipService.findByConditions(internship, pageNum, pageSize, startYear, startMonth,
				endYear, endMonth);
		if (page != null && page.getTotalPages() < pageNum) {
			page = internshipService.findByConditions(internship, (int) page.getTotalPages(), pageSize, startYear, startMonth,
					endYear, endMonth);
		}
		map.put("page", page);
		map.put("startYear", startYear);
		map.put("startMonth", startMonth);
		map.put("endYear", endYear);
		map.put("endMonth", endMonth);
		return "intern-query";
	}

	@RequestMapping(value = "/export-excel")
	public ModelAndView export(ModelMap map, Internship internship, Integer startYear, Integer startMonth, Integer endYear,
			Integer endMonth) {
		Page<Internship> page = internshipService.findByConditions(internship, 1, Integer.MAX_VALUE, startYear, startMonth,
				endYear, endMonth);
		map.put("interns", page.getResult());
		return new ModelAndView(new InternExportExcelView(), map);
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			internshipService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/intern-query":returnUrl));
	}

}
