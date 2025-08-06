Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226CC87FD3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 13:58:02 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web11.26104.1754488680414452947
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 06:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=ti-com-17Q1 header.b=xO7PR8bZ;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: s-adivi@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 576Dvx1E135082;
	Wed, 6 Aug 2025 08:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754488679;
	bh=4fn+47Ya46dL0rSaCtSm7XSW7FchnUIACp0IoORDVIo=;
	h=Date:Subject:To:References:From:CC:In-Reply-To;
	b=xO7PR8bZGLvmJUI+rZF4bZnoZ1D049/ljaiB5QGmoaO9Ytyjh+HUPxDnxFxp5DXKD
	 Z+Ox1TtZciza9OdY3yA1NoX197ocOURUjg0sPPvQ5ttK35F57MWt3nkBslJqYNQCzb
	 f9e68I+98UnSf2etdO9+96BRMI8TxV42lLcMHuVI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 576Dvx7Y176306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 08:57:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 08:57:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 08:57:59 -0500
Received: from [172.24.233.226] (uda0498651.dhcp.ti.com [172.24.233.226])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 576DvvPP3923075;
	Wed, 6 Aug 2025 08:57:58 -0500
Message-ID: <1b3e688c-ac4d-4d98-a0c5-b2e933e038d6@ti.com>
Date: Wed, 6 Aug 2025 19:27:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: Jan Kiszka <jan.kiszka@siemens.com>,
        "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <9bec0162-625e-4796-97d5-0cd364b3ad2a@web.de>
 <d40cd721-9403-404a-8a5d-83820646ab33@ti.com>
 <9bbceb24-c6f6-4584-8d08-9903c0ec4de0@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
CC: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <9bbceb24-c6f6-4584-8d08-9903c0ec4de0@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by lelvem-ot01.ext.ti.com id 576Dvx1E135082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 13:58:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19696



On 04/08/25 02:24, Jan Kiszka wrote:
> On 01.08.25 07:27, Adivi, Sai Sree Kartheek wrote:
>>
>>
>> On 7/23/2025 3:38 AM, Jan Kiszka wrote:
>>> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>>>> - optee-client, optee-ftpm:
>>>>  =C2=A0=C2=A0 - This integrate Microsoft's reference implementation =
of the TCG
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 TPM2.0 as an OPTee trusted application.
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Since the OPTee secure storage on TI AM62P=
x SK is RPMB-based, and
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 the RPMB accessing is provided by linux te=
e-supplicant, this TA is
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 only discoverable when tee-supplicant is r=
unning.
>>>>
>>>> - optee-os, optee-os-tadevkit:
>>>>  =C2=A0=C2=A0 - refactor optee-os recipe and add one for optee-os-ta=
devkit which is
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 required for optee-client
>>>>
>>>> - u-boot:
>>>>  =C2=A0=C2=A0 - New patch to add ftpm node in the am62px device tree
>>>>  =C2=A0=C2=A0 - Add rpmb-setup.cfg for setting up additional configs=
 required for
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 enabling FTPM.
>>>>
>>>> - cip-core-image-security:
>>>>  =C2=A0=C2=A0 - Add newly added optee ta packages to cip-core-image-=
security
>>>>
>>>> - Kconfig
>>>>  =C2=A0=C2=A0 - Enable security features (data encryption, full encr=
yption) for
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 TI AM62Px SK
>>>>
>>>> Co-authored-by: Ayush Gupta <a-gupta4@ti.com>
>>>> Co-authored-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>>> ---
>>>>  =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
>>>>  =C2=A0 .../optee-client/optee-client-ti-k3_4.6.0.bb=C2=A0 | 16 ++++=
+++++
>>>>  =C2=A0 .../files/0001-add-enum-to-ta-flags.patch=C2=A0=C2=A0=C2=A0=C2=
=A0 | 27 +++++++++++++++
>>>>  =C2=A0 .../optee-ftpm-ti-k3_0~231017+git.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++++++++++++++++++
>>>>  =C2=A0 .../optee-os/optee-os-tadevkit-ti-k3_4.6.0.bb | 12 +++++++
>>>>  =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.bb=C2=A0 | 29 ++++=
++++--------
>>>>  =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0.inc | 29 +++++++++=
+++++++
>>>>  =C2=A0 .../files/0001-Add-tpm-node-in-uboot.patch=C2=A0=C2=A0=C2=A0=
 | 30 +++++++++++++++++
>>>>  =C2=A0 recipes-bsp/u-boot/files/rpmb-setup.cfg=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 12 +++++++
>>>>  =C2=A0 recipes-bsp/u-boot/files/rules-ti-am62px-sk=C2=A0=C2=A0 |=C2=
=A0 2 --
>>>>  =C2=A0 .../u-boot/u-boot-ti-am62px-sk_2025.01.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++
>>>>  =C2=A0 .../images/cip-core-image-security.bb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++++
>>>>  =C2=A0 .../cip-core-initramfs/cip-core-initramfs.bb=C2=A0 |=C2=A0 7=
 ++++
>>>>  =C2=A0 13 files changed, 207 insertions(+), 18 deletions(-)
>>>>  =C2=A0 create mode 100644 recipes-bsp/optee-client/optee-client-ti-
>>>> k3_4.6.0.bb
>>>>  =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/files/0001-add-enu=
m-to-
>>>> ta-flags.patch
>>>>  =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>>> k3_0~231017+git.bb
>>>>  =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti=
-
>>>> k3_4.6.0.bb
>>>>  =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.6.0=
.inc
>>>>  =C2=A0 create mode 100644 recipes-bsp/u-boot/files/0001-Add-tpm-nod=
e-in-
>>>> uboot.patch
>>>>  =C2=A0 create mode 100644 recipes-bsp/u-boot/files/rpmb-setup.cfg
>>>>
>>>> diff --git a/Kconfig b/Kconfig
>>>> index 68c4309..b59ca59 100644
>>>> --- a/Kconfig
>>>> +++ b/Kconfig
>>>> @@ -204,7 +204,7 @@ config IMAGE_SECURITY
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_SWUPDATE
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_SECURE_BOOT
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_DATA_ENCRYPTION
>>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables security, e=
ncryption, secureboot and swupdate
>>>> for IEC 62443-4-2.
>>>>  =C2=A0 @@ -260,13 +260,13 @@ config KAS_INCLUDE_DELTA_UPDATE
>>>>  =C2=A0 =C2=A0 config IMAGE_DATA_ENCRYPTION
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Encrypt data partitions on fir=
st boot"
>>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables LUKS encryp=
tion for the partitions /var and /home.
>>>>  =C2=A0 =C2=A0 config IMAGE_FULL_ENCRYPTION
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Encrypt rootfs and data partit=
ions"
>>>> -=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI
>>>> +=C2=A0=C2=A0=C2=A0 depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM6=
4 ||
>>>> TARGET_QEMU_ARM || TARGET_X86_UEFI || TARGET_TI_AM62PX_SK
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IMAGE_DATA_ENCRYPTION
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables LUKS encryp=
tion for all non-boot partitions on
>>>> first boot.
>>>> diff --git a/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb b/
>>>> recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>>>> new file mode 100644
>>>> index 0000000..6b9d640
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-client/optee-client-ti-k3_4.6.0.bb
>>>> @@ -0,0 +1,16 @@
>>>> +#
>>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Su Bao Cheng <baocheng.su@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +require recipes-bsp/optee-client/optee-client-custom.inc
>>>> +
>>>> +SRC_URI +=3D "https://github.com/OP-TEE/optee_client/archive/
>>>> ${PV}.tar.gz;downloadfilename=3Doptee_client-${PV}.tar.gz"
>>>> +SRC_URI[sha256sum] =3D
>>>> "a970338c9f69861901336716d89684646e4480b9970996a5b3581ae7d49fdaa3"
>>>> +
>>>> +S =3D "${WORKDIR}/optee_client-${PV}"
>>>> diff --git a/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-
>>>> flags.patch b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-
>>>> flags.patch
>>>> new file mode 100644
>>>> index 0000000..57917ba
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-ftpm/files/0001-add-enum-to-ta-flags.patch
>>>> @@ -0,0 +1,27 @@
>>>> +From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2=
001
>>>> +From: Maxim Uvarov <maxim.uvarov@linaro.org>
>>>> +Date: Fri, 17 Apr 2020 12:05:53 +0100
>>>> +Subject: [PATCH] add enum to ta flags
>>>> +
>>>> +If we compile this TA into OPTEE-OS we need to define a flag
>>>> +that this TA can be discovered on the optee bus.
>>>> +Upstream-Status: Submitted [https://github.com/microsoft/MSRSec/
>>>> pull/34]
>>>> +
>>>> +Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>>> +---
>>>> + .../ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h=C2=A0=
=C2=A0=C2=A0 | 2 +-
>>>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>>>> +
>>>> +diff --git a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/
>>>> user_ta_header_defines.h b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/
>>>> user_ta_header_defines.h
>>>> +index 92c33c1..e83619d 100644
>>>> +--- a/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_define=
s.h
>>>> ++++ b/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_define=
s.h
>>>> +@@ -44,7 +44,7 @@
>>>> +
>>>> + #define TA_UUID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TA_=
FTPM_UUID
>>>> +
>>>> +-#define TA_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TA_FLAG_=
SINGLE_INSTANCE |
>>>> TA_FLAG_INSTANCE_KEEP_ALIVE)
>>>> ++#define TA_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TA_FLAG_=
SINGLE_INSTANCE |
>>>> TA_FLAG_INSTANCE_KEEP_ALIVE | TA_FLAG_DEVICE_ENUM_SUPP)
>>>> + #define TA_STACK_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (64 * 1024)
>>>> + #define TA_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (32 * 1024)
>>>> +
>>>> diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>>> b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>>> new file mode 100644
>>>> index 0000000..14df4d4
>>>> --- /dev/null
>>>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_0~231017+git.bb
>>>> @@ -0,0 +1,33 @@
>>>> +#
>>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#=C2=A0 Su Bao Cheng <baocheng.su@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>>>> +
>>>> +SRC_URI +=3D " \
>>>> +=C2=A0=C2=A0=C2=A0 https://github.com/Microsoft/ms-tpm-20-ref/archi=
ve/
>>>> ${SRCREV}.tar.gz \
>>>
>>> We need to migrate to https://github.com/OP-TEE/optee_ftpm.
>>
>> I'm still working on this part. Running into some issues (optee-ftpm t=
a
>> is not discoverable. So doesn't probe.). Do we have this enabled on an=
y
>> other platform or qemu?
>=20
> Likely not, thus there might still be problems in transition. Did you
> already discuss this issue with upstream?

I haven't raised this upstream yet. I'll go ahead and do that. Please do=20
let me know if you come across anything relevant on your end.

>=20
>>
>> Meanwhile, I've posted a v2 fixing other issues. I'm ok if you want to
>> merge the first 3 patches in the v2 and leave the data encryption patc=
h
>> out until I migrate to optee-ftpm.
>=20
> I'll have a look the next days.
>=20
> Thanks,
> Jan
>=20


