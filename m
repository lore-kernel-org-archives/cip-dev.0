Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8887BC46CCD
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:07:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.35075.1703113642283345487
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:07:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="191072745"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2023 08:07:35 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CDA1040BF9EC;
	Thu, 21 Dec 2023 08:07:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 20/30] riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
Date: Wed, 20 Dec 2023 23:06:36 +0000
Message-Id: <20231220230646.219816-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14156

commit b3e77da00f1b7b670983c69d0295f4ce132bf87c upstream.

Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
Single).

RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
r9a07g043f.dtsi includes RZ/Five SoC specific blocks.

Below are the RZ/Five SoC specific blocks added in the initial DTSI which
can be used to boot via initramfs on RZ/Five SMARC EVK:
- AX45MP CPU
- PLIC

[0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
new file mode 100644
index 000000000000..50134be548f5
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SoC
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define SOC_PERIPHERAL_IRQ(nr)	(nr + 32)
+
+#include <arm64/renesas/r9a07g043.dtsi>
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <12000000>;
+
+		cpu0: cpu@0 {
+			compatible = "andestech,ax45mp", "riscv";
+			device_type = "cpu";
+			reg = <0x0>;
+			status = "okay";
+			riscv,isa = "rv64imafdc";
+			mmu-type = "riscv,sv39";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x40>;
+			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+};
+
+&soc {
+	interrupt-parent = <&plic>;
+
+	plic: interrupt-controller@12c00000 {
+		compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
+		#interrupt-cells = <2>;
+		#address-cells = <0>;
+		riscv,ndev = <511>;
+		interrupt-controller;
+		reg = <0x0 0x12c00000 0 0x400000>;
+		clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
+		interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
+	};
+};
-- 
2.34.1


