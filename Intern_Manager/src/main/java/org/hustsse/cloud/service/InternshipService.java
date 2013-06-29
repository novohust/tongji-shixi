package org.hustsse.cloud.service;

import java.awt.image.RescaleOp;
import java.util.List;

import ognl.Ognl;
import ognl.OgnlException;

import org.apache.commons.lang3.StringUtils;
import org.apache.xmlbeans.impl.xb.xsdschema.RestrictionDocument.Restriction;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.InternshipDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Internship;
import org.hustsse.cloud.entity.Teacher;
import org.hustsse.cloud.enums.WeekEnum;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class InternshipService {

	@Autowired
	InternshipDao internshipDao;

	public Internship findById(Long id) {
		return internshipDao.findUniqueBy("id", id);
	}

	public List<Internship> findByMonth(Long stuId, Integer year, Integer month) {
		return internshipDao
				.find("from Internship i join fetch i.teacherTeam t join fetch i.teacher join fetch t.area a join fetch a.department where i.student.id = ? and i.year = ? and i.month = ?",
						stuId, year, month);
	}

	@Transactional(readOnly = false)
	public void add(List<Internship> internAddList, List<Long> internDelIdList) {
		for (Long id : internDelIdList) {
			internshipDao.delete(id);
		}
		for (Internship intern : internAddList) {
			internshipDao.save(intern);
		}
	}

	public Page<Internship> findByConditions(Internship query, Integer pageNum, Integer pageSize, Integer startYear, Integer startMonth, Integer endYear, Integer endMonth) {
		// Criteria的组装
		Criteria c = internshipDao.createCriteria();
		c.createAlias("teacherTeam", "tt").createAlias("tt.area", "a").createAlias("a.department", "d")
				.createAlias("d.secondarySubject", "ss")	// 教授组及以上
				.createAlias("teacher", "t")	//带教老师
				.createAlias("student", "s").createAlias("s.major", "m")
				;
		c.addOrder(Order.asc("s.name"));	// 保证同一个学生的实习记录在查询结果中在一起

		if (query != null) {
			// 教授组以上
			addEqByProperty(query, "teacherTeam.id", "tt.id", c);
			addEqByProperty(query, "teacherTeam.area.id", "a.id", c);
			addEqByProperty(query, "teacherTeam.area.department.id", "d.id", c);
			addEqByProperty(query, "teacherTeam.area.department.secondarySubject.id", "ss.id", c);

			//带教老师
			addEqByProperty(query, "teacher.id", "t.id", c);

			// 学生
			addEqByProperty(query, "student.major.id", "m.id", c);
			addEqByProperty(query, "student.type", "s.type", c);
			addEqByProperty(query, "student.grade", "s.grade", c);
			addEqByProperty(query, "student.clazz", "s.clazz", c);
			// 学号姓名导师用like	---- ??有必要吗
			addLikeByProperty(query, "student.name", "s.name", c, MatchMode.ANYWHERE);
			addLikeByProperty(query, "student.stuNo", "s.stuNo", c, MatchMode.ANYWHERE);
			addLikeByProperty(query, "student.mentor", "s.mentor", c, MatchMode.ANYWHERE);
		}
		// 时间
		// 开始时间
		if(startYear != null && startMonth != null) {
			c.add(Restrictions.or(
					Restrictions.and(Restrictions.eq("year", startYear),Restrictions.ge("month", startMonth)),	// 同一年>=月份
					Restrictions.gt("year", startYear)	// >年份
					));
		}
		// 结束时间
		if(endYear != null && endMonth != null) {
			c.add(Restrictions.or(
					Restrictions.and(Restrictions.eq("year", endYear),Restrictions.le("month", endMonth)),	// 同一年<=月份
					Restrictions.lt("year", endYear)	// <年份
					));
		}

		// 查询
		Page<Internship> page = new Page<Internship>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		internshipDao.findPage(page, c);
		return page;
	}

	/**
	 * 根据查询对象指定的属性为Criteria添加equal Restriction，如果属性值为null或为空字符串则忽略。
	 *
	 * @param query
	 *            查询对象
	 * @param ognlPath
	 *            属性路径，OGNL格式
	 * @param restrictionPath
	 *            添加Restriction使用的属性路径
	 * @param c
	 *            Criteria
	 */
	private void addEqByProperty(Internship query, String ognlPath, String restrictionPath, Criteria c) {
		try {
			Object val = Ognl.getValue(ognlPath, query);
			if (val == null || (val instanceof String && StringUtils.isBlank((String) val)))
				return;
			c.add(Restrictions.eq(restrictionPath, val));
		} catch (OgnlException e) {
			// 属性链中某个为null，未添加Restriction，忽略之。
		}
	}

	/**
	 * 根据查询对象指定的属性为Criteria添加like Restriction，属性值为null则忽略。
	 *
	 * @param query
	 *            查询对象
	 * @param ognlPath
	 *            属性路径，OGNL格式
	 * @param restrictionPath
	 *            添加Restriction使用的属性路径
	 * @param c
	 *            Criteria
	 */
	private void addLikeByProperty(Internship query, String ognlPath, String restrictionPath, Criteria c,MatchMode matchMode) {
		try {
			Object val = Ognl.getValue(ognlPath, query);
			if (val == null)
				return;
			c.add(Restrictions.like(restrictionPath, val.toString(),matchMode));
		} catch (OgnlException e) {
			// 属性链中某个为null，未添加Restriction，忽略之。
		}
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		internshipDao.delete(id);
	}

}