package org.hustsse.cloud.service;

import java.util.List;

import org.hustsse.cloud.dao.InternshipDao;
import org.hustsse.cloud.dao.base.Page;
import org.hustsse.cloud.entity.Internship;
import org.hustsse.cloud.enums.WeekEnum;
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
		return internshipDao.find("from Internship i join fetch i.teacherTeam t join fetch i.teacher join fetch t.area a join fetch a.department where i.student.id = ? and i.year = ? and i.month = ?", stuId,year,month);
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

	public Page<Internship> findByConditions(Internship internship, int totalPages, Integer pageSize, Integer startYear,
			Integer startMonth, WeekEnum startWeek, Integer endYear, Integer endMonth, WeekEnum endWeek) {
		return null;
	}

}