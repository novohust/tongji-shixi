package org.hustsse.cloud.service.dataimport;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SecondarySubjectRowImporter extends RowImporter {

	@Autowired
	SecondarySubjectService secondarySubjectService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		SecondarySubject ss = new SecondarySubject();
		Cell nameCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "名称不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);

		String name = nameCell.getStringCellValue();
		if (secondarySubjectService.findByName(name) != null) {
			addErrorTip(session, "'" + name + "'已被使用", i);
			return;
		}
		// 保存
		ss.setName(name);
		secondarySubjectService.add(ss);
	}

}
