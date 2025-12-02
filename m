Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C485CFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 06:58:38 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2221.1764658716388625949
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 22:58:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=OzwUcJD5;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.200.51, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYcD+Nk2EnNULZ9atmr2HaDJE5NAk8MQ1R+dS7DHkQOFdZQG3Lc8lOcdOUxocPSnz6GDZbUXv/rfpSvcmeZ9n2paRXzZerMbnsMjWmoMJYaVdYdzTjSfsJhnD5B/fFMUimQl83VGnK2KIldfRzsGndpyrz7rgkE2kW/ZcRJGhZRgYXUu2NSkA0wyD7CE0a9HV/+L8VaJZP5zHCY5Vg0Hi3t2VaamFNQG8z2/SbJZ0/LcfxqjqXYUebb2XrrX0gQBEYT5+c8VG5yjIFTvgG9bUg13SbDarQZkCDThaQ46Gd1cqC/ZgdhjPAqZCp+FCoUQ/22kyGliy/cR6tM4TnkcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Z1NoNOEzqyPiEK9CoqwXvF9+dr8iy928+9na7UoKk=;
 b=lsh1ow4aY31gAA2oc8SiiO9RHE5DWR2qv247huvfzA8ZZuElEE7LG6Wuaq3CZfMMSi0biuerKXY0eTonXYQdZu6YGkBlyTy9gMBRf0ANRl3Fbxzb+QrE9e3YWOu9aQELp00dlnC+W2zxutif6BTU0/8QKm+V6oPVREEaWQ/PkDoTaAlnHwriLR2WEB48Xa7IHdg7H0HnHWcVhIBSgX55JfgVi1FFMd9YI0XFEHO6+YeOUwNYrU6cliOWaIWt0g69SgxH68m+giwC/oNt3VHvZOWjUOJTZ7N2G8UdwiLiHKa+wZ7kxu+/Jo29z4BTWwr1qKcbrLCkjWEvvJXlLrrWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5Z1NoNOEzqyPiEK9CoqwXvF9+dr8iy928+9na7UoKk=;
 b=OzwUcJD5kQ3uHzK4vGe95dnzoqYqVBIsxtqgM/KUNRhRpSPSLIN+3nepPQ9DZe3J270+q/cFARZPB2SQMDouubVCEkLCPmf710jhIwsGXOExYmMNq9k7nf04kV4l9UzUtWPk6rJR7ZgNMRMgxJ+5QJExU6uokLN4AhYBeTTBgcI=
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:58:33 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::1e) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 06:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 06:58:32 +0000
Received: from DFLE106.ent.ti.com (10.64.6.27) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Tue, 2 Dec
 2025 00:58:30 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Dec 2025 00:58:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 00:58:30 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B26wSOR1804200;
	Tue, 2 Dec 2025 00:58:29 -0600
Message-ID: <695bab04-a355-4333-a6f6-1850a42253e6@ti.com>
Date: Tue, 2 Dec 2025 12:28:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
 <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
 <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
 <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
 <d1f88d49-e317-4782-9ac9-fce1bf21bd7b@siemens.com>
 <b12ef53f-532a-4fdc-b0f4-1484e13ec22c@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <b12ef53f-532a-4fdc-b0f4-1484e13ec22c@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|BN0PR10MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d0b403-9583-4729-3c54-08de317034c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1Kcj+ryjyJ+kmgpiM0LrtR/3hEPrfEhhoOFrqVM2cZYcpeFvZlxbMkjXbLPG?=
 =?us-ascii?Q?PUs5GTlUaq5wvN0zL3F4EgcShCCNlzKkQEwGrzLS9DtJXVgm5j1YS+FBykLv?=
 =?us-ascii?Q?T2qdIKwLJ4Qq2UsGTmfgI0gn2HGyXLXVJHHonZ1luqMOopQvmHbV3kSB+MjQ?=
 =?us-ascii?Q?jAhBNLHM76Tc4Sl6MwgOtmgaXLfVQzYl9zwZQ3ab3HYu/Rm7KXaTn3CM2BE/?=
 =?us-ascii?Q?fx5T9gbgf4lfJytaWdPFQjclL5gLxz3Sb7rcdjXVV1d3Vm6w1U5Ucm1a0mL3?=
 =?us-ascii?Q?5uD0VNmJtR8UndqiJhepbK2LwMHnJcaImSqTS3m5oGn5SPJ+hIE5eqrJkVMn?=
 =?us-ascii?Q?laI5TUBiha4qxdbnqSwoFICkT5ZqiDpubM5P3lM/KfvQp3Y7HYzlUZL5jolp?=
 =?us-ascii?Q?+3NVCfeaZOtTpsL+mq3r+vk2bliMnd+B8J/Nv4ZO0IZiek/DPes3Wkqipdui?=
 =?us-ascii?Q?Lu8iouycXxKq8Pch3hpe7QOyfepxN+5F98LLr7G7cR+pdy6QzCkqS9gGWnl7?=
 =?us-ascii?Q?bpnrvk++ru4joOvDlMcc2+Z+y8aUG1NPb0fBRCrTNOsyC/9TqlpBOf38Ut2s?=
 =?us-ascii?Q?lEkKwW6JRg7cPpvw4aFFY/RCr+3mGPJHa5HRkLEWYEt1+R8+GPYqbrTNHmPh?=
 =?us-ascii?Q?kWmO1UseufIoADrDGZPpvHiwrb+bKz/uk0w9cJR9DLbMnTSU+OLK7DexUgz4?=
 =?us-ascii?Q?jUcVLeQlKIB17N/r/tOnlboQ4EMxGm/Ga2eL+ewWDcan97wstjO3TT0kq5Ll?=
 =?us-ascii?Q?N1LytSMEO8SCkx5s0+cPC3ClOyx+o2Ykv4N95qBP0qGzPAVytJIcjmOWbVD+?=
 =?us-ascii?Q?b+q2vIYS1c7/0u1qf5b9m0zYnmvXOv+VjS6ljlrj/yBn6vE/8Z9OX2oZdJTn?=
 =?us-ascii?Q?4uSWIc/n0FGb5/ZVOYh8aRi3NZKqGTA/YGg0Ev2BZVG/PoVW9VI7YvHOLt/V?=
 =?us-ascii?Q?wde9fyaEnOQYFuWDyZio4yENpAQuQFHhvOl7byx9ID1ooznMTX3aaW1t2eDE?=
 =?us-ascii?Q?0rYS30rY35t9c7piG+Ok9SUETaKPUst7GmUBOWm1XulSmqC6wUx//FNuHfP2?=
 =?us-ascii?Q?xsvxT2RHaIsCFqeGnTUvLH9ecgjmMIFfUQ1T7TuFHZ3S+uiSlcQLBTVt3eKb?=
 =?us-ascii?Q?beppIXd41HB6jtjaEbKe1i++F7VBjvRdZyylt8M49WDphFukW3gfQmSsS1j6?=
 =?us-ascii?Q?tsn7Y1cdJOmG284klsihjtu6BkzNkso54c0dxDlcUV2c5lpu6PvbDJ91ACNt?=
 =?us-ascii?Q?r2f/YEBYlR+NFAZLAeAGlMg8LqA84JpdkZWiUVHiW0Rx8g+iuElaHvmep7H9?=
 =?us-ascii?Q?rLdY+uE0ZSnvrnESE3WQ63p3rLEJzV45EI2nvJt0Yd4YlOaRa0/kXgF1lbb0?=
 =?us-ascii?Q?QHnVMaUaPpMbvXY3mJQnUbd+WFqizPHPuSUHW9SVitLP1axePEalc3vkeXX0?=
 =?us-ascii?Q?AI5X8QLMzybC+8TH6AE3GULUJpXrg1NE9MYE7fPLejkMFjwQqvFjPaizehWl?=
 =?us-ascii?Q?Q40ALDB2lDcgYHw=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:58:32.3596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d0b403-9583-4729-3c54-08de317034c5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 06:58:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20784


On 27/11/25 20:05, Jan Kiszka wrote:
> On 27.11.25 14:37, Jan Kiszka wrote:
>> On 26.11.25 11:25, Sai Sree Kartheek Adivi wrote:
>>>
>>> On 11/24/25 16:35, Jan Kiszka wrote:
>>>> On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>>>>>
>>>>> On 11/24/25 15:27, Jan Kiszka wrote:
>>>>>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>>>>>
>>>>>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> Allows to use the same kernel for all arm64 targets.
>>>>>>>>
>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>> ---
>>>>>>>>  =C2=A0=C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>>>>>>  =C2=A0=C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>>>>>>  =C2=A0=C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 deletions(=
-)
>>>>>>>>
>>>>>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>>>>>>> rzg2m.conf
>>>>>>>> index 0b3acf49..485683b2 100644
>>>>>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>>>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>>>>>> @@ -1,7 +1,7 @@
>>>>>>>>  =C2=A0=C2=A0=C2=A0 #
>>>>>>>>  =C2=A0=C2=A0=C2=A0 # CIP Core, generic profile
>>>>>>>>  =C2=A0=C2=A0=C2=A0 #
>>>>>>>> -# Copyright (c) Siemens AG, 2019
>>>>>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>>>>>>  =C2=A0=C2=A0=C2=A0 #
>>>>>>>>  =C2=A0=C2=A0=C2=A0 # Authors:
>>>>>>>>  =C2=A0=C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@sie=
mens.com>
>>>>>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/
>>>>>>>> ${KERNEL_DEFCONFIG_VERSION}/
>>>>>>>> arm64/renesas_defconfig"
>>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSIO=
N}/
>>>>>>>> arm64/cip_merged_defconfig"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FI=
LES}"
>>>>>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62=
px-
>>>>>>>> sk.conf
>>>>>>>> index 589f071e..bf3cf9ab 100644
>>>>>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>>>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>>>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACH=
INE}/tiboot3-am62px-hs-fs-
>>>>>>>> evm.bin;tiboot3.bin"
>>>>>>>>  =C2=A0=C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSIO=
N}/
>>>>>>>> arm64/ti_defconfig"
>>>>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSIO=
N}/
>>>>>>>> arm64/cip_merged_defconfig"
>>>>>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>>>>>> initramfs with the following log
>>>>>>>
>>>>>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - canno=
t
>>>>>>> create a encrypted device!
>>>>>>>
>>>>>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>>>>>> command confirms that the device supports sha256 and ecc.
>>>>>>>
>>>>>>> It's working with ti_defconfig. So looks like there is some timing
>>>>>>> issue / race condition when the tpm support is built as inbuilt
>>>>>>> instead
>>>>>>> of module.
>>>>>> And there is no other module missing in the initramfs that might be
>>>>>> built-in with your config? If you re-run the encryption hook manuall=
y
>>>>>> from the initramfs later, that will work then?
>>>>> yes. Once after the boot stops at initramfs with above error, running
>>>>> `/scripts/local-top/crypt` manually starts encryption without any
>>>>> issues.
>>>>>
>>>>>>> I'll run some more tests to properly identify the issue and post a =
fix
>>>>>>> in here or cip-kernel-config repo.
>>>>>>>
>>>>>>>>  =C2=A0=C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>>>> Thanks for reporting. Finding the root cause will be important to av=
oid
>>>>>> that other users will run into similar issues later on.
>>>>> Yup, actively working on it.
>>>>>
>>>> Is initramfs-tee-ftpm-hook included in the build? That is supposed to
>>>> wait for the ftpm to appear.
>>> Just found out that it's not included in the build. The recipe itself i=
s
>>> built but the local-top is not added to the SRC_URI.
>>>
>>> There are 2 issues.
>>> 1. TEE_SUPPLICANT_IN_USERLAND is not set.
>>> 2. the initramfs-tee-ftpm-hook recipe has an issue. There is a missing =
:
>>> while adding supp-user to the OVERRIDES.
>>>
>>> I'll send a patch fixing [1] in sometime. I've sent a PATCH on isar-
>>> users for [2] but I don't see it on the list. Will try to repost in
>>> sometime if I still don't find it.
>> I had a look at the config diff again but still didn't spot anything
>> that could explain the different behavior. Fact is that the userland
>> supplicant should no longer be used - pulling it in is likely only
>> papering over the underlying synchronization issue we may still have.
>>
>> Did you also try with just the initramfs-tee-ftpm-hook of isar fixed
>> while keeping TEE_SUPPLICANT_IN_USERLAND =3D "0"? If that still causes
>> issues on your board, maybe you could add "set -x" to
>> isar/meta/recipes-initramfs/initramfs-tee-ftpm-hook/files/local-top and
>> also to recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> and share a boot log. I hope that this will tell us more about what is
>> going on.
>>
> Now I recall:
>
> https://github.com/ilbers/isar/commit/a1893507e495710297a2749efa3b2cb05e4=
f2881
>
> There is no waiting for some tpm device anymore. I was assuming that
> this device node appears magically in time when the in-kernel supplicant
> is used. But I was likely misguided by the timing I saw inside qemu.
>
> If you roll this isar commit back, then things should work with in-
> kernel supplicant as well. Please confirm, then I will provide some
> upstream patch which also updates the comments in the local-top file.
>
> Well, this kind makes sense because we also need just polling loops when
> waiting on partitions to appear before decrypting or mounting them -
> same reason, I guess: The storage device has to be probed first. And the
> RPMB is attached to the same device, so it does not matter if we are
> waiting for an in-kernel or a userland supplicant, both also need to
> wait for the eMMC.

[1] on isar worked. Thanks for the patch Jan.

[1] - https://groups.google.com/g/isar-users/c/sVJxkjDm6Uc

> Jan
>

