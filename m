Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7920C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 18:29:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.101407.1700764141415025609
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 10:29:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,222,1695654000"; 
   d="scan'208";a="187858424"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2023 03:28:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.37])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 74F4E40555FC;
	Fri, 24 Nov 2023 03:28:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 00/12] Add versa3 clk generator support
Date: Thu, 23 Nov 2023 18:28:42 +0000
Message-Id: <20231123182854.422379-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 18:29:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13673

This patch series aims to add versa3 clk generator support on
RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.

All the patches are cherry-picked from the mainline.

Also added missing MTU3 binding patches for RZ/{G2UL,Five} SoCs.

v1->v2:
 * Dropped unneeded patch "clk: Add trace events for rate requests"
 * Added rz_mtu3 binding patches to this series.

Biju Das (10):
  dt-bindings: clock: Add Renesas versa3 clock generator bindings
  dt-bindings: clock: versaclock3: Add description for #clock-cells
    property
  clk: Add support for versa3 clock driver
  clk: vc3: Fix 64 by 64 division
  clk: vc3: Fix output clock mapping
  clk: vc3: Make vc3_clk_mux enum values based on vc3_clk enum
  arm64: dts: renesas: rz-smarc: Use versa3 clk for audio mclk
  dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
    names
  dt-bindings: timer: renesas,rz-mtu3: Improve documentation
  dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs

Stephen Boyd (2):
  clk: Move no reparent case into a separate function
  clk: Introduce clk_hw_determine_rate_no_reparent()

 .../bindings/clock/renesas,5p35023.yaml       |   89 ++
 .../bindings/timer/renesas,rz-mtu3.yaml       |   67 +-
 .../boot/dts/renesas/rz-smarc-common.dtsi     |   14 +-
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   20 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |   20 +
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |   24 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-versaclock3.c                 | 1142 +++++++++++++++++
 drivers/clk/clk.c                             |   85 +-
 drivers/clk/clk_test.c                        |  152 +++
 include/linux/clk-provider.h                  |    2 +
 12 files changed, 1558 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,5p35023.yaml
 create mode 100644 drivers/clk/clk-versaclock3.c

-- 
2.25.1


