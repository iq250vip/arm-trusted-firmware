#
# Copyright (c) 2017-2018, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

include lib/xlat_tables_v2/xlat_tables.mk

AW_PLAT			:=	plat/allwinner

PLAT_INCLUDES		:=	-Iinclude/plat/arm/common/		\
				-Iinclude/plat/arm/common/aarch64	\
				-I${AW_PLAT}/common/include		\
				-I${AW_PLAT}/${PLAT}/include

PLAT_BL_COMMON_SOURCES	:=	drivers/console/${ARCH}/console.S	\
				drivers/ti/uart/${ARCH}/16550_console.S	\
				${XLAT_TABLES_LIB_SRCS}			\
				${AW_PLAT}/common/plat_helpers.S	\
				${AW_PLAT}/common/sunxi_common.c

BL31_SOURCES		+=	drivers/arm/gic/common/gic_common.c	\
				drivers/arm/gic/v2/gicv2_helpers.c	\
				drivers/arm/gic/v2/gicv2_main.c		\
				drivers/delay_timer/delay_timer.c	\
				drivers/delay_timer/generic_delay_timer.c \
				lib/cpus/${ARCH}/cortex_a53.S		\
				plat/common/plat_gicv2.c		\
				plat/common/plat_psci_common.c		\
				${AW_PLAT}/common/sunxi_bl31_setup.c	\
				${AW_PLAT}/common/sunxi_cpu_ops.c	\
				${AW_PLAT}/common/sunxi_pm.c		\
				${AW_PLAT}/sun50i_a64/sunxi_power.c	\
				${AW_PLAT}/common/sunxi_security.c	\
				${AW_PLAT}/common/sunxi_topology.c

# The bootloader is guaranteed to only run on CPU 0 by the boot ROM.
COLD_BOOT_SINGLE_CPU		:=	1

# Enable workarounds for Cortex-A53 errata. Allwinner uses at least r0p4.
ERRATA_A53_835769		:=	1
ERRATA_A53_843419		:=	1
ERRATA_A53_855873		:=	1

# Disable the PSCI platform compatibility layer.
ENABLE_PLAT_COMPAT		:= 	0

MULTI_CONSOLE_API		:=	1

# Prohibit using deprecated interfaces. We rely on this for this platform.
ERROR_DEPRECATED		:=	1

# The reset vector can be changed for each CPU.
PROGRAMMABLE_RESET_ADDRESS	:=	1

# Allow mapping read-only data as execute-never.
SEPARATE_CODE_AND_RODATA	:=	1

# BL31 gets loaded alongside BL33 (U-Boot) by U-Boot's SPL
RESET_TO_BL31			:=	1
