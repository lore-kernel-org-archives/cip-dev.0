Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129BC41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:51 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web11.42981.1717769261075316169
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fg5S985V;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so2707752a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769259; x=1718374059; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0G8qfJTYZmVtOWrHqGVVMyTDny6QhhnlS6dvU4JqrY=;
        b=fg5S985VqATzSFfqN2jUIkA8k3I4kvTxuCpmIWtG6nHU6fQC6+9yF9uPgodCNXfwHr
         19eI73uGInbdlsCgOglgL6k1PrG6XFaZTiVDDpR1WRIc39q41wWVbzQ6OINJUpUaVK+g
         tjQZzFTXdRGQZ/0GF88qlRn8kRGUDQWlHcU/B3VwCFmgCfScqkqUU+flsFYeOc0tC4jf
         UcNrD9vYcjrhl3AtEFqLumycA9ydIkMQ6W/Hxh3wCBTQ8/Ym+QpJnNy4hvkMIianC7NL
         s/8nKVu+Lt978H+0xh/ElE+weqDBegZGVjHPFb/VCaAOQj1QmwmSF1t8otMeAUFm0V9l
         6ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769259; x=1718374059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0G8qfJTYZmVtOWrHqGVVMyTDny6QhhnlS6dvU4JqrY=;
        b=t4LF5m9JWwChActA6pnF6GZBn61uWbVYsnyb74PVMJmY3i2btQ+BNDDTsHQ0wcKa1b
         fYm9G25VI/HS78huwS4WdAdoEWIWcJhmSRu3pgo4KTDUgMf4dXd0EBQvKoG8E869sV1H
         ZHTJnMNvahRXhAmhumKmY6VKTSUlBZKGu/HYr5PbI6XmBk8PGhx0pXAu6iBMhRjUGl+A
         M5OjSKMYd/ln07tkONqEiOvG4gFLsKvEOmJmAzzCNZbRaoVRtHOEGaJK9NZMqR7mL8c4
         Y94mBmnzxBLpsLrWFtcjcmq1S4reIQ6Wp01T4ToQZeF54qHB80IU6+OsAKM9XQHnBUwp
         7ACw==
X-Gm-Message-State: AOJu0YxpA8OJA5zFOO3r28H908cEE2b3JvUQXPccBdK8dE5pUlzPOH0f
	J9mfOAVMeaLVAmxKBW0x67VR91CUsZMsVi3ewq0CcCBVLVjlrhyeewuwHWBO66bmMQ8LBpp59hA
	4
X-Google-Smtp-Source: AGHT+IFWdfVYQ/28DVdPoS4hnyEk4A6cxo1x3j1CPsSa1cvQerQ4AZZpnzsA8P7JV/btdOljgLJWcg==
X-Received: by 2002:a50:cd09:0:b0:57c:5b26:46e2 with SMTP id 4fb4d7f45d1cf-57c5b264948mr1157194a12.31.1717769259524;
        Fri, 07 Jun 2024 07:07:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:38 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 17/19] arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
Date: Fri,  7 Jun 2024 17:07:09 +0300
Message-Id: <20240607140711.2497286-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16158

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
index 5facfad96158..6315ffa6c1bb 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -152,7 +152,10 @@ irqc: interrupt-controller@11050000 {
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
@@ -164,7 +167,8 @@ irqc: interrupt-controller@11050000 {
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


