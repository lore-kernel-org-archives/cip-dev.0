Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7AED10F21
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 10:25:24 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com (BYAPR05CU005.outbound.protection.outlook.com [52.101.85.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10390.1764152723391861157
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 02:25:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=ISRjC5xb;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.85.52, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClQufThw1sf7Y4EkK3CBMWcCPzTa1yxrkxC4hWlyuHy3zrv3uoTR+kYm9tCXp5zHEACSfwNnpR4pxmyHhX3yD7XokcZ8+r5hfqnTZvCpdR9L0+Zo+5eGiGCy6YaPBPVMz/ANWSavSKTt0FmTErDFaDoCKm9yEbQ0BMV7XEIh/2OZH0FffCnrohTU+rId7/QqHy2w2AWtlJJQvpU/EyMt1ts8IDEcrcMUkN47Zhk15LcaY/FB/kBSHv02qgda0Q1GjMpGZ2I2OGClXRABjNP2PweBNZhXHH6fwsUdODd4m530g1DrN9jEGJSkXmmAXiXK8lmIYXcT+UCgXw0jICzt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv6WS0eUGnJBOUz1RYOswgQleCm0XSAXR9tou3OiWbA=;
 b=qTrZ6CY68WnDItjFQIy70Bv8zJnK+OnEVGO1KukQDoZmb3kSyFqXv0UuMCS8RaRiuieDA0781TCW7zmuDKr5cGWZSMGU4OG+/8zGzqa3GuobeokLCOA7Y0EA8RLYGo0NRV81vtbfhbd9O1i4ZtEJxIwKWWwsHGgcS9EJet/qwdVb9yKXmTdcPSCAgAhGW6zJKT+NEqgmrWWOP7LV3YZopT9Iboj6sFozPwtU+2Z8/7US3sfglRWTArueodqDpwBrLqcX7JlO74yQyupz4cGHM6TmyTaI0BWjZmzVCtdmBm7ER3sZ9Pnav4o4/LbO6r6O49WN8wsCUgyYeJ70Oi2ZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv6WS0eUGnJBOUz1RYOswgQleCm0XSAXR9tou3OiWbA=;
 b=ISRjC5xbm8dJnLu3bbuHs3xOSIFhJ4JWRxyBFzJMfiyZ3YF29pRo9E+cOFPmfDtC/X7e1JIOgX0U2zz8oiJSQRVdBcMmq9A6H7waeEOxBIPrsZb7GiayLKLnhwQU+2hEDuFDDMSPB3oCoA/bC94s8ae5Wf7gpb/camh7gVHdzfg=
Received: from BY3PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:217::18)
 by DM6PR10MB4267.namprd10.prod.outlook.com (2603:10b6:5:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 10:25:18 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::5f) by BY3PR04CA0013.outlook.office365.com
 (2603:10b6:a03:217::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 10:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 10:25:17 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 04:25:13 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 04:25:13 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 04:25:13 -0600
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AQAPBHW1073784;
	Wed, 26 Nov 2025 04:25:11 -0600
Message-ID: <b6cd2368-e868-4667-ad0e-321a468dbcb0@ti.com>
Date: Wed, 26 Nov 2025 15:55:10 +0530
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
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <f842cf21-f6a5-4e0e-97b0-00f3e6761ae3@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DM6PR10MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: d8433d30-7d38-44b4-67ef-08de2cd6187c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?o16EJF4+OiYeDbgV/GY2wjh+PnquPSQ6/isunYr5l3YBT9huzgVb0WlEWNih?=
 =?us-ascii?Q?j3IQlqzQP0sbIyjLPwVXrFojEAikTVDviOSgJbEXtMlDRukdyJuFgjv4/wG5?=
 =?us-ascii?Q?ozrZREJPcco21eJrpl6ZCxMYRykBmhmo3JC/m7075PA7mOvSdhU4xXcATCW3?=
 =?us-ascii?Q?vpDwYeN8wJxjoz0rkWHXvNwzxAPumnSottqDOqjPbggraxCAb0b4IkDBoFRz?=
 =?us-ascii?Q?xKYwgG6GODJLNE3DabReeP1DZlRNQG5rcLpynJ+QFU9gel3Krr2lQFE3TY2t?=
 =?us-ascii?Q?XSKUXq1ArjLCNB4b/zWFF8XDfKBNv+rlT9vf78zq5lKN2rPMZgT1axo9l2zk?=
 =?us-ascii?Q?PdTyo+JDki4GGfF/n8JRh46U6gIM8HhnKxMmwffhWmhgmGfcTlx0VgCRNPzZ?=
 =?us-ascii?Q?WFjotS3DmJJDkViyW2FeY1dzAURoV5OFXIFYuiGdFb+EViRT0K+HJxJCa3+I?=
 =?us-ascii?Q?6tM8p4UcsmN+PowKeMJoOzPisHAoYiW95bimtitOq2CZtij1qsP7R1w5x0H1?=
 =?us-ascii?Q?KHfOkkVusoiU6L0xdgvwo40RVlVgZuJSr5OTesDAgJNxHYBZbuAv1dMBTzQJ?=
 =?us-ascii?Q?Tll1y0dWQJF8bEPH3LSUW/+D55xk5xDZF2s8QgwLF3Rxi7JOmbr5zCB75Lb1?=
 =?us-ascii?Q?oUqd0rbLaJSImgiz3mCB5stYg49mtvXROQwGUoJn8Q06FEA/WBqbegHJ+6a3?=
 =?us-ascii?Q?phfLupUyp+MzAHNUWs2Tey3PL/d1ORXVjVjTu0OIr+vdJzV1fo+UKJEofn97?=
 =?us-ascii?Q?nByHUyzky8H6wd/bbwCtd8z6bNetMiXn/KCI+wKyquh9NTrNur0jSaC3kl60?=
 =?us-ascii?Q?KohuiQwRkztqxAODa737Wpo/Awvw60H75RdnD8fdmQbDSXK//zPBUrekMcgN?=
 =?us-ascii?Q?THlBmQMIHVdYc8B6ixJh2oN7xjuQgsLR2h1vQnB+5qUPr+9QTdN6UPypTnwV?=
 =?us-ascii?Q?IY8WdsHimeV0Vl4nYJpu0mx6oF3j61YP4hl2z3iIvU663khxBpmpyHA3sg4R?=
 =?us-ascii?Q?s+HEUdTBiQH2eOhx5S9+Hujl4AfPz36veK8/iZn+ZpV/hVnLYSCh0o3jy7Nd?=
 =?us-ascii?Q?HZgdHDWTK4mFRdoAPRFluiYd/+y27l0qacGPCrNGQRMOLt6SEYyouVB/2PE9?=
 =?us-ascii?Q?Fk0ZYw7HAShrHGEkLSjFHFDdntbYX/rFsV6EiK7T66TwB6p2FfMfxktSozqs?=
 =?us-ascii?Q?KIluoo3IxQ793DDP1JPl/hOnPMo0DpqamFEg66otQqONZpAKDXnqoQVmB5yz?=
 =?us-ascii?Q?xsp96grqt2/o3zTb9UCdIVmfjSRrQyyOE8FM1I4/QgJajD4ffhacU819E1Hn?=
 =?us-ascii?Q?3g3iG2BMQ1B66kUfRzYa5NVQJm2xz5TDzvElZZkTvN05E7pIrFbJs6CoTIo+?=
 =?us-ascii?Q?eNQG0+lvydSHAySHVySzMQEbrDqGQvRuWwlBvPKq9G2FcR6PT61P424RXGIy?=
 =?us-ascii?Q?S6I66G/mCwdoQNgI7acg644kSed//3HFf8Q53c0MKPTwVpbwuNrLnlSq5L/w?=
 =?us-ascii?Q?xzn32hjxYJdrCcmO/2VSYn2TeNTAi7DSCp9GP/E7zB0Clp42ZEfZUrsEk82i?=
 =?us-ascii?Q?qGVtgH5nSLZI98lMi3A=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:25:17.7983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8433d30-7d38-44b4-67ef-08de2cd6187c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4267
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Nov 2025 10:25:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20733



On 11/24/25 16:35, Jan Kiszka wrote:
> On 24.11.25 11:36, Sai Sree Kartheek Adivi wrote:
>>
>>
>> On 11/24/25 15:27, Jan Kiszka wrote:
>>> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>>>
>>>>
>>>> On 11/17/25 22:45, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> Allows to use the same kernel for all arm64 targets.
>>>>>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> ---
>>>>>  =C2=A0=C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>>>  =C2=A0=C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>>>  =C2=A0=C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>>>> rzg2m.conf
>>>>> index 0b3acf49..485683b2 100644
>>>>> --- a/conf/machine/hihope-rzg2m.conf
>>>>> +++ b/conf/machine/hihope-rzg2m.conf
>>>>> @@ -1,7 +1,7 @@
>>>>>  =C2=A0=C2=A0 #
>>>>>  =C2=A0=C2=A0 # CIP Core, generic profile
>>>>>  =C2=A0=C2=A0 #
>>>>> -# Copyright (c) Siemens AG, 2019
>>>>> +# Copyright (c) Siemens AG, 2019-2025
>>>>>  =C2=A0=C2=A0 #
>>>>>  =C2=A0=C2=A0 # Authors:
>>>>>  =C2=A0=C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>>>  =C2=A0=C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>>>  =C2=A0=C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCO=
NFIG_VERSION}/
>>>>> arm64/renesas_defconfig"
>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>>> arm64/cip_merged_defconfig"
>>>>>  =C2=A0=C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>>  =C2=A0=C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>>>  =C2=A0=C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
>>>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-
>>>>> sk.conf
>>>>> index 589f071e..bf3cf9ab 100644
>>>>> --- a/conf/machine/ti-am62px-sk.conf
>>>>> +++ b/conf/machine/ti-am62px-sk.conf
>>>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tibo=
ot3-am62px-hs-fs-
>>>>> evm.bin;tiboot3.bin"
>>>>>  =C2=A0=C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>>> arm64/ti_defconfig"
>>>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>>>> arm64/cip_merged_defconfig"
>>>>
>>>> Jan, I'm seeing a boot issue after this change. The boot stops at
>>>> initramfs with the following log
>>>>
>>>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
>>>> create a encrypted device!
>>>>
>>>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>>>> command confirms that the device supports sha256 and ecc.
>>>>
>>>> It's working with ti_defconfig. So looks like there is some timing
>>>> issue / race condition when the tpm support is built as inbuilt instea=
d
>>>> of module.
>>>
>>> And there is no other module missing in the initramfs that might be
>>> built-in with your config? If you re-run the encryption hook manually
>>> from the initramfs later, that will work then?
>>
>> yes. Once after the boot stops at initramfs with above error, running
>> `/scripts/local-top/crypt` manually starts encryption without any issues=
.
>>
>>>
>>>>
>>>> I'll run some more tests to properly identify the issue and post a fix
>>>> in here or cip-kernel-config repo.
>>>>
>>>>>  =C2=A0=C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>>>
>>>
>>> Thanks for reporting. Finding the root cause will be important to avoid
>>> that other users will run into similar issues later on.
>>
>> Yup, actively working on it.
>>
>=20
> Is initramfs-tee-ftpm-hook included in the build? That is supposed to
> wait for the ftpm to appear.

Just found out that it's not included in the build. The recipe itself is=20
built but the local-top is not added to the SRC_URI.

There are 2 issues.
1. TEE_SUPPLICANT_IN_USERLAND is not set.
2. the initramfs-tee-ftpm-hook recipe has an issue. There is a missing :=20
while adding supp-user to the OVERRIDES.

I'll send a patch fixing [1] in sometime. I've sent a PATCH on=20
isar-users for [2] but I don't see it on the list. Will try to repost in=20
sometime if I still don't find it.

Kartheek

>=20
> Jan
>=20


