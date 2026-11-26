Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.404.1795708432042835775
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:53:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BRlcikZ1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/Mt8jJmBVINmIbehfwbNQNm0+YZSC4beCdcCcPTXNJ++cZYhgxmNQRvgy9/N2rDXBoerjDO2v6bXF7iw2+9IzCRgaRlyEP99FKE3Z/1BiYF4YJc5F2MpvYR+BZBmstounL1aKkFhxKLDZp2cRPBiWn309J4K3gPoEszYbOHto/YNjT4FwXGP2bOcJg9k6+//bWyGMTNYg+0lCzUAZGlhlAV7B36nDVuOOE56381zs90oyF9/vmW0lW7vGL3bAJNoZC5faIE5yMt1FGFCXO29/XPxcFlXHSmQ8SeTcNPIaS3FV3FTEOKfLUP7RFFvTjCEuuxz7xiftY4rJkEGLjhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeI7JwzuXPbPr6/EEl62z+gtDNwmBpWrlPoR1kp8Qsg=;
 b=EdFas/4r7/WNEALNhLNBhpFQT0iqcT7GxvQV9YAS7Q+PKXrBXpzeU8B8rGdnoIqcUmrEqmkMCYz4SZP5Wx/kotkcRQre9VHQoT39B8AB70bRMcFRf4RF83G+Wc1/ntYMYTty8TU1w3PZ99/qM0EQVug9M2d3MdN0RJw0ieZBjUUxyaJLLkdND/gCmarxLjpJi67b3jOenXa0iCg/LX8u++fQtWdfZDJLMN0ZVc4n4bkB+zuSg3a+qrVAYNbI9tVcP8FaPPLvZetCPI/xZQiiTHqD6RAupQp9fFWPSt3XXi5hBum8Oy1+vAyA2JXl6edRxzixes0XVg9FKlzOAhR2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeI7JwzuXPbPr6/EEl62z+gtDNwmBpWrlPoR1kp8Qsg=;
 b=BRlcikZ1OW57xizl4iRiq5jqVxhvnczTUoXTB90owznuJhi8+6hCvZa2rURL0Eu4HiLOcgE0yRfPo7uCy55Kq8F8y8a3fGSZ/iTXSgLydrcLAcobe0Q08O/elh79BOKTbMzIlOpTLp+QSGKtcNwPCSl72kyS5lzkLUQynev5VlI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:53:49 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:53:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/12] Renesas: Backport audio and serial support
Date: Thu, 26 Nov 2026 16:53:09 +0100
Message-ID: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f56053d-f006-4819-3ee6-08df4bd5761e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021130227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: MOlN1qvY2o3TcCWE7XnSIb/gMXnAL9S8YXsPcHdxAhfllDqJKzfZO9dGudndS3RURxDQh5WqkUXMEXs0XhLA5MwlFO5V/eEXoI2LY0J1YGobfaMWpBJ3n4VYpYXy0qmuiaU2nePqt5a9aNDl74MAIpP9/VYggb4z+aG9r8HAFFzyYjB1OXt88B0uky52gb7jL9k0VC+v/7pUSyZNkHGHKnwaC8c7ZeeSWEd5VaW3Q0tU5uHvZ46Bmvi3tmQbTxabLUhlYZ1bgqeRX+EEVA9GpV/t9FYj692kL0AXbiRpjm3M28dQ3z8j40Ouetga3rfbOTOsTkkh01KfC4Ovr1nGtT/CTak3WeSgIYCJpfMFP7ktUqoSVBXl+uhFszvf5q6MQQhcd2vpP0ZCXV+O2dJspvxhKy1lVoKil6lXOrcSclaiIxO1zhW6JTmwKfoCGKm60eYwOjpnv/EvXRigYH4X9Yy+TjueIb8quJQtMbMON9c7YA6CZFsav6pjXwWlZTALCBsekWUKT/aYhz0j8VckMw7ptHuzdO1yNPG2amkQ360hrdN9OhHJ1XW/e5aYmVhdlrNbIfaEWsuwftZsvNrZgVtFIsljWDnaCX4ulGflHDT/oJRiAMn2T0loj1M+IXYB5VaUhi/DrSJbbYYtpan90FISLDFYDxW5HroZMqvsT3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021130227099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/bft3/OASOgseu0SH4aJEzxKDbKU43Wl2YGhzuVBRItlbaGJ6mi5vSeu+rn7?=
 =?us-ascii?Q?wPHp14a4oqm1Eq9j/Jxm9Snfrt/oAu7/iuOSlMACULfLt0SUf8cAZhYm7jBx?=
 =?us-ascii?Q?syD1FbB/O5oHmy6v/TljoqDEy0Puq16z7xl/9D6wlee6BG/FSqF4r3EbAtfD?=
 =?us-ascii?Q?ViSckjaHPGyIP6xAVcdGCHEbxD5Ccz/gW7Is2K7V8OYNJGKQn2Hefn5sNSYj?=
 =?us-ascii?Q?MTUvB1Jax7syL8m4KC18GZGZyxECnSzLZ/ZBp12qS0nBtiC9wQoGUX9RSWZA?=
 =?us-ascii?Q?qYj2gIHeAjBdwfG0FEHi9vrBMwOlgwhmOq1YJt+JEMytYEpm7goK+vDmNLxw?=
 =?us-ascii?Q?Hv5/XmpDe/IDqyvfMexGMjo+f9qjV22MsI4aEk2wqrgBjDrEdcrTDBlMxCx/?=
 =?us-ascii?Q?YT1tbKCAmrjXEqTHCfhjJ93vc9l0CSzeXzbjJ5OTiMPEoLlnxeXGD3rgjbaQ?=
 =?us-ascii?Q?G8jKu8DW+Qz7a6v/asbM1XX7GySrX5YC1ZGYEb8/Kgd73pA3O6SEh/zAflj1?=
 =?us-ascii?Q?CbJyJMONJJVe8IVCz+yaLQXQAo4xNhn157E5tYWlJ5ksxN4C3topLXyQiT9T?=
 =?us-ascii?Q?D2JN3OBa2nM7ZhYiDWNsnF2AfPc7uKhDyOQ7gqIZNNHzBXLqfewvOUfkZFyD?=
 =?us-ascii?Q?s2tmwfIEc9EC659M85IpfhCboCWarf9ld6El589fR561RleQ6l4QyCQQ3zie?=
 =?us-ascii?Q?cHyiTVYoaoDdnhChU9trHLEEqu49q8JpHsWfdEojeCOmIGWiqZ4LaF23v4nQ?=
 =?us-ascii?Q?ZsJm6/DGayu/4WOP9YyxjGEFTWLUCvB7QXuX4khGbnYWjt4hygiIoZ33L7Vm?=
 =?us-ascii?Q?k19KHzxdWe+oeJzTgddRbBP+rSYJRLnSnrPHOMdgDiyMgHUC5vzv9KmPho8T?=
 =?us-ascii?Q?9X+Bmyd2L2A6XmNIdlGWLgpARZfAQLNhB5oWOvbB18QeoinBCWfz/wQnReSS?=
 =?us-ascii?Q?vuU69nc4KF9OfgkpYPnj5eAlDZJjAtdOvQmDEaul6sMkQFfGHySTZZnw6xxZ?=
 =?us-ascii?Q?mfcwUKA4+2aNT3Zqc5OmiV9H1GQaVsJoM4iPPHNqZo5ocaEfd5kSVGGOwu17?=
 =?us-ascii?Q?qa5rKEQBgSzSBeZuuV4gtlOJNo2OFq3wFarBoEx16hDYVRHvJnk1Ll9c4P0r?=
 =?us-ascii?Q?IH2/sReI0WME9S1LSNRzm1r+eyyPLoKiJx4fb7aUiYg0CW7wVzKBRDJ1M/rK?=
 =?us-ascii?Q?GOtuTwkcql1gm5X4OwocweoykbWQb9l5oWhFlrR1tyZm8cUtSAdubqJQ6oBd?=
 =?us-ascii?Q?dduontBt3Jwazi8P1EuKb77Vp0hqqih1Kao4nngf0oMpcLqvfTimiW1A2ZO+?=
 =?us-ascii?Q?KtlpeUZoK28nUtlHNCW3knnhPmub/hSe24zTmgyg/NZSr2fTq0lyTxpVL5Gy?=
 =?us-ascii?Q?0Z3u1co+ex4HtT+kfhUg6fbhBX6drWqDas9Fm+GtVzuz9a958TmIfanryexF?=
 =?us-ascii?Q?IeehEBeOguCO2LIC90Nr7tbkyEuIt50IwSBFqIbgTnh49G5iVlB1gYduYRSy?=
 =?us-ascii?Q?VZ/GvBWaTTxla/z+uJ1Wo8yYs+wsl7AjNA+3I5WKb+bpaSAce6mtYt5oEau/?=
 =?us-ascii?Q?hze2KhD83wWOZcw+s8oDKnSenDMCH7RC5ueyGFAfUiAiUsHyfUlbH+5BWM/C?=
 =?us-ascii?Q?3vcw39lCUtTw+dRurnbFCCUo6CeRiYsbHXM8HLseq5oj305YmA1WclaAn7wq?=
 =?us-ascii?Q?nK57JTH6qKiZyVRy6QQEM6cUHySCFeXibgiX1BjKCAsslzw5zOYFKFY1gV4t?=
 =?us-ascii?Q?Z+wRKU6zMQCD3S0PSzsBj0nwm3wJVlvFxPVfrADsp3grd0uK6n0M?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f56053d-f006-4819-3ee6-08df4bd5761e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:53:49.2217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7PnKtkOihoff8U4HzIcp0z2dL6WaajQabzPqeTSYkcnrv+ctDyx8OfbePmilW0ziROt85jc1/9QDkqmF8o5jv3JhtBtym2nIX2LZQXNAkiZT+mgzjyjSvtwb6eyqIK/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25178

Hi,

This series switches the rz-ssi driver to use cyclic DMA. Along with
it a DMA fix was added. This fix needs to be applied after the rz-ssi is
switched to use cyclic DMA, to avoid any regression. This series add also
rspi suspend/resume support.

For bisectability reasons, this series needs to be applied on top of
series https://lore.kernel.org/all/20261126154747.3832917-1-tommaso.merciai=
.xr@bp.renesas.com/

This is the equivalent work done for linux-5.10.y-cip kernel [1].

[1] https://lore.kernel.org/all/20261126152553.1298561-1-claudiu.beznea@tux=
on.dev/T/#t


Thank you,
Tommaso

Biju Das (1):
  ASoC: sh: rz-ssi: Use SSIFCR_FIFO_RST macro

Claudiu Beznea (8):
  ASoC: renesas: rz-ssi: Remove the rz_ssi_get_dai() function
  ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
  ASoC: renesas: rz-ssi: Drop unnecessary if condition
  ASoC: renesas: rz-ssi: Drop the & operator in front of function name
  ASoC: renesas: rz-ssi: Drop goto label
  ASoC: renesas: rz-ssi: Fix playback and capture
  ASoC: renesas: rz-ssi: Add pause support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs

Kuninori Morimoto (1):
  ASoC: renesas: rz-ssi: Use guard() for spin locks

Tommaso Merciai (1):
  spi: rzv2h-rspi: Add suspend/resume support

Uwe Kleine-K=C3=B6nig (1):
  ASoC: sh: rz-ssi: Convert to platform remove callback returning void

 drivers/spi/spi-rzv2h-rspi.c |  18 ++
 sound/soc/sh/Kconfig         |   1 +
 sound/soc/sh/rz-ssi.c        | 462 ++++++++++++-----------------------
 3 files changed, 177 insertions(+), 304 deletions(-)

--=20
2.54.0

