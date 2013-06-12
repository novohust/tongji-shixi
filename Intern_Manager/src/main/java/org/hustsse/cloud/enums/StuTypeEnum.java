package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum StuTypeEnum {
	Bachelor, Master, Doctor;

    private static ResourceBundleUtil util = new ResourceBundleUtil(StuTypeEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }
}
