Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F2C44502
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90788.1783076376267514807
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kVfJp+D8;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-473ba028d46so486081f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076374; x=1783681174; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ/FTicVIYPS/3LC8/MsozhmI893jU0srT954u/icoM=;
        b=kVfJp+D85HHgH2OKSHGFPOMC23X8dbPkoKBt7ergCuhKvVnr2BdTx28IR1Tb8BvOMx
         jw4hBwB0DRUJtZb9qz5pHoGP/h0Fwx8eX+x5ncSO6/PNlAGrYh5kbJP7gfUZFqz3LPag
         dJdB4WPKapMYiVSgmymY+J+Pi5VFIC96otM6Elvj/N7ik5s8ieSZjHxi0U//i+FPZdOg
         Jxfa7VDEBBu+HRikt9eL6a3ZTtIDGs1GmFBtqDGlZFACUPlF4fmZEfs/ssHz+aRgYbSt
         pHFenMTnPXQir6zKgiUJJ+Q5HpNY0tPC71wsKXG9D2lrGJIQJqqHT1Doz5xmWVcY9JQ3
         VXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076374; x=1783681174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQ/FTicVIYPS/3LC8/MsozhmI893jU0srT954u/icoM=;
        b=gjdOIVkOzNQWif3AqNvE9TQaQXr62ByW+ujMvtUa4PYIAtGaqfkWwZRSTIqnMREHXV
         cREuKoLC192QEgjG7NmKVBqNjDvgxUdHBdGZcZN3CUDvCf9mNgqRbVhFWlM/LTqeqt7u
         g+3gYaSssvVd/DkppsiCqC3m7/h5uOfRjEoLMXKLR+cggZVOZvsnhOSDHroOXKTiXrFe
         0oky1vd3Iu5HO3joSeZah+yH9OZFZIJXo8yekO5yhCMj0huqKz1Zu1bMUO0FfDTCN7+2
         NIxeVwojLjGh9ok1b8Yphp8ABT8JWqnTCND5ptyPlZ97+CRshqSR1B6N0GWH4iNtLZMd
         o8wg==
X-Gm-Message-State: AOJu0Yy7TSrRRvxfKrhfhhTgQZJFITdN2bR2PvG1XauDv2HcWaz6OKie
	R8+vY+59Di1gW5V8Ss+jkpTwYQqMqVnvxiYMlxrlyc1Dv/cR4d8EnW3h9fn8jEwO
X-Gm-Gg: AfdE7clYKQk6WuzMkrckULWJyG9vT81r5Us0FvTWTJouPxmKMcO8bAE+ClcSNIrax4J
	xcTBnRoWHqxq9EWrUAKW8kz6vtcEWFTdWtNFCNkpWHj9Gw2q3gZD0AlPbVOofVNkmwptB3hDMmF
	Nj4BkeD6Gr8JMtdtTFXTk7ypiUjqiRqNX4pLr4omHLtJpzcwE2dQ3VCmelVbkPEMUGR/poetD3L
	HLFTtlpxXJI4GRHOyp9MTWaGvqHFacKFQYM9X0YasgvvgBvSU2oPvpt+NogQ+8hGUAjniIi0bn8
	4SDNsCG/ivkByvRdl+S/aWsEsyKhD8Em8kfTFmDdBKBnDlUr6xxgqxyob5sejOuD7PCLEG+ET/A
	P7SbPEs4oa718Z7Cf5j1cWC2vDcoTydSvqYXe6M7JiYVpjNsSWm/cBoTCeu2+fVchPn5ygaxc96
	Oc9/RoXNOPTYJMgsFZUrX2
X-Received: by 2002:adf:e195:0:b0:460:64e8:2553 with SMTP id ffacd0b85a97d-47757e57472mr14060845f8f.4.1783076374418;
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
Subject: [PATCH 6.12.y-cip 21/23] arm64: dts: renesas: rzg3l-smarc-som: Add pinctrl configuration for ETH0
Date: Fri,  3 Jul 2026 11:59:12 +0100
Message-ID: <20260703105923.251255-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23440

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 72411a23c3942a2d5462f1695f0bceaf1c018bf7 ]

Add pin control configuration for the ETH0 Ethernet interface on the
RZ/G3L SMARC SoM board and also enable hotplug support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260430125342.439755-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   |  1 +
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index acead2b1c842..0ae052238b3b 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -14,6 +14,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/renesas,r9a08g046-pinctrl.h>
 #include "r9a08g046l48.dtsi"
 #include "rzg3l-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index fb781d9035aa..c7227a865fa4 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -23,6 +23,8 @@ &eth0 {
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
 
+	pinctrl-0 = <&eth0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 };
 
@@ -38,6 +40,7 @@ &mdio0 {
 	phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640";
 		reg = <7>;
+		interrupts-extended = <&icu 3 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <1400>;
 		txc-skew-psec = <1400>;
 		rxdv-skew-psec = <0>;
@@ -52,3 +55,32 @@ phy0: ethernet-phy@7 {
 		txd3-skew-psec = <0>;
 	};
 };
+
+&pinctrl {
+	eth0_pins: eth0 {
+		txc {
+			pinmux = <RZG3L_PORT_PINMUX(B, 1, 1)>;  /* ETH0_TXC_REF_CLK */
+			power-source = <1800>;
+			output-enable;
+			drive-strength-microamp = <5200>;
+		};
+
+		ctrl {
+			pinmux = <RZG3L_PORT_PINMUX(A, 0, 1)>, /* MDIO */
+				 <RZG3L_PORT_PINMUX(A, 1, 1)>, /* MDC */
+				 <RZG3L_PORT_PINMUX(A, 2, 1)>, /* RX_CTL */
+				 <RZG3L_PORT_PINMUX(A, 3, 1)>, /* TX_CTL */
+				 <RZG3L_PORT_PINMUX(B, 0, 1)>, /* RXC */
+				 <RZG3L_PORT_PINMUX(B, 2, 1)>, /* TXD0 */
+				 <RZG3L_PORT_PINMUX(B, 3, 1)>, /* TXD1 */
+				 <RZG3L_PORT_PINMUX(B, 4, 1)>, /* TXD2 */
+				 <RZG3L_PORT_PINMUX(B, 5, 1)>, /* TXD3 */
+				 <RZG3L_PORT_PINMUX(B, 6, 1)>, /* RXD0 */
+				 <RZG3L_PORT_PINMUX(B, 7, 1)>, /* RXD1 */
+				 <RZG3L_PORT_PINMUX(C, 0, 1)>, /* RXD2 */
+				 <RZG3L_PORT_PINMUX(C, 1, 1)>, /* RXD3 */
+				 <RZG3L_PORT_PINMUX(C, 2, 15)>; /* PHY_INTR */
+				 power-source = <1800>;
+		};
+	};
+};
-- 
2.43.0


