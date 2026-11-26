Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.580.1795708910030677978
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:01:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Egs91bRZ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4wNwQiDkLbmXupG8NEYSI1cJoT5FpUwLPnujTisWxNuvzTrX5zrJZDzV6V6z0zXECF/LKm9yQC5GgbE9Jj5Sbz+qXRhEwNPp9AZ9gJsDdi8b9eXIiYVGNc/YKdzWaCmL6XhViMh7q8Zb5X8FQbivvyLRZNd4AIiPbybvXbXdlDL8HNYl6pSbcfIz3nRTll7PXKeiTo4KuzyrFIJEXcwOar6Tn8KBIFt8yr2hHpvjDUUTrW1+vxyKOXr3AalC+vpl8sLjBwnGh9/3AXNrKz0wGta3nVyiTO6MjBnNGHERG9wZyv47oOtvxFKTmKuM+eUw7jRBssIpCW/1l9CQ6fjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV92U2jlKFvyDjzHGKFHz9CfcQFxJ6+0mk3PE/azWNI=;
 b=Wuoz3UQbqE2N4mLV2Uf7RgOB/MrGs2EQLIcRMRd3N3w0Q0GYutO39XOhueMH5hPOpIAUg374gjYEjI+uhw6rtAbN11tnk7srRTdgQOotYGSbrsWSYV7M9aAF2DCIWU4bcEX5te+qLQ5b6L9OVRmUDX/XiNBMUIM6wynIxGZDOJBPcQCy91BoOilQMhL0HDYDUCxKVQYJbh2x+0B4dN+4jMWMgOnj12ltZ2/BaoW6auG/fUu2dI+vxHAecr/BIP1Wet/l5ya0rSHd3ExIxNQpF8M5Mw5eSOY620ZlW3VG+eFr9/iNoCQExEti+jSNVWhTbuiEoHvqM3kibcv+oheUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV92U2jlKFvyDjzHGKFHz9CfcQFxJ6+0mk3PE/azWNI=;
 b=Egs91bRZMofXCUDFBpbgM2pO5p0uQ9ndrP5JjD8PEqudSTGxrhyDV2FC0yvfweCJmAeHgVI6enlhvfmrrEQex1TPabABOzFo+gAtigLq0wDW1aUBkOwtJChkZ681HtQ0DrJMjvPYu4M9/g4kroF86/amWXl/pqx2k6zP2Qa7UGU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:01:47 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:01:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/8] Renesas: Backport audio and serial support
Date: Thu, 26 Nov 2026 17:01:11 +0100
Message-ID: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::14) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 76749328-219a-44b8-98aa-08df4bd6930b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: qI8DwNfOuarIVa8LbzZ64MwRGfc6B4FzYoWG3NbgMWYds6sW2/BqPoDhsq8d1+4ndnAI6+jxUMijdzpyUrKP410TCMPxrsGj+MK7mYygeDYyCPaO/cTYnaDOCn2V0Fdsd88mNL8yXCP5OZt73Xo1N0Cbw4LnsATNiPXZpF0kxLkgXbC9TcotwpAHwwqRoA/L4ShMgjic0CfnYkdHRj8LOhM2exXosPXLcRTspv697kckJCMD1B3BwDDhXWtDE9w0PKiPNlOmCHIcrybykDA7kREE65+pndiaEK3GT4LDT7tpwmpMYKopazbZ0/S1+DLaXxBLJGysCwV8biiqe0opmy+58E7hkK71LE1/17+MX2j91iiu/LE0y0NVrqAQNc4ZdfZP05nUWVIwk6+8jzRxQ7/UDh5JHP9A9TW+YT1CJtNxvCInKIN6dXUAgH1H85T5geg0O8N8JNHn71hRd9+hKL95ruJa27ARdevMrEG32oJ2FpYl+/STqaopvH/2MWkzuSxaOmGeSUXCf8oLmBN6a5MOzQ0Rua5PBe93KlEuCX5/4Rx1o7VVYJtvefJ1cD5GsN56WiomgA3RWXnvfHsDHAIXr7Cjv98FNyDfcOFCBJB+yOYiLeVnUze+A8cUUbvfj0oDFv4cf7obv0h6C+WfRRwRAMDFWlz+E4yKTWHK8GE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WcAwBhqZuoY+UCQMswOjMfM+5/gDP+jx6tfojtY3OBUlLHwroOHPNWsKn4oH?=
 =?us-ascii?Q?SiggPYTRsD3N5Sp8Cx6SwJcdQtP7IoCj861DCotAEM6FYsO//zMlWO99PDpv?=
 =?us-ascii?Q?gxhnPOhY9TbdTKWD1KAb6Q7dI5E6axdU/QXaWSqjXQ4K8oV+xa/GHmC89qKn?=
 =?us-ascii?Q?6utJtKuXY+gPuDxpuQujr8AfXDH2qlHNgpChWCcYISYHhFyrLMtEfOnBF3DP?=
 =?us-ascii?Q?GKvy31nmrJ9A3f7lAzdyT9hsf7jyXL60YZc25tzsmeZOTj/uawWS22YJ245W?=
 =?us-ascii?Q?rSz6C7oiLn7sVczv5KxDcSlcLSWTFey/xNRSdRpn8Drqwb2bdrqZPpmeT+Mp?=
 =?us-ascii?Q?W8SAtUAAP3VkDpushXWrsfVkCLqE6pMBMkakKvROY3FkHgnMg7+F4pw0XGW4?=
 =?us-ascii?Q?V9ZVyW44BKN2TcH/dSfWLmORKNhgnIRL4JSLRj4l8OLdTzacrCHfiBw29Dbt?=
 =?us-ascii?Q?n91Pde3gXusl03tRvZ0iAp3klsInKOuor0Idz7pkO5yd3jXayGjRVNCYPyVo?=
 =?us-ascii?Q?VPP6jqGEwJHRlmcaiUb6IGsJJVNyYePDL+wPBjfQ0WtjIQJZVoC3v2OIRKXU?=
 =?us-ascii?Q?GG1AeYzy7DoHkbbf32Z/mFE+w7wSQ8M3e/UjMqnwk2LcT2CPXf0imt4QhSfF?=
 =?us-ascii?Q?4ey67c0S1bPNUXhOva2GwwJXdlPSMGDmLbEXbJidoJbkY5BYqSAh0rzxfe5A?=
 =?us-ascii?Q?ICWd4F+OTkb85RM6qm8cgEj3pkD/5NhmVlaOUwBLifwru5sDqIvBssDilWlH?=
 =?us-ascii?Q?XqcUVdQ3Hgzz/j/jpr7v+FsAXmpiDzurFPmxeYc7aF0DZOazBxTW/67f1idC?=
 =?us-ascii?Q?1v50QHzPNnglfJOXPFmmxR71m7cj+yAMs4gshpggZltTL2UHsUsENt+5IlU1?=
 =?us-ascii?Q?4TW3cBHSoHaCEIIZrCG7ye8kNA6Gu5Dk4OLuyBg/riO2u/PwgM+FDp1N/c/C?=
 =?us-ascii?Q?8L6oDnvHsO7XPI7R2VxTQxDV9PkBJVAZlihRgPhzW0BznYQuQak8kAhS9LxE?=
 =?us-ascii?Q?XwBgk1bHW4/RNJQsOg1jdg210mHpmh0wF07O3HoRvG3tt/nkrT6gq+K8bk5j?=
 =?us-ascii?Q?v2Ph+4PDmq2nS4ecsG055u91frEruCJkWGVV11OPxI0oAJ8HEeEEW+wQ/IXS?=
 =?us-ascii?Q?NNvuOKAERXojVbbZj1N0TLGP9ymXv+xKW394MU2BV/mNe9zu6FMRxxVx3Djl?=
 =?us-ascii?Q?aZ2MuIoPFp47O+ZUIjYbdCIjQstGgFAK+Y7WDFwrz6ZkUoaQdYxbbmtG1Rbw?=
 =?us-ascii?Q?RF+/xh2yzpf8asXv1+sfMbKa4El2Mtzz34n2saVIgfhss8yir+anFJDzjBB6?=
 =?us-ascii?Q?FeXnh8PDi9/yVZGekCIktFp5loDfRkl4V2E2aIuGIqEFYLVZLzCXDyVe31MW?=
 =?us-ascii?Q?7YNMuQUDs1FcBOygGheTPt9lT8KBPKhnwzCY8MrIsBlDiWPepUFSejiXrav2?=
 =?us-ascii?Q?0K+n8dy4bYoVPmJ8TlwEpYean5UZi332/urdoni4ocDoY6DgPh7/e9ZK1I1n?=
 =?us-ascii?Q?y8POLSj65qJTHASiBuDu0kp8/GxsDUNjCD3fILy+PDb/dsk3qyB902vRWllA?=
 =?us-ascii?Q?xu1ibgqYFbSgVFAqeKEnKr/Qv7CGXQndMlcQDkB/QeY67C/ixyOID3GGRCFb?=
 =?us-ascii?Q?LKYtBq14eMVNHcIPSSDirBV0OpKj0lnnHlsm2sEk8Ha7NkF4STdAIuTBoO6M?=
 =?us-ascii?Q?YzXS/V5bxQTVPRfUVnbVQztxUpvid1jz2+3MsG8juaAQgVVRdOWAJR6NQ9Rs?=
 =?us-ascii?Q?vi/KD2pNRmSvOuUDUMUncsHXiC4RePzdeIfZmfoIiBp93c1wmTZi?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76749328-219a-44b8-98aa-08df4bd6930b
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:47.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYbtRC1kcmndj/Wf13rkuaeUKw0mjCG2hOzB/i/UWHIsGOupd2iELVhoSAHBG/V4CZ3BFaAjRFzpGCfSS9mNUQAobFaglsTqvziMMQUamYUqgvmIoVrNwQaoc8MIdCd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:01:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25215
Content-Type: text/plain; charset="utf-8"

Hi,

This series switches the rz-ssi driver to use cyclic DMA. Along with
it a DMA fix was added. This fix needs to be applied after the rz-ssi is
switched to use cyclic DMA, to avoid any regression. This series add also
rspi suspend/resume support.

For bisectability reasons, this series needs to be applied on top of
series https://lore.kernel.org/all/20261126155545.3834937-1-tommaso.merciai=
.xr@bp.renesas.com/

This is the equivalent work done for linux-5.10.y-cip kernel [1].

[1] https://lore.kernel.org/all/20261126152553.1298561-1-claudiu.beznea@tux=
on.dev/T/#t


Thank you,
Tommaso

Claudiu Beznea (7):
  ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
  ASoC: renesas: rz-ssi: Drop unnecessary if condition
  ASoC: renesas: rz-ssi: Drop the & operator in front of function name
  ASoC: renesas: rz-ssi: Drop goto label
  ASoC: renesas: rz-ssi: Fix playback and capture
  ASoC: renesas: rz-ssi: Add pause support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs

Tommaso Merciai (1):
  spi: rzv2h-rspi: Add suspend/resume support

 drivers/spi/spi-rzv2h-rspi.c |  18 ++
 sound/soc/sh/Kconfig         |   1 +
 sound/soc/sh/rz-ssi.c        | 423 ++++++++++++-----------------------
 3 files changed, 166 insertions(+), 276 deletions(-)

--=20
2.54.0

