Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4594.1794226539663596583
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TB7Z2Bdh;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.14, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJltEV4QrsPAX41c8NwJyPVsbYBZuEvLGs9gjfWR1UeUhWo8raszeOk4Ybv5VDz3hSimA6HiQlGMCgIEZg3xoPrHm3G5/vzswYEbRw4s56o4iOItL3mxWQinjJZy/7Gqlp4cLaEYdS0Ej/YCcx+r8O2F3lYAv+EcwToFcDYReaNeGionY1UwVS6tLV2E6mIPLXrKykjv9NeNnYmGIV6F8nAai5UnDWwYPIpEC6yk5HtfW0KWWIABeYSpDUBo6ZRevZAacEhmW7QKVERI36yGKlK6DhUaZ1nsSIqK38eHt6pO+Mcjs8KAzfgxDr4/HfGYtDgFfDpGmAScEXoe64wJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23zorooChZ39fF021RdPtMI99Tz1yEcHBj2ALfd9AcM=;
 b=XyMbI3t71tuhuoKjtm4R9/uzRjD8SEX1JXs0fSam4sd8QlHzXRAeAZRZ4BOfOVEI5FyJQuFHkScyixK2IVQimyEcZD35fMTuApdZf1xZtgv6D8RAndOZeywGKXI+si6Pm41+pMlCNOn2e5YcV3zpDoWNGwlme2pt4VNlQ/Y9KWhewgFwpnpmSjkf4qG9ceK2TsO4eLTN30GRE7qz4oIFyb3rcaws4oUaGFyoN0B9ppmhmMVZDXbaOjnD5noZ2gWnGfZw7tFStK5dYGtWyBQ9Bzos2TfPR7MVB3Yu5vX6cZo/vAZONiiwg1RPmWgUGNfBy6yy41+iyVxy+oVXTQ9WcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23zorooChZ39fF021RdPtMI99Tz1yEcHBj2ALfd9AcM=;
 b=TB7Z2BdhExcAgOw1Q6h/3mXQPGMr68/p6JczWbhFoNLAJSz5gFqRxHhUzelJ8KHDJlDursWuDPAyTNA9j3xiiSvkzj1Y5uscQgeSuvj53SBQcGY+eu1yE+EqstNYwTuhCoajmI9RoUGTHN0rczJ5JAgRP59vOaD9UtSqONwDkJI=
Received: from OSTP286CA0052.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:217::13)
 by OSCPR01MB16426.jpnprd01.prod.outlook.com (2603:1096:604:348::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:34 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:217:cafe::53) by OSTP286CA0052.outlook.office365.com
 (2603:1096:604:217::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:34 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D6316300022D;
	Mon,  9 Nov 2026 21:15:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 24/24] arm64: dts: renesas: Add LCDC overlays for RZ/T2H and RZ/N2H EVKs
Date: Mon,  9 Nov 2026 12:14:51 +0000
Message-ID: <20261109121451.6042-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OSCPR01MB16426:EE_
X-MS-Office365-Filtering-Correlation-Id: 424e4372-68d2-4723-e731-08df3e5b27ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|13003099007|11063799006|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021135927099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: e/tZ4NuUEAr45/r10ZrH8Zq6XjU3N/MNwbCNYlOI5WH/uxlRjXgqfIG9145Yq2T6T9Nw6rAmNlmNNBgLXxj3D2ovNEga48BAVTtPdaE4UAy8LKHSOMqLS1KHClXWy9NykcH1TNokVR/B0Y+PZq5/qcXc36DVWUcvI6BASMR2QtuA8welMhXPvAHHvNpenkRdXGWrI1ydbPD7upYg6boQVUB76LZXtiijBIezIk0tPvjl8lM1dThj0gqgXhnAldtPTpsDJ3x8DiLGa/seJxXjiAXqL8fi0ivgvm+nw/1eIYHp1NDpAaLskJ2pyR+nvqP+bXfIlpyg/6FuuhnckR4SEY07LMlb6qQVLxrmUOyxElggBPz1ul/qqYASRU/0m4K2YWl4J7cX4tUFfopH0RwOAdCWaP4QrZkDair+q9/XTDbu7UR5O+tKJD4nThdpHwUCejM8mX8nfsf7K09ySRp/gLUkVVB5wSxFQtwT9GFnDvilUKnbzvcRnelGIMGnDrGCBNQcEnB3qSCBlGxkRX1bGYzXeR7mFtZISijbGA9q1ORCCgNjsVrWoCZ3I0kl1iklU7sdf02+uoi32jtCKXbp2ptjC97YrR6zn4Wo584SgBsWGMKjtMD94QQn8fPyBi7qcqThkxBASCnnlcoifg6xi4PSQMsDKrshboEMl+57YBs=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(13003099007)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qo+HXnR5oVP3VGmii4O3TT8eJuPRH0kHJZO53JhSL9b4fcvPJb05aAJNGmYGAX+sfr28b8Rblzti3W4U1+2r3o+LRSAD1agySlElN0rnSuEMRZBY1LkQ7OhD75CVSHNYVu1fwHbS5KRKVP6RYMFFNt6vI9W5fexHnCWwM/GK6gqOIax7RBACnCFTlM7CLeTJJXLwFeIuAEHr9lt0MACV9q5qT9iQqxqLlAYhioilCQRAtW4Svvq/awoh1E7rI1CrsjgGxRy5Jc1/cclyWZ9JJM+eaWRJAOA9tmldAkMR9xv1QbKSneejaFkyZWnadYJOVYsXwCvC25Y7HOw+roYfRoNWPkUrS4RRgcQBx/a+GAB8Yu75n6rBiOX0Un8d5gXlBGX6GO8uon+ZrJ9kGkCCqjfRyvCvF/19btvZBsx5yGFzrO31C+eJ4HD9c99wozst
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:34.2243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e4372-68d2-4723-e731-08df3e5b27ef
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16426
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24727
Content-Type: text/plain; charset="utf-8"

commit a720aed53ff387632ff80758272950ac49bfaa39 upstream.

Add DT overlay support for enabling the DU/LCDC pipeline on the RZ/T2H
and RZ/N2H evaluation kits when fitted with an ADV7513 HDMI transmitter
on CN15/CN20.

Share the common ADV7513 and LCDC pin configuration between the two
overlays. Disable board functions whose pins are reassigned to LCDC,
including the affected LEDs, SDHI0 on the RZ/T2H EVK, and I2C0 on the
RZ/N2H EVK.

Move the LED8 and LED9 preprocessor conditionals inside the node
definitions so that the nodes remain present in the base DTS. This
allows the LCDC overlays to reference and disable the LEDs when their
pins are reassigned to display functions.

Configure the LCDC data and clock pins with slew-rate setting 1 as
recommended by the hardware manual. Use slew-rate setting 0 for the
HSYNC, VSYNC and DE pins, as testing with the ADV7513 showed unstable
display output and visible flicker when these synchronization signals
were configured for fast slew rate.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260819183829.3953529-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  6 ++
 .../renesas/r9a09g077m44-evk-cn15-lcdc.dtso   | 53 ++++++++++++++
 .../renesas/r9a09g087m44-evk-cn20-lcdc.dtso   | 63 ++++++++++++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 12 ++--
 .../dts/renesas/rzt2h-n2h-evk-du-adv7513.dtsi | 72 +++++++++++++++++++
 5 files changed, 202 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.=
dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g087m44-evk-cn20-lcdc.=
dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-du-adv7513.dt=
si

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/ren=
esas/Makefile
index 258966035b38e..5d48ad16dcc86 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -167,8 +167,14 @@ r9a09g057h44-rzv2h-evk-cn15-sd-dtbs :=3D r9a09g057h44-=
rzv2h-evk.dtb rzv2-evk-cn15-
 dtb-$(CONFIG_ARCH_R9A09G057) +=3D r9a09g057h44-rzv2h-evk-cn15-sd.dtb
=20
 dtb-$(CONFIG_ARCH_R9A09G077) +=3D r9a09g077m44-rzt2h-evk.dtb
+dtb-$(CONFIG_ARCH_R9A09G077) +=3D r9a09g077m44-evk-cn15-lcdc.dtbo
+r9a09g077m44-rzt2h-evk-cn15-lcdc-dtbs :=3D r9a09g077m44-rzt2h-evk.dtb r9a0=
9g077m44-evk-cn15-lcdc.dtbo
+dtb-$(CONFIG_ARCH_R9A09G077) +=3D r9a09g077m44-rzt2h-evk-cn15-lcdc.dtb
=20
 dtb-$(CONFIG_ARCH_R9A09G087) +=3D r9a09g087m44-rzn2h-evk.dtb
+dtb-$(CONFIG_ARCH_R9A09G087) +=3D r9a09g087m44-evk-cn20-lcdc.dtbo
+r9a09g087m44-rzn2h-evk-cn20-lcdc-dtbs :=3D r9a09g087m44-rzn2h-evk.dtb r9a0=
9g087m44-evk-cn20-lcdc.dtbo
+dtb-$(CONFIG_ARCH_R9A09G087) +=3D r9a09g087m44-rzn2h-evk-cn20-lcdc.dtb
=20
 dtb-$(CONFIG_ARCH_RCAR_GEN3) +=3D draak-ebisu-panel-aa104xd12.dtbo
 dtb-$(CONFIG_ARCH_RCAR_GEN3) +=3D salvator-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.dtso b/=
arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.dtso
new file mode 100644
index 0000000000000..aaddfc1154d54
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-evk-cn15-lcdc.dtso
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DT overlay for the RZ/T2H EVK with ADV7513 transmitter
+ * connected to DU enabled.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define RZT2H_IRQ8	24
+
+/*
+ * RZ/T2H LCDC configuration:
+ * ----------------------------------------------------------
+ * Function        Pin     SW Setting
+ * ----------------------------------------------------------
+ * LCDC_DATG0     P11_0, SW6[3]: OFF, SW6[4]: ON, SW6[5]: OFF
+ * LCDC_DATB1     P18_0, SW8[3]: OFF, SW8[4]: ON
+ * LCDC_DATB2     P18_1, SW8[1]: OFF, SW8[2]: ON
+ * IRQ8           P22_6, SW2[1]: ON, SW2[2]: OFF
+ */
+
+&{/leds/led-4} {
+	/* P18_0 is used for DU function LCDC_DATB1. */
+	status =3D "disabled";
+};
+
+&{/leds/led-5} {
+	/* P18_1 is used for DU function LCDC_DATB2. */
+	status =3D "disabled";
+};
+
+/*
+ * Disable SDHI0 as SW2 settings for eMMC/SD card conflict with DU pin
+ * settings.
+ */
+&sdhi0 {
+	status =3D "disabled";
+};
+
+#include "rzt2h-n2h-evk-du-adv7513.dtsi"
+
+&adv7513 {
+	interrupts-extended =3D <&icu RZT2H_IRQ8 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&adv7513_irq_pins {
+	pinmux =3D <RZT2H_PORT_PINMUX(22, 6, 0x0)>; /* IRQ8 */
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-evk-cn20-lcdc.dtso b/=
arch/arm64/boot/dts/renesas/r9a09g087m44-evk-cn20-lcdc.dtso
new file mode 100644
index 0000000000000..9c9e4fc80363e
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-evk-cn20-lcdc.dtso
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DT overlay for the RZ/N2H EVK with ADV7513 transmitter
+ * connected to DU enabled.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#define RZN2H_IRQ5	21
+
+/*
+ * RZ/N2H LCDC configuration:
+ * ----------------------------------------------------------
+ * Function        Pin     SW Setting
+ * ----------------------------------------------------------
+ * LCDC_DATG0     P11_0, DSW12[3]: ON, DSW12[4]: OFF
+ * LCDC_DATG3     P14_3, DSW18[5]: OFF, DSW18[6]: ON, DSW19[3]: OFF, DSW19=
[4]: ON
+ * LCDC_DATG6     P14_6, DSW15[8]: ON, DSW15[9]: OFF, DSW15[10]: OFF
+ * LCDC_DATB2     P18_1, DSW18[9]: OFF, DSW18[10]: ON
+ * I2C_SCL1       P03_3, DSW7[1]: ON, DSW7[2]: OFF
+ * I2C_SDA1       P03_4, DSW7[3]: ON, DSW7[4]: OFF
+ * ------------------------------------------------
+ */
+
+&{/keys/key-1} {
+	/* P18_2 is used for DU function LCDC_DATB3. */
+	status =3D "disabled";
+};
+
+&{/leds/led-4} {
+	/* P18_1 is used for DU function LCDC_DATB2. */
+	status =3D "disabled";
+};
+
+&{/leds/led-7} {
+	/* P14_3 is used for DU function LCDC_DATG3. */
+	status =3D "disabled";
+};
+
+&{/leds/led-8} {
+	/* P14_6 is used for DU function LCDC_DATG6. */
+	status =3D "disabled";
+};
+
+&i2c0 {
+	/* P14_6 is used for DU function LCDC_DATG6. */
+	status =3D "disabled";
+};
+
+#include "rzt2h-n2h-evk-du-adv7513.dtsi"
+
+&adv7513 {
+	interrupts-extended =3D <&icu RZN2H_IRQ5 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&adv7513_irq_pins {
+	pinmux =3D <RZT2H_PORT_PINMUX(14, 0, 0x0)>; /* IRQ5 */
+};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index cd46acb3869d7..33e0d270a67b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -157,8 +157,8 @@ led-7 {
 			function-enumerator =3D <8>;
 		};
=20
-#if LED8
 		led-8 {
+#if LED8
 			/*
 			 * USER_LED0
 			 * DSW15[8]: OFF, DSW15[9]: OFF, DSW15[10]: ON
@@ -167,11 +167,13 @@ led-8 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
 			function-enumerator =3D <0>;
-		};
+#else
+			status =3D "disabled";
 #endif
+		};
=20
-#if LED9
 		led-9 {
+#if LED9
 			/*
 			 * USER_LED1
 			 * DSW15[5]: OFF, DSW15[6]: ON
@@ -180,8 +182,10 @@ led-9 {
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
 			function-enumerator =3D <1>;
-		};
+#else
+			status =3D "disabled";
 #endif
+		};
=20
 		led-10 {
 			/*
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-du-adv7513.dtsi b/ar=
ch/arm64/boot/dts/renesas/rzt2h-n2h-evk-du-adv7513.dtsi
new file mode 100644
index 0000000000000..d0242dc551610
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-du-adv7513.dtsi
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DT overlay common parts for the RZ/{T2H/N2H} EVKs with ADV7513
+ * transmitter connected to DU enabled.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
+
+#define ADV7513_PARENT_I2C i2c1
+#include "rz-smarc-du-adv7513.dtsi"
+
+&pinctrl {
+	du_pins: du-group {
+		du-data-pins {
+			pinmux =3D <RZT2H_PORT_PINMUX(10, 0, 0x28)>, /* LCDC_DATR0 */
+				 <RZT2H_PORT_PINMUX(10, 1, 0x28)>, /* LCDC_DATR1 */
+				 <RZT2H_PORT_PINMUX(10, 2, 0x28)>, /* LCDC_DATR2 */
+				 <RZT2H_PORT_PINMUX(10, 3, 0x28)>, /* LCDC_DATR3 */
+				 <RZT2H_PORT_PINMUX(10, 4, 0x28)>, /* LCDC_DATR4 */
+				 <RZT2H_PORT_PINMUX(10, 5, 0x28)>, /* LCDC_DATR5 */
+				 <RZT2H_PORT_PINMUX(10, 6, 0x28)>, /* LCDC_DATR6 */
+				 <RZT2H_PORT_PINMUX(10, 7, 0x28)>, /* LCDC_DATR7 */
+				 <RZT2H_PORT_PINMUX(11, 0, 0x28)>, /* LCDC_DATG0 */
+				 <RZT2H_PORT_PINMUX(14, 1, 0x28)>, /* LCDC_DATG1 */
+				 <RZT2H_PORT_PINMUX(14, 2, 0x28)>, /* LCDC_DATG2 */
+				 <RZT2H_PORT_PINMUX(14, 3, 0x28)>, /* LCDC_DATG3 */
+				 <RZT2H_PORT_PINMUX(14, 4, 0x28)>, /* LCDC_DATG4 */
+				 <RZT2H_PORT_PINMUX(14, 5, 0x28)>, /* LCDC_DATG5 */
+				 <RZT2H_PORT_PINMUX(14, 6, 0x28)>, /* LCDC_DATG6 */
+				 <RZT2H_PORT_PINMUX(17, 6, 0x28)>, /* LCDC_DATG7 */
+				 <RZT2H_PORT_PINMUX(17, 7, 0x28)>, /* LCDC_DATB0 */
+				 <RZT2H_PORT_PINMUX(18, 0, 0x28)>, /* LCDC_DATB1 */
+				 <RZT2H_PORT_PINMUX(18, 1, 0x28)>, /* LCDC_DATB2 */
+				 <RZT2H_PORT_PINMUX(18, 2, 0x28)>, /* LCDC_DATB3 */
+				 <RZT2H_PORT_PINMUX(18, 3, 0x28)>, /* LCDC_DATB4 */
+				 <RZT2H_PORT_PINMUX(18, 4, 0x28)>, /* LCDC_DATB5 */
+				 <RZT2H_PORT_PINMUX(18, 5, 0x28)>, /* LCDC_DATB6 */
+				 <RZT2H_PORT_PINMUX(18, 6, 0x28)>; /* LCDC_DATB7 */
+			drive-strength-microamp =3D <11800>;
+			slew-rate =3D <1>;
+		};
+
+		du-clk-pins {
+			pinmux =3D <RZT2H_PORT_PINMUX(9, 4, 0x28)>; /* LCDC_CLK */
+			drive-strength-microamp =3D <11800>;
+			slew-rate =3D <1>;
+		};
+
+		du-sync-pins {
+			pinmux =3D <RZT2H_PORT_PINMUX(9, 5, 0x28)>, /* LCDC_HSYNC */
+				 <RZT2H_PORT_PINMUX(9, 6, 0x28)>; /* LCDC_VSYNC */
+			drive-strength-microamp =3D <11800>;
+			slew-rate =3D <0>;
+		};
+
+		du-de-pins {
+			pinmux =3D <RZT2H_PORT_PINMUX(9, 7, 0x28)>; /* LCDC_DE */
+			drive-strength-microamp =3D <11800>;
+			slew-rate =3D <0>;
+		};
+	};
+
+	adv7513_irq_pins: adv7513-irq-pins {
+	};
+};
+
+&adv7513 {
+	pinctrl-0 =3D <&adv7513_irq_pins>;
+	pinctrl-names =3D "default";
+};
--=20
2.43.0

