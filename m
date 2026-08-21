Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE27C5DF8E
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:23 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7174.1787318240149935273
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=I18L+Hjd;
 spf=pass (domain: renesas.com, ip: 40.107.74.43, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3PnvgP1AzCFzkhWsD0irpij5KVZJcpPAfC5RfOKCyhBFoCPPvJtgQUbfXUuNXh8y1QJ9iBM8uMxuOzwN8e3fN0ubbZLC/7SLd/Dg49iWiDZGwu3cuqkdfDSswSEJ+Xn5bFSqRRNKXLKN/MXCmRg8PkMfZ33XocJCgKmGPEN2rVVNKSGN66rOjnZ8xrMB3dGiEDoSdBSyVE7IhSU8PKEHjbgoBWApLZNjRQmq3fpIvZR4zDgWJs0yhKtUAGsHiBMK0Rda+jgTQfr/gq3PpqJAGVar35uBuTw9DYq3BD8HW6ZR3v8kscX4AA8oMpGYuQJPlZGE1WQAIDMCPFp/LSJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GlUhumf+4c5+6dl533Fqcj2qA/nHnOXZNZT30sziTA=;
 b=zTPs6liMXFU1OjuFllOJPUc8Xe9iZBP5h25070vbQEfKqIu/UkBs9uiE5uZY6ZMShU1Y+yEySWPlmoNRvdX9bmBk7c+SuXl1ov0b+OA6EKmHMUut48QoZyWXtEkGBnKXJxhT5T/ok50fS+5LGTUfXSBC1eI/NX8Qcu1cU2fMTa3YKEvxsUYYX1ByeTJnZXvAasu256LzOaCKsNPyMUN/qLm/+fz2oBvKfkHJc2txEYarb1wx5m9uX/1hzEv47bVH68JCh2Wspryf9PdESnN7v7Xo6UqVJntKfSAw0nMkzN5EreaDcL38atByV6s6Y7gQEuAr+F/qWJnp+2DdegVI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GlUhumf+4c5+6dl533Fqcj2qA/nHnOXZNZT30sziTA=;
 b=I18L+HjdaHf7Zi56HVpqxzitF+rjOW2PzbhM4dTmVWpzCzqNuTg+gt/OucsG1zr6Rte0x/x1v/lT/h2kv7EfSg7Dljrw0ashtsl15S0q0R57NxiyaiSETLibqNx7RJxRLbZb/+RLxb7ftn1JxWb4osi32DfnHN2F95AKDVbVmQc=
Received: from TY6P286CA0042.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b7::13)
 by OSCPR01MB14411.jpnprd01.prod.outlook.com (2603:1096:604:3a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 13:17:16 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7:cafe::18) by TY6P286CA0042.outlook.office365.com
 (2603:1096:405:3b7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 13:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:17:16 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2BD5E3000374;
	Fri, 21 Aug 2026 22:17:14 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 17/18] arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add GPIO keys
Date: Fri, 21 Aug 2026 16:15:53 +0300
Message-ID: <20260821131554.638741-18-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OSCPR01MB14411:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: be737943-33d0-48cf-a207-08deff86858f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	SgoUqB+b8bgkKlOvmiwLpRQfnac1pPOZCDGAuALCd9HtkupzwZN+aX/I7yWZY1uQmsRe2NxoBRyUtu0SKmDaXaYBgipxwgjVx8tF4OlDcXptx7JKHpoJ0UHmWlC2krdttq5ZQbae5st+wtpAlwcDdJF4lS0Wgzxyy1NipETDwyDuumS0iu/KuzlGTiKHV+ESbzFKcaTe5tlHuEba34dKkj0G7YyCwo63KdOdI2GcueJLILwGBqlQ3s9VEr5cSw3kpNq1y+QjWSpoVhjYdZj0n8QUmtvwmei0bsWEpul4lHfFQ+M1w6GahgilwuhWrKWojmHYrNHU0YlNOfh8bDEqfJ0v6B9j6702NGOg7LWFmgnb6cm0jqodmFyhd2blsQZc+e+CA/rkVEKFJgzEOZxLJibpTKphF1VQrw8YJedCuq1q0SHqn/qg9K7kqLciLJaz73LVEma3ttaZA7g0nqU/z0uMy3bGw4gPGwFpeDyxjO7b2KkntLY5g3lvqSP9xhESnIijnr9fQQ34b4WfQw8nUYADY/n6kO8KhELBGIjQBhm4cbVsWhQbNHLHFm6vfzOM0ZdQiJmRgYEJzioo5mfD5aklk62lMcs86uopFSCsMUMCFxQW5X3BihxosYGIbDjLNtPwOunFs/f6feUUWZctdA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pb1jfPOZ5UK1wYt/bJ+6ju0fwxFFCGdx3heYnuJB0ggKsc/5s4HpNig9/3gDBwDAYTJTDNYABGCIeN3yaE/rDa5xaY8AG+3AqRrXVSZwdwF5z4DFNByGUFX0rd7DIthCrAVQ/vTv6AqBcoJy2aQRZ1mjNIff9a/uVHAe7A/xlRc2VklP3PCooIGAB15SH3X+ZR+rRjm3thMSe7hGWmbaDpdRXh7UqkK4AR0iOnuBCMVf5QB/iKz01679T5c/9046Sp5zEXB8IDTdpqZzQHmMGMVhMRWD2TyfN0vFmcln/kXmqQoOhVxxJy8JfEk9dodHGlihyYEldlXDh+5X2+it/yxrfIdG4amMrvIxlluk/m3BFeRUK1ZJBKgpegHnFU82TwwLmOBAQCPUpSx1tkJXg4do5djs2s5mjGXRk4CdzcotHGIXkrMMuz1LwDC22oKC
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:17:16.4163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be737943-33d0-48cf-a207-08deff86858f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23974

commit fcec728e1599f45f7956c1f7694706cf77cdf29e upstream.

The Renesas RZ/T2H Evaluation Kit has three user buttons connected to
GPIOs that can be used as input keys.

Add support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-8-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[ctani: resolve includes conflict]
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index d5d3112e6dad..89f3258b8bf6 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -7,6 +7,7 @@
=20
 /dts-v1/;
=20
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
=20
 #include "r9a09g077m44.dtsi"
@@ -59,6 +60,37 @@ / {
 	model =3D "Renesas RZ/T2H EVK Board based on r9a09g077m44";
 	compatible =3D "renesas,rzt2h-evk", "renesas,r9a09g077m44", "renesas,r9a0=
9g077";
=20
+	keys {
+		compatible =3D "gpio-keys";
+
+#if (!SD1_MICRO_SD)
+		/* SW2-3: OFF */
+		key-1 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(8, 6) IRQ_TYPE_EDGE_FALLIN=
G>;
+			linux,code =3D <KEY_1>;
+			label =3D "SW9";
+			wakeup-source;
+			debounce-interval =3D <20>;
+		};
+#endif
+
+		key-2 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(0, 3) IRQ_TYPE_EDGE_FALLIN=
G>;
+			linux,code =3D <KEY_2>;
+			label =3D "SW10";
+			wakeup-source;
+			debounce-interval =3D <20>;
+		};
+
+		key-3 {
+			interrupts-extended =3D <&pinctrl RZT2H_GPIO(8, 7) IRQ_TYPE_EDGE_FALLIN=
G>;
+			linux,code =3D <KEY_3>;
+			label =3D "SW11";
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


