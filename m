From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  6 Jul 2018 19:10:58 +0100
Subject: [cip-dev] [PATCH v2 10/86] ARM: shmobile: r8a7745: Add clock index
	macros for DT sources
In-Reply-To: <1530900658-21832-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530900658-21832-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530900658-21832-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add macros usable by device tree sources to reference r8a7745 clocks by
index.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
Hello Ben,

We realized there was a problem with the indexes of v1 as
"rcan" has index 8 within clock-output-names property from
DT node cpg_clocks at e6150000 from file:
arch/arm/boot/dts/r8a7745.dtsi.

This patch replaces:
https://lists.cip-project.org/pipermail/cip-dev/2018-June/001285.html

We are sorry for any inconvenience this may cause to your process.

Thanks,
Fab

v1->v2:
* swapped R8A7745_CLK_Z2 and R8A7745_CLK_RCAN indexes

 include/dt-bindings/clock/r8a7745-clock.h | 147 ++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7745-clock.h

diff --git a/include/dt-bindings/clock/r8a7745-clock.h b/include/dt-bindings/clock/r8a7745-clock.h
new file mode 100644
index 0000000..f1659d5
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7745-clock.h
@@ -0,0 +1,147 @@
+/*
+ * Copyright (C) 2018 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7745_H__
+#define __DT_BINDINGS_CLOCK_R8A7745_H__
+
+/* CPG */
+#define R8A7745_CLK_MAIN		0
+#define R8A7745_CLK_PLL0		1
+#define R8A7745_CLK_PLL1		2
+#define R8A7745_CLK_PLL3		3
+#define R8A7745_CLK_LB			4
+#define R8A7745_CLK_QSPI		5
+#define R8A7745_CLK_SDH			6
+#define R8A7745_CLK_SD0			7
+#define R8A7745_CLK_RCAN		8
+#define R8A7745_CLK_Z2			9
+
+/* MSTP0 */
+#define R8A7745_CLK_MSIOF0		0
+
+/* MSTP1 */
+#define R8A7745_CLK_VCP0		1
+#define R8A7745_CLK_VPC0		3
+#define R8A7745_CLK_ADG			6
+#define R8A7745_CLK_TMU1		11
+#define R8A7745_CLK_3DG			12
+#define R8A7745_CLK_2DDMAC		15
+#define R8A7745_CLK_FDP1_0		19
+#define R8A7745_CLK_TMU3		21
+#define R8A7745_CLK_TMU2		22
+#define R8A7745_CLK_CMT0		24
+#define R8A7745_CLK_TMU0		25
+#define R8A7745_CLK_VSP1DU0		28
+#define R8A7745_CLK_VSP1_SY		31
+
+/* MSTP2 */
+#define R8A7745_CLK_SCIFA2		2
+#define R8A7745_CLK_SCIFA1		3
+#define R8A7745_CLK_SCIFA0		4
+#define R8A7745_CLK_MSIOF2		5
+#define R8A7745_CLK_SCIFB0		6
+#define R8A7745_CLK_SCIFB1		7
+#define R8A7745_CLK_MSIOF1		8
+#define R8A7745_CLK_SCIFB2		16
+#define R8A7745_CLK_SYS_DMAC1		18
+#define R8A7745_CLK_SYS_DMAC0		19
+
+/* MSTP3 */
+#define R8A7745_CLK_TPU0		4
+#define R8A7745_CLK_SDHI2		11
+#define R8A7745_CLK_SDHI1		12
+#define R8A7745_CLK_SDHI0		14
+#define R8A7745_CLK_MMCIF0		15
+#define R8A7745_CLK_IIC0		18
+#define R8A7745_CLK_IIC1		23
+#define R8A7745_CLK_CMT1		29
+#define R8A7745_CLK_USBHS_DMAC0		30
+#define R8A7745_CLK_USBHS_DMAC1		31
+
+/* MSTP4 */
+#define R8A7745_CLK_RWDT		2
+#define R8A7745_CLK_USB_DDM		6
+#define R8A7745_CLK_IRQC		7
+#define R8A7745_CLK_INTC_SYS		8
+
+/* MSTP5 */
+#define R8A7745_CLK_AUDIO_DMAC0		2
+#define R8A7745_CLK_PWM			23
+
+/* MSTP7 */
+#define R8A7745_CLK_USB_EHCI		3
+#define R8A7745_CLK_USBHS		4
+#define R8A7745_CLK_HSCIF2		13
+#define R8A7745_CLK_SCIF5		14
+#define R8A7745_CLK_SCIF4		15
+#define R8A7745_CLK_HSCIF1		16
+#define R8A7745_CLK_HSCIF0		17
+#define R8A7745_CLK_SCIF3		18
+#define R8A7745_CLK_SCIF2		19
+#define R8A7745_CLK_SCIF1		20
+#define R8A7745_CLK_SCIF0		21
+#define R8A7745_CLK_DU1			23
+#define R8A7745_CLK_DU0			24
+
+/* MSTP8 */
+#define R8A7745_CLK_IPMMU_SGX		0
+#define R8A7745_CLK_VIN1		10
+#define R8A7745_CLK_VIN0		11
+#define R8A7745_CLK_ETHERAVB		12
+#define R8A7745_CLK_ETHER		13
+#define R8A7745_CLK_DCU			30
+
+/* MSTP9 */
+#define R8A7745_CLK_GPIO6		5
+#define R8A7745_CLK_GPIO5		7
+#define R8A7745_CLK_GPIO4		8
+#define R8A7745_CLK_GPIO3		9
+#define R8A7745_CLK_GPIO2		10
+#define R8A7745_CLK_GPIO1		11
+#define R8A7745_CLK_GPIO0		12
+#define R8A7745_CLK_RCAN1		15
+#define R8A7745_CLK_RCAN0		16
+#define R8A7745_CLK_QSPI_MOD		17
+#define R8A7745_CLK_I2C5		25
+#define R8A7745_CLK_I2C4		27
+#define R8A7745_CLK_I2C3		28
+#define R8A7745_CLK_I2C2		29
+#define R8A7745_CLK_I2C1		30
+#define R8A7745_CLK_I2C0		31
+
+/* MSTP10 */
+#define R8A7745_CLK_SSI_ALL		5
+#define R8A7745_CLK_SSI9		6
+#define R8A7745_CLK_SSI8		7
+#define R8A7745_CLK_SSI7		8
+#define R8A7745_CLK_SSI6		9
+#define R8A7745_CLK_SSI5		10
+#define R8A7745_CLK_SSI4		11
+#define R8A7745_CLK_SSI3		12
+#define R8A7745_CLK_SSI2		13
+#define R8A7745_CLK_SSI1		14
+#define R8A7745_CLK_SSI0		15
+#define R8A7745_CLK_SCU_ALL		17
+#define R8A7745_CLK_SCU_DVC1		18
+#define R8A7745_CLK_SCU_DVC0		19
+#define R8A7745_CLK_SCU_CTU1_MIX1	20
+#define R8A7745_CLK_SCU_CTU0_MIX0	21
+#define R8A7745_CLK_SCU_SRC6		25
+#define R8A7745_CLK_SCU_SRC5		26
+#define R8A7745_CLK_SCU_SRC4		27
+#define R8A7745_CLK_SCU_SRC3		28
+#define R8A7745_CLK_SCU_SRC2		29
+#define R8A7745_CLK_SCU_SRC1		30
+
+/* MSTP11 */
+#define R8A7745_CLK_SCIFA3		6
+#define R8A7745_CLK_SCIFA4		7
+#define R8A7745_CLK_SCIFA5		8
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7745_H__ */
-- 
2.7.4
