Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4676.1794226501789771810
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WY+nuRPQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.35, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T47k6hdB+XYO/bKRXF4i2O7rREPJYgdbfsKhdu/z1en1Vc//n4o4IYB0Lrc1cFByF04CXTe3yUlt1jAPS4yJ1VySR+F7mtc88XF04vPJzk8rwGmxG50YB3cVwWLXaQLjmUSzF+SfsiICuZDE8xDOTgDgGeea4S58PbJQ0O4sad+Kmdci9bLSDU0ad7t2w9vzuL7uZpo2JnSATVq7zeQloqGFhh87vE/64skQDBTTW8Jq4OLnldO5b9pG5B+6N80SXn4i40MvRqpS+gSmKBtdDsA9fBIrBwN8YxCAEYXSRoWDRHAfmjhJF7LK6kkMoqQKmFhWJy/ciYjazM5OmU597Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYaqWw4OQ7iraUol/DcWytJ0APWQxpk4V6DBmKwv7cU=;
 b=ZHsVwMCtxJIpRSogRHBGLcw/W0u7pAqCSg0JJ3e9AlU9I4sME3ymB9bTnsX9ARpJNCMyPoit6vQwn1sKgZVUojNQq/ux2WigUFCffuCIHFgDfmsEuppVBqZm/ubfzKEVQjD/8xCOPYY4OxhEv8cveh4BJTUP/pcaG1LcBYuY4GagArtECYH12czhMcVofWTbRkn/WcYKSDdGTu9IAEXyTTRR+eEn++5QoqECzSHFqMJFj1zl/P1A3xcFVC2y8NtFFBqPnhv0GbrnBMBqrefP42EarMLBRkmOz0XrH76EJgo/U3/A/s4+dxe/54ZgEJbyuaLauZnkJRbczUU3EzXlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYaqWw4OQ7iraUol/DcWytJ0APWQxpk4V6DBmKwv7cU=;
 b=WY+nuRPQ02LR2RpiN1BPnbSSfnb+B8KzwvClj7JzTLeT2JHTn0I1eK1dk5Kx6CIMT00Ve0AD4IBJ4S/tvKaqGp3mNjGaYoAfyu0dQ2wr88pxEOEIGKOI/JHzVCQM3FUbDv9z4aSzbMyivmhaPVFkcz/0cE34aZTsLhMjaHXFhuY=
Received: from TY6P301CA0023.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::15)
 by TYYPR01MB12636.jpnprd01.prod.outlook.com (2603:1096:405:15e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:14:54 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::e) by TY6P301CA0023.outlook.office365.com
 (2603:1096:405:3bf::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:14:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:14:53 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A2F7B300022D;
	Mon,  9 Nov 2026 21:14:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and RZ/N2H SoCs
Date: Mon,  9 Nov 2026 12:14:27 +0000
Message-ID: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYYPR01MB12636:EE_
X-MS-Office365-Filtering-Correlation-Id: 12086f8f-8406-4be3-bcbd-08df3e5b0fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ttdt50AcbVr76C/nKvrhiZXb93rTM8klThoLW832Ro1GCQQjW6UwsHq8MmnDQUFIRhiCbdqDciLv7PxUu2J7s6DWbd2M6JD2tUHof8KiayZwi6OPHlPRlVvo9abR4C6Pea71+hxwPGmoc6V8OMZmlvzuNRe4NNK8HWe1RNTHLIezY9Fo395umAn1h6mKT0TueIANNI9fnWZ2orF8bhzKZbzduUTyTxocOkwu30FMQ1SHuqaim1JXITP/u9CHgGYkLcRO4ymt8Uq00HJfHVKdnSZ2fTDc/tnw8LYB1cMjADbSYfObPlhuf2G31FbrD5JMbaya6HMd/ZcOBQPnSsGj4XBbggSQM4bIb/hdwprkA6PGmZS4MybA2PtuWhfMY5LE7H3ahAd7lIztBkw8JUZ4vbXPnuBf2sM/CeNHE4yg29WjQr/44MZa4KvKuGShFsrLSIDgJRmt2W+aRAhTla3dyHds7RKBAllMwroU8fPmKEMytEy2+jQvwZ/Lz5VTJ6x7kYagu2AFLRDikcKUe8z6sK5p+zIpyQPFlX13U41SC4OssR5mSlw8my5OJREMcWr9lAcXM/7FXP6hZzTgFshX65PljS/gWwa7ZHUde6JigPxRlYq4SkLdJ2de4/o2mTvl/VqZvkUVtUeLRVpphYErqk7uAOZSX0Bg0KEuQCDg1bpcP0hx8jHstCHmLiR6dU5BBUtfjBHNRfdAboF18Oq/Sg==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QRATi+nxssIxXI6PstB6QgroNGjA0ZLnid0JNuiUcobRv8I3nZ9STenfTYIqotPMw29Jl4VyIK1tdd3adyb5lfJ+voPJaJUkRD7Ekl2RFWWZrEX6IpPEjosZssk8CAkgdUYEP1HtIAY8bHv5fxKdSmIL3ZjQR7jpnmfYjSbcNCHI744ZsGaXGyUCl++0FZNg4TDI/6rEQpQEZtWa5z2cdylRZGjMrZBOrhK3EZhPT3PRFyy7dlK1s3WoDXGcfgyDORp1S9AfVhMNX+Ugw5x+Ok+FbepQgQzTHE0HajxGheTaZPb9TZVi/Ld1g5nP7AWE5YflQ21aSA44lKJejXeDl8iA6kGQ001EY3TcJFaWTqVwIBc5d81NbqraXmLJ/dXXoMcyOEzmRjDDgTme8XCBPluxgAa+tQEEYYRhEoSa/Z+2VYxFyTcMoqu1x5cz2pB7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:14:53.9380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12086f8f-8406-4be3-bcbd-08df3e5b0fea
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12636
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24704
Content-Type: text/plain; charset="utf-8"

Hi all,

This series backports upstream display support for the Renesas RZ/T2H
and RZ/N2H SoCs to 6.12.y-cip. It adds support for the VSPD/FCPVD/DU
display pipeline and board overlays for HDMI output through an external
ADV7513 transmitter on the corresponding evaluation kits.

The series is organised as follows:

- Patches 1-9 add the DT bindings and VSP1/DU driver changes, including
  optional reset handling, per-SoC pixel-clock limits and the RZ/T2H
  DPI output-enable control.

- Patches 10-18 provide the clock changes: a clock-divider maximum-rate
  query fix with KUnit coverage, LCDC/RTC module-stop release delays,
  shared PLL calculation helpers, related RZ/V2H clock updates, RTC
  clock definitions, and PLL3/LCDC clock support.

- Patches 19-24 add the SoC display nodes and EVK overlays for the
  ADV7513 connected to CN15 on RZ/T2H and CN20 on RZ/N2H. The overlays
  configure the display pins and disable conflicting board functions;
  the board switch settings are documented alongside these changes.

All patches are backported from upstream. The shared PLL helper
extraction in patch 15 was manually applied, as noted in its commit
message.

Cheers,
Prabhakar

Lad Prabhakar (22):
  dt-bindings: display: renesas,rzg2l-du: Add RZ/T2H and RZ/N2H support
  dt-bindings: clock: renesas,r9a09g077/87: Add LCDC_CLKD clock ID
  media: dt-bindings: media: renesas,fcp: Document RZ/T2H and RZ/N2H
    SoCs
  media: dt-bindings: media: renesas,vsp1: Document RZ/T2H and RZ/N2H
    SoCs
  media: renesas: vsp1: Make reset control optional to support platforms
    without a reset line
  drm: renesas: rz-du: Make DU reset control optional for RZ/T2H support
  drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
  drm: renesas: rz-du: Add support for RZ/T2H SoC
  clk: divider: Add KUnit tests for clk_divider_bestdiv() ULONG_MAX
    handling
  clk: divider: Fix clk_divider_bestdiv() returning min rate for large
    rate requests
  clk: renesas: cpg-mssr: Implement dedicated MSTP delay logic for
    RZ/T2H LCDC and RTC
  clk: renesas: rzv2h-cpg: Use per-SoC PLL reference frequency for
    calculations
  clk: renesas: rzv2h-cpg: Extract PLL calculation helpers into shared
    library
  dt-bindings: clock: renesas,r9a09g077/87: Add PCLKRTC clock ID
  clk: renesas: r9a09g077: Add RTC clocks
  clk: renesas: r9a09g077: Add LCDC and PLL3 clock support for RZ/T2H
    display pipeline
  arm64: dts: renesas: r9a09g077: Add VSPD and FCPVD nodes
  arm64: dts: renesas: r9a09g077: Add DU node
  arm64: dts: renesas: r9a09g087: Add VSPD and FCPVD nodes
  arm64: dts: renesas: r9a09g087: Add DU node
  arm64: dts: renesas: rzt2h-n2h-evk: Use consistent switch notation
  arm64: dts: renesas: Add LCDC overlays for RZ/T2H and RZ/N2H EVKs

Tommaso Merciai (2):
  dt-bindings: display: renesas,rzg2l-du: Refuse port@1 for RZ/G2UL
  clk: renesas: rzv2h: Add PLLDSI clk mux support

 .../bindings/display/renesas,rzg2l-du.yaml    |  21 +-
 .../bindings/media/renesas,fcp.yaml           |  18 +-
 .../bindings/media/renesas,vsp1.yaml          |  17 +-
 arch/arm64/boot/dts/renesas/Makefile          |   6 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  46 +++
 .../renesas/r9a09g077m44-evk-cn15-lcdc.dtso   |  53 +++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  18 +-
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  46 +++
 .../renesas/r9a09g087m44-evk-cn20-lcdc.dtso   |  63 +++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  32 +-
 .../dts/renesas/rzt2h-n2h-evk-du-adv7513.dtsi |  72 ++++
 drivers/clk/.kunitconfig                      |   1 +
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-divider.c                     |  25 +-
 drivers/clk/clk-divider_test.c                | 153 +++++++
 drivers/clk/renesas/Kconfig                   |   6 +
 drivers/clk/renesas/Makefile                  |   1 +
 drivers/clk/renesas/r9a09g077-cpg.c           | 375 +++++++++++++++++-
 drivers/clk/renesas/renesas-cpg-mssr.c        |  20 +-
 drivers/clk/renesas/rzv2h-cpg-lib.c           | 217 ++++++++++
 drivers/clk/renesas/rzv2h-cpg.c               | 374 ++++++++---------
 drivers/clk/renesas/rzv2h-cpg.h               |   8 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   9 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  20 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  14 +
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |   9 +-
 .../media/platform/renesas/vsp1/vsp1_drv.c    |   2 +-
 .../clock/renesas,r9a09g077-cpg-mssr.h        |   2 +
 .../clock/renesas,r9a09g087-cpg-mssr.h        |   2 +
 include/linux/clk/renesas.h                   |  34 +-
 31 files changed, 1419 insertions(+), 254 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.=
dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44-evk-cn20-lcdc.=
dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-du-adv7513.dt=
si
 create mode 100644 drivers/clk/clk-divider_test.c
 create mode 100644 drivers/clk/renesas/rzv2h-cpg-lib.c


base-commit: c8fba740567363d02e64b657c2e6b26d86c5f84d
--=20
2.43.0

