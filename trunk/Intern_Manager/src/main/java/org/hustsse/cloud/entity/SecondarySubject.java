package org.hustsse.cloud.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table
public class SecondarySubject extends IdEntity {
	private String name;

	private List<Department> departments;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "secondarySubject", cascade = { CascadeType.REMOVE })
	public List<Department> getDepartments() {
		return departments;
	}

	public void setDepartments(List<Department> departments) {
		this.departments = departments;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
