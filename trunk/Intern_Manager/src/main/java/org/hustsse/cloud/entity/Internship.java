package org.hustsse.cloud.entity;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hustsse.cloud.enums.WeekEnum;

@Entity
@Table
public class Internship extends IdEntity {

	private int year;
	private int month;
	private WeekEnum weekType;

	private Student student;
	private TeacherTeam teacherTeam;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "student_id")
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "teacher_team_id")
	public TeacherTeam getTeacherTeam() {
		return teacherTeam;
	}

	public void setTeacherTeam(TeacherTeam team) {
		this.teacherTeam = team;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	@Enumerated(EnumType.STRING)
	public WeekEnum getWeekType() {
		return weekType;
	}

	public void setWeekType(WeekEnum weekType) {
		this.weekType = weekType;
	}




}
