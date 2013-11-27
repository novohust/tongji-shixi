package org.hustsse.cloud.service.dataimport;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.entity.Student;
import org.hustsse.cloud.enums.EnrollTypeEnum;
import org.hustsse.cloud.enums.GenderEnum;
import org.hustsse.cloud.enums.StuTypeEnum;
import org.hustsse.cloud.enums.TrueFalseEnum;
import org.hustsse.cloud.service.MajorService;
import org.hustsse.cloud.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentRowImporter extends RowImporter {

	@Autowired
	StudentService studentService;
	@Autowired
	MajorService majorService;

	@Override
	public void importRowInner(HttpSession session, Sheet sheet, int i) {
		Row r = sheet.getRow(i);
		if (!valEmptyRow(session, "空行", i, r))
			return;

		Student s = new Student();
		//学号
		//不能为空
		Cell stuCell = r.getCell(0);
		if (!valAnyEmptyCell(session, "学号不能为空", i, stuCell))
			return;
		stuCell.setCellType(Cell.CELL_TYPE_STRING);
		//重复？
		String stuNo = stuCell.getStringCellValue();
		if(studentService.findByStudentNo(stuNo) != null) {
			addErrorTip(session, "学号'" + stuNo + "'已被使用", i);
			return;
		}
		s.setStuNo(stuNo);

		// 姓名
		Cell nameCell = r.getCell(1);
		if (!valAnyEmptyCell(session, "姓名不能为空", i, nameCell))
			return;
		nameCell.setCellType(Cell.CELL_TYPE_STRING);
		s.setName(nameCell.getStringCellValue());

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
		s.setGender(g);

		//出生日期
		Cell birthCell = r.getCell(3);
		if(birthCell != null && !isContentEmpty(birthCell)) {
			if(birthCell.getCellType() == Cell.CELL_TYPE_NUMERIC && DateUtil.isCellDateFormatted(birthCell)) {
				double d = birthCell.getNumericCellValue();
	            Date date = DateUtil.getJavaDate(d);
	            s.setBirthday(date);
			}else {
				addErrorTip(session, "不合法的出生日期", i);
				return;
			}
		}

		// 专业
		// 为空？
		Cell majorCell = r.getCell(4);
		if (!valAnyEmptyCell(session, "专业不能为空", i, majorCell))
			return;
		// 存在？
		majorCell.setCellType(Cell.CELL_TYPE_STRING);
		String majorName = majorCell.getStringCellValue();
		Major major = majorService.findByName(majorName);
		if (major == null) {
			addErrorTip(session, "指定的专业'" + majorName + "'不存在", i);
			return;
		}
		s.setMajor(major);

		//导师
		Cell mentorCell = r.getCell(5);
		if (mentorCell != null && !isContentEmpty(mentorCell)) {
			mentorCell.setCellType(Cell.CELL_TYPE_STRING);
			s.setMentor(mentorCell.getStringCellValue());
		}

		// 年级
		Cell gradeCell = r.getCell(6);
		if (!valAnyEmptyCell(session, "年级不能为空", i, gradeCell))
			return;
		if(gradeCell.getCellType() != Cell.CELL_TYPE_NUMERIC) {
			addErrorTip(session, "不合法的年级", i);
			return;
		}
		s.setGrade((int)gradeCell.getNumericCellValue());

		// 班级
		Cell clazzCell = r.getCell(7);
		if (!valAnyEmptyCell(session, "班级不能为空", i, clazzCell))
			return;
		if(clazzCell.getCellType() != Cell.CELL_TYPE_NUMERIC) {
			addErrorTip(session, "不合法的班级", i);
			return;
		}
		s.setClazz((int)clazzCell.getNumericCellValue());

		// 类别
		Cell typeCell = r.getCell(8);
		if (!valAnyEmptyCell(session, "类别不能为空", i, typeCell))
			return;
		typeCell.setCellType(Cell.CELL_TYPE_STRING);
		StuTypeEnum t = StuTypeEnum.fromDesc(typeCell.getStringCellValue());
		if(t == null) {
			addErrorTip(session, "不合法的类别", i);
			return;
		}
		s.setType(t);

		// 证件号
		Cell identityNoCell = r.getCell(9);
		if (identityNoCell != null && !isContentEmpty(identityNoCell)) {
			identityNoCell.setCellType(Cell.CELL_TYPE_STRING);
			s.setIdentityNo(identityNoCell.getStringCellValue());
		}

		// 毕业学校
		Cell schoolCell = r.getCell(10);
		if (schoolCell != null && !isContentEmpty(schoolCell)) {
			schoolCell.setCellType(Cell.CELL_TYPE_STRING);
			s.setGraduateSchool(schoolCell.getStringCellValue());
		}

		// 录取类别
		Cell enrollTypeCell = r.getCell(11);
		if (!valAnyEmptyCell(session, "录取类别不能为空", i, enrollTypeCell))
			return;
		enrollTypeCell.setCellType(Cell.CELL_TYPE_STRING);
		EnrollTypeEnum e = EnrollTypeEnum.fromDesc(enrollTypeCell.getStringCellValue());
		if(e == null) {
			addErrorTip(session, "不合法的录取类别", i);
			return;
		}
		s.setEnrollType(e);

		// 医师执照
		Cell docQuaCell = r.getCell(12);
			if (docQuaCell != null && !isContentEmpty(docQuaCell)) {
				docQuaCell.setCellType(Cell.CELL_TYPE_STRING);
			TrueFalseEnum tfe = TrueFalseEnum.fromDesc(docQuaCell.getStringCellValue());
			if(tfe == null) {
				addErrorTip(session, "\"医师执照\"的值不合法", i);
				return;
			}
			s.setDocQualification(tfe);
		}

		// 医师注册
		Cell docRegCell = r.getCell(13);
		if (docRegCell != null && !isContentEmpty(docRegCell)) {
			docRegCell.setCellType(Cell.CELL_TYPE_STRING);
			TrueFalseEnum tfe = TrueFalseEnum.fromDesc(docRegCell.getStringCellValue());
			if(tfe == null ) {
				addErrorTip(session, "\"医师注册\"的值不合法", i);
				return;
			}
			s.setDocRegister(tfe);
		}

		// 描述
		Cell desCell = r.getCell(14);
		if(desCell != null && !isContentEmpty(desCell)) {
			desCell.setCellType(Cell.CELL_TYPE_STRING);
			s.setDescription(desCell.getStringCellValue());
		}

		// 保存
		studentService.add(s);
	}

}
