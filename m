Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090ECD12AD
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.32451.1711527521051102206
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JCF8Mq5S;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41488f9708fso20260945e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527519; x=1712132319; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbjLZQDt499ZwEF1iBm4NhaAGon96fzXArIcfhll/z0=;
        b=JCF8Mq5SxasNIYU1vyycEQpFQXwiC9zShoMv5BJL5U+X4Egq4Ma1R5q148naYPbLUu
         XHjICFG/hbB/auNWUvo+kBf4g0fxaiLplh6/kZMOib2LH2rmT93M2NllIxpWuKx8xjK1
         lhkUXmqz6hHjePrId+G0pHvupC1IgMRkcmS1B/yKJhtgbl/9TOwECZj3dTFoaggim+fV
         xjakiIyMx0ib1grPo8Qdm9JwoC9u6EqICQY6gkX4T4RatoKaVFj9WwCWQXlUdemAVzQz
         ZJtdksEyjrIfqYQ24e2TD85szsWFQjy9t+OpSVO4kXPTW8taOEB4IsJZ4v/aic5BHjt5
         mc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527519; x=1712132319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbjLZQDt499ZwEF1iBm4NhaAGon96fzXArIcfhll/z0=;
        b=WdjAVaU6wBVwd4r8BC3/nzB2rGP5UFrONk5Rv6hhZPY5t4lG2HwS3zxltXAttkskTI
         FTss+B+CqmgschthT/NTpPyNEKu3z3OqtYr95eOmkAxuyx2Kkp5BXfQrXiufZIf8e29O
         bGRHwTF4WFPwVIg9F/UzZyWUCFD7j6KwF03cWd+R12lo+jYEIrPMhlGdbdlWCSSaCoRF
         wfMT28IziWwxGMo1KKRGwqsDxiulm4l3CaVB5q+nwjxkbsK9c+OHnbo+hldQaocUelkS
         EGEy7vPKyqRF3WAccinnmtKZCX6puXFpbhMJlqsCYpcFa5qgmTtNCO3SFZIUFDPO/ymJ
         ETKQ==
X-Gm-Message-State: AOJu0Ywv0X7cCINfEJmJ7wHZfIPTMJaF7QLCPQQ5HBub5/vEkekCaJsP
	rDB0/0lFhDW8ZsKwNYmes6LsqaeUVkuGwahbwUTBrJOvM4im0tg5SpLbkKxvmWw=
X-Google-Smtp-Source: AGHT+IHTCB6m53qvq0FCisIRPKXYwxYIPvF561bqgJGNtAPhusYg+mizOMu6CVhVqJ4/fan5N7Ld5Q==
X-Received: by 2002:a05:600c:1547:b0:414:88a2:fb7b with SMTP id f7-20020a05600c154700b0041488a2fb7bmr1186085wmg.11.1711527519517;
        Wed, 27 Mar 2024 01:18:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 35/36] arm64: dts: renesas: rzg2lc-smarc-som: Add PHY interrupt support for ETH0
Date: Wed, 27 Mar 2024 10:17:55 +0200
Message-Id: <20240327081756.2228036-36-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15452

From: Biju Das <biju.das.jz@bp.renesas.com>

commit fe7297bf011bf6910d76010ba1763daf1286cbf4 upstream.

The PHY interrupt (INT_N) pin is connected to IRQ0 for ETH0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230712151153.81965-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 370e9420d380..f5f5d50ff917 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -81,6 +82,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ0 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -139,7 +142,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(25, 0, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(25, 1, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(26, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(0, 0, 1)>;  /* IRQ0 */
 	};
 
 	gpio-sd0-pwr-en-hog {
-- 
2.39.2


