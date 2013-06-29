package org.hustsse.cloud.service.dataimport;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Teacher;
import org.hustsse.cloud.entity.TeacherTeam;
import org.hustsse.cloud.enums.GenderEnum;
import org.hustsse.cloud.service.TeacherService;
import org.hustsse.cloud.service.TeacherTeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeacherRowImporter extends RowImporter {

	@Autowired
	TeacherService teacherService;
	@Autowired
	TeacherTeamService teacherTeamService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		Teacher t = new Teacher();
		//工号
		//不能为空
		Cell teacherNoCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "工号号不能为空", i, teacherNoCell))
			return;
		teacherNoCell.setCellType(Cell.CELL_TYPE_STRING);
		//重复？
		String teacherNo = teacherNoCell.getStringCellValue();
		if(teacherService.findByTeacherNo(teacherNo) != null) {
			addErrorTip(session, "工号'" + teacherNo + "'已被使用", i);
			return;
		}
		t.setTeacherNo(teacherNo);

		// 姓名
		Cell nameCell = r.getCell(1);
		if (!valAnyEmptyCell(session, "姓名不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);
		t.setName(nameCell.getStringCellValue());

		// 性别
		Cell genderCell = r.getCell(2);
		if (!valAnyEmptyCell(session, "性别不能为空", i, genderCell))
			return;
		genderCell.setCellType(Cell.CELL_TYPE_STRING);
		GenderEnum g = GenderEnum.fromDesc(genderCell.getStringCellValue());
		if(g == null) {
			addErrorTip(session, "不合法的性别", i);
			return;
		}
		t.setGender(g);

		//出生日期
		Cell birthCell = r.getCell(3);
		if(birthCell != null) {
			if(birthCell.getCellType() == Cell.CELL_TYPE_NUMERIC && DateUtil.isCellDateFormatted(birthCell)) {
				double d = birthCell.getNumericCellValue();
	            Date date = DateUtil.getJavaDate(d);
	            t.setBirthday(date);
			}else {
				addErrorTip(session, "不合法的出生日期", i);
				return;
			}
		}

		// 教授组
		// 为空？
		Cell teamCell = r.getCell(4);
		Cell areaCell = r.getCell(5);
		Cell deptCell = r.getCell(6);
		Cell ssCell = r.getCell(7);
		if (!valAnyEmptyCell(session, "必须指定所在教授组（及其上级病区、科室和二级学科）", i, teamCell,areaCell,deptCell,ssCell))
			return;
		// 存在？
		teamCell.setCellType(Cell.CELL_TYPE_STRING);
		areaCell.setCellType(Cell.CELL_TYPE_STRING);
		deptCell.setCellType(Cell.CELL_TYPE_STRING);
		ssCell.setCellType(Cell.CELL_TYPE_STRING);

		String teamName = teamCell.getStringCellValue();
		String areaName = areaCell.getStringCellValue();
		String deptName = deptCell.getStringCellValue();
		String ssName = ssCell.getStringCellValue();


		TeacherTeam team = teacherTeamService.findByAreaDeptSSName(teamName,areaName,deptName,ssName);
		if (team == null) {
			addErrorTip(session, "指定的教授组'" + StringUtils.join(new String[] {ssName,deptName,areaName,teamName}, "-")+ "'不存在", i);
			return;
		}
		t.setTeacherTeam(team);

		// 保存
		teacherService.add(t);
	}

}
