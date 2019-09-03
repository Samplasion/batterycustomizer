include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BatteryCustomizerPrefs
BatteryCustomizerPrefs_FILES = BCPRootListController.m
BatteryCustomizerPrefs_INSTALL_PATH = /Library/PreferenceBundles
BatteryCustomizerPrefs_FRAMEWORKS = UIKit
BatteryCustomizerPrefs_PRIVATE_FRAMEWORKS = Preferences
BatteryCustomizerPrefs_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BatteryCustomizerPrefs.plist$(ECHO_END)
