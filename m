Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A025CD129D
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.32447.1711527512992185459
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BXtlQ4uv;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41495dce900so584755e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527511; x=1712132311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/nZ1SUt8zbviRtEJNZhpS2YUAb5gd6lR6iarWytMY=;
        b=BXtlQ4uv7rmLX2ohufnPzlWkQmFVjiEiR2Tdf7YmFUBXgEjO827MgypjUbkrioDvMl
         LQDactmZZ+q4xPZ0g8mKPVfSiFtO8Jk1UNRVmJlkqWPBGcPjaX0RwAMjNfKkW9JB7Ndn
         Jh8s1/pLspm/mIOJCxQCmUJ/jwvAfDwIFuLml6+9SWVZPfuOuguwpGs/S363siLT7Dom
         3H1n6ePB4fINC55tW7nut6Xf+5wHbfDBQT2PnllesVCDq9iS6NBAxZVDAnkpp1e6iGCa
         ADvE4m/xVHcMz8r7W48kJ+ykWwlSGd+FnMT6scXgEZue3UzAe2R+aCimwjOvbjgfEju4
         nDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527511; x=1712132311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NA/nZ1SUt8zbviRtEJNZhpS2YUAb5gd6lR6iarWytMY=;
        b=ewhylgs8o+t9D8n3b0TDkYMjc7BxvCaaScvv0DOmY2KYKhK/wKTOtu19Ukg/JMYjAC
         y89V3DUfjoXB7OmlsHxe+FExBIsithvY6LtYGXUPL2Z5/mp6Tjvx6FxC4PnCAr46xlgm
         ecFqaMkohak/5zT/Ct0yti6VlCG/BbmhCXqCZBefFN+T7g/GWnF9ED1Wja7bNw7RlSit
         B3OdsZm3FPPIP2JMWjzoesOXmJm522yh1JJ52ljP5yxeZ3clpVwAyKFMFskrdmYxWf13
         r/zj9DuriWp/f4WKdtuNIgyew4yCn3xv7mZQNuRp+AvV3R8aDZ/UMcVx/9Om2JsYtga1
         9bNQ==
X-Gm-Message-State: AOJu0Yxdy4wLwkYHV+AH5jjBCHYRACeQznIXu1ku82lFuOFl+Tezsilh
	gd4KhVKLPpC7yjJvS3o25wmGD3npPtjF+4KZkxEYKA4xZ3jDXyYwllcmlXIsS3I=
X-Google-Smtp-Source: AGHT+IFS75TcljIXxYLCddQFjtbYzc8BO9WRiEjp8F/qFUMVV7f+ygx8JC4cUrhtbpnKeMALd98mVA==
X-Received: by 2002:a05:600c:3d89:b0:414:95ae:51ff with SMTP id bi9-20020a05600c3d8900b0041495ae51ffmr333121wmb.20.1711527511502;
        Wed, 27 Mar 2024 01:18:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 28/36] arm64: dts: renesas: r9a07g044: Add IRQC node
Date: Wed, 27 Mar 2024 10:17:48 +0200
Message-Id: <20240327081756.2228036-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15445

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5edc51af5b304a91a957b862d150cd8a89c4aa97 upstream.

Add IRQC node to R9A07G044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718195651.7711-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index f7edace31807..881fecc8d0bc 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -775,6 +775,61 @@ pinctrl: pinctrl@11030000 {
 				 <&cpg R9A07G044_GPIO_SPARE_RESETN>;
 		};
 
+		irqc: interrupt-controller@110a0000 {
+			compatible = "renesas,r9a07g044-irqc",
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
+			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+			clock-names = "clk", "pclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G044_IA55_RESETN>;
+		};
+
 		dmac: dma-controller@11820000 {
 			compatible = "renesas,r9a07g044-dmac",
 				     "renesas,rz-dmac";
-- 
2.39.2


