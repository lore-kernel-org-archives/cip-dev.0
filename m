Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B66FD874A
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73774.1773747412389137747
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pgsxc5dx;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso15030345e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747410; x=1774352210; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU80Prx3aqiqPPoBgkdXQvyUe9YLDoN+m1m63sw0m5g=;
        b=Pgsxc5dxa19zz/VJMP1eFfDAQU9rKCHnyw3t/bU6U6iNIcUxHem4Hel/R0AWoeSGUs
         4xDrLw65UJteGZUrdsmbyvk+gCU+r+Ts9zwZx//djQlrbFKL2TPXJfj2nGt9ysmwDk6P
         EFlYrUzLpvCanr99TvU7E1Lua5TyN8w9SFJjnGBnI/nzGPQo4xTOq0c6EMZKnyBGwYdG
         DsAG0B9bWtCdMiWfcZxYwdk+4Ggbj5RgrWZOeawJGihxEIl3mw4Yr7007pndXvQWfoeU
         KXjTltjTVjjtZCqVQJwrh7FMi42ecwTRtFptNPvQ6yLh6nMrcD6pOgl74PmKkpyvFK60
         wmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747410; x=1774352210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cU80Prx3aqiqPPoBgkdXQvyUe9YLDoN+m1m63sw0m5g=;
        b=ggp3bTGhd9kZjB/O66D36gdkUvjsReLd+GkTbBVX1CblCPHS3titTIp8YxcE/SytdL
         RH9168K2K4HfcDGoZkBv5dJIhFKakdmUY228ut4YyrzTGNWcWi5+996BdVHEf78eTH7R
         NIgY8AA1lFHGwoJ1uFMdDrcsPG9p9i9RicJNjSDrR+h+jWeIukwxFkzii4wEJXsMTjSl
         OOCnPAtLXO3Wwd9tEnNYAWU66Uq6QKcg1MIs4ju9DwbK5hL0/GsSyRnb1fY/Opbh9uqn
         LSTA2gfIiyWQBzNpRwIauNIvpEsGILO2vIrvUhY/UDmRy68zL9GOutrx6BzIHTNpnQ8n
         XV8w==
X-Gm-Message-State: AOJu0YypHxcmbazqVkaD2mqwvJeJUcSpBywPgOhzUZLCfHCV2J7GmNJi
	+XdQzjN0tFf+J3BsKZhFntpXp1IPTBXweD4Aahe/82/JfsGRbJGnl+s6YyIdEw==
X-Gm-Gg: ATEYQzxSjGH2FNN0F6sdCAqm3rcUj+W9p4aipNujASKJ0QHziLSWl8qn31LJLQY+TZY
	WYFrS1f/3FZOtoA1U8eg6zEWHKZq+khqLGw2ZMxaC4ofFBIY/1w4lRAmmVa+FdPSOhIQdostqH5
	MuOjNFBja27JUd1IlTUe1JClDqYoiIvRY7PbQXAAp9TzGwMMcLzVatsu8cmgc/LY960dTZdtC6X
	p+RBZHmUMqUmHIl1IyiV4L+idGsQqu3Oz+i1adgV1x+3DfAtzo+xqdVU6nos6xQVwZv1Xv57D2j
	CAE2wU+X7ubVykRMFLosHjUvs+u7bqs4Mzs8LPixThTI6Am5EtrWNdeSFIiFOB21uoumHDT7yWI
	Y3OR75tpunKMaKkoET5AUVqwuNCV/inWDgoBqdHgYzOLHeQ+kRPrPlAYEcMxGnJQ5YmIHHv0+l9
	vhmO3eu+zL2Tku8PxMD39jypluVqtIrfUUfqpKX8zls6FBwzP9
X-Received: by 2002:a05:600c:4583:b0:485:3983:aba8 with SMTP id 5b1f17b1804b1-4855670530dmr252736965e9.27.1773747410374;
        Tue, 17 Mar 2026 04:36:50 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:50 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/11] arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
Date: Tue, 17 Mar 2026 11:36:36 +0000
Message-ID: <20260317113643.311192-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22483

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 87c83a27b80062d0ca5dca408b7a7db42027a582 ]

Add USB3 PHY/Host nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250916150255.4231-8-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index addcc9ed8661..0a2fc3480a43 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -1073,6 +1073,36 @@ gic: interrupt-controller@14900000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		xhci: usb@15850000 {
+			compatible = "renesas,r9a09g047-xhci";
+			reg = <0 0x15850000 0 0x10000>;
+			interrupts = <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "all", "smi", "hse", "pme", "xhc";
+			clocks = <&cpg CPG_MOD 0xaf>;
+			power-domains = <&cpg>;
+			resets = <&cpg 0xaa>;
+			phys = <&usb3_phy>, <&usb3_phy>;
+			phy-names = "usb2-phy", "usb3-phy";
+			status = "disabled";
+		};
+
+		usb3_phy: usb-phy@15870000 {
+			compatible = "renesas,r9a09g047-usb3-phy";
+			reg = <0 0x15870000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xb0>,
+				 <&cpg CPG_CORE R9A09G047_USB3_0_CLKCORE>,
+				 <&cpg CPG_CORE R9A09G047_USB3_0_REF_ALT_CLK_P>;
+			clock-names = "pclk", "core", "ref_alt_clk_p";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xaa>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@15c00000  {
 			compatible = "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
 			reg = <0x0 0x15c00000 0 0x10000>;
-- 
2.43.0


