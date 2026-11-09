Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4693.1794226539853536008
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TPpDtrD1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.57, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ07pE/UwLA8sk/fNlmNX9siV636PZmojbCOZBkBR6GgVAAcQ2s4c8/DProIdk6u5hEHMMDTmYunESZ53CZiKCUZc8w8vFKkiSPstWL0lvzsOVyMzqoYgNRjYU97Xirw8aNKkiSpfisYxoiNWJKBTBUHsAGpC2gRzb0fXNmihvlMCsjpHhY+nng/8yIOLrcVEqqd5lQUtl3NMixeO7dUlUQnfGMm3Fp1iZjuYScbMx5ntIZAMA4D6qjK+/5E7DRUqWT7DWng1kXmlMynQ4zMvlZb0wvOl/6dHrTFU2nHRYgZc/boaLxSJ9/a3XHs7Rzh4n9ScqHsWT/VXEY4ZuvPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYeIDQyslZ9bWwsW+nHtdo448q53TDYYn8oql05OeE8=;
 b=QtqPwhYY38i8vZgkEbw+GovWgh9D7bJwvVmxmvqex07Jy7GQKcK+p4jMV1gnXDQnNC0IDTm520UPv0ODvQsbiUy/FctJ1MnQx/7vtooPwr/yk+RPgvY7jgmW6ipKtei5ScX61OqXrOqPlWh3h8l76LoPhoLhO8WAaAQ/JQ5hbStaIbt5gdk3BJXbsMmmjmEhBKpYnQMYKeWC787cgxDA/LljyIko/RCUmh1TGrkWFjZ+P1ZSwVATUeSfGBFvwO51ft3Nt1aGKzEuhItTBuING3cNGXmGAwW5OHZrRZvz6Jn104wP2DusqxIhRGH459v0fOF+5T+APaDjeiiHfKVhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYeIDQyslZ9bWwsW+nHtdo448q53TDYYn8oql05OeE8=;
 b=TPpDtrD1rXzkxUSzl6xYJKjjzem4PlyUgK1Lrk6ED68P2VFObQfkGhFgP+uarkvmMAvQDT1mcEuwT2FrQXyskc32h1ZauXAVgU94yAyCxzFyGrDACl8Ee+isTF10E8tQ0ZAZmcYvzqW2G0INaFsBjixAZZvwelqEF151PiQHBEU=
Received: from TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:38b::10)
 by TY4PR01MB15995.jpnprd01.prod.outlook.com (2603:1096:405:2d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:32 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b:cafe::79) by TYCP286CA0309.outlook.office365.com
 (2603:1096:400:38b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:32 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 35D47300022D;
	Mon,  9 Nov 2026 21:15:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/24] arm64: dts: renesas: rzt2h-n2h-evk: Use consistent switch notation
Date: Mon,  9 Nov 2026 12:14:50 +0000
Message-ID: <20261109121451.6042-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY4PR01MB15995:EE_
X-MS-Office365-Filtering-Correlation-Id: b98c49b5-244d-4f94-e457-08df3e5b26e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: yEQ5xD2AA12nymQgu4UCF40zqISO21mzgaTxl0ONSPJ1jOxlm+O2t/ceZ/QPj4jG0y2eqshEZWMpsuO4I0uMjcRNL6NBX81pXC3alu4tOK41kxXwfui61+td73lEJASMpAx9fo27X/dc6WC+tGkF40qA5fIdITA5g7cLpTA7uN47YygvgLJD+QmoQsI27oNmiVVpP67zoC7FZk1RshYUuYmraiy+NFW3KAKcDuU/UjV8itAb6JOrF2i9mHR3hxAG/L/4XqAcdz+78FwU2fKYJ7H5qM5IGrjg4+7Ih+7/FVyWAFAWBxu1Ul9xo+Ag2Su7NVpau6Bj9AQ3FUU0pwIS6+IOd41OwHqRSo12pG8BwqqtAPwR2VrhQQ06JbF84raZxDVANrn11j86HtXhpyxnf8XfL3zUip03ZAYZqxhoOKhsfZ86kXe+CQlbnoySfFb7lJgGftDjzaJO/LPLaLW+R6kdANADXRC/e9EKWGat0me9S3RFTnxyq8fecw2Jcsc64x73tyV9izjrtHa4eOrzMdjMJTqfWgI5wdZhwwtTliRD/uPfISD8cn1Muxq/QAcrhwsU5K4MoeEn26ipTGCYPXqhBOTrAerL+2vgXdI7i3AFgf6UqQV5OdMrMb0dnbhRse+0olgjcYYEoQ8UFyutxcuMdIEgy16HLGWKhEeBvic=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CNKiz/u4RqWxrij3s/OVhxpnIs34JPRllRPue6e0ZUhjLe4WNTeqb+jjrEalpYuOHRy2fOO90++sDNyY+EMKrYHw4rbrNk0MJQElXYDvBARDOqgM0KSvQoI/gKW+bPOjjafHlFFsdCVcIze7UaMU24/70a17HPPP6Gkhqkn3aXgb9uTdL6v4wUscoKlq3jIaJo7R7ToKe3ghDaAWVFFG20L2cvOjZlRYFJyj1hqezUC3zH/kYQaLtiaMGL5nNajNJ5QvX81A0mzJci5sZ7Oh5vSj4UOeT/5WiwiXFJUG5XcjMfZROg4b7z+hhxqtH2o6MY3xesIuxzxkNmeAmXM5jJsJ+G435k8zb4ycBh7FMScA8jPagDmLkv1/w+EBE5bFS9EzZtYhmKrqUv96BIw7tIgxOznFThYNrAtHHfb/BFTNELCOSNygoAWBPe2jteOV
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:32.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98c49b5-244d-4f94-e457-08df3e5b26e8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15995
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24728
Content-Type: text/plain; charset="utf-8"

commit 110a97dd044ab70ad9d1e9b67acdf4db5703f87c upstream.

The switch comments in the board DT files use inconsistent notation,
with some references written as "SWx-y" and others as "SWx[y]" (and
"DSWx-y"/ DSWx[y] for the DIP switches on the RZ/N2H EVK).

Standardise on the "SWx[y]" / "DSWx[y]" form throughout both files so
switch references use a consistent notation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260819183829.3953529-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 18 ++++++++---------
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 20 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 89f3258b8bf6f..aad6ebab4a17e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -64,7 +64,7 @@ keys {
 		compatible =3D "gpio-keys";
=20
 #if (!SD1_MICRO_SD)
-		/* SW2-3: OFF */
+		/* SW2[3]: OFF */
 		key-1 {
 			interrupts-extended =3D <&pinctrl RZT2H_GPIO(8, 6) IRQ_TYPE_EDGE_FALLIN=
G>;
 			linux,code =3D <KEY_1>;
@@ -95,7 +95,7 @@ leds {
 		compatible =3D "gpio-leds";
=20
 		led-0 {
-			/* SW8-9: ON, SW8-10: OFF */
+			/* SW8[9]: ON, SW8[10]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(23, 1) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -103,7 +103,7 @@ led-0 {
 		};
=20
 		led-1 {
-			/* SW5-1: OFF, SW5-2: ON */
+			/* SW5[1]: OFF, SW5[2]: ON */
 			gpios =3D <&pinctrl RZT2H_GPIO(32, 2) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -119,7 +119,7 @@ led-2 {
=20
 #if (!SD1_MICRO_SD)
 		led-3 {
-			/* SW2-3: OFF */
+			/* SW2[3]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(8, 5) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_RED>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -128,7 +128,7 @@ led-3 {
 #endif
=20
 		led-4 {
-			/* SW8-3: ON, SW8-4: OFF */
+			/* SW8[3]: ON, SW8[4]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(18, 0) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -136,7 +136,7 @@ led-4 {
 		};
=20
 		led-5 {
-			/* SW8-1: ON, SW8-2: OFF */
+			/* SW8[1]: ON, SW8[2]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(18, 1) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_RED>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -144,7 +144,7 @@ led-5 {
 		};
=20
 		led-6 {
-			/* SW5-9: OFF, SW5-10: ON */
+			/* SW5[9]: OFF, SW5[10]: ON */
 			gpios =3D <&pinctrl RZT2H_GPIO(22, 7) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -152,7 +152,7 @@ led-6 {
 		};
=20
 		led-7 {
-			/* SW5-7: OFF, SW5-8: ON */
+			/* SW5[7]: OFF, SW5[8]: ON */
 			gpios =3D <&pinctrl RZT2H_GPIO(23, 0) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -160,7 +160,7 @@ led-7 {
 		};
=20
 		led-8 {
-			/* SW7-5: OFF, SW7-6: ON */
+			/* SW7[5]: OFF, SW7[6]: ON */
 			gpios =3D <&pinctrl RZT2H_GPIO(23, 5) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index eb19e3c565abd..cd46acb3869d7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -115,7 +115,7 @@ leds {
 		compatible =3D "gpio-leds";
=20
 		led-3 {
-			/* DSW18-7: ON, DSW18-8: OFF */
+			/* DSW18[7]: ON, DSW18[8]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(31, 6) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -123,7 +123,7 @@ led-3 {
 		};
=20
 		led-4 {
-			/* DSW18-9: ON, DSW18-10: OFF */
+			/* DSW18[9]: ON, DSW18[10]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(18, 1) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_RED>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -131,7 +131,7 @@ led-4 {
 		};
=20
 		led-5 {
-			/* DSW18-1: ON, DSW18-2: OFF */
+			/* DSW18[1]: ON, DSW18[2]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(22, 7) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -139,7 +139,7 @@ led-5 {
 		};
=20
 		led-6 {
-			/* DSW18-3: ON, DSW18-4: OFF */
+			/* DSW18[3]: ON, DSW18[4]: OFF */
 			gpios =3D <&pinctrl RZT2H_GPIO(23, 0) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
 			function =3D LED_FUNCTION_DEBUG;
@@ -148,8 +148,8 @@ led-6 {
=20
 		led-7 {
 			/*
-			 * DSW18-5: ON, DSW18-6: OFF
-			 * DSW19-3: OFF, DSW19-4: ON
+			 * DSW18[5]: ON, DSW18[6]: OFF
+			 * DSW19[3]: OFF, DSW19[4]: ON
 			 */
 			gpios =3D <&pinctrl RZT2H_GPIO(14, 3) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
@@ -161,7 +161,7 @@ led-7 {
 		led-8 {
 			/*
 			 * USER_LED0
-			 * DSW15-8: OFF, DSW15-9: OFF, DSW15-10: ON
+			 * DSW15[8]: OFF, DSW15[9]: OFF, DSW15[10]: ON
 			 */
 			gpios =3D <&pinctrl RZT2H_GPIO(14, 6) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
@@ -174,7 +174,7 @@ led-8 {
 		led-9 {
 			/*
 			 * USER_LED1
-			 * DSW15-5: OFF, DSW15-6: ON
+			 * DSW15[5]: OFF, DSW15[6]: ON
 			 */
 			gpios =3D <&pinctrl RZT2H_GPIO(14, 7) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_GREEN>;
@@ -186,7 +186,7 @@ led-9 {
 		led-10 {
 			/*
 			 * USER_LED2
-			 * DSW17-3: OFF, DSW17-4: ON
+			 * DSW17[3]: OFF, DSW17[4]: ON
 			 */
 			gpios =3D <&pinctrl RZT2H_GPIO(2, 7) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_YELLOW>;
@@ -197,7 +197,7 @@ led-10 {
 		led-11 {
 			/*
 			 * USER_LED3
-			 * DSW17-1: OFF, DSW17-2: ON
+			 * DSW17[1]: OFF, DSW17[2]: ON
 			 */
 			gpios =3D <&pinctrl RZT2H_GPIO(3, 0) GPIO_ACTIVE_HIGH>;
 			color =3D <LED_COLOR_ID_RED>;
--=20
2.43.0

