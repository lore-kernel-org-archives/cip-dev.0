Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF203C3F6B0
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4769.1659438536866126129
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:08:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="128236700"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Aug 2022 20:08:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B236C4004934;
	Tue,  2 Aug 2022 20:08:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/24] arm64: dts: renesas: Add initial DTSI for
 RZ/G2LC SoC
Date: Tue,  2 Aug 2022 12:08:27 +0100
Message-Id: <20220802110850.1496057-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8998

commit 3a3c2a48d8c6ba586a2eda249b0e2f5f19609dfd upstream.

The RZ/G2L and RZ/G2LC SoCs are similar and they share the same DEVID.
RZ/G2LC has fewer peripherals compared to RZ/G2L.

SSI (3 channels vs 4 channels)
GbEthernet (1 channel vs 2 channels)
SCIFA (4 channels vs 5 channels)
ADC is only supported in RZ/G2L.

Add the initial DTSI for the RZ/G2LC SoC by reusing the common
r9a07g044.dtsi file with unsupported device nodes deleted in the below
SoC specific dtsi files.

r9a07g044c1.dtsi => RZ/G2LC R9A07G044C1 SoC specific parts
r9a07g044c2.dtsi => RZ/G2LC R9A07G044C2 SoC specific parts

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211216114305.5842-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi | 32 ++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi | 20 ++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
new file mode 100644
index 000000000000..1d57df706939
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c1.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2LC R9A07G044C1 SoC specific parts
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g044.dtsi"
+
+/ {
+	compatible = "renesas,r9a07g044c1", "renesas,r9a07g044";
+
+	cpus {
+		/delete-node/ cpu-map;
+		/delete-node/ cpu@100;
+	};
+
+	timer {
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&soc {
+	/delete-node/ ssi@1004a800;
+	/delete-node/ serial@1004c800;
+	/delete-node/ adc@10059000;
+	/delete-node/ ethernet@11c30000;
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi
new file mode 100644
index 000000000000..7bb8917fe421
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2LC R9A07G044C2 SoC specific parts
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a07g044.dtsi"
+
+/ {
+	compatible = "renesas,r9a07g044c2", "renesas,r9a07g044";
+};
+
+&soc {
+	/delete-node/ ssi@1004a800;
+	/delete-node/ serial@1004c800;
+	/delete-node/ adc@10059000;
+	/delete-node/ ethernet@11c30000;
+};
-- 
2.25.1


