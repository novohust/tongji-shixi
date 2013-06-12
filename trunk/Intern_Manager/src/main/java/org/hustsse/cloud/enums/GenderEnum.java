package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum GenderEnum {
	Male,Female;

    private static ResourceBundleUtil util = new ResourceBundleUtil(GenderEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }
}
