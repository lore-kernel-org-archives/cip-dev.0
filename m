Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F7C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:50 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.41691.1737546702018119164
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ixq5ugGd;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so46968635e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546700; x=1738151500; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=ixq5ugGdZ2XjLklNZonLEcYE0U563YnuFrg0dxKFrGKogxB9XQD2ZhhyhgdGSGWQdP
         CpotU/xvtKHQg6GujLCE7/ZjUmkmIcJlix1uRSOeqD0ClHJCjIfCQT7lmU5UjqeRRSJV
         M5QAMY7KTFaVmu+1TldIvuGfz+QptkxRjIE8D7g1iMAj6uatlsspF8cRvoPbheM5zsHS
         2p4vZa2F1DCrlj/wHN8+T9a9kBtvoRDFbamw0KvwKpi6Y+UEI6/E9bsIqKx3Axcavh5h
         w3Dwvtu0FiuyZWPORKQ0Jt1BZYfeh8hhOBc3GclP6DtlVVM+kKH3QmAN5a/n6b9UzSU1
         e5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546700; x=1738151500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9gIUiudDAAdT7+/KwLCRVApT8O0rjggfgBvSy6a4o=;
        b=on+K/IaknGtlPhiGCY8eLZ4wxpeIDJiDalaCbK66r0gnEYD6W+hsF9VModd/gyRTg0
         2PmKa+ecKUA11yoS2aFNUVhDtkfsZumQniRY2LLayHTJ3Ty6EgCBdFYbP3Z0LIX8P8N7
         j42T1YCh8aKbqsM4DH20Co/XunGHLkYZnA5OBYvqFoNcU6e1H+nxew0LvaRNJ6+wQR+D
         7fMQ5ixa2MGkWPgVH/ryaVKdKIE97TNB4Xcv1w8VSVr54bl5/GqvAgIugzlm4TqLmbGV
         7hflXTMgRkM8kO6MPx1Vc4+5GZbygO2r1fYzrYzwsnngNWUQA0C8qI73GBpx+VPpz9Tb
         XLBA==
X-Forwarded-Encrypted: i=1; AJvYcCUZkgjtAZRDfyul0I7YmNzUxj8qeVANtI0bREitRgMRliXacfGfP9VJFfk1Dz+IXTa7kGl98980@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw4lo/PvPkKt0Yv44XMWhJa4VDAxmVU3Bq7Qr5DTzAcruhTcV6u
	KAs//G2N0VLmwDXy8F98IEhcnVR2Q1CY8AoStCznYNaprCefEV3Df3fn51AIZvg=
X-Gm-Gg: ASbGnctJMdGQasSjavIX2U73+WbhdDg+/ZJfL/+yOk9YXHmZ4zAILgECL7bQwvAjpel
	zfgT7jKwUs25zoa3F1ss2Ds3hYcrLwPd9mLh3PmsRID9HYDDf4Ey9aHRGeQpOCSlkOrjCuhOI1p
	PhBTrWspWhu73MKAlIv/eKKFGVbZpMrO3Gfonf//TxOv+EB386HLYz9zwUMx87dJRfWkO5Uaww2
	/zLmykr0Cw6rXFoWCoauVE0EHTQHcE7DQuDa10XNctY8Rt5B7b0H5xm0ffqtn5iZjJlfEJ2N7bi
	quXfPGUJdRlGVoXRLV8MnVU=
X-Google-Smtp-Source: AGHT+IEAfS4u+OqHRQELjnzyT9xR8YhgdEa4gQqmKWnMgOT46fGkaluiFha/v+bdZtUQMKUwo5C+lA==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-438913cb620mr227322105e9.11.1737546700502;
        Wed, 22 Jan 2025 03:51:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 12/14] arm64: dts: renesas: r9a08g045: Add RTC node
Date: Wed, 22 Jan 2025 13:51:17 +0200
Message-ID: <20250122115120.2885015-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17575

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2d768aee9f5294d2023e824c0906e2e7d1414629 upstream.

Add the DT node for the RTC IP available on the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 7bc8969a7b5a..3401c1200a1c 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/r9a08g045-cpg.h>
+#include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
 
 / {
 	compatible = "renesas,r9a08g045";
@@ -72,6 +73,20 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		rtc: rtc@1004ec00 {
+			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
+			reg = <0 0x1004ec00 0 0x400>;
+			interrupts = <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "alarm", "period", "carry";
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb VBATTB_VBATTCLK>;
+			clock-names = "bus", "counter";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
-- 
2.43.0


