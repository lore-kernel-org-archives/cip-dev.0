Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B8D25B65
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:25:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13088.1769606735411742880
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:25:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: f+tTLGONRACNOAO+71qQzw==
X-CSE-MsgGUID: XVaaevCZRiuZSj6clf5lFw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jan 2026 22:25:36 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EA7104172F18;
	Wed, 28 Jan 2026 22:25:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 06/11] thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
Date: Wed, 28 Jan 2026 13:25:15 +0000
Message-ID: <20260128132522.6902-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
References: <20260128132522.6902-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:25:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21743

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 19d3a401a617c68e9487f55b9f2efe213f8f949d upstream.

The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block designed
to monitor the chip's junction temperature. This sensor is connected to
channel 1 of the APB port clock/reset and provides temperature measurements.

It also requires calibration values stored in the system controller registers
for accurate temperature measurement. Add a driver for the Renesas RZ/G3E TSU.

[ dlezcano: Fixed conflict with "renesas: Add support for RZ/G3S" ]

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250917170202.197929-3-john.madieu.xa@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 MAINTAINERS              | 7 +++++++
 drivers/thermal/Kconfig  | 7 +++++++
 drivers/thermal/Makefile | 1 +
 3 files changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 061d208b5a9f..6ec53b8ac3b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17690,6 +17690,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
 F:	drivers/thermal/renesas/rzg3s_thermal.c
 
+RENESAS RZ/G3E THERMAL SENSOR UNIT DRIVER
+M:	John Madieu <john.madieu.xa@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+F:	drivers/thermal/renesas/rzg3e_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4bd995d9eb08..161e887bf13c 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -373,6 +373,13 @@ config RZG3S_THERMAL
 	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
 	  thermal framework.
 
+config RZG3E_THERMAL
+	tristate "Renesas RZ/G3E thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	 Enable this to plug the RZ/G3E thermal sensor driver into the Linux
+	 thermal framework
+
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index a3498d4cb553..5bda83243bae 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-$(CONFIG_RZG3E_THERMAL)	+= rzg3e_thermal.o
 obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
-- 
2.51.0


