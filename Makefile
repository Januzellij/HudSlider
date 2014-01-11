
ARCHS = armv7 arm64
TARGET = :clang
TWEAK_NAME = HudSlider
HudSlider_FILES = Tweak.xm
HudSlider_FRAMEWORKS = UIKit CoreGraphics
include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
