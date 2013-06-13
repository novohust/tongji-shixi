package org.hustsse.cloud.web.datamanage;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.entity.Student;
import org.hustsse.cloud.service.MajorService;
import org.hustsse.cloud.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.ServletContextResource;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/data-manage/student")
public class StudentController {

	@Autowired
	StudentService studentService;
	@Autowired
	MajorService majorService;

	@RequestMapping(value = "")
	public String pageFind(ModelMap map,Student query,Integer pageNum,Integer pageSize) {
		List<Major> allMajor = majorService.findAll();
		map.put("allMajor", allMajor);
		map.put("query", query);
		if(pageNum == null)
			pageNum = 1;
		if(pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Student> page = studentService.findByConditions(query,pageNum,pageSize);
		// 如果请求的页码超过了最后一页，跳转到最后一页
		if(page.getTotalPages()<pageNum) {
			page = studentService.findByConditions(query, (int)page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "data-manage-student";
	}

	@RequestMapping(value = "/{id}")
	@ResponseBody
	public Student findById(@PathVariable Long id) {
		Student d = studentService.findById(id);
		return d;
	}

	@Value("#{mvcProp.upload_avatar_folder}")
	Resource uploadAvatarDir;

	@RequestMapping(value = "/add")
	public ModelAndView add(Student s,MultipartFile img) throws Exception {
		s.setName(s.getName().trim());
		if(img != null && img.getSize() > 0) {
			File imgDir = uploadAvatarDir.getFile();
			if (!imgDir.exists())
				imgDir.mkdirs();
			String imgName = s.getStuNo() + "."+img.getOriginalFilename().split("\\.")[1];
			File imgFile = new File(imgDir, imgName);
			String imgRelativePath = ((ServletContextResource) uploadAvatarDir)
					.getPathWithinContext() + "/" + imgName;
			s.setAvatar(imgRelativePath);

			try {
				img.transferTo(imgFile);
				studentService.add(s);
			} catch (Exception e) {
				FileUtils.deleteQuietly(imgFile);
				throw e;
			}
		}else {
			studentService.add(s);
		}
		return new ModelAndView("redirect:/data-manage/student");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids,String returnUrl) {
		for (Long id : ids) {
			studentService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/student":returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/noCanUse")
	@ResponseBody
	public List<Object> noCanUseWhenAdd( String fieldId, String fieldValue) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		result.add(studentService.findByStudentNo(fieldValue.trim()) == null);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(Student s,MultipartFile img,String returnUrl) throws Exception {
		s.setName(s.getName().trim());
		String oldAvatar = studentService.findById(s.getId()).getAvatar();
		// 更换头像了
		if(img != null && img.getSize() > 0) {
			File imgDir = uploadAvatarDir.getFile();
			if (!imgDir.exists())
				imgDir.mkdirs();

			if(StringUtils.isNotBlank(oldAvatar)) {
				String[] tmp = oldAvatar.split("/");
				String oldImgName = tmp[tmp.length - 1];
				FileUtils.deleteQuietly(new File(imgDir,oldImgName)); // 把原来的图片删了
			}

			String imgName = s.getStuNo() + "."+img.getOriginalFilename().split("\\.")[1];
			File imgFile = new File(imgDir, imgName);
			String imgRelativePath = ((ServletContextResource) uploadAvatarDir)
					.getPathWithinContext() + "/" + imgName;
			s.setAvatar(imgRelativePath);

			try {
				img.transferTo(imgFile);
				studentService.update(s);
			} catch (Exception e) {
				FileUtils.deleteQuietly(imgFile);
				throw e;
			}
		}else {	//没有更换头像
			s.setAvatar(oldAvatar);
			studentService.update(s);
		}
		// 编辑要留在当前页
		return new ModelAndView("redirect:"+(StringUtils.isBlank(returnUrl)?"/data-manage/student":returnUrl));
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
		String newStuNo = fieldValue;
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);

		// 更新时验证名称要排除自己
		Student d = studentService.findByStudentNo(newStuNo);
		result.add(d == null || d.getId().equals(idEdit));
		return result;
	}

}
