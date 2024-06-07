Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C863C27C6E
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:51 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.42983.1717769263525514198
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KssIOm7n;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2602196a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769262; x=1718374062; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CgqTg0mi8Fn0vdGy+22hicoHTOJmUtKsKvVaw261mg=;
        b=KssIOm7naksTpME3hHLMrWjxmRRflMAjFkjC/K0AS2szuv51BL9A9J1DwJ7pKhgu8Z
         fN8xHCnEHeSMzUhKPtkAq+8MTzPH1cPHeieUEYM0/JmG0JUPLag3BCvHcKESo4qJuU2L
         v5UZDD7EQGU9drC4iFwX4uBzZY8VWvoizHQsUrgzryCcOXz2uRILiu5Mjtch5JuomnfJ
         u4j8Or/zbOS1wg7bgZ+TcIB2Hz1XPWj8KBVOgvPWbGZ2ctulfd0oL3iizXaGTBp6ahgA
         FWmy5bs1O81JxOCeO8YNoB2ra6dPaeDXY4VZNng7l480pSp/85EDjYXjUJubPAT7nPo9
         lwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769262; x=1718374062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CgqTg0mi8Fn0vdGy+22hicoHTOJmUtKsKvVaw261mg=;
        b=aWSAam5ok579UjawL9VDwyKsMpgi3VMoMtAMaZpPgY50khCfQ3vLqIJHCQHFuIbFa/
         vPwK7cN9rpCt8XTnf9dMBYI1q5S7xCS2Ub+a9exepkUlAxNlBPfh0wPgGpEztXhBi8ED
         Q0zba3E3AKKrjdwpezZc+/llleV1qXRWwgh2OtBmhGB3VJe3eKJjSxhhXYCdt2/T/Bwq
         2JisCXqg8I5LQCLRz51p5LMk24j1hWuFOg2T6gZ/J8U5T9hbhxWBAIpUqfc+h+0qNyto
         cHPx7+K844Z0y8Ug0AF0QdJRz9wSS0Je4UBSzOks/NsYFet4crfYDhe7LiuBfN6ceuN7
         TTmg==
X-Gm-Message-State: AOJu0YwRItpWZAsgmGes7EnoUr2aQCWCaOQcAExdagymqHOr8bm/55vM
	+2yzsEK90HbMoy96M8md1Npl9Y67XzQVLHGtKgUjKnQ5bnc2lntY1t02TVbf/uo=
X-Google-Smtp-Source: AGHT+IFZ419+JX1H9PX0Kdo+lUyR8JZ6nZlLfII2IFbHHCkDIPWA32AvGW2imNUMk24UX95wei+aOw==
X-Received: by 2002:a05:6402:446:b0:57c:46f7:a49c with SMTP id 4fb4d7f45d1cf-57c46f7ac1cmr3302782a12.7.1717769261988;
        Fri, 07 Jun 2024 07:07:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 19/19] arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
Date: Fri,  7 Jun 2024 17:07:11 +0300
Message-Id: <20240607140711.2497286-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16160

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 14fe225dd5fcd5928583b0bcc34398a581f51602 upstream.

The IRQC IP block supports Bus error and ECCRAM interrupts on RZ/G2L and
alike SoC's (listed below).  Update the IRQC nodes with the missing
interrupts, and additionally, include the 'interrupt-names' properties
in the IRQC nodes so that the driver can parse interrupts by name.

  - R9A07G043U              - RZ/G2UL
  - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
  - R9A07G054               - RZ/V2L

Fixes: 5edc51af5b30 ("arm64: dts: renesas: r9a07g044: Add IRQC node")
Fixes: 48ab6eddd8bb ("arm64: dts: renesas: r9a07g043u: Add IRQC node")
Fixes: 379478ab09e0 ("arm64: dts: renesas: r9a07g054: Add IRQC node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240205144421.51195-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 12 +++++++++--
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi  | 22 ++++++++++++++++++++-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi  | 22 ++++++++++++++++++++-
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index ebaaf82edeca..68b802a90c1c 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -103,7 +103,13 @@ irqc: interrupt-controller@110a0000 {
 			     <SOC_PERIPHERAL_IRQ(473) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(474) IRQ_TYPE_LEVEL_HIGH>,
 			     <SOC_PERIPHERAL_IRQ(475) IRQ_TYPE_LEVEL_HIGH>,
-			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>;
+			     <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(35) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(36) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(37) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(38) IRQ_TYPE_EDGE_RISING>,
+			     <SOC_PERIPHERAL_IRQ(39) IRQ_TYPE_EDGE_RISING>;
 		interrupt-names = "nmi",
 				  "irq0", "irq1", "irq2", "irq3",
 				  "irq4", "irq5", "irq6", "irq7",
@@ -115,7 +121,9 @@ irqc: interrupt-controller@110a0000 {
 				  "tint20", "tint21", "tint22", "tint23",
 				  "tint24", "tint25", "tint26", "tint27",
 				  "tint28", "tint29", "tint30", "tint31",
-				  "bus-err";
+				  "bus-err", "ec7tie1-0", "ec7tie2-0",
+				  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+				  "ec7tiovf-1";
 		clocks = <&cpg CPG_MOD R9A07G043_IA55_CLK>,
 			<&cpg CPG_MOD R9A07G043_IA55_PCLK>;
 		clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 390914c8db49..9115d2ced33a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -826,7 +826,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
 			clock-names = "clk", "pclk";
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index a432134e1f0a..769e87aa6886 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -833,7 +833,27 @@ irqc: interrupt-controller@110a0000 {
 				     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "nmi", "irq0", "irq1", "irq2", "irq3",
+					  "irq4", "irq5", "irq6", "irq7",
+					  "tint0", "tint1", "tint2", "tint3",
+					  "tint4", "tint5", "tint6", "tint7",
+					  "tint8", "tint9", "tint10", "tint11",
+					  "tint12", "tint13", "tint14", "tint15",
+					  "tint16", "tint17", "tint18", "tint19",
+					  "tint20", "tint21", "tint22", "tint23",
+					  "tint24", "tint25", "tint26", "tint27",
+					  "tint28", "tint29", "tint30", "tint31",
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
+					  "ec7tiovf-1";
 			clocks = <&cpg CPG_MOD R9A07G054_IA55_CLK>,
 				 <&cpg CPG_MOD R9A07G054_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.39.2


