Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F70CD1295
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.32453.1711527523389792077
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dxuZTOQI;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41485fcb8ccso22134995e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527522; x=1712132322; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoNezSeOY/X/XqPk8oPrqtHOHFKx1n/uiU9nKmiVwgI=;
        b=dxuZTOQIe/Kd5ufX4JKMJXJYWCJiyUhqt1g1mQamgonEeCNSAw+ufev6gAk9DWojy2
         AOK7CVE2v0MWEiGEYORZQA4o6veDta7spCwvja9Qe2oMubfZ+1OodkNi4X2sUuHJqFh2
         owoKKmWxcouHBUn1oJQAD2Wc6oU29pzQHpJ7T4us3tooV7tJsPOzYy3lOHr+hKd+garB
         +tcx77b7n4gLvBAo7D7h+dr4qaOcugxWgv6EldbH0YOlKRH5xmPhJP9vm8Ue1Qg9PRnx
         GxVgr7nqPBT/ZdBh9iw08f96XP2SFiM9SBwVA+WE/bQyZ6St1p+yJVtdrB1umwHiA42B
         BgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527522; x=1712132322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoNezSeOY/X/XqPk8oPrqtHOHFKx1n/uiU9nKmiVwgI=;
        b=xQjD/xXA52aUEkjERqQ/IvAWSnbuNzq0qbpaziqrUU2EH/Oivj35Lw10GkdXO0bRCD
         I7MOUoul7qJccIHMCEBG/0LVGE28/0t1FT00oFOKmfx/bYwvUBKCfQUiL//K5iaHs4kR
         GNg79Kl82vvgnjd4v7oxXlUBU0TULvgDnxv3oChTrYikJew0cneTMQuLGDqu2TdZc7XN
         4hvaeTZDQEtwaaJ1gHJK+bpmy5A8iiVx95ZMu6/9NJBL/IGsXSwtCERF5/OFgMoqVqws
         cIQ5dCbj85rK927H11fhP2+vf2OW/tOevazTL3X2Y8iil++tpXfTnHegwWt7tA4aDS4u
         S+FA==
X-Gm-Message-State: AOJu0YznwlaJ3/lZw/Qwlb/HMBfR4wTrcVOKUpmWZvLZEX/vqQ0OtPL1
	SGLTfmb+mASG4MyMN/klhibjov1hmR4OEkvJJIHFg7vzCgp9zh4WR5L6HpUH/wg=
X-Google-Smtp-Source: AGHT+IEfMV4FN6lpiCugcQWSMFJxeXSzgn0gw6wDvcX3PPXpD4q6lkF+bw4KU9FWTHrYe9yJBul5Dw==
X-Received: by 2002:a05:600c:3c96:b0:414:8e02:e432 with SMTP id bg22-20020a05600c3c9600b004148e02e432mr397123wmb.7.1711527520820;
        Wed, 27 Mar 2024 01:18:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 36/36] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for ETH{0/1}
Date: Wed, 27 Mar 2024 10:17:56 +0200
Message-Id: <20240327081756.2228036-37-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15453

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f4673e52dbab9d890d236ed75264653bcd43bac1 upstream.

The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
ETH1 respectively.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 53276350a85e..2df6c95b7826 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -77,6 +78,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -104,6 +107,8 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -151,7 +156,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(3, 2, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(3, 3, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(4, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(4, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(4, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(5, 1, 7)>; /* IRQ2 */
 	};
 
 	eth1_pins: eth1 {
@@ -169,7 +175,8 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(9, 1, 1)>, /* ET1_RXD0 */
 			 <RZG2L_PORT_PINMUX(9, 2, 1)>, /* ET1_RXD1 */
 			 <RZG2L_PORT_PINMUX(9, 3, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(10, 0, 1)>; /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(10, 0, 1)>, /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(18, 5, 1)>; /* IRQ7 */
 	};
 
 	sdhi0_emmc_pins: sd0emmc {
-- 
2.39.2


