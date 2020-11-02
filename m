Return-Path: <SRS0=G/l4=EI=lists.cip-project.org=bounce+64572+5702+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC781C00A89
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F5921D91
	for <cip-dev@archiver.kernel.org>; Mon,  2 Nov 2020 09:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CdZFDRYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F5921D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5702+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3cm6YY4521723x479JmEbEn3; Mon, 02 Nov 2020 01:24:48 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.28759.1604309087918325827
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2020 01:24:48 -0800
X-IronPort-AV: E=Sophos;i="5.77,444,1596466800"; 
   d="scan'208";a="61463271"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Nov 2020 18:24:46 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C00A54005E2A;
	Mon,  2 Nov 2020 18:24:45 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas: r8a774e1: Add PCIe device nodes
Date: Mon,  2 Nov 2020 09:24:38 +0000
Message-Id: <20201102092443.4142-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201102092443.4142-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: LQ1dFle2kgJ9v1PnGX9O4Uyhx4520388AA=
Content-Type: multipart/mixed; boundary="F7EdH0KpJ19UAfX5BB6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604309088;
 bh=TruGG7KpyoNJ80dtRl/dx56pywvGmm4CtI17g3zgyKM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CdZFDRYPSlSNkSYYjcXQtDxcOdh9PTUWSQG0OCTaWSTG+UPV2+HOinfAXZWjRn3QnB7
 PJnt2XMOfR6Uifjno8rvB86YkwVXMECEzjGwuWIjR600utkF4vpaNgMohoH2wcHqs/jdp
 w6haY24uZMHC8YM0Lk4z6pmz9v90PWGbcOY=

--F7EdH0KpJ19UAfX5BB6t

commit cbb2f09abcd635888508338d4436771fe07688d1 upstream.

Add PCIe{0,1} device nodes for R8A774E1 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1594919915-5225-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 47 ++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 0f86cfd52425..aaa55f9449f5 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1517,12 +1517,57 @@
 		};
 
 		pciec0: pcie@fe000000 {
+			compatible = "renesas,pcie-r8a774e1",
+				     "renesas,pcie-rcar-gen3";
 			reg = <0 0xfe000000 0 0x80000>;
 			#address-cells = <3>;
 			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000>,
+				 <0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000>,
+				 <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>,
+				 <0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
 			status = "disabled";
+		};
 
-			/* placeholder */
+		pciec1: pcie@ee800000 {
+			compatible = "renesas,pcie-r8a774e1",
+				     "renesas,pcie-rcar-gen3";
+			reg = <0 0xee800000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xee900000 0 0x00100000>,
+				 <0x02000000 0 0xeea00000 0 0xeea00000 0 0x00200000>,
+				 <0x02000000 0 0xc0000000 0 0xc0000000 0 0x08000000>,
+				 <0x42000000 0 0xc8000000 0 0xc8000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
+			status = "disabled";
 		};
 
 		hdmi0: hdmi@fead0000 {
-- 
2.17.1


--F7EdH0KpJ19UAfX5BB6t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5702): https://lists.cip-project.org/g/cip-dev/message=
/5702
Mute This Topic: https://lists.cip-project.org/mt/77977470/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--F7EdH0KpJ19UAfX5BB6t--
