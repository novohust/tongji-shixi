package org.hustsse.cloud.service;

import java.util.ArrayList;
import java.util.List;

import org.hustsse.cloud.dao.UserDao;
import org.hustsse.cloud.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly=true)
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	UserDao userDao;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		User u = userDao.findUniqueBy("userName", userName);
		if (u == null)
			throw new UsernameNotFoundException("用户不存在");
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>();
		authList.add(new SimpleGrantedAuthority(u.getRole().toString()));
		return new org.springframework.security.core.userdetails.User(u.getUserName(), u.getPassword(), true, true, true, true, authList);
	}
}
