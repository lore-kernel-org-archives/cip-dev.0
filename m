Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22906CD1298
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.32306.1711527514297422374
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kQVnhycQ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.175, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d094bc2244so84022131fa.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527512; x=1712132312; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gndqMjqTXWbuAAMSpbCUpgJoNh7MBvK07glniHFUq4s=;
        b=kQVnhycQ04Ux2Hy+5xuDy6xwSB2EiDYSOu1oeWoUCb+v3fADX4vTwrGDjUdqvs81ok
         iJeRZQDYVjcfZ7zvW+QHxrXWGD6wARYA5MzUW/AgCm1tNltUE/VtvLp58mx/TxPytapT
         jPIsFg+ijw3gvXMB4eyaeOVO/PD1daaTBntCop1RlWyx/kA+rFMTLE3LWkfnXEC3WKBr
         M7jZ1UY/b960Po/e7OX4wMK2ORO1XQo8v8XqagLqDi0ZBT29WjxzOlfQ8g6Ls3zLg7kW
         xXpua5qUJohUkzPWg0u97L42y0HguFRcbYOxjA2e1gjMPpCIkcpPGm55dwF8/1nwjo3n
         zbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527512; x=1712132312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gndqMjqTXWbuAAMSpbCUpgJoNh7MBvK07glniHFUq4s=;
        b=VRcuXAKmOuNY1n/h+bStHqv4Cfs4Emthl5LAGeZvShHZJ6NTsLAQFgKgci2u/oKyeF
         aG22xvaPtRZ+agtzGG4iySwI+6A2QGJTLWZkAyQU/2HMu4NgLaQhTYLU9qneFE0LKpr3
         ZMDo2oiEqynXfYt1vRw3wQV2msVX6WcH9Bo6c2Tdb502KL5tyVyvYoJ0E9z9eG0t/epT
         ZeeP5d/B3jBH4ChE2Zd5BFSNu+g7PIb+Q4QZAZlIM7I5ieAcXEg2xksyPxEcS2ObDfyV
         2TE6878PLGvFV6PUC0U7RaQJ0TLGIGW1FZ2WcjdlScB5N4pM9gHv0ryrRMYY03TSwTMk
         QyRw==
X-Gm-Message-State: AOJu0YxaTqcPj8b2mUly7bpi0SIPKfywMMWdKU24Jo7LaoFpsqIudvQZ
	wZmISTVr5yd6rLxIHKxbSulkY7VhZ7OMUO8Ug0kPYx9wAKQSJJT7gC5BKwSdvIc=
X-Google-Smtp-Source: AGHT+IH2qlrMcKUh6dr47TONHbMDiOdAgoQDzGa079tvvOgoE0f0X7ZxidniwDpzGOo7j6AK7QmQmQ==
X-Received: by 2002:a2e:3c0b:0:b0:2d5:b33c:1f64 with SMTP id j11-20020a2e3c0b000000b002d5b33c1f64mr301809lja.38.1711527512511;
        Wed, 27 Mar 2024 01:18:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 29/36] arm64: dts: renesas: r9a07g054: Add IRQC node
Date: Wed, 27 Mar 2024 10:17:49 +0200
Message-Id: <20240327081756.2228036-30-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15446

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 379478ab09e0c25709e804b732ee7910d14a3972 upstream.

Add IRQC node to R9A07G054 (RZ/V2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718195651.7711-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index fa2dfd5eee41..9a856dda9fa7 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -782,6 +782,61 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A07G054_GPIO_SPARE_RESETN>;
 		};
 
+		irqc: interrupt-controller@110a0000 {
+			compatible = "renesas,r9a07g054-irqc",
+				     "renesas,rzg2l-irqc";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0x110a0000 0 0x10000>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
+				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
+			clock-names = "clk", "pclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G054_IA55_RESETN>;
+		};
+
 		dmac: dma-controller@11820000 {
 			compatible = "renesas,r9a07g054-dmac",
 				     "renesas,rz-dmac";
-- 
2.39.2


