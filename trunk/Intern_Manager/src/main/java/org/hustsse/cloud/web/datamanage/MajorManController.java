package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/data-manage/major")
public class MajorManController {

	@Autowired
	MajorService majorService;

	@RequestMapping(value = "")
	public String allMajor(ModelMap map) {
		List<Major> allMajors = majorService.findAll();
		map.put("allMajor", allMajors);
		return "data-manage-major";
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public Major findMajorById(@PathVariable Long id) {
		return majorService.findById(id);
	}

	@RequestMapping(value = "/add")
	public ModelAndView addMajor(Major major) {
		major.setName(major.getName().trim());
		majorService.add(major);
		return new ModelAndView("redirect:/data-manage/major");
	}

	@RequestMapping(value = "/del")
	public ModelAndView deleteMajor(Long[] ids) {
		for (Long id : ids) {
			majorService.delete(id);
		}
		return new ModelAndView("redirect:/data-manage/major");
	}

	// 添加时的验证-----
	// 整个表单的验证
	@RequestMapping(value = "/add/validate")
	@ResponseBody
	public List<List<Object>> validateAdd(Major major) {
		List<List<Object>> results = new ArrayList<List<Object>>();
		results.add(validateNameUsedWhenAdd("name-add", major.getName()));
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
		if (majorService.findByName(fieldValue) != null) {
			result.add(false);
			result.add("该专业已存在");
		} else {
			result.add(true);
			result.add("该名称可用");
		}
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView updateMajor(Major major) {
		major.setName(major.getName().trim());
		majorService.update(major);
		return new ModelAndView("redirect:/data-manage/major");
	}

	// 编辑时的验证-----
	// 整个表单的验证
	@RequestMapping(value = "/update/validate")
	@ResponseBody
	public List<List<Object>> validateUpdate(Major major) {
		List<List<Object>> results = new ArrayList<List<Object>>();
		results.add(validateNameUsedWhenUpdate("nameEdit", major.getName(), major.getId()));
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
		if (fieldValue.equals(majorService.findById(id).getName()) || majorService.findByName(fieldValue) == null) {
			result.add(true);
			result.add("该名称可用");
			return result;
		}
		result.add(false);
		result.add("该专业已存在");
		return result;
	}

}
