Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38166.1795595432386777789
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 00:30:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qiT8oSTl;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7fN8NKRrtFZPu6YWcXpJ7mGYYeyMs9tlPrbBX3z2jEHpnFKeiwmRT6Pewqy72SyQLiRBY7ps3cOWDtMvydu8WWM9UbQU1F31sKbenc7sszA557JvYQSALXEOowkzkirAd0tOShxI6k1S94x5wCcn+DR0zASMTCl3EfzNH0YDgM2Rjqs6GnW0KclHPUPOoxJV85JbN6UhkOw55hlWOjKtN5DxdC78kJNtasR7aKgXaFnSFSHga22aKiwkffhz6De3VyLD1rlvI/07FNxXT56+nQNhsFGY6ocF9hhAY4pXtToYXIz7UEa0KuDx2s6/Q7fL5T7xn41XkSDbQJU9sApVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmsu01c9DEZPc08pamnSPxpv/z8u8SvsUV3APeryeHs=;
 b=RDsXgLU3kNhFC6ThBId/vmfefw7AHlGiTDwCATuAp6JkY7Li6JX/KMAZejgKQNEkWM1M4bh7xip3nOjbrMTjJUJDEBBERtNDIdvDA3xf8VQHd9baGunRx8Fmv04tyalpMudBOSxQB8Vb7qYHU6pUmdueRUp193vp3GcnNubyGOLROFH6MpFyRFVCD3ETFHDwIX+7ZgBiFalfHKyRmAOgsDU1A6VOwiDtWfbSevK3XUwrzy0SM8iVRSawOyOPD4DIQMdMBhJJarWI/8iSfgluBS3AVY20W7/CmsHGWA7aGJQOHyF4Boxv6YhLp4LsbyouJlIWQiGXRQiw2xGYvWsRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmsu01c9DEZPc08pamnSPxpv/z8u8SvsUV3APeryeHs=;
 b=qiT8oSTlpo7apAFEt6s/PRsQwLyMQdbkqkXuyujl+OR1uBCvJ7dKB9LGyr6i8DNfyVIZxMKGYAEuO/wxWm6LcPChs2Pv8wAhg4CHA5qUu+mHuJb2jXWRJBmH5o32zQ3Bk0MLm40sasVlVZ/R+EcWWXWUJS9kAUSm7bUPDee/bKKYpSVcqjbJE6j3fsXeVXYGSHKU4tAYU/PNWJ0HswW/8nXP+x42ehh9YpYYrelG6S/Z6PlAAt0hhF7ShiJZAOQGdy7qb1taB/15Qh6wotmXwBo2ATYmHIrnQwVVV8ZcP0uLjc9YedaY0OOxsE/4Kt/IpZQHMfrtDSZYKC+4sOa1UQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA2PR10MB8875.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:426::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 08:30:27 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 08:30:27 +0000
Message-ID: <b6c3c0ba-f6a5-4561-bf28-889a8303cd61@siemens.com>
Date: Wed, 25 Nov 2026 09:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 0/3] Add out of tree signing
 for swu files
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <18E74FCA31FE6824.893556@lists.cip-project.org>
 <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA2PR10MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 273fc58f-fe86-4337-23cb-08df4ace5bf6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|55112099003|56012099006|11063799006|4143699003|261021121427099003|261102123227099003|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 5GLcp6JlNSAwjQueShsvQkdpV0t3Es5E6rpPeQk8meecDJ275S2w4he828oREpbSTsfhbrEXoRADrMbSELpmiz9PTfxjTMtjZhx279iu7y/LZhTPRgCCPYA1evHVR3DmfddzK1/d57vprWfNtKa2CTUppKzgTOXg0crZHu6cR7Ajw4P4zbilOLsqV/vcOVDrL+v3PxPZC/iLP1AGMOttCIhXGXAhOKxSGq3xbRAgrvudXjy1TLO3yMu7LQ57WOPgsHflJlwp+hxOtRPqFLMzAal/n2vclcpMGpffb/FAHwJgllGn06Cy4IbsFegeIuUVg6YgKj+ulaZWojP34J6z/1oRzWLSX6As8HImlXWMvMHpFWcpzuhlvaF2mh3+lBUkzAXFR/EuMCQd6lq+6RAeE6EyqOJIaMb6sPzPm6tmY5o+xEhErWZReHA0WmbwSjLvmjzXVGL9+VJiEs28KIWWf3AUGvCP694lIudYEXoLwa2X3k52ubxwiVAvMf74JY/1w31HccsdLcwif8xWWPydghh6A14+b0NvQ7r7IGZFRMqZEZYrii73pxEef9xYRADA+77W9GIphyAPqeN5YeZWgaJSKHkJhq3OBv75o6u6zNnAqvtWj7GEVgeaR84ogRM0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(55112099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261102123227099003)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BdhJgOGt0O4pnRmbcjIdIs96B8pxi9F6hGtXcOEEh9RdWKAqSCmScHdYK3fm?=
 =?us-ascii?Q?7a5f/Wjppoig8zb1/htQsZgax/QOI7A8GPRR3la4kEZ3+bOehKDLc2Cget9R?=
 =?us-ascii?Q?SzAsZMqMkq+GQdHELg1e1EP+MpDLOPFNQgsr3O4vPeHnnC8sg4V52IMiIObz?=
 =?us-ascii?Q?wYa3qy/bwH58P8CubsehRsMEwn7Ze34kQEDOZ0FJd0YxlB3zbvyLZA/wXsGr?=
 =?us-ascii?Q?yklcU54Hd3iSaTFRax+h/Zw29ydBWXAfyFLA3XvY1F2gxtTnbD0iL09/s5yf?=
 =?us-ascii?Q?v6VCQ+r48DM53Kc3Ke4ZTBiUCIZYalt45YkO76/CWdoKWU3Ae8e9N9y6z6C/?=
 =?us-ascii?Q?yZWw7pAJYs8VsSjMEBv/NrjfRRFb6WFHj0o4pgR+Fh8OoA6t1tC1oLDqcM9I?=
 =?us-ascii?Q?l7K1+lpUPp7QrTv7HIycuBCwg/p3fPlocDum8SuiGiJ2ZHVV0dOEMjJp+/Ff?=
 =?us-ascii?Q?1tt5DMIra6vwQ+oF5YugIeH/fBbSEqCEIrqKXoW/TqfkW1EPSpF26xa/b6La?=
 =?us-ascii?Q?f55k/cVptPhwI+TqWXq7jUAwvJMYcQDluWGF8uZWzcVR5Zyo4p0rayCXxevG?=
 =?us-ascii?Q?+z/QjQsQr2TZgj18NxR6wBrytZGhK03b366lx5KbcWdrHnNQk8FUraW1GmUd?=
 =?us-ascii?Q?JOaxr16JZmBrL60I9F1ca/WhB7pX/NrFIsvWprpyC6uVxIzEHWXt6wIUmM+C?=
 =?us-ascii?Q?F4mqoUEL0pDi/0J2eXLlrRPyZsVZ251vlocfrgt0dJDZFkG6KjHUzgc0LEn6?=
 =?us-ascii?Q?sh1/vgXFuh9k5JcB6kAT5dKqjTPrGMoRPN6HXI5PFkVCPoAA8L71We6Qrpny?=
 =?us-ascii?Q?5v+sxlhiv7rfoUFxNknycX/3oq7GVdaaucyrqECfcHIAYd0g5W/c3lx3wzsw?=
 =?us-ascii?Q?3Frxdr/UU+Jx52n/FO/Doitg+9xJ2WGR1waxZIV2+NwvapOabCJoaS28d3Fz?=
 =?us-ascii?Q?K9c+6ixVPkRJJ9qVDzRWEgyuu1GyFH3ksXDc5dg2AMGiFUL6c8b1rpo6p+7O?=
 =?us-ascii?Q?Olll9Bt2NnWumTZhHZObXa+1cTfNTSuAydXI/1JOC3CHhMyiTY4X1GEovMR3?=
 =?us-ascii?Q?yta1gwtmlHWvnMwyHkWAEO2mMtohaUBgENjFf1qKCp3P6Y9WfkXp41pCd/AL?=
 =?us-ascii?Q?XTIdc8MlWSwN2HpjnQTYHw7bqmpvK1WGVaCQeAJhyFWLzy5olLoJ2W6cxtaJ?=
 =?us-ascii?Q?l/l0ZvbrXuzTaD4x9iom14QxJnPNiyWSxRzizmRQKW6427dLkqVgkSQcVFbA?=
 =?us-ascii?Q?tuMK2W32r7qVux4VzvEprd0FCnamD+qy4C2lJvqHCtB4TQYlRx2+NCdu4Zb2?=
 =?us-ascii?Q?9yzP5PWOz5Os7NG4nn7ydgZmeE9Hb+62cvwGszh0vvLY0FRi+u3ZHaunkx8G?=
 =?us-ascii?Q?4kPZDfS10EH8RU7UjEibsX+8INsrfOA7V6Th3ZGthYZ0OILdTuWG0o5SK4+2?=
 =?us-ascii?Q?bYqqvv/Tiy3wbJ8i3A+sJ2q3SSa3o00+GXWQTqUQeNV/Y6nrsx7ABjnS01l5?=
 =?us-ascii?Q?7BD4NNwojcZM4RhicOHDjwYfp8H9+F6gZXqM4yuyiBFL6Sq1gZ8vVMmskalV?=
 =?us-ascii?Q?TiB7ck+Sls5j1ry93+Hj5ufLsvYB1mcdGx6ISMICVzCoU5+bef1x94LZXnw8?=
 =?us-ascii?Q?YQ9Ot66sZ371mnqCKJ3vvwfrkbFfROMIP+LylOHrKdaEqoOJWUriptncoqr3?=
 =?us-ascii?Q?tHshcNB7t+IuMcPlakv/cI2rXcLuMzzP0f7WxTFt0HEdPDxUGgdF9eV8s5OX?=
 =?us-ascii?Q?kMN26S0PNw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273fc58f-fe86-4337-23cb-08df4ace5bf6
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:30:27.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynq83hndrfIZIgRfMUuZzx+ipz0Vo8mW3Io3PRHZ+f4R2x/KpH6Rpnm6EhGvAnrDtVN2BejQEQ6DS4uOgCrPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 08:30:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25073

On 25.11.26 09:28, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> Any comments on this patch series?
>=20

Quirin?

Jan

> BR Alexander
>=20
> Am 12.11.2026 um 14:38 schrieb Heinisch, Alexander via cip-dev:
>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>
>> =C2=A0=C2=A0 Following up a request from [1] I added scripts to sign exi=
sting
>> SWU files out of tree.
>> =C2=A0=C2=A0 A rework of the existing sign-swu-cms was needed to allow r=
euse in
>> out of tree signing.
>>
>> =C2=A0=C2=A0 The script interface is:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign-swu.sh [OPTIONS] SWU_FILE [-- =
SIGNER_SCRIPT [SIGNER_ARGS...]]
>>
>> =C2=A0=C2=A0 where the SIGNER_SCRIPT interface follows:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIGNER_SCRIPT [SIGNER_ARGS...] SIGN=
EE SIGNED
>>
>> =C2=A0=C2=A0 SIGNEE and SIGNED are provided by sign-swu.sh
>>
>> =C2=A0=C2=A0 1: https://lists.cip-project.org/g/cip-dev/message/24534
>>
>> Changes in V3:
>> =C2=A0=C2=A0 - Made scripts posix compliant and changed shebang to /bin/=
sh
>>
>> Changes in V2:
>>
>> =C2=A0=C2=A0 - Fixed indentation to tab
>> =C2=A0=C2=A0 - Fixed (single) trailing whitespace
>> =C2=A0=C2=A0 - Added out-of-tree signing to README.signing.md
>>
>> Alexander Heinisch (3):
>> =C2=A0=C2=A0 sign-swu-cms: Refactor signing script to be reusable for ou=
t of build
>> =C2=A0=C2=A0=C2=A0=C2=A0 signing.
>> =C2=A0=C2=A0 swupdate: Add out of tree signing script for swu files.
>> =C2=A0=C2=A0 README.signing: Added section on out-of-tree signing for up=
dates.
>>
>> =C2=A0 doc/README.signing.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++
>> =C2=A0 .../swupdate-signer/files/sign-swu-cms=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 84 +++++++++--
>> =C2=A0 scripts/sign-swu.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132 ++++++++++++++++++
>> =C2=A0 3 files changed, 248 insertions(+), 10 deletions(-)
>> =C2=A0 mode change 100644 =3D> 100755 recipes-devtools/swupdate-signer/f=
iles/
>> sign-swu-cms
>> =C2=A0 create mode 100755 scripts/sign-swu.sh
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#24783): https://lists.cip-project.org/g/cip-dev/
>> message/24783
>> Mute This Topic: https://lists.cip-project.org/mt/122229754/8886423
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub
>> [alexander.heinisch@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


--=20
Siemens AG, Foundational Technologies
Linux Expert Center
