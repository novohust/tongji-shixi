package org.hustsse.cloud.utils;

import java.util.Locale;
import java.util.ResourceBundle;

public class ResourceBundleUtil {
	private ResourceBundle resourceBundle;

	public ResourceBundleUtil(String resource) {
		this.resourceBundle = ResourceBundle.getBundle(resource);
	}

	public ResourceBundleUtil(String resource, Locale locale) {
		this.resourceBundle = ResourceBundle.getBundle(resource, locale);
	}

	public String getProperty(String key) {
		return resourceBundle.getString(key);
	}
}
