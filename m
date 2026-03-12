Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FA51067049
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:42 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24580.1773329732612099563
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lQUTTBe4;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso9091765e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329731; x=1773934531; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cU80Prx3aqiqPPoBgkdXQvyUe9YLDoN+m1m63sw0m5g=;
        b=lQUTTBe4HfA4R3FjqTOzQj0mSMYEbTgR+Us3JU/HXCrXUJXAq1wWZJZuUG6ZBbBK1t
         Z2QiB5jsNiwh0qCcgm3S+nR/l+UTQ50spU3+CaLgwSXZzqpC8SDj8zuoNrBT5GR7fvAj
         no8ft0VgIs+LkK71nHXoz69yq1yrLQf2715Ts9aigrU8y3JDAfIcDVwPUuG1ncoNN9+C
         XwrjmMMDSMzSZQUGeWUaUhkKbTLs5TjGrvW7FoqbUvgZTGHw7ICT1un8HEsar4YS1mSY
         gV46X+Me+tJ9juJuV+3Ov9CrIE8q9L6ZwUdMBElKHNy0Dz2+1ItgRAm3UnPC+/M/GcfD
         XY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329731; x=1773934531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cU80Prx3aqiqPPoBgkdXQvyUe9YLDoN+m1m63sw0m5g=;
        b=O+1LeD1pKplOegTX11hzh4f1OMw+9YfCHPZyX67fUpcEZ+7yS/13imwdJwq9TCDdzX
         l9+TmaA+gRPbg5GteJD86K/wmHV2TiFiVrLdk8gliHrWY713ML32nDtch1eZlcqMjP6w
         W6QUss1+YU7avIo/9+QZqBwU2JegYumedZhQkZMT5kgC03FpuCWtTX7AVnzmqTT1sZwa
         /bcJy4o+jDt2XilESksNGj6GUE7+zgmsqgUnR/ltlyKZBnEkSp+REokGuMbvZbCRz59h
         W3Ag0EfwBLuRlOzM/J3gwq4TUZ34P2QHvZlHLgj2Xs5EgMYR8hM9+q1doNQxGiURoRfC
         S1gw==
X-Gm-Message-State: AOJu0YwmD42AUihMQpIv5gWbnaSKtsqw3/d43EiPPvGe6YfQ6fFekIix
	gBw5zVkpZvUxc/WHegNc0XJ/yL8d6vsG2v7tH7zY4iq8u2XbImBNogUzv1B7EA==
X-Gm-Gg: ATEYQzy47fYbdXz8FG/p889M8665QVpsKPQDKnY7WCAT+IXz+pwCbYYgnsVJ5mtM+hQ
	80MOYH+gILkpUtC2obsNFAcHaVS8+O87k73wNlTsgr5tTMj10i4Au4AJTpsnB+8znYfsZPJI962
	Qu/qw6jkiQAT0vl95dvNkM3PmCKQsQxvyfcPRHN2UvVkCxcnV2YQyhpg7gcNJnMdRPLEWcX5UGc
	VduGZ5KSxtYhbtvUDrb6yYZYRuXV8eOvTQVTPJw1Dx8YOSS1irsHiDQoNYgN2cgxQG1YFlCvw7X
	lw0bNpGvLSOER4LLWr/Le97d8r96jyKX7WH74zZoKn1oXzVxT1GkeuNHw315CJ0AwubG5VmqKHt
	+/G27bucS+UfbBO+Rs2kgph2DotwNFDAD1FXt/YdyGD6GsTI2DTXJqQ+jOJyxjWcujqPLM7Qimt
	hmPJhswV6aWQ9Z/wh1WqCAR7j0+OM7wW/oUCmTQZGoM2a5Aa0=
X-Received: by 2002:a05:600c:3511:b0:485:3473:d48b with SMTP id 5b1f17b1804b1-4854b139161mr117057285e9.35.1773329730527;
        Thu, 12 Mar 2026 08:35:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/11] arm64: dts: renesas: r9a09g047: Add USB3 PHY/Host nodes
Date: Thu, 12 Mar 2026 15:35:14 +0000
Message-ID: <20260312153522.1131675-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22365

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


