Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.370.1792470477244423687
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 21:27:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KrZbkn9g;
 spf=pass (domain: siemens.com, ip: 40.107.130.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhwlTvvZa2SaHC21u8IR687cRHvby6NUqOQg58c0qs+5WaUPDp8e0RF7VSfdSn3cbMmvEflf4AzYPe1CY5F+EUcmuKZhpkkllyC3k05HOBttPnCjOigcy8fUhWey/RdLV7lo5E5H6UJovqttY1aizGFiLpmoGfQycR4J0J6nNU0WsK0pnwfWYx7NQx1PASx0P35bugCzhMQmuyIwEYpyFyaQCSdPPLWPaT13s8UHleQ2rW0O+LDI3yXy0QtnBAMnh/Lr1nplWjrKEQsJBGULtbUskoPS1aNfyMIa19JSY3/gP71P2bXS44LjKzBlkosZqpjAxRBuiVTMpteiik8hwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4DgF1aZTpKZuXFOM0igCoPWpHVeCDfhNaWFefcPZ1I=;
 b=GzYqD3XjeobA7Kv6PIGIGvWjb+iXr7LM5n8nLgthZD3HkIC7cnmeFsxOKkM3bvWJfyp0Z01xybwCOG4+qwKC4WjcdLzvlQd9/GuEQVOEQP3rf7HsXlU0hODwHZ7QT6nwprlNJx1qRhoD8iwH3SE9CnkJNwQz+EDzDhS1A/Hpw4Oc62hr+NEgZkU9tIcAHfRNqLE/PJSL7OD0Ch9rRbLb9+oCrnC9PTa/XY8zzMRkSIbS2JJZ/J0GOjSfIcz4crEgCDLxCfkyod/XNJWCUkCIVDzTYZsbPtDM8cunHwYZEphG3W+jgE2pmup2JtS22GSCKdg0m+Ey95C+Mt0HpT5zsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4DgF1aZTpKZuXFOM0igCoPWpHVeCDfhNaWFefcPZ1I=;
 b=KrZbkn9gd4kUaesPbkkQxOTHh1E2r7rBlZNKb7QzN39g07JfKcfPmvzqNjeSbPl24wTgsd7RRPYUp3MnOBaq4QGsmwoLtDuwRd4MIgsVe5TTzzHIcHbdJUcaGX/8TSxO4GQKgiWm02yNbacfbLRkd3s8t/LoQvU/Ovn/ClcRtcfiJNCSLQCO++AO6Lg4ni7G5pj7MQjPP8OeiplHBV/Za2aSZ9RR5whBySOCY9BeyZinlQQcB/j4C1edvbeI4/uvVrTTd5cmjmPfqj7K6JBK/MjZLoMB3Dq4+XYMxPcx2PSZ85xfwCpwHbfBL7ptwxfr6NkZfUiH76J2CE7JcV1Zfg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV2PR10MB908632.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:38d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 04:27:52 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 04:27:52 +0000
Message-ID: <e5bf8a6c-2617-4da6-91bd-1c256e06e2b5@siemens.com>
Date: Tue, 20 Oct 2026 06:27:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV2PR10MB908632:EE_
X-MS-Office365-Filtering-Correlation-Id: 012e50b3-ef75-48b3-18d1-08df2e628180
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: aQc479xqameAQaXuPHSGfoX8I7CJga3yL8eUeuNOOqJZoqs2SFaXeA8lWokSMa63yMNQfWGGqq3z/APhQxV2fD/lHHhdUBgaqBZPNxO8T17m3483Gfr+e2yEk0Wo7KOqjn7miOAwH7a/PVeZ31CcVhXSrmY07GhByO6yZ+EHyDZtzHmoWFwX1sFWzPGr0d+UWNZH4symQKnEavteBfWoJXBLfg9brpLHzo7fH6Yi/fp8tayUt3s4buIb6ZWGJ6URNWnIA25x2nvRu5yvUsofqk1XNshJ8EjjhVfuJ1f2QGqj63NdAUSVnoW5lhRKU4bExZzymJx3FTlkhuOtVAgMmBz2y7cjFZkS2qCMYEoFyXpGsUhTpFJSFi7FVDAsgDb3goXv1PuSMOOBFFa1wDASL4URkiD5SHddTXGn1ekAW0HgBNW1gKr+nNhBGJ12whL3CfWVqYFtP/tKxdgb2KV8Nj7eMDOjUHcROu3kIHfjQjwRDp5NLy9fU4I8Ge/0+NvuICx1mLunTAC0WYW1mFti0VyvVKDkkoY98HbStqBEPfW60O0wRPvDzGDeWXmHVvh5o6JnokNbTvGNeq2O4bk9gFL+quM0V/taTyQxVKF4mzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2PaJ5h3al7Cf5xHemMomSSJRVHV867sS7R/LgJ8ghtuv/C1ujpgu+e47ht+8?=
 =?us-ascii?Q?IED5fEwiok/PLKGUDORRhRU7tazTUwnKnHSTHulHQj1UWGk1SVNyx1ZxAc7i?=
 =?us-ascii?Q?tDaimajTQgPl3MU7q4abMqaXfZ7fueyQzDIh8fOgBuRxAP/QJrgl7fNSbzhe?=
 =?us-ascii?Q?CMxYkoXKpHxldPEHv/cqM1RnGLlLqUfI4SU+1Ry7DpXHvpuqMaloxCX/NM+4?=
 =?us-ascii?Q?lNSdCKT49q68Ok/lbVdXYDoQ7j9bDzKW1JlYYS3zualpaU9JEbtZ2cQp48Vu?=
 =?us-ascii?Q?0qCwbq5/HBJwOv302Z2/Lc6VbvfqtdrUOqj0Fnxllxu4wI/2tAUMXs/YRq+V?=
 =?us-ascii?Q?87UbuVAtwv9SI8oA+cM2aLsuvcO4DNksVsYoVejCo6bffF/XaBvEyRjlZIg1?=
 =?us-ascii?Q?Rdnc3wqj9+3MpE9LvGBqOHet+eTJjzjTQkt+YRM/xFzTY3UQf73XHKqcNG6Q?=
 =?us-ascii?Q?DHHcmNmKpxdq4SUUNAemDZrf+sTxSx1xT97CBzBJvKy4P4GMGF+1OZDeMlYk?=
 =?us-ascii?Q?YqYBOyea85W4qqfKKn4QUhXiO+d+PhsO8gfGOBoKv99kWN/uKgST1MugD7V6?=
 =?us-ascii?Q?kyub7VfrMlCeE8NMI0Cmf+0Ky/zuJ3yxgzIogtlgIqRCZ6EP2rFjkYPfmdju?=
 =?us-ascii?Q?UKoVRdGT/jsMAFEjUyzIP+WRHJ9mhXlHaxoJ3bkD2HjHAarY/L07xg+uQck7?=
 =?us-ascii?Q?ZkluVwCh61jeyKqwykCHBgfyMZwcLpSd6lK9vLAN+pCnwiLRDCuF4AfRvmRZ?=
 =?us-ascii?Q?tu4aTc536mwxjkoj2pvs5hm+adngz1yi4uDcZvGxidUuBIQsnrhStbe0QGVu?=
 =?us-ascii?Q?ZNnH9gwSVUfq2zBt6GciXB9nfloohllSWrFjkDGH3dYngJ0l7Q84oa5eOHyz?=
 =?us-ascii?Q?XC6avQwDj0UdGs6TCt6Os43d9wJiqmY/Qpb6MdxIerPC/66ECFDCIBBuSEgw?=
 =?us-ascii?Q?LUna9iOIPtnqEZ5MR5yVDHmx1n5ewMMGYtnSHLlSBCbI66SxztkCUalFHGRw?=
 =?us-ascii?Q?R8D7lz8V4X80ft9MIICP5OOJSynfDKddyYt1I84SltQ0JGLnxk6EVRncHQpL?=
 =?us-ascii?Q?vjuZJS4flQ1r+KA8bj6HqkpKBgmY7nMcHaVBLgjuBOX6r86bYUSpmCDNb6By?=
 =?us-ascii?Q?O/Zf1q7B1kyvP9wS/TGEoGWCYQswSC6RbahHAxTeQxcvHCYdbboePGcTFLJ0?=
 =?us-ascii?Q?WlV3yTESnxolow+eHdRmvFBW5AOPg6/ZsKi81gPEhrET9b6PpHDhY43nvhl0?=
 =?us-ascii?Q?Ut+gnYeqIpA2BE7nOpg4k1UBZhdV3Y+QEwl5XkLWXgd3GYHMTmRdOXv04HLl?=
 =?us-ascii?Q?hRzJwA3R97FsMrV7HdBKUSmAqEquA/9kCQfTPSFr/fr0NzfiVJuyHROtdYMq?=
 =?us-ascii?Q?7d67XCU2odqlw45bLYnqS1b61QxzQmNaff6VFCEOeQf7s5wtX7fBvs4H/gX4?=
 =?us-ascii?Q?6Az1aVXYEo5gUGLuyb/EH/UYItitzzk2agPOZhNdNVrzmBLc8K2hRG6M3AFL?=
 =?us-ascii?Q?h617/M8HMUhgViqdW9+DGTNMyZ93w0r0lA/8XMx/WPWuAktCS59L5BEgdW9r?=
 =?us-ascii?Q?lUDT3pnChX4PGxrTspIW2OzqxBnQn11Hou7HeeTT6Va0KJNju0GV/bmN30Uj?=
 =?us-ascii?Q?K7rZWLs6EuA0MOWuzQ8I1PafBiyh3HHrazaeBfPrDqIR8Qy15eb3Ig9MJ8Wi?=
 =?us-ascii?Q?gQvRWe/SpNRYSbshmhyUWRPRm1DMXt7C6/uMpPK/skS5UfwiEOHZ9OatMHH+?=
 =?us-ascii?Q?gV0pq/gHaA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012e50b3-ef75-48b3-18d1-08df2e628180
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 04:27:52.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5ie0X7Xu1j/P2usX8MQQLfI5gy7bg6yIGEVFlbeZ+fIJmskgBvgKcgOulduRyB79u03XA0cQKgKh9zEauYGQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB908632
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 04:28:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24497

On 21.09.26 07:29, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This describes at which time which ares of the CIP kernel are handled by
> the CIP security team and how to report vulnerabilities to it. It
> furthermore state the this projects falls under the LF stewardship
> framework.
>=20
> As the original kernel documentation already contains a reporting guide,
> leave a note there which one applies to CIP kernels.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>=20
> Changes in v2:
>  - leave a note in security-bugs.rst (will need adjustment for older=20
>    kernels)
>=20
>  Documentation/process/security-bugs.rst |  6 ++++
>  SECURITY.md                             | 37 +++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 SECURITY.md
>=20
> diff --git a/Documentation/process/security-bugs.rst b/Documentation/proc=
ess/security-bugs.rst
> index 56c560a00b37a..7b38c83d932d6 100644
> --- a/Documentation/process/security-bugs.rst
> +++ b/Documentation/process/security-bugs.rst
> @@ -3,6 +3,12 @@
>  Security bugs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +.. note::
> +
> +   If you identified a vulnerability that only affects a CIP kernel, ple=
ase
> +   instead follow the reporting process described in SECURITY.md that ca=
n be
> +   found in the top-level directory.
> +
>  Linux kernel developers take security very seriously.  As such, we'd
>  like to know when a security bug is found so that it can be fixed and
>  disclosed as quickly as possible.  Please report security bugs to the
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 0000000000000..f39a0178338ee
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,37 @@
> +# Security Policy
> +
> +This project is supported under the Linux Foundation CRA stewardship fra=
mework,
> +as described at https://www.linuxfoundation.org/security. Security
> +vulnerabilities should be reported through the mechanisms described belo=
w,
> +which we will coordinate with our CRA steward. For actively exploited
> +vulnerabilities and severe incidents that may require CRA escalation, pl=
ease
> +use the project=E2=80=99s emergency security reporting mechanisms as app=
ropriate.
> +
> +## Security Context
> +
> +Open source software can be used in various contexts that may go far bey=
ond
> +what it was originally designed and also secured for. Therefore, we desc=
ribe
> +here what the CIP kernel maintenance is particularly covering and what i=
s out
> +of scope.
> +
> +Unlike the upstream kernel, the CIP kernel is maintained with the focus =
on
> +architectures and configurations defined by the CIP project members, see
> +https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabili=
ties
> +found in code paths not covered this way are considered out of scope.
> +Furthermore, vulnerabilities that are affecting the upstream Linux kerne=
l as
> +well are in the responsibility of the kernel security team, see
> +https://www.kernel.org/doc/html/latest/process/security-bugs.html. In sc=
ope for
> +the CIP kernel are issues caused by patches not found in the correspondi=
ng
> +stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related to
> +missing backports after the corresponding stable kernel went end-of-life=
.
> +
> +## Reporting a Vulnerability
> +
> +Please DO NOT report any potential security vulnerability via a public c=
hannel
> +(mailing list, gitlab issue etc.). Instead, contact the CIP security tea=
m via
> +security@cip-project.org via email. Please provide a detailed descriptio=
n of
> +the issue, the steps to reproduce it, the affected versions and, if alre=
ady
> +available, a proposal for a fix. You should receive a response within 5 =
working
> +days. If the issue is confirmed as a vulnerability by us, we will reques=
t a
> +CVE, publish the fix and give credits for your report if desired. This p=
roject
> +follows a 90 day disclosure timeline.

Gentle reminder that this one is awaiting more feedback. See also [1]
for discussions on v1 of this patch. Some issues pointed out there are
also awaiting adjustment proposals.

Thanks,
Jan

[1]
https://lore.kernel.org/cip-dev/2af79ddb-ba67-4afb-9722-85a36b15602f@siemen=
s.com/

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
