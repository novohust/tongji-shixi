package org.hustsse.cloud.web.print;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.io.FileUtils;
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

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BarcodeEAN;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Controller
@RequestMapping(value = "/barcode-print")
public class PrintController {

	@Autowired
	StudentService studentService;
	@Autowired
	MajorService majorService;

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

	@Value("#{mvcProp.font_file}")
	Resource font;

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
		map.put("font", font);
		return new ModelAndView(new PrintPreviewPdfView(), map);
	}

	public static void main(String[] args) throws DocumentException, IOException {
		BaseFont  bf = BaseFont.createFont("R:/simhei.ttf", BaseFont.IDENTITY_H,BaseFont.NOT_EMBEDDED);
		Font f = new Font(bf, 12, Font.NORMAL);
		BarcodeEAN codeEAN = new BarcodeEAN();
		codeEAN.setBarHeight(20);
		codeEAN.setFont(null);
		Document doc = new Document(PageSize.A4, 0, 0, 0, 0);
		doc.setMargins(0, 0, 0, 0);
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("R:/a.pdf"));
		doc.open();
		doc.newPage();
		PdfContentByte cb = writer.getDirectContent();
		// 创建一个有3列的表格
		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);
		// 定义一个表格单元
		PdfPCell cell = new PdfPCell();
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setPaddingLeft(20);
		cell.setPaddingRight(20);
		cell.setPaddingBottom(10);
		codeEAN.setCode("4512345678906");
		cell.addElement(codeEAN.createImageWithBarcode(cb, null, null));
		Paragraph p = new Paragraph("汪瑶 -- Student",f);
		p.setSpacingBefore(-3);
		cell.addElement(p);

		// 一个空的cell
		PdfPCell empty = new PdfPCell();
		empty.setBorder(Rectangle.NO_BORDER);

		table.addCell(cell);
		table.addCell(cell);
		table.addCell(cell);
		table.addCell(cell);
		table.addCell(empty);
		table.addCell(empty);

		doc.add(table);
		doc.close();
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
	public ModelAndView add(Student s, MultipartFile img) throws Exception {
		s.setName(s.getName().trim());
		if (img != null && img.getSize() > 0) {
			File imgDir = uploadAvatarDir.getFile();
			if (!imgDir.exists())
				imgDir.mkdirs();
			String imgName = s.getStuNo() + "." + img.getOriginalFilename().split("\\.")[1];
			File imgFile = new File(imgDir, imgName);
			String imgRelativePath = ((ServletContextResource) uploadAvatarDir).getPathWithinContext() + "/" + imgName;
			s.setAvatar(imgRelativePath);

			try {
				img.transferTo(imgFile);
				studentService.add(s);
			} catch (Exception e) {
				FileUtils.deleteQuietly(imgFile);
				throw e;
			}
		} else {
			studentService.add(s);
		}
		return new ModelAndView("redirect:/data-manage/student");
	}

	@RequestMapping(value = "/del")
	public ModelAndView delete(Long[] ids, String returnUrl) {
		for (Long id : ids) {
			studentService.delete(id);
		}
		// 删除要留在当前页
		return new ModelAndView("redirect:" + (StringUtils.isBlank(returnUrl) ? "/data-manage/student" : returnUrl));
	}

	// 添加时的验证-----
	// 表单单个字段ajax校验
	@RequestMapping(value = "/add/noCanUse")
	@ResponseBody
	public List<Object> noCanUseWhenAdd(String fieldId, String fieldValue) {
		List<Object> result = new ArrayList<Object>(2);
		result.add(fieldId);
		result.add(studentService.findByStudentNo(fieldValue.trim()) == null);
		return result;
	}

	@RequestMapping(value = "/update")
	public ModelAndView update(Student s, MultipartFile img, String returnUrl) throws Exception {
		s.setName(s.getName().trim());
		String oldAvatar = studentService.findById(s.getId()).getAvatar();
		// 更换头像了
		if (img != null && img.getSize() > 0) {
			File imgDir = uploadAvatarDir.getFile();
			if (!imgDir.exists())
				imgDir.mkdirs();

			if (StringUtils.isNotBlank(oldAvatar)) {
				String[] tmp = oldAvatar.split("/");
				String oldImgName = tmp[tmp.length - 1];
				FileUtils.deleteQuietly(new File(imgDir, oldImgName)); // 把原来的图片删了
			}

			String imgName = s.getStuNo() + "." + img.getOriginalFilename().split("\\.")[1];
			File imgFile = new File(imgDir, imgName);
			String imgRelativePath = ((ServletContextResource) uploadAvatarDir).getPathWithinContext() + "/" + imgName;
			s.setAvatar(imgRelativePath);

			try {
				img.transferTo(imgFile);
				studentService.update(s);
			} catch (Exception e) {
				FileUtils.deleteQuietly(imgFile);
				throw e;
			}
		} else { // 没有更换头像
			s.setAvatar(oldAvatar);
			studentService.update(s);
		}
		// 编辑要留在当前页
		return new ModelAndView("redirect:" + (StringUtils.isBlank(returnUrl) ? "/data-manage/student" : returnUrl));
	}

	// 编辑时的验证-----
	/**
	 * 表单单个字段ajax校验
	 *
	 * @param fieldId
	 *            name输入框的input
	 * @param name
	 *            name输入框的value
	 * @param deptIdEdit
	 *            选择的二级学科的id
	 * @param id
	 *            病区id
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
