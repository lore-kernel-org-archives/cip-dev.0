Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAEEC55180
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2456.1785575707618334532
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ixcXcWB4;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49558ce01afso3922985e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575706; x=1786180506; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3one7YKZqMSafXhl4G9Y8lc56hxOwmwY1VWgxSdAoFg=;
        b=ixcXcWB4MrYtLwxlvOGx3AbhOC3cWmRgKbRXTfZw7KhWNcQbz7sGDWUglhvC60oWex
         Ms/6N1ZLBQ/xJlwRTzKnvAFaJXpIaEFJkJuT6CRCfYCxo4OwzmPJt+HUveJ4MCrC58d0
         mBo4ow0hwUAm6Z+oN5dKhxhlDmb7IwnB89ZYqrF6AAAfFPo48bvoUnvhFfo+k51NdZM0
         tgoYkMqmmN0vYhxhqiKzQ6aGxi8OiohoTDEn719Ud89TrrzgQELdgsLPuaT3rUtx2eDE
         PANBSzSazls/kHgDKUjOIJ7BVM6FDQ6hHWVca/cQTam+b79LWHnFGLBEPycX+jWfoLWm
         hTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575706; x=1786180506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3one7YKZqMSafXhl4G9Y8lc56hxOwmwY1VWgxSdAoFg=;
        b=oF9nNoQuedgPeS8MYQQtinFd58RaSxgHp6eSqUGxggGu4wGOyCHo4gqkYKGBwqsSUi
         8oGkH/GbEsX+GmqVTUxVpDZms+e42XpjSAya2qD7jhnykW+K8OWZ3HM5eSWUsgjSQP8l
         6UlzKZiWeH17mtchqLlD6iHaSfdkhQmNxx8GDoHTNnzEa1IzNYd5EM2uIARR+buqZDZB
         o72Gqn6uzO0twyKSijbb2y0CPBGa3bfZHx5q0WwwWprcNg7hFAp8A4o4DJ3xH9tMoNxD
         E+UZF43aIrfeRYQ6efK2xpxfrvluBXcqaW5baLjqKaLXyizSGtk4Df590CUyCUEr8yL4
         gyVg==
X-Gm-Message-State: AOJu0Yz5gkAdqRgaQ/HV87lTPPG+i7tyfvykKRFk+fbdOqrIw2MMUUj0
	HJ81yoUCVFmGB+G2m5l4HJ7v0PjjuOSrAWxaKscm2dIlgQNxDhcMvPAl+FRDFg==
X-Gm-Gg: AR+sD12BvaN3ss17FhtoUFOQm9eL6Yu8/+DoXXoA7Vn6npUaCtT9PUb6c4WT37gGFOz
	yQ0MXzHoq7ulWgBLWNNcutblz+g+DgWzEVVj2PaILZiD5J8fzJ1wlDApagH9ZCTR96WGBFHBaCU
	YacnsOGQan7Yd8bR3mzSKZt2pdPpkbgLtGdoVHqz9ZTsZq8ROyFC2a6MTBHMyVCzKWWGd5RisRO
	ZDiW9ET3rPMF1l9MpBirroCJb5AkGF4Urem28dYFD8LJP/FIeN0bU4gmqqkHGg3viQcJMrjXFxH
	c5LdPDI+aaH12KuMoqPr6PDqoyvZ+nAcDv5o9x3O6Qk4YWHKoLyk+uzkplK77RpJCEyz3LbV7B9
	wZh8W2xInn6fTTmJkqb9B+7bkLtguCaQru+bW56D7w5cVAI9Y5V5O0oGL4IlB36nCaRou16u2/x
	uO/+oF824oShO/uvMj1h/2V9DBboDSsvOsCgcZfZ5v5oQdmqjlTh/YWXP4lsWW2wMBgCRprVrX2
	xsQMWokH2zouw==
X-Received: by 2002:a05:600c:1f89:b0:493:cfe8:5b36 with SMTP id 5b1f17b1804b1-4980c66d7c6mr27634935e9.8.1785575705831;
        Sat, 01 Aug 2026 02:15:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/19] arm64: dts: renesas: r9a08g046: Add scif{1..5} device nodes
Date: Sat,  1 Aug 2026 10:14:39 +0100
Message-ID: <20260801091458.14026-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23835

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 141853e48860bc4aa74e312ae56bb72ff06107b1 ]

Add scif{1..5} device nodes to RZ/G3L ("R9A08G046") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505070206.7932-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 0cedf5a38291..7a7c11ab4903 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -166,6 +166,96 @@ scif0: serial@100ac000 {
 			status = "disabled";
 		};
 
+		scif1: serial@100ac400 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x100ac400 0 0x400>;
+			interrupts = <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF1_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF1_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif2: serial@1004c000 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c000 0 0x400>;
+			interrupts = <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF2_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF2_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif3: serial@1004c400 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c400 0 0x400>;
+			interrupts = <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF3_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF3_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif4: serial@1004c800 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c800 0 0x400>;
+			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF4_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF4_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif5: serial@1004e000 {
+			compatible = "renesas,scif-r9a08g046", "renesas,scif-r9a07g044";
+			reg = <0 0x1004e000 0 0x400>;
+			interrupts = <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G046_SCIF5_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G046_SCIF5_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@100ae000 {
 			reg = <0 0x100ae000 0 0x400>;
 			#address-cells = <1>;
-- 
2.43.0


