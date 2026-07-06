Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F599C44502
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156754.1783362230825183331
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=odswGDfS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.41, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw0cLS/u8p4nOCLV8JlFPPLxdGbZGkNXE+A4zxalwKQaZbf1JRSeMFno+OlW9/eWS5QZozjh09g4q7Quo93Du9UrwkJx94Qclmmt0OoZrYk9/l5ebiD876Nyol99BzZqZlwGIPawl8EBrHlp5EwffTsBHFFetybfEYYzHmkkab/YOQhNeRLu0jW3WQ4xFNRQkQ2RQ6HKV8q1t0/s17auDXdA5GZTFaPnM2P8qJvv6CXzCNvWNYbZbBpRjCbPK99cXTX/Me6Kn6wy1AqhC1PWfqLpmR/xruvfLC0ixs83hdvUgZ42+y3cUxI13j9Dth8l9BefdxJksljFInuBKQQ/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOdmeJQxMlrmWhzpMgRwWNLCssKVXKhdijnQ+k2E6S4=;
 b=NieaECMiW6WpHNVy8+6Wg7J5BojEGs3gLf8ihBM7ot52q+Ma9Dx7t4SqddiFzdLfr5bJHwBjpJG32U63JRfJHXIImmJUqqTWSbbimGQdIMcl6ckHbw3eevr9Ju3JZv/8eJLmUJUv1JIfpBd7nTB1Cx9gFADPPNal0pXB2M26N9XfpQm6Qx0qEJ0iUUkzDbn6Mz/VuQtCCc0LgrVNKtwdcMhxXfP1DzcGrPPM9L3PsKDqB3oRN7W1XT+afJBJ8/hjvlJ4QoCMd3GPTw3mUyTxupIBQ6qgdeATvnQRL5BDxSZUiWwjwoLSoN+ryFzjE63DT1/OFAfBoJOy97nW43wz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOdmeJQxMlrmWhzpMgRwWNLCssKVXKhdijnQ+k2E6S4=;
 b=odswGDfSqZk1IPT3S1hV9PBLZgKhrCZEvYc72bO+XpDGqQ3DE4/3u3yO4DHLss2rskJNSAA3ETlsCaOIHBGIwpMqNFfD2ycDxBLPjCvCb8Oax+TIvvbCWnl3S3raI3stBraUhzH8n82HW/Gxzt52WVkaeti2Vox2H2hu/e0rQ3o=
Received: from TYCP286CA0113.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:29c::10)
 by TYWPR01MB9559.jpnprd01.prod.outlook.com (2603:1096:400:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 18:23:45 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c:cafe::74) by TYCP286CA0113.outlook.office365.com
 (2603:1096:400:29c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:45 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F0DAA300017B;
	Tue,  7 Jul 2026 03:23:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 8/8] arm64: dts: renesas: rzt2h-n2h-evk: Enable xSPI nodes
Date: Mon,  6 Jul 2026 19:23:28 +0100
Message-ID: <20260706182328.5237-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|TYWPR01MB9559:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e939bc5-c424-471d-e682-08dedb8bb73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|11063799006|13003099007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	tx4YpyUxJcWRmX/JiVVBe0/gQPDAuqNHtfJ7vpATXWJYOMwav3lL7Mq5TTkb1E4rPhbawjv17D06i7Lm8llFW4qw0gAvC78Y3cLLv9I9RHa9WO361InJX/4gtCkFhZOBnbA75+HEJGaEcOYwpU5yT4AEin9PB/9iUXq1V+t4Klc0WZdx7p2Iu84gEKTxyabg6HVleeJDPzvWIgxi1MUSa5lCfX+D+AQXAtEJ3FqEMpHBdKI6gA4YlhVpxandKc1CNtG3e+mwqQ78t3Zkj4495f0oYCoi3ft4b8b9X5FnKPc+l52ce9maSpdqck7wRIz8Wllq3sQsxDMiYXKuCmlXt4eh7rCy6u2G4IwdIom9+fzjqDOOjhG0M316KBlVMNI+jXWbBA77XLBFgJ1XR7EvprqUwXwfKSKXiu26qGFwHpQLHmfvB/A/7urOlIaUHPRPBmHhptrgHNDq0nz9kiZR2r1Q8N0q/7JEUmesdeetQ0SDhD4L0G+F7B9rbxPLSV2mM73wgwJYpCyxAH8ZMqZgeaVp7uGLRGRoMmpcPLb3Z28CVql4uG5ZOE3LgN4mQOqvTnFn8QL259LEm91IAxs5j2VpMpH0RpFmkmQNVCp//dVllB5cHILdFiVfuYyMUsNiJ6omkaPOL19vdzsGkd3nPw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(13003099007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ah2Y4AAzlRPnp4ob1vWEoXEjNuxcT5+sfH8miWeMOTTqBIFua/Li2tQt0MJGE3Q8cqR8E2JfijvVHF88SMUE44y6LIMPFSU05mRODb4/zZbOVSUyf+LMszeZZ6brPYO9/NRUQ67TNUSq5/UdG0Zl8thuLEXf/BKzgJWfnc9PmviIRb8Dstjvijx2OcjXHW2LjjaXDum/mB47w+A4aBRitnuafoCHCEbyhE5RIfCkWyVDjU0vT6V+BUQklTPewP7MY286ygeNYj9FAPYPSznL8Mz7VqiYL+z5HPKJeiz7YITwWJ1TzoXTl8Pts7BmnexqUbKPowqJofzjhKx0cfIj+xH4P71ZDpaNDeIDWhdoO60vOxKH4x294xw/yaNI6YisvMl9xEJLLloKFh+PA6fZAxaD78T3do1q7L3CNXQEdr6HLJFJ55HLLDHb1jrwEHCf
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:45.3838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e939bc5-c424-471d-e682-08dedb8bb73c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23470

commit f4418ce75760e5f546a1bdd0876056febc430b1f upstream.

Enable the xSPI0 and xSPI1 controllers on the RZ/T2H N2H EVK board.

Configure the xSPI0 controller interface to 1-bit (x1) mode, even though
the connected MX25LW51245 octal flash device supports octal mode.  Add a
corresponding inline hardware comment detailing this restriction;
operating in octal mode causes the BootROM to fail loading the
first-stage bootloader following a Watchdog Timer (WDT) reset.

Configure the xSPI1 controller interface connected to the AT25SF128A
flash device for 4-bit (x4) mode to utilize all available data lines.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260527202430.606341-1-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  15 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 127 ++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index ebb6ebb9cdcf..d5d3112e6dad 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -304,3 +304,18 @@ usb_pins: usb-pins {
 	};
 };
=20
+/*
+ * XSPI0 Pin Configuration:
+ * ------------------------
+ * Signal     | Pin     | SW5
+ * -----------|---------|---------------
+ * XSPI0_ECS  | P07_5   | 5: OFF, 6: ON
+ */
+&xspi0_pins {
+	ecs-pins {
+		pinmux =3D <RZT2H_PORT_PINMUX(7, 5, 0x1c)>; /* XSPI0_ECS0 */
+		drive-strength-microamp =3D <2500>;
+		input-schmitt-disable;
+		slew-rate =3D <0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/a=
rm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 6ed9289d8025..4cc68279b8e2 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
=20
+#include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/net/mscc-phy-vsc8531.h>
@@ -20,6 +21,8 @@ aliases {
 		mmc0 =3D &sdhi0;
 		mmc1 =3D &sdhi1;
 		serial0 =3D &sci0;
+		spi0 =3D &xspi0;
+		spi1 =3D &xspi1;
 	};
=20
 	chosen {
@@ -331,6 +334,45 @@ ctrl-pins {
 				 <RZT2H_PORT_PINMUX(17, 4, 0x29)>; /* SD1_CD */
 		};
 	};
+
+	xspi0_pins: xspi0-group {
+		ctrl-data-pins {
+			pinmux =3D <RZT2H_PORT_PINMUX(5, 1, 0x1c)>, /* XSPI0_CKP */
+				 <RZT2H_PORT_PINMUX(5, 3, 0x1c)>, /* XSPI0_CS0 */
+				 <RZT2H_PORT_PINMUX(5, 5, 0x1c)>, /* XSPI0_DS */
+				 <RZT2H_PORT_PINMUX(5, 6, 0x1c)>, /* XSPI0_IO0 */
+				 <RZT2H_PORT_PINMUX(5, 7, 0x1c)>, /* XSPI0_IO1 */
+				 <RZT2H_PORT_PINMUX(6, 0, 0x1c)>, /* XSPI0_IO2 */
+				 <RZT2H_PORT_PINMUX(6, 1, 0x1c)>, /* XSPI0_IO3 */
+				 <RZT2H_PORT_PINMUX(6, 2, 0x1c)>, /* XSPI0_IO4 */
+				 <RZT2H_PORT_PINMUX(6, 3, 0x1c)>, /* XSPI0_IO5 */
+				 <RZT2H_PORT_PINMUX(6, 4, 0x1c)>, /* XSPI0_IO6 */
+				 <RZT2H_PORT_PINMUX(6, 5, 0x1c)>, /* XSPI0_IO7 */
+				 <RZT2H_PORT_PINMUX(6, 6, 0x1c)>; /* XSPI0_RESET0 */
+			drive-strength-microamp =3D <9000>;
+			input-schmitt-disable;
+			slew-rate =3D <1>;
+		};
+	};
+
+	/*
+	 * XSPI1 Pin Configuration:
+	 * ------------------------
+	 * Signal     | Pin      | RZ/T2H (SW1)  | RZ/N2H (DSW2)
+	 * -----------|----------|---------------|---------------
+	 * ALL        | Multiple | 6: ON         | 6: ON
+	 */
+	xspi1_pins: xspi1-pins {
+		pinmux =3D <RZT2H_PORT_PINMUX(1, 0, 0x1c)>, /* XSPI1_CKP */
+			 <RZT2H_PORT_PINMUX(1, 1, 0x1c)>, /* XSPI1_CS0 */
+			 <RZT2H_PORT_PINMUX(1, 4, 0x1c)>, /* XSPI1_IO0 */
+			 <RZT2H_PORT_PINMUX(1, 5, 0x1c)>, /* XSPI1_IO1 */
+			 <RZT2H_PORT_PINMUX(1, 6, 0x1c)>, /* XSPI1_IO2 */
+			 <RZT2H_PORT_PINMUX(1, 7, 0x1c)>; /* XSPI1_IO3 */
+		drive-strength-microamp =3D <9000>;
+		input-schmitt-enable;
+		slew-rate =3D <1>;
+	};
 };
=20
 &sci0 {
@@ -394,3 +436,88 @@ &wdt2 {
 	timeout-sec =3D <60>;
 };
=20
+&xspi0 {
+	pinctrl-0 =3D <&xspi0_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+
+	assigned-clocks =3D <&cpg CPG_CORE R9A09G077_XSPI_CLK0>;
+	assigned-clock-rates =3D <50000000>;
+
+	flash@0 {
+		compatible =3D "jedec,spi-nor";
+		reg =3D <0>;
+		vcc-supply =3D <&reg_3p3v>;
+		m25p,fast-read;
+		/*
+		 * Configure for 1-bit mode to prevent the BootROM from failing
+		 * to load the first-stage bootloader following a watchdog reset.
+		 */
+		spi-tx-bus-width =3D <1>;
+		spi-rx-bus-width =3D <1>;
+		spi-max-frequency =3D <50000000>;
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			partition@0 {
+				label =3D "bl2-0";
+				reg =3D <0x00000000 0x00060000>;
+				read-only;
+			};
+
+			partition@60000 {
+				label =3D "fip-0";
+				reg =3D <0x00060000 0x007a0000>;
+				read-only;
+			};
+
+			partition@800000 {
+				label =3D "user-0";
+				reg =3D <0x800000 0x003800000>;
+			};
+		};
+	};
+};
+
+&xspi1 {
+	pinctrl-0 =3D <&xspi1_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+
+	assigned-clocks =3D <&cpg CPG_CORE R9A09G077_XSPI_CLK1>;
+	assigned-clock-rates =3D <50000000>;
+
+	flash@0 {
+		compatible =3D "jedec,spi-nor";
+		reg =3D <0>;
+		vcc-supply =3D <&reg_3p3v>;
+		m25p,fast-read;
+		spi-tx-bus-width =3D <4>;
+		spi-rx-bus-width =3D <4>;
+		spi-max-frequency =3D <50000000>;
+
+		partitions {
+			compatible =3D "fixed-partitions";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+
+			partition@0 {
+				label =3D "bl2-1";
+				reg =3D <0x00000000 0x00060000>;
+			};
+
+			partition@60000 {
+				label =3D "fip-1";
+				reg =3D <0x00060000 0x007a0000>;
+			};
+
+			partition@800000 {
+				label =3D "user-1";
+				reg =3D <0x800000 0x800000>;
+			};
+		};
+	};
+};
--=20
2.43.0


