Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E07C021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 09:15:18 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.38])
 by mx.groups.io with SMTP id smtpd.web10.47464.1739783712868811640
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 01:15:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BVvrxovd;
 spf=pass (domain: siemens.com, ip: 52.101.71.38, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOHhA+a8BSxk2lXmNbpJAL1w4cnzm712pI8N6s7+NUzRzqlPwav1KGagSBZBMyFWDJbtxEe6IlpU0q90SHKb5vocTAoiDqhVxjALeIMgGGJoZ4VWGsWL/ys986MAFK4MVhYV/woYc7vO3VZKRQHiWkzYcxyQDlcHsAKh7KAkz7HDVywXATE+Joaa/z3xQ6VWovaHEaDwdvSAj3sXQ6Nz+ZI3Tkagbcw32YyrjKAwAlZj0v5isHiG9RisZMR3xVVRWFxaw2J61A+24zNZ6QLvKzONnUCit6WgeWB5hAD9EYAe6HS9nCsxxPow9AQxzJ59Bwgsh5iQjR+vq7Miogq/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNeS8F/Trnf5CpGG658T2drIwZoHENBX4535Zms9RG8=;
 b=w7v/gujhTNDsvq0bTb3BPbkpsMUXH615J19gzkpcbNwSmnX76gvJ59QbSHu2b0fkUCNX5kAL9r6JweAjgeCTpn9vpqo527KxtbBsUFBR/9i2mes8TXqGrd7Fq18miLXE7ZchwfZ001BaY6MWs+TNFKg6hXXY8qb9UMdkNyzu0RHkJ1Oeoa3zcA5otck5Ty1dDmUw5Q7aBKgTh///zhkZ5LR4SiTfFovWVgRdn+k+26cqw7iaDbd6enRzeL+41hFyxqz/Gd2XjYnDK5yWPrYxIRfaUhaiv9CJMEmmyFblMxIzijvRGue0rk+XvAac4USHp7uUU+BhBIR3a2O9xCb86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNeS8F/Trnf5CpGG658T2drIwZoHENBX4535Zms9RG8=;
 b=BVvrxovdpy1yNjE5sDiaeaBX8xZRTbuj+raAaouo6xk+AR1ozIvAxH8BdGQmGzKNaZNxnhfshJbhm42c6YNcORo35q4yW55BVa9T6MY0VjboQ6YisjdsJQmazcu4U/iCOS0OICMwGKPKcgOdS8yjsAgdUUkf6g9in+209yyxQNOn2r1FqYERevWrBWv+l8LU2QPEobb1ygdLVYTfdwUy4tdP+B+/UV7V/pFhZZ75p0Z0lgV9lU1J7lv+PakgUm+O3vW+fPYPztM7u/lFD/Fbdl5WbVuWE3Cgm6k6ruybFtI7I7Bj+rM4ZSHoCgNxnZ15NxTWh7ndZWZZPLX78f5uLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB9187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Mon, 17 Feb
 2025 09:15:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 09:15:06 +0000
Message-ID: <22f263c0-94fe-45d1-8da2-02f05ba83be8@siemens.com>
Date: Mon, 17 Feb 2025 10:15:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the latest
 version
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Arjunan, Srinu (FT FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
 <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 58de3d68-e006-40b1-15e9-08dd4f3391b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eTZVJfKju57EChHkQNMNVgkByxBkdrVEfUdDAGNPzFV+g4qqha24MPDEkYA6?=
 =?us-ascii?Q?yxPLn3cicDee22zbL0asLVYqO48lb8+qxaW5kbBxUJKcA1NYA9n5nvcs4L8i?=
 =?us-ascii?Q?zGlev69tAPLEx6aCUdq63gQIIXBDeq3qmjTQImJWOiKpN0jOSBGXpTPO+ZJl?=
 =?us-ascii?Q?puzqVSv1f4qqMiqJqLubf05zYZQcfvepDWk/OdudK4FmkNyd9BEn5nuIhOpg?=
 =?us-ascii?Q?+WwizcSP5QFcwcYnhnieFkM/+vOABFrHppNyyhHfRh7kIQZV5HLfUjcW+T3L?=
 =?us-ascii?Q?1V064XO7Fb2IPt6tQOZ8h3Cd9RxxAFBFfRIQXuKEMLdrKm2UjppekuUaHU/6?=
 =?us-ascii?Q?LVSxNujafpGw3ugkWg+k/z6orVfDArhCG2ZtCZjVljQtLFv9ZPCXdXEj4dbz?=
 =?us-ascii?Q?IXOQ9w80heDEnPi25P/GezlFSR5BwspPVKa02R33evWbaZU8aNoHofVH6udi?=
 =?us-ascii?Q?Z6L3RsU/yvlrTjKGehp/fGueXEfFIsAcKcpTkI7/ADQ24tmNZzQd/tbahq4u?=
 =?us-ascii?Q?LAL8jTert/FyRPOkHuYIJal3RNRqPdliz0wTdwrofH8nsPVGuaSoH8TnZCPf?=
 =?us-ascii?Q?gg7vahExUHPugK5zKzK8fmqndWOMFgja9PLFuPryvElqqxGwYrACNunzq8t6?=
 =?us-ascii?Q?MPP2nUHLmHvdRIhniFh2mj+XeTjr9qP9C4DjbMKwp5yW2m4lVRUvXd4fZbkp?=
 =?us-ascii?Q?Z8T9aDe18ggNETkoxAKuChU6sJ8An/XFXIc2FHOGXzsJO4K+hxhJbQnueF3o?=
 =?us-ascii?Q?Q0MTiQSpYjZ+f4jpKo9pvlgpyqQ3FEBWIrBR7bY618/byWvKYkWTx1nETk1H?=
 =?us-ascii?Q?c1NPOdXcUMrNRMQvzpIjQBfphyjNfnyzOIVBECzfYfUM4ouxxN8QE3Nrc41r?=
 =?us-ascii?Q?WC33xi+f4YZ1JPZGc8ZRN8X4w2m9uj9dZLXLUz0ac2DrY4NuO1FI6IuI1Hv7?=
 =?us-ascii?Q?mBCNrXb4qLCQAZXpu4MgHJwbG/qnlkUmz/0Ip9o/pL8+R7/PkdMRadtt0TEX?=
 =?us-ascii?Q?3V6VoTmNX0EYCPNXobnxNRqmwiQqS9tHdAHiim6wzzS+EbYA52jSdy+3jriI?=
 =?us-ascii?Q?WJijcC7wCKV0hy8XWA3hSTfIzNP/Rwb8YJJ8RU3+CTtkFftdQAnKJ8pf8Aye?=
 =?us-ascii?Q?TlR7oslNG538NcsMWIwZoGdTfCPsk/RvPUYgZTQhL980QdQDwhDgIaUssy6E?=
 =?us-ascii?Q?XqTt4aeAzyYThzIwBeOX8kyWeXiSNg2nwDfaJSbMBmEnFvVKOJd22BSDek4s?=
 =?us-ascii?Q?v3nlX4SY+5uieEyEP8ezKpktlOh+0GCujW/VDIomJxhlDpPjc4jt1+TLz4xo?=
 =?us-ascii?Q?aebzvcIzcivZC90TfQGfIegfqwstAXsqLTyyeXPZhYeLTwxx9vzWXELkazpy?=
 =?us-ascii?Q?IUfW5GgTFW4lv4zk5ImBuD6UCodj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dGudbwbuk9vdxKSxryEVWfcisbOZdtx7blaM4FCYVvXH8YAROgMvDfoRcCkC?=
 =?us-ascii?Q?CmOwXSvDbw4A7Bw+bWAPVwLKeuHKukq0oWo2MILRS0g0x9lMjXuAozXb7G7T?=
 =?us-ascii?Q?5I/lsfopDHGFWtE2tpBduo6/YXNOGyfwmZ8YDbtNUYNHPw/ejgjkgQwk/kQa?=
 =?us-ascii?Q?tw18GjwgkLzRAsRf1Co3hVWiSe0la3xrkcHzmc/tWGqq156ZmYWBdnUSw3P1?=
 =?us-ascii?Q?grkSGx573kqIkhWluNggg9CJu/+I4NYNztpubB9/t3CcnJiGuL4iUJnDKSkb?=
 =?us-ascii?Q?AoKsXy3zmeBJUbBDKqUIlmu2tP4G9B1zuLT4XASxy0gq8Y0u9QIM9rOhom2G?=
 =?us-ascii?Q?+MGd/IzKQx4U0f8JCb/iyog1KEjndiwlJlL2ZSxlIVMpZaP7RjeJxLEYGEqQ?=
 =?us-ascii?Q?l7V0xDbZtMOP/OZK0nrrSYpEtS+igXFEVpJudyJCf1c3Uzl/x5rYVepihEKx?=
 =?us-ascii?Q?2I1naQBwbgD9tGHSZAFcHqDtS8VNv7LMG7oEJVrqAhv70pR+Uu8ilMajO1xQ?=
 =?us-ascii?Q?UPETxvqmIklsOKZEcQKq7m9irXra8gukwSKNY2y8irf3NsBHD6eZL6j1xikM?=
 =?us-ascii?Q?reaZlChG11RZExHT8SvvbSb5X7DP77pCtyQKv//JEvthzA1EdHDaEZq9631G?=
 =?us-ascii?Q?3CVlOAkilUpWZ2bQAiU1iLW/Z8YAfmrYN4Xn+FoOV29cvewJ4HLXNnprVur+?=
 =?us-ascii?Q?2ieoi6A/2tVWq3hfkzz7tmsvMc1GVV7zmGLWqTyrfmmJj6NoFv/IKfIZGdei?=
 =?us-ascii?Q?le5/yFQHBzENDAH9rbLj9HxviUg0ImFJ3+rIoi/o06mr8ZhiTLHF820SRXIt?=
 =?us-ascii?Q?RgznlWHjrE5lk8faX7rChu8krwF8vGOYT4R6bXorsrvUrggfhjhEXIX0bUxz?=
 =?us-ascii?Q?A9YQGvgg5Yu/DBxFdy5/XEgMWqCfl859VkQIGh0xZ9SZJJ5jBjM7sWcerlsY?=
 =?us-ascii?Q?ijq6s59GrLFm8YfJxiSu2+lHQZwZOB9YGwNC81bl53FBO9CFzv1QbDisqjMq?=
 =?us-ascii?Q?Plx/jtJ+s7O26dl2yvn/2VokOU5shrqM+M7rKCViMd/Zdhcy1+6kMxDmL4SE?=
 =?us-ascii?Q?g5fgn0XTcZ//nFcxOCZqcmoL/ngqKHVYlre8XcLmFFNarUIiVnJPwMAP1kr5?=
 =?us-ascii?Q?EIW57r5uhBiuJKewmwJpfJMWQuL4e6f8CMwU8G14mpdZi3GE3s1VvSMjA+4i?=
 =?us-ascii?Q?URIk7giaUxGBjNovB7s26oG8Ndcq/Pyr1tjzCxNJTp17NEDTkZcbqBIcINqR?=
 =?us-ascii?Q?bHQJW+9aVCjohTi1bZ2pq0yD0IJ9uXr5HGm6youwgARHBNrXaX8cu1krafeK?=
 =?us-ascii?Q?8w+EdKwsN/kJ+MXUlvL0RQxG7cDyxpaxn50yCRpf9DfjGApuppEsriBIejPb?=
 =?us-ascii?Q?4qE7bQX1fnTjO9EpNsyDomRQq6TUdSGdVIQVyhEVbl+db6X37hD1ZVhaBvXI?=
 =?us-ascii?Q?5eGY9sslC49ohiwv31BZG/hWcqIX0q6ef8ve0E5ML9jEbbEexOTFpFpS5TjJ?=
 =?us-ascii?Q?sBmKdVdW0A514q7dnSdsCOzFHAHR/AhZsolMVHqZlyBKsSxAWSvfLbagT09o?=
 =?us-ascii?Q?S8BjKgNnC7ikHZ+fkG9CmkTALCiteeKBhq4Fu1mi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58de3d68-e006-40b1-15e9-08dd4f3391b8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:15:06.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfnaOd/bd1Kuu7azM65U9NwRimQURSL8KRwvd1ZNmijgcYuCAehd/RNX2Ed65YG1hzSNIla76sEK/o75aao+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 09:15:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17853

On 17.02.25 10:05, Quirin Gylstorff wrote:
>=20
>=20
> On 2/17/25 06:37, Arjunan, Srinu (FT FDS CES LX PBU 2) wrote:
>> Hi Jan,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 You meant this cip_merged_defconfig is generated one?,
>> in that case, is this sufficient to enable the required configuration
>> in siemens_ipc227e_defconfig to use the mokutil in IPC targets?,
>> Please provide your thoughts.
>>
> Normally you would adapt siemens_ipc227e_defconfig and then regenerate
> all cip_merged_configs.
>=20
> Also if you adapt 6.1.y-cip you should also adapt the version after that
> also(6.6 ... 6.13 at time of writing).
>=20
> Quirin
>=20
>=20
>> Many thanks,
>> Srinu
>>
>> -----Original Message-----
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: 14 February 2025 13:47
>> To: Arjunan, Srinu (FT FDS CES LX PBU 2) <srinuvasan.a@siemens.com>;
>> cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Gylstorff, Quirin (FT RPD CED OES-
>> DE) <quirin.gylstorff@siemens.com>
>> Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the
>> latest version
>>
>> On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
>>> From: srinuvasan <srinuvasan.a@siemens.com>
>>>
>>> This revision brings the CONFIG_EFIVAR_FS to read the EFI (Extensible
>>> Firmware Interface) variable information via sysfs.
>>>
>>> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
>>> ---
>>> =C2=A0 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
>>> b/recipes-kernel/linux/cip-kernel-config.inc
>>> index 53bee8f..e761957 100644
>>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>>> @@ -1,7 +1,7 @@
>>> =C2=A0 #
>>> =C2=A0 # CIP Core, generic profile
>>> =C2=A0 #
>>> -# Copyright (c) Siemens AG, 2022-2024
>>> +# Copyright (c) Siemens AG, 2022-2025
>>> =C2=A0 #
>>> =C2=A0 # Authors:
>>> =C2=A0 #=C2=A0 Jan Kiszka <jan.kiszka@siemens.com> @@ -14,7 +14,7 @@
>>> SRC_URI:append =3D " ${@ \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CONFIG') =3D=
=3D '1' else '' \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }"
>>> =C2=A0 -SRCREV_cip-kernel-config ?=3D
>>> "e486c93a916cb6f78b4917b7345e8818f96069f9"
>>> +SRCREV_cip-kernel-config ?=3D "6b5db480b7a43e0217b1fa58f487f0bb997743c=
7"
>>> =C2=A0 =C2=A0 do_fetch[vardeps] +=3D "SRCREV_cip-kernel-config"
>>> =C2=A0=20
>>
>> Argh, the commit to cip-kernel-config is broken: We must not patch the
>> merged configs only anymore, they are generated.
>>
>> Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that
>> switch causes the merged config to turn it off again. I though that
>> was fixed?
>=20
> There are two configs which disable in 6.1.y the EFI_VARS_FS:
> - cip_container_defconfig and obsvx2_defconfig.
>=20
> As we take all config into account this will deactivate EFI_VARS_FS.
>=20

...and that would be a bug in the generator script: default-y in one
config must be handled like explicit-y. And explicit-y + explicit-n must
be y in the merged config.

> At a other note we should look into automatic the config generation.

You mean as part of cip-kernel-config CI, or what?

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

