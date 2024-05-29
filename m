Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F2FC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:38 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.8703.1716970530044064352
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aoIFuRv5;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b5898so14221425e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970528; x=1717575328; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy0JzQKtDy1pYtA9NTXZluynHW5V8Nkmn5JCqCnSOxM=;
        b=aoIFuRv5QouB9bGuGzBxgUfWRzsf2jXlaBedTfKmLJCVIMdMNFtHf/xs/Taks9uGK+
         8pDTKKWmXXMnc0B4bQZh8piVMs8CgEWzz3OT/1cBEY0mj7XB3u8s6rQ8WK7EFMHo3m8l
         9BE0i49GS7N+RV6woXIuqojKSa5UBhYk42VBxIKQ++RCpHnc6i0wD8BMas9B9IsJWjqK
         NbQSv+8wxey9obVAXYv1L+nhxdCT7f583DrOpPqne1FmqDJmeZAS+4rkSvDipzC1kLaG
         eju+QcHekMkoVaV6UPJfkThMb6rZ7+91mH2Dq/DWbdRHZbS7faHkIhfOJvdjDLEgzztC
         O6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970528; x=1717575328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy0JzQKtDy1pYtA9NTXZluynHW5V8Nkmn5JCqCnSOxM=;
        b=qyA7NgVj8e/Ifyx57XQOYDtXvnzj4pMz+ACmUKqxJgsVEvLhM74jhnB7n0Byg79GUG
         zym//TvfoQC3AKI3aOJbPkJgcJXTRb570Jv4ph3HA+28N8gYZfxD1cSbvPlukC2Q5OAE
         kiOF7FSYNeeHe0uOUCp619EKkLrMRGQ6g8pzThVHw2ul+OVDkO30CuHbgNAvnbyCOu5l
         DIYczpXyP8pdjFzfOfaFH/fcCrDntZySac/f1HR4y5qQJ2RcYVkvc/iW9HEuBOseVryc
         vs/+rDThTojOakmCKO8bJmK/HD+IJw7+MNgVB3w8pztLKfPOA/OvWP+ht4ci+Y4lLtvw
         gmag==
X-Gm-Message-State: AOJu0YwZHlN0zfeMdvpNR7AgwBrQlNIb5lLmc4ddY8BSwtFALj/qSgz2
	nvvi4rMz1D0DLrajMLHFOryWVRlZYXwDAykn1MrZ6k6AjCYY+qkKksBhWW4be+w=
X-Google-Smtp-Source: AGHT+IF2EL0cr5G1CX/r8ft6YWobHhMoDqINVyoJ08s7u/49KNmfb8UGxOT+nopTERbFsrhdlc2JdQ==
X-Received: by 2002:a05:600c:3553:b0:418:29d4:1964 with SMTP id 5b1f17b1804b1-4210895dd5emr104338245e9.0.1716970528606;
        Wed, 29 May 2024 01:15:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 32/33] arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces
Date: Wed, 29 May 2024 11:14:33 +0300
Message-Id: <20240529081434.639519-33-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16060

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 932ff0c802c678bb6c7a98740eff930dad41fece upstream.

The RZ/G3S Smarc Module has Ethernet PHYs (KSZ9131) connected to each
Ethernet IP.  For this, add proper DT descriptions to enable Ethernet
communication through these PHYs.

The interface b/w PHYs and MACs is RGMII.  The skew settings were set to
zero as based on phy-mode (rgmii-id) the KSZ9131 driver enables internal
DLL, which adds a 2ns delay b/w clocks (TX/RX) and data signals.

Different pin settings were applied to TXC and TX_CTL compared with the
rest of the RGMII pins to comply with requirements for these pins
imposed by HW manual of RZ/G3S (see chapters "Ether Ch0 Voltage Mode
Control Register (ETH0_POC)", "Ether Ch1 Voltage Mode Control Register
(ETH1_POC)", for power source selection, "Ether MII/RGMII Mode Control
Register (ETH_MODE)" for output-enable and "Input Enable Control
Register (IEN_m)" for input-enable configurations).

Also enable the Ethernet interfaces by selecting SW_CONFIG3 = SW_ON.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231207070700.4156557-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 141 +++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index f59094701a4a..f062d4ad78b7 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -26,7 +26,7 @@
  *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
  */
 #define SW_CONFIG2	SW_ON
-#define SW_CONFIG3	SW_OFF
+#define SW_CONFIG3	SW_ON
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
@@ -35,6 +35,9 @@ aliases {
 		mmc0 = &sdhi0;
 #if SW_CONFIG3 == SW_OFF
 		mmc2 = &sdhi2;
+#else
+		eth0 = &eth0;
+		eth1 = &eth1;
 #endif
 	};
 
@@ -89,6 +92,60 @@ vcc_sdhi2: regulator2 {
 	};
 };
 
+#if SW_CONFIG3 == SW_ON
+&eth0 {
+	pinctrl-0 = <&eth0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy0: ethernet-phy@7 {
+		reg = <7>;
+		interrupt-parent = <&pinctrl>;
+		interrupts = <RZG2L_GPIO(12, 0) IRQ_TYPE_EDGE_FALLING>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+
+&eth1 {
+	pinctrl-0 = <&eth1_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy1: ethernet-phy@7 {
+		reg = <7>;
+		interrupt-parent = <&pinctrl>;
+		interrupts = <RZG2L_GPIO(12, 1) IRQ_TYPE_EDGE_FALLING>;
+		rxc-skew-psec = <0>;
+		txc-skew-psec = <0>;
+		rxdv-skew-psec = <0>;
+		txen-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+#endif
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
@@ -136,6 +193,88 @@ &sdhi2 {
 #endif
 
 &pinctrl {
+	eth0-phy-irq-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(12, 0) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "eth0-phy-irq";
+	};
+
+	eth0_pins: eth0 {
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* ET0_TXC */
+			power-source = <1800>;
+			output-enable;
+			input-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		tx_ctl {
+			pinmux = <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* ET0_TX_CTL */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(1, 2, 1)>,	/* ET0_TXD0 */
+				 <RZG2L_PORT_PINMUX(1, 3, 1)>,	/* ET0_TXD1 */
+				 <RZG2L_PORT_PINMUX(1, 4, 1)>,	/* ET0_TXD2 */
+				 <RZG2L_PORT_PINMUX(2, 0, 1)>,	/* ET0_TXD3 */
+				 <RZG2L_PORT_PINMUX(3, 0, 1)>,	/* ET0_RXC */
+				 <RZG2L_PORT_PINMUX(3, 1, 1)>,	/* ET0_RX_CTL */
+				 <RZG2L_PORT_PINMUX(3, 2, 1)>,	/* ET0_RXD0 */
+				 <RZG2L_PORT_PINMUX(3, 3, 1)>,	/* ET0_RXD1 */
+				 <RZG2L_PORT_PINMUX(4, 0, 1)>,	/* ET0_RXD2 */
+				 <RZG2L_PORT_PINMUX(4, 1, 1)>,	/* ET0_RXD3 */
+				 <RZG2L_PORT_PINMUX(4, 3, 1)>,	/* ET0_MDC */
+				 <RZG2L_PORT_PINMUX(4, 4, 1)>,	/* ET0_MDIO */
+				 <RZG2L_PORT_PINMUX(4, 5, 1)>;	/* ET0_LINKSTA */
+			power-source = <1800>;
+		};
+	};
+
+	eth1-phy-irq-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(12, 1) GPIO_ACTIVE_LOW>;
+		input;
+		line-name = "eth1-phy-irq";
+	};
+
+	eth1_pins: eth1 {
+		txc {
+			pinmux = <RZG2L_PORT_PINMUX(7, 0, 1)>;	/* ET1_TXC */
+			power-source = <1800>;
+			output-enable;
+			input-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		tx_ctl {
+			pinmux = <RZG2L_PORT_PINMUX(7, 1, 1)>;	/* ET1_TX_CTL */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(7, 2, 1)>,	/* ET1_TXD0 */
+				 <RZG2L_PORT_PINMUX(7, 3, 1)>,	/* ET1_TXD1 */
+				 <RZG2L_PORT_PINMUX(7, 4, 1)>,	/* ET1_TXD2 */
+				 <RZG2L_PORT_PINMUX(8, 0, 1)>,	/* ET1_TXD3 */
+				 <RZG2L_PORT_PINMUX(8, 4, 1)>,	/* ET1_RXC */
+				 <RZG2L_PORT_PINMUX(9, 0, 1)>,	/* ET1_RX_CTL */
+				 <RZG2L_PORT_PINMUX(9, 1, 1)>,	/* ET1_RXD0 */
+				 <RZG2L_PORT_PINMUX(9, 2, 1)>,	/* ET1_RXD1 */
+				 <RZG2L_PORT_PINMUX(9, 3, 1)>,	/* ET1_RXD2 */
+				 <RZG2L_PORT_PINMUX(10, 0, 1)>,	/* ET1_RXD3 */
+				 <RZG2L_PORT_PINMUX(10, 2, 1)>,	/* ET1_MDC */
+				 <RZG2L_PORT_PINMUX(10, 3, 1)>,	/* ET1_MDIO */
+				 <RZG2L_PORT_PINMUX(10, 4, 1)>;	/* ET1_LINKSTA */
+			power-source = <1800>;
+		};
+	};
+
 	sdhi0_pins: sd0 {
 		data {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
-- 
2.39.2


