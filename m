Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3FCD1297
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.32311.1711527519942506155
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gd3VJ54s;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414946b418dso2239595e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527518; x=1712132318; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YWVM5OqorjOMgRy2rOepDuk30m+2YYgf8uJM5gDFnI=;
        b=gd3VJ54sCi8pPn5EIeXcw9gp5poMSrSHlfWZTXbPIPt7p4yBB03WviqSfsunjFYnuy
         x/4Hff4RfuvvhUrsowxiTQYK6QcHux6zOzoDvfZ+HnWAiogwQszpwyc2rEyf241+SJ6g
         BoEprkcPXfhIUJdbCkxAWDlsHMAQNJmYsDe0iO3gfFOcaDFH35LQukPm9+2NZSLzWbFl
         GUMsQTUtx9g7AiFOoYk8WoMVyWoW++j/b0SJ3O+/kqAV8YurMdkeyp+Y75V5jE+ppKQK
         71lUyoPdNxB6UBVZXeFt/cQyoyFUW2+vA6rH1fEiDs2ijiyvUUy/ltMdaoH1I/INK9nk
         Sgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527518; x=1712132318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YWVM5OqorjOMgRy2rOepDuk30m+2YYgf8uJM5gDFnI=;
        b=K4yvKZL7mvZk9e04H6q1ruUgTFpjwQlY94SPayEcg83OhxdVU5WUoHfeiL16+MlO1D
         fc68ThyqkrbIelTCxHB7O4PBTvAdFMdoTfZWzaFvi7IrCfVJWAhuek+mhjDXWrf9TZ7j
         u21adxCkmDBDllgUlF2bz4yVTWQ00kKVFp1sTQQeDOJqhTTnSBknpBkiiGKXEH9tLvrB
         W17RtrHbXsEx38iYikX7yJx80ukTCHFDM6VGHB6czjOCAdLxrhOPZtHc5zfOygsgUDIn
         elcHQVSmus6dk4FVhLWR45czJP7JMD4lpXRy4tyxtI9LiTXJEeutQ8qzFaikKyMwxaJI
         uHbA==
X-Gm-Message-State: AOJu0YxZiQQCjHvXIFkIwKnle8TqgqoGmoi1f0gLgw256TOCMoSDZyUP
	LbTHI2QKNMqA/h78K+p16LPsCwyiZbc/mrO4S0HfXC4bw5eQM1RHrt8jCB/zefE=
X-Google-Smtp-Source: AGHT+IHZNvX4mHxLcUogc/sdto8hg6j5DWt+yosTWQqbEgeA/0LI+arqhrFlFVLF8AgJo8Dl/+T8eQ==
X-Received: by 2002:a7b:c3c1:0:b0:414:6c34:9ba0 with SMTP id t1-20020a7bc3c1000000b004146c349ba0mr2437563wmj.16.1711527518451;
        Wed, 27 Mar 2024 01:18:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 34/36] arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for ETH{0/1}
Date: Wed, 27 Mar 2024 10:17:54 +0200
Message-Id: <20240327081756.2228036-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15451

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ffd882417412ea7273ae14deec77711f6df54bbc upstream.

The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
and ETH1 respectively.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220722151155.21100-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 6b785957ab5f..0eb0c624d8c4 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 /* SW1[2] should be at position 2/OFF to enable 64 GB eMMC */
@@ -101,6 +102,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -127,6 +130,8 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ3 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -189,7 +194,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(1, 0, 1)>;  /* IRQ2 */
 	};
 
 	eth1_pins: eth1 {
@@ -207,7 +213,8 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(34, 1, 1)>, /* ET1_RXD0 */
 			 <RZG2L_PORT_PINMUX(35, 0, 1)>, /* ET1_RXD1 */
 			 <RZG2L_PORT_PINMUX(35, 1, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(36, 0, 1)>, /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(1, 1, 1)>;  /* IRQ3 */
 	};
 
 	gpio-sd0-pwr-en-hog {
-- 
2.39.2


