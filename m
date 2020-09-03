Return-Path: <SRS0=+u5p=CM=lists.cip-project.org=bounce+64572+5400+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E0C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 999AA206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BiEJ9Lho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999AA206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5400+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id buekYY4521723xlZzicr9pe4; Thu, 03 Sep 2020 07:43:13 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.15617.1599144186096464858
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56297559"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:12 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 18FDB40C46C1;
	Thu,  3 Sep 2020 23:43:10 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/6] ARM: dts: r8a7742: Add [H]SCIF{A|B} support
Date: Thu,  3 Sep 2020 15:43:02 +0100
Message-Id: <20200903144303.13275-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: YJnejLw616YWzLRBVuWyFVU3x4520388AA=
Content-Type: multipart/mixed; boundary="nFhAYy7S5VvCqXBTPp7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144193;
 bh=NH45+mZ4iF4N5K4y8N3ePUf32yYqFD7J6t54qi6WTtE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BiEJ9LhoLpmi7K6mUVLbvwkd0rLwZCXjis2w3/gWtMD+H7zXinx3fDms9yCD4LZ0uLx
 7KVOQSIugzi9rq5BWr+K/6dwJ14uELa0NrPOnDLK177/7r992O1lMgic/X2QTB78vfHQu
 QEr4ddk8Ejz+FCz/o0WgBUM6rfptVzFF7sw=

--nFhAYy7S5VvCqXBTPp7D

commit b2cb7d8d5f0c63615e38bfae2d632faf33aa8601 upstream.

Describe [H]SCIF{A|B} ports in the R8A7742 device tree.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588794695-27852-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: changed clocks and power-domains properties, removed resets property]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 145 +++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index cc452e243446..32ed4138dc1b 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -961,6 +961,34 @@
 			status = "disabled";
 		};
 
+		scifa0: serial@e6c40000 {
+			compatible = "renesas,scifa-r8a7742",
+				     "renesas,scifa";
+			reg = <0 0xe6c40000 0 0x40>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFA0>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x21>, <&dmac0 0x22>,
+			       <&dmac1 0x21>, <&dmac1 0x22>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scifa1: serial@e6c50000 {
+			compatible = "renesas,scifa-r8a7742",
+				     "renesas,scifa";
+			reg = <0 0xe6c50000 0 0x40>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFA1>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x25>, <&dmac0 0x26>,
+			       <&dmac1 0x25>, <&dmac1 0x26>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		scifa2: serial@e6c60000 {
 			compatible = "renesas,scifa-r8a7742",
 				     "renesas,scifa";
@@ -1035,6 +1063,123 @@
 			status = "disabled";
 		};
 
+		scifb0: serial@e6c20000 {
+			compatible = "renesas,scifb-r8a7742",
+				     "renesas,scifb";
+			reg = <0 0xe6c20000 0 0x100>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFB0>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scifb1: serial@e6c30000 {
+			compatible = "renesas,scifb-r8a7742",
+				     "renesas,scifb";
+			reg = <0 0xe6c30000 0 0x100>;
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFB1>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x19>, <&dmac0 0x1a>,
+			       <&dmac1 0x19>, <&dmac1 0x1a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scifb2: serial@e6ce0000 {
+			compatible = "renesas,scifb-r8a7742",
+				     "renesas,scifb";
+			reg = <0 0xe6ce0000 0 0x100>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFB2>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x1d>, <&dmac0 0x1e>,
+			       <&dmac1 0x1d>, <&dmac1 0x1e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif0: serial@e6e60000 {
+			compatible = "renesas,scif-r8a7742",
+				     "renesas,scif";
+			reg = <0 0xe6e60000 0 0x40>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_SCIF0>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+			       <&dmac1 0x29>, <&dmac1 0x2a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif1: serial@e6e68000 {
+			compatible = "renesas,scif-r8a7742",
+				     "renesas,scif";
+			reg = <0 0xe6e68000 0 0x40>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_SCIF1>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+			       <&dmac1 0x2d>, <&dmac1 0x2e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif2: serial@e6e56000 {
+			compatible = "renesas,scif-r8a7742",
+				     "renesas,scif";
+			reg = <0 0xe6e56000 0 0x40>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_SCIF2>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+			       <&dmac1 0x2b>, <&dmac1 0x2c>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif0: serial@e62c0000 {
+			compatible = "renesas,hscif-r8a7742",
+				     "renesas,hscif";
+			reg = <0 0xe62c0000 0 0x60>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_HSCIF0>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
+			       <&dmac1 0x39>, <&dmac1 0x3a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		hscif1: serial@e62c8000 {
+			compatible = "renesas,hscif-r8a7742",
+				     "renesas,hscif";
+			reg = <0 0xe62c8000 0 0x60>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7742_CLK_HSCIF1>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x4d>, <&dmac0 0x4e>,
+			       <&dmac1 0x4d>, <&dmac1 0x4e>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.17.1


--nFhAYy7S5VvCqXBTPp7D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5400): https://lists.cip-project.org/g/cip-dev/message=
/5400
Mute This Topic: https://lists.cip-project.org/mt/76608372/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nFhAYy7S5VvCqXBTPp7D--
