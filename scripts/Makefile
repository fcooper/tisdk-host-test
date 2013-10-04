-include Rules.make

all: linux matrix-gui arm-benchmarks am-sysinfo matrix-gui-browser refresh-screen qt-tstat oprofile-example u-boot-spl wireless ti-crypto-examples 
clean: linux_clean matrix-gui_clean arm-benchmarks_clean am-sysinfo_clean matrix-gui-browser_clean refresh-screen_clean qt-tstat_clean oprofile-example_clean u-boot-spl_clean wireless_clean ti-crypto-examples_clean 
install: linux_install matrix-gui_install arm-benchmarks_install am-sysinfo_install matrix-gui-browser_install refresh-screen_install qt-tstat_install oprofile-example_install u-boot-spl_install wireless_install ti-crypto-examples_install 
# Kernel build targets
linux:
	@echo =================================
	@echo     Building the Linux Kernel
	@echo =================================
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) tisdk_$(PLATFORM)_defconfig
	$(MAKE) -j $(MAKE_JOBS) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) LOADADDR=0x80008000 uImage
	$(MAKE) -j $(MAKE_JOBS) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules

linux_install:
	@echo ===================================
	@echo     Installing the Linux Kernel
	@echo ===================================
	install -d $(DESTDIR)/boot
	install $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/uImage $(DESTDIR)/boot
	install $(LINUXKERNEL_INSTALL_DIR)/vmlinux $(DESTDIR)/boot
	install $(LINUXKERNEL_INSTALL_DIR)/System.map $(DESTDIR)/boot
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) INSTALL_MOD_PATH=$(DESTDIR) modules_install

linux_clean:
	@echo =================================
	@echo     Cleaning the Linux Kernel
	@echo =================================
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) mrproper
# Make Rules for matrix-gui project
matrix-gui:
	@echo =============================
	@echo      Building Matrix GUI
	@echo =============================
	@echo    NOTHING TO DO.  COMPILATION NOT REQUIRED

matrix-gui_clean:
	@echo =============================
	@echo      Cleaning Matrix GUI
	@echo =============================
	@echo    NOTHING TO DO.

matrix-gui_install:
	@echo =============================
	@echo     Installing Matrix GUI
	@echo =============================
	@cd example-applications; cd `find . -name "*matrix-gui-2.0*"`; make install
# arm-benchmarks build targets
arm-benchmarks:
	@echo =============================
	@echo    Building ARM Benchmarks
	@echo =============================
	@cd example-applications; cd `find . -name "*arm-benchmarks*"`; make -j $(MAKE_JOBS)

arm-benchmarks_clean:
	@echo =============================
	@echo    Cleaning ARM Benchmarks
	@echo =============================
	@cd example-applications; cd `find . -name "*arm-benchmarks*"`; make clean

arm-benchmarks_install:
	@echo ==============================================
	@echo   Installing ARM Benchmarks - Release version
	@echo ==============================================
	@cd example-applications; cd `find . -name "*arm-benchmarks*"`; make install

arm-benchmarks_install_debug:
	@echo ============================================
	@echo   Installing ARM Benchmarks - Debug Version
	@echo ============================================
	@cd example-applications; cd `find . -name "*arm-benchmarks*"`; make install_debug
# am-sysinfo build targets
am-sysinfo:
	@echo =============================
	@echo    Building AM Sysinfo
	@echo =============================
	@cd example-applications; cd `find . -name "*am-sysinfo*"`; make -j $(MAKE_JOBS)

am-sysinfo_clean:
	@echo =============================
	@echo    Cleaning AM Sysinfo
	@echo =============================
	@cd example-applications; cd `find . -name "*am-sysinfo*"`; make clean

am-sysinfo_install:
	@echo ===============================================
	@echo     Installing AM Sysinfo - Release version
	@echo ===============================================
	@cd example-applications; cd `find . -name "*am-sysinfo*"`; make install

am-sysinfo_install_debug:
	@echo =============================================
	@echo     Installing AM Sysinfo - Debug version
	@echo =============================================
	@cd example-applications; cd `find . -name "*am-sysinfo*"`; make install_debug
# matrix-gui-browser build targets
matrix-gui-browser:
	@echo =================================
	@echo    Building Matrix GUI Browser
	@echo =================================
	@cd example-applications; cd `find . -name "*matrix-gui-browser*"`; make -j $(MAKE_JOBS) -f Makefile.build release

matrix-gui-browser_clean:
	@echo =================================
	@echo    Cleaning Matrix GUI Browser
	@echo =================================
	@cd example-applications; cd `find . -name "*matrix-gui-browser*"`; make -f Makefile.build clean

matrix-gui-browser_install:
	@echo ===================================================
	@echo   Installing Matrix GUI Browser - Release version
	@echo ===================================================
	@cd example-applications; cd `find . -name "*matrix-gui-browser*"`; make -f Makefile.build install

matrix-gui-browser_install_debug:
	@echo =================================================
	@echo   Installing Matrix GUI Browser - Debug Version
	@echo =================================================
	@cd example-applications; cd `find . -name "*matrix-gui-browser*"`; make -f Makefile.build install_debug
# refresh-screen build targets
refresh-screen:
	@echo =============================
	@echo    Building Refresh Screen
	@echo =============================
	@cd example-applications; cd `find . -name "*refresh-screen*"`; make -j $(MAKE_JOBS) -f Makefile.build release

refresh-screen_clean:
	@echo =============================
	@echo    Cleaning Refresh Screen
	@echo =============================
	@cd example-applications; cd `find . -name "*refresh-screen*"`; make -f Makefile.build clean

refresh-screen_install:
	@echo ================================================
	@echo   Installing Refresh Screen - Release version
	@echo ================================================
	@cd example-applications; cd `find . -name "*refresh-screen*"`; make -f Makefile.build install

refresh-screen_install_debug:
	@echo ==============================================
	@echo   Installing Refresh Screen - Debug Version
	@echo ==============================================
	@cd example-applications; cd `find . -name "*refresh-screen*"`; make -f Makefile.build install_debug
# QT Thermostat build targets
qt-tstat:
	@echo ================================
	@echo    Building QT Thermostat App
	@echo ================================
	@cd example-applications; cd `find . -name "*qt-tstat*"`; make -j $(MAKE_JOBS) -f Makefile.build release

qt-tstat_clean:
	@echo ================================
	@echo    Cleaning QT Thermostat App
	@echo ================================
	@cd example-applications; cd `find . -name "*qt-tstat*"`; make -f Makefile.build clean

qt-tstat_install:
	@echo ===================================================
	@echo   Installing QT Thermostat App - Release version
	@echo ===================================================
	@cd example-applications; cd `find . -name "*qt-tstat*"`; make -f Makefile.build install

qt-tstat_install_debug:
	@echo =================================================
	@echo   Installing QT Thermostat App - Debug version
	@echo =================================================
	@cd example-applications; cd `find . -name "*qt-tstat*"`; make -f Makefile.build install_debug
# oprofile-example build targets
oprofile-example:
	@echo =============================
	@echo    Building OProfile Example
	@echo =============================
	@cd example-applications; cd `find . -name "*oprofile-example*"`; make -j $(MAKE_JOBS)

oprofile-example_clean:
	@echo =============================
	@echo    Cleaning OProfile Example
	@echo =============================
	@cd example-applications; cd `find . -name "*oprofile-example*"`; make clean

oprofile-example_install:
	@echo =============================================
	@echo     Installing OProfile Example - Debug version
	@echo =============================================
	@cd example-applications; cd `find . -name "*oprofile-example*"`; make install
# u-boot build targets
u-boot-spl: u-boot
u-boot-spl_clean: u-boot_clean
u-boot-spl_install: u-boot_install

u-boot:
	$(MAKE) -j $(MAKE_JOBS) -C $(TI_SDK_PATH)/board-support/u-boot-* CROSS_COMPILE=$(CROSS_COMPILE) $(UBOOT_MACHINE)
	$(MAKE) -j $(MAKE_JOBS) -C $(TI_SDK_PATH)/board-support/u-boot-* CROSS_COMPILE=$(CROSS_COMPILE)

u-boot_clean:
	$(MAKE) -C $(TI_SDK_PATH)/board-support/u-boot-* CROSS_COMPILE=$(CROSS_COMPILE) clean

u-boot_install:
	install -d $(DESTDIR)/boot
	install $(TI_SDK_PATH)/board-support/u-boot-*/u-boot.img $(DESTDIR)/boot
	install $(TI_SDK_PATH)/board-support/u-boot-*/MLO $(DESTDIR)/boot
	install $(TI_SDK_PATH)/board-support/u-boot-*/u-boot.map $(DESTDIR)/boot
# Wireless build targets
wireless: compat-modules bt-firmware bt-enable
wireless_install: compat-modules_install bt-firmware_install bt-enable_install
wireless_clean: compat-modules_clean bt-firmware_clean bt-enable_clean

bt-firmware:
	@echo ============================
	@echo      Building bt-firmware
	@echo ============================
	@echo    NOTHING TO DO.  COMPILATION NOT REQUIRED

bt-firmware_install:
	@echo ==============================
	@echo      Installing bt-firmware
	@echo ==============================
	@cd board-support/extra-drivers; cd `find . -name "*bt-firmware*"`; make DEST_DIR=${DESTDIR} BASE_LIB_DIR="/lib" PLATFORM=${PLATFORM} install

bt-firmware_clean:
	@echo ============================
	@echo      Cleaning bt-firmware
	@echo ============================
	@echo    NOTHING TO DO.

bt-enable: linux
	@echo ===========================
	@echo      Building bt-enable
	@echo ===========================
	@cd board-support/extra-drivers; cd `find . -name "*bt-enable*"`; \
	make -j $(MAKE_JOBS) DEST_DIR=${DESTDIR} PLATFORM=${PLATFORM}

bt-enable_install:
	@echo ============================
	@echo      Installing bt-enable
	@echo ============================
	@cd board-support/extra-drivers; cd `find . -name "*bt-enable*"`; \
	make DEST_DIR=${DESTDIR} PLATFORM=${PLATFORM} install

bt-enable_clean:
	@echo ===========================
	@echo      Cleaning bt-enable
	@echo ===========================
	@cd board-support/extra-drivers; cd `find . -name "*bt-enable*"`; \
	make DEST_DIR=${DESTDIR} PLATFORM=${PLATFORM} clean

compat-modules: linux
	@echo ================================
	@echo      Building compat-modules
	@echo ================================
	@cd board-support/extra-drivers; \
	cd `find . -maxdepth 1 -name "*compat-bluetooth*"`; \
	./scripts/driver-select bt; make -j $(MAKE_JOBS) DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm; \
	cd ..; \
	cd `find . -maxdepth 1 -name "*compat-wireless*"`; \
	./scripts/driver-select wl12xx; make -j $(MAKE_JOBS) DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm

compat-modules_install:
	@echo ==================================
	@echo      Installing compat-modules
	@echo ==================================
	@cd board-support/extra-drivers; \
	cd `find . -maxdepth 1 -name "*compat-bluetooth*"`; \
	make DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} INSTALL_MOD_PATH=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm install-modules; \
	cd ..; \
	cd `find . -maxdepth 1 -name "*compat-wireless*"`; \
	make DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} INSTALL_MOD_PATH=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm install-modules

compat-modules_clean:
	@echo ================================
	@echo      Cleaning compat-wireless
	@echo ================================
	@cd board-support/extra-drivers; \
	cd `find . -maxdepth 1 -name "*compat-bluetooth*"`; \
	make DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm clean; \
	cd ..; \
	cd `find . -maxdepth 1 -name "*compat-wireless*"`; \
	make DEPMOD=echo DESTDIR=${DESTDIR} KLIB_BUILD=${LINUXKERNEL_INSTALL_DIR} KLIB=${DESTDIR} CROSS_COMPILE=${CROSS_COMPILE} ARCH=arm clean
# ti-crypto-examples build targets
ti-crypto-examples:
	@echo =================================
	@echo    Building TI Crypto Examples
	@echo =================================
	@cd example-applications; cd `find . -name "*ti-crypto-examples*"`; make -j $(MAKE_JOBS)

ti-crypto-examples_clean:
	@echo =================================
	@echo    Cleaning TI Crypto Examples
	@echo =================================
	@cd example-applications; cd `find . -name "*ti-crypto-examples*"`; make clean

ti-crypto-examples_install:
	@echo ===================================================
	@echo   Installing TI Crypto Examples - Release version
	@echo ===================================================
	@cd example-applications; cd `find . -name "*ti-crypto-examples*"`; make install

ti-crypto-examples_install_debug:
	@echo =================================================
	@echo   Installing TI Crypto Examples - Debug Version
	@echo =================================================
	@cd example-applications; cd `find . -name "*ti-crypto-examples*"`; make install_debug
