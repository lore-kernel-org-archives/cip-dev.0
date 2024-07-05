Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D00C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 13:04:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16666.1720184660868312182
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 06:04:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214374040"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 22:04:20 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BC783453293E;
	Fri,  5 Jul 2024 22:04:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/9] Add IRQC support for RZ/Five SoC
Date: Fri,  5 Jul 2024 14:04:08 +0100
Message-Id: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 13:04:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16406

Hi All,

This patch series aims to add IRQC support to RZ/Five SoC. While at it
fix build warning for RZ/G2L CPG driver and fix for ax45mp_cache driver.

- patches 4/9 and 5/9 have been cherry picked from -next
- rest of the patches have been cherry picked from v6.10-rc6

Cheers,
Prabhakar

Biju Das (1):
  irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()

Lad Prabhakar (8):
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
    interrupts
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
    RZ/Five SoC
  irqchip/renesas-rzg2l: Add support for RZ/Five SoC
  irqchip/renesas-rzg2l: Reorder function calls in
    rzg2l_irqc_irq_disable()
  riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
  arm64: dts: renesas: r9a07g043: Move interrupt-parent property to
    common DTSI
  riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt
    properties from ETH0/1 nodes
  cache: ax45mp_cache: Align end size to cache boundary in
    ax45mp_dma_cache_wback()

 .../renesas,rzg2l-irqc.yaml                   |  61 +++++--
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   4 -
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  75 +++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  16 --
 drivers/cache/ax45mp_cache.c                  |   4 +
 drivers/irqchip/irq-renesas-rzg2l.c           | 158 ++++++++++++++++--
 7 files changed, 272 insertions(+), 47 deletions(-)

-- 
2.34.1


