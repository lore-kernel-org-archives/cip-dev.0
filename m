Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10358.1795682987992233232
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 00:49:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dShlqIa1;
 spf=pass (domain: siemens.com, ip: 52.101.84.12, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVy5ZuuCqndNfm9Jgg+SSioX+DsZHLH+XwRxbYAe9RpYmINkWnm6zec0regbGBUSZhThlqf2GGqzJdyk5p5ofaE6OV4Xqe9TDeSg7r6loux+ybDJrbQHzzrrWgvBIoTibSziOZHj91xR5f2e97l/BjGwiHr/hwF+UvjdCFUtwWs2q0REhkpI8/MA+TzkCeY3MdnWGgdYlOVfOlgVCpw/lCzZu5L8Sdgi73uGChSn2HG2ZJmiwYobF8FQC+xHnjm9VVHhV7Hcke2XHpOEiux6CURmIu0p1gyI5rPXMcUnnXBAK4BPsGNBMW11lonv1rnP0WJ6k6TSq9tVv1WTQNa9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbkPovNvyKyj/ecBRTgndDjhIflNxwp0ei5ENzM0I5Y=;
 b=x0sXk3Ht3KGDQcb1CXvxvJqREw+FbQQdldM/AuPvpaB4adRwZimmsiVViq28R2Qobb0SU/b6lTMTGHzu695CyJ2W/B4TOoAh6vTIJrZLy/6Wqb74x+FAsDid2DEqgmB0oqQWgkuI2gqOHqXJhQR0DZcrvkXlPVGFd+5MAeT89fJWbd8H0TwkFrn+3449Aw3ci7Hn75A/UNGVAxuzshku3P/Dvie2X7gyXYydXaIZbN179GJ8ANBZjVKj/7cgCT7oMc6LVzzIYrGC3u0t+3fVQo40yzf7/AwH+MjRrf8YsupOZjYXslz7juX32Ik59gqr1Rm6ABE2TFpU0Xi6NuPdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbkPovNvyKyj/ecBRTgndDjhIflNxwp0ei5ENzM0I5Y=;
 b=dShlqIa1ttMOuHZvOwhIVFtEHDKaXBl8U/5KrA0LnaVO8d0Up7554m6/lau3jtkBT2dsEDOHAI0rzUTP2XtQ9wd/r7Zi2mvYwORAPIkNLXHGQNlo7nAyC2chq3aj0C77Fn92bjv8TfMWUjrP8s3l2FOWtl7tUpNr46ivbDOnU/fh9uHNXgDIgAX0LT8ReqqZrUp/XhBgZ7AOE5NTht03uoc3aQJyOrmNTA5jRF/sKepJIDwpppfZ9QvF/0Dfts6fPt6HKoRFSZNJSBzKVAycCXNEf9OyMm+bx14AkSf0sLYU4zKMGCumRFjom5OslANdFvEwOG7KSjlwFwtJgb3WNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS8PR10MB6820.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 08:49:44 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 08:49:41 +0000
Message-ID: <690d9870-bbe4-4832-b2f2-7fa1459a7e35@siemens.com>
Date: Thu, 26 Nov 2026 09:49:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 0/3] Add out of tree signing
 for swu files
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>,
 cip-dev@lists.cip-project.org
References: <18E74FCA31FE6824.893556@lists.cip-project.org>
 <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
 <b6c3c0ba-f6a5-4561-bf28-889a8303cd61@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <b6c3c0ba-f6a5-4561-bf28-889a8303cd61@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS8PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fe47e8-d881-43f0-7720-08df4b9a35cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|366016|1800799024|23010399003|6133799003|261009223027099003|55112099003|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006|261102123227099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Ad3vl3kT9xcINdDGhDFjVK7w7Bphxf2Z7VeOoTcVyZX+8+8TSjv8wcuAAg3lGGScvaqlCut1EKMNKDF/RHm82XPnO1ZBeeuCb9pfCwhUVQHao04uTekvtyzy3DJy/TqfTM1cYPMtS/Di6SNF69WxDWIajfSyXV9J5LHJkJ5cwCW3Nb5hkzp7vZbKdoRE6FWpVnkb278Px26Gd0Kk7S5zH3OVUEi4XUmFmg4hBTjQAoXhI+dLnG8ljGO2QjX4KczhTzyMsxvex1sxC2T7V9efqAcb9myA2MFxfPP8zNbN52B9y+FKXqKMQiqx47E1v5J85lXvcMaPpK9HHSS9RIbuDgYmK7Vb6v1NAWutrGFVR59nquXLn+lAObMNBeRTms7tlaSOc/WlQna0ljpb2NvWRX9YVx/ROWPm2jCuENk/qYlMZQBpPvmOZ/fTRgyVUVwOGMinV6s7ZMbRZ+f69CO+FNNlKyLXhd9xXQqFjxFyzK/g6YMBU11hRhuWE+OXz6kdWqP6f2OrdDx0ZuuG7qi0bg33gdgGCp9Lcs9X58GHiKpKEtJdcfW6WTbxYLGTAP+hwJHydnBiLzNxSgxTlaRL+oe03uhDW5su0HzeuAXS//T6AHMAOvH7VlxdPTNxivT5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024)(23010399003)(6133799003)(261009223027099003)(55112099003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006)(261102123227099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lMWqCxr9QfBXgi1gxVdH6gx3WNpuiGAsjrYsOuhou921WMPrWmgskwA3Ywws?=
 =?us-ascii?Q?FGEFq3FgiQHCTR6wMJdNrmtAoEFIXaKubHB8jY7gUGoB4ujPW2mH2u02EFxm?=
 =?us-ascii?Q?6aXVoRPdvk9Q7vlcsiKPUaWHKHHqhdBLq44rHomkTu92rkcvPdKQLtuUZJfk?=
 =?us-ascii?Q?4dlcssIgfrL0KufIzL1eSzEvTpSjTPiUd9hNU6OK5qiELuhlhyJQtba/d1kU?=
 =?us-ascii?Q?6m2Ot04fD5cWOm4QHy3eKnMyAHBn/K6mC27H9GM4f1JEAdz4Axj8jSfOP10i?=
 =?us-ascii?Q?mhcWudAQSahXfDMWfNRGENSkyeiDe/TUV2lTx95fq2sBIAwDQ/lf3ma4EHUW?=
 =?us-ascii?Q?H1S9MqleszIo+ZkH2+I9uNiXLJHOP6h/BZSOa0O1FCMqZd1bl7hat3QfSVb/?=
 =?us-ascii?Q?4/wjK6mqpjbZUSgVPLC57Bfoh5TnngKWvQmLhWSMXBdI9YLj/mcbLqO7vEa7?=
 =?us-ascii?Q?2LnAlNagxYJSIzY+MOZUkIbAFHbU+5YfLY1cAO+Qu9fPMYAj2PbBGOAT1Cqh?=
 =?us-ascii?Q?HtS0JjnoVXrO/y+WgImSPvzfiGU3IWGtNlebrFGKHIgBPcdkmcOPhptzbo97?=
 =?us-ascii?Q?HfPOt/lk7ZH7aW4YIdlcRlhHprlI3itihPyNNDhGrF6nr0Merl51Oec+pP6a?=
 =?us-ascii?Q?2ipYV7CBmpiscksBQ0mgdb5Nn/GntB+8h6ZrcnjGcdVGWbehzx2ZzRPMdIns?=
 =?us-ascii?Q?febSQIASUiXtkbHqk8uVNj7zD7OIAB7Bkwa3AP2f8vdaY2wpFQ+/H7LxYg0+?=
 =?us-ascii?Q?ArduAbGr11bJ2w5jVwKuoqtBmV8SnhUQ4lcP6/90C4vX3Mf5+3ProPTykd5J?=
 =?us-ascii?Q?md9fSIe5DptEJOqdQERe0jipoMcJa69O9okJ2b41OvntWO7ontBhJ0FqRBUl?=
 =?us-ascii?Q?baF7UL8CO2iQwSSQLMqgs2AppIeDJV1F3K0ZrTM+syVrXFRdgSi9rMnJpqxy?=
 =?us-ascii?Q?ScaPu/2B1dpOv3PiqTuBTv7O2TwymXJI9NQHcYo53LXu33BiybcqLydQQxTx?=
 =?us-ascii?Q?1dLumKnL/He0WtuXILXnzRsKuu2ogPUjRCCNYKgd+LRRbNj5SbowVkABusdQ?=
 =?us-ascii?Q?cjOFxjgyzrdc0V4UmbdYl1A8nYTVSegPws25aPm6tZUqQ1aFC2GwNwjOzxue?=
 =?us-ascii?Q?N6pHozDj5PFmVhuEt07mVMyeQcybY7aYIJD4W+uumsZeBBcGqpQ4aeuAoVDP?=
 =?us-ascii?Q?kitICa6nqmscr41E2EP1M1Td0bwBjSYq6+y/viIKgJH6aC+gWA08zjB7XvcK?=
 =?us-ascii?Q?/xc4C5jYNQAzzMEDeM9pigTcl3yhFtxGpiq2JlY0/OIQFTOMct3P/3wTmQ23?=
 =?us-ascii?Q?ViGxObVNn59KRU5IFD0c9irLKiaE2M9Ts1Lqbvo0FrwrXXwY541PvpZHABXE?=
 =?us-ascii?Q?mwGxXrJQZyzzr1ZlVoyZwZshQQIr6MZjZeDU1Y8OIq/uBNMVkydRrvMAck+m?=
 =?us-ascii?Q?2eju5hwboNIhc9Hx9KmwUN1fd68WwWKX8gf4il7VRClLnrNXN3PC2ErmtgfI?=
 =?us-ascii?Q?s9pm2rAInr2I+CoZtLnDiJcrUMjXw6g9gjfo2+uqfwcM8Ie4gZ6O6hojXRlQ?=
 =?us-ascii?Q?5PbYH5fUePuTHcNmcXT4ddSjeb4CW9UGxFoUCsZxsIOgs0He6QNLAD6SHdXp?=
 =?us-ascii?Q?8w2GNanS7XIHVgvTMjaPvyXry3OGM0iyGXmuk7Po4SBUTISdSNEFoOvg3+/z?=
 =?us-ascii?Q?BtHCje+cvs6DsO0RiBj6P4EYofcvWyQTJzksFSCEvAU48YKRMNd2YNzniQvB?=
 =?us-ascii?Q?gQfAvZ/+wYzRiDkGfV/qGW6IZjIuvPg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe47e8-d881-43f0-7720-08df4b9a35cd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:49:41.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faq4aq1E53Ri7rEg/ouJ/07kN23ezCSoW9UJX0JvP8Mjtft+9yld9AJNA8izJrRTpg0VBLW6tyy4hZINSuQ45Ra6yATkgOe3e6q+rXtNxOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6820
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 08:49:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25080



On 11/25/26 9:30 AM, Jan Kiszka wrote:
> On 25.11.26 09:28, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>> Any comments on this patch series?
>>
>=20
> Quirin?

Looks good to me, only

Should we use a more defined api instead of `-- SIGNER_SCRIPT` for the=20
script, as currently with `cp`
as SIGNER_SCRIPT we can create non valid swus?

Quirin

>=20
> Jan
>=20
>> BR Alexander
>>
>> Am 12.11.2026 um 14:38 schrieb Heinisch, Alexander via cip-dev:
>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>
>>>  =C2=A0=C2=A0 Following up a request from [1] I added scripts to sign e=
xisting
>>> SWU files out of tree.
>>>  =C2=A0=C2=A0 A rework of the existing sign-swu-cms was needed to allow=
 reuse in
>>> out of tree signing.
>>>
>>>  =C2=A0=C2=A0 The script interface is:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign-swu.sh [OPTIONS] SWU_FILE [-=
- SIGNER_SCRIPT [SIGNER_ARGS...]]
>>>
>>>  =C2=A0=C2=A0 where the SIGNER_SCRIPT interface follows:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIGNER_SCRIPT [SIGNER_ARGS...] SI=
GNEE SIGNED
>>>
>>>  =C2=A0=C2=A0 SIGNEE and SIGNED are provided by sign-swu.sh
>>>
>>>  =C2=A0=C2=A0 1: https://lists.cip-project.org/g/cip-dev/message/24534
>>>
>>> Changes in V3:
>>>  =C2=A0=C2=A0 - Made scripts posix compliant and changed shebang to /bi=
n/sh
>>>
>>> Changes in V2:
>>>
>>>  =C2=A0=C2=A0 - Fixed indentation to tab
>>>  =C2=A0=C2=A0 - Fixed (single) trailing whitespace
>>>  =C2=A0=C2=A0 - Added out-of-tree signing to README.signing.md
>>>
>>> Alexander Heinisch (3):
>>>  =C2=A0=C2=A0 sign-swu-cms: Refactor signing script to be reusable for =
out of build
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 signing.
>>>  =C2=A0=C2=A0 swupdate: Add out of tree signing script for swu files.
>>>  =C2=A0=C2=A0 README.signing: Added section on out-of-tree signing for =
updates.
>>>
>>>  =C2=A0 doc/README.signing.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++
>>>  =C2=A0 .../swupdate-signer/files/sign-swu-cms=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 84 +++++++++--
>>>  =C2=A0 scripts/sign-swu.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132 ++++++++++++++++++
>>>  =C2=A0 3 files changed, 248 insertions(+), 10 deletions(-)
>>>  =C2=A0 mode change 100644 =3D> 100755 recipes-devtools/swupdate-signer=
/files/
>>> sign-swu-cms
>>>  =C2=A0 create mode 100755 scripts/sign-swu.sh
>>>
>>>
>>>
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>> Links: You receive all messages sent to this group.
>>> View/Reply Online (#24783): https://lists.cip-project.org/g/cip-dev/
>>> message/24783
>>> Mute This Topic: https://lists.cip-project.org/mt/122229754/8886423
>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub
>>> [alexander.heinisch@siemens.com]
>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>=20
>=20

