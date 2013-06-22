package org.hustsse.cloud.web.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.hustsse.cloud.entity.Student;
import org.hustsse.cloud.enums.PrintTypeEnum;
import org.hustsse.cloud.enums.WeekEnum;
import org.hustsse.cloud.web.print.PrintController.InternRange;
import org.springframework.core.io.Resource;

import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.Barcode128;
import com.itextpdf.text.pdf.Barcode128;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PrintPreviewPdfView extends AbstractIText5PdfView {

	@Override
	protected Document newDocument() {
		return new Document(PageSize.A4, 0, 0, 0, 0);
	}

	private static PdfPCell empty;
	private static Font f;
	{
		empty = new PdfPCell();
		empty.setBorder(Rectangle.NO_BORDER);
	}

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		// create font
		synchronized (PrintPreviewPdfView.class) {
			if (f == null) {
				Resource font = (Resource) model.get("font");
				BaseFont bf = BaseFont.createFont(font.getFile().getAbsolutePath(), BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
				f = new Font(bf, 12, Font.NORMAL);
			}
		}
		PdfContentByte cb = writer.getDirectContent();

		// set up barcode
		Barcode128 code128 = new Barcode128();
		code128.setBarHeight(31);
		code128.setFont(null);

		// create table
		PdfPTable table = new PdfPTable(3);
		table.setWidthPercentage(100);

		int sum = 0;
		List<Student> students = (List<Student>) model.get("students");
		List<InternRange> ranges = (List<InternRange>) model.get("ranges");

		for (int j = 0; j < students.size(); j++) {
			Student s = students.get(j);
			for (InternRange r : ranges) {
				// 对每个打印范围生成条码

				// 如果月份选择全部，打印12张条码
				// 如果选择某个月份，看是否按周拆分：
				// 未勾选：打印1张条码
				// 勾选：看周的值
				// 周 == 全部：打印4张条码
				// 周 == 1|2|3|4：打印1张条码
				if (r.getMonth() == null || r.getMonth() == 0) {
					for (int i = 1; i <= 12; i++) {
						PdfPCell cell = createCell(cb, code128, s, r.getYear(), i, WeekEnum.All);
						table.addCell(cell);
					}
					sum += 12;
				} else {
					if (r.getSplitByWeek() == null || !r.getSplitByWeek()) {
						table.addCell(createCell(cb, code128, s, r.getYear(), r.getMonth(), WeekEnum.All));
						sum++;
					} else {
						if (r.getWeek() == WeekEnum.All) {
							for (WeekEnum w : WeekEnum.values()) {
								if (w == WeekEnum.All)
									continue;
								table.addCell(createCell(cb, code128, s, r.getYear(), r.getMonth(), w));
							}
							sum += 4;
						} else {
							table.addCell(createCell(cb, code128, s, r.getYear(), r.getMonth(), r.getWeek()));
							sum++;
						}
					}
				}
			}
			// 输出完一个学生的条码后判断是否需要分页
			if (PrintTypeEnum.PagedByStu == (PrintTypeEnum) model.get("printType") && sum % 32 != 0 && j != students.size() - 1) {
				fixTable(table, sum);
				document.add(table);
				// 重新创建一个table并另起一页
				table = new PdfPTable(3);
				table.setWidthPercentage(100);
				document.newPage();
				sum = 0;
			}
		}
		fixTable(table,sum);
		document.add(table);
	}

	private void fixTable(PdfPTable table, int sum) {
		// 分页前补全空白cell
		if(sum % 3 != 0) {
			for (int i = 0; i < 3 - sum % 3; i++) {
				table.addCell(empty);
			}
		}
	}

	private PdfPCell createCell(PdfContentByte cb, Barcode128 code128, Student s, int year, int month, WeekEnum week) {
		PdfPCell cell = new PdfPCell();
		cell.setBorder(Rectangle.NO_BORDER);
		cell.setPaddingLeft(20);
		cell.setPaddingRight(20);
		cell.setPaddingBottom(10);
		String code = StringUtils.join(new Object[] { s.getId(), year, month, week.value()}, ",");
		code128.setCode(code);
		cell.addElement(code128.createImageWithBarcode(cb, null, null));
		Paragraph p = new Paragraph(s.getName() + " - " + s.getMajor().getName(), f);
		p.setSpacingBefore(-3);
		cell.addElement(p);
		return cell;
	}

}
