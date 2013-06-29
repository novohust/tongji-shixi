package org.hustsse.cloud.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.AreaDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Area;
import org.hustsse.cloud.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class AreaService {

	@Autowired
	AreaDao areaDao;

	@Transactional(readOnly = false)
	public void add(Area area) {
		areaDao.save(area);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		areaDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(Area aepartment) {
		areaDao.save(aepartment);
	}

	public Area findById(Long id) {
		return areaDao.findUniqueBy("id", id);
	}

	public Area findByIdWithDept(Long id) {
		return areaDao.findUnique("from Area a join fetch a.department d where a.id = ?", id);
	}


	public List<Area> findByDepartmentId(Long deptId) {
		return areaDao.findBy("department.id", deptId);
	}

	/**
	 * 分页按条件查询，目前只有查询页面调用
	 *
	 * @param department
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public Page<Area> findByConditions(Area area, Integer pageNum, Integer pageSize) {
		// Criteria的组装
		Criteria c = areaDao.createCriteria();
		// !!! fetchmode要在组装查询条件之前先设置，因为组装时有可能产生subCriteria，关联的"语境"不一样了。
		c.setFetchMode("department", FetchMode.JOIN); // 页面上要用到科室的名称
		c.setFetchMode("department.secondarySubject", FetchMode.JOIN); // 页面上要用到二级学科的名称

		if (area != null) {
			if (area.getDepartment() != null && area.getDepartment().getId() != null)
				c.add(Restrictions.eq("department.id", area.getDepartment().getId()));
			if (area.getDepartment() != null &&
					area.getDepartment().getSecondarySubject() != null &&
					area.getDepartment().getSecondarySubject().getId() != null)
				c = c.createCriteria("department").add(Restrictions.eq("secondarySubject.id", area.getDepartment().getSecondarySubject().getId()));
			if (StringUtils.isNotBlank(area.getName()))
				c.add(Restrictions.like("name", area.getName(), MatchMode.ANYWHERE));
		}
		// 查询
		Page<Area> page = new Page<Area>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		areaDao.findPage(page, c);
		return page;
	}

	public boolean isNameUsed(Long deptId, String name) {
		Area a = areaDao.findUnique("from Area where department.id = ? and name = ?",deptId,name);
		return a != null;
	}

	public Area findByAreaDeptSSName(String areaName, String deptName, String ssName) {
		Area a = areaDao.findUnique("from Area a join fetch a.department d join fetch d.secondarySubject s where s.name = ? and d.name = ? and a.name = ?",ssName,deptName,areaName);
		return a;
	}
}