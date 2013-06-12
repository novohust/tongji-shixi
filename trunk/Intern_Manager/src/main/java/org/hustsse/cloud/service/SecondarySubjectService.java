package org.hustsse.cloud.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.SecondarySubjectDao;
import org.hustsse.cloud.entity.SecondarySubject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class SecondarySubjectService {

	@Autowired
	SecondarySubjectDao secondarySubjectDao;

	public SecondarySubject findByName(String name) {
		if(StringUtils.isBlank(name)) {
			throw new IllegalArgumentException("name不能为空");
		}
		return secondarySubjectDao.findUnique(Restrictions.eq("name", name.trim()));
	}

	@Transactional(readOnly = false)
	public void add(SecondarySubject secondarySubject) {
		secondarySubjectDao.save(secondarySubject);
	}

	public List<SecondarySubject> findAll() {
		return secondarySubjectDao.getAll();
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		secondarySubjectDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(SecondarySubject secondarySubject) {
		secondarySubjectDao.save(secondarySubject);
	}

	public SecondarySubject findById(Long id) {
		return secondarySubjectDao.findUniqueBy("id", id);
	}
}