Return-Path: <SRS0=VC0D=CG=lists.cip-project.org=bounce+64572+5314+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9BC2D0A8
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8A7207DF
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s7Hs2LwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8A7207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5314+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AoXTYY4521723xW1H052q5hw; Fri, 28 Aug 2020 09:07:54 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.45775.1598629367424711810
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:50 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804752"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:49 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 592CC400C4F0;
	Sat, 29 Aug 2020 00:42:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 24/30] ARM: dts: r8a7742: Initial SoC device tree
Date: Fri, 28 Aug 2020 16:41:49 +0100
Message-Id: <20200828154155.5827-25-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: K5gw56VSLzrJs0s57FgB7SUDx4520388AA=
Content-Type: multipart/mixed; boundary="8haR9PbtSO6DGkc07Cck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630874;
 bh=/QyR2iC1yyAaPS+4L6qGcyGONyI6PkX4H43E7F7KP/8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s7Hs2LwCmmEk/3tQM52rw8F6qw53ecHRlTl5JHNukjdpv5CFfaGEr8+aZf+nOHFZH0i
 gKDu+rGlECA6EAkqyY8hvyhg2/8W4279f8eJMuZ2iPTyg54Yw1rY3TLLeSodtsGuPGjSS
 0LCn93LSTxejoMGjyR4EmlpDaskSIvpE8AE=

--8haR9PbtSO6DGkc07Cck

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit eb4cdda7a30b3f9894fd5a58e0201fa57861183f upstream.

The initial R8A7742 SoC device tree including CPU[0-8], PMU, PFC,
CPG, RST, SYSC, ICRAM[0-2], SCIFA2, MMC1, DMAC[0-1], GIC, PRR, timer
and the required clock descriptions.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588542414-14826-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: reworked on clock, removed sysc, prr device nodes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 769 +++++++++++++++++++++++++++++++++
 1 file changed, 769 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742.dtsi

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
new file mode 100644
index 000000000000..af2ea73f9557
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -0,0 +1,769 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the r8a7742 SoC
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/r8a7742-clock.h>
+
+/ {
+	compatible = "renesas,r8a7742";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks@e6150000 {
+			compatible = "renesas,r8a7742-cpg-clocks",
+				     "renesas,rcar-gen2-cpg-clocks";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk &usb_extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "main", "pll0", "pll1", "pll3",
+					     "lb", "qspi", "sdh", "sd0", "sd1",
+					     "z", "rcan";
+			#power-domain-cells = <0>;
+		};
+
+		/* Variable factor clocks */
+		sd2_clk: sd2_clk@e6150078 {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150078 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd2";
+		};
+		sd3_clk: sd3_clk@e615026c {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615026c 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sd3";
+		};
+		mmc0_clk: mmc0_clk@e6150240 {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150240 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc0";
+		};
+		mmc1_clk: mmc1_clk@e6150244 {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150244 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "mmc1";
+		};
+		ssp_clk: ssp_clk@e6150248 {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe6150248 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "ssp";
+		};
+		ssprs_clk: ssprs_clk@e615024c {
+			compatible = "renesas,r8a7742-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0 0xe615024c 0 4>;
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "ssprs";
+		};
+
+		/* Fixed factor clocks */
+		pll1_div2_clk: pll1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pll1_div2";
+		};
+		z2_clk: z2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "z2";
+		};
+		zg_clk: zg_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+			clock-output-names = "zg";
+		};
+		zx_clk: zx_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <3>;
+			clock-mult = <1>;
+			clock-output-names = "zx";
+		};
+		zs_clk: zs_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <6>;
+			clock-mult = <1>;
+			clock-output-names = "zs";
+		};
+		hp_clk: hp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "hp";
+		};
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		b_clk: b_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <12>;
+			clock-mult = <1>;
+			clock-output-names = "b";
+		};
+		p_clk: p_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "p";
+		};
+		cl_clk: cl_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <48>;
+			clock-mult = <1>;
+			clock-output-names = "cl";
+		};
+		m2_clk: m2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "m2";
+		};
+		imp_clk: imp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "imp";
+		};
+		rclk_clk: rclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(48 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "rclk";
+		};
+		oscclk_clk: oscclk_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL1>;
+			#clock-cells = <0>;
+			clock-div = <(12 * 1024)>;
+			clock-mult = <1>;
+			clock-output-names = "oscclk";
+		};
+		zb3_clk: zb3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "zb3";
+		};
+		zb3d2_clk: zb3d2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "zb3d2";
+		};
+		ddr_clk: ddr_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7742_CLK_PLL3>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "ddr";
+		};
+		mp_clk: mp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&pll1_div2_clk>;
+			#clock-cells = <0>;
+			clock-div = <15>;
+			clock-mult = <1>;
+			clock-output-names = "mp";
+		};
+		cp_clk: cp_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&extal_clk>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "cp";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: mstp0_clks@e6150130 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
+			clocks = <&mp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7742_CLK_MSIOF0>;
+			clock-output-names = "msiof0";
+		};
+		mstp1_clks: mstp1_clks@e6150134 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150134 0 4>, <0 0xe6150038 0 4>;
+			clocks = <&zs_clk>, <&zs_clk>, <&zs_clk>, <&zs_clk>,
+				 <&p_clk>, <&zg_clk>, <&zs_clk>, <&zs_clk>,
+				 <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
+				 <&rclk_clk>, <&cp_clk>, <&zs_clk>, <&zs_clk>,
+				 <&zs_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_VCP1 R8A7742_CLK_VCP0
+				R8A7742_CLK_VPC1 R8A7742_CLK_VPC0
+				R8A7742_CLK_TMU1 R8A7742_CLK_3DG
+				R8A7742_CLK_2DDMAC R8A7742_CLK_FDP1_2
+				R8A7742_CLK_FDP1_1 R8A7742_CLK_FDP1_0
+				R8A7742_CLK_TMU3 R8A7742_CLK_TMU2
+				R8A7742_CLK_CMT0 R8A7742_CLK_TMU0
+				R8A7742_CLK_VSP1_DU1 R8A7742_CLK_VSP1_DU0
+				R8A7742_CLK_VSP1_R R8A7742_CLK_VSP1_S
+			>;
+			clock-output-names =
+				"vcp1", "vcp0", "vpc1", "vpc0", "tmu1",
+				"3dg", "2ddmac", "fdp1-2", "fdp1-1", "fdp1-0",
+				"tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
+				"vsp1-du0", "vspr", "vsps";
+		};
+		mstp2_clks: mstp2_clks@e6150138 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
+			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
+				 <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&zs_clk>,
+				 <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_SCIFA2 R8A7742_CLK_SCIFA1 R8A7742_CLK_SCIFA0
+				R8A7742_CLK_MSIOF2 R8A7742_CLK_SCIFB0 R8A7742_CLK_SCIFB1
+				R8A7742_CLK_MSIOF1 R8A7742_CLK_MSIOF3 R8A7742_CLK_SCIFB2
+				R8A7742_CLK_SYS_DMAC1 R8A7742_CLK_SYS_DMAC0
+			>;
+			clock-output-names =
+				"scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
+				"scifb1", "msiof1", "msiof3", "scifb2",
+				"sys-dmac1", "sys-dmac0";
+		};
+		mstp3_clks: mstp3_clks@e615013c {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
+			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&p_clk>, <&sd3_clk>,
+				 <&sd2_clk>, <&cpg_clocks R8A7742_CLK_SD1>, <&cpg_clocks R8A7742_CLK_SD0>, <&mmc0_clk>,
+				 <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
+				 <&hp_clk>, <&hp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_IIC2 R8A7742_CLK_TPU0 R8A7742_CLK_MMCIF1 R8A7742_CLK_SCIF2 R8A7742_CLK_SDHI3
+				R8A7742_CLK_SDHI2 R8A7742_CLK_SDHI1 R8A7742_CLK_SDHI0 R8A7742_CLK_MMCIF0
+				R8A7742_CLK_IIC0 R8A7742_CLK_PCIEC R8A7742_CLK_IIC1 R8A7742_CLK_SSUSB R8A7742_CLK_CMT1
+				R8A7742_CLK_USBDMAC0 R8A7742_CLK_USBDMAC1
+			>;
+			clock-output-names =
+				"iic2", "tpu0", "mmcif1", "scif2", "sdhi3",
+				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
+				"iic0", "pciec", "iic1", "ssusb", "cmt1",
+				"usbdmac0", "usbdmac1";
+		};
+		mstp4_clks: mstp4_clks@e6150140 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
+			clocks = <&cp_clk>, <&rclk_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7742_CLK_IRQC R8A7742_CLK_RWDT R8A7742_CLK_INTC_SYS>;
+			clock-output-names = "irqc", "rwdt", "intc-sys";
+		};
+		mstp5_clks: mstp5_clks@e6150144 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&hp_clk>, <&hp_clk>,
+				 <&extal_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_AUDIO_DMAC0 R8A7742_CLK_AUDIO_DMAC1
+				R8A7742_CLK_THERMAL R8A7742_CLK_PWM
+			>;
+			clock-output-names = "audmac0", "audmac1",
+					     "thermal", "pwm";
+		};
+		mstp7_clks: mstp7_clks@e615014c {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+			clocks = <&mp_clk>, <&hp_clk>, <&zs_clk>, <&zs_clk>, <&p_clk>,
+				 <&p_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>, <&zx_clk>,
+				 <&zx_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_EHCI R8A7742_CLK_HSUSB R8A7742_CLK_HSCIF1
+				R8A7742_CLK_HSCIF0 R8A7742_CLK_SCIF1 R8A7742_CLK_SCIF0
+				R8A7742_CLK_DU2 R8A7742_CLK_DU1 R8A7742_CLK_DU0
+				R8A7742_CLK_LVDS1 R8A7742_CLK_LVDS0
+			>;
+			clock-output-names =
+				"ehci", "hsusb", "hscif1", "hscif0", "scif1",
+				"scif0", "du2", "du1", "du0", "lvds1", "lvds0";
+		};
+		mstp8_clks: mstp8_clks@e6150990 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+			clocks = <&zx_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
+				 <&zg_clk>, <&hp_clk>, <&p_clk>, <&zs_clk>,
+				 <&zs_clk>, <&zg_clk>, <&hp_clk>, <&p_clk>, <&zs_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_R_GP2D R8A7742_CLK_VIN3 R8A7742_CLK_VIN2
+				R8A7742_CLK_VIN1 R8A7742_CLK_VIN0
+				R8A7742_CLK_ETHERAVB R8A7742_CLK_ETHER
+				R8A7742_CLK_SATA1 R8A7742_CLK_SATA0
+				R8A7742_CLK_IMR_X2_1 R8A7742_CLK_IMR_X2_0
+				R8A7742_CLK_IMR_LSX2_1 R8A7742_CLK_IMR_LSX2_0
+			>;
+			clock-output-names =
+				"r-gp2d", "vin3", "vin2", "vin1", "vin0",
+				"etheravb", "ether", "sata1", "sata0",
+				"imr-x2-1", "imr-x2-0", "imr-lsx2-1", "imr-lsx2-0";
+		};
+		mstp9_clks: mstp9_clks@e6150994 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+			clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+				 <&p_clk>, <&p_clk>, <&cpg_clocks R8A7742_CLK_QSPI>, <&cp_clk>,
+				 <&hp_clk>, <&hp_clk>, <&hp_clk>, <&hp_clk>;
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_GPIO5 R8A7742_CLK_GPIO4 R8A7742_CLK_GPIO3
+				R8A7742_CLK_GPIO2 R8A7742_CLK_GPIO1 R8A7742_CLK_GPIO0
+				R8A7742_CLK_RCAN1 R8A7742_CLK_RCAN0 R8A7742_CLK_QSPI_MOD R8A7742_CLK_IICDVFS
+				R8A7742_CLK_I2C3 R8A7742_CLK_I2C2 R8A7742_CLK_I2C1 R8A7742_CLK_I2C0
+			>;
+			clock-output-names =
+				"gpio5", "gpio4", "gpio3", "gpio2", "gpio1", "gpio0",
+				"rcan1", "rcan0", "qspi_mod", "iic3",
+				"i2c3", "i2c2", "i2c1", "i2c0";
+		};
+		mstp10_clks: mstp10_clks@e6150998 {
+			compatible = "renesas,r8a7742-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
+			clocks = <&p_clk>,
+				<&mstp10_clks R8A7742_CLK_SSI_ALL>, <&mstp10_clks R8A7742_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7742_CLK_SSI_ALL>, <&mstp10_clks R8A7742_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7742_CLK_SSI_ALL>, <&mstp10_clks R8A7742_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7742_CLK_SSI_ALL>, <&mstp10_clks R8A7742_CLK_SSI_ALL>,
+				<&mstp10_clks R8A7742_CLK_SSI_ALL>, <&mstp10_clks R8A7742_CLK_SSI_ALL>,
+				<&p_clk>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>,
+				<&mstp10_clks R8A7742_CLK_SCU_ALL>, <&mstp10_clks R8A7742_CLK_SCU_ALL>;
+
+			#clock-cells = <1>;
+			clock-indices = <
+				R8A7742_CLK_SSI_ALL
+				R8A7742_CLK_SSI9 R8A7742_CLK_SSI8 R8A7742_CLK_SSI7 R8A7742_CLK_SSI6 R8A7742_CLK_SSI5
+				R8A7742_CLK_SSI4 R8A7742_CLK_SSI3 R8A7742_CLK_SSI2 R8A7742_CLK_SSI1 R8A7742_CLK_SSI0
+				R8A7742_CLK_SCU_ALL
+				R8A7742_CLK_SCU_DVC1 R8A7742_CLK_SCU_DVC0
+				R8A7742_CLK_SCU_CTU1_MIX1 R8A7742_CLK_SCU_CTU0_MIX0
+				R8A7742_CLK_SCU_SRC9 R8A7742_CLK_SCU_SRC8 R8A7742_CLK_SCU_SRC7 R8A7742_CLK_SCU_SRC6 R8A7742_CLK_SCU_SRC5
+				R8A7742_CLK_SCU_SRC4 R8A7742_CLK_SCU_SRC3 R8A7742_CLK_SCU_SRC2 R8A7742_CLK_SCU_SRC1 R8A7742_CLK_SCU_SRC0
+			>;
+			clock-output-names =
+				"ssi-all",
+				"ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
+				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0",
+				"scu-all",
+				"scu-dvc1", "scu-dvc0",
+				"scu-ctu1-mix1", "scu-ctu0-mix0",
+				"scu-src9", "scu-src8", "scu-src7", "scu-src6", "scu-src5",
+				"scu-src4", "scu-src3", "scu-src2", "scu-src1", "scu-src0";
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <2>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <3>;
+			clock-frequency = <1400000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA15>;
+			capacity-dmips-mhz = <1024>;
+			voltage-tolerance = <1>; /* 1% */
+			clock-latency = <300000>; /* 300 us */
+
+			/* kHz - uV - OPPs unknown yet */
+			operating-points = <1400000 1000000>,
+					   <1225000 1000000>,
+					   <1050000 1000000>,
+					   < 875000 1000000>,
+					   < 700000 1000000>,
+					   < 350000 1000000>;
+		};
+
+		cpu4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z2>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z2>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z2>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		cpu7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <780000000>;
+			clocks = <&cpg_clocks R8A7742_CLK_Z2>;
+			power-domains = <&cpg_clocks>;
+			next-level-cache = <&L2_CA7>;
+		};
+
+		L2_CA15: cache-controller-0 {
+			compatible = "cache";
+			power-domains = <&cpg_clocks>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		L2_CA7: cache-controller-1 {
+			compatible = "cache";
+			power-domains = <&cpg_clocks>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+
+	/* External root clock */
+	extal_clk: extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	pmu-0 {
+		compatible = "arm,cortex-a15-pmu";
+		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	pmu-1 {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts-extended = <&gic GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+	};
+
+	/* External SCIF clock */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		pfc: pin-controller@e6060000 {
+			compatible = "renesas,pfc-r8a7742";
+			reg = <0 0xe6060000 0 0x250>;
+		};
+
+		rst: reset-controller@e6160000 {
+			compatible = "renesas,r8a7742-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
+
+		icram0: sram@e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63a0000 0x12000>;
+		};
+
+		icram1: sram@e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram@0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x100>;
+			};
+		};
+
+		icram2: sram@e6300000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe6300000 0 0x40000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe6300000 0x40000>;
+		};
+
+		dmac0: dma-controller@e6700000 {
+			compatible = "renesas,dmac-r8a7742",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x20000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&mstp2_clks R8A7742_CLK_SYS_DMAC0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
+
+		dmac1: dma-controller@e6720000 {
+			compatible = "renesas,dmac-r8a7742",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6720000 0 0x20000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&mstp2_clks R8A7742_CLK_SYS_DMAC1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
+		};
+
+		scifa2: serial@e6c60000 {
+			compatible = "renesas,scifa-r8a7742",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c60000 0 0x40>;
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp2_clks R8A7742_CLK_SCIFA2>;
+			clock-names = "sci_ick";
+			dmas = <&dmac0 0x27>, <&dmac0 0x28>,
+			       <&dmac1 0x27>, <&dmac1 0x28>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		mmcif1: mmc@ee220000 {
+			compatible = "renesas,mmcif-r8a7742",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee220000 0 0x80>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_MMCIF1>;
+			dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
+			       <&dmac1 0xe1>, <&dmac1 0xe2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			reg-io-width = <4>;
+			status = "disabled";
+			max-frequency = <97500000>;
+		};
+
+		gic: interrupt-controller@f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&mstp4_clks R8A7742_CLK_INTC_SYS>;
+			clock-names = "clk";
+			power-domains = <&cpg_clocks>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	/* External USB clock - can be overridden by the board */
+	usb_extal_clk: usb_extal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <48000000>;
+	};
+};
-- 
2.17.1


--8haR9PbtSO6DGkc07Cck
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5314): https://lists.cip-project.org/g/cip-dev/message=
/5314
Mute This Topic: https://lists.cip-project.org/mt/76477103/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8haR9PbtSO6DGkc07Cck--
