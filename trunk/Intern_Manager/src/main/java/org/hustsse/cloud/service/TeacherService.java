package org.hustsse.cloud.service;

import java.util.List;

import ognl.Ognl;
import ognl.OgnlException;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.TeacherDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.Teacher;
import org.hustsse.cloud.utils.ReflectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class TeacherService {

	@Autowired
	TeacherDao teacherDao;

	@Transactional(readOnly = false)
	public void add(Teacher t) {
		teacherDao.save(t);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		teacherDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(Teacher t) {
		teacherDao.save(t);
	}

	public Teacher findById(Long id) {
		return teacherDao.findUniqueBy("id", id);
	}

	public Teacher findByIdWithTeamAndAreaAndDept(Long id) {
		return teacherDao.findUnique("from Teacher a join fetch a.teacherTeam" + " join fetch a.teacherTeam.area"
				+ " join fetch a.teacherTeam.area.department where a.id = ?", id);
	}

	public List<Teacher> findByTeamId(Long areaId) {
		return teacherDao.findBy("teacherTeam.id", areaId);
	}

	/**
	 * 分页按条件查询，目前只有查询页面调用
	 *
	 * @param department
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public Page<Teacher> findByConditions(Teacher query, Integer pageNum, Integer pageSize) {
		// Criteria的组装
		Criteria c = teacherDao.createCriteria();
		c.createAlias("teacherTeam", "t").createAlias("t.area", "a").createAlias("a.department", "d")
				.createAlias("d.secondarySubject", "ss");

		if (query != null) {
			addEqByProperty(query, "teacherNo", "teacherNo", c);
			addEqByProperty(query, "teacherTeam.id", "t.id", c);
			addEqByProperty(query, "teacherTeam.area.id", "a.id", c);
			addEqByProperty(query, "teacherTeam.area.department.id", "d.id", c);
			addEqByProperty(query, "teacherTeam.area.department.secondarySubject.id", "ss.id", c);

			// if (query.getTeacherTeam() != null &&
			// query.getTeacherTeam().getId() != null)
			// c.add(Restrictions.eq("t.id", query.getTeacherTeam().getId()));
			//
			// if (query.getTeacherTeam() != null &&
			// query.getTeacherTeam().getArea() != null &&
			// query.getTeacherTeam().getArea().getId() != null)
			// c.add(Restrictions.eq("a.id",
			// query.getTeacherTeam().getArea().getId()));
			//
			// if (query.getTeacherTeam() != null &&
			// query.getTeacherTeam().getArea() != null &&
			// query.getTeacherTeam().getArea().getDepartment() != null &&
			// query.getTeacherTeam().getArea().getDepartment().getId() != null)
			// c.add(Restrictions.eq("d.id",
			// query.getTeacherTeam().getArea().getDepartment().getId()));
			//
			//
			// if (query.getTeacherTeam() != null &&
			// query.getTeacherTeam().getArea() != null &&
			// query.getTeacherTeam().getArea().getDepartment() != null &&
			// query.getTeacherTeam().getArea().getDepartment().getSecondarySubject()
			// != null &&
			// query.getTeacherTeam().getArea().getDepartment().getSecondarySubject().getId()
			// != null)
			// c = c.add(Restrictions.eq("ss.id",
			// query.getTeacherTeam().getArea().getDepartment().getSecondarySubject().getId()));

			if (StringUtils.isNotBlank(query.getName()))
				c.add(Restrictions.like("name", query.getName(), MatchMode.ANYWHERE));
		}
		// 查询
		Page<Teacher> page = new Page<Teacher>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		teacherDao.findPage(page, c);
		return page;
	}

	/**
	 * 根据查询对象指定的属性为Criteria添加Restriction，如果属性值为null或为空字符串则忽略。
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
	private void addEqByProperty(Teacher query, String ognlPath, String restrictionPath, Criteria c) {
		try {
			Object val = Ognl.getValue(ognlPath, query);
			if (val == null ||(val instanceof String && StringUtils.isBlank((String)val)))
				return;
			c.add(Restrictions.eq(restrictionPath, val));
		} catch (OgnlException e) {
			// 属性链中某个为null，未添加Restriction，忽略之。
		}
	}

	public Teacher findByTeacherNo(String teacherNo) {
		return teacherDao.findUniqueBy("teacherNo", teacherNo);
	}

	public List<Teacher> findAll() {
		return teacherDao.getAll();
	}
}