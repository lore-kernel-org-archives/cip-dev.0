Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1545CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 07:11:28 +0000 (UTC)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 by mx.groups.io with SMTP id smtpd.web10.14259.1755673887295428106
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 00:11:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=uqpaFt8J;
 spf=pass (domain: ti.com, ip: 198.47.23.235, mailfrom: s-adivi@ti.com)
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K7BMi6195291;
	Wed, 20 Aug 2025 02:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755673882;
	bh=rsTtN2GS2XyF2Ogqhb+HFylAIzx791IGn1ALsuG1x9I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uqpaFt8J0tFJUPuWuohxqcAdYpji48Rn6jG7k1/Jah6j4KvSedo/RXE64vcl/ozro
	 JWjPc5GM8SbVrP+Bc39eKrT5lZydoyl+xtNzSZKuffMw8P1KlJSLfME1lxomcYCZ/8
	 3i1JTA4by9ikar6bdszsIXaT1pNwAIKbRhgLyago=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K7BMER1871116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 02:11:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 02:11:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 02:11:22 -0500
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K7BK4N118442;
	Wed, 20 Aug 2025 02:11:20 -0500
Message-ID: <5bc3951d-cceb-4d95-86bd-46b3a1eb801f@ti.com>
Date: Wed, 20 Aug 2025 12:41:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] Add support for TI AM62Px
 SK platform
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <vigneshr@ti.com>, <dinesh.kumar@toshiba-tsip.com>
References: <20250731082421.292376-1-s-adivi@ti.com>
 <20250731082421.292376-2-s-adivi@ti.com>
 <841cce01-62d9-429c-9e6d-6333c79ed9fb@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <841cce01-62d9-429c-9e6d-6333c79ed9fb@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 07:11:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19768

Hi Jan

On 8/18/25 22:44, Jan Kiszka wrote:
> On 31.07.25 10:24, Sai Sree Kartheek Adivi wrote:
>> - Add machine conf and and kas yml files for TI AM62Px SK
>> - Add new u-boot 2025.01 recipe as support for AM62P is only available
>>    from 2025.01
>> - Add new patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>>    to enable KASLR support. This is already upstreamed to u-boot at [1].
>> - Add new recipes for trusted-firmware-a, optee-os
>>
>> [1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   Kconfig                                       |  5 ++
>>   conf/machine/ti-am62px-sk.conf                | 32 ++++++++++
>>   kas/board/ti-am62px-sk.yml                    | 13 ++++
>>   recipes-bsp/optee-os/files/rules-ti.tmpl      | 21 +++++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 37 ++++++++++++
> 
> For QEMU, I'm now on 4.7.0 - please update so that we can probably reuse
> bits.

Yes.

> 
>>   .../trusted-firmware-a-ti-k3_2.13.bb          | 18 ++++++
>>   ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++++
>>   recipes-bsp/u-boot/files/rules-ti.tmpl        | 33 ++++++++++
>>   recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 ++++++++++
>>   .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 60 +++++++++++++++++++
> 
> And here, we should go for 2025.07. I will soon bump the existing u-boot
> users to that version.

I've the changes ready. Will post the series today with these updates 
removing the optee-ftpm part for now. As that is not yet functional.

> 
>>   wic/ti-am62px-sk.wks                          | 11 ++++
>>   11 files changed, 301 insertions(+)
>>   create mode 100644 conf/machine/ti-am62px-sk.conf
>>   create mode 100644 kas/board/ti-am62px-sk.yml
>>   create mode 100755 recipes-bsp/optee-os/files/rules-ti.tmpl
>>   create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>>   create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>>   create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>>   create mode 100755 recipes-bsp/u-boot/files/rules-ti.tmpl
>>   create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
>>   create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>>   create mode 100644 wic/ti-am62px-sk.wks
>>
>> diff --git a/Kconfig b/Kconfig
>> index e078892..1b7e428 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -77,6 +77,10 @@ config TARGET_QEMU_RISCV64
>>   	select ARCH_RISCV64
>>   	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>>   
>> +config TARGET_TI_AM62PX_SK
>> +	bool "Texas Instruments AM62Px SK"
>> +	select ARCH_ARM64
>> +
>>   endchoice
>>   
>>   config KAS_INCLUDE_BOARD
>> @@ -89,6 +93,7 @@ config KAS_INCLUDE_BOARD
>>   	default "kas/board/bbb.yml" if TARGET_BBB
>>   	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>>   	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>>   
>>   comment "Kernel options"
>>   
>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
>> new file mode 100644
>> index 0000000..6e59250
>> --- /dev/null
>> +++ b/conf/machine/ti-am62px-sk.conf
>> @@ -0,0 +1,32 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +DISTRO_ARCH = "arm64"
>> +DTB_FILES = "k3-am62p5-sk.dtb"
>> +
>> +IMAGE_FSTYPES ?= "wic"
>> +WKS_FILE ?= "ti-am62px-sk.wks"
>> +
>> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
>> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
>> +
>> +IMAGE_INSTALL += "u-boot-script"
>> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
>> +
>> +IMAGE_BOOT_FILES = " \
>> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
>> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
>> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
>> +
>> +USE_CIP_KERNEL_CONFIG = "1"
>> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
>> +
>> +WDOG_TIMEOUT = "0"
>> +
>> +PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-ti-am62px-sk"
>> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
>> new file mode 100644
>> index 0000000..53e08be
>> --- /dev/null
>> +++ b/kas/board/ti-am62px-sk.yml
>> @@ -0,0 +1,13 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# Authors:
>> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 1
>> +
>> +machine: ti-am62px-sk
>> diff --git a/recipes-bsp/optee-os/files/rules-ti.tmpl b/recipes-bsp/optee-os/files/rules-ti.tmpl
>> new file mode 100755
>> index 0000000..d5163d5
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/files/rules-ti.tmpl
>> @@ -0,0 +1,21 @@
>> +#!/usr/bin/make -f
>> +
>> +# Debian rules for custom OP-TEE OS build
>> +#
>> +# This software is a part of ISAR.
> 
> Not quite anymore, but...
> 
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>> +endif
>> +
>> +override_dh_auto_build:
>> +	CFLAGS= LDFLAGS= $(MAKE) $(PARALLEL_MAKE) PLATFORM=${OPTEE_PLATFORM} \
>> +		CROSS_COMPILE=arm-linux-gnueabihf- \
>> +		CROSS_COMPILE64=${CROSS_COMPILE} \
>> +		${OPTEE_EXTRA_BUILDARGS}
>> +
>> +%:
>> +	dh $@
> 
> Why do you need an own rules file? 32 and 64-bit TA support? Maybe we
> can generalize that and patch isar instead? But I so far avoided 32-bit
> TAs - do they have a use case?

No specific use case really. It can be removed.

> 
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> new file mode 100644
>> index 0000000..0d03a57
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> @@ -0,0 +1,37 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require recipes-bsp/optee-os/optee-os-custom.inc
>> +
>> +SRC_URI += " \
>> +    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee_os-${PV}.tar.gz \
>> +    file://rules-ti.tmpl \
>> +"
>> +SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
>> +
>> +S = "${WORKDIR}/optee_os-${PV}"
>> +
>> +DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
>> +
>> +OPTEE_PLATFORM = "k3-am62x"
>> +OPTEE_NAME = "ti-k3"
>> +OPTEE_EXTRA_BUILDARGS = " \
>> +    TEE_IMPL_VERSION=${PV} \
>> +    CFG_ARM64_core=y \
>> +    CFG_USER_TA_TARGETS=ta_arm64 \
>> +    CFG_TEE_CORE_LOG_LEVEL=1"
> 
> You could probably stick your deviating make options into
> OPTEE_EXTRA_BUILDARGS as well. Still, if there is some way to make
> isar's rules more generic, that would be best.

understood.

> 
>> +
>> +OPTEE_BINARIES = "tee-pager_v2.bin"
> 
> That is legacy. I'm almost sure the default of this var will work as well.
> 
>> +
>> +python do_transform_template:prepend() {
>> +    import shutil
>> +    import os
>> +
>> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
>> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
>> +    shutil.copyfile(src, dst)
> 
> You could also add rules-ti.tmpl to TEMPLATE_FILES and copy the result
> in shell code in do_prepare_build. Or rename to rules.tmpl and use
> file://rules.tmpl;subdir=debian, just like below. Too many options with
> bitbake :). So better avoid the custom rules.

Yeah, will avoid this. custom rules file is not really needed.

> 
>> +}
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>> new file mode 100644
>> index 0000000..eca70d8
>> --- /dev/null
>> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>> @@ -0,0 +1,18 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
>> +
>> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
>> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
>> +
>> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
>> +
>> +TF_A_NAME = "ti-k3"
>> +TF_A_PLATFORM = "k3"
>> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
>> +TF_A_BINARIES = "lite/release/bl31.bin"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>> new file mode 100644
>> index 0000000..d831b21
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>> @@ -0,0 +1,38 @@
>> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
>> +From: Gokul Praveen <g-praveen@ti.com>
>> +Date: Thu, 10 Jul 2025 15:29:22 +0530
>> +Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
>> +
>> +KASLR, or Kernel Address Space Layout Randomization, is a security
>> +feature in the Linux kernel that randomizes the memory location
>> +where the kernel is loaded during boot.
>> +
>> +OP-TEE RNG is a Random Number Generator (RNG) component within the
>> +Open Portable Trusted Execution Environment (OP-TEE) which provides
>> +a random number to U-BOOT and U-BOOT provides this random number
>> +as seed value to the LINUX kernel for KASLR.
>> +
>> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
>> +configs.
>> +
>> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> +Reviewed-by: Bryan Brattlof <bb@ti.com>
>> +Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
>> +---
>> + arch/arm/Kconfig | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> +index 5872455a0fe5..4e7593616d8a 100644
>> +--- a/arch/arm/Kconfig
>> ++++ b/arch/arm/Kconfig
>> +@@ -835,6 +835,9 @@ config ARCH_K3
>> + 	select FIT_SIGNATURE if ARM64
>> + 	select LTO
>> + 	imply TI_SECURE_DEVICE
>> ++	imply DM_RNG if ARM64
>> ++	imply TEE if ARM64
>> ++	imply OPTEE if ARM64
>> +
>> + config ARCH_OMAP2PLUS
>> + 	bool "TI OMAP2+"
>> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
>> new file mode 100755
>> index 0000000..8f41300
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
>> @@ -0,0 +1,33 @@
>> +#!/usr/bin/make -f
>> +#
>> +# Debian rules for custom U-Boot build for ti-am62p-sk
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
>> +endif
>> +
>> +override_dh_auto_build:
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
>> +
>> +	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_A53_CONFIG}
>> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
>> +		TEE=/usr/lib/optee-os/ti-k3/tee-pager_v2.bin BINMAN_INDIRS=${BINMAN_INDIRS}
>> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
>> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
>> +
>> +override_dh_auto_install:
>> +	mv tools/env/lib.a tools/env/libubootenv.a
>> +
>> +override_dh_auto_test:
>> +
>> +override_dh_strip:
>> +	dh_strip -X libubootenv.a
>> +
>> +%:
>> +	dh $@ --parallel
>> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.01.inc b/recipes-bsp/u-boot/u-boot-common-2025.01.inc
>> new file mode 100644
>> index 0000000..14bdef9
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/u-boot-common-2025.01.inc
>> @@ -0,0 +1,33 @@
>> +#
>> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require recipes-bsp/u-boot/u-boot-custom.inc
>> +
>> +FILESPATH:append := ":${FILE_DIRNAME}/files"
>> +
>> +SRC_URI += " \
>> +    https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2 \
> 
> Let's see how long this server will still work... But I haven't heard
> about an official new home yet, so let's keep it.
> 
>> +    file://rules.tmpl;subdir=debian"
>> +SRC_URI[sha256sum] = "cdef7d507c93f1bbd9f015ea9bc21fa074268481405501945abc6f854d5b686f"
>> +
>> +SRC_URI:append:secureboot = " \
>> +    file://secure-boot.cfg"
>> +
>> +S = "${WORKDIR}/u-boot-${PV}"
>> +
>> +DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}, \
>> +        libgnutls28-dev:native, libgnutls28-dev:${DISTRO_ARCH}, yamllint:native"
>> +
>> +DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
>> +    openssl, efivar, secure-boot-secrets, python3-openssl:native"
>> +DEBIAN_BUILD_DEPENDS:append:secureboot:buster   = ", pesign"
>> +DEBIAN_BUILD_DEPENDS:append:secureboot:bullseye = ", pesign"
>> +DEBIAN_BUILD_DEPENDS:append:secureboot:bookworm = ", pesign"
>> +DEPENDS:append:secureboot = " secure-boot-secrets"
>> +
>> +do_prepare_build:append:secureboot() {
>> +    sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
>> +    cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
>> +}
>> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>> new file mode 100644
>> index 0000000..d0d6e5d
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>> @@ -0,0 +1,60 @@
>> +#
>> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require u-boot-common-${PV}.inc
>> +
>> +TI_FIRMWARE_SRCREV = "33bec0e2ea9a25362c0c8243b2f1ed392dbc5b02"
>> +
>> +SRC_URI += " \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=sysfw-cert \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=sysfw-enc \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=sysfw-stub-cert \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=sysfw-stub-enc \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f?id=${TI_FIRMWARE_SRCREV};downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=dm \
> 
> Did you answer my question about CI-stability of git.ti.com already?

We were creating a github mirror and we just got it ready a couple days 
ago at https://github.com/TexasInstruments/ti-linux-firmware. Will move 
to github mirror in the next revision.

> 
>> +    file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
>> +    file://rules-ti.tmpl"
>> +
>> +SRC_URI[dm.sha256sum] = "7251394068d287ec81cb0f005a734de3bb7bb695d9dbcc3903ea83dda2182efc"
>> +SRC_URI[sysfw-cert.sha256sum] = "fe36da7923ac6fa52eea5e601fb4321299df5e639d9dd66b41b6825bc1d9d539"
>> +SRC_URI[sysfw-enc.sha256sum] = "4db6ed096fd5077023f292841a64aedb3a4ff8408d1160fb10a7aa0355d06e56"
>> +SRC_URI[sysfw-stub-cert.sha256sum] = "22b58a07429da5ae0b0cd126d4ec0f429ee687429251f4fcfe9a2f5bb3e74b5d"
>> +SRC_URI[sysfw-stub-enc.sha256sum] = "2cb73e5c9acf985325f40f16152906c9a2057f41ffb7903a981a34f7b2aaf524"
>> +
>> +S = "${WORKDIR}/u-boot-${PV}"
>> +TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
>> +BINMAN_INDIRS = "./ti-linux-firmware"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> +
>> +U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
>> +U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
>> +U_BOOT_CONFIG = "${U_BOOT_A53_CONFIG}"
>> +
>> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
>> +
>> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
>> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
>> +    libssl-dev:native, libssl-dev, grub-common, \
>> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
>> +    python3-jsonschema:native, python3-yaml:native, \
>> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
>> +
>> +do_prepare_build:append() {
>> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
>> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-sysfw
>> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
>> +}
>> +
>> +TEMPLATE_VARS += "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
>> +
>> +python do_transform_template:prepend() {
>> +    import shutil
>> +    import os
>> +
>> +    src = os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
>> +    dst = os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
>> +    shutil.copyfile(src, dst)
> 
> See above.

Yes, will do this in a clean way.

> 
>> +}
>> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
>> new file mode 100644
>> index 0000000..8663607
>> --- /dev/null
>> +++ b/wic/ti-am62px-sk.wks
>> @@ -0,0 +1,11 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2023-2024
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
>> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
>> +
>> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
>> +
>> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"
> 
> Jan
> 

Kartheek

