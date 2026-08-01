Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF2C5516F
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2458.1785575711285749591
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g2Q+DqRh;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-495590dde14so5141105e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575709; x=1786180509; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hg6BHuEdvBN/cYlYR2ZsjMunjwe/PNAQPuuypToNGz0=;
        b=g2Q+DqRhn7DToWLD5SZh2aIE0hhWSHvARgI74w2PPUBEMAN6a5dzwBSx7z3k2tWxX6
         VqxFa5FtAQcSMBq1cI5kXK7l5GGzW9skdDhnqghPWU1NNDidd9zjETo8UlKQsrDAGOxQ
         tAWcFTgmFs9neOtcshU4EhWn2Do/+sInTmHJH3GxOfBAJNYdI9ylZ7Gzv8OcQY8Qboq/
         6MnBbROKjh6T4kEy+I4eYoL0sbsjHHPTHMVQi5Vg2tQVO++WUKuFc+yHv3F0fnN9cJsJ
         +b7mRZqsPmYQ0xHJ/FAQpnYRwryi8gOxkXOuZqrn7aSVkNObaw+pZC9Nkj0F9oCYvffd
         LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575709; x=1786180509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hg6BHuEdvBN/cYlYR2ZsjMunjwe/PNAQPuuypToNGz0=;
        b=eAYYfT1TUtEBonAHaIEJN9tStpno0zoTHpToJe1Jne1ZvgbL8oVqHMAcFw+6RuJGzt
         5o2vtY9I5r/UUXLIGIEcLnqsJEMR7yJNWhG29FssetBxNTwWLCeoTvINKhwQsrtUEG8f
         VUiZhb8CdHeQsJsEisI+hnw7OLRyN+Q94zNwQNha6LUhjeNGbBEfn7AYwKQ19XRn2upw
         6FLInzXWJhvIX/OXFhRthgWUPixY+LbVcN/vbJhoWhBj6rzM9oLyKiKw2eslsLLTohkH
         vn7ynfSN6Og/NFHTETH7zd8xvCHz7KIhX42jIInGwgpsi02UM9DNJPFf1NObG67IoGzX
         OicA==
X-Gm-Message-State: AOJu0YxyxamBkPA5qPEIa5tEoKw5FB47BNioV5sIqFXGHFLKG9SYI89E
	Lv+nwI2l2/lopXsEbL2sfp4IFEgyJoOAEcJCZ1Feh0pF0XuqWIYdxlxCImI8xQ==
X-Gm-Gg: AR+sD103O0/Ordd2w6pbKw9Ryl/ISFZh1Zmp/teIymfhORBt1E+RnjpJildxH955ePZ
	Majnt7LmG4I90rJgG2Uhq02nVUEu0ZIqduURa7Ga5ipahghPk2HtDjUCpVLwFFqXZCpDwngeDJ4
	YbmrHaUOxt4ABOjNEwFg/xIRm9Ahw3gkc26ICH0yLU5wqurSDI31Z2MbJ5JPfAvtdia9k59DFLU
	P6Pv8k5Xvy9BrWdvQpPfFG7yU+MJ7cMfTF4V4iKhkFkN6MuA3cYWc++6Pqucse/dB+Sh9a10b/q
	uFOQKUBO7g8vkq3rkmY43x+f7cddISCTU6u6BK45ENWMS6p7Bpi7RgDBMvhZW5DdxC7+bqC89uk
	gjXFajvnwmX0rmXJg1lPqQlMZf5bwy9UwXD0jCEad7n0aT6ZMcyWT+Zr5r+8OZ9F0msiP4eQ46y
	4/PPYRa867LCiCWIsWM2OqZnX0mZ6sflhOV3a9EJ3vJ9BKsnVhpCehKx+/7667CjAoPj5WCbh12
	aDWQtP8Cu8WF/ZUPOGJIZ9zGg==
X-Received: by 2002:a05:600c:6d03:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-4980c674f32mr25373785e9.12.1785575709469;
        Sat, 01 Aug 2026 02:15:09 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/19] arm64: dts: renesas: r9a08g046: Add SSI support
Date: Sat,  1 Aug 2026 10:14:44 +0100
Message-ID: <20260801091458.14026-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23840

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 17dc49f44c33cff7133fd48d5bc18bb0f625503a ]

Add SSI{0,1,2,3} nodes to RZ/G3L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505123708.134069-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 5f8eb93da3c1..70f820f14335 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -349,6 +349,82 @@ canfd: can@100c0000 {
 			/* placeholder */
 		};
 
+		ssi0: ssi@100e4000 {
+			compatible = "renesas,r9a08g046-ssi", "renesas,rz-ssi";
+			reg = <0 0x100e4000 0 0x400>;
+			interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 307 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G046_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A08G046_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G046_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2665>, <&dmac 0x2666>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi1: ssi@100e4400 {
+			compatible = "renesas,r9a08g046-ssi", "renesas,rz-ssi";
+			reg = <0 0x100e4400 0 0x400>;
+			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 310 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G046_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A08G046_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G046_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2669>, <&dmac 0x266a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@100e4800 {
+			compatible = "renesas,r9a08g046-ssi", "renesas,rz-ssi";
+			reg = <0 0x100e4800 0 0x400>;
+			interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 313 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G046_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A08G046_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G046_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x266d>, <&dmac 0x266e>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@100e4c00 {
+			compatible = "renesas,r9a08g046-ssi", "renesas,rz-ssi";
+			reg = <0 0x100e4c00 0 0x400>;
+			interrupts = <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 316 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G046_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A08G046_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G046_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2671>, <&dmac 0x2672>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g046-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.43.0


