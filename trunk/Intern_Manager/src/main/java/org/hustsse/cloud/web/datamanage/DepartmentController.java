package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Department;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.service.DepartmentService;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/data-manage/department")
public class DepartmentController {

	@Autowired
	DepartmentService departmentService;
	@Autowired
	SecondarySubjectService secondarySubjectService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map,Department department,Integer pageNum,Integer pageSize) {
		List<SecondarySubject> allSS = secondarySubjectService.findAll();
		map.put("allSS", allSS);
		map.put("query", department);
		if(pageNum == null)
			pageNum = 1;
		if(pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Department> page = departmentService.findByConditions(department,pageNum,pageSize);
		if(page.getTotalPages()<pageNum) {
			page = departmentService.findByConditions(department, (int)page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "data-manage-department";
	}

	@RequestMapping(value = "/all/{ssId}")
	@ResponseBody
	public List<Department> findAllBySsid(@PathVariable Long ssId) {
		List<Department> d = departmentService.findBySecondarySubjectId(ssId);
		return d;
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public Department findById(@PathVariable Long id) {
		Department d = departmentService.findById(id);
		return d;
	}

	@RequestMapping(value = "/add")
	public ModelAndView add(Department department) {
		department.setName(department.getName().trim());
		departmentService.add(department);
		return new ModelAndView("redirect:/data-manage/department");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			departmentService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/department":returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenAdd(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long ssIdAdd) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		List<Department> depts = departmentService.findBySecondarySubjectId(ssIdAdd);
		for (Department dept : depts) {
			if(dept.getName().equals(fieldValue)) {
				result.add(false);
				return result;
			}
		}
		result.add(true);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(Department department,String returnUrl) {
		department.setName(department.getName().trim());
		departmentService.update(department);
		// 编辑要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/department":returnUrl));
	}

	// 编辑时的验证-----
	/**
	 表单单个字段ajax校验
	 *
	 * @param fieldId name输入框的input
	 * @param name name输入框的value
	 * @param ssIdEdit	选择的二级学科的id
	 * @param id	科室id
	 * @return
	 */
	@RequestMapping(value = "/update/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenUpdate(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long ssIdEdit,
			@RequestParam Long idEdit) {
		String name = fieldValue;
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 更新时验证名称要排除自己
		Department d = departmentService.findById(idEdit);
		if(ssIdEdit == d.getSecondarySubject().getId() && d.getName().equals(name)) {
			result.add(true);
			return result;
		}

		// 指定二级学科下有重复名字，名称不可用
		List<Department> depts = departmentService.findBySecondarySubjectId(ssIdEdit);
		for (Department department : depts) {
			if(department.getName().equals(name)) {
				result.add(false);
				return result;
			}
		}

		// 名称可用
		result.add(true);
		return result;
	}

}
