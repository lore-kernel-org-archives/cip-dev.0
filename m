Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15110.1795703847409387844
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 06:37:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=yj73cEa1;
 spf=pass (domain: siemens.com, ip: 52.101.66.13, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nc67lOs4A+K2aiGoBVlff0P0rkonen6iSh7tD6MXliu90Zbj0WBrXHTDRrSL7zU1LXVcrR521P/N9RLZiwj9PJbM1YQrx3WVu2NQajZDa3znMZOz4cs3qBwVYfQYkc2TiCzaM4Gti1irUtO+TWCvM/S26x+7MuCu4IuI8wrY4NVxxNxDlykP4Dfcy1nne72uieSpLuROFUdV1638u43IWx3EAoboAlV6438V6Q2yCeLOPcfsOe17cHFEHtfxAGLzLh8SAsfvzYbSC7kNLD490Xb6g1froPKufZCv+vMViOUfQH3SxPBqOhbjFiAvat1bewdnox4tgjK+way+1FM0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ft53/92qn19GUuUPztLxiInK0cKFRR7x9E4lK9Ikyk=;
 b=NNK4oPgmwf/PTeq8z3Q8QDpEmJPg3KH0keMAI8rENwGVH7qU5yZeCGqa2wit9oU7zNuWlhS7ewiQ9GMGKTANju+ubx1Mhc4eCG5URdCU2xTtCSEb5YspkK5Hu/dGOG3IdcmzkhHmxPzDWqrcI5pNvCs+HfCXG2bkWVI+qJdBDMKqkZMQQ84GYOmRmdb7xFQA8GHHXzE5pb9aHfaNZlJM0yeVWFyTq/ZXHcVNshKapTUXW3HlYF/mf7Zb50KOBzmyQlt10xEl+eShzu+DqZWf+7dj0DarveS1dalT7iSgGwzhWuhN8BpcndiosjmbCVCyr7Yb30HWJ90PGs7fRaJ2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ft53/92qn19GUuUPztLxiInK0cKFRR7x9E4lK9Ikyk=;
 b=yj73cEa15Up33k6NOiQ+GO4gq/Qn7wT+rF/r0z32B8ZtYK1JpkN2rsppleuKqATO1gvcG5PHbo3HQu2+axqSwGBmA8i0aqs8IoFUpniQSAwBrfG5P9zO4m2weRZGXgcRRPw/gIwt2gMcBgqi2O+ikKTVmo9+tkIcYq5hEc3aK0iqIwVqRpeIYXfcgzguGN8Bhg5/L5d9DgYqfgs9Ky+ntzA2VAgUtP/y26maNDgwp2P8gU5yn0Z71jtoQdic93iLHVREnPf+OIenxu4jGmwX1S4IZ6s2BsJtNDxdtXrr2E5W4NR3zZq4dFiZA+aC1nOXIVobij0VvLgcEOALiXQK4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB8139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:387::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 14:37:22 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 14:37:22 +0000
Message-ID: <7dad6556-5893-4b87-baa6-963aa00a4422@siemens.com>
Date: Thu, 26 Nov 2026 15:37:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 0/3] Add out of tree signing
 for swu files
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 cip-dev@lists.cip-project.org
References: <18E74FCA31FE6824.893556@lists.cip-project.org>
 <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
 <b6c3c0ba-f6a5-4561-bf28-889a8303cd61@siemens.com>
 <690d9870-bbe4-4832-b2f2-7fa1459a7e35@siemens.com>
 <aafef241-850e-48aa-9f24-b171b518a51c@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <aafef241-850e-48aa-9f24-b171b518a51c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c58f90-027c-40b0-63fc-08df4bcac872
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4022899009|6133799003|18002099003|261009223027099003|55112099003|22082099003|3023799007|4133799003|13003099007|11063799006|261022105027099003|261026130827099003|261022115727099003|261022113327099003|10067099003|261026121527099003|4143699003|261021123027099003|261102123227099003|56012099006|261028144727099003|261021135927099003|261021133027099003|261026135527099003|261021121427099003|261026140227099003|261021130227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: Pl1j+9m9iN1PAdtaor5Fd3nmyoI7u7jyY5aHErzf4lJL7TdbBH1MOA39JG2Zt9tjA80DLfRoPMS2WqkxrBBbwRoHwYfKqgxN+9I/irCyFiHhfEmq5XA6Cdu8qmNUrp7YbpmE9582ALhWz4p+DXql1RTfmx3B0gYmfKDUPWZNya6IehGtzulD3otD3lt5QmIK/n6PNgR5fKMIq35ZJoQqe16RhWzF3zfWSzSent/RSV83RqKUaBi7xvRbCcDlMFuqUp7jUyZTnH+gctYJGnzr0F8jGDPDPaXBGonheFFUQMsf/F7jNhn9LBX2KuvdRGQfyS8Y5nCj83mhaJRrBQU1aFW3X3P5K38mYPWmNM9zMnwgoE/THTdYV2hM/XhxcCK1ClTa1eHdvEti0WmqVn69vNjJgA2Z/L1+b1UpNnU+3OfRHI/uxhKb79xywSsdMYLJC7wC6UsO+514SSpns0vWWQwQbM9PVh+CvhaHkn6n3E50gB8TyAB7LPzb+KWQWgoLLTSiSRrB71gzC3hrbc/C6vnz+XgSUjnDl2Yk+uKwh5focxre3y2eIHnx1hYwJZd2GIf2IfLvgFkR9JDaYFRSJ3WqlxtpxJof01gbI+GEAdt/ib1J7iKOCF4aPCDU5hly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4022899009)(6133799003)(18002099003)(261009223027099003)(55112099003)(22082099003)(3023799007)(4133799003)(13003099007)(11063799006)(261022105027099003)(261026130827099003)(261022115727099003)(261022113327099003)(10067099003)(261026121527099003)(4143699003)(261021123027099003)(261102123227099003)(56012099006)(261028144727099003)(261021135927099003)(261021133027099003)(261026135527099003)(261021121427099003)(261026140227099003)(261021130227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z0BLbcNLPt8zxFaAc2IEo506WcQxSQBpXZ7JiF/jIFLz8qIFtOgzPEEK+8bn?=
 =?us-ascii?Q?Oi1JsNSLO/zZTrx3/7XZC+3gf4mbSiHcF7Vt5CrGQMWWof1YycFYftt2qraT?=
 =?us-ascii?Q?2aOjxqQmGyttGIntaYl+Bj6IFdXc8GDeDhxNHesRWm9ga3ICXRL8/BI2fo/Y?=
 =?us-ascii?Q?EuH5fVSoBQG3ytd5noaxjrm41zwOI8PMUQEr8eAKXrSf4lwLWLmAwpEwpj/v?=
 =?us-ascii?Q?w5TWoncc5upcXGIz8F7g/n32hEXb6vSCIXexWMW8/bbAdLhBfUHlk4SBxOZe?=
 =?us-ascii?Q?ptXUF/7jb3BoxaVdIp4oud6V75Jdw8niiV/WcLGG7XOuCCNOD4wvoy7IBgWH?=
 =?us-ascii?Q?PKA7ef9ZZqCkSRU9ESLz7RZTQzzpXcbLz5bUPKqv1ijuoHNxnPUVbBPApJfl?=
 =?us-ascii?Q?CMh5gcdkl7/r19hx6oLbiiouH0v5wNtzq5zHP0lE6OaAXWGLeeGzwCeloMYU?=
 =?us-ascii?Q?2/OUEIHua5FYp8+ILcjbf310HRev8JZHYiln1CnPtVlwFfBYSas+24a0HHqh?=
 =?us-ascii?Q?yeX/QY/LEDeb8po2Oh0jtpVaIJN5+Srg26WDdZmzPEoHad3YvBlwvdgXp/4q?=
 =?us-ascii?Q?cEcucRfo3CsEHY6L1cPLgl7vu1+rxnwQ6+9YQM54SGazou9SpPq5qMIjHvVh?=
 =?us-ascii?Q?kmbHAWEjMNqFzFbEEGaa2cF9kuT9y1LJ+VV9dA9HuJENhpVSTNMYDH+WuaWg?=
 =?us-ascii?Q?hpyWggM33oHF/C/8Dl1ANRht3a3aHUVOPQJzeSciZ38ol5tbMPOa14nMykFf?=
 =?us-ascii?Q?ve292cZk9znC04/tskeYTmTwPhwdMN+d74uKnfDwWbAh+oqqFCz0XXdyw+ti?=
 =?us-ascii?Q?SM6yxhGCe9th3M1/uBjfv62+WJopE3cB91UmSSL+9YfsvZhBJTVz2+zGF1Cm?=
 =?us-ascii?Q?FHL928mCpDFmDW5/2egNMpgkP2rcj2uQYafVkS1t0DmFsQTOVdT1PHzyb1m8?=
 =?us-ascii?Q?HC4o24ZZkpETbGOjSXUhBaI5Eyk6r5Ap4HMymBDRKzMHay0Yxoo/HMskDWuj?=
 =?us-ascii?Q?bpcNNDHpEsE93IdnkdMJtjAgZ7/IvmGzNoAdcO0uazFFYJ8bH8MldgtPD796?=
 =?us-ascii?Q?K6/l+Iv+PRrhAeb0o9RxPFiappm3MGNOmB9ERkvQ7xbl8N6ybgZrWC5b+RDA?=
 =?us-ascii?Q?xQ1Muhf/tAzKS17kcFIdgTqKEoSPUp4psArIO2glzSyMCrAmiRyjMlVCxDjX?=
 =?us-ascii?Q?kzU1yzWDwPfAYDwiHM5Lqnjp6Z11kfe78sVh4synMS4l1MLJOk/dTO7NccKf?=
 =?us-ascii?Q?Bz7a+n+j0v4hG+29X+ZP5nkEDOCnxJjYnK4X/Iit/HKMPmeUXTBoJhdRFF1C?=
 =?us-ascii?Q?I0RRULG0DOYK3MJxhneGwIGp3zrHVkzyUlujVV8y7S/wmrzmfbQbcGdtG8cp?=
 =?us-ascii?Q?xsrAtUBbFJEJX21PmfDSMDKaw/IrXr6/kVeQFlO8LgXCctbnlj8ha0IcVUIy?=
 =?us-ascii?Q?+HX9d+WdBVnG4Os1Zc9aEUx6infVcfXROmR+HoIODL2iNAqUe7fiAHwKOIEm?=
 =?us-ascii?Q?/3G8uGUh/euTItFDZwKWxkssCg3u0I6o6x2CwuhK/hlTzpGsuFB2VcooW2ql?=
 =?us-ascii?Q?vD6lu49n2qRrlSLcvIB0SGRC+CFbPFfxcwyrU4hnvqUdcN86pQI5pw1Jf9L5?=
 =?us-ascii?Q?w5S+1cP0nWwSGBNaBfJhNTrZLEr26lZBCxavfFKEiBT/Jo/G9Vdfi3EuSeuj?=
 =?us-ascii?Q?a+LtE2sh4OwskcLR2dEHK6qKx4aXKH9pSOwBNPj3yc6b1HlKkq0IoFPhAgxF?=
 =?us-ascii?Q?I8dAUNE1NWS1QYW6ZXZ1dvj0T48BjBU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c58f90-027c-40b0-63fc-08df4bcac872
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:37:22.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8+6nZlAspVQb++5FPJT8dDZENNxb7zQBQy9eC7j62PHO+GcGSLobtGaR3FPyjTIbPzcu53nw3XPppWX8qv3Nikcrj4n06naFqtRZsMn6VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 14:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25109



On 11/26/26 12:47 PM, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>=20
>=20
> Am 26.11.2026 um 09:49 schrieb Quirin Gylstorff:
>>
>>
>> On 11/25/26 9:30 AM, Jan Kiszka wrote:
>>> On 25.11.26 09:28, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>> Any comments on this patch series?
>>>>
>>>
>>> Quirin?
>>
>> Looks good to me, only
>>
>> Should we use a more defined api instead of `-- SIGNER_SCRIPT` for the=20
>> script, as currently with `cp`
>> as SIGNER_SCRIPT we can create non valid swus?
>=20
> The signer interface is defined as (see: README.signing.md):
>  =C2=A0=C2=A0=C2=A0 SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED
>=20
> As I cannot forsee additional parameters to the signing script the=20
> proposed API was the only generalization I could come up with.
>=20
> Any suggestions?

If we have no Idea we can merge it.

  Normally i would say that the signer should only call signee and=20
signed and no other arguments but i understand the possibility that we=20
want additional parameter.


Quirin
>=20
> BR Alexander
>=20
>>
>> Quirin
>>
>>>
>>> Jan
>>>
>>>> BR Alexander
>>>>
>>>> Am 12.11.2026 um 14:38 schrieb Heinisch, Alexander via cip-dev:
>>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 Following up a request from [1] I added scripts to=
 sign existing
>>>>> SWU files out of tree.
>>>>> =C2=A0=C2=A0=C2=A0 A rework of the existing sign-swu-cms was needed t=
o allow reuse in
>>>>> out of tree signing.
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 The script interface is:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign-swu.sh [OPTIONS] SWU_=
FILE [-- SIGNER_SCRIPT=20
>>>>> [SIGNER_ARGS...]]
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 where the SIGNER_SCRIPT interface follows:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIGNER_SCRIPT [SIGNER_ARGS=
...] SIGNEE SIGNED
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 SIGNEE and SIGNED are provided by sign-swu.sh
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 1: https://eur01.safelinks.protection.outlook.com/=
?=20
>>>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>>>> dev%2Fmessage%2F24534&data=3D05%7C02%7Calexander.heinisch%40siemens.c=
om%7C94fe47e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C=
1%7C0%7C639312797856707722%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs=
IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C=
%7C%7C&sdata=3DlbFWhO8%2FRxNVEMzI49kbv54fVeb0%2F5gWtMcDF5J0bSM%3D&reserved=
=3D0
>>>>>
>>>>> Changes in V3:
>>>>> =C2=A0=C2=A0=C2=A0 - Made scripts posix compliant and changed shebang=
 to /bin/sh
>>>>>
>>>>> Changes in V2:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 - Fixed indentation to tab
>>>>> =C2=A0=C2=A0=C2=A0 - Fixed (single) trailing whitespace
>>>>> =C2=A0=C2=A0=C2=A0 - Added out-of-tree signing to README.signing.md
>>>>>
>>>>> Alexander Heinisch (3):
>>>>> =C2=A0=C2=A0=C2=A0 sign-swu-cms: Refactor signing script to be reusab=
le for out of=20
>>>>> build
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signing.
>>>>> =C2=A0=C2=A0=C2=A0 swupdate: Add out of tree signing script for swu f=
iles.
>>>>> =C2=A0=C2=A0=C2=A0 README.signing: Added section on out-of-tree signi=
ng for updates.
>>>>>
>>>>> =C2=A0=C2=A0 doc/README.signing.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++
>>>>> =C2=A0=C2=A0 .../swupdate-signer/files/sign-swu-cms=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 84 +++++++++--
>>>>> =C2=A0=C2=A0 scripts/sign-swu.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132 ++++++++++++=20
>>>>> + +++++
>>>>> =C2=A0=C2=A0 3 files changed, 248 insertions(+), 10 deletions(-)
>>>>> =C2=A0=C2=A0 mode change 100644 =3D> 100755 recipes-devtools/swupdate=
-signer/=20
>>>>> files/
>>>>> sign-swu-cms
>>>>> =C2=A0=C2=A0 create mode 100755 scripts/sign-swu.sh
>>>>>
>>>>>
>>>>>
>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>> Links: You receive all messages sent to this group.
>>>>> View/Reply Online (#24783): https://=20
>>>>> eur01.safelinks.protection.outlook.com/?=20
>>>>> url=3Dhttps%3A%2F%2Flists.cip- project.org%2Fg%2Fcip-=20
>>>>> dev%2F&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C94fe47e8d8=
8143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6393127=
97856765900%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDA=
wMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D=
z3Y1Ak4bldrxkRLNuBekJCAaeeLwLIGjSNUVK8Kt4UU%3D&reserved=3D0
>>>>> message/24783
>>>>> Mute This Topic: https://eur01.safelinks.protection.outlook.com/?=20
>>>>> url=3Dhttps%3A%2F%2Flists.cip-=20
>>>>> project.org%2Fmt%2F122229754%2F8886423&data=3D05%7C02%7Calexander.hei=
nisch%40siemens.com%7C94fe47e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4ad=
dab42e1495d55a%7C1%7C0%7C639312797856806889%7CUnknown%7CTWFpbGZsb3d8eyJFbXB=
0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj=
oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dn3wE5xlEOIBD6Bm57vIneBbSRCUqMxTjKreFG5VbN%2=
Fw%3D&reserved=3D0
>>>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>>>> Unsubscribe: https://eur01.safelinks.protection.outlook.com/?=20
>>>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>>>> dev%2Funsub&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C94fe4=
7e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C63=
9312797856847359%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj=
AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sda=
ta=3Dy8i2zMWyLExkVqjr2beoJPd%2FZrBNxy84F8e8JtCisCo%3D&reserved=3D0
>>>>> [alexander.heinisch@siemens.com]
>>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>
>>>
>>>
>>
>=20

