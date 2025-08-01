Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECCCC87FD2
	for <webhook@archiver.kernel.org>; Fri,  1 Aug 2025 05:28:06 +0000 (UTC)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 by mx.groups.io with SMTP id smtpd.web11.80944.1754026069372696524
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 22:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Wxpe+nyH;
 spf=pass (domain: ti.com, ip: 198.47.19.245, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5715Rm073170298;
	Fri, 1 Aug 2025 00:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754026068;
	bh=/gIuhQTE9ZamGYYJOnkUUpX5144lR6ECbsxRPwXEG0M=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Wxpe+nyHhHmReyVw5kh/fZHcpHCanoLwvJNvUn/ICIK8gAQ+EDqDUvd6rrNp3JiCn
	 os27yWKfPPJSCIj12Ftsda0/jg3A5NS9e4LIOyM+qQyYuIZ6qAQI6XJOdc84m9FTFr
	 8luEkheeOAFiFTvDfOPLi6sjVzafHg3nJWxfPp94=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5715RmuD546964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 1 Aug 2025 00:27:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 1
 Aug 2025 00:27:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 1 Aug 2025 00:27:48 -0500
Received: from [172.24.31.85] (lt2k2yfk3.dhcp.ti.com [172.24.31.85])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5715Rk9K3759684;
	Fri, 1 Aug 2025 00:27:47 -0500
Message-ID: <d40cd721-9403-404a-8a5d-83820646ab33@ti.com>
Date: Fri, 1 Aug 2025 10:57:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: Jan Kiszka <jan.kiszka@web.de>, <cip-dev@lists.cip-project.org>,
        <vigneshr@ti.com>
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <9bec0162-625e-4796-97d5-0cd364b3ad2a@web.de>
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <9bec0162-625e-4796-97d5-0cd364b3ad2a@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Aug 2025 05:28:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19650



On 7/23/2025 3:38 AM, Jan Kiszka wrote:
> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>> - optee-client, optee-ftpm:
>>    - This integrate Microsoft's reference implementation of the TCG
>>      TPM2.0 as an OPTee trusted application.
>>      Since the OPTee secure storage on TI AM62Px SK is RPMB-based, and
>>      the RPMB accessing is provided by linux tee-supplicant, this TA is
>>      only discoverable when tee-supplicant is running.
>>
>> - optee-os, optee-os-tadevkit:
>>    - refactor optee-os recipe and add one for optee-os-tadevkit which is
>>      required for optee-client
>>
>> - u-boot:
>>    - New patch to add ftpm node in the am62px device tree
>>    - Add rpmb-setup.cfg for setting up additional configs required for
>>      enabling FTPM.
>>
>> - cip-core-image-security:
>>    - Add newly added optee ta packages to cip-core-image-security
>>
>> - Kconfig
>>    - Enable security features (data encryption, full encryption) for
>>      TI AM62Px SK
>>
>> Co-authored-by: Ayush Gupta <a-gupta4@ti.com>
>> Co-authored-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   Kconfig                                       |  6 ++--
>>   .../optee-client/optee-client-ti-k3_4.6.0.bb  | 16 +++++++++
>>   .../files/0001-add-enum-to-ta-flags.patch     | 27 +++++++++++++++
>>   .../optee-ftpm-ti-k3_0~231017+git.bb          | 33 +++++++++++++++++++
>>   .../optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb | 12 +++++++
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb  | 29 ++++++++--------
>>   recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc | 29 ++++++++++++++++
>>   .../files/0001-Add-tpm-node-in-uboot.patch    | 30 +++++++++++++++++
>>   recipes-bsp/u-boot/files/rpmb-setup.cfg       | 12 +++++++
>>   recipes-bsp/u-boot/files/rules-ti-am62px-sk   |  2 --
>>   .../u-boot/u-boot-ti-am62px-sk_2025.01.bb     |  9 +++++
>>   .../images/cip-core-image-security.bb         | 13 ++++++++
>>   .../cip-core-initramfs/cip-core-initramfs.bb  |  7 ++++
>>   13 files changed, 207 insertions(+), 18 deletions(-)
>>   create mode 100644 recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>>   create mode 100644 recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
>>   create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>   create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb
>>   create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
>>   create mode 100644 recipes-bsp/u-boot/files/0001-Add-tpm-node-in-uboot.patch
>>   create mode 100644 recipes-bsp/u-boot/files/rpmb-setup.cfg
>>
>> diff --git a/Kconfig b/Kconfig
>> index 68c4309..b59ca59 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -204,7 +204,7 @@ config IMAGE_SECURITY
>>   	select IMAGE_SWUPDATE
>>   	select IMAGE_SECURE_BOOT
>>   	select IMAGE_DATA_ENCRYPTION
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>   	help
>>   	  This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
>>   
>> @@ -260,13 +260,13 @@ config KAS_INCLUDE_DELTA_UPDATE
>>   
>>   config IMAGE_DATA_ENCRYPTION
>>   	bool "Encrypt data partitions on first boot"
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>   	help
>>   	  This enables LUKS encryption for the partitions /var and /home.
>>   
>>   config IMAGE_FULL_ENCRYPTION
>>   	bool "Encrypt rootfs and data partitions"
>> -	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
>> +	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>   	select IMAGE_DATA_ENCRYPTION
>>   	help
>>   	  This enables LUKS encryption for all non-boot partitions on first boot.
>> diff --git a/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb b/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>> new file mode 100644
>> index 0000000..6b9d640
>> --- /dev/null
>> +++ b/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>> @@ -0,0 +1,16 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-bsp/optee-client/optee-client-custom.inc
>> +
>> +SRC_URI += "https://github.com/OP-TEE/optee_client/archive/${PV}.tar.gz;downloadfilename=optee_client-${PV}.tar.gz"
>> +SRC_URI[sha256sum] = "a970338c9f69861901336716d89684646e4480b9970996a5b3581ae7d49fdaa3"
>> +
>> +S = "${WORKDIR}/optee_client-${PV}"
>> diff --git a/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
>> new file mode 100644
>> index 0000000..57917ba
>> --- /dev/null
>> +++ b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
>> @@ -0,0 +1,27 @@
>> +From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
>> +From: Maxim Uvarov <maxim.uvarov@linaro.org>
>> +Date: Fri, 17 Apr 2020 12:05:53 +0100
>> +Subject: [PATCH] add enum to ta flags
>> +
>> +If we compile this TA into OPTEE-OS we need to define a flag
>> +that this TA can be discovered on the optee bus.
>> +Upstream-Status: Submitted [https://github.com/microsoft/MSRSec/pull/34]
>> +
>> +Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> +---
>> + .../ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h    | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h
>> +index 92c33c1..e83619d 100644
>> +--- a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h
>> ++++ b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h
>> +@@ -44,7 +44,7 @@
>> +
>> + #define TA_UUID                     TA_FTPM_UUID
>> +
>> +-#define TA_FLAGS                    (TA_FLAG_SINGLE_INSTANCE | TA_FLAG_INSTANCE_KEEP_ALIVE)
>> ++#define TA_FLAGS                    (TA_FLAG_SINGLE_INSTANCE | TA_FLAG_INSTANCE_KEEP_ALIVE | TA_FLAG_DEVICE_ENUM_SUPP)
>> + #define TA_STACK_SIZE               (64 * 1024)
>> + #define TA_DATA_SIZE                (32 * 1024)
>> +
>> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>> new file mode 100644
>> index 0000000..14df4d4
>> --- /dev/null
>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>> @@ -0,0 +1,33 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>> +
>> +SRC_URI += " \
>> +    https://github.com/Microsoft/ms-tpm-20-ref/archive/${SRCREV}.tar.gz \
> 
> We need to migrate to https://github.com/OP-TEE/optee_ftpm.

I'm still working on this part. Running into some issues (optee-ftpm ta 
is not discoverable. So doesn't probe.). Do we have this enabled on any 
other platform or qemu?

Meanwhile, I've posted a v2 fixing other issues. I'm ok if you want to 
merge the first 3 patches in the v2 and leave the data encryption patch 
out until I migrate to optee-ftpm.

> 
>> +    https://github.com/wolfSSL/wolfssl/archive/${SRCREV-wolfssl}.tar.gz;name=wolfssl \
> 
> That will also nicely obsolete pulling in GPL'ed wolfSSL.
> 
>> +    file://0001-add-enum-to-ta-flags.patch \
> 
> And obsolte this patch.
> 
>> +    "
>> +
>> +SRCREV = "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
>> +SRCREV-wolfssl = "9db828a099bda150a4595cf89954c15877947039"
>> +
>> +SRC_URI[sha256sum] = "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
>> +SRC_URI[wolfssl.sha256sum] = "18f77959daf2a7995757cc7e6c86efe513aa6e355e4770bba6d36bf677fe88df"
>> +
>> +S = "${WORKDIR}/ms-tpm-20-ref-${SRCREV}"
>> +
>> +OPTEE_NAME = "ti-k3"
>> +TA_CPU = "cortex-a53"
>> +TA_DEV_KIT_DIR = "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
>> +
>> +do_prepare_build:append() {
>> +    rm -rf ${S}/external/wolfssl
>> +    cp -a ${S}/../wolfssl-${SRCREV-wolfssl} ${S}/external/wolfssl
>> +}
>> diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb
>> new file mode 100644
>> index 0000000..30f046e
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb
>> @@ -0,0 +1,12 @@
>> +#
>> +# Copyright (c) Texas Instruments Incorporated, 2025
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
>> +require optee-os-ti-k3_${PV}.inc
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> index 437b6fd..bf7017c 100644
>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb
>> @@ -1,24 +1,27 @@
>>   #
>>   # Copyright (c) Texas Instruments Incorporated, 2025
>> +# Copyright (c) Siemens AG, 2020-2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>>   #
>>   # SPDX-License-Identifier: MIT
>> -
>> +#
>>   require recipes-bsp/optee-os/optee-os-custom.inc
>> +require optee-os-ti-k3_${PV}.inc
>>   
>> -SRC_URI += "https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee_os-${PV}.tar.gz"
>> -SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
>> -
>> -S = "${WORKDIR}/optee_os-${PV}"
>> +OPTEE_BINARIES = "tee-raw.bin"
>>   
>> -DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
>> +# MS fTPM integration
>> +DEPENDS:append:secureboot = " optee-ftpm-${OPTEE_NAME} optee-client-${OPTEE_NAME}"
>> +DEBIAN_BUILD_DEPENDS:append:secureboot = ", optee-ftpm-${OPTEE_NAME}"
>>   
>> -OPTEE_PLATFORM = "k3-am62x"
>> -OPTEE_EXTRA_BUILDARGS = " \
>> -    TEE_IMPL_VERSION=${PV} \
>> -    CFG_ARM64_core=y \
>> -    CFG_USER_TA_TARGETS=ta_arm64 \
>> -    CFG_TEE_CORE_LOG_LEVEL=1"
>> +FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
>>   
>> -OPTEE_BINARIES = "tee-raw.bin"
>> +OPTEE_EXTRA_BUILDARGS:append:secureboot = " \
>> +    CFG_EARLY_TA=y \
>> +    EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
>> +    "
>>   
>>   COMPATIBLE_MACHINE = "ti-am62px-sk"
>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
>> new file mode 100644
>> index 0000000..9253015
>> --- /dev/null
>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc
>> @@ -0,0 +1,29 @@
>> +#
>> +# Copyright (c) Siemens AG, 2020-2023
>> +#
>> +# Authors:
>> +#  Jan Kiszka <jan.kiszka@siemens.com>
>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>> +#
>> +# This file is subject to the terms and conditions of the MIT License.  See
>> +# COPYING.MIT file in the top-level directory.
>> +#
>> +
>> +SRC_URI += "https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz"
>> +SRC_URI[sha256sum] = "0c947c6972bf50c483cb993af01041d4094b1e03711c7246cdde6ba2ffc351fe"
>> +
>> +S = "${WORKDIR}/optee_os-${PV}"
>> +
>> +DEBIAN_BUILD_DEPENDS += ", python3-cryptography:native"
>> +
>> +OPTEE_NAME = "ti-k3"
>> +OPTEE_PLATFORM = "k3-am62x"
>> +OPTEE_EXTRA_BUILDARGS = " \
>> +    TEE_IMPL_VERSION=${PV} \
>> +    CFG_ARM64_core=y \
>> +    CFG_TEE_CORE_LOG_LEVEL=1 CFG_TEE_TA_LOG_LEVEL=1 \
>> +    CFG_TA_MEASURED_BOOT=y CFG_USER_TA_TARGETS=ta_arm64 \
>> +    CFG_CONSOLE_UART=0 CFG_CORE_DYN_SHM=y CFG_WITH_SOFTWARE_PRNG=y \
>> +    CFG_REE_FS=n CFG_RPMB_FS=y CFG_RPMB_WRITE_KEY=y CFG_CORE_HEAP_SIZE=524288 CONFIG_INSECURE=y"
>> +
>> +COMPATIBLE_MACHINE = "ti-am62px-sk"
>> diff --git a/recipes-bsp/u-boot/files/0001-Add-tpm-node-in-uboot.patch b/recipes-bsp/u-boot/files/0001-Add-tpm-node-in-uboot.patch
>> new file mode 100644
>> index 0000000..68d7250
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/0001-Add-tpm-node-in-uboot.patch
>> @@ -0,0 +1,30 @@
>> +From bd6963c71a56cbbae031b81b90671b6c05a837f0 Mon Sep 17 00:00:00 2001
>> +From: Anshul Dalal <anshuld@ti.com>
>> +Date: Thu, 19 Jun 2025 15:54:35 +0530
>> +Subject: [PATCH] added tpm node to u-boot dt
>> +
>> +Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> +---
>> + dts/upstream/src/arm64/ti/k3-am62p.dtsi | 6 ++++++
>> + 1 file changed, 6 insertions(+)
>> +
>> +diff --git a/dts/upstream/src/arm64/ti/k3-am62p.dtsi b/dts/upstream/src/arm64/ti/k3-am62p.dtsi
>> +index 75a15c368c1..1df9f2bb71a 100644
>> +--- a/dts/upstream/src/arm64/ti/k3-am62p.dtsi
>> ++++ b/dts/upstream/src/arm64/ti/k3-am62p.dtsi
>> +@@ -29,6 +29,12 @@
>> + 			compatible = "arm,psci-1.0";
>> + 			method = "smc";
>> + 		};
>> ++
>> ++		tpm {
>> ++			compatible = "microsoft,ftpm";
>> ++			status = "okay";
>> ++		};
>> ++
>> + 	};
>> +
>> + 	a53_timer0: timer-cl0-cpu0 {
>> +--
>> +2.49.0
>> +
>> diff --git a/recipes-bsp/u-boot/files/rpmb-setup.cfg b/recipes-bsp/u-boot/files/rpmb-setup.cfg
>> new file mode 100644
>> index 0000000..bfe7226
>> --- /dev/null
>> +++ b/recipes-bsp/u-boot/files/rpmb-setup.cfg
>> @@ -0,0 +1,12 @@
>> +### RPMB key pairing config
>> +CONFIG_TEE=y
>> +CONFIG_OPTEE=y
>> +CONFIG_OPTEE_SERVICE_DISCOVERY=y
>> +CONFIG_TPM=y
>> +CONFIG_TPM_V2=y
>> +CONFIG_CMD_TPM=y
>> +CONFIG_TPM2_FTPM_TEE=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_CMD_NVEDIT_EFI=y
>> +CONFIG_CMD_MMC_RPMB=y
>> +CONFIG_BOOTCOMMAND="setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing 1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
>> diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
>> index ab8b813..81a3293 100644
>> --- a/recipes-bsp/u-boot/files/rules-ti-am62px-sk
>> +++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
>> @@ -15,13 +15,11 @@ override_dh_auto_build:
>>   	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
>>   		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
>>   		rm -f secure-boot.esl; \
>> -		\
>>   		if [ -x /usr/bin/efisecdb ]; then \
>>   			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
>>   		else \
>>   			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
>>   		fi; \
>> -		\
>>   		rm -f ubootefi.var; \
>>   		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
>>   		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
> 
> Unrelated whitespace changes.
> 
> Jan
> 


