Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130B6F3C27A
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15560.1773066367260984079
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RTijzhjB;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b611274bso5332564f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066365; x=1773671165; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XToOWv+452vYLydqdmnWLFiKK3HRu7vsccAAzvbElgw=;
        b=RTijzhjBz4tnzkdKdGO/S+K2clCBB+90BdVES09lAtOzWQjuthmHAwNlBPhjTrozji
         PXOBRNzT4oFY+nUT3Gzlv/qKdkNXFW4ZNhMlsDkQRQinE0LaGyGR2EbI5RErz+0WCYRP
         MeCnHgi5xF85AlXBEidBslwWlS7Fkdfc7ugRvAEunwWZjE3KgSIoGbwxKQlJCxNrckmf
         jYDlsfcquA+7eb34PH3GHXBjgZX4UAJBeYi2pcuHsu89tFg1QZxieEVwykLbyOv1p6+9
         wpjlz+RixbzuSkGvfDT/OjMCaI9dm3Rke80fdLwfSaPmP/AZESTFWLpnsNfWe7PVZSj8
         gOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066365; x=1773671165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XToOWv+452vYLydqdmnWLFiKK3HRu7vsccAAzvbElgw=;
        b=LILLTBw3aOqmYuxeS8TZOasPuTXHbsMFPa9rVhtvl99jkbAVdm9btymXYDsa3bMbgw
         4YjuYoKrLgODyu9xqYZJ6BFBUm+mj8zu+xiH7NpflzGPeWpymSLqqXpgc606b524cxNr
         TuZ3dZqu+7bFoG7Ueu3O9hAjNDHJ+57KnPTWGPgj0tm6ysdHqz0vC3K6/42K+ft+YFDC
         Uvj10W6bK2A2/5Cl9cDhRbw2YzOCNGVBuIhmYkGPKiCXyz5xUq2TQR4gDC9nxhSG+R3t
         Yd9YkXG/mh8YDmcHHEeO2KjTAnjNyYHHQyKe4s2lRCUap85VGx5CfX57OrxF1lPyAwt5
         KTlg==
X-Gm-Message-State: AOJu0YwG4miuQUXZ3k+DJY+z1Aaowpy1ob+xBIY1GIjJkGunk2OEvd9u
	xbAystWa7h8VPDpIGrMJLIFYDYMHYzUL/NqMhD+gj0J/8RLYgDwo4jiQxyWZVg==
X-Gm-Gg: ATEYQzzqMxli3r7MFEg3cxzYTSWgk+IysLTbMAgcHehL0eVxXeNj5uJpPA3cDsz174a
	f71Eyy6F0KXQq48y+xSuwVsJc4hDdI9BB7QEhMZfkvP+Et8IDiMRGeXbxXccjvu+b8IYAzPPjmh
	SEucm18kbLhlt55AkT3hsaa3v2FWJHs7GWMTjvimBJLcV4N2TgsBLU7R58SGzwa7MZ2jUm304xe
	wbfufiQSxZ818YMGqEq9MuMWdkPf6WXdZSXifTquf1PeNvr4TiVL4A7C21V87C3cc8XPeEC7mkz
	Xki03nwsXRmKl0f3ZtRDZ3SePFc8+JAwVrL2w00Eg+mCDNRW+fIE1pzkPPCI0zlNDssd1IYpzWQ
	cRB55LOsg+8tVj0arl1nHCpC870NN+HzLPzT8NJS5iFrNf1uCINBLV+r1cJWSYqmvwC86nynSKH
	r1KRiCHu/GJynTTPWVaI8GlMrWJ4eVCR8=
X-Received: by 2002:a05:6000:4308:b0:439:d7e1:fc51 with SMTP id ffacd0b85a97d-439da885bf9mr19971862f8f.36.1773066365227;
        Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 25/29] arm64: dts: renesas: r9a09g047: Add RSCI nodes
Date: Mon,  9 Mar 2026 14:25:25 +0000
Message-ID: <20260309142549.987737-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22193

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit ef601dbb5b80a0240dc479ca0aa5fbd746f23ca7 ]

Add RSCI nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251129185203.380002-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 220 +++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index bd15725f2c22..addcc9ed8661 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -591,6 +591,226 @@ channel5 {
 			};
 		};
 
+		rsci0: serial@12800c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12800c00 0 0x400>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 116 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x5d>, <&cpg CPG_MOD 0x5e>,
+				 <&cpg CPG_MOD 0x61>, <&cpg CPG_MOD 0x60>,
+				 <&cpg CPG_MOD 0x5f>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x81>, <&cpg 0x82>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci1: serial@12801000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801000 0 0x400>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 122 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x62>, <&cpg CPG_MOD 0x63>,
+				 <&cpg CPG_MOD 0x66>, <&cpg CPG_MOD 0x65>,
+				 <&cpg CPG_MOD 0x64>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x83>, <&cpg 0x84>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci2: serial@12801400 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801400 0 0x400>;
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 128 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x67>, <&cpg CPG_MOD 0x68>,
+				 <&cpg CPG_MOD 0x6b>, <&cpg CPG_MOD 0x6a>,
+				 <&cpg CPG_MOD 0x69>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x85>, <&cpg 0x86>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci3: serial@12801800 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801800 0 0x400>;
+			interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x6c>, <&cpg CPG_MOD 0x6d>,
+				 <&cpg CPG_MOD 0x70>, <&cpg CPG_MOD 0x6f>,
+				 <&cpg CPG_MOD 0x6e>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x87>, <&cpg 0x88>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci4: serial@12801c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12801c00 0 0x400>;
+			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x71>, <&cpg CPG_MOD 0x72>,
+				 <&cpg CPG_MOD 0x75>, <&cpg CPG_MOD 0x74>,
+				 <&cpg CPG_MOD 0x73>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x89>, <&cpg 0x8a>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci5: serial@12802000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802000 0 0x400>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 146 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x76>, <&cpg CPG_MOD 0x77>,
+				 <&cpg CPG_MOD 0x7a>, <&cpg CPG_MOD 0x79>,
+				 <&cpg CPG_MOD 0x78>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8b>, <&cpg 0x8c>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci6: serial@12802400 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802400 0 0x400>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x7b>, <&cpg CPG_MOD 0x7c>,
+				 <&cpg CPG_MOD 0x7f>, <&cpg CPG_MOD 0x7e>,
+				 <&cpg CPG_MOD 0x7d>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8d>, <&cpg 0x8e>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci7: serial@12802800 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802800 0 0x400>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x80>, <&cpg CPG_MOD 0x81>,
+				 <&cpg CPG_MOD 0x84>, <&cpg CPG_MOD 0x83>,
+				 <&cpg CPG_MOD 0x82>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x8f>, <&cpg 0x90>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci8: serial@12802c00 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12802c00 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 164 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x85>, <&cpg CPG_MOD 0x86>,
+				 <&cpg CPG_MOD 0x89>, <&cpg CPG_MOD 0x88>,
+				 <&cpg CPG_MOD 0x87>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x91>, <&cpg 0x92>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
+		rsci9: serial@12803000 {
+			compatible = "renesas,r9a09g047-rsci";
+			reg = <0 0x12803000 0 0x400>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 170 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei",
+					  "aed", "bfd";
+			clocks = <&cpg CPG_MOD 0x8a>, <&cpg CPG_MOD 0x8b>,
+				 <&cpg CPG_MOD 0x8e>, <&cpg CPG_MOD 0x8d>,
+				 <&cpg CPG_MOD 0x8c>;
+			clock-names = "pclk", "tclk", "tclk_div4",
+				      "tclk_div16", "tclk_div64";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x93>, <&cpg 0x94>;
+			reset-names = "presetn", "tresetn";
+			status = "disabled";
+		};
+
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g047-wdt", "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
-- 
2.43.0


