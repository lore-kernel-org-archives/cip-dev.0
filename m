Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC74C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 13:50:12 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web11.25940.1754488212289262000
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 06:50:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Bpv+8mPE;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576DoBWT092710;
	Wed, 6 Aug 2025 08:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754488211;
	bh=YHR61NSqeoLXVCPDoZjz5qUBdlPQWvpBK9ei0htvSpc=;
	h=Date:Subject:To:References:From:CC:In-Reply-To;
	b=Bpv+8mPEkcIxNloLnFAeW47HMsJpYJi5dLjb8yZ0fXnWo3pawx7ncytknJa2xjv0m
	 CNBSqIlJNyjo3DjrqglPEHRSlxmOqtH7Az4LSAS63/q8IaSohns5f8pICledrGnDKc
	 wst/AE+0V79elygNbckZIJQtLo+x2Ls1KG9Glvp8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576DoBl1172746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 08:50:11 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 08:50:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 08:50:10 -0500
Received: from [172.24.233.226] (uda0498651.dhcp.ti.com [172.24.233.226])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576Do9kj3915001;
	Wed, 6 Aug 2025 08:50:09 -0500
Message-ID: <5115b1c9-33b5-4760-9463-340123b32b58@ti.com>
Date: Wed, 6 Aug 2025 19:20:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/4] Add support for TI AM62Px SK
 platform
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-2-s-adivi@ti.com>
 <9de6a768-68af-40b4-b0e7-bdd07b1b8eb9@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <9de6a768-68af-40b4-b0e7-bdd07b1b8eb9@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 13:50:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19695

Hi Jan,

I've already posted v2. Anyway, you can find my responses here.

On 05/08/25 15:46, Jan Kiszka wrote:
> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>> - Add machine conf and and kas yml files for TI AM62Px SK
>> - Add new u-boot 2025.01 recipe as support for AM62P is only available
>>    from 2025.01
>> - Add new recipes for trusted-firmware-a, optee-os
>> - Add new initramfs hook to include TI kernel modules in initramfs image
>>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   Kconfig                                       |  5 ++
>>   conf/machine/ti-am62px-sk.conf                | 32 +++++++++++++
>>   kas/board/ti-am62px-sk.yml                    | 13 ++++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 24 ++++++++++
>>   .../trusted-firmware-a-ti-k3_2.13.bb          | 18 ++++++++
>>   ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 31 +++++++++++++
>>   recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 +++++++++++++
>>   recipes-bsp/u-boot/u-boot-common-2025.01.inc  | 33 +++++++++++++
>>   .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     | 46 +++++++++++++++++++
>>   .../initramfs-ti-k3-kernel-modules-hook.bb    | 27 +++++++++++
>>   wic/ti-am62px-sk.wks                          | 11 +++++
>>   11 files changed, 273 insertions(+)
>>   create mode 100644 conf/machine/ti-am62px-sk.conf
>>   create mode 100644 kas/board/ti-am62px-sk.yml
>>   create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>>   create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>>   create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>>   create mode 100644 recipes-bsp/u-boot/files/rules-ti-am62px-sk
>>   create mode 100644 recipes-bsp/u-boot/u-boot-common-2025.01.inc
>>   create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>>   create mode 100644 recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
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
> 
> Same questions as for the ZCU102 target apply here as well: Please
> encode your kernel and possibly also distro version requirements in Kconfig.

Sure

> 
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
>> index 0000000..a520002
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
>> +IMAGE_INSTALL += "u-boot-script initramfs-ti-k3-kernel-modules-hook"
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
> 
> We rather want 14 here.

noted. will update for v3.

> 
>> +
>> +machine: ti-am62px-sk
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
> 
> Intentionally not (yet) 4.7.0?

No. This can be updated to 4.7.0. Will update in v3.

> 
>> new file mode 100644
>> index 0000000..437b6fd
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> @@ -0,0 +1,24 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require recipes-bsp/optee-os/optee-os-custom.inc
>> +
>> +SRC_URI += "https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee_os-${PV}.tar.gz"
>> +SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
>> +
>> +S = "${WORKDIR}/optee_os-${PV}"
>> +
>> +DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
>> +
>> +OPTEE_PLATFORM = "k3-am62x"
>> +OPTEE_EXTRA_BUILDARGS = " \
>> +    TEE_IMPL_VERSION=${PV} \
>> +    CFG_ARM64_core=y \
>> +    CFG_USER_TA_TARGETS=ta_arm64 \
>> +    CFG_TEE_CORE_LOG_LEVEL=1"
>> +
>> +OPTEE_BINARIES = "tee-raw.bin"
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
>> index 0000000..3b55aaf
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>> @@ -0,0 +1,31 @@
>> +From 69a862c40c976a534ca79153c04d69ef3544ca57 Mon Sep 17 00:00:00 2001
>> +From: Gokul Praveen <g-praveen@ti.com>
>> +Date: Mon, 5 May 2025 15:32:53 +0530
>> +Subject: [PATCH 1/1] configs: KASLR OPTEE RNG support for
>> + K3 devices
>> +
>> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
>> +configs.
>> +
> 
> 
> That's 7d4136397715d2c08161a32a873c052dd1bb8b6c in upstream, right?

Already fixed in v2.

> 
>> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> +---
>> + arch/arm/Kconfig | 3 +++
>> + 1 file changed, 3 insertions(+)
>> +
>> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> +index 7282c4123b0..cd27e5a5422 100644
>> +--- a/arch/arm/Kconfig
>> ++++ b/arch/arm/Kconfig
>> +@@ -805,6 +805,9 @@ config ARCH_K3
>> + 	select REGEX
>> + 	select FIT_SIGNATURE if ARM64
>> + 	imply TI_SECURE_DEVICE
>> ++	imply DM_RNG
>> ++	imply TEE
>> ++	imply OPTEE
>> +
>> + config ARCH_OMAP2PLUS
>> + 	bool "TI OMAP2+"
>> +--
>> +2.34.1
>> +
>> diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
>> new file mode 100644
>> index 0000000..dc53b07
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
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
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm am62px_evm_r5_defconfig
>> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>> +
>> +	$(MAKE) $(PARALLEL_MAKE) am62px_evm_a53_defconfig
>> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
>> +		TEE=/usr/lib/optee-os/ti-k3/tee-raw.bin
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
> 
> Why not 2025.07?

2025.07 should work. Let me give it a try and update for v3.

> 
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
>> index 0000000..b9dbdf8
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.01.bb
>> @@ -0,0 +1,46 @@
>> +#
>> +# Copyright (c) 2025 Texas Instruments Incorporated - http://www.ti.com
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +require u-boot-common-${PV}.inc
>> +
>> +TI_FIRMWARE_SRCREV = "9ee2fedb1fb4815f54310dd872d34faf9948c7c1"
>> +
>> +SRC_URI += " \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=sysfw-cert \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=sysfw-enc \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=sysfw-stub-cert \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin?id=${TI_FIRMWARE_SRCREV};downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=sysfw-stub-enc \
>> +    https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/plain/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f?id=${TI_FIRMWARE_SRCREV};downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=dm \
>> +    file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
>> +    file://rules-${MACHINE}"
>> +
>> +SRC_URI[dm.sha256sum] = "3435b8b5be80a3fe8775f60b1239dd909a2a75958569727491ca9691fecc820d"
>> +SRC_URI[sysfw-cert.sha256sum] = "3565f0dd48470e6ae36a7a90fb2eb2e2e0949b9702271e3b944b98a208a01a69"
>> +SRC_URI[sysfw-enc.sha256sum] = "61c52ea82d5b0eddfb236619d685d660ab1afc18d10aa4794b03a1c1a679baf7"
>> +SRC_URI[sysfw-stub-cert.sha256sum] = "a0c9181646c1832eb5bdfdf243634fe03df1c0bad01653b041149768a39d35f9"
>> +SRC_URI[sysfw-stub-enc.sha256sum] = "d96af397494c460cd3bbd6cf925c6f559a9c43b572cfdd58961b5c8900124144"
>> +
>> +S = "${WORKDIR}/u-boot-${PV}"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> +
>> +U_BOOT_CONFIG = "am62px_evm_a53_defconfig"
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
>> +    mkdir -p ${S}/ti-sysfw
>> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${S}/ti-sysfw
>> +    mkdir -p ${S}/ti-dm/am62pxx
>> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${S}/ti-dm/am62pxx
>> +    cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
>> +}
>> diff --git a/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb b/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
>> new file mode 100644
>> index 0000000..75e7f92
>> --- /dev/null
>> +++ b/recipes-initramfs/initramfs-ti-k3-kernel-modules-hook/initramfs-ti-k3-kernel-modules-hook.bb
>> @@ -0,0 +1,27 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-initramfs/initramfs-hook/hook.inc
>> +
>> +HOOK_ADD_MODULES = " \
>> +    snd-soc-davinci-mcasp \
>> +    snd-soc-ti-udma \
>> +    ti-eqep \
>> +    ti-ecap-capture \
>> +    mcrc \
>> +    sa2ul \
>> +    icss_iep \
>> +    icssg \
>> +    icssg-prueth \
>> +    ti_k3_common.ko \
>> +    ti_k3_dsp_remoteproc.ko \
>> +    ti_k3_m4_remoteproc \
>> +    ti_k3_r5_remoteproc \
>> +    rpmsg_char \
>> +    rpmsg_ctrl \
>> +    rtc-ti-k3 \
>> +    pruss \
> 
> Why are those modules if they are boot-essential? And what do we really
> need? I doubt that we need them all...

True, and none of these are needed. I've already removed this 
initramfs-hook in v2.

> 
>> +"
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


