Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4588.1794226532967713538
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZgQ843Ts;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.17, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrvcOEkyF7n4cbOLyn9L2VlxzVFjo5n/A196Qb0qtJY3GkdbD8fc7ZXA15HQ7ndAfGdomHALFupTu61bx97S+3rlMRgCMlNMOpoYxZlKuoK3pSS2YmjtiLC4Kb7t2NJa8BCfxYNNR18M14b5HTR4PDVBcZDxdYybvPNSrwKqmuGzAgZ13wvrttAmEOHbnxH1UVwaBAqKPKICgZiYAPMM6v8sAeeFS8uKrrExxry/ywbqvoO1OwbGh6soKWsrg6nSi4MvF4m/jkmgi2UxhB1qFHWNF6vPLiMbEI+6FUfT60srjHUqYgb8coFZ9Df7O73XumCZSnydIUFvNeJR0srgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF5Fakf4+Q1oWB+7WVgA/3HxH+z54oSqYtBi9f0h18k=;
 b=GtNVvtML1oXi4gEqSi3wNFbeA+MgTfam2+oVRSfWxaAz2t6W3oy9WKZD1J4T2cPbCNRS2UTdu7qdrybAj4qHr8wQGdo2VGz97llwuNryovTE0p1qLWsJOe+sUdiSBm6ZnPXega5tCmyaxcfesXQ10To70i4Idw+ZysSoECkEwlDmyUPXA/lP2V6jQHgAHoXuBGrjm8t6YP00co/YmBXY7aTr+YfsP6gtlN3CX+uKnePf/m+BrdMY5cF00CYYEH0yOBU8ewtr109CpILwrOnBJEDzf0DXOZeAja7ZcAiIjxGPq53o1NbE2D1pNE5royOgAVBxJ5ObYvGrR8UcHbsSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF5Fakf4+Q1oWB+7WVgA/3HxH+z54oSqYtBi9f0h18k=;
 b=ZgQ843TsLvx3FHobLN+vtjXLYf8ZMESKlsosi8D+THbA48mNpe0ZZAFHW/hMrI+mHxAgmERIQ2gINnWmKRzFcO3gxkZ0uDopkmJG+OMqqp5jAD7BzUp/Iv11+5cqVSN3lJCeX8B6Hbgdko6Iw0SzKA1alZ/NzloAWAFZbSd4NtY=
Received: from OS7P301CA0008.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26e::10)
 by OS9PR01MB16225.jpnprd01.prod.outlook.com (2603:1096:604:3eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:15:26 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26e:cafe::79) by OS7P301CA0008.outlook.office365.com
 (2603:1096:604:26e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:25 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 8C1DC300028E;
	Mon,  9 Nov 2026 21:15:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 19/24] arm64: dts: renesas: r9a09g077: Add VSPD and FCPVD nodes
Date: Mon,  9 Nov 2026 12:14:46 +0000
Message-ID: <20261109121451.6042-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|OS9PR01MB16225:EE_
X-MS-Office365-Filtering-Correlation-Id: acd0099c-1b0d-474a-7836-08df3e5b22fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|10067099003|13003099007|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QyoLIHS8+9z+C1T0DQZwtLqQEZMfaF9fNAPRJgjVxk9ZW1aElLqyzHtx4T75v6F7X9hUqLJMJ6oBURS7PmlUohZyBn969c+ROgj7AI8WsY/XIoB4QOFKxFhAQS6gSr6J+m/gMD6YcAw1LMXKJe1VqWnaAyH2Weay5LAy0wA6nBZU5OQmUhvXLSuk3545wrC04PPVdUUGYSsihm/xI26Hz4kX8Qt7Hrhm3VSeL8yEqtNvgL7ZEqOHSROU9GRkfCm30wiHx7WQsKZeP7qHiutEHxy9KKuXAZkE06S2X8ZtF8sR9ezsSu7U6AlnVcHX9BqMDAd+PuS/kz6EEApoxH+mtH+wlKVd531BcZTQU0ukKOReI1DPTO1ssCHZY1OF1GMlii2NuYJCVBYJ/lTD1sAZw4iVCvJ0Lz+PD/5zYh5xzJ568CW+8lRhQBL4zKrVcqzyvPKB6KGCKYySJIk43BwXh8wM9nH8rK0bfUz+WoYdtfM9BtdboJQlQUxnQwZfDHtQb74kN22vxeph1RKYfXKOeiKY66OZHDxpzCxL1A0yvX7QRE94nFJdOj5a3oHJNWzErk6uMu5pM8Sa+zgolhrxAogYGEViy22YoMSGaBArTxfdgoJOyCvO7n8VKTMk4TfUbRf3sch0rAijGidHY7bsLg==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(13003099007)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uk6eedFDpiuNoXbXT2PAsBtbeuBdFHYsjQv23eBzf2/7pkPlKsfy1hufNPnHrJ9AroXwM0kwlqnEpFcyKWt5V2R9/xdbSwzk4l1a+c8YdtFdyOVHKrvm8VKeXQM31HKRTw+XAiPLEAIY32mRYLMF7g7UtuSPyh/w68FTbMzy/NFWyrb4GP/7YAvNUnVnoPlGgc6MeGHl3RxuHCW5k0V52p4hYhepj+LP8M80rF5RmM9cT4W6LLZI7ezf5hhzgkfmrZTQt8cOgg03ExzmxTtePqwB0zTkUpBA3g2cUINUerfekRKR/pygNvNl2fsNiGu6lxaYvQn2upUBweTAu11mzSSSHnB8dcsWeIIhHqa7vxDdb0LjEeJhbwkl6P+NB1cZ5w/a03zErZz7Kz2Xs7V6Is7HUZbendXIsK7M8gPzq0qH3VIKiNjjcneyOWNts5Km
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:25.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acd0099c-1b0d-474a-7836-08df3e5b22fd
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24723
Content-Type: text/plain; charset="utf-8"

commit 61b6e44ac524847f5d76154a5efa17f92fd5b23b upstream.

Add VSPD and FCPVD nodes to RZ/T2H SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615115455.1412098-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g077.dtsi
index 0cc16bac5dbb2..6b26549997718 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -1269,6 +1269,28 @@ sdhi1_vqmmc: vqmmc-regulator {
 				status =3D "disabled";
 			};
 		};
+
+		fcpvd: fcp@920d0000 {
+			compatible =3D "renesas,r9a09g077-fcpvd", "renesas,fcpv";
+			reg =3D <0 0x920d0000 0 0x10000>;
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G077_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+		};
+
+		vspd: vsp@920e0000 {
+			compatible =3D "renesas,r9a09g077-vsp2", "renesas,r9a07g044-vsp2";
+			reg =3D <0 0x920e0000 0 0x8000>;
+			interrupts =3D <GIC_SPI 780 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKAH>,
+				 <&cpg CPG_MOD 1204>,
+				 <&cpg CPG_CORE R9A09G077_LCDC_CLKD>;
+			clock-names =3D "aclk", "pclk", "vclk";
+			power-domains =3D <&cpg>;
+			renesas,fcp =3D <&fcpvd>;
+		};
 	};
=20
 	stmmac_axi_setup: stmmac-axi-config {
--=20
2.43.0

