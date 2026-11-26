Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12288.1795693655094145835
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 03:47:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=os60Wm5t;
 spf=pass (domain: siemens.com, ip: 52.101.65.4, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLSLH3ADSXZxO13IZHH73O4HCxlohxF4lUNVe7GDkf8V5H/YKktrUqSKrBJLht7PVHL6zxvzXrtni45w1LUtYQNo4YGcoBo6LZ3yXX7bs3JU5qdEG+qMnH3dtoCtTcK/e/I0iJ2yqsuipmFsWgsBNe56Jz2WXy6yYrnQ+3d2YRXD2SZl10Wjh7yk1q65aPh8r+EmryN1uLEenNsDUFHfoBtdy0DLvqgXXjPkOTjtrfrJ8SzoJ0o672K/oB+LJGXNcOqhcddolSdN1nAplIVH5jF/EWYcBUbo7ME2UqFRXGQvVXocTaC9iwp++sFCnI++eAsbrTDX3aSlvXSk5mNkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbyDkpO2bQsmmswJ2mVt06VaUfeBEjvBxZ4Guh1CC40=;
 b=y+xpjkOI6TSLO6GN/C6IWUH0c2WFdrK4l4nu+e8AigeO+X3HMr3nZNCEi6scvkbJxLAlZOuHXwCdOEeTX6wjkTxWBCAhBsRIPCvZJJayUe4gF/m7+4n6D2BLlxW/2A0wBnyNkmmlfIjMQcE2bGdNrr7xYS2DuUxQs7bdYL7OrPbga/pq5yu8MQQH3c4iPNwiLq4yvpS4QU7YKunLU90V4Jp00mPWPriqzlubjM3UAhlH6Y26gU2Q3N8dQKDIxXtxgZyI4gNSvNJhGuwuVEmAOGEYRMqPDrDzGyEhnHyYekCDWi9oBnqC8g+032vBYTt2nJ1rvBBBVZWnAKDaIL1HGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbyDkpO2bQsmmswJ2mVt06VaUfeBEjvBxZ4Guh1CC40=;
 b=os60Wm5tOBvpa+JBHghVaH4kTFsPFV9LHVcRUXveZIBnbvvWKZ51xmMGXPqwyuBRXG/KofYZlLq8WAiFbuJZUypotVa0+UEMCxH3cqNof6+KCTcwosHoHlL5lNaZJgEMnwELqrfPQiSgDCtIuMeOpZmwK3ZEM2veO9bk5YlO9L3R+jbelfS2msJiVl+Nkv0q8WhXRPveOtMWm23ydM5iJ8sZsS9Kdu0F6ySmKZDMJvHf/6/IdY0UFkv+9U+k5hhkVdRkeKFQ9w6+6fTIbVf2Za+LQTA/7qrENMBjoZB4GLZ2KWkD1NYCHX/ObLaThhG0LEwAO2Ydg+xmG822Nrobbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ed::14)
 by AS8PR10MB7352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:614::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 11:47:25 +0000
Received: from DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405]) by DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2339:186:874d:c405%6]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 11:47:25 +0000
Message-ID: <aafef241-850e-48aa-9f24-b171b518a51c@siemens.com>
Date: Thu, 26 Nov 2026 12:47:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 0/3] Add out of tree signing
 for swu files
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <18E74FCA31FE6824.893556@lists.cip-project.org>
 <57d5b79d-4a72-49f4-aa00-703c750f4e43@siemens.com>
 <b6c3c0ba-f6a5-4561-bf28-889a8303cd61@siemens.com>
 <690d9870-bbe4-4832-b2f2-7fa1459a7e35@siemens.com>
From: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>
In-Reply-To: <690d9870-bbe4-4832-b2f2-7fa1459a7e35@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::7) To DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ed::14)
Return-Path: alexander.heinisch@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8045:EE_|AS8PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb2a0f5-e8f8-4754-15c2-08df4bb30a13
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|23010399003|55112099003|6133799003|261009223027099003|18002099003|22082099003|3023799007|4133799003|13003099007|261021121427099003|261022075727099003|261022115727099003|261022113327099003|261021130227099003|261022105027099003|261026140227099003|261021123027099003|261026130827099003|261026121527099003|261028144727099003|261026135527099003|261021135927099003|261021133027099003|56012099006|10067099003|261102123227099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4FkwTo+PmTAoLc3/gGF/sek0sA81gEY5jefVupinzIZIqUyCivofaYFdkvrL//58HFgRuD4OzplPltT0M/CsZF5Dgt0U+tLRMwVF5jUjnfPMU1axZZ0UB0RKAb1siQVYizTQqky12Mkn4+odjHF8yjmu280FxjS4LOa6sWByCrsRIRfQSlFap4GU3/vh+qz5wIbCe3rzokxKr82S18m77aDnY5WXdTiUgBHRqXJdnFzUWOMVLmAXceaPCyDMLT+7S8Hx3vuHqygrpvNGpQ55f5U5BO9lg/PbQlowWhrwOofZfNe3/juEgfC6kngzJbkFUDb2AKOknR8z/TXLsodRFiuQDVZvPlK5Kav71Zu/M3FK0Ozs8o38fYDzZyzbsTZ1cNq+bbizXBKKE6WXOHnBlys58LvdXweKKHD/QyHEsW4nNC2qkZAN80AMMUASE+XlClK7OuEJghsd622EZzXOQeVqtP7M/dzY3IsF2DR71tP6vbqK8LOe6l0Tt26Wmi3Hcbf6Ph1V3WxW+1lSlCk7qNLlk4irnq7Fnj5lEYlU2yPq5+caPOtVxPUFLu0G5FoGauXSISiy/0dYXGDvs7W9IbvMAie7gJG7B1148p34Uo0HIuYIf5DYq+k4yUIX8CpJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(23010399003)(55112099003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(4133799003)(13003099007)(261021121427099003)(261022075727099003)(261022115727099003)(261022113327099003)(261021130227099003)(261022105027099003)(261026140227099003)(261021123027099003)(261026130827099003)(261026121527099003)(261028144727099003)(261026135527099003)(261021135927099003)(261021133027099003)(56012099006)(10067099003)(261102123227099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyV6ak5LO5ZPIaXPJt5s9SjGlSL/MEGHuTzovQTOQxJqyiGkzMOldtn0vwli?=
 =?us-ascii?Q?jZQeFet2wBlxjihhWUaQpHxHNCqCM0nv3SRBFxY+KPoa5IZOK9Aoscns0cXJ?=
 =?us-ascii?Q?ZHtQPbs1m9nogkJZlbtGtJQmU05SzYSnaRnsUy81H5rhGNUsOXg/v0lVveEq?=
 =?us-ascii?Q?NJOd2YnqpNIl5UFFBe9LUC2auYV6PA4rod65rqrYSAHu4NqfVmHdDxyne9Nh?=
 =?us-ascii?Q?Uj9veiYRXwj9YR+RETpkxbAc+NqVpDpU2RtYP23lh1UOR+IJmAXP/+fO8xqi?=
 =?us-ascii?Q?A1Ube5kLxYSdPvkULGsMaMgdaKTta6CKvuoYSTO2YDs2zuA04tKNlrjy6O9V?=
 =?us-ascii?Q?CHOolQbytnZBvBDG2aO9g+vnN2TTCe//9bv5RFg8J36FPa+pGD5QqiPbw1zO?=
 =?us-ascii?Q?zrJ/fJnleWIm/OkfeBtFuRviXvft3IDeezeKu6UnygzQ77Y+QbvHXRlthfjf?=
 =?us-ascii?Q?40tA8e9Q0u3HHaof+8QVUF1xmTPWBPgHKUwQdsuPP3NsSGLxVlugzmWR1uIw?=
 =?us-ascii?Q?ZIRJ10fBC6NaIQsy5cR8H2HC2Ncz6yfPxbwWgWQt5qaQ8RLRub+DEtdU4v/D?=
 =?us-ascii?Q?uCUPaMVXWSywBKPDzK58MMATkXQFERsoWFYKyzGbUMI8aJfUXmo9GzLllrOA?=
 =?us-ascii?Q?21PW21t/jPzk8s8zfOZQyR3ts6iPJ7Ovv8eJF0G1dVWB/gqtFQsOcDvpX3Lz?=
 =?us-ascii?Q?vgj4o5COMCLKibAMFbHWyIgNsdNmWJ7Xr8Uj4+K81mx4E8vG6hlGD7KO8Kqg?=
 =?us-ascii?Q?dpfNt9b98pouYGvCFzrJ4T4aOJex+G+vNDLUa25pER9xPMpIirXAQmO9Ke1a?=
 =?us-ascii?Q?vIhao2ZlrKvifOwJrgy3dfBiIqpcih1RCcsGPMY6KnWMVlDK0CGgAPyc/cnp?=
 =?us-ascii?Q?88owtCqt+2Hc6A3DGA1uMNP6K5QV/2uCIbGVx6lYx9jQ1JdEc+mPWiHPKo2t?=
 =?us-ascii?Q?EYuLNQ/9db1Denh2McWJLHsOZYaTDnduvJn0Ekr0C6aSYarcbL8jTWbP3JCH?=
 =?us-ascii?Q?PPQonkzz3jsqb1B0w0m2aZq1R7v5Nw9q04pTZaj5DZzHBViR5dFU5y8UfFXK?=
 =?us-ascii?Q?SUYzEdRGSIshwjgv0NCrZuFnVkoI1W9b3FrdkvjQ9jKnIpqdmNDKp2uKIBBm?=
 =?us-ascii?Q?M+MyTpZIVvR5RvmixvAsm8mlLdlxvsIoDbKdLFMApZ07g1Fzs8F1y9RvGuE0?=
 =?us-ascii?Q?NJssxGkkKavJIICf426NLuTCybbQqkTh2finU0BoTQADNgg5JYQvzuLb62pW?=
 =?us-ascii?Q?cOMlUKExPuxYZdVvjDBQf4RVK4thVeCc9Ekyh2+kE72R9QqcFq5RdSXqquUp?=
 =?us-ascii?Q?mqyfMJ/rV1NhLN5m0qeSTgTiNH5oqtc3z35/VNr4sdCFiJV+oprqoNCYeBBB?=
 =?us-ascii?Q?VnwRSiANxbfAyGEbQlKNMFoOQaSaz7t583wZNOfoh+UgLwm6ewO+U+bm1sQT?=
 =?us-ascii?Q?EQlx205C2Fto3j5DkRagHpsmQbVsC6lirNJE9gvsKskswtTpSRBoERS2EbjR?=
 =?us-ascii?Q?fUpR6Hlrqk9dUwVewCJkB9vPMMArJIO1uphelhwXxanhnfQjmgIsFei95lxW?=
 =?us-ascii?Q?Wb7s+iZ2tijXzHC118r0awX8bYoJWnAJgarnC0Br7z30qbD/nqBztw/NyVrQ?=
 =?us-ascii?Q?XgpwWuw3+bUqVveUT0OfJJRVAX4J4hutkgCd20vdHyCUdbi2CMK+G42EFJ9w?=
 =?us-ascii?Q?6zch104eGBX37J+Q62J8B1ISLE384jUL520+KWoJWivbK5itA3Jg0+9eJxaS?=
 =?us-ascii?Q?Y1peQkVSrHMkV4KUd3Pzrt6mZTWi+g8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb2a0f5-e8f8-4754-15c2-08df4bb30a13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8045.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:47:25.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSF/eKFCtRyG1cXAsHkUgqKb4tHbmbFN8DCV6AG+/Ohr7UKJUY9S1IWmrnBzx1BpnmKKefWDWmqN8KuFATzSzpITj7ZHdz8/v8eagC0VeFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7352
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 11:47:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25104



Am 26.11.2026 um 09:49 schrieb Quirin Gylstorff:
>=20
>=20
> On 11/25/26 9:30 AM, Jan Kiszka wrote:
>> On 25.11.26 09:28, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>> Any comments on this patch series?
>>>
>>
>> Quirin?
>=20
> Looks good to me, only
>=20
> Should we use a more defined api instead of `-- SIGNER_SCRIPT` for the=20
> script, as currently with `cp`
> as SIGNER_SCRIPT we can create non valid swus?

The signer interface is defined as (see: README.signing.md):
     SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED

As I cannot forsee additional parameters to the signing script the=20
proposed API was the only generalization I could come up with.

Any suggestions?

BR Alexander

>=20
> Quirin
>=20
>>
>> Jan
>>
>>> BR Alexander
>>>
>>> Am 12.11.2026 um 14:38 schrieb Heinisch, Alexander via cip-dev:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> =C2=A0=C2=A0=C2=A0 Following up a request from [1] I added scripts to =
sign existing
>>>> SWU files out of tree.
>>>> =C2=A0=C2=A0=C2=A0 A rework of the existing sign-swu-cms was needed to=
 allow reuse in
>>>> out of tree signing.
>>>>
>>>> =C2=A0=C2=A0=C2=A0 The script interface is:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sign-swu.sh [OPTIONS] SWU_F=
ILE [-- SIGNER_SCRIPT=20
>>>> [SIGNER_ARGS...]]
>>>>
>>>> =C2=A0=C2=A0=C2=A0 where the SIGNER_SCRIPT interface follows:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SIGNER_SCRIPT [SIGNER_ARGS.=
..] SIGNEE SIGNED
>>>>
>>>> =C2=A0=C2=A0=C2=A0 SIGNEE and SIGNED are provided by sign-swu.sh
>>>>
>>>> =C2=A0=C2=A0=C2=A0 1: https://eur01.safelinks.protection.outlook.com/?=
=20
>>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>>> dev%2Fmessage%2F24534&data=3D05%7C02%7Calexander.heinisch%40siemens.co=
m%7C94fe47e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C1=
%7C0%7C639312797856707722%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI=
lYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%=
7C%7C&sdata=3DlbFWhO8%2FRxNVEMzI49kbv54fVeb0%2F5gWtMcDF5J0bSM%3D&reserved=
=3D0
>>>>
>>>> Changes in V3:
>>>> =C2=A0=C2=A0=C2=A0 - Made scripts posix compliant and changed shebang =
to /bin/sh
>>>>
>>>> Changes in V2:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 - Fixed indentation to tab
>>>> =C2=A0=C2=A0=C2=A0 - Fixed (single) trailing whitespace
>>>> =C2=A0=C2=A0=C2=A0 - Added out-of-tree signing to README.signing.md
>>>>
>>>> Alexander Heinisch (3):
>>>> =C2=A0=C2=A0=C2=A0 sign-swu-cms: Refactor signing script to be reusabl=
e for out of=20
>>>> build
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signing.
>>>> =C2=A0=C2=A0=C2=A0 swupdate: Add out of tree signing script for swu fi=
les.
>>>> =C2=A0=C2=A0=C2=A0 README.signing: Added section on out-of-tree signin=
g for updates.
>>>>
>>>> =C2=A0=C2=A0 doc/README.signing.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++
>>>> =C2=A0=C2=A0 .../swupdate-signer/files/sign-swu-cms=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 84 +++++++++--
>>>> =C2=A0=C2=A0 scripts/sign-swu.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 132 +++++++++++++=20
>>>> +++++
>>>> =C2=A0=C2=A0 3 files changed, 248 insertions(+), 10 deletions(-)
>>>> =C2=A0=C2=A0 mode change 100644 =3D> 100755 recipes-devtools/swupdate-=
signer/files/
>>>> sign-swu-cms
>>>> =C2=A0=C2=A0 create mode 100755 scripts/sign-swu.sh
>>>>
>>>>
>>>>
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>> Links: You receive all messages sent to this group.
>>>> View/Reply Online (#24783): https://=20
>>>> eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.cip-=
=20
>>>> project.org%2Fg%2Fcip-=20
>>>> dev%2F&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C94fe47e8d88=
143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C63931279=
7856765900%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw=
MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dz=
3Y1Ak4bldrxkRLNuBekJCAaeeLwLIGjSNUVK8Kt4UU%3D&reserved=3D0
>>>> message/24783
>>>> Mute This Topic: https://eur01.safelinks.protection.outlook.com/?=20
>>>> url=3Dhttps%3A%2F%2Flists.cip-=20
>>>> project.org%2Fmt%2F122229754%2F8886423&data=3D05%7C02%7Calexander.hein=
isch%40siemens.com%7C94fe47e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4add=
ab42e1495d55a%7C1%7C0%7C639312797856806889%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0=
eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo=
yfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dn3wE5xlEOIBD6Bm57vIneBbSRCUqMxTjKreFG5VbN%2F=
w%3D&reserved=3D0
>>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>>> Unsubscribe: https://eur01.safelinks.protection.outlook.com/?=20
>>>> url=3Dhttps%3A%2F%2Flists.cip-project.org%2Fg%2Fcip-=20
>>>> dev%2Funsub&data=3D05%7C02%7Calexander.heinisch%40siemens.com%7C94fe47=
e8d88143f0772008df4b9a35cd%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C639=
312797856847359%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA=
uMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat=
a=3Dy8i2zMWyLExkVqjr2beoJPd%2FZrBNxy84F8e8JtCisCo%3D&reserved=3D0
>>>> [alexander.heinisch@siemens.com]
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>
>>
>>
>=20

