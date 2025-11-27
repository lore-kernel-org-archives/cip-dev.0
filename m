Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6809ED11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 11:30:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16629.1764243016084177802
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Nov 2025 03:30:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: UEgL5eybRj+ACRZGsCA38w==
X-CSE-MsgGUID: Meob4WJwTAaSOWMycAVgzA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Nov 2025 20:30:15 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.131])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 41870401109B;
	Thu, 27 Nov 2025 20:30:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/5] Add RZ/V2H DMAC support
Date: Thu, 27 Nov 2025 11:30:07 +0000
Message-ID: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 11:30:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20749

Hi,

This series adds DMAC support for the Renesas RZ/V2H SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Fabrizio Castro (5):
  dt-bindings: dma: rz-dmac: Document RZ/V2H(P) family of SoCs
  irqchip/renesas-rzv2h: Add rzv2h_icu_register_dma_req()
  dmaengine: sh: rz-dmac: Allow for multiple DMACs
  dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
  arm64: dts: renesas: r9a09g057: Add DMAC nodes

 .../bindings/dma/renesas,rz-dmac.yaml         | 102 +++++++++--
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 165 ++++++++++++++++++
 drivers/dma/sh/rz-dmac.c                      |  84 ++++++++-
 drivers/irqchip/irq-renesas-rzv2h.c           |  35 ++++
 include/linux/irqchip/irq-renesas-rzv2h.h     |  23 +++
 5 files changed, 382 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/irqchip/irq-renesas-rzv2h.h

-- 
2.51.0


