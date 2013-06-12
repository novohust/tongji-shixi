package org.hustsse.cloud.dao;

import org.hustsse.cloud.dao.base.HibernateDao;
import org.hustsse.cloud.entity.Major;
import org.hustsse.cloud.entity.Student;
import org.springframework.stereotype.Repository;

@Repository
public class StudentDao extends HibernateDao<Student, Long> {

}
