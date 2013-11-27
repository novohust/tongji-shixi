package org.hustsse.cloud.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hustsse.cloud.enums.EnrollTypeEnum;
import org.hustsse.cloud.enums.GenderEnum;
import org.hustsse.cloud.enums.StuTypeEnum;
import org.hustsse.cloud.enums.TrueFalseEnum;

@Entity
@Table
public class Student extends IdEntity {

	private String stuNo;
	private String name;
	private Date birthday;
	private String mentor;
	private Integer grade;
	private Integer clazz;
	private StuTypeEnum type;
	private GenderEnum gender;
	private String avatar;
	private String race;
	private String identityNo;// 证件号
	private String graduateSchool; // 毕业学校
	private EnrollTypeEnum enrollType; // 录取类别
	private TrueFalseEnum docQualification; // 是否有医师资格
	private TrueFalseEnum docRegister; // 是否医师注册
	private String description;

	private Major major;
	private List<Internship> internships;

	@Enumerated(EnumType.STRING)
	public GenderEnum getGender() {
		return gender;
	}

	public void setGender(GenderEnum gender) {
		this.gender = gender;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "student_id")
	public Major getMajor() {
		return major;
	}

	public void setMajor(Major major) {
		this.major = major;
	}

	public String getStuNo() {
		return stuNo;
	}

	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getMentor() {
		return mentor;
	}

	public void setMentor(String mentor) {
		this.mentor = mentor;
	}

	public Integer getGrade() {
		return grade;
	}

	public void setGrade(Integer grade) {
		this.grade = grade;
	}

	@Enumerated(EnumType.STRING)
	public StuTypeEnum getType() {
		return type;
	}

	public void setType(StuTypeEnum type) {
		this.type = type;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public Integer getClazz() {
		return clazz;
	}

	public void setClazz(Integer clazz) {
		this.clazz = clazz;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRace() {
		return race;
	}

	public void setRace(String race) {
		this.race = race;
	}

	public String getIdentityNo() {
		return identityNo;
	}

	public void setIdentityNo(String identityNo) {
		this.identityNo = identityNo;
	}

	public String getGraduateSchool() {
		return graduateSchool;
	}

	public void setGraduateSchool(String graduateSchool) {
		this.graduateSchool = graduateSchool;
	}

	public EnrollTypeEnum getEnrollType() {
		return enrollType;
	}

	public void setEnrollType(EnrollTypeEnum enrollType) {
		this.enrollType = enrollType;
	}

	@Enumerated(EnumType.STRING)
	public TrueFalseEnum getDocQualification() {
		return docQualification;
	}

	public void setDocQualification(TrueFalseEnum docQualification) {
		this.docQualification = docQualification;
	}

	@Enumerated(EnumType.STRING)
	public TrueFalseEnum getDocRegister() {
		return docRegister;
	}

	public void setDocRegister(TrueFalseEnum docRegister) {
		this.docRegister = docRegister;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "student", cascade = { CascadeType.REMOVE })
	public List<Internship> getInternships() {
		return internships;
	}

	public void setInternships(List<Internship> internships) {
		this.internships = internships;
	}
}
