Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65275C7EE2A
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:21 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.34565.1685631855818179187
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350481"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:14 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3F6F940078AA;
	Fri,  2 Jun 2023 00:04:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 00/19] Add RZ/V2M USB3.1 support
Date: Thu,  1 Jun 2023 16:03:51 +0100
Message-Id: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11730

This patch series aims to add USB3.1 support for RZ/V2M EVK platform

All these patches are cherry-picked from the mainline.

Arnd Bergmann (1):
  xhci: split out rcar/rz support from xhci-plat.c

Biju Das (14):
  clk: renesas: r9a09g011: Add USB clock and reset entries
  usb: typec: hd3ss3220: Add polling support
  dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
  dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and
    interrupts properties
  dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
  dt-bindings: usb: Add RZ/V2M USB3DRD binding
  usb: gadget: Add support for RZ/V2M USB3DRD driver
  usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
  usb: host: xhci-plat: Improve clock handling in probe()
  usb: host: xhci-plat: Add reset support
  xhci: host: Add Renesas RZ/V2M SoC support
  arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
  arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and Host
  arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch

Christophe JAILLET (1):
  usb: host: xhci-plat: Remove useless DMA-32 fallback configuration

Geert Uytterhoeven (1):
  arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller support

Phil Edworthy (2):
  dt-bindings: usb: renesas, usb3-peri: Document RZ/V2M r9a09g011
    support
  usb: gadget: udc: renesas_usb3: Add support for RZ/V2M

 .../bindings/usb/renesas,rzv2m-usb3drd.yaml   | 129 ++++++++++++
 .../bindings/usb/renesas,usb-xhci.yaml        |  43 +++-
 .../bindings/usb/renesas,usb3-peri.yaml       |  63 ++++--
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  82 ++++++++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  45 +++++
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/renesas/r9a09g011-cpg.c           |  21 ++
 drivers/usb/gadget/udc/Kconfig                |  11 +
 drivers/usb/gadget/udc/Makefile               |   1 +
 drivers/usb/gadget/udc/renesas_usb3.c         | 191 +++++++++++++++---
 drivers/usb/gadget/udc/rzv2m_usb3drd.c        | 140 +++++++++++++
 drivers/usb/host/Kconfig                      |  11 +-
 drivers/usb/host/Makefile                     |   8 +-
 drivers/usb/host/xhci-plat.c                  | 152 +++++++-------
 drivers/usb/host/xhci-plat.h                  |   7 +
 drivers/usb/host/xhci-rcar.c                  | 102 +++++++++-
 drivers/usb/host/xhci-rcar.h                  |  55 -----
 drivers/usb/host/xhci-rzv2m.c                 |  38 ++++
 drivers/usb/host/xhci-rzv2m.h                 |  16 ++
 drivers/usb/typec/hd3ss3220.c                 |  29 +++
 include/linux/usb/rzv2m_usb3drd.h             |  20 ++
 21 files changed, 973 insertions(+), 193 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzv2m-usb3drd.yaml
 create mode 100644 drivers/usb/gadget/udc/rzv2m_usb3drd.c
 delete mode 100644 drivers/usb/host/xhci-rcar.h
 create mode 100644 drivers/usb/host/xhci-rzv2m.c
 create mode 100644 drivers/usb/host/xhci-rzv2m.h
 create mode 100644 include/linux/usb/rzv2m_usb3drd.h

-- 
2.25.1


