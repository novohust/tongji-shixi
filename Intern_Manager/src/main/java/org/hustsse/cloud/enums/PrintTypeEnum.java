package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum PrintTypeEnum {
	PagedByStu,NotPaged;

    private static ResourceBundleUtil util = new ResourceBundleUtil(PrintTypeEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }
}
