package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum ImportTypeEnum {
	SecondarySubject,Department,Area,TeacherTeam,Teacher,Major,Student;

    private static ResourceBundleUtil util = new ResourceBundleUtil(ImportTypeEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }
}
