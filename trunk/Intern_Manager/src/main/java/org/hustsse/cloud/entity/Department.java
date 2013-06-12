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
public class Department extends IdEntity {
	private String name;
	private SecondarySubject secondarySubject;
	private List<Area> areas;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "secondary_subject_id")
	public SecondarySubject getSecondarySubject() {
		return secondarySubject;
	}

	public void setSecondarySubject(SecondarySubject secondarySubject) {
		this.secondarySubject = secondarySubject;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "department", cascade = { CascadeType.REMOVE })
	public List<Area> getAreas() {
		return areas;
	}

	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}

}
