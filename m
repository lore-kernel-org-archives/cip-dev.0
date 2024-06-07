Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A869C27C5F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:31 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.43062.1717769365911136097
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZTKQw4tT;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a68a9a4e9a6so208871566b.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769364; x=1718374164; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SPBI/PgK9GyReJZyefK3nQtExOWXPBhl2T9F+V3rjE=;
        b=ZTKQw4tTsGVsI4zjv2e/kdczM+kk/lGOk+7UenuoQCN04zywo3ty0sN0B9RPWO5w/2
         iEwtM3GeMkvuUe6RXwMKH0/1WkOue+Hnuq2rwxMcL/n3G4wMheCvnIB2JmTUS9JrjXoP
         4fQRNLG/xTA7nB0GS6h+0tgBWzm4LTkPlDrAQSpM9ks7+ysqpM5EU0qeSwS56uYrWSd6
         /eoTG1QIUQTFh7YSYKC/B7y3RNA5tnEFmHix/vY4uP06ugDpXC8ROBFy3nde741c/tPd
         C+3S3GRZTUkbU7PGui/pp5+FXwC2V3PxWpecLL0Z2hQAS/938eKeAdADTsp/OLOhbJ0u
         Fwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769364; x=1718374164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SPBI/PgK9GyReJZyefK3nQtExOWXPBhl2T9F+V3rjE=;
        b=WpwI7bSHvy/OahUBZWRpta4iYNBBDcfmX/8FFevCU3tOSJr0wqthdWrbjjU84B0SwO
         zC/oH7tfENjeuQ2Fy2hgwt8stKQVPDL9fNEPgZOe8nJYeOqy9/7tcWE88JAL02fop1d1
         /9nttwejtGFSPrsv1PjrUuRecasi9HyVlkAB0YufFMlqXk/auzb4dNZ9tOS+8qYp+m45
         IpQxS5KHKarcgWsgxpM13HsHKA+PaDUXqCnw1BOKTNSVFWMgdKS44I1AEHcsKYcxagR6
         8NWmiKB+oPWE8izdg78JiJ7V5XUKnXvFDKApfNqTbvsRPzKdyj42f5gEHGMY0dqzNhqI
         ICNw==
X-Gm-Message-State: AOJu0YwvBnGffAqjEpYHZoGz3g45bWUfkrD+hsl5tljatCAPm9RZ/vdW
	8VlQo7ulOO71l4HT6s5kj/a3/N+P3FWMabiaf0RcDhSEWlLx+VkGfG4caQHZ+uHqqfOQYU1+L2U
	M
X-Google-Smtp-Source: AGHT+IGaEg+CdxQFy8PGgkYVnr11rwrvyBgd3vhziF1DdfRj1pbigfbqjLo1N+NGXGavI4BrhRXJpw==
X-Received: by 2002:a17:906:84d:b0:a6c:717a:5112 with SMTP id a640c23a62f3a-a6cd665ca24mr221527566b.21.1717769364289;
        Fri, 07 Jun 2024 07:09:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 17/17] arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
Date: Fri,  7 Jun 2024 17:08:56 +0300
Message-Id: <20240607140856.2497508-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16178

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit bf7e37716d995c54630c30540db5642f58ea037a upstream.

The IRQC block on the RZ/G3S (R9A08G045) SoC supports ECCRAM error
interrupts too.  Add those missing interrupts to the IRQC node.

Fixes: 837918aa3fdd ("arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240205144421.51195-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 02fd68b06eea..aba6b0383778 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -157,7 +157,10 @@ irqc: interrupt-controller@11050000 {
 				     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "nmi",
 					  "irq0", "irq1", "irq2", "irq3",
 					  "irq4", "irq5", "irq6", "irq7",
@@ -169,7 +172,8 @@ irqc: interrupt-controller@11050000 {
 					  "tint20", "tint21", "tint22", "tint23",
 					  "tint24", "tint25", "tint26", "tint27",
 					  "tint28", "tint29", "tint30", "tint31",
-					  "bus-err";
+					  "bus-err", "ec7tie1-0", "ec7tie2-0",
+					  "ec7tiovf-0";
 			clocks = <&cpg CPG_MOD R9A08G045_IA55_CLK>,
 				 <&cpg CPG_MOD R9A08G045_IA55_PCLK>;
 			clock-names = "clk", "pclk";
-- 
2.39.2


