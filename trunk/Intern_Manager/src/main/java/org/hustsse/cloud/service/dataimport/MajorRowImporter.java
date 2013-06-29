package org.hustsse.cloud.service.dataimport;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.service.MajorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MajorRowImporter extends RowImporter {

	@Autowired
	MajorService majorService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		Major major = new Major();
		Cell nameCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "名称不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);

		String name = nameCell.getStringCellValue();
		if (majorService.findByName(name) != null) {
			addErrorTip(session, "专业'" + name + "'已经存在", i);
			return;
		}
		// 保存
		major.setName(name);
		majorService.add(major);
	}

}
