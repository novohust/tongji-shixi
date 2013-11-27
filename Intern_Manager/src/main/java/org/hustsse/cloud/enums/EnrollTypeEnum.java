package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum EnrollTypeEnum {
	NonDirectional,// 非定向
	WeiPei;//委培

    private static ResourceBundleUtil util = new ResourceBundleUtil(EnrollTypeEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }

	public static EnrollTypeEnum fromDesc(String desc) {
		for (EnrollTypeEnum g : EnrollTypeEnum.values()) {
			if(g.getDescription().equals(desc))
				return g;
		}
		return null;
	}
}
