Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B52D65536
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:15 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11756.1765967525828758367
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jZMmbG6p;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so10650295a12.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967524; x=1766572324; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D32I5urpnuBetXq/r8Hr3BjCqejJEuLWcs+kD9qsbs=;
        b=jZMmbG6pfQ1L0IJ9kYx+qtwi69MSUsiTEEd6me9N7LZGed24/z4K7azfKNnrhrrYLF
         jTzHqimgJDdPiiT2s/xeqtPXqk7SLP6OwVnQBDScnXnWt5oa8WfNYa1FJicxNHjxuD+e
         xF2d956FzlQta8lgWvR8JakWo1ttsA3i4UEffW5Qr1JkCo/3WGVzCWlimRAJ1dkPM1NZ
         BnhFUqK6oH8L2yPKspB6Po4FVsP4PNtbR31dYucXyqvESk8OpVqrXBjUn+X82aqsI4Uz
         C4tilKK1w/LZR3l8qKVPpBmY3XLUs/p8Y3P22ogveeKvE0hF/jkGlNeo8VoImfdXCepI
         TAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967524; x=1766572324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3D32I5urpnuBetXq/r8Hr3BjCqejJEuLWcs+kD9qsbs=;
        b=X6787MtQLZgCgcyguu1wpFJLxJx5B93mAglaOfqg2HLjkKv+ol9sZA0xQRy3WlDqZy
         jaZ6uzSUqrUW7p6YGovyfhEUkMjJ4t0dlBKE0inuRT9rFegb8/BARE/JEF2Dpap2rK9V
         vGi/07p39NxwrCWG/FHb6TDpSHp6TsVeZlM3vJGjO3TNmugX5nzZgbzm34r+EXNa6aDX
         l3vrBPYm760+jsGfZOWImwWKzaa8CozA/Hf5zmkgPynMENQUENImrg9nHlEKKnojwXLq
         ON5WZyVLO547cIMHWoRZgqMLY4gk6pV4zcQcnDTQ0cSXixjET7IVOoVLPaF8WcJPEN8m
         NVIw==
X-Forwarded-Encrypted: i=1; AJvYcCUb6ZoDhwLu8vgVuYb88WAPJPbgkqdP5NxREnb5GUG7p/GVizVizUoKON4sDWPAmaseCJxQZXSW@lists.cip-project.org
X-Gm-Message-State: AOJu0YwrGl28zyNmOEj2xxQVlaxks+2XeKiLkW4x3JK2Hiz9tmxjC79W
	WwYIzLsI0PiA2akj8I/b+qJs5JuVqQvd3ZQP8RQ8FuSQ5HTWgz+LV6pZ6li8FCuvJUVM2Pvr3Mg
	UMc37
X-Gm-Gg: AY/fxX4j2Udf+hSA24529J1cXEEh/1s8GjsK8GJrZgFYj8S4pTKanjCQM2g4+WxpEdF
	IUZlfj9jRZTAo5Yz64dKT23M8TME1nU63cxgqXzzonCIfgng7/5+vX7evdg+jmtrihFtlwyWTx1
	7skr1rerXo4tvqfnP6bIlHgi/7PPAtgFkUDX5KXCfahIT7NLH3AicDT4qDwYASqUb4u7m+VjwZ/
	UqXVhjEX2G0B8FuVbRbtqHwdvhtm97ZIlkkYB37HIizewJ2bGS/83vxU64ZZtkYzHUNclFnoO9r
	Qebf+nM1Asz/ZcUOLcTBjb13lsPDSa+JwDjXhjlnIReRz2Oans42t23kLNzWFuzigNM2nruhflD
	OTTOQ34PdgQq9dYr9MVirg58+WSz30j95D3ps8al6YwEEketFNBvM6aZvvgxjYzkWAwXtBl1x3J
	fzLVVFiRJOBpfBLqSNB6uOSESjUVutOHnSq+2N2Oao
X-Google-Smtp-Source: AGHT+IFEjLFNLjkOAnyr05bIRVY4T7LVLbMOv9HdZo/KF4mQTKJkBmedUIV1/fVb4W0FsZIrrx+8kw==
X-Received: by 2002:a05:6402:2346:b0:64b:4720:1c16 with SMTP id 4fb4d7f45d1cf-64b47201e4fmr625164a12.20.1765967524225;
        Wed, 17 Dec 2025 02:32:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:03 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 5/7] arm64: dts: renesas: r9a08g045: Add OPP table
Date: Wed, 17 Dec 2025 12:31:46 +0200
Message-ID: <20251217103149.4182935-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21102

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
index 89c129f9c1c9..69c9a7d24a20 100644
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


