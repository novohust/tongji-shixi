package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.entity.Teacher;
import org.hustsse.cloud.enums.GenderEnum;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.hustsse.cloud.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/data-manage/teacher")
public class TeacherController {

	@Autowired
	TeacherService teacherService;
	@Autowired
	SecondarySubjectService secondarySubjectService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map,Teacher teacher,Integer pageNum,Integer pageSize) {
		List<SecondarySubject> allSS = secondarySubjectService.findAll();
		map.put("allSS", allSS);
		map.put("query", teacher);
		if(pageNum == null)
			pageNum = 1;
		if(pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Teacher> page = teacherService.findByConditions(teacher,pageNum,pageSize);
		// 如果请求的页码超过了最后一页，跳转到最后一页
		if(page.getTotalPages()<pageNum) {
			page = teacherService.findByConditions(teacher, (int)page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "data-manage-teacher";
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public Teacher findById(@PathVariable Long id) {
		Teacher d = teacherService.findByIdWithTeamAndAreaAndDept(id);
		return d;
	}

	@RequestMapping(value = "/add")
	public ModelAndView add(Teacher t) {
		t.setName(t.getName().trim());
		teacherService.add(t);
		return new ModelAndView("redirect:/data-manage/teacher");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			teacherService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/teacher":returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/noCanUse")
	@ResponseBody
	public List<Object> noCanUseWhenAdd( String fieldId, String fieldValue) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		result.add(teacherService.findByTeacherNo(fieldValue.trim()) == null);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(Teacher t,String returnUrl) {
		t.setName(t.getName().trim());
		teacherService.update(t);
		// 编辑要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/teacher":returnUrl));
	}

	// 编辑时的验证-----
	/**
	 表单单个字段ajax校验
	 *
	 * @param fieldId name输入框的input
	 * @param name name输入框的value
	 * @param deptIdEdit	选择的二级学科的id
	 * @param id	病区id
	 * @return
	 */
	@RequestMapping(value = "/update/noCanUse")
	@ResponseBody
	public List<Object> noCanUseWhenUpdate(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long idEdit) {
		String newTeacherNo = fieldValue;
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);

		// 更新时验证名称要排除自己
		Teacher d = teacherService.findByTeacherNo(newTeacherNo);
		result.add(d == null || d.getId().equals(idEdit));
		return result;
	}

}
