include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e

TWEAK_NAME = BatteryCustomizer
BatteryCustomizer_FILES = Tweak.xm
BatteryCustomizer_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += batterycustomizerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
