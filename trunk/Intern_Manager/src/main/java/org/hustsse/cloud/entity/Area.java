package org.hustsse.cloud.entity;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table
public class Area extends IdEntity {
	private String name;
	private Department department;
	private List<TeacherTeam> teacherTeams;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "department_id")
	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "area", cascade = { CascadeType.REMOVE })
	public List<TeacherTeam> getTeacherTeams() {
		return teacherTeams;
	}

	public void setTeacherTeams(List<TeacherTeam> teacherTeams) {
		this.teacherTeams = teacherTeams;
	}

}