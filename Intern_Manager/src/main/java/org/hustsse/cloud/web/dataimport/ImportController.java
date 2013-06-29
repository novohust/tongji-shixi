package org.hustsse.cloud.web.dataimport;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.hustsse.cloud.entity.SecondarySubject;
import org.hustsse.cloud.enums.ImportTypeEnum;
import org.hustsse.cloud.service.AreaService;
import org.hustsse.cloud.service.SecondarySubjectService;
import org.hustsse.cloud.service.dataimport.RowImporter;
import org.hustsse.cloud.web.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/data-import")
public class ImportController {

	@Autowired
	AreaService areaService;
	@Autowired
	SecondarySubjectService secondarySubjectService;
	@Autowired
	ApplicationContext appContext;

	@RequestMapping(value = "")
	public String index() {
		return "data-import";
	}

	@RequestMapping(value = "/import")
	@ResponseBody
	public AjaxResult importData(MultipartFile excel,final ImportTypeEnum type,final HttpSession session) throws InterruptedException {
		session.setAttribute("importing", true);
		session.setAttribute("importedCount", 0);
		final List<String> errorTips = Collections.synchronizedList(new LinkedList<String>());
		session.setAttribute("errorTips", errorTips);

		Workbook wb = null;
		try {
			wb = WorkbookFactory.create(excel.getInputStream());
		} catch (Exception e) {
			return new AjaxResult(false,"excel文件损坏");
		}
		final Sheet sheet = wb.getSheetAt(0);
		final int max = sheet.getLastRowNum();
		if(max == 0)
			return new AjaxResult(false,"excel没有内容");
		session.setAttribute("totalCount", max);
		final RowImporter rowImporter = (RowImporter) appContext.getBean(StringUtils.uncapitalize(type.toString())+"RowImporter");

		Executors.newFixedThreadPool(1).submit(new Runnable() {
			@Override
			public void run() {
				for (int i = 1; i <= max; i++) {
					rowImporter.importRow(session, sheet, i);
				}
			}
		});

		session.removeAttribute("importing");
		return new AjaxResult(true);
	}


	@RequestMapping(value = "/query-process")
	@ResponseBody
	public Map<String,Object> queryProcess(HttpSession session) {
		List<String> e = ((List<String>)(session.getAttribute("errorTips")));
		List<String> tmp = new ArrayList<String>(e);
		e.clear();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("totalCount", session.getAttribute("totalCount"));
		map.put("importedCount", session.getAttribute("importedCount"));
		map.put("errors",tmp);
		return map;
	}
}
