Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED56C04A95
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7910.1666708896535930741
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:41:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="137874077"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2022 23:41:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1088B43684FB;
	Tue, 25 Oct 2022 23:41:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/12] RZ/G2{L,LC,UL}/RZ/V2L improvements
Date: Tue, 25 Oct 2022 15:41:19 +0100
Message-Id: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:41:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9821

This patch series aims to add DMA support to RSPI and enhancements
like fixing interrupt types, MII support and fix RPM imabalance for
RZ/G2{L,LC,UL}/RZ/V2L SoCs

All these patches are cherry-picked from the mainline.

Biju Das (9):
  arm64: dts: renesas: r9a07g043: Add DMA support to RSPI
  arm64: dts: renesas: r9a07g044: Add DMA support to RSPI
  arm64: dts: renesas: r9a07g054: Add DMA support to RSPI
  arm64: dts: renesas: r9a07g043: Fix audio clk node names
  arm64: dts: renesas: r9a07g044: Fix SCI{Rx,Tx} interrupt types
  arm64: dts: renesas: r9a07g054: Fix SCI{Rx,Tx} interrupt types
  arm64: dts: renesas: r9a07g043: Fix SCI{Rx,Tx} interrupt types
  clk: renesas: r9a07g044: Add conditional compilation for
    r9a07g044_cpg_info
  ravb: Add RZ/G2L MII interface support

Geert Uytterhoeven (1):
  mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path

Lad Prabhakar (1):
  arm64: dts: renesas: Adjust whitespace around '{'

Uwe Kleine-König (1):
  mtd: hyperbus: Make hyperbus_unregister_device() return void

 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 20 +++++++++++++-------
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 16 +++++++++++-----
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 16 +++++++++++-----
 drivers/clk/renesas/r9a07g044-cpg.c        |  2 ++
 drivers/mtd/hyperbus/hbmc-am654.c          |  6 +++---
 drivers/mtd/hyperbus/hyperbus-core.c       |  8 ++------
 drivers/mtd/hyperbus/rpc-if.c              | 13 +++++++++----
 drivers/net/ethernet/renesas/ravb.h        |  8 ++++++++
 drivers/net/ethernet/renesas/ravb_main.c   |  8 +++++++-
 include/linux/mtd/hyperbus.h               |  4 +---
 10 files changed, 67 insertions(+), 34 deletions(-)

-- 
2.25.1


