Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3321D25B6B
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:27:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12809.1769606815696538903
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: oiIObWMoQ3mSXGX9vpuWLA==
X-CSE-MsgGUID: Cv45pP4RTM2j0AaDMQS8rg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jan 2026 22:27:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF4FD40325B4;
	Wed, 28 Jan 2026 22:27:02 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 06/12] thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
Date: Wed, 28 Jan 2026 13:26:43 +0000
Message-ID: <20260128132650.6955-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:27:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21755

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
 MAINTAINERS                      | 7 +++++++
 drivers/thermal/renesas/Kconfig  | 7 +++++++
 drivers/thermal/renesas/Makefile | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a169a7212db..7b3afd158dba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19774,6 +19774,13 @@ S:	Maintained
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
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index 566478797095..7780d80ca1fe 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -34,3 +34,10 @@ config RZG3S_THERMAL
 	help
 	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
 	  thermal framework.
+
+config RZG3E_THERMAL
+	tristate "Renesas RZ/G3E thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
+	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
index 1feb5ab78827..0ea592247572 100644
--- a/drivers/thermal/renesas/Makefile
+++ b/drivers/thermal/renesas/Makefile
@@ -3,4 +3,6 @@
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-$(CONFIG_RZG3E_THERMAL)	+= rzg3e_thermal.o
 obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
+
-- 
2.51.0


