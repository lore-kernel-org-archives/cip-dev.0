Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306AC54E67
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 18:31:58 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web10.779.1710527510919015366
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 11:31:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=K5OrR+7Q;
 spf=pass (domain: siemens.com, ip: 40.107.104.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF0PGfsfMpSvms8D7hFvG4y0rFvpsHjY9hTgJxc/S2AN1RyJbqcKINCOYoP1j/EDnA+2iQKkD2O6ZENkjQJOTpMvTXbmiKdMW8K3qs43pp6IxxS2WgbK/9vfp9GDRLLKOHUDrRS4g158XNBpum9slvem4fZ03wJURyhX8KfrYBJshFIW7sYQv+Tay1HtgNsID/DOQMiaeKduzbedHe9hgj1D84ntrdbx79v8EHz6qF5fQKKQ83QeS77MmjVUmZIDcMKAF7c7iZIyrt5Fd1ZV+VMjKTp2Rfd0Kej5Z2nGNgF31XAz3sElA7OZ4gZNKH4qKaw+bX/BJbFeOEcIbxYXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z84EcSqOiIAe80gsIsRKnYmxm56QboPjmB5UjMUmd6w=;
 b=Jc27v13rwqvlAx4rQZ39KJoWLvhtykK+OE8FiPDjggeCATx2k7b412LMhXMg7S1kq2jOMhCaxNl9usr57po2qaFkdJj8pMlnQ+5Od2UvaCSslzWd468vXetXzGtcpF/CRT9sP5qWGtGzkZr9DOCf8/Z26aX2fEHvR2tDzpXzGIUr9EO/qEjLhi8ySEpkCyzNkKxmUmC/NjjmpBKqPCbzMbznYuiJRqoiNzhSn14tX2zqHzn2/2ip1FJ3IFmv/dI1zI7iFRKiNCMNyB6iaZLhIuu/ncoIBBhu9RQZqCyE52K+jHGA6XyuIr2OJDP9QHeHStRF/0OhGPzyrxEbBoEipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84EcSqOiIAe80gsIsRKnYmxm56QboPjmB5UjMUmd6w=;
 b=K5OrR+7Q6NmLnM3OyMY6pRQYCe/pEEZYmdSuZJX4N2z2ijpof6wFvRMaxtEmxDBg4vqmqR2ts9EXNRBGFISiusgIQoxvl+RjF4VdSbH0F0a/CxPwZXlj36NcSeQwRj6wGNUWyen8BqYR9J2mgV73bJm2F7e6oHwlzTzxatfQUlHtIwCdohV/cokzd3PcVPOyTyZorXfXOP959ztG4tFavIJWMrzckprN9YBrxIATiT2sDnDJZ5xslkQAPgOxjsDsf9Xhvfm1sY56L/ifJ3AGkqrTTOuLX4VbwiGEjn4N6JPc6LL4m+e6Sx7v55wxXGYT14e+3KUDfvTYCxumM3jkZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.38; Fri, 15 Mar
 2024 18:31:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 18:31:45 +0000
Message-ID: <b67dcf70-0141-4b2f-b9bf-8a723d468685@siemens.com>
Date: Fri, 15 Mar 2024 19:31:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Backporting Renesas IA55 IRQC driver
Content-Language: en-US
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Pavel Machek <pavel@denx.de>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
References: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYCPR01MB64784B67B1AD38E99F08C2ED9F282@TYCPR01MB6478.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3689d6d1-bf80-437b-1903-08dc451e2ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	raWG0SWsmfXKnCxeBi020ULo5pOyFJJgpayXEgeowOH8JXRBon06MuONSW3ClfC+/f+axtXbXjdkRIa6B9pq96/YIS26DdhPjxuDQUc9VUEs+YHERkAjI0PGF3BwwmqtjoPJ7jaYFNgJBkWm0WF9SNlw2+knkG+oMKdL9pdnLLgIbhZXxvgPQLHmSYZ4naPE3i2LkhpT7PhlFMrbp+8PvsW33aLTFg75pU1EZvBBrRcFmiJ1r/NcbLyK5+VY/qyXnD8zs3HrpkDG29vA0xwf5GcrJT6twXyREfOlw1flwqr+FReGRPUXTMV+pdONkuCaWT68y0LwI4B2jPP79pqIbGUXcZZ567gk7xul0th//Id3W8J9h+4fS7xuQ61r/M1laxG+yAOvkEC2Ld1elJAfyGVs17YNv6MYueWiADogrB2/wS4Na+1wZwpxKATJUCJqqoET4zOO0mtmK8n59FKCyU5Bq8n8zk+db5GP98wn++r5FHRs2vIXRyYtCOZEZfrcNCxzY8+eUfGruSUX9ZkhklITSY8u6/6MdG5UxQgghBBaa/KVK/nv01On05oWapNTqHN6WVXiqKmlIMk++f9dXEpho0HJX/S+RWwICDGXpTZtcqFLm1inCCSF1ocMbJ+9FZDDwUO+s9uTyTI6omlZgfp+tt/L1nxSwlqJJvQVkcg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5JzLViyayO8SXrisu6ccY+2J4FerSH6U1ZjyGddUJt6NJW3PbhTJd/BNXRYT?=
 =?us-ascii?Q?EBPa85/sSwdZwDkkyo3j0sfxRTgf69Vgp3wuzXP3FZHRi+ZpE0P22/2j/gHo?=
 =?us-ascii?Q?Km7VJw58rvABhBYp15LzG6aoelzQnzoj7xKDWyqhTf45LNdy6Hj2jsxUYsyB?=
 =?us-ascii?Q?lIiFndwre50/yT16XJhqbrSQOeQs0huIBSNelzvyHvOumDrpDpU40UU6ioqQ?=
 =?us-ascii?Q?mmcXCh+5mWs34QOFG4LF8hZli9haBBSOZANMcjHjcbqe+og0zawwCQhNmCap?=
 =?us-ascii?Q?m9ytKnyEr3buL+0Z68hzWb4P2hFwJr9oZiHY6vSey7BzWmF1lug2bvKtsip4?=
 =?us-ascii?Q?kM2VY24415QCIPhokQVH7Iwin0bSp/q9ubGnbGR29xC3Ruyyfo8cby3F9VJ4?=
 =?us-ascii?Q?T8kLHBM1RnNhyiueBEq839d0Y4p/wPXyLSOYZd5klt2Y34OECln0P8Qchoog?=
 =?us-ascii?Q?aNj/ynW6nwpuRii5r2Y0PDwA1vDoKQVgYbqlGEc2q/Iulfp3biJsnaQEcGkU?=
 =?us-ascii?Q?yE3dQgXkf/5HslUt9JLeDrfFJvcX3K1e6OChFMCDMZZAY6Zp9eAG3z8NC5Gm?=
 =?us-ascii?Q?ZURwy7l08PplLq21O39a8TNLbvdRVk+1cSgSeAYAd9GCFw+3OA9p+ynCkh/t?=
 =?us-ascii?Q?UC+b5TYTfpYkTWqkg9Fc7mK0A95/w1y7oeoMul6fOIrOPuKfEBbylH30mY57?=
 =?us-ascii?Q?ToWsfX1rGlj66c0K7lkdWwVufHapK417rzvAmZWCa2uESnlMgyDwhWvA20lf?=
 =?us-ascii?Q?MuwhsqFBVCcxfy7Sg9YySkDekKzTlY+N3UkCTqrwF9gLCTTUTkrNscTX2Mon?=
 =?us-ascii?Q?SYS9zZol0NnTResHM4/NMDdL0getTxP3Ay1uCr8EaVr59IhnX3Tn8qrpRB9S?=
 =?us-ascii?Q?MfZMso5ayzgK8nHGfVFR52bqnpq/JpBFWjN0M8PqXhW4/b2IBkYucC8H7QYd?=
 =?us-ascii?Q?oB634LHmepsmv4bmz1bC6iG6hyYOg3gtdz3thgImRVt7tocANP6txV6ERJvj?=
 =?us-ascii?Q?m76/15W9ZKlsIrmVJjX6/LbLNAPiyXr61rEuBbjMxeomF1fXK84iUSQxvBLz?=
 =?us-ascii?Q?rgAzjjPa58SQFl5Hlm20+rnwSPWwuIh/cgLXyMOsPLCnYqavR0K0JjbPKqpr?=
 =?us-ascii?Q?cnluatuK3jxrsphf3GNbtLecShjQF7Aro0c0JqnBz09dOkIMepuSHos1FNeY?=
 =?us-ascii?Q?F7lZW52YPjHA9glnle5k28GEz+As0F6KuXqULPpA0Cge1OMkGZ/6aQTzifgZ?=
 =?us-ascii?Q?gQ3Rr5+uwzEAZyZ3LWFqgNP9DL3uwhDEsVu9Kc8zQm0ClEresi/rnZ72dz2R?=
 =?us-ascii?Q?MSh6Z+tcZ8UEvBCcmYh0h2qOTAr6ioYX3mRe+Xql1F6rusgpLFp/KQtf4PkO?=
 =?us-ascii?Q?x4qfQBT9uzEodSbSwMCHImXG53x2ODkRUPpghFpydEyk5MOC2ySTpAJWgtvQ?=
 =?us-ascii?Q?FF+2Zu+5T/OwaH522R5qxbq0NSXQAmD2N/LhHCuBypg6I+fwR4ue6tOGLBP1?=
 =?us-ascii?Q?ad5kLdMv+JTq9TyCjJjG52WAap6nxR3cTcz+ATcpSzvj8wfgEknO84bXPjE9?=
 =?us-ascii?Q?sy2QTgIXWlh1hNpACpiH/1sLxlQzcPAHw8o8/3IECSQmIXTYmphSzqcMguaV?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3689d6d1-bf80-437b-1903-08dc451e2ad4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:31:45.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ii8ss4zhXZZsg+PoBKB9kAMssFJXeowAh5WSDRuTufSeal3r54QpUw+T9VYv0kPALcKVg2Pw73GUm/RVYphWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5165
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 18:31:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15333

On 15.03.24 16:18, Claudiu Beznea wrote:
> Hi, CIP maintainers,
>=20
> I'm trying to backport the IA55 IRQC driver [1] to v5.10.209-cip44.
>=20
> The controller is connected to GIC and pin controller as follows:
>=20
>                                           =E2=94=8C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                                           =E2=94=82          =E2=94=82 SP=
IX     =E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=9C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=82   =
       =E2=94=82          =E2=94=82
>                                           =E2=94=82          =E2=94=82   =
       =E2=94=82          =E2=94=82
>                   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90IRQ0-7        =E2=94=82  IA55    =E2=94=
=82          =E2=94=82  GIC     =E2=94=82
>      Pin0 =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=
=82
>                   =E2=94=82        =E2=94=82              =E2=94=82      =
    =E2=94=82 PPIY     =E2=94=82          =E2=94=82
>      ...          =E2=94=82  GPIO  =E2=94=82              =E2=94=82      =
    =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=96=BA=E2=94=82          =E2=94=82
>                   =E2=94=82        =E2=94=82GPIOINT0-127  =E2=94=82      =
    =E2=94=82          =E2=94=82          =E2=94=82
>      PinN =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=96=BA=E2=94=82        =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=96=BA=E2=94=82          =E2=94=82          =E2=94=82          =E2=94=
=82
>                   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=98              =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=98          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>=20
> While working on mainline driver, my colleague, Prabhakar, found that the=
re
> are issues with this kind of hierarchy due to
> platform_get_resource(pdev, IORESOURCE_IRQ, ...) which relies on static
> allocation of IRQ resources in DT core code causing issues
> when using hierarchical interrupt domains with "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>=20
> As a result he run a cleanup campaign in mainline kernel and changed
> drivers from using platform_get_resource(pdev, IORESOURCE_IRQ, ...)
> to platform_get_irq(pdev, ...) (see list here [2]) and at the submitting =
[3].
>=20
> Now we want to backport the IA55 driver to v5.10.209-cip44 (in the first =
instance).
>=20
> At the moment we have 2 working approaches:
> 1/ backport all the work that Prabhakar did (I counted ~80 commits)
> 2/ change the mainline IA55 driver to not use the interrupts bindings
>    to describe the interrupts (see [4] for the mainline approach)
>    but another DT property (we have a working version that uses
>    interrupt-map and interrupt-map-mask) and adapt the
>    rzg2l_irqc_parse_interrupts() to do the proper mapping
>=20
> The issue we see with 1 is that it affects multiple drivers but not only =
Renesas ones.

Right, and that will raise the question how to test all the others (a
rhetorical question).

> The issue we see with 2 is that the DT bindings are changed and we don't =
know
> if we should keep the DTB as ABI: should a CIP DTB be able to work with a=
 mainline
> kernel? Should a mainline DTB be able to work with a CIP kernel?

Upstream DTB means upstream approved bindings. CIP is upstream in this
regard as well. It's already a major PITA when moving from permature
vendor bindings to the finally approved ones in upstream as it may
involve both firmware and kernel.

>=20
> Could you please share your knowledge on this?
> What solution would you prefer?

I would prefer none of them right now, but I'm neither the final
authority nor do I have a much better idea yet. Well... maybe there is a
way to provide both existing semantics of 5.10 for the existing drivers
and the new own for the backported one, but then under a differently
named interface (of_device_alloc_nextgen)?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


