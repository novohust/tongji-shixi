package org.hustsse.cloud.web.internship;

import java.util.List;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

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
		Page<Internship> page = internshipService.findByConditions(internship, pageNum, pageSize, startYear, startMonth, startWeek,
				endYear, endMonth, endWeek);
		if (page != null && page.getTotalPages() < pageNum) {
			page = internshipService.findByConditions(internship, (int) page.getTotalPages(), pageSize, startYear, startMonth, startWeek,
					endYear, endMonth, endWeek);
		}
		map.put("page", page);
		map.put("startYear", startYear);
		map.put("startMonth", startMonth);
		map.put("startWeek", startWeek);
		map.put("endYear", endYear);
		map.put("endMonth", endMonth);
		map.put("endWeek", endWeek);
		return "intern-query";
	}

}
