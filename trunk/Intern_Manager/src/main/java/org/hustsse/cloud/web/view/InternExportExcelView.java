package org.hustsse.cloud.web.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Internship;
import org.hustsse.cloud.utils.EncodeUtils;
import org.springframework.web.servlet.view.document.AbstractExcelView;

public class InternExportExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		response.setHeader("Content-Disposition","attachment;filename="+EncodeUtils.urlEncode("考勤记录导出")+".xls");
		Sheet sheet = workbook.createSheet();
		List<Internship> interns = (List<Internship>) model.get("interns");

		// title row
		Row titleRow = sheet.createRow(0);
		int cellIndex = 0;
		titleRow.createCell(cellIndex++).setCellValue("学号");
		titleRow.createCell(cellIndex++).setCellValue("姓名");
		titleRow.createCell(cellIndex++).setCellValue("类别");
		titleRow.createCell(cellIndex++).setCellValue("专业");
		titleRow.createCell(cellIndex++).setCellValue("年级");
		titleRow.createCell(cellIndex++).setCellValue("班级");
		titleRow.createCell(cellIndex++).setCellValue("导师");
		titleRow.createCell(cellIndex++).setCellValue("带教老师");
		titleRow.createCell(cellIndex++).setCellValue("教授组");
		titleRow.createCell(cellIndex++).setCellValue("病区");
		titleRow.createCell(cellIndex++).setCellValue("科室");
		titleRow.createCell(cellIndex++).setCellValue("二级学科");
		titleRow.createCell(cellIndex++).setCellValue("实习时间");

		int rowIndex = 1;
		cellIndex = 0;
		for (Internship internship : interns) {
			Row row = sheet.createRow(rowIndex++);
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getStuNo());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getName());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getType().getDescription());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getMajor().getName());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getGrade());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getClazz());
			row.createCell(cellIndex++).setCellValue(internship.getStudent().getMentor());

			row.createCell(cellIndex++).setCellValue(internship.getTeacher().getName());

			row.createCell(cellIndex++).setCellValue(internship.getTeacherTeam().getName());
			row.createCell(cellIndex++).setCellValue(internship.getTeacherTeam().getArea().getName());
			row.createCell(cellIndex++).setCellValue(internship.getTeacherTeam().getArea().getDepartment().getName());
			row.createCell(cellIndex++).setCellValue(internship.getTeacherTeam().getArea().getDepartment().getSecondarySubject().getName());

			row.createCell(cellIndex++).setCellValue(internship.getYear() + "-" + internship.getMonth() + " "+internship.getWeekType().getDescription());
			cellIndex = 0;
		}
	}

}
