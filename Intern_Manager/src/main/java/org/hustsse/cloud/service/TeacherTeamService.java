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
import org.hustsse.cloud.dao.TeacherTeamDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.TeacherTeam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class TeacherTeamService {

	@Autowired
	TeacherTeamDao teacherTeamDao;

	@Transactional(readOnly = false)
	public void add(TeacherTeam t) {
		teacherTeamDao.save(t);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		teacherTeamDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(TeacherTeam t) {
		teacherTeamDao.save(t);
	}

	public TeacherTeam findById(Long id) {
		return teacherTeamDao.findUniqueBy("id", id);
	}

	public TeacherTeam findByIdWithAreaAndDept(Long id) {
		return teacherTeamDao.findUnique("from TeacherTeam a join fetch a.area b" +
				" join fetch b.department where a.id = ?", id);
	}


	public List<TeacherTeam> findByAreaId(Long areaId) {
		return teacherTeamDao.findBy("area.id", areaId);
	}

	/**
	 * 分页按条件查询，目前只有查询页面调用
	 *
	 * @param department
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public Page<TeacherTeam> findByConditions(TeacherTeam team, Integer pageNum, Integer pageSize) {
		// Criteria的组装
		Criteria c = teacherTeamDao.createCriteria();
		c.createAlias("area", "a").createAlias("a.department", "d").createAlias("d.secondarySubject", "ss");

		if (team != null) {
			if (team.getArea() != null &&
					team.getArea().getId() != null)
				c.add(Restrictions.eq("a.id", team.getArea().getId()));

			if (team.getArea() != null &&
					team.getArea().getDepartment() != null &&
					team.getArea().getDepartment().getId() != null)
				c.add(Restrictions.eq("d.id", team.getArea().getDepartment().getId()));

			if (team.getArea() != null &&
					team.getArea().getDepartment() != null &&
					team.getArea().getDepartment().getSecondarySubject() != null &&
					team.getArea().getDepartment().getSecondarySubject().getId() != null)
				c = c.add(Restrictions.eq("ss.id", team.getArea().getDepartment().getSecondarySubject().getId()));

			if (StringUtils.isNotBlank(team.getName()))
				c.add(Restrictions.like("name", team.getName(), MatchMode.ANYWHERE));
		}
		// 查询
		Page<TeacherTeam> page = new Page<TeacherTeam>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		teacherTeamDao.findPage(page, c);
		return page;
	}

	public boolean isNameUsed(Long areaId, String name) {
		TeacherTeam t = teacherTeamDao.findUnique("from TeacherTeam where area.id = ? and name = ?",areaId,name);
		return t != null;
	}

	public TeacherTeam findByAreaDeptSSName(String teamName, String areaName, String deptName, String ssName) {
		return teacherTeamDao.findUnique("from TeacherTeam tt join fetch tt.area a join fetch a.department d join fetch d.secondarySubject ss where tt.name = ? and a.name = ? and d.name = ? and ss.name = ?",teamName,areaName,deptName,ssName);
	}
}