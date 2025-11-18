Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5140BCEBF93
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 08:03:58 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7726.1763453020374492354
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 00:03:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ufRNUEkI;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 40.107.159.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNYCwRjRBZJO9rDejKdjvCqhPSIBx5SsyLVFEKfxWEkQ0NFLaV0c3dVYF4MK5Dgt/9uBvpTzSElMkzXVmzKOf8hccYLUOwd10j8dEbVoFFlxWNPSiPX4c05JuseL5GGPBLUx37ZSYtQ/hExD52POdWm+NyFKOhywkG/+NsO4u33ggz48vDTKqVgH5wHbzZS6PACjleGcGuFMN1PS48ybTWtt5ku7pH0lJPuYzNDglipaVj3NJnN1rt69AdB5Hn82N0AZATWU3g5ughH28JdI2APKeKobhNx8+2ontmSzDqifjJSFlzc5M4zcudCA08SG0dAUwlIttcwer6uJMCqpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6xMXZGwm8DK57ejPwRaILYXepim5e0Fg3nFm9qGfMY=;
 b=WXurJ2c5QllbItfguXJ9jY6g2OQM4XChFKX5UMI2eGqmcBJG41I7e5ChotfIHaaL6H5ATB6r52WlZoNj6geV4cJF+KdZZ6IzvD4AZBSiXSZ4JDYEsVQJ1ifqDyPSRVvs8vmC2BKdbwWXNrKQ+5b9jOS12isF/JeoTSG783YGF8TIvd0lWs0DUT7djDSvze8y1a7DDos8uzicGHifq0b9GuQfs/VYHBeZEgBWK5DcXy3sV0K8VuSXdrxXCycM84TbFeaIwJYmC/n4A4IuIQmKXoOKrYfFRDQIw4NwF0GlR9nOz4ek/Nm8ftSbhER3IxK+aMpU+mpml9A7t1wupimMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6xMXZGwm8DK57ejPwRaILYXepim5e0Fg3nFm9qGfMY=;
 b=ufRNUEkIU48b1sLmJF0oGkR2MDKqIMTAhmOw4SzPkH5Vmvj2Lf90Kd4NA4htGQ/dexnJB6tykG+lk/ACwRyArLGcWABwB/rAVft+1i95rBV47OTpTiasioNBu/Cun3sa+oyia0aML+o7WvRdquWXU5mAezZ69ksHSfzKkY1gieSZyQ5D8QjIacM+ayLnTS9RK5BxsQEjUrfp0MM8nepdJWfYhJAOnCsEW6CQYG+3jxtKQNfQlChC1Iw3zq638adq3Q6kVi6dWcAQHjqbCIYp55iIsSh1cPzs5oBFHBO+f8xvoc85Duc7BbA03tGv7Z9G4TnyfWJ6/tfuFJ7LQtQD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 08:03:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 08:03:36 +0000
Message-ID: <23d50a02-2273-4c76-a89b-32ffc8249a3f@siemens.com>
Date: Tue, 18 Nov 2025 09:03:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 4/4] ti-am62px-sk: Add support
 for secureboot & data encryption
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251114090509.2935933-1-s-adivi@ti.com>
 <20251114090509.2935933-5-s-adivi@ti.com>
 <07b0cdc9-6aa1-4ec5-b9cf-44fcd5a663f3@siemens.com>
 <6aacb3eb-9f12-470d-86ad-5ca712f6aaf1@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6aacb3eb-9f12-470d-86ad-5ca712f6aaf1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb47050-0c51-448a-144d-08de2678f9a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?X/Ot8/9L475ZOpkasQMo4JncqG0FdkxH0OUtXRVu9DS+K0jy/BAa1upM7tvZ?=
 =?us-ascii?Q?i6PBlOABdqKPyeMs08OHoKL0C7FgYOWkkKG9WeFZXoWq8nhTRVjffufiXuyz?=
 =?us-ascii?Q?vTYi7O2UnlREqa1W15niYKIUkRUNQsddlt9g6O2AMb2hnA51sotVmrz2UpRw?=
 =?us-ascii?Q?wEX6Kj/2TYw3AvApYuJ2qaH07wPLsLNT2macXVuzjELRPzCvSIWZBKWIu7Uz?=
 =?us-ascii?Q?3ZM/02xAwXHt77c7+9Ol0Y/7fW297iaCbswg4m1KWLx+35czLQy5ou7ERGsu?=
 =?us-ascii?Q?YBUTfKV26DPeBOQhb637Gevl74f8Rk27GjUk+lLRWRf53dz4FcTEdSWGx026?=
 =?us-ascii?Q?hqcsvWUTAumNRLPb5nCGplPow+CvCw40U0rKMXxfzItbBKUI5ImRj3NvMXlJ?=
 =?us-ascii?Q?9C+1AS50FnWl13JF/yOa2NIA27HJ17mO+4q5ynOPCJnYDIx8qtoaQ1B3k8uN?=
 =?us-ascii?Q?p1qVCHS0SB1Bz0CJWv25nMTzZ67u3u20+FfaTY4uoBvkAek+aBLHqR8rVEs+?=
 =?us-ascii?Q?BJnZLZ1dIdsDei3ep2nfBP9hFn+ez727AkHVIn6KNjs8EluMLfRlsi7948LM?=
 =?us-ascii?Q?u5iDTHPzZnBoDTHRmZ8r+rgjXpoWm5ZBDAb3Rge9p6IfzW9O7dr0yyhw0ch5?=
 =?us-ascii?Q?Ub9kxOIw2YBMaMdVdpeF6TUoSwfb7l2E/kxu+ka/zlUaBIRWi8rEwnaYsctP?=
 =?us-ascii?Q?xbYIIukzQcLaUtQJKW3zSfywWlEQCcGVBDru6aIbdyywCXqGIFu8rMfDX8rO?=
 =?us-ascii?Q?2gqhoeLa7SjCnrA0icnDbo03IqREzIy2HcZPEAWi8bUhApj6H6ApYFozmIRm?=
 =?us-ascii?Q?eoHf9QrU7Fab2MTy+ZSlL3ig2FJTPnFZEdU9i5Yo+o/dwC5+WFllJq9L1Fwx?=
 =?us-ascii?Q?ocpHIm7/uXGwCbthHrSCer9FeaDzKllne5ujZ6tt2k4cQR+ZHjaM4+IJRjCi?=
 =?us-ascii?Q?RgBJI0NfYGrDikYGZ2HbFlbpfzn+ip692WpuUJVSRCzU5zB+9Y+EE9jY34wE?=
 =?us-ascii?Q?g9o5hS3Nb5qNE9iIju37VUb/XGQAEIe8LIGp5edF2vscw0PLEnK0E+kp8u0e?=
 =?us-ascii?Q?fCUTTYz3calgDusDlAtxQE43VVmGYVPCPp7e+vyNXxzXuQ8ze+s0koOMUbMj?=
 =?us-ascii?Q?fnZyCjKTOAqTxj8xrqrLbIKtNs4ttB0BDwwWKikI4jqIi5XLTBhdtfgR8Bti?=
 =?us-ascii?Q?lZ0NbjmZukFCapjxUZvvJmPItP1jU88YFhql4yl0BA3Ghn1MuteIAKL+kYbP?=
 =?us-ascii?Q?9AWyTrBcXR4AEVwgDJd3iWzQeYDHpUDwxpAZ2fkDE62IGoP4hktAWAF6PtvO?=
 =?us-ascii?Q?E/4JMKO+4BZZulAILKluzHqHhEOAWOrmj0aihBW7HFXN4MkgeAKZeMdRq1Zd?=
 =?us-ascii?Q?mbZQBrCu8sBikh+i64IXEeCX+1u7c5p4K0QONP0BTnRZBug32A1shjWF7qn7?=
 =?us-ascii?Q?+6W/e9cahxI4bH5QwKANI2suOzhX/YSIHbp4ltNn2IzCqT95OG+ftQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WyOvcoFj4rh7Q6Ko3xh5+Gh+uzT5OCPvs9223yGw0VuLoKJ88R2gzh2SOtB8?=
 =?us-ascii?Q?deEt+lcd9d6mPdlFFkYVuAe/OL6sutmKJTSJgGXK7d0gPs5JrSrHQSiOtRYR?=
 =?us-ascii?Q?To3PdYaXi7adkxi471W1z1JPPH4V09BFItGhMcwtDGcEy0yGyPTiRfRUNoMK?=
 =?us-ascii?Q?W1l9Eu/FCFLPXCLN1Ob9DZXq53zzOvk8AXByFayDDXsziwGI8HRQaIwYpq+4?=
 =?us-ascii?Q?8mTkrfTUdHh6FH299LbjyEQ3sJg2YSktnHOxWh8EogYRZhMW+EZ4XkTQXIFq?=
 =?us-ascii?Q?U8DtYpqtEW6nU68DIZFv+M0bkA603XPt5koxXc8SmDc7CccDitmPqJcKR1jz?=
 =?us-ascii?Q?iAfuooAsw3VZiKhFK7kbpplIjiDMK9zIDRcQ1thKIGbedUD7vl8kFfXkWKj2?=
 =?us-ascii?Q?YAOiTUtHNowogdekDFoeM0cFt0VeFoNUJ3Mk8GWVdmUvtxMQR035SO8MfncK?=
 =?us-ascii?Q?hRtfr3guUqOUqT95EJIh/b6A/0Ulq9eQYa3Axgzzr5aIXCUdwsME9ubkN3vT?=
 =?us-ascii?Q?IdxYPeztYquYu23ZJuweVsMkvHRkF68QzWxcTT9SFI1JEbUoSBMQ+R/SOuRk?=
 =?us-ascii?Q?j22S/2cAEEQ7KrfZsQYC/7F1vfGjnerbyN9fy7uGAoK0R7OIbdca1kz7R3rq?=
 =?us-ascii?Q?OS3MusdkWnZgoQf8rcWEzWo1qtI8bMDZUPGRa0lRv1k2VG1fajVog7St6uwY?=
 =?us-ascii?Q?jI3V2EBULk14QmPn3s14UvVGH/qc3VGiLOsKaUyAG/K3e+R700L1PkM2UV9R?=
 =?us-ascii?Q?YW0qHX1ry5zooBSEYLHVFt2xPmJHSUAtdJHcrzPUeBWdI6wLQbl7NRytINQF?=
 =?us-ascii?Q?A2Me3RgvTRwK1IReAyHx0hpva903v6PoBShI76Vvq1l4zTMfjLxS/dHlPQFT?=
 =?us-ascii?Q?TTpv8XytB4csa/2LMTrmHmLAIvygi7j2RDntFv3Ijx+gSxENorSN7P4ZUwNR?=
 =?us-ascii?Q?YcitMrRDpk2Wcp6oeRxOj4o7TidtBS8rLeAzrcwvr45rdwT77qGnUCmTcl6R?=
 =?us-ascii?Q?ji5ECzS7jUSUGI2U6H19IYRH0Mmnf6SSstBCb4q7l98mkHI7lJf38UTQK3YW?=
 =?us-ascii?Q?65gyjCwV1u1dx3QcbkeFYbwuLagJoR2yUZMjIzr1QFOSrvIp6Xd63VOQTmm5?=
 =?us-ascii?Q?BZXv1ece/LQcHbzoJZYOaQTumRFa+5ru9NWBuszXN3mqN5gMSU5Ra5Ajczc0?=
 =?us-ascii?Q?bckkMTwiXUaqUyVCGl9hqhTm2fQ+FEMIHqzudSVuVfJFuhaekGs/oEd98iiQ?=
 =?us-ascii?Q?fjTdCXyx1XOHdM2HSyoiJnwxtP3MfIDbxq97rF5C43ohZvrRhaIQq+GLLtR1?=
 =?us-ascii?Q?iR5zkIXrWuitqNvl0/rrsYHqlakj0alRRLXcgz+vZR8/VX/zmy39pqdOw0Pz?=
 =?us-ascii?Q?vrrkUHHmE3upi7CZSSURzt1sfzGwZhQ9MH71Xw1GSoiSKb/xeNT1Qyisi+Sm?=
 =?us-ascii?Q?XycVcvP0UErtMrBWDN2+FLSLkWRpGbvbHLhjAWnsJcVOZj2Bl25cUQx1WOZl?=
 =?us-ascii?Q?Vphxzxw8Z8YB/xj6kUOmU341nzoSBSsObZrbsQt9LYxzh8+SI6bzG37EeFet?=
 =?us-ascii?Q?2Q+5lwJ1+iCEFN3h11adkWQwHPDC1EuolEFz9Ik8WahTSqIuz+d40pLi6aV2?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb47050-0c51-448a-144d-08de2678f9a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 08:03:36.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHlA8H//DK+yAD+ATp+k5z5RHilOCIfbk01drYBiqZlvS3S4xeZVy5hI19uh/9DHNTt9CzV9j3nkHejPzgxtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6643
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 08:03:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20610

On 17.11.25 12:13, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/14/25 23:07, Jan Kiszka wrote:
>> On 14.11.25 10:05, Sai Sree Kartheek Adivi wrote:
>>> - Add new recipe for optee-os-tadevkit, optee-ftpm
>>> - Integrate OPTEE-fTPM, StMM
>>> - Add ti-extra.cfg for enabling RPMB, FTPM and StMM related configs
>>> - Update Kconfig to enable secureboot
>>> - Add wks file for use with secureboot
>>>
>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
>>> =C2=A0 ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++++++=
++++++
>>> =C2=A0 .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 +++++++++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb=C2=A0 | 16 ++++++++=
+++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc |=C2=A0 5 +++-
>>> =C2=A0 recipes-bsp/u-boot/files/ti-extra.cfg=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++
>>> =C2=A0 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 +++
>>> =C2=A0 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++=
++
>>> =C2=A0 8 files changed, 111 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-
>>> k3_4.8.0.bb
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
>>> =C2=A0 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.=
in
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index d322a94..536162d 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -104,6 +104,10 @@ config TARGET_TI_AM62PX_SK
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Texas Instruments AM62Px SK"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_ARM64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAS_SWUPDATE
>>> +=C2=A0=C2=A0=C2=A0 select HAS_SECURE_BOOT
>>> +=C2=A0=C2=A0=C2=A0 select HAS_DISK_ENCRYPTION
>>> +=C2=A0=C2=A0=C2=A0 select HAS_OPTEE
>>> +=C2=A0=C2=A0=C2=A0 select FTPM_STMM
>>> =C2=A0 =C2=A0 endchoice
>>> =C2=A0 diff --git a/recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb b/recipes-bsp/optee-ftpm/optee-ftpm-ti-
>>> k3_4.8+v1.62r1-48-ge9fc7b8.bb
>>> new file mode 100644
>>> index 0000000..2cfff21
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.b=
b
>>> @@ -0,0 +1,28 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require recipes-bsp/optee-ftpm/optee-ftpm.inc
>>> +
>>> +SRC_URI +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/OP-TEE/optee_ftpm/archive/
>>> ${SRCREV}.tar.gz;downloadfilename=3Doptee_ftpm-${SRCREV}.tar.gz \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/microsoft/ms-tpm-20-ref/archive/=
${SRCREV_ms-
>>> tpm}.tar.gz;name=3Dms-tpm;downloadfilename=3Dms-tpm-20-ref-${SRCREV_ms-
>>> tpm}.tar.gz \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +SRCREV =3D "04cbc8a136e8fe6731a536f5fe145e2862feafd7"
>>> +SRCREV_ms-tpm =3D "e9fc7b89d865536c46deb63f9c7d0121a3ded49c"
>>> +
>>> +SRC_URI[sha256sum] =3D
>>> "7adfa71c4b49affef7d4db2436d8d6b93cdc3aaa9bdc9cf795c0bf7488a4cac6"
>>> +SRC_URI[ms-tpm.sha256sum] =3D
>>> "b77d092c0dde362adf6bc88a580ca7c8abe124d69bb734bf28f8904ae30494a4"
>>> +
>>> +S =3D "${WORKDIR}/optee_ftpm-${SRCREV}"
>>> +MS_TPM_20_REF_DIR =3D "ms-tpm-20-ref-${SRCREV_ms-tpm}"
>>> +
>>> +OPTEE_NAME =3D "ti-k3"
>>> +
>>> +TA_CPU =3D "cortex-a53"
>>> +TA_DEV_KIT_DIR =3D "/usr/lib/optee-os/${OPTEE_NAME}/export-ta_arm64"
>>> diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb b/
>>> recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>>> new file mode 100644
>>> index 0000000..6e396fa
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>>> @@ -0,0 +1,13 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +OPTEE_ENABLE_APPS =3D "0"
>>> +
>>> +require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
>>> +require optee-os-ti-k3_${PV}.inc
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> index f8cd973..e73a7bf 100644
>>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> @@ -9,3 +9,19 @@
>>> =C2=A0 =C2=A0 require recipes-bsp/optee-os/optee-os-custom.inc
>>> =C2=A0 require optee-os-ti-k3_${PV}.inc
>>> +
>>> +# StMM integration, required by UEFI auth variable management
>>> +DEPENDS:append:optee-with-apps =3D " edk2-standalonemm-rpmb"
>>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", edk2-standalonemm-
>>> rpmb"
>>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
>>> +=C2=A0=C2=A0=C2=A0 CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +# OP-TEE fTPM integration
>>> +DEPENDS:append:optee-with-apps =3D " optee-ftpm-${OPTEE_NAME}"
>>> +DEBIAN_BUILD_DEPENDS:append:optee-with-apps =3D ", optee-ftpm-
>>> ${OPTEE_NAME}"
>>> +FTPM_UUID =3D "bc50d971-d4c9-42c4-82cb-343fb7f37896"
>>> +OPTEE_EXTRA_BUILDARGS:append:optee-with-apps =3D " \
>>> +=C2=A0=C2=A0=C2=A0 CFG_EARLY_TA=3Dy \
>>> +=C2=A0=C2=A0=C2=A0 EARLY_TA_PATHS=3D/usr/lib/optee-os/${OPTEE_NAME}/ta=
/
>>> ${FTPM_UUID}.stripped.elf \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> index 444f6b3..5ee5020 100644
>>> --- a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> @@ -21,7 +21,10 @@ OPTEE_EXTRA_BUILDARGS +=3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CFG_ARM64_core=3Dy \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CFG_USER_TA_TARGETS=3Dta_arm64 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEE_IMPL_VERSION=3D${PV} \
>>> -=C2=A0=C2=A0=C2=A0 CFG_TEE_CORE_LOG_LEVEL=3D1 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1=
 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_CORE_DYN_SHM=3Dy CFG_CORE_HEAP_SIZE=3D524288 \
>>> +=C2=A0=C2=A0=C2=A0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
>>> +=C2=A0=C2=A0=C2=A0 CONFIG_INSECURE=3Dy \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "
>>> =C2=A0 =C2=A0 DEBIAN_BUILD_DEPENDS +=3D ", device-tree-compiler, python=
3-
>>> cryptography:native"
>>> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-
>>> boot/files/ti-extra.cfg
>>> new file mode 100644
>>> index 0000000..faff390
>>> --- /dev/null
>>> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
>>> @@ -0,0 +1,19 @@
>>> +### FTPM + RPMB + StandaloneMM setup
>>> +CONFIG_TEE=3Dy
>>> +CONFIG_OPTEE=3Dy
>>> +CONFIG_OPTEE_SERVICE_DISCOVERY=3Dy
>>> +CONFIG_TPM=3Dy
>>> +CONFIG_TPM_V2=3Dy
>>> +CONFIG_CMD_TPM=3Dy
>>> +CONFIG_TPM2_FTPM_TEE=3Dy
>>> +CONFIG_CMD_OPTEE_RPMB=3Dy
>>> +CONFIG_SUPPORT_EMMC_RPMB=3Dy
>>> +CONFIG_EFI_MM_COMM_TEE=3Dy
>>> +CONFIG_MEASURED_BOOT=3Dy
>>> +CONFIG_CMD_NVEDIT_EFI=3Dy
>>> +CONFIG_CMD_MMC_RPMB=3Dy
>>> +CONFIG_EFI_TCG2_PROTOCOL=3Dn
>>
>> Some of those are part of ftpm-stmm.cfg which you get anyway. Maybe you
>> can drop them in a follow-up patch.
>>
>> Then you don't need TPM support in U-Boot for our integration - or do
>> you have scenario for that? Doesn't do any harm, just curious.
>>
>> Did you already test if measured boot works for you?
>=20
> I've enabled TPM support in u-boot because measured boot depends on it.
> And no, measured boot is not working yet and it's still a wip. Do you
> want me to remove these configs and re-enable them with measured boot
> related patches?
>=20

Missed to answer this: It should do not harm to my understanding, so it
can be left enabled, even more if it helps with further testing.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

