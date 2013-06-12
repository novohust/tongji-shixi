package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.service.AreaService;
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
@RequestMapping(value = "/data-manage/area")
public class AreaController {

	@Autowired
	AreaService areaService;
	@Autowired
	SecondarySubjectService secondarySubjectService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map,Area area,Integer pageNum,Integer pageSize) {
		List<SecondarySubject> allSS = secondarySubjectService.findAll();
		map.put("allSS", allSS);
		map.put("query", area);
		if(pageNum == null)
			pageNum = 1;
		if(pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Area> page = areaService.findByConditions(area,pageNum,pageSize);
		if(page.getTotalPages()<pageNum) {
			page = areaService.findByConditions(area, (int)page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "data-manage-area";
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public Area findById(@PathVariable Long id) {
		Area d = areaService.findByIdWithDept(id);
		return d;
	}

	@RequestMapping(value = "/all/{deptId}")
	@ResponseBody
	public List<Area> findAllBySsid(@PathVariable Long deptId) {
		List<Area> d = areaService.findByDepartmentId(deptId);
		return d;
	}

	@RequestMapping(value = "/add")
	public ModelAndView add(Area area) {
		area.setName(area.getName().trim());
		areaService.add(area);
		return new ModelAndView("redirect:/data-manage/area");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			areaService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/area":returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenAdd( String fieldId, String fieldValue,  Long deptIdAdd) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 没选科室，不做校验（通过）;前端科室校验将失败，表单无法提交
		if(deptIdAdd == null) {
			result.add(true);
			return result;
		}
		List<Area> areas = areaService.findByDepartmentId(deptIdAdd);
		for (Area area : areas) {
			if(area.getName().equals(fieldValue)) {
				result.add(false);
				return result;
			}
		}
		result.add(true);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(Area area,String returnUrl) {
		area.setName(area.getName().trim());
		areaService.update(area);
		// 编辑要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/area":returnUrl));
	}

	// 编辑时的验证-----
	/**
	 表单单个字段ajax校验
	 *
	 * @param fieldId name输入框的input
	 * @param name name输入框的value
	 * @param deptIdEdit	选择的二级学科的id
	 * @param id	科室id
	 * @return
	 */
	@RequestMapping(value = "/update/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenUpdate(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long deptIdEdit,
			@RequestParam Long idEdit) {
		String name = fieldValue;
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 没选科室，不做校验（通过）;前端科室校验将失败，表单无法提交
		if(deptIdEdit == null) {
			result.add(true);
			return result;
		}
		// 更新时验证名称要排除自己
		Area d = areaService.findById(idEdit);
		if(deptIdEdit == d.getDepartment().getId() && d.getName().equals(name)) {
			result.add(true);
			return result;
		}

		// 指定科室下有重复名字，名称不可用
		List<Area> areas = areaService.findByDepartmentId(deptIdEdit);
		for (Area area : areas) {
			if(area.getName().equals(name)) {
				result.add(false);
				return result;
			}
		}

		// 名称可用
		result.add(true);
		return result;
	}

}
