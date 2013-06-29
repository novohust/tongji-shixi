package org.hustsse.cloud.dao;

import org.hustsse.cloud.dao.base.HibernateDao;
import org.hustsse.cloud.entity.User;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends HibernateDao<User, Long> {

}
