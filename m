Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1368EEC0475
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:37 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14394.1772529808048781360
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DzRBVMSk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtgPoWz5BRTO2HIxZj+N4+8plh2sbD1aYtnBgAW07WykjblRzt5y/YZGVIzkz2OmMg+dhA3+/vpSmxtuS3UBy3fsXnWo0DBXjiWZuvV+tJ7eMwpUccgMEO8IicY5sEDz0AlT8cVdg+5SdBDczUWyyfipBGWNVclLEtSHZbBD4BjW+zGIgoVvqXcRrbJviolkTlCkQqAFYwj6sA6QDZDUPQECoOBKXbxMZC2mdblx8huuim3F3HW2Wscpuhc9O7l1NCdHjLJREISeg2Rvjx62WkojY0CQIyCwOaX3aiJMCsvSnMLWkrElIqzmV2CPhcCMnRm0aGvKNs4Q0fM+7jgw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMONWpVvLXboKTfGrwMcLQQOkhsS8pVREBLPG08syAo=;
 b=wpYz05vSsmkonJfj6oIkdwMVGhw6jRQtmEevdVYpj5rZds8vSe7JE9HOtiAdoqAelhDwb8P7nSp5yvW9tApEPqPy4UGPRvPeqW+L8eeZF344diHtw+aO2yDVB21PgO3B+lu/lKMabvju6MOsMqIVcRYNVeUMJBh2gtThUlIPHFf7yKNlqHQ7s0e7VgiXv0vxwAE72LJYbHyb7tnAV8xABBJVFTk7z9wJ8nS2EM+kAEZnXaKMkA2qooPzneFzs9A9dLU/DHrZ60V335WmlWyy2X5Wqdsukr2F4VusH2C6ho1OfgqQFDz4GUt9Ey+7BoME/JK/XBI+DJ8Ps3wm1d+O0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMONWpVvLXboKTfGrwMcLQQOkhsS8pVREBLPG08syAo=;
 b=DzRBVMSkrLHjsjWSDC/00tO7xDMsu3mDe9FoiI2rie9Mxwpm9LJkq2EtH9r/r1CmllQVyJdIIOKPXP1MOEhFiImI5RYNyN0CPUMkomYJClw1O8MlmQ2NUmxcWWZBnCZEPWwow4PESbWXNUyNp4NBMCJE8ykv5JF+mO346CqrWNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/7] i3c: renesas: Add suspend/resume support
Date: Tue,  3 Mar 2026 10:22:52 +0100
Message-ID: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb416fb-48ad-46e5-3646-08de790684f8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	jf8VNPjFboKi8c9aMRAmhoFzpia45d8xZ7UzelIHdCzNUb82OxApISyZGLeb1PNGqb1KAHh1nXN+K1eeylBXf7OSHj9gcqaxq63LFXyGP8juh4opDbk8Ygdl9y00NuA+s0Qlk4o+Ic6/0Gc3mXt22wPHhqiffWijO7C3OdVOl46vY4WUUVTkwPAdUYsgRdBNf+MY2qndhr4d0vAPxfhGoclyuS0rIs0pqF0UCiug8WHeCaq8e4eQzT32RtmB11lsHTB+XEblHi1mCMU1UbKEnqla9MH2Q68tQQ4tnj0V8+asn4/Gkcs2uBWTmLvJWt8wo8yQv5f8+4GteNiW6U3MVavYb4FQZxFAu7ciqqR9g2aEjWV5WPOStpUuUd1iqX7voUBwggpLLSOvZtmxGl2fVj6tFCzq/jE4D9khPmL+64UN4u9nbkqiWvVAGbzMT23q8X5dQlOBk08sOFFz3DOSkNmdY6L4HJRyh5x+b4TaTizjcyc4qKtFs1PZmsMGrwXxefcwGWg+HMBd9DoKyC8fHqrVkYw6PvXYYMMMDzWgZkE97Tx6fwjhyRJqcdGd9smM8aSfDAhspKHn7mmdzpnBDCVP5KLSz/z65NmYrbnNgMkM124W0bQ7VcI0cIw7SnxRF+G5A/wmKlpxgUMksN94UdBRHdVPCA/w2kWvZb/k6CC9L7JAFU1cLs+uqo0r3N9Uiq1H35GjCAmgYLt1nItwshAsKkey5SayZ+mCPwCh9OqS1M6zTwrypDQd534874sx4JR50EPQTTYWaXfeoqpDZlvXQ6aI3NAXKOVuYi2sUAw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CT4c+ECqTVEwmEMvF1ZJb9EKGTPPjuTMzn2mJjSfCXylyZeexepp9sQSc8p0?=
 =?us-ascii?Q?43Gzt/oZSJS/tfttj8zrEdJMhUexf3JZ1lhTnS1T8WESnrcAKH+jaVlXKp5f?=
 =?us-ascii?Q?lgfitAFBL4l3SuneWffRlP68CCQrl5f9WU7bI2lgPt5yTgwS4kbM3WyimTz3?=
 =?us-ascii?Q?4OJKeOi4g87tObIXq3y0TRYojxWLATsh1+A1CIr/DV2fokeZYlvJppXpusfz?=
 =?us-ascii?Q?hCRkPmsK9dfFVtEUVntL62kFjTLYQiMFU0L94F9V3rttOUre6eCEi/fVPJc5?=
 =?us-ascii?Q?qUpzOvAnhm2YVceR+usFoB1zfW/15c/ABnnNYzdQ7lxu8Pyrv2Wk4NUOp7mJ?=
 =?us-ascii?Q?4P1Po08Jv95iXtzhDr46XfovCUZT4NrjCAf3GAb66th3yAhTLph6bgMqhzdc?=
 =?us-ascii?Q?lXjozSei/aqXCgVrqXF2XfvvAV4HKU9LxNN6c0AFFWXEs/ei7Q0HRDptCbpZ?=
 =?us-ascii?Q?zt70qZ+YoQJJAVv8tQL06d/ooiKK8AVsXXE3MQ9KHkRLST2VSrc5XvyPcgAn?=
 =?us-ascii?Q?D3xWoTMkkkAyIo1xtE9wlzIhuqXJqYEURTJLUmqreGP4DqBksQvYZjeeXPQ0?=
 =?us-ascii?Q?3ButCumVxtg5zfgQOYHQldGz2anBVPtBNQfBjzSak22TReEm4zktI9IoHR0P?=
 =?us-ascii?Q?XSc8hXRnTYCeP4Dispc9/u7H4LqXx2/2QgGRNLOpls+Ik2KpOzioxyViTNJE?=
 =?us-ascii?Q?NheIwUkI904FJfBcuZRkyLfLdew83CCii+SgDjJM6LSnlc8fSQVFtws2WsCV?=
 =?us-ascii?Q?1LK2hN1owOcZCHp4952MknZATcefGkAoZyJJVdxF/SnmRhkf1sZpUm8tJfS7?=
 =?us-ascii?Q?jjsGAML1vJEkXjM5TmHEuPzSCaY8TnrequfvhYhffncYHZNQM4ds0Lb8fYIZ?=
 =?us-ascii?Q?gPp2XIPsI0Qa7hoXp8T0l9P81soKxdKtLZ+vSl57J0oTeE8UFLK2dlDYLC4Q?=
 =?us-ascii?Q?aJkZJk0UJfpFUyAVJR1HoRs0eoqwBH2SCsF1U/Ce6dF29aGfd+QKlwcmuBo8?=
 =?us-ascii?Q?5XPdBvN56yloccV/sFPN+Ift1CVS5RPraYZVwlBM4I358ArckTPZn7Y3GwQx?=
 =?us-ascii?Q?CsN5OFsNWuWmVx4obFUGYkDHiH7jT8UN8w4gHC2PMkXweuEaCBbDnqxouAfp?=
 =?us-ascii?Q?Pd94f5KaGp7duu4q40OVsLVhmVIXPjQ4J/ueHwg1YBYw7W7VbOgFXUcG5FN0?=
 =?us-ascii?Q?2Ncq0UNaKDUws2FY2Pl2171uLJ06ZKwioR3yh5uAHC4+EAI6UHKuhGDetCJW?=
 =?us-ascii?Q?4ydnnvr6mZdM3xRPiwWWko6wFl6JqYULEVEbfQhLd2TNNUPE8m/2qvWt+usc?=
 =?us-ascii?Q?dWKbgeZwf8jSvx89+8VPkaqVCYEryf2Ex1CV0m8dg8eGlACkwHmOcZVfMLSd?=
 =?us-ascii?Q?rYM3yxgNOLoFS8MU3zWC6JaUAae3TgO/A8FVXOHxwm0wguHamQtaemHCLUkk?=
 =?us-ascii?Q?GeczFD6DtU/0JTPUPT6o2WPTvtelqtKzz/YU8F9uGD1IWhZvccpNBPWVeh/8?=
 =?us-ascii?Q?fkZy3uH0Viohg/HG8DZPaG9kwhqGiXyIhvvk6rLGA6eANQbRx9a/vfsCdK6W?=
 =?us-ascii?Q?oU1WxOJSOrg7R5KCn+Rj3i8ibuJRQkdjsX9WSyGp3GbLW7bhqr6lsf7Gevvn?=
 =?us-ascii?Q?oLbwCgEUkhfbv2cYxSdyZmDfVq44AueoDv4QQdhClcgO83GjFcKcA14sbPzs?=
 =?us-ascii?Q?27hyhFpCAAXS7/XsGLOmKp86dMDETGsKBTgE5Df9V1Rz+qiaE7LwrJ0cMFEu?=
 =?us-ascii?Q?gOh9ZdmOcr4m8iVEYwkCjRUMfCm+tm5N1yWf5steYoUYj59Xi0kO?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb416fb-48ad-46e5-3646-08de790684f8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:24.5800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7PQejI5AViuB/FRaXsTPjHk6Y1y8gYdww05Ym6d2hx6d1Jgn7stQ55GWGqfDknMvS2A24AAXUZX23iS+chZChuZu/BpnaPeZXb5BRBsXGpdTjxRL3uOpnidxH+GN5pt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22051

Dear All,
This series enable I3C on RZ/G3E SoM and adds suspend/resume support to the
Renesas I3C controller driver into linux-cip-6.12.y.

The series also includes patches required to backport:

 - devm_clk_bulk_get_all_enabled()

Into linux-cip-6.12.y, which are used by the main suspend/resume patch.

Thanks & Regards,
Tommaso

Cristian Ciocaltea (1):
  clk: Provide devm_clk_bulk_get_all_enabled() helper

Tommaso Merciai (5):
  arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
  i3c: renesas: Switch to clk_bulk API and store clocks in private data
  i3c: renesas: Store clock rate and reset controls in struct
    renesas_i3c
  i3c: renesas: Factor out hardware initialization to separate function
  i3c: renesas: Add suspend/resume support

Wolfram Sang (1):
  i3c: renesas: Simplify return statement in 'renesas_i3c_daa'

 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  14 +
 drivers/clk/clk-devres.c                      |   9 +-
 drivers/i3c/master/renesas-i3c.c              | 261 ++++++++++++------
 include/linux/clk.h                           |  21 +-
 4 files changed, 206 insertions(+), 99 deletions(-)

--=20
2.43.0


