include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Foldr
Foldr_FILES = Tweak.xm
Foldr_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
