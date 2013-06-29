package org.hustsse.cloud.service.dataimport;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.Department;
import org.hustsse.cloud.service.AreaService;
import org.hustsse.cloud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AreaRowImporter extends RowImporter {

	@Autowired
	DepartmentService departmentService;
	@Autowired
	AreaService areaService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		Area area = new Area();
		Cell nameCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "病区名称不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);
		Cell deptCell = r.getCell(1);
		Cell ssCell = r.getCell(2);
		if (!valAnyEmptyCell(session, "必须指定所属科室", i, ssCell, deptCell))
			return;
		deptCell.setCellType(Cell.CELL_TYPE_STRING);
		ssCell.setCellType(Cell.CELL_TYPE_STRING);

		// 指定的科室存在？
		String deptName = deptCell.getStringCellValue();
		String ssName = ssCell.getStringCellValue();

		Department dept = departmentService.findByDeptAndSSName(ssName, deptName);
		if (dept == null) {
			addErrorTip(session, "指定的科室'" + ssName + "-" + deptName + "'不存在", i);
			return;
		}

		// 是否重名？
		String name = nameCell.getStringCellValue();
		if (areaService.isNameUsed(dept.getId(), name)) {
			addErrorTip(session, "病区名称'" + name + "'重复", i);
			return;
		}
		// 保存
		area.setName(name);
		area.setDepartment(dept);
		areaService.add(area);
	}

}
