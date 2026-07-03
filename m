Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D79C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:38 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89977.1783076376804723286
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=E+HXp30P;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47122683cf3so318015f8f.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076375; x=1783681175; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RARvCY2YQohhIPnLer2qb9a10p4AQga48yte6Ix5x5Y=;
        b=E+HXp30P6N5BVJwSDBjGY8/MqkNU8KxZpYw7/5ZLo6GX47osexKG/djoRB3+P16htP
         hn5KW5UOHaSaVv6RzlY2YYsepId1PPCIQIQFpWXUJ8vuUr0n1w+u0brXUxnCFeKtJw9m
         I2GNhKqoSholDoJ6Hzy1dDZvQRljw33Ckaif38mMuTp9FHSpc/hwOghjdGr5ZNjMgkoT
         IXNbL4WxHiJKewoEDUeV9ZKU7mOktxg4j8vxUJLUesv09R+/EtW+KSuZAaHFPTD7OvHN
         QJ/i/lwUET3sta1BXM1e8Rko1rDoy6sVYGwC37hkxR27euKZZEzLSOcfo7BwYzm1aQsO
         tC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076375; x=1783681175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RARvCY2YQohhIPnLer2qb9a10p4AQga48yte6Ix5x5Y=;
        b=LTglWIRdDAzxwQsQsAbbHlw1zbD1ahFauMTaJhCWvGQ+NZiR1f9Pmv2wea7NZ2qI2g
         nb0zRsbghHmbDUt238y4ZC13a2koDVYZhfGbkRsP423UrgHFxrrP3TSYJjmJKWT8jwF7
         Dypg8iGuDm+PJWtiSKlP5zd/s/9JynSohuoTNLa6t3I489iRjllIt+tBrHPh0OuIjWRt
         K/znXcqLloPRKOnuoNhU0mjHNeLohGfuCgtAG8K0wq7IJVCLvMTAJJoLS1bbac2rZXFC
         n7CvWYUdsa1UHH1lSLFP20nCc5TU7ilRUMKVKId6aTrX3s/FenX7F+1Dl1vkQOtWPlGK
         rpMw==
X-Gm-Message-State: AOJu0Yxg4Fg0TA99txkD+ghpcwRwit5/QLCiaYvSpkKD9HDeu+PNz45f
	UomcMJTMyCwzKnUb6xJVhjVGk3Ck7UrL7cJvNokb8jM3XFs4llnc4vqFcWNLqRVs
X-Gm-Gg: AfdE7cnuBAYgKSrHNkUR3FXTeNwPZMgC4jBx/wkH97yc2tfA08nYzZNWNvyKJUCsfSf
	hKDLWp5Bd9z/xL/gzdPKAWXro702y2LOjc74v/gDthfz6oEbwMuiORz0MXTPSMnKCoitNelMT6W
	IB0js68INiXZD58PKzBsKbh6162I7OSV4iC+7bZ5aw9+gga1G+ckUCZS+MyuikWBEceXNzZUTqv
	B7+yvJdN2ihXDxscORt44FXJ9/7Tutce/a1uoryBgM1D/IIgj7x/WqNIiSrdBQ+wYG+UPpm7PvU
	C74emjCQCnlMB8c2YgcfakgsgG6L76QNOlDUltoSaXwJOcAnhUuJdEVbFGj6Fo9fCtYkNU3+k3Q
	7v7+jp7YpduxsqFu43X+OCkBFry+nyNJRo0h2Ae9kc/mlI5t7i3/JY3pkqBazXQ4GdOq+BGgRQt
	IpL6UjepRRg3sGD+nFD+Lc
X-Received: by 2002:a05:6000:610:b0:46d:d5db:9a with SMTP id ffacd0b85a97d-4775abab06dmr14813228f8f.46.1783076374939;
        Fri, 03 Jul 2026 03:59:34 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:34 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/23] arm64: dts: renesas: rzg3l-smarc-som: Enable eth1 (GBETH1) interface
Date: Fri,  3 Jul 2026 11:59:13 +0100
Message-ID: <20260703105923.251255-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23441

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 8a59e4f535a876fe94034f3a1e44b371d1fe363f ]

Enable the Gigabit Ethernet Interface (GBETH1) populated on the RZ/G3L
SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430125342.439755-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index c7227a865fa4..f53e6332e2f4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -10,6 +10,7 @@ / {
 
 	aliases {
 		ethernet0 = &eth0;
+		ethernet1 = &eth1;
 	};
 
 	memory@48000000 {
@@ -32,6 +33,19 @@ &eth0_rxc_rx_clk {
 	clock-frequency = <125000000>;
 };
 
+&eth1 {
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+
+	pinctrl-0 = <&eth1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&eth1_rxc_rx_clk {
+	clock-frequency = <125000000>;
+};
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
@@ -56,6 +70,26 @@ phy0: ethernet-phy@7 {
 	};
 };
 
+&mdio1 {
+	phy1: ethernet-phy@7 {
+		compatible = "ethernet-phy-id0022.1640";
+		reg = <7>;
+		interrupts-extended = <&icu 16 IRQ_TYPE_LEVEL_LOW>;
+		rxc-skew-psec = <1400>;
+		txc-skew-psec = <1400>;
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
 &pinctrl {
 	eth0_pins: eth0 {
 		txc {
@@ -83,4 +117,31 @@ ctrl {
 				 power-source = <1800>;
 		};
 	};
+
+	eth1_pins: eth1 {
+		txc {
+			pinmux = <RZG3L_PORT_PINMUX(E, 1, 1)>;  /* ETH1_TXC_REF_CLK */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		ctrl {
+			pinmux = <RZG3L_PORT_PINMUX(D, 0, 1)>, /* MDIO */
+				 <RZG3L_PORT_PINMUX(D, 1, 1)>, /* MDC */
+				 <RZG3L_PORT_PINMUX(D, 2, 1)>, /* RX_CTL */
+				 <RZG3L_PORT_PINMUX(D, 3, 1)>, /* TX_CTL */
+				 <RZG3L_PORT_PINMUX(E, 0, 1)>, /* RXC */
+				 <RZG3L_PORT_PINMUX(E, 2, 1)>, /* TXD0 */
+				 <RZG3L_PORT_PINMUX(E, 3, 1)>, /* TXD1 */
+				 <RZG3L_PORT_PINMUX(E, 4, 1)>, /* TXD2 */
+				 <RZG3L_PORT_PINMUX(E, 5, 1)>, /* TXD3 */
+				 <RZG3L_PORT_PINMUX(E, 6, 1)>, /* RXD0 */
+				 <RZG3L_PORT_PINMUX(E, 7, 1)>, /* RXD1 */
+				 <RZG3L_PORT_PINMUX(F, 0, 1)>, /* RXD2 */
+				 <RZG3L_PORT_PINMUX(F, 1, 1)>, /* RXD3 */
+				 <RZG3L_PORT_PINMUX(F, 2, 15)>; /* PHY_INTR */
+				 power-source = <1800>;
+		};
+	};
 };
-- 
2.43.0


