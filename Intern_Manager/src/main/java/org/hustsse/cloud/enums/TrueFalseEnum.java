package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum TrueFalseEnum {
	True,False;

    private static ResourceBundleUtil util = new ResourceBundleUtil(TrueFalseEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }

	public static TrueFalseEnum fromDesc(String desc) {
		for (TrueFalseEnum g : TrueFalseEnum.values()) {
			if(g.getDescription().equals(desc))
				return g;
		}
		return null;
	}
}
