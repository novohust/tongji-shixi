package org.hustsse.cloud.dao;

import org.hustsse.cloud.dao.base.HibernateDao;
import org.hustsse.cloud.entity.Department;
import org.hustsse.cloud.entity.Major;
import org.springframework.stereotype.Repository;

@Repository
public class DepartmentDao extends HibernateDao<Department, Long> {

}
