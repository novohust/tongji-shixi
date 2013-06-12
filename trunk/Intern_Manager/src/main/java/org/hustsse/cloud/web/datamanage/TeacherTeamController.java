package org.hustsse.cloud.web.datamanage;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.entity.TeacherTeam;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.hustsse.cloud.service.TeacherTeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/data-manage/teacher-team")
public class TeacherTeamController {

	@Autowired
	TeacherTeamService teacherTeamService;
	@Autowired
	SecondarySubjectService secondarySubjectService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map,TeacherTeam team,Integer pageNum,Integer pageSize) {
		List<SecondarySubject> allSS = secondarySubjectService.findAll();
		map.put("allSS", allSS);
		map.put("query", team);
		if(pageNum == null)
			pageNum = 1;
		if(pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<TeacherTeam> page = teacherTeamService.findByConditions(team,pageNum,pageSize);
		if(page.getTotalPages()<pageNum) {
			page = teacherTeamService.findByConditions(team, (int)page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "data-manage-teacher-team";
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public TeacherTeam findById(@PathVariable Long id) {
		TeacherTeam d = teacherTeamService.findByIdWithAreaAndDept(id);
		return d;
	}

	@RequestMapping(value = "/all/{areaId}")
	@ResponseBody
	public List<TeacherTeam> findAllByAreaId(@PathVariable Long areaId) {
		List<TeacherTeam> d = teacherTeamService.findByAreaId(areaId);
		return d;
	}

	@RequestMapping(value = "/add")
	public ModelAndView add(TeacherTeam t) {
		t.setName(t.getName().trim());
		teacherTeamService.add(t);
		return new ModelAndView("redirect:/data-manage/teacher-team");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			teacherTeamService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/teacher-team":returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenAdd( String fieldId, String fieldValue,  Long areaIdAdd) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 没选病区，不做校验（通过）;前端病区校验将失败，表单无法提交
		if(areaIdAdd == null) {
			result.add(true);
			return result;
		}
		List<TeacherTeam> teams = teacherTeamService.findByAreaId(areaIdAdd);
		for (TeacherTeam t : teams) {
			if(t.getName().equals(fieldValue)) {
				result.add(false);
				return result;
			}
		}
		result.add(true);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(TeacherTeam t,String returnUrl) {
		t.setName(t.getName().trim());
		teacherTeamService.update(t);
		// 编辑要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/teacher-team":returnUrl));
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
	@RequestMapping(value = "/update/nameCanUse")
	@ResponseBody
	public List<Object> nameCanUseWhenUpdate(@RequestParam String fieldId, @RequestParam String fieldValue, @RequestParam Long areaIdEdit,
			@RequestParam Long idEdit) {
		String name = fieldValue;
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		// 没选病区，不做校验（通过）;前端病区校验将失败，表单无法提交
		if(areaIdEdit == null) {
			result.add(true);
			return result;
		}
		// 更新时验证名称要排除自己
		TeacherTeam d = teacherTeamService.findById(idEdit);
		if(areaIdEdit == d.getArea().getId() && d.getName().equals(name)) {
			result.add(true);
			return result;
		}

		// 指定病区下有重复名字，名称不可用
		List<TeacherTeam> teams = teacherTeamService.findByAreaId(areaIdEdit);
		for (TeacherTeam t : teams) {
			if(t.getName().equals(name)) {
				result.add(false);
				return result;
			}
		}

		// 名称可用
		result.add(true);
		return result;
	}

}
