package org.hustsse.cloud.web.print;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.entity.Student;
import org.hustsse.cloud.enums.PrintTypeEnum;
import org.hustsse.cloud.enums.WeekEnum;
import org.hustsse.cloud.service.MajorService;
import org.hustsse.cloud.service.StudentService;
import org.hustsse.cloud.web.view.PrintPreviewPdfView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping(value = "/barcode-print")
public class PrintController {

	@Autowired
	StudentService studentService;
	@Autowired
	MajorService majorService;
	@Autowired
	ApplicationContext appContext;

	static ObjectMapper mapper = new ObjectMapper();

	public static JavaType getCollectionType(Class<?> collectionClass, Class<?>... elementClasses) {
		return mapper.getTypeFactory().constructParametricType(collectionClass, elementClasses);
	}

	@RequestMapping(value = "")
	public String pageFind(ModelMap map, Student query, Integer pageNum, Integer pageSize, PrintTypeEnum printType, String ranges)
			throws JsonParseException, JsonMappingException, IOException {
		List<Major> allMajor = majorService.findAll();
		map.put("allMajor", allMajor);
		map.put("query", query);

		InternRange defaultRange = new InternRange();
		defaultRange.setMonth(1);
		defaultRange.setYear(2013);
		List<InternRange> rangesList;
		map.put("ranges", ranges);
		if (StringUtils.isNotBlank(ranges)) {
			rangesList = fromJson(ranges);
		} else {
			rangesList = new ArrayList<InternRange>(1);
			rangesList.add(defaultRange);
		}
		map.put("rangesList", rangesList);

		map.put("printType", printType);
		if (pageNum == null)
			pageNum = 1;
		if (pageSize == null || pageSize <= 0)
			pageSize = 10;
		Page<Student> page = studentService.findByConditions(query, pageNum, pageSize);
		// 如果请求的页码超过了最后一页，跳转到最后一页
		if (page.getTotalPages() < pageNum) {
			page = studentService.findByConditions(query, (int) page.getTotalPages(), pageSize);
		}
		map.put("page", page);
		return "barcode-print";
	}

	private List<InternRange> fromJson(String ranges) throws IOException, JsonParseException, JsonMappingException {
		List<InternRange> rangesList;
		JavaType javaType = getCollectionType(ArrayList.class, InternRange.class);
		rangesList = (List<InternRange>) mapper.readValue(ranges, javaType);
		return rangesList;
	}

	private List<Long> deSerialize(String ids) throws IOException, JsonParseException, JsonMappingException {
		List<Long> rangesList;
		JavaType javaType = getCollectionType(ArrayList.class, Long.class);
		rangesList = (List<Long>) mapper.readValue(ids, javaType);
		return rangesList;
	}

	@Value("#{mvcProp}")
	private Properties viewConfig;

	@RequestMapping(value = "/preview")
	public ModelAndView preview(ModelMap map, Student query, PrintTypeEnum printType, String ranges, Boolean checkQueryAll, String stuIds)
			throws JsonParseException, JsonMappingException, IOException {
		List<Student> students;
		if (Boolean.TRUE.equals(checkQueryAll)) {
			Page<Student> page = studentService.findByConditions(query, 1, Integer.MAX_VALUE);
			students = page.getResult();
		} else {
			List<Long> ids;
			if (stuIds.startsWith("["))
				ids = deSerialize(stuIds);
			else {
				ids = new ArrayList<Long>(1);
				ids.add(mapper.readValue(stuIds, Long.class));
			}
			students = new LinkedList<Student>();
			for (Long id : ids) {
				students.add(studentService.findByIdWithMajor(id));
			}
		}
		map.put("students", students);
		List<InternRange> rangesList = fromJson(ranges);
		map.put("ranges", rangesList);
		map.put("printType", printType);
		map.put("viewConfig", viewConfig);
		map.put("resourceLoader", appContext);
		return new ModelAndView(new PrintPreviewPdfView(), map);
	}

	public static class InternRange {
		private Integer month;
		private WeekEnum week;
		private Integer year;
		private Boolean splitByWeek;

		public Integer getMonth() {
			return month;
		}

		public void setMonth(Integer month) {
			this.month = month;
		}

		public WeekEnum getWeek() {
			return week;
		}

		public void setWeek(WeekEnum week) {
			this.week = week;
		}

		public Integer getYear() {
			return year;
		}

		public void setYear(Integer year) {
			this.year = year;
		}

		public Boolean getSplitByWeek() {
			return splitByWeek;
		}

		public void setSplitByWeek(Boolean splitByWeek) {
			this.splitByWeek = splitByWeek;
		}

	}

}
