package org.hustsse.cloud.service.dataimport;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

public abstract class RowImporter {

	private Cell[] c;

	public abstract void importRowInner(HttpSession session, Sheet s, int i);

	public void importRow(HttpSession session, Sheet s, int i) {
		try {
			importRowInner(session, s, i);
		} catch (Exception e) {
			addErrorTip(session, e.toString(), i);
		} finally {
			setImportedCount(session, i);
		}
	}

	protected boolean valEmptyRow(HttpSession session, String tip, int i, Row r) {
		if (r == null) {
			addErrorTip(session, tip, i);
			return false;
		}
		return true;
	}

	protected boolean valAnyEmptyCell(HttpSession session, String tip, int i, Cell... c) {
		for (Cell cell : c) {
			if (cell == null) {
				addErrorTip(session, tip, i);
				return false;
			}
		}
		return true;
	}

	protected void addErrorTip(HttpSession session, String tip, int i) {
		@SuppressWarnings("unchecked")
		List<String> errorTips = (List<String>) session.getAttribute("errorTips");
		errorTips.add("第" + (i + 1) + "行:&nbsp;&nbsp;" + tip);
	}

	void setImportedCount(HttpSession session, int i) {
		session.setAttribute("importedCount", i);
	}

}
