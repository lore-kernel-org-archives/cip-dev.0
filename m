Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55ECC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10189.1639659298966442092
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="104171948"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D15F04012261;
	Thu, 16 Dec 2021 21:55:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/24] arm64: dts: renesas: Add initial device tree
 for RZ/G2L SMARC EVK
Date: Thu, 16 Dec 2021 12:54:34 +0000
Message-Id: <20211216125446.15451-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7135

commit 690ea5d394eb370973ffcb9ecda6a1855fe87d01 upstream.

Add basic support for RZ/G2L SMARC EVK (based on R9A07G044L2):
- memory
- External input clock
- SCIF

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210609153230.6967-12-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    | 21 +++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 27 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index dffefe030a76..8a5bc12a6d8d 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -56,3 +56,5 @@ dtb-$(CONFIG_ARCH_R8A77990) += r8a77990-ebisu.dtb
 dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak.dtb
 
 dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
+
+dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
new file mode 100644
index 000000000000..d3f72ec62f03
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC EVK board
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g044l2.dtsi"
+#include "rzg2l-smarc.dtsi"
+
+/ {
+	model = "Renesas SMARC EVK based on r9a07g044l2";
+	compatible = "renesas,smarc-evk", "renesas,r9a07g044l2", "renesas,r9a07g044";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
new file mode 100644
index 000000000000..adcd4f50519e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC EVK common parts
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		serial0 = &scif0;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
+
+&scif0 {
+	status = "okay";
+};
-- 
2.17.1


