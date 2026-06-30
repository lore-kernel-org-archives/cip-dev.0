Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD1C44500
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:07 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19442.1782820143467024839
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BwmWx2q8;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4758bd3731bso453389f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820142; x=1783424942; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wJ1VRWrRbsZgraHS92jJg6ZlYYbGG8xeMkIDwZIQZQ=;
        b=BwmWx2q8+roF89zo85gxRwU3WrO0iJDCBHZCQ/pQf2BCjOPGfeeZer2h7Hekj3x4FZ
         Y53Pg0oumb1w1Yt/Li6JL5cXz/+pikDd+A59MRhBCJpwzbmVLorLPH+rna9lTmhISj48
         FJG9AzXZwO0J01zXgGkn4Y3q4aU/1oXa23brcWXs7oeNNNmT1lU7TjZG6ogAoIbB869f
         CBr487loAGlqrgZ/0xk3bjNMYPxM936usaeOnTC2pA4XLOohFYxuEhqEiqWav4Jk6bXz
         gqgTheWVlZyPimnLa4CedJpbSK0MkOuaZZD8I24e36DCR5l/xaRasQzEj/fcMw36NgO6
         6HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820142; x=1783424942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wJ1VRWrRbsZgraHS92jJg6ZlYYbGG8xeMkIDwZIQZQ=;
        b=O7SN3PZJE6jma/lHouArTHfBk3fq6ABq9uHXWw9nbN4xT1XCibEjsF2rps8v8vUt71
         LfiP+3rt8+z5epYlo0Ev2tqMGsEtDsYDp99kjWQaDO9SydR/cgFsdsMf5wxoL8ixvtQH
         gIOCzF7MzXMA4BWp7L3NldzmEIEgLAA1sR1gfhrIh/p6KMClUUfeISSLWuwlh7oHwSAA
         3gTITm55SkVLTzEhY4Cit61Lbi0zEiZqVD5BHAf+R7knhGfsMMD4ixpYY0ZrPTpUq5yJ
         VsV58q/1yoJHRSEYjE/p6Dp7ujb8ZtySdjVqX3LNpjcvniBOVaXgT4WHHKa9zePHZFW2
         3RSw==
X-Gm-Message-State: AOJu0YyN6K3ZJAi8YUGPhqfMxtIKsfYu7fsXErL6ibNQEuNNzKb5v+Y9
	s22jCD0X5T9WLz7BjXbxgVx5DfIAwCnTIoVaC4hdQKsM/2nQRoxtZMlj1F9iPQyn
X-Gm-Gg: AfdE7ckNtIH8/h6BbV7G6eSlGs/gWlQ8eMv0hzfZwEdZivlTAwuYbmKzhpTQwnkAqpL
	CKPt4c+QBshrwIrPf0XVh1XuL9G8EUuDCb2mmIqTKsFll2H5nhwaUAx/UngDOCy31iaDc133zc1
	vd+uFq4uEy8qZCDlmRrHNORpTlWO9FfBE8yKE241ryJKn7mXXib/62Cs0GLOKLA9X7tAJw++kGZ
	DE47s0kfP5coLXWxnjEgBe3P1IRboUW0mdLtxOKA0O3JBz+gSap1dTk4CpvAoblKTpzN6bWYOO4
	xT+YH3EAaucYQUNYaWsZuUu5ERnrixK3aSWNfkte2tcb+pe0Ul+NoS3/eCUErXMVcszd9boxjG0
	2KZbH4wTyIzBZ3q2DECrdhEZhMasuhcVoCgVBr6PlyUFvECi8FUXv9H3sQRjXnwdfH6FQ6Czz0w
	uJ0iXiyT+X3YlnHL+WBbctnWzAlqzvkhmEKZN82A==
X-Received: by 2002:a05:6000:400d:b0:474:8dbb:ccd0 with SMTP id ffacd0b85a97d-475dfa8909emr2071411f8f.19.1782820141319;
        Tue, 30 Jun 2026 04:49:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 33/39] arm64: dts: renesas: Add initial DTSI for RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:52 +0100
Message-ID: <20260630114813.92739-34-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23357

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit a57349a7a108b2ba824036de9c191a1d8080e517 ]

Add the initial DTSI for the RZ/G3L SoC.
The files in this commit have the following meaning:
  - r9a08g046.dtsi:    RZ/G3L family SoC common parts
  - r9a08g046l48.dtsi: RZ/G3L R9A08G046L48 SoC-specific parts

Add placeholders to reuse the code for the Renesas SMARC II carrier
board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260324114329.268249-9-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 212 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi |  13 ++
 2 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
new file mode 100644
index 000000000000..28b0c7558748
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3L SoC
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/clock/renesas,r9a08g046-cpg.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "renesas,r9a08g046";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a55";
+			reg = <0>;
+			device_type = "cpu";
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			device_type = "cpu";
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			device_type = "cpu";
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			device_type = "cpu";
+			next-level-cache = <&L3_CA55>;
+			enable-method = "psci";
+		};
+
+		L3_CA55: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-size = <0x80000>;
+			cache-level = <3>;
+		};
+	};
+
+	eth0_txc_tx_clk: eth0-txc-tx-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	eth0_rxc_rx_clk: eth0-rxc-rx-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	eth1_txc_tx_clk: eth1-txc-tx-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	eth1_rxc_rx_clk: eth1-rxc-rx-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@100ac000 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x100ac000 0 0x400>;
+			interrupts = <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 389 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@100ae000 {
+			reg = <0 0x100ae000 0 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			/* placeholder */
+		};
+
+		canfd: can@100c0000 {
+			reg = <0 0x100c0000 0 0x20000>;
+			/* placeholder */
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a08g046-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>,
+				 <&eth0_txc_tx_clk>, <&eth0_rxc_rx_clk>,
+				 <&eth1_txc_tx_clk>, <&eth1_rxc_rx_clk>;
+			clock-names = "extal",
+				      "eth0_txc_tx_clk", "eth0_rxc_rx_clk",
+				      "eth1_txc_tx_clk", "eth1_rxc_rx_clk";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a08g046-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "lpm_int", "ca55stbydone_int",
+					  "cm33stbyr_int", "ca55_deny";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			/* placeholder */
+		};
+
+		sdhi1: mmc@11c10000 {
+			reg = <0x0 0x11c10000 0 0x10000>;
+			/* placeholder */
+		};
+
+		pcie: pcie@11e40000 {
+			reg = <0 0x11e40000 0 0x10000>;
+			ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
+			device_type = "pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			/* placeholder */
+
+			pcie_port0: pcie@0,0 {
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				ranges;
+				device_type = "pci";
+				#address-cells = <3>;
+				#size-cells = <2>;
+				/* placeholder */
+			};
+		};
+
+		gic: interrupt-controller@12400000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x12400000 0 0x20000>,
+			      <0x0 0x12440000 0 0x80000>;
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
new file mode 100644
index 000000000000..39b114172af5
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3L R9A08G046L48 SoC specific parts
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r9a08g046.dtsi"
+
+/ {
+	compatible = "renesas,r9a08g046l48", "renesas,r9a08g046";
+};
-- 
2.43.0


