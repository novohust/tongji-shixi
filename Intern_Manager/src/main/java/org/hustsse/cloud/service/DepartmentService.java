package org.hustsse.cloud.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.DepartmentDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class DepartmentService {

	@Autowired
	DepartmentDao departmentDao;


	@Transactional(readOnly = false)
	public void add(Department department) {
		departmentDao.save(department);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		departmentDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(Department department) {
		departmentDao.save(department);
	}

	public Department findById(Long id) {
		return departmentDao.findUniqueBy("id", id);
	}

	public List<Department> findBySecondarySubjectId(Long ssId) {
		return departmentDao.findBy("secondarySubject.id", ssId);
	}

	/**
	 * 分页按条件查询，目前只有查询页面调用
	 *
	 * @param department
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public Page<Department> findByConditions(Department department, Integer pageNum, Integer pageSize) {
		// Criteria的组装
		Criteria c = departmentDao.createCriteria();
		if (department != null) {
			if (department.getSecondarySubject() != null && department.getSecondarySubject().getId() != null)
				c.add(Restrictions.eq("secondarySubject.id", department.getSecondarySubject().getId()));
			if (StringUtils.isNotBlank(department.getName()))
				c.add(Restrictions.like("name", department.getName(),MatchMode.ANYWHERE));
		}
		c.setFetchMode("secondarySubject", FetchMode.JOIN);	//页面上要用到二级学科的名称
		// 查询
		Page<Department> page = new Page<Department>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		departmentDao.findPage(page, c);
		return page;
	}

	public List<Department> findAll() {
		return departmentDao.getAll();
	}
}