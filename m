Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F1D25B71
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:27:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12809.1769606815696538903
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:27:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: JOxbhdsgRFKRPS+1qIZ69Q==
X-CSE-MsgGUID: Hu2HYpoNQA+F3dCgl7umEg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jan 2026 22:27:05 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8071540325B4;
	Wed, 28 Jan 2026 22:27:04 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 07/12] thermal: renesas: Fix RZ/G3E fall-out
Date: Wed, 28 Jan 2026 13:26:44 +0000
Message-ID: <20260128132650.6955-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:27:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21756

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e649c3662b4fd9d4e01607c91a0facc7d9005570 upstream.

 - Restore sort order in MAINTAINERS and Kconfig,
 - Remove empty trailing line from Makefile.

Fixes: 19d3a401a617c68e ("thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/G3E SoC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 MAINTAINERS                      | 14 +++++++-------
 drivers/thermal/renesas/Kconfig  | 14 +++++++-------
 drivers/thermal/renesas/Makefile |  1 -
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b3afd158dba..50f44b9d6e8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19767,13 +19767,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/potentiometer/renesas,x9250.yaml
 F:	drivers/iio/potentiometer/x9250.c
 
-RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
-M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
-L:	linux-pm@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
-F:	drivers/thermal/renesas/rzg3s_thermal.c
-
 RENESAS RZ/G3E THERMAL SENSOR UNIT DRIVER
 M:	John Madieu <john.madieu.xa@bp.renesas.com>
 L:	linux-pm@vger.kernel.org
@@ -19781,6 +19774,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 F:	drivers/thermal/renesas/rzg3e_thermal.c
 
+RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+F:	drivers/thermal/renesas/rzg3s_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/renesas/Kconfig b/drivers/thermal/renesas/Kconfig
index 7780d80ca1fe..d55ea77c2eec 100644
--- a/drivers/thermal/renesas/Kconfig
+++ b/drivers/thermal/renesas/Kconfig
@@ -27,6 +27,13 @@ config RZG2L_THERMAL
 	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
 	  thermal framework.
 
+config RZG3E_THERMAL
+	tristate "Renesas RZ/G3E thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
+	  thermal framework.
+
 config RZG3S_THERMAL
 	tristate "Renesas RZ/G3S thermal driver"
 	depends on ARCH_R9A08G045 || COMPILE_TEST
@@ -34,10 +41,3 @@ config RZG3S_THERMAL
 	help
 	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
 	  thermal framework.
-
-config RZG3E_THERMAL
-	tristate "Renesas RZ/G3E thermal driver"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	help
-	  Enable this to plug the RZ/G3E thermal sensor driver into the Linux
-	  thermal framework.
diff --git a/drivers/thermal/renesas/Makefile b/drivers/thermal/renesas/Makefile
index 0ea592247572..8f5ae9af277c 100644
--- a/drivers/thermal/renesas/Makefile
+++ b/drivers/thermal/renesas/Makefile
@@ -5,4 +5,3 @@ obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
 obj-$(CONFIG_RZG3E_THERMAL)	+= rzg3e_thermal.o
 obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
-
-- 
2.51.0


