package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.hustsse.cloud.entity.SecondarySubject;
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
@RequestMapping(value = "/data-manage/secondary-subject")
public class SecondarySubjectManController {

	@Autowired
	SecondarySubjectService secondarySubjectService;

	@RequestMapping(value = "")
	public String allMajor(ModelMap map) {
		List<SecondarySubject> allSecondarySubjects = secondarySubjectService.findAll();
		map.put("allSecondarySubject", allSecondarySubjects);
		return "data-manage-secondary-subject";
	}

	@RequestMapping(value = "/all")
	@ResponseBody
	public List<SecondarySubject> allSecondarySubjectJson(ModelMap map) {
		return secondarySubjectService.findAll();
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public SecondarySubject findMajorById(@PathVariable Long id) {
		return secondarySubjectService.findById(id);
	}

	@RequestMapping(value = "/add")
	public ModelAndView addMajor(SecondarySubject secondarySubject) {
		secondarySubject.setName(secondarySubject.getName().trim());
		secondarySubjectService.add(secondarySubject);
		return new ModelAndView("redirect:/data-manage/secondary-subject");
	}

	@RequestMapping(value = "/del")
	public ModelAndView deleteMajor(Long[] ids) {
		for (Long id : ids) {
			secondarySubjectService.delete(id);
		}
		return new ModelAndView("redirect:/data-manage/secondary-subject");
	}

	// 添加时的验证-----
	// 整个表单的验证
	@RequestMapping(value = "/add/validate")
	@ResponseBody
	public List<List<Object>> validateAdd(SecondarySubject secondarySubject) {
		List<List<Object>> results = new ArrayList<List<Object>>();
		results.add(validateNameUsedWhenAdd("nameAdd", secondarySubject.getName()));
		return results;
	}

	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenAdd(@RequestParam String fieldId, @RequestParam String fieldValue) {
		return validateNameUsedWhenAdd(fieldId, fieldValue);
	}

	private List<Object> validateNameUsedWhenAdd(String fieldId, String fieldValue) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		if (secondarySubjectService.findByName(fieldValue) != null) {
			result.add(false);
			result.add("该专业已存在");
		} else {
			result.add(true);
			result.add("该名称可用");
		}
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView updateMajor(SecondarySubject secondarySubject) {
		secondarySubject.setName(secondarySubject.getName().trim());
		secondarySubjectService.update(secondarySubject);
		return new ModelAndView("redirect:/data-manage/secondary-subject");
	}

	// 编辑时的验证-----
	// 整个表单的验证
	@RequestMapping(value = "/update/validate")
	@ResponseBody
	public List<List<Object>> validateUpdate(SecondarySubject secondarySubject) {
		List<List<Object>> results = new ArrayList<List<Object>>();
		results.add(validateNameUsedWhenUpdate("nameEdit", secondarySubject.getName(), secondarySubject.getId()));
		return results;
	}

	// 表单单个字段ajax校验
	@RequestMapping(value = "/update/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenUpdate(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long idEdit) {
		return validateNameUsedWhenUpdate(fieldId, fieldValue, idEdit);
	}

	private List<Object> validateNameUsedWhenUpdate(String fieldId, String fieldValue, Long id) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 更新时验证名称要排除自己
		if (fieldValue.equals(secondarySubjectService.findById(id).getName()) || secondarySubjectService.findByName(fieldValue) == null) {
			result.add(true);
			result.add("该名称可用");
			return result;
		}
		result.add(false);
		result.add("该专业已存在");
		return result;
	}

}
