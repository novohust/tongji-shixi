package org.hustsse.cloud.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.criterion.Restrictions;
import org.hustsse.cloud.dao.MajorDao;
import org.hustsse.cloud.entity.Major;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class MajorService {

	@Autowired
	MajorDao majorDao;

	public Major findByName(String name) {
		if(StringUtils.isBlank(name)) {
			throw new IllegalArgumentException("name不能为空");
		}
		return majorDao.findUnique(Restrictions.eq("name", name.trim()));
	}

	@Transactional(readOnly = false)
	public void add(Major major) {
		majorDao.save(major);
	}

	public List<Major> findAll() {
		return majorDao.getAll();
	}

	@Transactional(readOnly = false)
	public void delete(Long id) {
		majorDao.delete(id);
	}

	@Transactional(readOnly = false)
	public void update(Major major) {
		majorDao.save(major);
	}

	public Major findById(Long id) {
		return majorDao.findUniqueBy("id", id);
	}
}