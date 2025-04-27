Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1398FC369D1
	for <webhook@archiver.kernel.org>; Sun, 27 Apr 2025 19:17:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.32070.1745781366282420937
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Apr 2025 12:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: NMJX5bvDTYazyx5MS52G0A==
X-CSE-MsgGUID: 3vG6GZx5R6GHO8LFvzGrug==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Apr 2025 04:16:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 430814075A70;
	Mon, 28 Apr 2025 04:16:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 08/16] arm64: dts: renesas: Add initial DTS for RZ/V2H EVK board
Date: Sun, 27 Apr 2025 20:15:40 +0100
Message-ID: <20250427191548.130118-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250427191548.130118-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 27 Apr 2025 19:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18659

commit 2fddca72dc9591ea037fe86ad90a30708f4cb496 upstream.

Add initial DTS for RZ/V2H EVK board (based on R9A09G057H44), adding
the below support:
- Memory
- Clock inputs
- PINCTRL
- SCIF

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828124134.188864-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied changes for Makefile]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 61 +++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 48f1924ed3882..c978bbe7c5b3d 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -91,5 +91,7 @@ dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G047) += r9a09g047e57-smarc.dtb
 
+dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk.dtb
+
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += draak-ebisu-panel-aa104xd12.dtbo
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += salvator-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
new file mode 100644
index 0000000000000..47f6f2bf6925a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/V2H EVK board
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a09g057.dtsi"
+
+/ {
+	model = "Renesas RZ/V2H EVK Board based on r9a09g057h44";
+	compatible = "renesas,rzv2h-evk", "renesas,r9a09g057h44", "renesas,r9a09g057";
+
+	aliases {
+		serial0 = &scif;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x1 0xF8000000>;
+	};
+
+	memory@240000000 {
+		device_type = "memory";
+		reg = <0x2 0x40000000 0x2 0x00000000>;
+	};
+};
+
+&audio_extal_clk {
+	clock-frequency = <22579200>;
+};
+
+&pinctrl {
+	scif_pins: scif {
+		pins = "SCIF_TXD", "SCIF_RXD";
+		renesas,output-impedance = <1>;
+	};
+};
+
+&qextal_clk {
+	clock-frequency = <24000000>;
+};
+
+&rtxin_clk {
+	clock-frequency = <32768>;
+};
+
+&scif {
+	pinctrl-0 = <&scif_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.43.0


