Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D316C77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:22 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web11.366.1750690033414325324
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=goTZDbji;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwZ62HfdsSqw8jDujbX1hxv4KAd334uPS24ft7IQdQ2kSpQ5dyD4UkKVIWA++FRreB/MVEeC7akXFkxLvUEGlu1NQPRhr4jMcBZT7qVJd/g8D6OSPFZ/pGCUz82qlhrJAI23UpIMCk03LTaeTQO13NN9u9xZ9wGArEcmYu8/DQr7XN34xvh1ol8FNrWZ7t1iHjjogZKuHZnH5eTIcKsSP1ZHrT3xfXtXhKfRvq3YxqEfLMTwzVubIW4LY+3hCgLUFF7oTqlAW26npWfzpXPxo49Zgm8LfuRxmQmaRszFc7W1feg7IO19ZEr77LLwa+o9ebomv9HyR+6Vgf8VnOzStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlTR1p7Q51uFDChoR53GuvurGK1WsaP2wiYS5KCOmMg=;
 b=Zl2QkU+EXy3DlherrdNWrAlenqHqGIaBcftuGJ9A4qBgZYZvqAB1NkIYhMuMu2GgaR/ehRAM2W7YtHsupPIBIQ4BWMGxSCUZ4JfWCI4mh62moxqLGJ0tjhcTFh5MLxnHTzkAYtMmNh8M405asOoJEZuNtgYNPnaWQGgq7a1W5W6tbcmTEUoU+URxqQf7fktKklSZqg9qHAJn3kFpLB1cLeHzoGVw0IKWH2DfkQXCIFDanOikALUF/76rrc4E+O4/lKCy4QT2pQ2yG5XH90AvPnAtqmRG+7i7VHZyhUWSvN4okXQjAFv5i7yxRqKzbPC/mNtA1VNzgiRfqMS/W14lrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlTR1p7Q51uFDChoR53GuvurGK1WsaP2wiYS5KCOmMg=;
 b=goTZDbjiG14PWFbqXCMFsHpXgtCE+jXt0xtFJxHgp3PwoV2QOaBs145KW11UNkpmVBrAnll5euhDss8HJXLiWR55sNffI0uTt9jBP1Wt9RO2sHME4RgDMBz2baS7nkARpOSnvpzlisr9YjN8AM/DEE3zxKMRR1V4C+AHHR+NRuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:06 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/17] Add support for RZ/G3E SDHI
Date: Mon, 23 Jun 2025 16:46:22 +0200
Message-ID: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b14e224-4f4f-40a4-4bf4-08ddb264d32b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rCvKf7sFEPJuwL/ylIrWKxtXexDevQhNg+cKZEmicPlAb6iLGG1PFkWQlJNa?=
 =?us-ascii?Q?4oKFVfGtmBY0XMhvzeVlzXDMOwOjrpm9Ezr37yM+zyujtpubh1+7/ixJRQl4?=
 =?us-ascii?Q?x7Fnlo7DthvLYh/OdAM3fewjlBGMp0VSXHQz/NIHixrUDAgdmgxYZmgaiVJD?=
 =?us-ascii?Q?26/VEmkAi5/4hZXnTDwi3Vbo4WTL/deMVuWSQ/xgnaVqtd9T3XG+Q9UQKbpd?=
 =?us-ascii?Q?06o6RkyNJDzBT9bss6RpzYOSL3ySNYbmbzq0ShlQTTuqmXFeUo+Kt0Xyp+lT?=
 =?us-ascii?Q?eZ2eotHgFMcTSlhBUSPxG+/zMx88ft/9RagYoG+6tOgtWo59zJxRMl8kvBGT?=
 =?us-ascii?Q?g49RNiy5n6yZ5n8tcVQGVXjmzGA5p15Tl0lFI64b5akl5xNowNOKxU/S58D0?=
 =?us-ascii?Q?RLNE3D58R/jCKyZP3jaJmbMwb5JA7bPV1v8mvCy07l4OqLB2DzD+Hih5a7MA?=
 =?us-ascii?Q?jL9fXEbs2IjUZkrT/GnABSFMU4dp1MTNzFG2trGKMoV9LbH596CQzdi4wIcq?=
 =?us-ascii?Q?fVf4oZLd5O7W/nJpYWbUoReN2VsYtWxjSofZ8wD0gZYQAo4kX9APsQe47iZP?=
 =?us-ascii?Q?0sA2xdX+amSPcggZrgjVLysjbHEixoagFTOFzXD6oJNBCoAqMHI627bKfVQ7?=
 =?us-ascii?Q?HZncYbbCAWmQaRhG/Hd5W/MGnn4Fb3nyxGMy5VgNJAw7Sw4vLA1yt4TIeN0i?=
 =?us-ascii?Q?blMg3R7BFCLu6DqIFhqOnwNom+S1DXJfxcdeIvojzzVRQELDhTaY5ln072dS?=
 =?us-ascii?Q?hyCq50QPrWt/vE2iROdUqm/7x9/mwAd5matTfiVZ624MGoqDIWqrY8sHjuJa?=
 =?us-ascii?Q?LbpJtMW6+oZm0VtiixW+FUBwKXVtobdyI+r5cIDZEN36V5J4J8HjbMYrFJY/?=
 =?us-ascii?Q?R8S4ptFneB3qbtnJSfn45QYlq4J1rrKYuYKmPwDcbD12ytqBxLcMAlEGKEDC?=
 =?us-ascii?Q?vEVVlNOSJ1H7/Wa9X1M/qi1ishRtZivAQCHTuytSmbFF9OSBrLyPtMuf11fR?=
 =?us-ascii?Q?xn9xcnE1VIo+Gq3mxkbR8bSXTfSHV1mcksijYEWDyHSVh5ZTL4KRYu8tVhZK?=
 =?us-ascii?Q?5pbuf0kSFOclF6gWkaM7MQjqdzWZOjuKZo0Ft7CGvmgc6XPIZACuttwxVyEA?=
 =?us-ascii?Q?oNyISs1oE44F9HXNuhynSm9y7rY9hUkdVXC3POnCatCYb3Yhv74lI02WSh3l?=
 =?us-ascii?Q?lv96wO+anbJHLZ85wgj2GQCKpwI8adiZUzlsvi2H9JvaFdV9Mrc7zCrYX41E?=
 =?us-ascii?Q?Co5Mze1BKVl3gNiNuh1zujsNTVrpH9glXu1b12EXVY3xdbnzJmCx59pCScIN?=
 =?us-ascii?Q?jI5C/SmcHukfci+bJHc7oK6bGZmUDn8KusgDSPCs60zNqEq8sphA2XSu4dC/?=
 =?us-ascii?Q?dgnO4/Y4Y/tP6IK93Z5QgIzb1MYcwSUJ+5Cjqqdwwn+0rn0SnOiZRitU7H9Q?=
 =?us-ascii?Q?eE44VQOyYPb929Jk6scK3wCUTgHGiGR9XuZrbkDMdSjzZRf1OzVuV3mAsX2F?=
 =?us-ascii?Q?g0bKGdErubblre4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hptNrVjfrs8F3JVOXh2jG+7YksvPwx64xSRVTkDfg5xKGcrpjvJ71fFtTb4v?=
 =?us-ascii?Q?r17P88gD9qi04kJDV7jVWxsjQJ0UEwmjZcfSh0nJXiLdvJhije7o5eA89rES?=
 =?us-ascii?Q?/BmpJwbPA0P/zwZlLlplMuEcaRiE4szcYrJ8mHqgN1VdHVCHf5MnFn+OnZAf?=
 =?us-ascii?Q?3LEI/frPskz6fwRegp7wfVCv70go9EcKl2opmT6Jg8R/PWjDITmVCl3U2xWR?=
 =?us-ascii?Q?SiIpygZFWJ5LsO8Mmc7bv9jVkFYsBGHpQ8nicLfLHLNq19SUeqEUrW/9m2Lq?=
 =?us-ascii?Q?YNITK0yCxBHFOd8o53ir1x8gnZTml0Yg1lt4FlLUYRU8MfZ+rYEEJcMFzFbc?=
 =?us-ascii?Q?TXepYxjN3Jump6yTc74pyC0iY7OeLEVMn6QKvXaIv3Ma3VuvCM+WcsQpdjiV?=
 =?us-ascii?Q?jcVk0XNcUllyLtcUcm8upLA2vC35J8mCJdv/5xat3ksp5xcTsySyUzgqjB28?=
 =?us-ascii?Q?Yx51YIYYltB2TY7+Y+0RJrZJ1AEj/4huquals5XjXoXVWKm1MnGmaYC5KD3s?=
 =?us-ascii?Q?kKSNPtZtmBJPQ+PIInJ8uPul7ExpCnau+s4j8VVxT8ZF0dKScmPuy6YKLcTM?=
 =?us-ascii?Q?+0sy5LoktCBEZvgbxGLANuDwZVLgzhosEgy7JQvcALWREtq1NVPAa3VxQMpi?=
 =?us-ascii?Q?JFHumzLgWcGp+MnIdEeeD/xwO6kouMCXuT9DTrQVElLwv/w9DMTpanRFi5XR?=
 =?us-ascii?Q?chMV5dfIDzIqDZzsuspIU9Gbd9GVSDoJRwqazAnk+T5hPZ+dgXrBzmz/FDIP?=
 =?us-ascii?Q?NYl5sYKK2H55rsZfq2d0I5yo4LvjjMJIlPLIeOq4DjKOdvuqYJUpFKnyEaKt?=
 =?us-ascii?Q?G+8DN3eYPbmXvU4+aQJcQ/1XZxDOwfkkgA2dosWYT5Qjj+iZMxufQhNAwiDd?=
 =?us-ascii?Q?DBP9+7gxDHWAb0Io0ytb3ki+taqCR0kO4j0/NKZGY7Sx4bj7husV7kzQ8xFc?=
 =?us-ascii?Q?/InPgdEsSZkRH9Dn8ESDwvQ6PPNV8HYtaG9uu2TP1XljmYK0ynSj0ghY66tV?=
 =?us-ascii?Q?EA/HQbkp0DMyo9mcQ+DNSudW3cj5nmWe82Ymzes/AoKKCYQLm5amEl8mH9VL?=
 =?us-ascii?Q?1vItPrfuE0HHRA0WbbLxwicKDK8oUXzLcLDa/8xSj7ZDvrXn3eHylOon9EZM?=
 =?us-ascii?Q?usVx+x8EVrf/b2s66sLPbR1ArgtSWL4iPx60QTWRZI7rLnLRogU+RSby92kU?=
 =?us-ascii?Q?7LjG75VAVKBksUKG6O2/slN/yqnl6ksiBneilxfUKbOz2w3kEw6obe2hlLeC?=
 =?us-ascii?Q?M0T+jW3H9Vpiz8l7HluDObGPHnpQJrUdt2+iPnJsATNyk11C0TjYd+bs6lbj?=
 =?us-ascii?Q?e6ZSL3yHbQxW8GSgCrqRM/eCfcrmz9oNHlYaFy99YdPT1yy/rpq8O+hJd0Hy?=
 =?us-ascii?Q?GK8Sm3LWqEYIoiBp7bzXZX5xi4Z7Cbl4InNkxn9W5QcK58+4um/1KvgI+MzM?=
 =?us-ascii?Q?gIVqne6kxumOdSTWq+I4lJAF+mXY50MOCH157qZmClK4tkwaMcU6yWcoEZV3?=
 =?us-ascii?Q?9O0hL6DB8UwJszXSX92USe1osL3lBZQ7zHEAuJl9fwRtvj66DMWYYcF7J7KH?=
 =?us-ascii?Q?FMUMBn4kzBRw9zMAgZrJuBtoqY0uh6i3foSseAIAtCa5pGU5hHEtIRKG4OTR?=
 =?us-ascii?Q?ixHFf9zgl9V+Mevpub7/O+Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b14e224-4f4f-40a4-4bf4-08ddb264d32b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:06.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkICSpW58f0/egLn45jD07h+bQJP9NnCSNxJC/VUQXMZjsfiNvJye4aCEPu4OrI0L13ZcSG8nrwde3XtQTZHuKKw6RYZAl5aS/KfEovw+y3eyxJrzBw7GRbKIQvECElf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19187

Hi All,

This patch series aims to add SDHI support for the Renesas RZ/G3E SoCs
into the linux-6.1.y-cip kernel.

The SD/MMC block on the RZ/G3E ("R9A09G047") SoC is similar to that
of the RZ/V2H, but the SD0 channel has only dedicated pins, so we must
use SD_STATUS register to control voltage and power enable (internal
regulator).

For SD1 and SD2 channel we can either use gpio regulator or internal
regulator (using SD_STATUS register) for voltage switching.

This patchset applies on top of [1]

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D974771

Thanks & Regards,
Tommaso
Biju Das (10):
  clk: renesas: r9a09g047: Add SDHI clocks/resets
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3E support
  of: base: Add of_get_available_child_by_name()
  mmc: renesas_sdhi: Add support for RZ/G3E SoC
  mmc: renesas_sdhi: Use of_get_available_child_by_name()
  arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
  arm64: dts: renesas: r9a09g057: Add support for enabling SDHI internal
    regulator
  arm64: dts: renesas: rzg3e-smarc-som: Enable SDHI{0,2}
  arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on
    SDHI0
  arm64: dts: renesas: r9a09g047e57-smarc: Enable SDHI1

Krzysztof Kozlowski (1):
  mmc: renesas_sdhi: use typedef for dma_filter_fn

Wolfram Sang (6):
  mmc: tmio: add callback for dma irq
  mmc: renesas_sdhi: improve naming of DMA struct
  mmc: renesas_sdhi: remove accessor function for internal_dmac
  mmc: renesas_sdhi: take DMA end interrupts into account
  mmc: renesas_sdhi: add helper to access quirks
  mmc: renesas_sdhi: use plain numbers for end_flags

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |  16 ++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  60 +++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  49 ++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    |  21 +++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  18 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 154 ++++++++++++++++++
 drivers/clk/renesas/r9a09g047-cpg.c           |  31 ++++
 drivers/mmc/host/Kconfig                      |   2 +-
 drivers/mmc/host/renesas_sdhi.h               |  20 ++-
 drivers/mmc/host/renesas_sdhi_core.c          | 148 +++++++++++++++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  82 ++++++----
 drivers/mmc/host/tmio_mmc.h                   |  11 ++
 drivers/mmc/host/tmio_mmc_core.c              |   3 +
 drivers/of/base.c                             |  27 +++
 include/linux/of.h                            |   9 +
 15 files changed, 605 insertions(+), 46 deletions(-)

--=20
2.43.0


