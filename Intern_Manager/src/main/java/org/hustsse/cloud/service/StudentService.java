package org.hustsse.cloud.service;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.StudentDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class StudentService {

	@Autowired
	StudentDao studentDao;

	@Transactional(readOnly = false)
	public void add(Student t) {
		studentDao.save(t);
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		studentDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(Student t) {
		studentDao.save(t);
	}

	public Student findById(Long id) {
		return studentDao.findUniqueBy("id", id);
	}

	public Student findByIdWithMajor(Long id) {
		return studentDao.findUnique("from Student s join fetch s.major where s.id = ?", id);
	}

	/**
	 * 分页按条件查询，目前只有查询页面调用
	 *
	 * @param department
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	public Page<Student> findByConditions(Student query, Integer pageNum, Integer pageSize) {
		// Criteria的组装
		Criteria c = studentDao.createCriteria();
		c.setFetchMode("major", FetchMode.JOIN).add(Example.create(query).enableLike(MatchMode.ANYWHERE));
		if(query.getMajor() != null && query.getMajor().getId() != null) {
			c.add(Restrictions.eq("major.id", query.getMajor().getId()));
		}
		// 查询
		Page<Student> page = new Page<Student>(pageSize);
		page.setPageNo(pageNum);
		page.setAutoCount(true);
		studentDao.findPage(page, c);
		return page;
	}

	public Student findByStudentNo(String teacherNo) {
		return studentDao.findUniqueBy("stuNo", teacherNo);
	}
}