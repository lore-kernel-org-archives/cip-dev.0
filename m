Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD8C44507
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:59:39 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90786.1783076374590491435
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LKthHqao;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so2800865e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783076373; x=1783681173; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JOiHcUJ2SSgnuJNYde5GshrHT7DjtFBZPcVLkJvHbpM=;
        b=LKthHqaool4Ge1X/LDC7PHYJ83ykVJZXO2SqKOxr15IAfFcyLTOQhDAeRNeE7Ott+y
         ET9+W5+vw/vEHH3CGLp4dQVrK5V+pGimHuaUiCHszfDIIbqbC0A6uf0igDC5X0SYm/HK
         ESvi+Vf+S4si65Daf4k/5N4d3I9YBR/toFwBI8BYNencAWURInUu4BpeIN2YO3yGU1rc
         Zs7xSmLGi3H6Hneu8yVqPzTLtKUJ7bVexmGXUq3lmrRcxD1IA60bRywztCKtt5u19oFi
         VS16VRSIfSHvEv1IMR8H6vB6zEkbhfHVd0izpm6Ezhr0J2UhtW9ZYB5As7Y5F7QErK3W
         HebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076373; x=1783681173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JOiHcUJ2SSgnuJNYde5GshrHT7DjtFBZPcVLkJvHbpM=;
        b=OSEtdnKTFqP1/TVs3zSqVGPWpTZiC9ui7C4OtcXOM+m4t39phd1OE23lzfJco+5wBz
         szEhwA6udV4EmivFJFDk27N9PQldCpGKIV6EpxhCSVp/zTOSBa47P+3yDopqtpP+Abu9
         FV7l9prlLbs8HO/eWGZKwVwls+v+MHsgfmF/JEP8jKVY4KM7I905W1u5YaaPez6oTVVi
         g1GMb6Nuct6mOj3squDKnO4ZLAVG+jgsT7ocKRr7ZzHx+8I3CmV3pjNjj55C6rVihG82
         X9bW5M69Yb99hIjhKyo51e10GDVusfOCJ0LBa4eh6elMvu9OzDTfPfIfxhMOqaXKkLv1
         Wajw==
X-Gm-Message-State: AOJu0Yw72ywe6HEPVQNHZYHSGKBD+rGPGOqUv0n6vei3/2AhHde2b9jO
	bTqpK/KoCwedrfkUQATredSyx22/D5XU4XYT5GmTuyrIsGKWg5HwYARw8J6vlCOM
X-Gm-Gg: AfdE7cloOZnuvEdzMtWO+aEDwhS3HUa+nLxAOnV3Eq2nEqOoEHaTnO9FySdZXigkEJH
	7EGOvXQ2Lf85atO+NL0Tyr258nTv8s0KDPZ6fwtTyO8vsB0Zfp/BfLXvQfiKD2CzeA+/SeNyO2i
	TXelqMBJ1T8OZcO3NQFykpz3P0T+0pxZJ5SmMgeoOIi4wgYIMtZ3jrq0YHR52U55i0mt67vjv5o
	T4fwT5sgBi19jJuI/ETJPl+B/DWn6CRzz2nhSPvDd5Z8z9bmVSDcvlz/2Nx/BHcHdpghuWx88CI
	BuLUCB4PqUBI/0D18RMJU/FZUHy2o0kqpWttFbr7vbgf6wsRN33ETR91yHnztqiaBXzcKWR24Zu
	oabTMBLnRL4z+nM14RM6SclqDZmkcugKxR8O162f3ALAB4hExDAvCRQk8GlIUIXvZsmoOhFTdZq
	cWeYvacWLlvuMCUX12PTf+
X-Received: by 2002:a7b:cc14:0:b0:492:53e2:7712 with SMTP id 5b1f17b1804b1-493c2b85612mr92365195e9.21.1783076372673;
        Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47998d81e86sm4838521f8f.16.2026.07.03.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:59:32 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/23] arm64: dts: renesas: Drop "syscon" fallback compatible from sysc/sys nodes
Date: Fri,  3 Jul 2026 11:59:08 +0100
Message-ID: <20260703105923.251255-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23436

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove the redundant "syscon" fallback compatible string from the
system controller nodes on RZ/G3S (r9a08g045), RZ/G3E (r9a09g047),
RZ/V2H(P) (r9a09g056), and RZ/V2N (r9a09g057), so they match the
current DT bindings.

This is now possible because commit ba5095ebbc7a ("mfd: syscon:
Allow syscon nodes without a "syscon" compatible") has been
backported to 6.12.y-cip, allowing the syscon driver to bind to
these nodes without the extra "syscon" compatible string.

Fixes: 9d4dac59bc3d ("arm64: dts: renesas: r9a08g045: Use syscon compatible for the system controller")
Fixes: 8d6a8af15fe7 ("arm64: dts: renesas: r9a09g047: Add TSU node")
Fixes: 04e1331b93df ("arm64: dts: renesas: r9a09g056: Use syscon compatible for the system controller")
Fixes: 3fd072f3b59e ("arm64: dts: renesas: r9a09g057: Add TSU nodes")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 7a5f339728d5..3173e6be1ffc 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -473,7 +473,7 @@ cpg: clock-controller@11010000 {
 		};
 
 		sysc: system-controller@11020000 {
-			compatible = "renesas,r9a08g045-sysc", "syscon";
+			compatible = "renesas,r9a08g045-sysc";
 			reg = <0 0x11020000 0 0x10000>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index ec5e1132d9e1..4267b10937f3 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -279,7 +279,7 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g047-sys", "syscon";
+			compatible = "renesas,r9a09g047-sys";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G047_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index eb2d8ab64b5c..a766d35effc5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -297,7 +297,7 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g056-sys", "syscon";
+			compatible = "renesas,r9a09g056-sys";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G056_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 0d36754ebe0c..eca57c29fc9b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -279,7 +279,7 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g057-sys", "syscon";
+			compatible = "renesas,r9a09g057-sys";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G057_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
-- 
2.43.0


