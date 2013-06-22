package org.hustsse.cloud.enums;

import org.hustsse.cloud.utils.ResourceBundleUtil;

public enum WeekEnum {
	All(0),First(1),Second(2),Third(3),Fourth(4);

	private int value;

	WeekEnum(int v) {value = v;}

    private static ResourceBundleUtil util = new ResourceBundleUtil(WeekEnum.class.getName());

    public String getDescription() {
        return util.getProperty(this.toString());
    }

	public int value() {
		return value;
	}

	/**
	 * JSTL中必须要getter
	 * @return
	 */
	public int getValue() {
		return value();
	}

	public WeekEnum valueOf(int i) {
		for (WeekEnum w : WeekEnum.values()) {
			if(w.value() == i)return w;
		}
		return null;
	}
}
