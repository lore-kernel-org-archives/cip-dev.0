Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4585.1794226525861471880
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OKmJhc2w;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.23, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCVXarrlFVr6vnEJUJGU9prrjFCCIDYxxvqPRruuND9cWuqO9i+A2QHFuXkSdKNVb/13eNu4/3DKcDpwdOA3hkm/wbwkHp6cnqfZCLBtp74k0nMVsbZschiNfkN5ATrRxxtKi0EmaqLNBYIkiBVjfDctu51elotwsjwOYxt3pSqfKnfGdpemsZG2eORFA6oMXv8aY47glxrW4bRvHohoqbfztsWEi5moujtazcVLRN2M9Tp6aviHtw7IFJd8IIfMEDjIb7mBWoeSDnwuP8+bB1bYE/zxEbe2/e5gZs3gCKnQvjYJywsXnbky4Q8ff65j9YogSSVGr8206wI2Yx6QWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms/olreYZwHFdwp88apxL/y1uKP9kOQlLDHqwfHL6DU=;
 b=wNAl+tPtNfaYHDCQcHfx6PVJA8cGFy3zmNPCINyyH2rHp2mjptNNeI3sP2oMHMV8TZJPhZVY9DN7IjnoXOZSt0rmqgs57rkxrmATSKmU9saX7UL3DXOExhhlMk0A+DOYtumW29W11JbfscTNTIgZ8u4dUhSqpRKUtwi1z4801FSqMmyz4INIjtfuQjztP88ilFrfI+rc/GUijh1bGasxbtdkEsNUyz+Ha90KoSpW4Btm2kf8KDwXZXD3/bokaTYZBm2g/em2PbU0gVhHqsDlT4R3S0Gi/KnJM/K239552OYcVo+I4VSqWUJTEFiys9Nq4P9yh8Q7ezHYqYBmG7jzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms/olreYZwHFdwp88apxL/y1uKP9kOQlLDHqwfHL6DU=;
 b=OKmJhc2wuLAylcz1l1kiAbW+HUL9ytlmG8z5fiINY2rYiJwEJcUhUxJ49xNYDadFGnVTsWgtuHoyeDpndGmH2g2M0UPLoWP0kDL2yLgNIzRKFEaa0Df0A+eGTQjjH2yqaFHFiTzqmdGp3Qm6ca4N3k2Ro2sYHnvgTiStKC1UhEs=
Received: from OS7PR01CA0059.jpnprd01.prod.outlook.com (2603:1096:604:254::17)
 by OSOPR01MB18012.jpnprd01.prod.outlook.com (2603:1096:604:477::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:22 +0000
Received: from OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:254:cafe::31) by OS7PR01CA0059.outlook.office365.com
 (2603:1096:604:254::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D215.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:22 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1F29C300022D;
	Mon,  9 Nov 2026 21:15:20 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/24] clk: renesas: r9a09g077: Add RTC clocks
Date: Mon,  9 Nov 2026 12:14:44 +0000
Message-ID: <20261109121451.6042-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D215:EE_|OSOPR01MB18012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe0f143-4869-4c01-b2b7-08df3e5b20ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261102130727099003|261102123227099003|10067099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: NfkPhcBW5rc7Hj2gW0yFRxXjQ9/451nhsSiCxXnxVC4ZQesBmpj+ksNJkuAGNDhhWfPpm03AHJTdpPFQInX7WbjnWPhoQMC+8vJKtqIJqbT3ZdYYmpAFqr+PkoMsmR12/EuDhfhIsxqMEo7aS7TtM6/lz+lkuV+/o/QwNiwQy9SoJQpIy0rqiAvhYzcA/WK/rPF1w1fNNZew64HqmOhiBEUw6YYcA5WZRYIYpW89rc3Y4TrnFC90LeJJQ9KRDcvvRDnc3B8UXApFMa4PeAJj9GtFkaUh029lmU9bSLfXR86JBvYsygGRKq23/2FJZ/rqlIXMtGO8VTqu+Gh54OhHVeVe2A3o7nWwtQwpqSrZ0VCvTImutog7KBmvHeCBWI622oLOfAQ+ADyJHQtBFrb4E8+lFeS8fXm+S9cBaI6OxuGo8yjiKCw38y0FyigMf7IKZYiaXPrR01d0leGduxRhMmv0HaBgUrqh+45EdPxK4YTkQrNp31tu0tuQlWewUidcd/TnMd81Sc6eDq1Y+tn1/EecemW6DLJPPj7vAsC7TMrtjBig1170Ge6exyKLAeR+bb567w7V/KTwq/hzrbSj4TmWIZ7MhL3MnMIBjh5/09qR3Nmw38RZQa+m2yXQ2lKwBqu/cXN7Py1WQ0cnOFuX/A==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261102130727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fevCmU9kDlC7V1fUxfpyx4wqUKjOuYkmpAXfgHO2Oh0uXb0PhZWxZd/c8791lrEzv/e0eDlxhOGRfxnTQI3p6OCH/AyKiX6TtNI+hytF2x40SF+8NNRFqAJmc2I9Kt16XbEy1LKrn/S/jLeGS38azmxXWWcopHBW4C7A/dMX8kT6qA9AUypNoaA01Qrxfp32lF0KH20ObYo6qkjNwwNwxPy6TLzl2skHZexPGT09nhKVVelokg1PtLcpZlRITXqst3ZaZcVTG93RPSxyZSV7TyFoO3yfy0QIYIc+XQz2zae7W5DbWWYNzCam4K6gOuL+ZHwZV/jzVDbIMFnZBlLR54yxGXh7UjdQoOSXnZOWpyeDoTBkjxY1TGUQJhNFAeIICCx3K54RsOj6N+Lc6PcoPiiB54ArwIH/HfBs+1jKWs6bOt2KZ5aqndoUoPxqN7y2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:22.4790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe0f143-4869-4c01-b2b7-08df3e5b20ef
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB18012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24720
Content-Type: text/plain; charset="utf-8"

commit 182b03cbe80fea16c8a2f6faaf890e0d8ee0ba46 upstream.

Add the core and module clock definitions for the Real-Time Clock (RTC)
peripheral on the Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260615143943.1610095-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a0=
9g077-cpg.c
index 7cc7439290d35..ceb48f9a6ab67 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -86,7 +86,7 @@ enum rzt2h_clk_types {
=20
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK =3D R9A09G077_PCLKCAN,
+	LAST_DT_CORE_CLK =3D R9A09G077_PCLKRTC,
=20
 	/* External Input Clocks */
 	CLK_EXTAL,
@@ -241,6 +241,7 @@ static const struct cpg_core_clk r9a09g077_core_clks[] =
__initconst =3D {
 			 FSELXSPI1, dtable_6_8_16_32_64),
 	DEF_MUX("PCLKCAN", R9A09G077_PCLKCAN, FSELCANFD,
 		sel_clk_pll4d3_div10_div20, ARRAY_SIZE(sel_clk_pll4d3_div10_div20), 0),
+	DEF_FIXED("PCLKRTC", R9A09G077_PCLKRTC, CLK_EXTAL, 128, 1),
 };
=20
 static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst =3D {
@@ -270,6 +271,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] _=
_initconst =3D {
 	DEF_MOD("sci5fck", 600, CLK_SCI5ASYNC),
 	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
 	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
+	DEF_MOD("rtc", 605, R9A09G077_CLK_PCLKL),
 	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
 	DEF_MOD("sdhi1", 1213, R9A09G077_CLK_PCLKAM),
 };
--=20
2.43.0

