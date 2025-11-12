Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC108CCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 08:10:44 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8503.1762935042839575653
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Nov 2025 00:10:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Hpg4JZ7H;
 spf=pass (domain: siemens.com, ip: 40.107.159.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiQOPaBDwE5zzW1/mivgV8afYdHWWC9RCYI36RosHoMgEqF83hgyU4lNaeRQ05usG3Nfc9ZUX6VettxSJF5sJ4Ztw0HOJc2KNPEse8znUN6lcfyuZSmnkKYFc+BmUtDlrXuLU2CWgoK1iZEjDwHRfyaMkcARvHmvm6TcYiiFihdPhBjhSsWsNgihZIHwTwqq4rAFmPvhRD0PzQXfQFz8B0BItHKwm8wR4dbBUqZlT43Br+pUvyGUbEWIq9vGh8SuKcQjQMAkcYEuGxO3foJKoY7KJ3hJGUlkKrggeuMmJ/58lfyEFKjNHgR6WZEtuJGeC9O1EIAcxj8vuILsApQn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpLuz1nhi7GohQ/SN8SAzYWAqI2UjsAljOrU1z1Mes0=;
 b=MIjJnYA9NMEhbSPbraPIkyMakOPbdR/XqhlB5foq8XOMHCVnQPxGfH9Ti30u8KQOeYGdkbhs5XZ7owVKl8CxEL3FDFP+faT6IackQBByi2sO0BYY4d6CcxlV/jLc1hKtXH5BcF4LiH37Tf65Up/b4MXxN3Nm/u4evL5RbZf4SwxA0WvD9/EP901w1Mjrhbvns6vEYJ55cNoEf+Qzi9QJ8c9eHFrVq+0RfpELqrjxDupehi3tdlwVgNDZlyah/XJywiKNGV6UqGvLN6bgVeT8XGUhSzhx1J8JkiWgImo+ekwJ9Gj8IsWANM4VlFjGMK2qvNb3uzZJnzrMU2uSu58l2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpLuz1nhi7GohQ/SN8SAzYWAqI2UjsAljOrU1z1Mes0=;
 b=Hpg4JZ7HLB6i010Yk9XMcTVcRfseQYqGufRxhRiIK9ly0OmoSl6xAQFVpcfYigiMXF/jbxqIHcbwL3L/lewMRUsubMeSE6ox49Mmbl4VSyV3/AAPaZ17t7MHZsrZldj0OuItc9UAde+cxWcaueBJOeJONMr7WXZ/3/ttYOy19AFhPxwlILO3azZZ1vncPS3yVumVrUBDdtSz/1N7LfOS8+/8Uq3vx0rwXjHIlvmLIkX/TAujY+dSktkqxAcNB9LczJWHJdAwBDiAbHFWFnELHix3EEIE+HIMT5y7ZuJZmd2u7uIPfKsSmRlJ3syWJM/1Ef0zGxyAthsxR+prSyHqgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6137.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 08:10:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:10:39 +0000
Message-ID: <6b45758b-5fff-42fa-a6c3-a9e3f27f5cdf@siemens.com>
Date: Wed, 12 Nov 2025 09:10:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/5] Add support for TI AM62Px
 SK platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251111164508.1707234-1-s-adivi@ti.com>
 <20251111164508.1707234-2-s-adivi@ti.com>
 <0e889535-0845-4f2d-910e-7da838d26577@siemens.com>
 <3c42b107-faea-4b18-90b0-53d45286d6a6@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <3c42b107-faea-4b18-90b0-53d45286d6a6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: d253c1bc-2bed-4658-99d0-08de21c2f767
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NaBDaOSYyKFY9vjZYAN/lULBNSW3YkpT+Oa5eEsgVrTGGv6M5xfnbUnm5ehH?=
 =?us-ascii?Q?0hIAz6PIxbMZNjzzEds82bi+808OAe91gugeMw7iIs6P92ylhmf3ofcrItws?=
 =?us-ascii?Q?q7l8h528udpl9hKpKX9cqt/UUal+UdlSi7fkizB9ywzNGQ6oFQ5y7Kdu+USG?=
 =?us-ascii?Q?FKOXn5/JQUjiUTrfL8YJ3WPHKieFwNquR+zf5D47GmE9tsO8qlBR52PnI7hF?=
 =?us-ascii?Q?tI8H8GPpljqmjFZIonrF/4F481Xvl/iVYVzmVxJYB5k1KB5LNkCMMaECHFQ8?=
 =?us-ascii?Q?GcBd4CVRyQYumaExDLVZNAxq9tqgppy15WOmLJRortwJMJuldIc1LTuWlfeA?=
 =?us-ascii?Q?GJmja1gtFcUk0Nz2ZqxP8zbmfNrAsN/O67cGv9UGlo51aNdGciBchvmEqVdc?=
 =?us-ascii?Q?8T19788/X8Fjp2m2TGJ8RONnwiyraOnmCIyDUIn1Qgw8TNOiGG+KGNeg96Dj?=
 =?us-ascii?Q?+mLgyI+vD2Z0dCJcYiUlCmljODn+iPlJRvrrPSF00NUgIk2ePJh8oIjpZx+q?=
 =?us-ascii?Q?MXqu+R8uwar0uaKaRC4MIzqeIzjFQ+PBbtllTSi5wlQACFtppqPGFqLVIB2B?=
 =?us-ascii?Q?Zc3w/pUlUF4t++XBoBiiiWBUf/5n0M7ts/BTR7SRRuOS5zB/thITQEi+spfR?=
 =?us-ascii?Q?OF1JvQp8IRND4R5XxGr31NPcX2crooAtn2MkzNGOc1HNQY5SMAHPcuwpAaME?=
 =?us-ascii?Q?yxCG5zgtR6NwJpNfZypxkoRXFHjEd/vyQdlvqMHBEcJVq426rtkG9nGPa82W?=
 =?us-ascii?Q?k/1xR6UfhiyL+lKnHuaWCZ+9GK4ccDDB6Xaas1TEaHAduCt/UxSKFIaNHhzr?=
 =?us-ascii?Q?a5XPHpfaWS+A0UAw73lfFOdhvC8cvF67t4I4YXw10enHN/EfWvw6yeDT5IIU?=
 =?us-ascii?Q?88GDorLMuTkakZr8IcprIi7fy5quBCEyEcEpy83CBK7o1XcW8Y1ILLOrp9Pv?=
 =?us-ascii?Q?y6YNCzlFgYeO5dZXmoMAfhXl3D1Y/ZBieX66YrvLfIvP+Eep6Cykx1gAeHBH?=
 =?us-ascii?Q?p0smmm3+tOJlknXp/LvALovoJzhfA+sOr9Bq3yqoiAZQJTygTRWRvH7Mnbq6?=
 =?us-ascii?Q?mykPIZz7YrSuAts3Li/ZwtZ2E+EokDMbGSf0bAYs8U28TGjRdETNLtuwL5jy?=
 =?us-ascii?Q?vh+VUh6mjzXdLJLGs2qxZZP06FlmlHwZD2y03LEI0jK5NPdmJIXvBcHie5DJ?=
 =?us-ascii?Q?Iw0A4gaNYKtfmDjkynbHmaoZ63at/A9lpekvI5mFbKDE8HW9daDJ84z/X5nZ?=
 =?us-ascii?Q?7eh7Qz+axTJjZ9/nRhx2Mskk5BJ0WPwyneXxOxQAqxZzbtmEZ8trGXHmlhM6?=
 =?us-ascii?Q?kCGoqBp4g6hT2vgmjSmfSdz9NeBatg61bsFMEag621ZJBsg7xsZApJ0cOaPu?=
 =?us-ascii?Q?eHV+HqqonM5CIIt6G1lA+vaW4T9WGQFlvmrit2z2J1yAk1nxe0tUEnOIbhva?=
 =?us-ascii?Q?MdGKpBrf7cAS4ebq4cXaWxUrkf1bV0hxfsq8RqvmCKOM0OLG3kNitw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KicYTPrtohEBQsx5DCYfuPdBNAkMJXj1Ms4ywbWAt/+9QD+ZdTVXLyaKGo8m?=
 =?us-ascii?Q?9F7f7heWWTMy7+Apanf9rqCWK3F8kceQYLFJF93T7ONYaxvuyJh2ZmeHnBK7?=
 =?us-ascii?Q?OcCT9L2zs11gGjcKvYzGpYExJ2wrAnTO3VzSIDy3yw3bcHaUZzohPZYgtJQr?=
 =?us-ascii?Q?tK1sPbWIkbyZoD/R0dVD+F5elk4bFKqrLoErwhdp3iya1UIFfvCeh5pEPRdO?=
 =?us-ascii?Q?qMsD+nE55CiXJ+VsIP609/edPBVGK2lflZBe/RDPcLm1+b4PWp8MyU6SEPQp?=
 =?us-ascii?Q?l53VQgVQxgyuSIJbpHfDr8LbOwAA95QhmUfGlYyC0OTDReorE2RbqlwnPUeB?=
 =?us-ascii?Q?JrqaZ4/Am81OfDEHD8MwX1RqOttn1h7lz80hywLhuEQW2lySciSxbUBb0ZuW?=
 =?us-ascii?Q?SuN+wYzd6uJ8I/MBzrqsv/hqR5Us2Y72vzgDRB38pX72gknFFcgg+ja8kfPc?=
 =?us-ascii?Q?sEJS8Lnth1GIhe9tiXxAVmKNKCyZXGMpzHCgRydGlaZyigUHFlgIUtMeAAV1?=
 =?us-ascii?Q?nC+E89tpqMOoLPlkVlAhxk0Vyd1SZ6CYjbz+VjD0ULLwGYzb9TUsn4q629MW?=
 =?us-ascii?Q?okqMB/q7eBHTqLKUeVIgGnz1OJMtDpHa1Xv+se5KIUtvgJibwqjCcP1tNpXK?=
 =?us-ascii?Q?idQ0a/eNfatrrp4O6JcMbEGNByxeLDjf5eUkVHE0MUUW/Bf2FmcRa6mGAvgr?=
 =?us-ascii?Q?oeD/xeUx1jUw/jReonKsbWRafeOmHw23zOxGUjyfq44TNWYLiQvuwbhPGE4G?=
 =?us-ascii?Q?dWMatMQi/ss0rQZ2XZ5gmGOoe6Pt5TpzcCsgTl5s9rHOIhgVYrbVVZPilJQO?=
 =?us-ascii?Q?YfHUG7zETA3TxaCdvpiGPzJj1UxIdT2wXUMr+GOGLoa8Ejl1aViFGB0YKVg/?=
 =?us-ascii?Q?oFcf4iY1Rfh89ISGJKY0mv8g+9+hbPyVotJCsTDR7qhWJKp6XQg/sZ+cp9NN?=
 =?us-ascii?Q?wYCSg7DVW3AEZW3+TL8rqdFIcScYe/jvHXYdPYsmcAmTAX9OLXvxGktBx73m?=
 =?us-ascii?Q?kKirdGqgVvNOTU2zzIof0AnPWew355ORZ/GjG6qv1IJGSyVbzqkhxNomzmiz?=
 =?us-ascii?Q?a4TazcpKApYg7OaincWVNYS3OJL6ehNUs2k9K2DoSDUJJPwGlICaJBVnd5sK?=
 =?us-ascii?Q?/JJcCAw7AVVlDnT6J8C/zikSU1d+h+SiIscDD4+X+fnDIkbu43OE8nhhStSQ?=
 =?us-ascii?Q?sTgXCOwc2+Q12iQKYQCExpkjfzHnoKgfUjm3jtFKwZyxTS0qvdJ1UyGxbaf7?=
 =?us-ascii?Q?BAal8sBpQmLOOlat/WB3EVCeiJqxnDnpHrKFy/0n1N7dU9fy4MbcCz6OH4Ot?=
 =?us-ascii?Q?4IbLqtX2wqlrwE3fYs0Eh1JQERBX0qEO+M6OAYAz5njgd0QAJoTxad6BwLTI?=
 =?us-ascii?Q?ppxVRzvMdIPN0zmz5E2KvSigGdRHcDhNGKOMg34QO6bwv6zXb/t6incRAyD8?=
 =?us-ascii?Q?tS8AKWSoaKZ9UVuIXP2HgG3wFY8F9m9GumrMgMK96lC0I0yWwNALTc6jSPWc?=
 =?us-ascii?Q?QjHXGZspUjTmv4VQ0EIBt8kwIwxtLsRM6QOou9+pzXT/1RIApOU2eMhWy4TC?=
 =?us-ascii?Q?cQnvI5+2/wCd5vqaW8gXS4HOISJy6Za4fBUyrCyycKO9jaynag8jMOs8Vhsn?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d253c1bc-2bed-4658-99d0-08de21c2f767
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:10:39.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbQt88o8boDNKcL7/8UdhTEJVItzM2zBoyaeZ1GGgBYdq7dL65db6Q8xX1Z5ReY/LOi00yMtjLot+7U0WQ6MwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6137
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 08:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20514

On 12.11.25 09:08, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 11/12/25 12:51, Jan Kiszka wrote:
>> On 11.11.25 17:45, Sai Sree Kartheek Adivi wrote:
>>> - Add machine conf and and kas yml files for TI AM62Px SK
>>> - Add u-boot 2025.07 recipe
>>> - Add patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch to
>>> =C2=A0=C2=A0 enable KASLR support. This is already upstreamed to u-boot=
 at [1].
>>> - Add new recipes for trusted-firmware-a, optee-os
>>> - Update SRCREV for cip-kernel-config to fetch ti_defconfig
>>> - Add wks file for supporting image builds
>>> - Update Kconfig to enable build support
>>>
>>> [1]: https://github.com/u-boot/u-boot/
>>> commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
>>>
>>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> ---
>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 11 ++-
>>> =C2=A0 conf/machine/ti-am62px-sk.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32 +++++++++
>>> =C2=A0 kas/board/ti-am62px-sk.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 13 ++++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb=C2=A0 | 11 +++
>>> =C2=A0 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 ++++++++
>>> =C2=A0 .../trusted-firmware-a-ti-k3_2.13.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++
>>> =C2=A0 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
>>> =C2=A0 recipes-bsp/u-boot/files/rules-ti.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 33 +++++++++
>>> =C2=A0 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb=C2=A0=C2=A0=C2=A0=C2=
=A0 | 69 +++++++++++++++++++
>>> =C2=A0 wic/ti-am62px-sk.wks=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++
>>> =C2=A0 10 files changed, 272 insertions(+), 2 deletions(-)
>>> =C2=A0 create mode 100644 conf/machine/ti-am62px-sk.conf
>>> =C2=A0 create mode 100644 kas/board/ti-am62px-sk.yml
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> =C2=A0 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> =C2=A0 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmwa=
re-
>>> a-ti-k3_2.13.bb
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-
>>> OPTEE-RNG-support-for-K3-devic.patch
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/files/rules-ti.tmpl
>>> =C2=A0 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.0=
7.bb
>>> =C2=A0 create mode 100644 wic/ti-am62px-sk.wks
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index 68773bc..0930f7f 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -86,6 +86,10 @@ config TARGET_QEMU_RISCV64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_RISCV64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select HAS_SWUPDATE if KERNEL_6_1 || KER=
NEL_6_12
>>> =C2=A0 +config TARGET_TI_AM62PX_SK
>>> +=C2=A0=C2=A0=C2=A0 bool "Texas Instruments AM62Px SK"
>>> +=C2=A0=C2=A0=C2=A0 select ARCH_ARM64
>>> +
>>> =C2=A0 endchoice
>>> =C2=A0 =C2=A0 config KAS_INCLUDE_BOARD
>>> @@ -98,6 +102,7 @@ config KAS_INCLUDE_BOARD
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/bbb.yml" if TARGET_BB=
B
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/iwg20m.yml" if TARGET=
_IWG20D
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default "kas/board/qemu-riscv64.yml" if =
TARGET_QEMU_RISCV64
>>> +=C2=A0=C2=A0=C2=A0 default "kas/board/ti-am62px-sk.yml" if TARGET_TI_A=
M62PX_SK
>>> =C2=A0 =C2=A0 comment "Kernel options"
>>> =C2=A0 @@ -107,17 +112,19 @@ choice
>>> =C2=A0 =C2=A0 config KERNEL_4_4
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Kernel 4.4.x-cip"
>>> -=C2=A0=C2=A0=C2=A0 depends on !ARCH_ARM64 && !ARCH_RISCV64
>>> +=C2=A0=C2=A0=C2=A0 depends on !ARCH_ARM64 && !ARCH_RISCV64 && !TARGET_=
TI_AM62PX_SK
>>
>> Let's put the target dependencies into a separate "depends on" line.
>>
>>> =C2=A0 =C2=A0 config KERNEL_4_19
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Kernel 4.19.x-cip"
>>> -=C2=A0=C2=A0=C2=A0 depends on !ARCH_RISCV64
>>> +=C2=A0=C2=A0=C2=A0 depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
>>> =C2=A0 =C2=A0 config KERNEL_5_10
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Kernel 5.10.x-cip"
>>> +=C2=A0=C2=A0=C2=A0 depends on !TARGET_TI_AM62PX_SK
>>> =C2=A0 =C2=A0 config KERNEL_6_1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Kernel 6.1.x-cip"
>>> +=C2=A0=C2=A0=C2=A0 depends on !TARGET_TI_AM62PX_SK
>>> =C2=A0 =C2=A0 config KERNEL_6_12
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Kernel 6.12.x-cip"
>>> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-
>>> sk.conf
>>> new file mode 100644
>>> index 0000000..6e59250
>>> --- /dev/null
>>> +++ b/conf/machine/ti-am62px-sk.conf
>>> @@ -0,0 +1,32 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +DISTRO_ARCH =3D "arm64"
>>> +DTB_FILES =3D "k3-am62p5-sk.dtb"
>>> +
>>> +IMAGE_FSTYPES ?=3D "wic"
>>> +WKS_FILE ?=3D "ti-am62px-sk.wks"
>>
>> We already set WKS_FILE to ${MACHINE}.wks, so this is redundant.
>>
>>> +
>>> +IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-
>>> am62px-sk"
>>> +IMAGER_BUILD_DEPS +=3D "u-boot-ti-am62px-sk"
>>> +
>>> +IMAGE_INSTALL +=3D "u-boot-script"
>>
>> Not needed, you are doing UEFI booting.
>>
>>> +IMAGE_PREINSTALL +=3D "firmware-ti-connectivity"
>>> +
>>> +IMAGE_BOOT_FILES =3D " \
>>> +=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
>>> +=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
>>> +=C2=A0=C2=A0=C2=A0 /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-
>>> evm.bin;tiboot3.bin"
>>> +
>>> +USE_CIP_KERNEL_CONFIG =3D "1"
>>> +KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/
>>> arm64/ti_defconfig"
>>> +
>>> +WDOG_TIMEOUT =3D "0"
>>> +
>>> +PREFERRED_PROVIDER_u-boot-${MACHINE} =3D "u-boot-ti-am62px-sk"
>>
>> Please set COMPATIBLE_MACHINE in the u-boot recipe instead, see
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>> commit/4ba393e85e5a832e4248b6842badec41207846cd
>>
>>> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
>>> new file mode 100644
>>> index 0000000..5127218
>>> --- /dev/null
>>> +++ b/kas/board/ti-am62px-sk.yml
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
>>> +header:
>>> +=C2=A0 version: 14
>>> +
>>> +machine: ti-am62px-sk
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> new file mode 100644
>>> index 0000000..f8cd973
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>>> @@ -0,0 +1,11 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require recipes-bsp/optee-os/optee-os-custom.inc
>>> +require optee-os-ti-k3_${PV}.inc
>>> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-
>>> bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> new file mode 100644
>>> index 0000000..444f6b3
>>> --- /dev/null
>>> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>>> @@ -0,0 +1,30 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +SRC_URI +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 https://github.com/OP-TEE/optee_os/archive/
>>> ${PV}.tar.gz;downloadfilename=3Doptee-os-${PV}.tar.gz \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +SRC_URI[sha256sum] =3D
>>> "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
>>> +
>>> +S =3D "${WORKDIR}/optee_os-${PV}"
>>> +
>>> +OPTEE_NAME =3D "ti-k3"
>>> +OPTEE_PLATFORM =3D "k3-am62px"
>>> +OPTEE_EXTRA_BUILDARGS +=3D " \
>>> +=C2=A0=C2=A0=C2=A0 CFG_ARM64_core=3Dy \
>>> +=C2=A0=C2=A0=C2=A0 CFG_USER_TA_TARGETS=3Dta_arm64 \
>>> +=C2=A0=C2=A0=C2=A0 TEE_IMPL_VERSION=3D${PV} \
>>> +=C2=A0=C2=A0=C2=A0 CFG_TEE_CORE_LOG_LEVEL=3D1 \
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +DEBIAN_BUILD_DEPENDS +=3D ", device-tree-compiler, python3-
>>> cryptography:native"
>>> +
>>> +OPTEE_ENABLE_APPS ?=3D "1"
>>> +OVERRIDES .=3D "${@':optee-with-apps' if
>>> bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
>>> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-
>>> k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-
>>> k3_2.13.bb
>>> new file mode 100644
>>> index 0000000..5b572bf
>>> --- /dev/null
>>> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>>> @@ -0,0 +1,22 @@
>>> +#
>>> +# Copyright (c) Texas Instruments Incorporated, 2025
>>> +#
>>> +# Authors:
>>> +#=C2=A0 Sai Sree Kartheek Adivi <s-adivi@ti.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>> +
>>> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
>>> +
>>> +SRC_URI +=3D "https://github.com/ARM-software/arm-trusted-firmware/
>>> archive/v${PV}.tar.gz;downloadfilename=3Darm-trusted-firmware-
>>> ${PV}.tar.gz"
>>> +SRC_URI[sha256sum] =3D
>>> "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
>>> +
>>> +S =3D "${WORKDIR}/arm-trusted-firmware-${PV}"
>>> +
>>> +TF_A_NAME =3D "ti-k3"
>>> +TF_A_PLATFORM =3D "k3"
>>> +TF_A_EXTRA_BUILDARGS =3D "CFG_ARM64=3Dy TARGET_BOARD=3Dlite SPD=3Dopte=
ed
>>> K3_PM_SYSTEM_SUSPEND=3D1"
>>> +TF_A_BINARIES =3D "lite/release/bl31.bin"
>>> +
>>> +COMPATIBLE_MACHINE =3D "ti-am62px-sk"
>>> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-
>>> support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-
>>> KASLR-OPTEE-RNG-support-for-K3-devic.patch
>>> new file mode 100644
>>> index 0000000..d831b21
>>> --- /dev/null
>>> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-
>>> for-K3-devic.patch
>>> @@ -0,0 +1,38 @@
>>> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
>>> +From: Gokul Praveen <g-praveen@ti.com>
>>> +Date: Thu, 10 Jul 2025 15:29:22 +0530
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^^^^^^^^^^^
>>
>> Still not upstream?? Please make sure that it's going to be included in
>> 2.14.
>=20
> This patch is already upstream but after v2025.07. Hence carrying the
> patch (upstream commit provided in the commit msg). Can remove this
> patch when we are ready to migrate to v2025.10 or once the v2026.01 is
> tagged.
>=20

Sorry, confused u-boot with TF-A...

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

