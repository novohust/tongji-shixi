package org.hustsse.cloud.service.dataimport;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Department;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.service.DepartmentService;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DepartmentRowImporter extends RowImporter {

	@Autowired
	DepartmentService departmentService;
	@Autowired
	SecondarySubjectService secondarySubjectService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		Department d = new Department();
		Cell nameCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "科室名称不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);
		Cell ssCell = r.getCell(1);
		if (!valAnyEmptyCell(session, "所属二级学科不能为空", i, ssCell))
			return;
		ssCell.setCellType(Cell.CELL_TYPE_STRING);

		// 指定的二级学科存在？
		String ssName = ssCell.getStringCellValue();
		SecondarySubject ss = secondarySubjectService.findByName(ssName);
		if (ss == null) {
			addErrorTip(session, "指定的二级学科'" + ssName + "'不存在", i);
			return;
		}

		// 是否重名？
		String name = nameCell.getStringCellValue();
		if (departmentService.isNameUsed(ss.getId(), name)) {
			addErrorTip(session, "科室名称'" + name + "'重复", i);
			return;
		}
		// 保存
		d.setName(name);
		d.setSecondarySubject(ss);
		departmentService.add(d);
	}

}
