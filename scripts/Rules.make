#platform
PLATFORM=am335x-evm

#Architecture
ARCH=armv7-a

MAKE_JOBS=24

#u-boot machine
UBOOT_MACHINE=am335x_evm_config

#Points to the root of the TI SDK
export TI_SDK_PATH=/home/a0273011/Desktop/sdk-test/sdk-test/ti-sdk-am335x-evm-07.00.00.00

#root of the target file system for installing applications
DESTDIR=/home/a0273011/Desktop/sdk-test/sdk-test/ti-sdk-am335x-evm-07.00.00.00/targetNFS

#Points to the root of the Linux libraries and headers matching the
#demo file system.
export LINUX_DEVKIT_PATH=$(TI_SDK_PATH)/linux-devkit

#Cross compiler prefix
export CROSS_COMPILE=$(LINUX_DEVKIT_PATH)/sysroots/i686-arago-linux/usr/bin/arm-linux-gnueabihf-

#Default CC value to be used when cross compiling.  This is so that the
#GNU Make default of "cc" is not used to point to the host compiler
export CC=$(CROSS_COMPILE)gcc

#Location of environment-setup file
export ENV_SETUP=$(LINUX_DEVKIT_PATH)/environment-setup

#The directory that points to the SDK kernel source tree
LINUXKERNEL_INSTALL_DIR=$(TI_SDK_PATH)/board-support/__KERNEL_NAME__

CFLAGS= -march=armv7-a -marm -mthumb-interwork -mfloat-abi=hard -mfpu=neon -mtune=cortex-a8
