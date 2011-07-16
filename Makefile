include theos/makefiles/common.mk

TWEAK_NAME = HudSlider
HudSlider_FILES = Tweak.xm
HudSlider_FRAMEWORKS = UIKit CoreGraphics
include $(THEOS_MAKE_PATH)/tweak.mk
