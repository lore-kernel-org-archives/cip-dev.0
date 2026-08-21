Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023C5DF96
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7145.1787318241160326053
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=VaPqgCYA;
 spf=pass (domain: renesas.com, ip: 40.107.74.37, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzriuUItwQ+/lhGQRt4qWDVobLxjn8lj5zYWNwjJc7EW8ZcXqsY9Z/IX5yA4PHQO+/LyLK/QY6jgIE63TVbyXOO1tlhRe4yR1ifUTP8Sc5bvrtUGoveqmagtrOg5D3FdoKmLp7EinR86aq40TyYY9nM2v76emj2IvNDhVIRsauYWB8rAkA3LK306TeezPiNO2bg7Vxed2afEorM4x9Nvl85SvR12bI66UkBv1kZLyOh+9KG6uPToLm2NJwYeFW/ge78FGR08uaItulSVIhSwGCb6hF1RsHB6LA3kysFHf+uiUiicZj/qfhjSuy5y9XrQfGzk3J7+2heFd5zzF2BA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpziuTma/923hzdOpoVdGSrYKkLRJ0kTdSSSxtVDuWg=;
 b=rSeiBGPgEfMACit6+we18M23Xpq33Og/ROk1n0xGt2krLOxFzNbkdG+6Fh90KB7E7CnXMV3oAUrRN4Ua+xttr5sgCAPB6t8UY2r+EEQB+PRHpRPtFubdT6kIQSrs87OVxKy5293k5NsUWCaZ20iJFHA/upcN2EHM2fGXiARKFQAT9CchGBnGLphqa51OJbNnijKLXotTn1tFRZs8iZ/OtDN3C2szisHPfboDnURpiGffZCO+vLet9V3l2Ex3q0fDwSsj0xiLyt5IbbkHeAgjf96JUQ/xBPYymg8io959QD4iAEeJitX1A1RSRyfKCJq9guT3zAkL0bLRtIK8DrXhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpziuTma/923hzdOpoVdGSrYKkLRJ0kTdSSSxtVDuWg=;
 b=VaPqgCYANZ4aC1JgxcA6w7W4rMWdVWi2SxtqOdEZePst9qdE5dsBrLAEyoBe0FaTd6fWwyK6R686WHXPeMQ1A9BqzP3I6xG44AaphjdQUNeU1uyp0XNScWGTD8C1JC5PtyaD097zs5JPYBfThUq5d3aXfiCiXxsJiI1FzTXoW70=
Received: from OS0PR01CA0027.jpnprd01.prod.outlook.com (2603:1096:604:25::14)
 by TYWPR01MB10064.jpnprd01.prod.outlook.com (2603:1096:400:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:17:18 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25:cafe::46) by OS0PR01CA0027.outlook.office365.com
 (2603:1096:604:25::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:18 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D902F3000374;
	Fri, 21 Aug 2026 22:17:16 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 18/18] arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add GPIO keys
Date: Fri, 21 Aug 2026 16:15:54 +0300
Message-ID: <20260821131554.638741-19-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TYWPR01MB10064:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6d82d22-c90b-44e5-907d-08deff86869e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	HURd3R0R+fYFj3X/dp67vlhqyCfBpCw1hC8mlZcoy80z4LWdHlZgIiZGtZh9kyHzBpbe7jBmFslNrgZMfddx9ZIortKiRVLvYJG3cuGXqbG1UAsmZTR7AotjIGmzm/cUzQVlFWWqoSDCH0zeNiLkiHyZ8Tj8tYdLENE3eiOChfqoKLV2FvE4R3LVBS5g+ShmWPhGckd/+8AOnaW/K6fkms2/YwN6j5ujHERoOv3vDzVeAiJs1mdh0776ooEjbCv9VL/BIVxXt3kV5SEvvacLQ259U1PRJW71zwExgfNPrOc1SjTWsl8IZuiit7cRSn+6x3YaevXmuHlqXAhjXSu3veAI2BySBiLOxw1bFj9VMQrYfFEJNAEJE8XwuZFlYVRRAwSLsnJufJ45J1e1GBC9oUpJz0ja3JjYZi8QZoiy80yfDW+inc1CSs19VHYbL0PP/dTOsje5+B2v/QCZe5B0kFFakuRfldVL9TlDwWhRejBjUhddMttjVirBQVpSjM+xPOCHo/1tvjXZIt9QInoHrXUwHkoEv8oo2xmtBRNlorJpeNmZ2hbhtQj9tgKGpM6ch2LQccbAh3QaSjhvkySUD8FQMieU+glYKPSpbpdGvsHoLTSud+7IAdZETeQeUJF2OuCR1A0ct+HEJ09mlVxReLiyJwEKPgCReiUQKCQsvks=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IkHJpgW+IXNUv+fJUztvPW8hizSlBQIpTL7+39CLc631GN7+UXmYgJFlzmp9DMV/gLxpInWEeIt1z9v9AMvkZJG55olrTpPqKz1sjU5XLu8799usFs44QZsIsyzLYV0+ocYUU7luywkd7oBpeTZhnEub5JY9p/XQj/mNz6K0HY+JCQGwtCFq/5VBNYqvurhl2ZQ1NiOKTRcUWd+e6tahCHiY3RlEo0E4OjsG6lv7sIroNe3agB1P0AID5NEPcfnkpXwEelBYQnw6dmxJiOlPHRQApnH5xd22xHAa81U3mJqF9D2hatSPuG3xB7Au7cemkirZDk92s9df/kZ7Kvm2dNzAWTVIig+unicUG8OcHSg+Wx6xbDcC4Pyof0qIP9ykJn9ItMCOOX7fsUduc6MXaelF6pmh/u/6WToOdTR6qvxTgjUbYBTHwq4KQitH40il
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:18.1787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d82d22-c90b-44e5-907d-08deff86869e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23975

commit 2c089ad703527f5ae08c7c362a9dfe5a660ab16d upstream.

The Renesas RZ/N2H Evaluation Kit has three user buttons connected to
GPIOs that can be used as input keys.

Add support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-9-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 06f1c14560da..eb19e3c565ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -7,6 +7,8 @@
=20
 /dts-v1/;
=20
+#include <dt-bindings/input/input.h>
+
 #include "r9a09g087m44.dtsi"
=20
 /*
@@ -81,6 +83,34 @@ / {
 	model =3D "Renesas RZ/N2H EVK Board based on r9a09g087m44";
 	compatible =3D "renesas,rzn2h-evk", "renesas,r9a09g087m44", "renesas,r9a0=
9g087";
=20
+	keys {
+		compatible =3D "gpio-keys";
+
+		key-1 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(18, 2) IRQ_TYPE_EDGE_FALLI=
NG>;
+			linux,code =3D <KEY_1>;
+			label =3D "SW2";
+			wakeup-source;
+			debounce-interval =3D <20>;
+		};
+
+		key-2 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(0, 4) IRQ_TYPE_EDGE_FALLIN=
G>;
+			linux,code =3D <KEY_2>;
+			label =3D "SW3";
+			wakeup-source;
+			debounce-interval =3D <20>;
+		};
+
+		key-3 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(18, 7) IRQ_TYPE_EDGE_FALLI=
NG>;
+			linux,code =3D <KEY_3>;
+			label =3D "SW4";
+			wakeup-source;
+			debounce-interval =3D <20>;
+		};
+	};
+
 	leds {
 		compatible =3D "gpio-leds";
=20
--=20
2.55.0


