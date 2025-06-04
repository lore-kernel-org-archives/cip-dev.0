Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5980DC61CE7
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:23:51 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.13295.1749032630285169192
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JpQ6Qfh/;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606741e8e7cso5343033a12.1
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032629; x=1749637429; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/KgOnvCG1/2Y784porVKxV5LNUoW7FM+cyRysm4kbo=;
        b=JpQ6Qfh/K7yY1oIA5cvHTekYQJXnXgsL5VIzQHNNeOBte3AX7oz/H1YXuLQESrCInl
         xoxVKArI9WnYl7USEXOIRt/PIGMZJOilxr6l72BUDUFCqrmk98yC96t0SQIOyDCuVuCm
         pZb5FHuiSXUhKQRq7koB3i9uB9VuP0qEpdRfh83QnAdKsP/ak46C1IVevSmcf6z/IBDn
         AD82AbSsEytVEgsWIlOzndXTLF4tXyFpZ0mpFEGPFKg4Gcp0WehYBLTkI5Vvfu5cbFwl
         2sK1MSvb52eh9jprEe2xWXgFH/77SKeixqL3oo7XdEEw4sw6LEnLMsIFRtp7V+tITEhL
         0p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032629; x=1749637429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/KgOnvCG1/2Y784porVKxV5LNUoW7FM+cyRysm4kbo=;
        b=LCHovm04kAD3pUkrL6LTT9+BYP1yjjolcIfAG5kEbjb8lfq0wMl411qq2hXtGZJS37
         J7kaPYr9H29yJzfU3GHGGShzD+lMSwCILhIkFomHZGCOruf4NiTNuBbalb79Da4wNahb
         h7G6QToTDFtV/mmrdz1MZs36CrQKQ9y7oxrzP1h4Nrf12t11oGeFuqbPGh9kdUn55kbW
         cWarJie+HG1MLRNCl/OtUMLbrRm88Zm9Via1z3cje31j+sgaS88uLunaDmBiDLuYQWXr
         Na2YcZx/Gs1Iw+Xd00Uoh9igsLmn7gu0f8exAhaXfR/Q0WMuh2hlBhMVOBQIJ05X31xY
         X/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXKg9C/QVdGyC2vjeXhTMbagJN6tGD45WlTIzkZ7JFpGAahnbFMPyzGtvXDW7EALW24NXCTS6eD@lists.cip-project.org
X-Gm-Message-State: AOJu0YzPSummxfSrUlyTJzrRAs7N+YjuVOHAfyTAqHkp35qOb/mhSRQB
	63o4BdIPjruS7EyKzIh+1PpylOPqEqmhTMTjg2jwaZ3Fo1nWGUDig1zrhSYtsCBQ+FsVodrFMgk
	HVAil
X-Gm-Gg: ASbGnctPCb3mWheiqWP9wSo4KLha270bCFm1A4vK3V1L86ibXvU59+ft9VLZPTafE3y
	NZ+x4IQEXH7t8vpNc5M5y3XSLtFfYxopAUeZV/dfZQb+n7i7XjZWN81mz3Vh5mXf6d9sS9qT7tC
	JaMW6BnQCkcrObPhvl6myWfd8KVH4Vh2zaRBY03YV/4ZVNEUMiYJaTeaasTpoSuFg6AZQAwcjL1
	bkkuNJWgVDun54AAI+KZbIoPjxQSnzqyrMW42y81otvlgw4Qtp0muSqQFQvmvfpFrTCEN3CbV62
	d9iPST8QS4+LkWL+GFLYh7l9zpkXC7rtWhIQ7H2C6yiKesZeYiUFvrWLfoKLeIbu6GY50i0tkmY
	HaSh7RQ==
X-Google-Smtp-Source: AGHT+IHeHKe4VsSPLECSilh6q66ZHQPAS+ON7OGpYFJ+0dPSzp87TNc/dQ9rUpzZU+fChqqJpo3r+w==
X-Received: by 2002:a17:907:7f94:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-addf8cccd0emr201028166b.3.1749032628606;
        Wed, 04 Jun 2025 03:23:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1087375166b.52.2025.06.04.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:23:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Wed,  4 Jun 2025 13:23:37 +0300
Message-ID: <20250604102341.2524186-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250604102341.2524186-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:23:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19005

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit aaf7188d7f77bb8a6e043c70dc6cc6616c427762 upstream.

The Renesas RZ/G3S SoC has 6 SCIF interfaces. SCIF0 is used as debug
console. Add the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index c317c23adc50..5634eff1e921 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -87,6 +87,96 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		scif1: serial@1004bc00 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004bc00 0 0x400>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF1_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF1_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif2: serial@1004c000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF2_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF2_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif3: serial@1004c400 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c400 0 0x400>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF3_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF3_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif4: serial@1004c800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c800 0 0x400>;
+			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF4_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF4_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif5: serial@1004e000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004e000 0 0x400>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF5_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF5_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1004ec00 {
 			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x1004ec00 0 0x400>;
-- 
2.43.0


