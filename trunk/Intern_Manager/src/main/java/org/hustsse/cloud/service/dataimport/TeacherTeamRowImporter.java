package org.hustsse.cloud.service.dataimport;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.TeacherTeam;
import org.hustsse.cloud.service.AreaService;
import org.hustsse.cloud.service.TeacherTeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeacherTeamRowImporter extends RowImporter {

	@Autowired
	AreaService areaService;
	@Autowired
	TeacherTeamService teacherTeamService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		TeacherTeam team = new TeacherTeam();
		Cell nameCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "教授组名称不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);

		Cell areaCell = r.getCell(1);
		Cell deptCell = r.getCell(2);
		Cell ssCell = r.getCell(3);
		if (!valAnyEmptyCell(session, "必须指定所属病区", i, ssCell, deptCell,areaCell))
			return;

		areaCell.setCellType(Cell.CELL_TYPE_STRING);
		deptCell.setCellType(Cell.CELL_TYPE_STRING);
		ssCell.setCellType(Cell.CELL_TYPE_STRING);

		// 指定的病区存在？
		String areaName = areaCell.getStringCellValue();
		String deptName = deptCell.getStringCellValue();
		String ssName = ssCell.getStringCellValue();

		Area area = areaService.findByAreaDeptSSName(areaName, deptName, ssName);
		if (area == null) {
			addErrorTip(session, "指定的病区'" + ssName + "-" + deptName + "-"+areaName + "'不存在", i);
			return;
		}

		// 是否重名？
		String name = nameCell.getStringCellValue();
		if (teacherTeamService.isNameUsed(area.getId(), name)) {
			addErrorTip(session, "教授组名称'" + name + "'重复", i);
			return;
		}
		// 保存
		team.setName(name);
		team.setArea(area);
		teacherTeamService.add(team);
	}

}
