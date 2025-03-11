Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64030C28B2F
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 05:52:17 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.59])
 by mx.groups.io with SMTP id smtpd.web10.2285.1741672335563306990
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 22:52:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iBTZRNbw;
 spf=pass (domain: siemens.com, ip: 52.101.66.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVkgItqiTzTO6NL5DoIJavPQy0Cxf+Qh7KOPgVjIq7j6Z3uQpEd9DfWBKxGGUCauFArMXWeskHH8JM/a6fY2eGaRgD1i7TINKeMv3mG9ltsgFmEDy920lSCSW/Dp+io8mBOp4hlAsxi3M8dyZDo6RpGeIbXXoICvnuNy9jVLnSCgmmlpYPX3Bc4+fYR5rUTjDpzMMUlKAco3a7zKjP8uKTroG2dkLuixYg20YzSKJm6AToCPIkTxPvdvdgyare8iMvuLr/xNcd66Ewp7ql46n/R945LBv4vVNuSaKPRDIsq8LZEOUL65FuMMO8FIFyVmtLPT7RSz33JSRMVL9t3/qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QojXG6cDMbr5YUHfKecXg46N9PpmKx46C6YQgd6I6E=;
 b=q2+GEtps/NqSLQtfoBmLC9gG+WM8udcO/Vc3OLuKc5KBpwrWTkqDIaYS2jArL1kEOiYdyUbdJt7Bh9ywla0Eg1yGPwApEzhCIyWr2cw1oKiLJc4jk1u5JKQE/1pGYAwcSS4sVi15TR/TEVZjE2DsuEtL/xkB8fZjKs/13MpbHzErEZp1tDl3fZ5yXr0qy0PiZuqKi3qptNe5RL9ElEHjmPyKpkFH1DxUTBS0OERnHKQbgitVt8EZh3WW3+01ip0L2bgqXAW7619X+3OU6ZdLcHWi5Ogyz2fj76JpA7qRIxmBpBtw3iLvvfnw9GSzGk9ni37UZ/Gju9w3VNX/yF6neg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QojXG6cDMbr5YUHfKecXg46N9PpmKx46C6YQgd6I6E=;
 b=iBTZRNbwjQG1D6omWuqYIQT9BiosvHFYtSFvlTQWwVSXomWUMAQVqv9xRxxoybHd4Jsk1PaYzQvL2eBWCf1j4hPzj1T2H6dSLA9YzOw2mAr8O2g3FAZ3uZ92mcVnmrWNEE6+fbH/tL+9XGeGTF6O7f+QGfItagrrtOPvuVDEAv/f7oqPtM6TQOTSmW1aiLEqZ8sm8Ja9wa9OR1xEzRi5TbV+CTWzrtYQSZbny92EZmKozwpj3/5R7RMOZyYkKr9jTDJ3BZepD3H8JtdCSEuN+nSyvZ+rq0wuPEp0u9FlUA5QYmr7ipqvR/o+e7kOsoXlzJIpB/TMyMZjdxWYIN9wsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:52:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:52:12 +0000
Message-ID: <319c1887-9e1e-4b99-b122-426ae59148fb@siemens.com>
Date: Tue, 11 Mar 2025 06:52:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
To: =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
 <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <22f01b35-2d08-4b94-bb72-37d82f3b21be@siemens.com>
 <PRAPR10MB5422CF6EE9F9F1525D8F1CFC80D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PRAPR10MB5422CF6EE9F9F1525D8F1CFC80D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 5474db07-dad6-47f5-e8c9-08dd6060de31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6Lxc7/atSVasZCi85aV+YaoILdn50xy176OqsvuAn4I9TTqO3PMu/Cbt6f0e?=
 =?us-ascii?Q?xJcbVW61hI4vbcP6KBQ4Hnt4tuhI6rMItyyATAFlrIsv5qsmBWFceFkRkO5x?=
 =?us-ascii?Q?uIfuFQp6V73C6dfudJGt1hILwykBKwY8hvxoV5DWZ1JEYWsdPTMQrpKSKx76?=
 =?us-ascii?Q?g/B178orul6UKN5VcCGQCM+WTIGCLTTdf9sm20kEUEOT1siOO3Kt/bdKkEwc?=
 =?us-ascii?Q?PAherWCmISJlwuEoib+wHOEOFmzcuMs/x/xwHhnKumicsvy991FGLAKjglMZ?=
 =?us-ascii?Q?/sBhWEszc2WmCVbKGd5DO0tKPmzXmxzjy14yAVahwOdVCy4yoQRPiG4sgEd2?=
 =?us-ascii?Q?rRCX1K51m/6FOQV5b5ydadVlpmUF0KHBA6FSEgGmLXPZw8LkQH6KVrSzrtoh?=
 =?us-ascii?Q?zU7axulIRo+DYKFJ1m8K0rwHND2ojMw6WnYMEy+csiib0qQnVozC9rN8O+ie?=
 =?us-ascii?Q?n2NhNLvHY/1Ni52RhhPn+/LW9l15usLNgkLOqaBS9BMRjYdyZyiGg8DCxWr1?=
 =?us-ascii?Q?l3RmXL2Moz3GfDtt8x2YtEygmp5Lv9D6AidwOVLZYWpbowXBaUcor+4VZsW0?=
 =?us-ascii?Q?w++bmi9onxPL/zdkPuCtFNSxuBPRUyhrRFVJ1AP7UEt7ba7v3bx99dj2/qqo?=
 =?us-ascii?Q?5Q0N9bMxuCg4NVBaeRo7jVciAhvAzcNik6wfGqZK8UmMvB3k+a772hpdLH5s?=
 =?us-ascii?Q?xkEfOjHNV18gsQUd/jQWJ6Ic/lS8j+UlYlF415+lUfQ/Fw5s5g70PNnJtARp?=
 =?us-ascii?Q?fekt/LZ7f88LpoMBcAew9aKjRXUbX5BS+qHz8dA/GHhOAMvXtKsQHP8dJBn4?=
 =?us-ascii?Q?ZYe4FQmuMa6rNWzZ/2YaLaYNjrT7kfQ5d7xIkkL6pQiig36z6zUEjUdM3+Sy?=
 =?us-ascii?Q?7xqzvcHnV2synm7Ore+m1myI8xzfCq2n8PnX/qSczcsT/xl77qGKCoLmXgzU?=
 =?us-ascii?Q?7TnY1SayzItkyWctwLXroOyM1iEx+wwQV215o9dNL4w/K1pnjqDdsqJjmC8W?=
 =?us-ascii?Q?8lZuz9M+Dh5PWjymCy9xAWdkuJSXbBS8zozw2B2gKNTW/CCyahYFRCcLWn1O?=
 =?us-ascii?Q?e+EsQhXb08mSwU98NwewhPpz0SVZpk5u9ILLcKuvpVMyDiKpKWloyqIpM+do?=
 =?us-ascii?Q?aDrY4Wj862E9C8AKExV8tLmKNjJ4hoLCxbs+1oK+XrMpszIyJpCc1lDPExQM?=
 =?us-ascii?Q?C9XgRuFwnGQ2dsl+dF9juC5715ZLwjFUZh46q1cJ2ZwMQaYbJebg4Er7aSJI?=
 =?us-ascii?Q?vuJf/LPg6fnVydj1wv+kBEwKgceHWXLcYSsrhjIr36gDNMK87bLPO/GZHRWP?=
 =?us-ascii?Q?T9/YiEtevY/4Juz5uMk/NPbSn17x5EpA6V5G7Ib5mDUEFw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kFj0uzpG7j+9wTK2im+SfAc752C+ZkQXGX4EnImgnYwqNnlE+GoaZJL7RF4m?=
 =?us-ascii?Q?R6xD9TMHuGIFTGkTvH46Tkf+7nVYNpOmh4VtnpWsh2ctGI2CteMsYNzd75LE?=
 =?us-ascii?Q?HGneyqxaqn/paCxAB3z/X6BItKhcF/vfD7FiDFEaoU8LFkBx/4Esj2oZ4BV4?=
 =?us-ascii?Q?Adc7pG4+HdPAk2dLHYVKimFbpyBqQLpe6RUIPqt402nGONkLh9ZqYIO+FXBJ?=
 =?us-ascii?Q?7Q/R0M6QkiR3uVP6R53/+dBzM+ihYFCF4aHcI7tjIKkVX9BDzq7I520SlxYs?=
 =?us-ascii?Q?xmm5hkoyLqq9ue1Ff6WcKi17ca1AiY2Qy0Sp+FuuVtmmTlPmkyAvPdiq34bj?=
 =?us-ascii?Q?axl9SBqkWirVwElSqNpzc9YJaGZcpVgVc7kLnIWIt7V+3JKR9Xa+qx75EqaZ?=
 =?us-ascii?Q?nvXvCgo2X46BNItP6QWdk1LIi7uv6/5pVbeBp5j/TjDld/udjHs5LcMMOWZ9?=
 =?us-ascii?Q?RrtyDkeeo8NU5gwoIcKw8ckZTduVTE1rNmYr5U+z02i993k2YXkNknSZjLUG?=
 =?us-ascii?Q?KtJpD8p8A91dQpN2hLz+c4qEePgs6tmwHQfZ02ITUGR4Lc9FT5Zphj4KbqK6?=
 =?us-ascii?Q?ItQyoTbGhnKKi+mJ/a6Sm0DkjHkI+OP2kC8elkIN0FPq/XwrklvBBLlu6Y8F?=
 =?us-ascii?Q?Az5C/n1As1C4VrLoDLHwlOd5Wk61yi2135mWbLHcl++jbCT4dnYDkouFGVPl?=
 =?us-ascii?Q?YAVb/L6x7GPzjs5ffhLBs2L2x8q03OvmTx2Cqp3LBmsFmSSZlMaVcX3N6gXP?=
 =?us-ascii?Q?riLRLI3WbDF/hO74oEqQ8X79h16E4OLgWUzuJuta9P7oeO18LpwkKfxYsGZ/?=
 =?us-ascii?Q?X/s9px4jhSbslPa8X5LF5vAEJ1AUYakSCfpftkK6u2OAVwBVsJYu434DQbCS?=
 =?us-ascii?Q?sxIXVfBZIKnXnqxtsgyPZa3jbfTAIBCQKmZRu0BWkWByHzvTjUaap5QCSMBD?=
 =?us-ascii?Q?4vcF7ITJWif3Vink2KLDd8JFMJAvMjj6b0hnqA2Jhb6GW86jRzM6Ivm6l6gi?=
 =?us-ascii?Q?plPDOxGbfPwOejj+YZOWQtSgNJ0XGtDEZrkUedw6/qgPOuIG0VXSEinsoVtI?=
 =?us-ascii?Q?ndy1lKV91agcCdxWBV/LoItimfzWItaKOpiDO2MJiWeVXyno5wXn1aASvbHw?=
 =?us-ascii?Q?+ZSQnUf47kSjOlJ95VGLAfJ+pZ99EHsmb8vTJLR45kKHvo9kvKkFvAzuwuIh?=
 =?us-ascii?Q?NfSk3WnpAHofh+qK1ZbhZ5JElxV05MIakSzyZHC78G4SjiN/PVwnCkBaqwKi?=
 =?us-ascii?Q?tXOMooQJz7RUzVrGsySinrwMsTvrZFrt4Yue5JknuzeTaW9/NlJF/MzRgeib?=
 =?us-ascii?Q?Wcn01dEVqbhzqVAXHjSJIYF5g5ftOnmIAgVYda9C8NuDIJCf1+xyIk1wLyjA?=
 =?us-ascii?Q?VPnAYCaK1vj/f3lyYwLMoKNIkhh7eWteb1//igNwzLE5X7/H94z5Fx5ikHCk?=
 =?us-ascii?Q?en7gVFBdStI6ERfvUvyBaCS+Y5sbS9ButP6YJO3jOhrB/VR4uYYPbZoes7wH?=
 =?us-ascii?Q?TR3On/y/iFmUXLgrBMTt/3YrQXlBbYHI35ydkUntStjzqtgOZBUH6eJCSYaZ?=
 =?us-ascii?Q?0d6qJ2GUuFmurrYO4qRy5ix7eHmgWYOWNHi7mfNJ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5474db07-dad6-47f5-e8c9-08dd6060de31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:52:11.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UmFecDVi3TlJKyEjqhcT1qwEYk8KTTKB0MWQIrSPWZZpdMIL3H5rrOLjqn9v41tIAdQZpZYh5dQoJL13lbSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6923
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 05:52:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18082

On 10.03.25 23:14, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
>> Now we already have two users of the same interface, and that needs coor=
dination. This can only be done upstream. So present your module signing pr=
ocedure as well. Did you patch linux/scripts/sign-file.c for that?
>=20
> No, but it may not be necessary since sign-file already supports detached=
 signatures.
> I've introduced a separate build profile for that:
> https://groups.google.com/g/isar-users/c/QbSnth6G__4
>=20

Too bad that this abstraction just talks about modules. The signer
scripts should just be identical for both use cases - and it seems your
solution in isar for modules is already a bit more generic than what you
proposed here: configurable hash function e.g.

Let's generalize that signing procedure in isar, introduce efi signing
there, probably to meta/scripts/lib/wic/plugins/source/bootimg-efi.py,
and we can simply reuse that here for EBG as well.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

