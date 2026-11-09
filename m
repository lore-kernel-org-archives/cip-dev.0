Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4584.1794226525228882900
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gtNATR2S;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.15, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwJoC0iQF6uFb+nYmxGV1/DHF+P49uXHzMUaiBmKod5q8T5EEZDdA81MMmphyIvrpNTfMEnn1N82iniQlJVdUy3c2+PqxHNF0ZEjQRtFFQU0nZ9/kR6fiA8Vt40Qf7/4tAMMYarDEAed9XcR+AkZpYgYFp9FhG+tzGexKPotXZb5CNKb1ZlP+Q/lAkzpQqmOzrY3611+YFZcBO5vds8Srldl5A6HAinEskWwLfIB7Pm0jbV0rRkmLVa6qWA3pTB3umCsWbQuYXf1AxD6AuUVPn+nqa2yVNn57htDY0GA4oVC6MMk30b4NamugzyyM19rBOURbOCZs++xSbkNkasEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDjEnfXGMDP5ultr2wz+upKl+ZyXgDQRllEe/emLzPk=;
 b=DQfpxYzkWMOhvPdaHqjRMhyp1SqtIzIaQQAr1PX2knxDlvxwJOkXRlNhyFePahUVm/TUK0dLo7lTYho1aRFnT6ds5lyXWSOMjNZD2p3iaNeRwA7EeBb66kagTdEsJWhh+AhOsvB0xlhuhFYkWiz0uvtIpwMwruS5GxjbgR1WX99N7u/Gfk5QNroi0lQAiTOmPXWCxu1K6lC9jfpnIjWvinVt6ozViJaKlke2DGoUfBVnDBzdJLYRFdKmDJD9HqjD8DLuJa7IUKW1DNcwv+2pkH/Pq68/LqL26NFfIza/EBVnQFqLWwsQIjZ+vmIWKLAdBy7KLgAxuKEKgcY2ADWy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDjEnfXGMDP5ultr2wz+upKl+ZyXgDQRllEe/emLzPk=;
 b=gtNATR2S7tZ/fIGSIv1HqkubdK3beJK2c14U6I6dqfq0CbVtAlDoSMp2VMOGmDw6B4KazD4w8nv3rx1i7OzZhy6dzcyGxBMIIDUZW6u5HNlczlH6EnjlU37EuT0vA0oB5hTk7/ewftaoc8JxgpTNA3jNHqGnPngm2UGwENx1I7E=
Received: from TY6P301CA0015.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::14)
 by OSOPR01MB18025.jpnprd01.prod.outlook.com (2603:1096:604:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:20 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::5c) by TY6P301CA0015.outlook.office365.com
 (2603:1096:405:3bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:20 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7077E30002A8;
	Mon,  9 Nov 2026 21:15:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/24] dt-bindings: clock: renesas,r9a09g077/87: Add PCLKRTC clock ID
Date: Mon,  9 Nov 2026 12:14:43 +0000
Message-ID: <20261109121451.6042-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OSOPR01MB18025:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a0fba7-42de-4871-e382-08df3e5b1fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006|261021121427099003|261009223027099003|261026121527099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c96FPh/6a3i8V/mpVyUUKf0IWslvyNhgjVkBfhubGziQBqoIQD7peRp4uqQeU+cslF+WLqUHWkdzmT16DqMXL5bIubyMl0aVVMjRbrpDj50KSgbKcJmVbC7Xajd6yE2WVSNykvzs+rO/j02GqoBkVix4K5aploGLZKULMXaVyXpKHhxar4/3EYUAmUUOUxqMOrRY41j4fqUQHinbrsmGldsVNN+IoBwApKqVKQ6ot9Yrs6tJuGRdbDOXJL/IBqCAWd2oWndCJk90cAT6Ryi7M5jrJl0RJ1yC1pvomaCwCGRl9KSEUFlFftkGwnTzv3iF/KpdOQ3SWQVKVSOGKOO7/qYf2NRhi+W8om47m8HYd9BfkUqtahioF0lSlSVpZeENKanfXJIxC82TMGIZEAeA8yMw462UeqA3kRydNrr2lrn940gfSwOjU5FJjJF6XaNWTWIXXbMFrfgoFZ5tfF+tQz+XzBU1//pzxdGppfrFf7drSFM+cmadVVK6/G1dCIk/kzbjMYMJMRuekKHjdjK6RDdbtJxaCl8ssIPpLoG01IHiJfG3AFWzRLszJ5kOPwEASwE902hUS023qOO7OminfX87srSVVIAXzHOujI3lusVdIDOanEHsxw6C5nLws2eWR5fwLETga/PCv8umgeJyDdmXHAKaO0ZrdYdu9TyWwnQ=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U75shx3kb4oHesfeJ2mYUSS8X5oiA4zt8ZGhBWwD/xllum7xpdAoWuYrG6Dw27lUA8e5vAqA4rnQ8dXtCXavyuroQBng50xjLYCFNLzMZ9gVnvMN75vbjpVspNgE31dQKQJ7nsMq/E44LDrFpQJ1nSCsXBdVQBgR7UDBJ5lULhslnoBTgyQqAC6DJKiFnvpkfky6dVrR5WYGmjSzIicsWvB8P670PnC1sNWEO5OA/XZATLl6OqYBc9QkthXSTNhbxzniuI+rQgPLJ8Z5KLSk2A820jma+YcpMlsRcoZJ9IfPhrE79xEg/DKjMOHb5ZrpDyew3XKeyjV7bMCk7ozIaUyPxl+rTKFHZczM4x3hkYjolC8xWgYc/4axji0JnfDLjZnIFR/JvYOgDaBOn8JavJVcQg3jLTnQSdLNpkVp8eHUgT+T40fk3OKjZPFi2I8q
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:20.7361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a0fba7-42de-4871-e382-08df3e5b1fe3
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB18025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24719
Content-Type: text/plain; charset="utf-8"

commit 2b005b458f6eeffdbe7705e6667437013b54e209 upstream.

Add the peripheral clock ID definition for the Real-Time Clock (PCLKRTC)
on the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

Note that the PCLKRTC clock is utilized as the operating clock source
for the RTC IP.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615143943.1610095-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 1 +
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/inclu=
de/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index f6cb8d649a467..aa47685f329af 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -35,5 +35,6 @@
 #define R9A09G077_XSPI_CLK1		23
 #define R9A09G077_PCLKCAN		24
 #define R9A09G077_LCDC_CLKD		25
+#define R9A09G077_PCLKRTC		26
=20
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/inclu=
de/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 312e563b322e7..1c73d0dcef184 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -35,5 +35,6 @@
 #define R9A09G087_XSPI_CLK1		23
 #define R9A09G087_PCLKCAN		24
 #define R9A09G087_LCDC_CLKD		25
+#define R9A09G087_PCLKRTC		26
=20
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
--=20
2.43.0

