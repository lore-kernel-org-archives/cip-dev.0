Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DBECD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:34 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7012.1778751743945784409
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fcH19uS3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.68, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8Zy9F3rubtKbSHz+33tWUWErD9ltjSPGJdeVQhTuAmyVkIhM7Qf4gV4PDUuXp8/A868gef+FUC5NygpbYhc6QOJBC1ZAxar6os+N4Dtlbz8M/Ni5ezYN4DBQ7CFINV4F2dpsiH3HjEgVJwS/xqNsBIGtdrVxwv3DC1qF93PIHsJw6pqCVpcMkRK1n1WKYtc1V4Sx31X7sYTbc/jmq/pRa9tT+F5eqi+x7++8vYbiYtVhooKRCyBROxLXYzPTifPGbKa6O2GB6G1wFRXYdk8pMnfm42gyW3R+rKNk6mwdoHI8DFblAmBC2aqCvTWFM0zmO6eJeYmCsn+sE6eGnqfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY0bUkgaWGK1UzdowjfwaPCJrpqEmgDxCWF2PShiyEQ=;
 b=Ka2qgpEGRX5/gFDgszqhXTdISWkNvRYM0Qj79jsb4ql97SkNYkKWeSdSkAP2dVLPnQ+BKLLzCnd4/+ERuv/OCoc1b1IqDoazrh71fLf2n6EXqWK/hltHawSUMvlniNvjIZKBremEhnoMFKKpKn/lzMHXuxAeGujiNe0wlVE0Z6F9Pocm3JVpHFKyrkD3rcpp8tl0ym2fLhiBy+vatlBOEeochaMtJLzWZVMvR8tlN5WnWKrCGKG79JkORsq6Coh4OahwUvzGRrRBL990l4sx7h40893q4z9Zp+4UhT0A3IGuisXZz3FzrJ5FHuyy39fSQmuap6C36lxXnjj/F9xXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY0bUkgaWGK1UzdowjfwaPCJrpqEmgDxCWF2PShiyEQ=;
 b=fcH19uS3ma40oO5yYPsNQ/+7U5e/tgTEzAFjLFYN5Wh2xx0YqZIsXlp+ig/fXUijMh6xKmgyFq7EmZFr3HLF0elfpaDa8BpL7PaVYVF6FtX4dcJbftOBkkZJD7EwTe0rc5y4/R5y7yMHP00emaMVaVYkGUsmDXeaUCTiIZ1nhWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:21 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:21 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 00/17] PCI: renesas: Add RZ/G3E PCIe controller support
Date: Thu, 14 May 2026 09:41:35 +0000
Message-ID: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd07a3c-f819-4697-514f-08deb19d1873
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	qZ/dI9Ip1j6nk5UD0TOl7DP+NSaWmz33HC+ujnB9Nc9kFvFJG3H+KdvzUvk5lnPA6aPUFDnIHFR/YSclfSJ2B9kzQebaFBnwsuIaAk9DNSRjiF62WCGXcX7lM7EUvKvB/Jb1BvZg5OtqNY2agkfEeXt7TFrD+Tq9kpQWDqIyFsLm2eab/QQD1qR0JsCVoNW4QKifrZr6JDkikZHEi8sHvNlIMXOj+iYU4gZW3ln444/owbVZD9OzdHNFN/hys1bLEyflr4V6wYKrUdmfCAbX8RkzhwmPEq9ngkX43OPsEfmBQ7952GW6Tb15TTLZrmXsIDOvbQ1Jr21LArB+qKh1Igj/J5/74CW7dlsP7DAiOzwvHWv0WcyACo2DwkmfUOe2Ue/vehN/ELpo292cmYUhAigewQPjYTrOUteGXjUXqzM562pr4xvRuACJwww2d11deF32walFqLM/ae6uhBdWOVFhNlyBfThrHFCIl8DeQR/v+oVn+dcSQcayb9CQJ9YtiNFdwlGoXEF1W6mDzvGT0YB7B4KhXHrTHl781FZBEd/3kAi80wi3XOErlmJfXn+rtb4pMcr+kTV8+6ervcSFs3yl9bdIUOfLLKOH4MWTjRf8/Yz6sIAvuGR3QFRgxRB8f2PLU+YHNPrrqt4+mt+m1NAF6AxuAObBD85oOtH3vMQQUyXrjQwnmBN2lmmuenAi9tat2wEC5royPFnZ7kB+B4lAO+XhJZIL4vkWbRM1nrocnBp2IXHNuQHDf1Ll/Ygm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8MUhu1Rvrfx9PAb4jxEL3BIrS2RXBbcliqPfEh0JCANTkEWnOgZrF12AdYnZ?=
 =?us-ascii?Q?c+8yCshd3qashW1mVQfQOVglhtbWIkQkQbZV9Cgog3crHGmQCoXABvsnlXsg?=
 =?us-ascii?Q?VnzZtkQg8RbilQy/N6rpf7PDa9Gf4NwNm8lq0zfAZjaHaOBJ2mM6LNfAFuGR?=
 =?us-ascii?Q?H7p+qu8Hh61Fcqu00noZUshmsZ75jaC69VH4He99NLdSZ2DpfZE9OzPKjHid?=
 =?us-ascii?Q?OQxU9xCL3Po45UvErpwPVGx2vgfWMp0QSv5F09O/Mjelb/IjoeF2y5nyTrXJ?=
 =?us-ascii?Q?6HW7gJOfl9/Ama7+nLY9xNxNTuTsasZz6ex8m8dDIjhzKsNnQwTMuiKiISOG?=
 =?us-ascii?Q?e7TJJ3TGlsF8a13qi4/6nhY6yMYrZXi5/lszPoROt6J9PU8PbvfuyCLrIVio?=
 =?us-ascii?Q?wZ9qwOSiP23EqiXB5hxbiXvg//tytmONNKehh/uMt7UBHQ/Z5EG+OAR+AdMy?=
 =?us-ascii?Q?mZHT53zLbfLlqVkQX6DKijXy1d4vIZnxjwUsR506NwQkS3a8czNX9eHDo12N?=
 =?us-ascii?Q?yghZeBhUYdjCGeM10qTVF06kBcF7B/xPJYswNL2Trw/NihDWmNNFbAbwMYw6?=
 =?us-ascii?Q?0orgxL7wR2r5o7Godh0eBM6iyBuHHlCT7FgMI1NAZQSKaDJMIa2FyKpocqJF?=
 =?us-ascii?Q?HPgh/88EHlpDjSAh8y6EykuVtU6NxPCvmhxkAK9fNJy4vV2Ue9niUmqxvGib?=
 =?us-ascii?Q?VkLn139CswPJrmwYDXWoQD0PrVerr+JMRgY8cj2LcDmtgrIxyyTZZejjr/uc?=
 =?us-ascii?Q?dqk4Dr3gcAdgVQXHhF4BiQ1NlT21f+gnoatAwD/711KeGuNoCDCOZwm4aH3d?=
 =?us-ascii?Q?0O5WVAP7ZluWyH06kuktwoYX8L24yuTkJ0kdMp3W1Y3lCyBoPBXEwQi85A2S?=
 =?us-ascii?Q?WI/rla7WYlIhbmXPmW91WcWTAZFFyZJe4EzbTVkWvK327QBBUVleB7JQBWZU?=
 =?us-ascii?Q?kwj3C/O4aijiygN4HflRmq17sSvaB2JhujQU7wF2M9HgQtLVsKo/AfLcevsm?=
 =?us-ascii?Q?GZXoPbgMoU7r71LB7d4GFS3KK9lBKO9Z2cpi/uL7kBC2SKOEV/CZzKEGM+CG?=
 =?us-ascii?Q?/L+6rukRnNYVA9pH8XzemKMU4Sy98OlezEaoULJksweYqzI/Qh3DymUoa3rT?=
 =?us-ascii?Q?q5D6QTGo25UwvvL/M/D2gsU1Z8wSXuCgZ+oacAhtnSnUg2d2kp0GLQKm6bul?=
 =?us-ascii?Q?3aFvhCfFWRysHWek2+XWn0JZET2SOFs8TNkpzaHXeCVlVU5P4bt3cYBp8TOX?=
 =?us-ascii?Q?v+WTQMzGB2jhH+qf24nIRY6zanfjDK4QearPew+lNhQ3F5TvvfITJkkX2rE0?=
 =?us-ascii?Q?pCvmdaYBjD4M2pLPvB5mwg/vPuJH+ky6zB6ssgZBzQ7sQqcdoDbLYHaSVFao?=
 =?us-ascii?Q?d/0FAm3ngPaKb4AoOIPpTqBf7rUF++1ZJXezlMXVL3Bhqz8oPXOgPHid6rtA?=
 =?us-ascii?Q?rJP5ARgV/K+QI3ohiinzKrLeVtq6xuOkbWQKpyGgWnZDBXJtVcp9oQwMjnWv?=
 =?us-ascii?Q?7nLsx/Jj96rTtqCIWV80S1MUgzH2261/UbPcjUkPTTtm40lD0fa4C6U5OInd?=
 =?us-ascii?Q?0k7RDpJsOPAnodY2X/DUUtUQmJh4z87Nt779dKG02kE7nCZQ+b6WRVudPLgj?=
 =?us-ascii?Q?hDaN2rfyspPofOYejpAxtpDVuXjOo83MzVqqrz/ytdOGQR4cWMBrzdyK/pbq?=
 =?us-ascii?Q?qlAT5O248ki04RkvtDXZP1Nsx7apuAtYFT8fG1JdgevCc2xM36eBWACzPzf+?=
 =?us-ascii?Q?a5wUrF5ZGTKxC7GTzcl1jY+PpMB1oAU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd07a3c-f819-4697-514f-08deb19d1873
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:21.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KP303ayj/DU70qtAiiMPEACxupSn5pg8D/1ks6oIpMj9hy3ueJbDz2BzhDQ92UuCmYUzfLLW5hWIXKxNW1jzaT9a2jpLv2H3qt3FbFmbns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22952

The Renesas RZ/G3E SoC features a PCIe controller that shares
similarities with the existing RZ/G3S PCIe controller, but with several
key differences. This series adds support for the RZ/G3E PCIe controller
by extending the existing RZ/G3S driver and device tree bindings.

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

John Madieu (15):
  clk: renesas: r9a09g047: Add PCIe clocks and reset
  PCI: rzg3s-host: Fix reset handling in probe error path
  PCI: rzg3s-host: Reorder reset assertion during suspend
  PCI: rzg3s-host: Rework inbound window algorithm for supporting RZ/G3E
    SoC
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
  PCI: rzg3s-host: Make SYSC register offsets SoC-specific
  PCI: rzg3s-host: Make configuration reset lines optional
  PCI: rzg3s-host: Add SoC-specific configuration and initialization
    callbacks
  PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
  PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
  PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
  arm64: dts: renesas: r9a09g047: Add PCIe node
  arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 121 ++++--
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  16 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   4 +
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 365 ++++++++++++++----
 include/linux/bitfield.h                      |  89 +++++
 8 files changed, 570 insertions(+), 110 deletions(-)

--=20
2.25.1


