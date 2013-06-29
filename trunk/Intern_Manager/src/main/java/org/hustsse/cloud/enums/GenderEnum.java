package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum GenderEnum {
	Male,Female;

    private static ResourceBundleUtil util = new ResourceBundleUtil(GenderEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }

	public static GenderEnum fromDesc(String desc) {
		for (GenderEnum g : GenderEnum.values()) {
			if(g.getDescription().equals(desc))
				return g;
		}
		return null;
	}
}
