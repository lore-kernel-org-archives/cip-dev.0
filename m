Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E844CCA479
	for <webhook@archiver.kernel.org>; Mon, 18 Jul 2022 09:24:51 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.25202.1658136274779570356
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:24:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800";
   d="scan'208";a="128219434"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2022 18:24:44 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 875A64007548;
	Mon, 18 Jul 2022 18:24:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 5.10.y-cip 05/12] arm64: defconfig: Enable additional
 support for Renesas platforms
Date: Mon, 18 Jul 2022 10:24:23 +0100
Message-Id: <20220718092430.382889-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Jul 2022 09:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8851

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2e8a3335472461927e57d1741ccf1791ff416075 upstream.

Increase build and test coverage by enabling support for more hardware
present on Renesas SoCs and boards:
  - Renesas RSPI, RZ/G2L thermal, RZ/G2L WDT watchdog, and OSTM timer,
    as used on the RZ/G2L SMARC EVK board,
  - R-Car Image Signal Processor (ISP) and Display Unit embedded MIPI
    DSI encoder on R-Car V3U, as used on the Falcon board.

All of the above are modular, except for thermal, watchdog, and timer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/c9800d67f91a90d418a3ce44c59109ae0a87b2d8.1643373223.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[biju: Removed R-Car V3U configs]
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7575dbd6f57c..58a79a3e1cd0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -465,6 +465,7 @@ CONFIG_SPI_ORION=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_RPCIF=m
+CONFIG_SPI_RSPI=m
 CONFIG_SPI_QCOM_QSPI=m
 CONFIG_SPI_QUP=y
 CONFIG_SPI_QCOM_GENI=m
@@ -540,6 +541,7 @@ CONFIG_IMX8MM_THERMAL=m
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
+CONFIG_RZG2L_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
@@ -563,6 +565,7 @@ CONFIG_QCOM_WDT=m
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
+CONFIG_RENESAS_RZG2LWDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
 CONFIG_MFD_ALTERA_SYSMGR=y
@@ -909,6 +912,7 @@ CONFIG_SM_GPUCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
+CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
 CONFIG_PLATFORM_MHU=y
-- 
2.25.1


