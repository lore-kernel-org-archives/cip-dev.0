Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403DC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59142.1722267074879486248
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908930"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E92B44006C72;
	Tue, 30 Jul 2024 00:31:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/13] RZ/G2L enhancements
Date: Mon, 29 Jul 2024 16:30:39 +0100
Message-ID: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16654

This patch series aim to add below enhancements on RZ/G2L SoCs.
1) Add VBUS regulator to control vbus voltage
2) Update correct procedure for cleating Alarm
3) Fix lockdep assert warning on DMA driver

All the patches are cherry-picked from the mainline.

Biju Das (12):
  reset: rzg2l-usbphy-ctrl: Move reset controller registration
  regulator: core: Add helper for allow HW access to enable/disable
    regulator
  dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document USB VBUS
    regulator
  reset: renesas: Add USB VBUS regulator device as child
  regulator: Add Renesas RZ/G2L USB VBUS regulator driver
  regulator: renesas-usb-vbus-regulator: Update the default
  phy: renesas: phy-rcar-gen3-usb2: Control VBUS for RZ/G2L SoCs
  arm64: dts: renesas: rz-smarc: Replace fixed regulator for USB VBUS
  dmaengine: sh: rz-dmac: Fix lockdep assert warning
  dt-bindings: watchdog: dlg,da9062-watchdog: Drop blank space
  rtc: isl1208: Add a delay for clearing alarm
  rtc: isl1208: Update correct procedure for clearing alarm

Mark Brown (1):
  regulator: Further restrict RZG2L USB VBCTRL regulator dependencies

 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 10 +++
 .../watchdog/dlg,da9062-watchdog.yaml         |  2 +-
 Documentation/power/regulator/consumer.rst    |  6 ++
 .../boot/dts/renesas/rz-smarc-common.dtsi     | 11 +--
 drivers/dma/sh/rz-dmac.c                      |  2 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  8 +-
 drivers/regulator/Kconfig                     |  9 +++
 drivers/regulator/Makefile                    |  1 +
 drivers/regulator/core.c                      | 28 +++++++
 .../regulator/renesas-usb-vbus-regulator.c    | 74 +++++++++++++++++++
 drivers/reset/reset-rzg2l-usbphy-ctrl.c       | 63 ++++++++++++----
 drivers/rtc/rtc-isl1208.c                     | 25 +++++--
 include/linux/regulator/consumer.h            |  7 ++
 13 files changed, 217 insertions(+), 29 deletions(-)
 create mode 100644 drivers/regulator/renesas-usb-vbus-regulator.c

-- 
2.43.0


