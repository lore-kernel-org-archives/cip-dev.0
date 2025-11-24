Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7CDCFD317
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:36:47 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14000.1763980598783914321
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=fCBAjyXN;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.93.194.53, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1B7aIhT27Eo293QL+vm9WiyEjNT/HlRjo4IZO/FSr3QEL33OKG3te4QKdukEWzq4p8NIeTIVIvQX2DSTQX7FKTld0BdqeLv7FXGMAO2R1CePissqma4QdNIrY6KkrYwuIGDy0idldeeZzdeDjnifJ8abA8kskmZuFJj8z/2kzog35TFtAEirQGqBJP8DV7VBqWHtHLR6g1sQI4frN3pli8RSLIrBhP1GXQ+MAvQVs7trZza4wRyqrD4nncD/PxBRYyzMentyFd482tEIyQmG1R7kWBV/cHI7kAa2R//TQMFgVwZQuf/De8ODb0s5kx5JvrY8VqIBLAnKiH/mm5AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd24u/0s2AbcdyNq9HKewGde9XNJWr0qUSvi3busjdY=;
 b=U9D8mrrT/xH7Bt5l3BoPwoP8pBDLyZI7yfdwzqTtRG6r2lEV6K2osJZv05iUkzGexynqMwyPcGlseU8JGZGSy7vcV6lDhSxX6drbIK77Ejfqd9GCtzZQ+QPtoMDVgw46OezCisX17XPQbBrRZgxHvZzb/2YePjGQIIN+Zu3cXe2fZAQgaSocYVsy7lNSj/27vBGl8mX4IIqKK5zyqdcHfz1WRv6DwNdI/D+BnekaF6/N8pV6csxx27Nss4jPRVvSUOCTMMJy4Hf1uk9HZlo4vI7POqbV/z7LtNb1kvioiO39yWjiZWW0//Lh6pEZFmv3F4RjPwRDJG1aevtKyBDgcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yd24u/0s2AbcdyNq9HKewGde9XNJWr0qUSvi3busjdY=;
 b=fCBAjyXNyw/wD90Uahweok1Kuoo1Hj4KuCpX8Bv+1DZUD+pKrwMHPjjlHLwxIXJnYRuuhcuvYdXdQlvUvqNT6ioDIojSz8DQJfkg35iv0ScBPhBwxo5QgQ6Gv4D65/jSyw/4hh3ytEnZ3FwrfnRNCr8XWQ+CSt7TcMAGSk18BHA=
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 10:36:35 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::13) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 10:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Mon, 24 Nov 2025 10:36:35 +0000
Received: from lewvowa02.ent.ti.com (10.180.75.80) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.20; Mon, 24 Nov
 2025 04:36:32 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.55; Mon, 24 Nov
 2025 04:36:32 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 04:36:32 -0600
Received: from [172.24.233.117] (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AOAaU331762322;
	Mon, 24 Nov 2025 04:36:31 -0600
Message-ID: <1883153f-6108-4351-87b3-835c88d32de0@ti.com>
Date: Mon, 24 Nov 2025 16:06:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/6] arm64: Switch to cip_merged_defconfig
To: Jan Kiszka <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
References: <cover.1763399717.git.jan.kiszka@siemens.com>
 <ae9f51993b0cf98e41452074a51cf1a15716f21d.1763399717.git.jan.kiszka@siemens.com>
 <9d4406c8-6599-437a-b4b0-d2f07d6442f9@ti.com>
 <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <6a1364ba-93c7-43e4-a153-213048963da6@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b932f17-c2f3-4221-8a94-08de2b455782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LNJdQJzIZBhfQTUYvtnjHa0Nqoeo+5jBZGBHwN4M97QveygCm3S+XpUxA+Jv?=
 =?us-ascii?Q?YZ9BMBu/c6fbknzUWh3EZc51YgKcFh+GJZTF6mkRcKbU4nqtRHPCUvXHo65i?=
 =?us-ascii?Q?ViUIp989zDsttI/A/8AxfvGap93r7rhEOOz3TDFPkVx4SDrAHJJ2piUOeyGX?=
 =?us-ascii?Q?yMiPzrlmnK+ZESB1nTxrBaZeQXs1xbfuY1YTa7FTvef06b5hTAHqifjIXwKn?=
 =?us-ascii?Q?jb5K+inEYsaA6vGziI2+G2/mgdB1jzKu2cXbfPDoefHWYnyT3OQc67belzcF?=
 =?us-ascii?Q?jcL/TUwYNGnkwFPzoRPWIW+U2JoKWecnMB3s3vWmodYuUusnnu/IzhIbz5jy?=
 =?us-ascii?Q?aWTwr8rBIHWnkMGcNK7TTo9KhMdnfbMKaf3+zQJI7VvagRS8Mm789oq4a7kj?=
 =?us-ascii?Q?8hLtF/kvic0AvfCT4hYxswpupFfq//qsMrWWu1tCOUHmCtDgvLkVcYGxMY0S?=
 =?us-ascii?Q?pq+kALbc5hCOR5gWnlKfBwGdApz7ga8MwC5A3KV8nah+Op6jrWvpecaf6n/M?=
 =?us-ascii?Q?6cG7BoM5SLzp4gD9QfQOpG+Gfgsbz5QzAkx9sJI/Sgj/dkYGhHhxQh7zTFlF?=
 =?us-ascii?Q?TuNyWeON3S8PrTNExcFp0rP01CiWArAN+dNdeZiuumOrTw2XD/07Eyb/912M?=
 =?us-ascii?Q?AIB0ZjqzYeGKXoCMu62PZFeUI4O7ziYB0Pk4Qb7fViaZWqMw5ZxqxF+RE3af?=
 =?us-ascii?Q?BNY0AQoxETXq39KM+knM6sdWP1idHd34ZcpBQT6Yok930EijbFcZWu7e2Y0M?=
 =?us-ascii?Q?0IbR3J0RYYgjXJUpsGPBkb1FMjp6M0/QIu9we3uPWktDvoVWrXiHXojiK/LB?=
 =?us-ascii?Q?RP6Kh9KRb+G2f2heUjcNJ+tgvonoaIUGTRkkN/TMW+6KwlL66FrQ0P7hA1K7?=
 =?us-ascii?Q?AjZ37CT6h/wyGg5Puun6nyKNxKN+XMHKCA2ryvYCQpF18hHUygTVBA9TmGne?=
 =?us-ascii?Q?5AYDE0j+hiBeSed22U/r42+c0J5NzOYavObp3t4EXV+pldTDLUEyOhfjg6gs?=
 =?us-ascii?Q?sA4g527eQuToxF4AH0mQRhyWDJ/tnK79kZBIR12fI1DUSCgkYweH9W2mJ3wA?=
 =?us-ascii?Q?Dy+vH8ZzLuAXMRH+G+BdlWO59Dhhhi05b+def1PCo8pU/r7if9Bx/LqHsyBh?=
 =?us-ascii?Q?areSiajLFo6iLmw7Ig83BbUMK04rScnyX7EQyyn7X0sHAVn9HtcwWURW9mqk?=
 =?us-ascii?Q?/J+1dcW7TJxudnFBCVJQQZeVm5lHUp0+3qmNwHURBVBclyEyAgfE8PgT6PZq?=
 =?us-ascii?Q?2dXLglErliWPjaRedfb+wxor64h46wfNxJQE6CSFgl5X67OvQjj4PpFunwYn?=
 =?us-ascii?Q?fqqHi7ZTJpHRJlcjGDZPa0ZRt1zofJO0iz6rPPVNPXTdROf12c5dg2j+8rPh?=
 =?us-ascii?Q?lCgYAsJJQoS1NBApl+G43WcdcbXeEimfxSRqelPMTEUUlz1cOFWVm5xG9QxK?=
 =?us-ascii?Q?4u5DpfCtT5pwd4Djoq9mD2vMF+T7zdG8tsoKOGxXAWrtVLZygY/bv5FXp20+?=
 =?us-ascii?Q?1uA4+4RvUTxYRm7JtBBbTjJNeH2YJ3Ol9G2rfe1v6EBVVHjXRjWsT9kuuNov?=
 =?us-ascii?Q?5H2QZ/3gnQo5vX2uLp4=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:36:35.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b932f17-c2f3-4221-8a94-08de2b455782
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:36:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20710



On 11/24/25 15:27, Jan Kiszka wrote:
> On 24.11.25 10:31, Sai Sree Kartheek Adivi wrote:
>>
>>
>> On 11/17/25 22:45, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Allows to use the same kernel for all arm64 targets.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  =C2=A0 conf/machine/hihope-rzg2m.conf | 4 ++--
>>>  =C2=A0 conf/machine/ti-am62px-sk.conf | 2 +-
>>>  =C2=A0 2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
>>> rzg2m.conf
>>> index 0b3acf49..485683b2 100644
>>> --- a/conf/machine/hihope-rzg2m.conf
>>> +++ b/conf/machine/hihope-rzg2m.conf
>>> @@ -1,7 +1,7 @@
>>>  =C2=A0 #
>>>  =C2=A0 # CIP Core, generic profile
>>>  =C2=A0 #
>>> -# Copyright (c) Siemens AG, 2019
>>> +# Copyright (c) Siemens AG, 2019-2025
>>>  =C2=A0 #
>>>  =C2=A0 # Authors:
>>>  =C2=A0 #=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> @@ -13,7 +13,7 @@ DISTRO_ARCH =3D "arm64"
>>>  =C2=A0 =C2=A0 IMAGE_FSTYPES ?=3D "wic"
>>>  =C2=A0 -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VER=
SION}/
>>> arm64/renesas_defconfig"
>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>> arm64/cip_merged_defconfig"
>>>  =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>>  =C2=A0 DTB_FILES =3D "r8a774a1-hihope-rzg2m-ex.dtb"
>>>  =C2=A0 IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-
>>> sk.conf
>>> index 589f071e..bf3cf9ab 100644
>>> --- a/conf/machine/ti-am62px-sk.conf
>>> +++ b/conf/machine/ti-am62px-sk.conf
>>> @@ -23,6 +23,6 @@ IMAGE_BOOT_FILES =3D " \
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tiboot3-am62=
px-hs-fs-
>>> evm.bin;tiboot3.bin"
>>>  =C2=A0 =C2=A0 USE_CIP_KERNEL_CONFIG =3D "1"
>>> -KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>> arm64/ti_defconfig"
>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>> arm64/cip_merged_defconfig"
>>
>> Jan, I'm seeing a boot issue after this change. The boot stops at
>> initramfs with the following log
>>
>> No tpm device exists or supports pcr_hash 'sha256' or 'ecc' - cannot
>> create a encrypted device!
>>
>> But the tpm2 device is available and the `tpm2 getcap algorithms`
>> command confirms that the device supports sha256 and ecc.
>>
>> It's working with ti_defconfig. So looks like there is some timing
>> issue / race condition when the tpm support is built as inbuilt instead
>> of module.
>=20
> And there is no other module missing in the initramfs that might be
> built-in with your config? If you re-run the encryption hook manually
> from the initramfs later, that will work then?

yes. Once after the boot stops at initramfs with above error, running
`/scripts/local-top/crypt` manually starts encryption without any issues.

>=20
>>
>> I'll run some more tests to properly identify the issue and post a fix
>> in here or cip-kernel-config repo.
>>
>>>  =C2=A0 =C2=A0 WDOG_TIMEOUT =3D "0"
>>
>=20
> Thanks for reporting. Finding the root cause will be important to avoid
> that other users will run into similar issues later on.

Yup, actively working on it.

>=20
> Jan
>=20


