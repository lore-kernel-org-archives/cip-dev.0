Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C01C02198
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 09:33:20 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.34])
 by mx.groups.io with SMTP id smtpd.web10.15812.1739871197682071060
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 01:33:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=eybTqqtb;
 spf=pass (domain: siemens.com, ip: 52.101.67.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgSwSn6vr55mg6y9TszyC9tPPpdZDN2uPHDH3BLsxc7EqN3F469APUIK5/K8hrjw8eCuZ2Io+5DkqjlMIlmOjZ5uHuQsF5zrzDavphf50il121x2ox+xtIEaEUzdw9sOwIV4S1BH/3AulfsVJ3BIgoZtNd1GHek5XOhNTxxiEiF5nCXl6NJ7+CJnqmfkex6T+f99XJXwlKSM4WZpHG6jtbyI2UEhvbvHP6eJzdvG3vzuST1IMC7JVyFW1Q9DDGxY9KKQ0YDjLy8era/Ps6zvUbhIuzeGBwFjXfwxqcBE8i+UCOUeH3oOosBTki1NMipxpOU8QoSyqQvYOGWoprJDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbbubXz0cTxyVZQZPpg/Xw87iW3H+WezyXjAAa8dlxI=;
 b=W54fjKuVq2SoxrTMCliP74a0Wiljus8I9lf5igjWbnCG0LFDWY4lB2N0P0uB7XIplr3g3+Lo+/KK0BU5LbFuKEkAYumLiIZfTk/vt/ocGT73ALAxBHGJy/9z2mqmbpGQnvSqZhbrhlgqWMfaUTSEtumSSN+dPZa5bt2j7tPtP8jkVk7t54TyXP2wwa27RAWwPkoQomGr8I39SY6xshSA/RDlYBbzuoDXELhFtAv/D1n8FQV1giDX1eBj0jm11LK4Ov3ZPzSnySw4j8mnI0YvhNeLFZ1rYKG7SeuH7WhMSDSpj/3AUFwLzyaKvRYoOEWkfmTSLRzYaHVLn/d4DIeqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbbubXz0cTxyVZQZPpg/Xw87iW3H+WezyXjAAa8dlxI=;
 b=eybTqqtbigi1ucVwRoJFIZy8/VxVxWpv0iazT8fI6azY+QBjHD4CsId5IjcqyLUzGdIZGmt5TT/l1UOnuaGnl6oZcRtN1Iz+yPcDvG2TfuNBNzx8l+KtI77gPnSDQXp9mvw8rzcb2uLqmmVxiXv7Pcuc9yfTasUyakIwEjE+ov0hFVzZX2cjvTVphZKh0QX0Ab28jETD1WxgqwIs8KhYz6hSAyVrZvxhBpTgIuLDBFezaClEydYc7AHd4gmOo9EAMP4d0pb42zPArujhuub2ObMgqnQ3thzWWmQxe8ZeW+XF8MPpCRNb8QkVUc51DY7l+Viw7/cnaNYY/dmJPa6eXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB6752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 18 Feb
 2025 09:33:15 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 09:33:15 +0000
Message-ID: <fdfa34e7-6ccd-4374-9231-6c4d1b2d8e13@siemens.com>
Date: Tue, 18 Feb 2025 10:33:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] update cip-kernel-defconfig to
 the latest version
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>,
 "Arjunan, Srinu (FT FDS CES LX PBU 2)" <srinuvasan.a@siemens.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20250214053127.1152501-1-srinuvasan.a@siemens.com>
 <59c46970-e5da-45d5-84b5-edbe763c1792@siemens.com>
 <PUZPR06MB574734D2FC5651C2195AD6FA88FB2@PUZPR06MB5747.apcprd06.prod.outlook.com>
 <70321418-f36b-4dd3-a6fa-ddda267c1a14@siemens.com>
 <22f263c0-94fe-45d1-8da2-02f05ba83be8@siemens.com>
 <1a1e5325-0565-4909-98a9-f1c7ccf82b98@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <1a1e5325-0565-4909-98a9-f1c7ccf82b98@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0789d91d-d21d-43b1-6273-08dd4fff44ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f4iwFC3qHZIV49hE9jaecVWrqLwr5zBJfm3S6+cApUZhOS3IixAZDrvji7TG?=
 =?us-ascii?Q?xBz/rNa1UXPaCtzZv3imDnCx4Tzp6yhwPROTcx0NsxNuHBblaKG2+ZIDMw8z?=
 =?us-ascii?Q?JZTiMlcBS0N81nKNcelDjsA9gm8vOXRWzZ9t+CU88IWR+kTXkMWFNCjI4GOu?=
 =?us-ascii?Q?AbWNTKDp6gx8YVH0s5KQTjyDj3oAOP7SpuEPQxojc8UkPaEOIhRlX/T2LfmO?=
 =?us-ascii?Q?RK1lCioPCRr28s/TRhkDQulTynHruJqDCV3lGRymOFHpB2ue0AhHpJKxTPc8?=
 =?us-ascii?Q?w2vg/Y1cfN0azmkMSQjazui7eb6yW/ATQh4HZqDx9Kcz2qC6HKIvUCfzs0uZ?=
 =?us-ascii?Q?vh6d+gVU6a9TSc8j3H1fGIt3rYyWdViLgtib1nNfZV9wdL9jFi9sgDNZPp4x?=
 =?us-ascii?Q?3qdG8go2I8+Q+hErVVW2OCUNhZ+IfmAEemhEfR33XQg0/V8H5+W4zItHMYvz?=
 =?us-ascii?Q?Y89p7oqXw0VHxSvbxyyRTNpIrtSa49mw/6vhAbAdcchthMCdAe68M/fChH+6?=
 =?us-ascii?Q?GfN1kRgzqq/A3jCGP/LRzw5IS4NwUMprDGhRcgK2+VzubVxAHP80xBO7DRh/?=
 =?us-ascii?Q?7pcCtDImn5xinTBfuMswl9rhpqBKfA0mlmzQh1+R3izluM+ffz3BGQJq9QvJ?=
 =?us-ascii?Q?d/JWQcFBYK0u8v2803m4/3+QL4HOgDAEsPfJWnvSH4ND88VR3Fw829YGGJN1?=
 =?us-ascii?Q?k8vzRJSDs4KcMcQqx7F65Lmiyz84TO2lffNzc0TZxWP6oDsV2WM2ufT/j7Mb?=
 =?us-ascii?Q?S+eqvVIfjCnlE2SNvgS4Qr1PDkey3M9bkCs01awKfCnfQOX3j9RTvKO7sfFo?=
 =?us-ascii?Q?fpL0S/Ds3pOh8GhTdB7V7Bddf63JNe+Fw/yqLzATZsyZSfsLXb/4jFo3BoQm?=
 =?us-ascii?Q?Ln22FLN0RYX/p8lKIzCPpMxiNLL5WbUgNm06iJ/Gq9Bmb/XOwvXl1PnRHBlq?=
 =?us-ascii?Q?G84/2f5H257QVW/1iELpvFbUa95tZcDJCKQz7zcyVvLEXEEN+dp6+TbB98cK?=
 =?us-ascii?Q?bOaw6pk+GH9jiV65H2NiApUhhQhppSFtFSSKwwPIrzVmzJY9Dtf93b802lZn?=
 =?us-ascii?Q?Cz3WDOrE3g7xrmmZEz5onnwUUhsCfLDCCPT0k6cCNzoQKJBOF0qSba2/W4z/?=
 =?us-ascii?Q?nwkB4S6FcpjD6SeF5TX4HsqBLwx9Mng136mxtKAzB38+7jy2eBcG7a1BDOAx?=
 =?us-ascii?Q?nG8EY0vyhvW+9e30Pvm1EF3pljt6ATaIRODpWf1GuwJvQ1xTW9AqOAZ95G0f?=
 =?us-ascii?Q?kjdZ+ifBx+8kI7jHkwSKwOVooAsdvHREz5PfYpZcBZP7HROdOcnrzf1eTpH2?=
 =?us-ascii?Q?dSmQaauJ+oIzecwwG9weBZEYoDd4JUZ/JiXLcudCC2bDtA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uY5tBy1zqw8hyassPGo82bUOfCUaDjXadCk2V4dWFh+Q05TWudMC3a584OUG?=
 =?us-ascii?Q?zyCOBTNMES0sDmRXQacoEHTPHHztYgYi8BLhpk6Ov/lAz8cbWgfei1Co6IP9?=
 =?us-ascii?Q?jtcCu0udES1G492k2YqMVbv92wvrJhRCBJBEsVh2qXU3PuiUsKBjQJK7Jn5f?=
 =?us-ascii?Q?q9TFwIbWuoZk19+rzZ1I5f5TL47QT75WZqbk/lGqmEnO9X2A3pC0+pFXpAYd?=
 =?us-ascii?Q?marfYKgMY6EuuXUv7rHi48IM/v9fDxenBTfTGFMO9fqpwxUNlN5CF4ugqIFX?=
 =?us-ascii?Q?XOtbXGWP2BfXUiW7/jdt0Gsm+g4Iag3tgLt1cz07gfs3SLLyD76LUuhMrrrv?=
 =?us-ascii?Q?RiPIHteoXPRp5Gyd4YazKU0nIuBq/fhJ2kM0mDzibFecdNmJyEzPwgsO0h8m?=
 =?us-ascii?Q?tyWUeyzbfnRPlg2JvoSH7Ovlsa3OBIwBIdoe2jGEHz51Ju9vG+TvCdL+RIe4?=
 =?us-ascii?Q?OM2+KBKDapCIfJ0iC60p/f5Pcu8dRfd0LZCtEkupqlxKr4qTVo+C3bjnLTgt?=
 =?us-ascii?Q?Z3vzeUPxDylfs+bXFLZGX5jPjvFrmylLJ0jC863sTghlQGsCpGv4XYpFoGwW?=
 =?us-ascii?Q?A0en6pE0/Jtps96bpjF0I9ANUCHQglu2rxJfsn2Yy4t1+IGacFuSNvAkvIcV?=
 =?us-ascii?Q?MywWXhBJl0QiDiPxgulOWAZhfjHFyf6g6AZJ0pAD2KNxAS4asv2+QffbtJRv?=
 =?us-ascii?Q?q/wAdUfxbFhGVIWB/TFPR7HLrbgiRMZ/HuLlL/7pEq6rpsWxiPAIvoAHWRts?=
 =?us-ascii?Q?hbE7EvdWEbFa9EktwEYkQ1I6Lz+Dy2w7wTJZL1q2uHPQXWgb9S1yXjyU1Z0y?=
 =?us-ascii?Q?Yf3FKN3Krqy1RRc60wWOjvI85m4RcqgKvXkCLEDYi4RRUxD7vtdvwLrX66pz?=
 =?us-ascii?Q?bulovDuzQi87hN86Rh7FRfLS8NslT2ByX8gYd8rniF7Cn4OfnadjpRl+7/1q?=
 =?us-ascii?Q?KzKIBb/moJGplIqaK7EJYvLlHxDeD56r1PHI8MhFR+3newHDckcBmYck/r/d?=
 =?us-ascii?Q?IkpIyC+6VFugAqeTzfJ3CAttMjS6PprRqhF3dUM0++nGOklcSbyhKFvXyvTV?=
 =?us-ascii?Q?QFvp1cCI6fEylgutbdsar10jkkPbWV3yaTmVP0VsCqJ4rN9Gmc+H+r3PLbEj?=
 =?us-ascii?Q?vz5rGnmRKlpS59MT8H2TfXuymHY4MSFJoIioNsXTM0ra9yaT6wmzRvBE6KVI?=
 =?us-ascii?Q?FusJNFrSbeqsidEFlhkaB50wvDphCbGxw2G1A1fgTG3RFb1oSxdT3aKAGCtG?=
 =?us-ascii?Q?WT+ZKmjyNeP/56nXlLLYt93lHv6qFvnEtQTfVUVMqhHv1m0yPEp4vsGKIiae?=
 =?us-ascii?Q?i6/KV6jPiY+n6z0pvzV3ZekoyNyHbkCOT3s20kAA8CGspCFiDUSbVSDHro8K?=
 =?us-ascii?Q?2iFTZXp7mAdy6sas0Firzo5YLlTW2UK90QZe2a0gKilSpf1CQ1y2WAzk5GB8?=
 =?us-ascii?Q?H2fd7r58ecLUQZzBzcvArXGx/odIebwdLpKQwmLGKJ4tfvJmxNFvIV/Bwl5E?=
 =?us-ascii?Q?KGVW2jtEQu+Mto7wrwEKsG2vAvaxO7UqGC0b46agqpF7qnP3eE7U8cd5UWvr?=
 =?us-ascii?Q?Qt8gXGHbykLBqm/Q1Xgr3lfvJfvwHCB0xESQVmA56Rf1+g5JvlkApGo/979D?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789d91d-d21d-43b1-6273-08dd4fff44ed
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 09:33:14.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XsXSwCthD3WyfxAjHsZbXweWPfIYDQ36m0NZ/sIYkSqPrS/sI+VcsqQzWCGDZmWL6nOIlHv6bwybkEl7sBBOvvRz6A6HTkDL8NzUCGbDAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 09:33:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17863



On 2/17/25 10:26, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
>=20
> On 2/17/25 10:15, Jan Kiszka wrote:
>> On 17.02.25 10:05, Quirin Gylstorff wrote:
>>>
>>>
>>> On 2/17/25 06:37, Arjunan, Srinu (FT FDS CES LX PBU 2) wrote:
>>>> Hi Jan,
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 You meant this cip_merged_defconfig is generated one?=
,
>>>> in that case, is this sufficient to enable the required configuration
>>>> in siemens_ipc227e_defconfig to use the mokutil in IPC targets?,
>>>> Please provide your thoughts.
>>>>
>>> Normally you would adapt siemens_ipc227e_defconfig and then regenerate
>>> all cip_merged_configs.
>>>
>>> Also if you adapt 6.1.y-cip you should also adapt the version after tha=
t
>>> also(6.6 ... 6.13 at time of writing).
>>>
>>> Quirin
>>>
>>>
>>>> Many thanks,
>>>> Srinu
>>>>
>>>> -----Original Message-----
>>>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>>>> Sent: 14 February 2025 13:47
>>>> To: Arjunan, Srinu (FT FDS CES LX PBU 2) <srinuvasan.a@siemens.com>;
>>>> cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
>>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; Gylstorff, Quirin (FT RPD CED OES-
>>>> DE) <quirin.gylstorff@siemens.com>
>>>> Subject: Re: [isar-cip-core][PATCH] update cip-kernel-defconfig to the
>>>> latest version
>>>>
>>>> On 14.02.25 06:31, srinuvasan.a@siemens.com wrote:
>>>>> From: srinuvasan <srinuvasan.a@siemens.com>
>>>>>
>>>>> This revision brings the CONFIG_EFIVAR_FS to read the EFI (Extensible
>>>>> Firmware Interface) variable information via sysfs.
>>>>>
>>>>> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
>>>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/recipes-kernel/linux/cip-kernel-config.inc
>>>>> b/recipes-kernel/linux/cip-kernel-config.inc
>>>>> index 53bee8f..e761957 100644
>>>>> --- a/recipes-kernel/linux/cip-kernel-config.inc
>>>>> +++ b/recipes-kernel/linux/cip-kernel-config.inc
>>>>> @@ -1,7 +1,7 @@
>>>>> =C2=A0=C2=A0 #
>>>>> =C2=A0=C2=A0 # CIP Core, generic profile
>>>>> =C2=A0=C2=A0 #
>>>>> -# Copyright (c) Siemens AG, 2022-2024
>>>>> +# Copyright (c) Siemens AG, 2022-2025
>>>>> =C2=A0=C2=A0 #
>>>>> =C2=A0=C2=A0 # Authors:
>>>>> =C2=A0=C2=A0 #=C2=A0 Jan Kiszka <jan.kiszka@siemens.com> @@ -14,7 +14=
,7 @@
>>>>> SRC_URI:append =3D " ${@ \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar('USE_CIP_KERNEL_CONF=
IG') =3D=3D '1' else '' \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }"
>>>>> =C2=A0=C2=A0 -SRCREV_cip-kernel-config ?=3D
>>>>> "e486c93a916cb6f78b4917b7345e8818f96069f9"
>>>>> +SRCREV_cip-kernel-config ?=3D=20
>>>>> "6b5db480b7a43e0217b1fa58f487f0bb997743c7"
>>>>> =C2=A0=C2=A0 =C2=A0 do_fetch[vardeps] +=3D "SRCREV_cip-kernel-config"
>>>>
>>>> Argh, the commit to cip-kernel-config is broken: We must not patch the
>>>> merged configs only anymore, they are generated.
>>>>
>>>> Quirin, I suspect that plathome_obsvx2_defconfig's disabling of that
>>>> switch causes the merged config to turn it off again. I though that
>>>> was fixed?
>>>
>>> There are two configs which disable in 6.1.y the EFI_VARS_FS:
>>> - cip_container_defconfig and obsvx2_defconfig.
>>>
>>> As we take all config into account this will deactivate EFI_VARS_FS.
>>>
>>
>> ...and that would be a bug in the generator script: default-y in one
>> config must be handled like explicit-y. And explicit-y + explicit-n must
>> be y in the merged config.
>=20
> I tested the script with the changes from srinu and the option is=20
> correctly set=C2=A0 EFI_VARS_FS to m. Save defconfig removes it again so=
=20
> there is some dependency problem which needs to be look at.

EFI_VARS_FS is set to m as a default, therefore `make savedefconfig`=20
removes the entry from the defconfig.

Quirin
>=20
>>
>>> At a other note we should look into automatic the config generation.
>>
>> You mean as part of cip-kernel-config CI, or what?
>>
>=20
> Yes for example or as bot.
>=20
> Quriin
>=20
>> Jan
>>
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17854): https://lists.cip-project.org/g/cip-dev/messa=
ge/17854
> Mute This Topic: https://lists.cip-project.org/mt/111177988/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175364=
0/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


