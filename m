Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC9C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6178.1682061505900396648
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156787005"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:25 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C92441AA65A;
	Fri, 21 Apr 2023 16:18:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 21/33] arm64: dts: renesas: Add initial device tree for RZ/V2M EVK
Date: Fri, 21 Apr 2023 08:17:17 +0100
Message-Id: <20230421071729.130347-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11294

From: Phil Edworthy <phil.edworthy@renesas.com>

commit ad1bd2bf658062c6edc5ff1ee1725565a4fc8930 upstream.

Add basic support for RZ/V2M EVK (based on R9A09G011):
- memory
- External input clock
- UART

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-13-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 44 +++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 414eab2bb2bc..44eafef2ea0a 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -63,3 +63,5 @@ dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044c2-smarc.dtb
 dtb-$(CONFIG_ARCH_R9A07G044) += r9a07g044l2-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc.dtb
+
+dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
new file mode 100644
index 000000000000..c207d8ce5523
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/V2M (r9a09g011) Evaluation Kit Board
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a09g011.dtsi"
+
+/ {
+	model = "RZ/V2M Evaluation Kit 2.0";
+	compatible = "renesas,rzv2mevk2", "renesas,r9a09g011";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@58000000 {
+		device_type = "memory";
+		/*
+		 * first 1.25GiB is reserved for ISP Firmware,
+		 * next 128MiB is reserved for secure area.
+		 */
+		reg = <0x0 0x58000000 0x0 0x28000000>;
+	};
+
+	memory@180000000 {
+		device_type = "memory";
+		reg = <0x1 0x80000000 0x0 0x80000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <48000000>;
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1


