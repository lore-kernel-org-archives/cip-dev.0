Return-Path: <SRS0=UqDJ=CK=lists.cip-project.org=bounce+64572+5354+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFDC433E6
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F8520707
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QSHKAUKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8520707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5354+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fWq0YY4521723xcpdnLW0voe; Tue, 01 Sep 2020 04:45:10 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11107.1598960480272809138
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:27 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="56086791"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:26 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 65979400752B;
	Tue,  1 Sep 2020 20:41:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 05/10] ARM: dts: r8a7742: Add I2C and IIC support
Date: Tue,  1 Sep 2020 12:41:09 +0100
Message-Id: <20200901114114.3465-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BuOAB8lzNVmQLvR4KCrKCENOx4520388AA=
Content-Type: multipart/mixed; boundary="duvERNLUtFZ0bExEDVf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960710;
 bh=Vo/vgvhQpxqLiBfDl/OEvmdKN421SBQe/bK/4LV3L38=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QSHKAUKRJw42KBaoLYuCn2Y2+2W588jPz3iZjBXFj14CGSp5l165B/r+kkMOfYz4fPS
 m8sv6LyzBQeVmyXtLz5z7bPV8d+wh+Tzhpn+j5DbwJ11hQ+kx1uBjSM/aSdMm4oOY9gmj
 0CmvbpMwcHnkvitpNTVDUFbbW123UqaWo3E=

--duvERNLUtFZ0bExEDVf2

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9af42b81cfc7f48d5384fc6a6c382dc716b45563 upstream.

Add the I2C[0-3] and IIC[0-3] device nodes to the R8A7742 device tree.

Automatic transmission for PMIC control is not available on IIC3 hence
compatible strings "renesas,rcar-gen2-iic" and "renesas,rmobile-iic" are
not added to iic3 node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1589555337-5498-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: changed clocks and power-domains properties, removed resets, i2c-scl-internal-delay-ns properties]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 110 +++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index d128fa1d4847..6693a54367aa 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -742,6 +742,116 @@
 			ranges = <0 0 0xe6300000 0x40000>;
 		};
 
+		i2c0: i2c@e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7742",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_I2C0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7742",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_I2C1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@e6530000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7742",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_I2C2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7742",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_I2C3>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic0: i2c@e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7742",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_IIC0>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic1: i2c@e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7742",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_IIC1>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic2: i2c@e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7742",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6520000 0 0x425>;
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_IIC2>;
+			dmas = <&dmac0 0x69>, <&dmac0 0x6a>,
+			       <&dmac1 0x69>, <&dmac1 0x6a>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic3: i2c@e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7742";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7742_CLK_IICDVFS>;
+			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
+			       <&dmac1 0x77>, <&dmac1 0x78>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller@e6700000 {
 			compatible = "renesas,dmac-r8a7742",
 				     "renesas,rcar-dmac";
-- 
2.17.1


--duvERNLUtFZ0bExEDVf2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5354): https://lists.cip-project.org/g/cip-dev/message=
/5354
Mute This Topic: https://lists.cip-project.org/mt/76554010/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--duvERNLUtFZ0bExEDVf2--
