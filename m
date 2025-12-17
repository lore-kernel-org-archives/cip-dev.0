Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD00D6553D
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11763.1765967540083247214
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QvQa5bUL;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1075820066b.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967538; x=1766572338; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqRS/DnldKPhUx/IP+1RBSzbeUVA5pTxtHBmfC5Vz10=;
        b=QvQa5bULg9iDx7wnL8Cwiesnu2ilFm9+io3xNnbyUzG4IQymcoSefRwTKn1f+FIh5E
         DrlkRGcJPPz+6Iy1xKVol48hQwWkdwdpSLd/K8Uo/iody/AIoI68pDNxkHf5n2jcvSPt
         Yg/yPSWQrK9dRAg255k8j2paRQdtnl59xQrqAuRGGtP2Jc4j8+wW7noalW+aruX7cECt
         59vndnqb6Kth95/1D3iodRuSlEFWwy2g7yDpvw/Jx6gFXZyaeAHViX60iO1yCe7XOHaq
         x8HLWU+zKka441lzVzWxsKgxUSOIp7JCnBdbpNrTvsfT0V4at6jI4uuXTa9ON4wp2VUU
         6Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967538; x=1766572338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqRS/DnldKPhUx/IP+1RBSzbeUVA5pTxtHBmfC5Vz10=;
        b=VLXFT2AcQ78FRfbK3V9NWTULBgyl90olvVAk40jziXqKZpv3XvHntqztMfhVcLyg0k
         c32APWtyaV/7seSivclsjEbMu4beoPtXU+gR80aZlyN51BeG19hBoxuRVzS8ORrgOu2v
         bZsjxCITEqCPg4ydX2Yuafz65vfC57j9NVJapLzKtkOXRwZJ2Oi/O9lNe+TkXYa8rD1g
         upebGMosV9EJ0gicjk+3rhQ6TLhPc5R8I/F+BHV2jXhwL/7ifS1hu3gPBM2xEpACXEzw
         wo+0FhfQ6gOuhAzOHPwsLXhU98eXBvDpd7Jl4mD93w6zhzESs8ftQQLoneyA1iLstQBI
         qb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVngzKRY6mN7wGhR6OKxHyjqEaXCbNtwrbmkNVxjEVZq2e9bbBnHM8/fxrA8QRrXA91cVqEwtsN@lists.cip-project.org
X-Gm-Message-State: AOJu0YxAHJziKJ7QQL+k0m+ouDby8cALjpxArnl+q2ah6+dhU/XdvJDP
	z/0yscwSIjWGo2oPR9abKtacB/y7luv0FBCTcXymVcx3yCWdcDXwM7VAOMxJWdqs774=
X-Gm-Gg: AY/fxX5S8VdZ2SeuKMuZcfEqT8d8v0+XyC/FjRKdzjByp+UPsrCRt9uhv+nr5kPuF5i
	+GiM8f5/kFmLj6cPOGDSPuHseekMYNTSEazvFLTMqnWUzZjSr20ahu0YueRMHVHywQLZfRPH+oT
	6rwfIskt9SzwLWV6hRjEEA+uakj/DqY4mg4iCNWuWu5o4b40CqHpK4GDDToqmxMsLuWaff/c2+A
	eiBe0JU8uo2LnGuCNCfii2iVCAlbkox7NPJHDj/OmdYaLFUcdOg9oHSPubS+exJM9ympmgdDmXU
	L2hjSimN2eviPrKR310wvqLshO+GcJWrBPSDt+dR7NoZvItJU1J0QhnbCo3TOG8SQFpcVQiJj86
	YZHmHqz6lmGVYgItjIxhPLurrx5sF1Xo81M7zW/2lWjMs9wy1trQMu1jKMl68va4VWcAU2Gznh0
	cQxW0ciDSckdcGjrTtwmnp4ONf2SPv0vR34eo6qiNY
X-Google-Smtp-Source: AGHT+IHAlya8Z1aHfAZX5jgJOUgpgX76hvh/kB0/C6LIG2EB2+MOA/yRPxmULCVuYiWpa99uKxw4YQ==
X-Received: by 2002:a17:907:9448:b0:b73:8798:3c00 with SMTP id a640c23a62f3a-b7d238ec1c5mr1957420666b.3.1765967538487;
        Wed, 17 Dec 2025 02:32:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 5/7] arm64: dts: renesas: r9a08g045: Add OPP table
Date: Wed, 17 Dec 2025 12:32:08 +0200
Message-ID: <20251217103210.4183025-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21110

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b6f4b126b2471211f35720d8e976b65044e13020 upstream.

Add OPP table for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128145616.2691841-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 55ee6195bacc..854b7a1d4eb2 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -28,6 +28,33 @@ audio_clk2: audio2-clk {
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-137500000 {
+			opp-hz = /bits/ 64 <137500000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-275000000 {
+			opp-hz = /bits/ 64 <275000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-550000000 {
+			opp-hz = /bits/ 64 <550000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <940000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -40,6 +67,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A08G045_CLK_I>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L3_CA55: cache-controller-0 {
-- 
2.43.0


