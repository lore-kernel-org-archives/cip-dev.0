Return-Path: <SRS0=PfZ6=CL=lists.cip-project.org=bounce+64572+5381+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7215BC2D0A8
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:44 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE1D20C56
	for <cip-dev@archiver.kernel.org>; Wed,  2 Sep 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FADA11Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE1D20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5381+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UEL6YY4521723x0Nq5GAwktr; Wed, 02 Sep 2020 09:06:44 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11147.1599062725125566061
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2020 09:05:42 -0700
X-IronPort-AV: E=Sophos;i="5.76,383,1592838000"; 
   d="scan'208";a="55980507"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 01:05:41 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.133])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 74E964008547;
	Thu,  3 Sep 2020 01:05:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 8/9] ARM: dts: r8a7742: Add MSIOF[0123] support
Date: Wed,  2 Sep 2020 17:05:16 +0100
Message-Id: <20200902160517.5181-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
References: <20200902160517.5181-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3Brb2aq6R3jGFnyW702ryktCx4520388AA=
Content-Type: multipart/mixed; boundary="Y9V2jbrDoTDigQ22HGUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599062804;
 bh=62SJPVZRpMlpunUT9BetLyu4abEkt9rs5/d+Zt58AcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FADA11CvvfG8C9AMFsJyTckANemrRuQXpsWDeAjv4JhRTA0T53olQ9jI/NiXGU1CCxA
 9rlGhOmn+leLX6WHNAdE5ZWdWCiaQ55IOdjKOJVefzx0mFW/SX0CPC1krNVwmyYDmsk74
 OtQ68l6pcJ+Qcck/3vQJOIBCQH/jemlDrAg=

--Y9V2jbrDoTDigQ22HGUt

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4b0ee283de6c525478c98d3b3d15a4aed7d96de6 upstream.

Add the DT nodes needed by MSIOF[0123] interfaces to the SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1591736054-568-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domain properties, removed resets property]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index ada98d3fe290..694b20354575 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -975,6 +975,66 @@
 			status = "disabled";
 		};
 
+		msiof0: spi@e6e20000 {
+			compatible = "renesas,msiof-r8a7742",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e20000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp0_clks R8A7742_CLK_MSIOF0>;
+			dmas = <&dmac0 0x51>, <&dmac0 0x52>,
+			       <&dmac1 0x51>, <&dmac1 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof1: spi@e6e10000 {
+			compatible = "renesas,msiof-r8a7742",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e10000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_MSIOF1>;
+			dmas = <&dmac0 0x55>, <&dmac0 0x56>,
+			       <&dmac1 0x55>, <&dmac1 0x56>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof2: spi@e6e00000 {
+			compatible = "renesas,msiof-r8a7742",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_MSIOF2>;
+			dmas = <&dmac0 0x41>, <&dmac0 0x42>,
+			       <&dmac1 0x41>, <&dmac1 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		msiof3: spi@e6c90000 {
+			compatible = "renesas,msiof-r8a7742",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6c90000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_MSIOF3>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x46>,
+			       <&dmac1 0x45>, <&dmac1 0x46>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@ee100000 {
 			compatible = "renesas,sdhi-r8a7742",
 				     "renesas,rcar-gen2-sdhi";
-- 
2.17.1


--Y9V2jbrDoTDigQ22HGUt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5381): https://lists.cip-project.org/g/cip-dev/message=
/5381
Mute This Topic: https://lists.cip-project.org/mt/76585848/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Y9V2jbrDoTDigQ22HGUt--
