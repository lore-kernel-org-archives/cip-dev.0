Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F69FC7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:49:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.web11.428.1750690134790822641
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tO7fogyj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgHhKF2b+RSSaMW0zSFY78hqBQ/I6T7ST8dzLO+N0M+0vNDrPeryHR2a0S+p4zYRyuu9Ntq43vZCSnqKbyn6nyxB05xkggXlGpn5OJRhTD329NblVofwHOvK8z9Y8/pxkUL6HIB85qRgjEyeeaX7UNo3MuDZZc/0iWKvC3G24vyFmmsNVWZKlgKLQLNz9yBi5u0wVcWrkuj0b8Gcf2GUn++7R9D3Xm9D8CwM87qphHwmFfI2w7JBQalA9oFzkESdJ8eZxyxFguxGzCA1amP/DTbxKykFCibl+LK9lY6j3COakV/nfw3mQdISp67XFXqbyiDkMPSJg5gSGPapDqPlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGXLuQJEwSRQLWyCwbyW5yUQ1arBICgtDcHGbRVoc6Q=;
 b=QjQsC/KupOunB4elutdFO6tKiyJDR2WASlGu0BROFw9RS+Z0d0ZUqYBiHEKyp6OKFUquun2FeMgafuJX4FyyeG/5QugkRh0wv9Gb1GM89KBZxPDVfiRhilyggqjnvSQR6wLgjrEZ2f1PS1bqNve9h+vlKSg1npP/4hYeStowRki3YPLJ0FBl3ZzLO7DGPcPiSdy9IUabPzSp55cJQ8/P7SHxi7b8pkB6lmgApeOacLVyYmIKgb1XT+8sktICFjH4UQpXiaxKoux9PoHNqasbLU5sAGQrDRhT84UgTAc6xvAB5p8Jx0MG563nsT/+Y8htSZAMlnAbQo7c6xla2xZVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGXLuQJEwSRQLWyCwbyW5yUQ1arBICgtDcHGbRVoc6Q=;
 b=tO7fogyjrN6UU0pd9ZXD0t2UsKx5tGONvjLJkOKEk4uJ1ZjaaClbTAorFrXkmCVyITLx22L7ovR/Fsg3IJK9R0K+eNeP/5yA7EPNLMtSKGTU+GevZc+IdpRWpBRUzRX53WJcM9Joozo2vEIcmEuL31BCCTbG59XFL0zHsn8Ijfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:53 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/10] arm64: dts: renesas: r9a09g047: Add SDHI0-SDHI2 nodes
Date: Mon, 23 Jun 2025 16:48:13 +0200
Message-ID: <20250623144817.2119838-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bdfc45-535c-4535-c9b2-08ddb265127f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jWsPvU1K+qIL5oO+PH5t20vwDm8KoToyZa53Ki+vExmAQyMIzxTn3X7HNR5Q?=
 =?us-ascii?Q?uEuOMghCtt+cPH1D+lgQwVC6ckgNK8qqLiy4XW2tIw9CAXhmwErJLtcuOoE7?=
 =?us-ascii?Q?uwTyQlCq5mdkvayly/FzLJEqAjY/KmelcKi94cuUF5jtXHGrRjkeqw4g9xBa?=
 =?us-ascii?Q?b5XqRCbQI02USFDBX0ZyirFtlJ/hTwBnMoFUfBkSHuuwRQuziasSLMOwBICR?=
 =?us-ascii?Q?zvNjdOmN/h/L1MXUSSxaR2Y4Vh+u5kgNcsF2zW+74+pjvJ5vf6SLizB1HQpU?=
 =?us-ascii?Q?z2DfrsPChauB4OqHSGskl5CSFPpyRkqAtMJYmzJLe5GEYufoKy/Dva5pGB/E?=
 =?us-ascii?Q?VGOxqmnkaCPpT+HhFZWxMdER+NT3MqoU0Vpd15U6Tcsc18OwHLeMWKaP5xPm?=
 =?us-ascii?Q?jnQ5SkUP8GCl9s7tKs8K9NPaqczmo81kK2Qcsy80gJumg2AK3TTAFupKdMLu?=
 =?us-ascii?Q?af3i6JMD4VC2wnmxuNvUlR1pL+uOd9YMRSl/9QoiRAl8hfQRlx3ujPsBcdJn?=
 =?us-ascii?Q?RgKNp50TG0Bt29cXlnagmr1Jugku/p0wFgzHfiKDu8PmySjMY45mBRvfFlzL?=
 =?us-ascii?Q?GdI70Wn8q/hrqe8slp+YSq2JYQaKyEoF5NX4fgxvkaeNE/hCQzd9xDrvDOMS?=
 =?us-ascii?Q?KMjOmUJeHPfXIflb8Ppk62W4UD051moZkzKDuFRCQ+1kVgyRoXej+MoDt0tS?=
 =?us-ascii?Q?ualKECyYMRA5UKREtrfE1nownY7ZJGbsViZeTRE+qXD9HA4kRp9BW/uHFRCk?=
 =?us-ascii?Q?FcdZMp9wggF+teTAzjT/XzCTmutKiXu2qiTy1kMXhyNRKjmlaqQu0jEVDSqW?=
 =?us-ascii?Q?X7lwv4VZrvdXpfE99JhjoDJIqUQGpgJoKR5WO5v1a3eViYwu2JMniU+WsIU8?=
 =?us-ascii?Q?oleNG2NOfrMn5tRc984+AtCCZeqknwRCq+p76wWjYsktUhgRoVm5hzg21tTS?=
 =?us-ascii?Q?qYLvtM1VMS0U4UVz2RkrhL/3Cu1IAdMJ2pRvTLfo2KsZbzK/dhvNf/Bj9SX8?=
 =?us-ascii?Q?9O/zZKLrE2oaGSQLvUIDcJQh6rO2ylOG34KFuc9cOkoi/EVWQFYM9ArUgH7W?=
 =?us-ascii?Q?TZlPR2Ke/ocVLUJR3ZgtP/t+T3/eImdE7c3LQDZHnz83T1D5TCcBmNDm8L1K?=
 =?us-ascii?Q?mVSgfu0lohEQLdQZfPCWcAH0ivpcsJodSIdA7jevDV9K0SqGLGuVEq4aBRmR?=
 =?us-ascii?Q?TITLuXF45CQsFg67lOTFvsyFTAlDfudRjOZOqA+Dr7f62Bkl7Ht8x16wayoh?=
 =?us-ascii?Q?rPh9yxrQ65m/igJBjNkXIwXBqqUfFGLn1aPbw/9fYSYABMk/fgTaMyXNDinb?=
 =?us-ascii?Q?+lc1Rj6SOWrepLZ6l2Mb++kEFpxQylRZCPiFMl7zVHwYUkBajvw5a6ayyiD9?=
 =?us-ascii?Q?pjq7pkMdXXeDfUf3zTs3BmqShzsHYPHuG4jgfxYMdKDdNGbo8pDFKkW7H0U+?=
 =?us-ascii?Q?2CE3oPqitz+XVyuAHMujN/TUcLy2ExKVZMhOEucijD+JWv8l4vtzd4pE96uy?=
 =?us-ascii?Q?gSLpU4XEzj39fjo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gectl+NGMRElTPxuRm3AXhVXlr3tVyQR/XF7G1p2aus6++RqtVSXlvmR6riH?=
 =?us-ascii?Q?pfGIEzsdisV+r2U4RpbaWf67aaDGJ1xDufwOpg1pYDXSiW8RYMhPFZLoKiTu?=
 =?us-ascii?Q?CBHnFKvs3jDAzll6sh2gskFAc6etDlR8CXL6/Y1x/m0rMXFtwOM1zNjeWPOU?=
 =?us-ascii?Q?KzK3Cxn/V9U3U2M96wLjJ0yqtQNj5Mz9NqW8dYpRXqEN8L9X5FSdZjavRAFX?=
 =?us-ascii?Q?t2BXiI/h86d2HKVTv49IxL7cImtTovAcM25wDgnwtOrZwieA+7sPFksBDI4k?=
 =?us-ascii?Q?gi1l+HZfZcaA2OuzOEwHjVQTugLk5xM/+DzVNSnppbAxMd64wwStVrFWO0+T?=
 =?us-ascii?Q?deZCJa+SRxGc6aeaPIR+jKnvXoTy8T+qUkRU2Rhz1lOFsLWwOuiq3b0wByHL?=
 =?us-ascii?Q?RDOzGLG5oJjkae4kxt6CBvfJLYfiCSQJDRZj6SPEnDSTVMN3Z60NSZN81jiD?=
 =?us-ascii?Q?teA+dhY7c/QpKXEM3BPZJt31bcs1XnSHx9TvX3PIQkF2MbaAzUKf1uIYdSj0?=
 =?us-ascii?Q?DM3x3da1LzTY4y1LoWeZA77dNA/vA1yFDfCvvfvpUKWvQ5dTzGBzId1Hcx0n?=
 =?us-ascii?Q?6wjouc/hvlg05PvFlA3+THvc8/LYtQqNTF886xElUlpj+fqgRGRJomXrEyYy?=
 =?us-ascii?Q?P/qLxUmZGIALB+cQAM4pBQ9NSt6MF5fsLuD8f6pdohoZZ5vMq3x1XxR0Db55?=
 =?us-ascii?Q?twr/rVeOk5E3C11qZxiMCwJxBQYdlH42G6lRh5llgRg9x2rwbcsRmATApei7?=
 =?us-ascii?Q?6tC0DOiSS4RRcqCKBBXBThNch5QXITg7mz6vhIynGEI4jRrIotk7G9OX5zsZ?=
 =?us-ascii?Q?5EXK+N+qEJ8C2CT74TACI6bgXIcsgoUVG8WKcE7bSuBVWXgI0YzF9RXiYlsV?=
 =?us-ascii?Q?ruHhP/0ziiO+t3V6F3tLGSv5Wc3znbYjBXGyIfZyXz+LC30nh71ZWTrOjQGT?=
 =?us-ascii?Q?blJOWIzXjXIh8yduYMcRYHq/fmsDIu5mbuRjSV0mhzhyOy9sfkzaTXTQjV8G?=
 =?us-ascii?Q?Y7FB0iKVxtLMaJLlV+ncRqM3ZoeSy0JFeZ6Zl28Ed8KDUnU10ykmi/LVCv/X?=
 =?us-ascii?Q?2A8afbKzqqDnJmxyEUiZea/YZy1M5g6Z3PVnb5y/kmy6s54ecSKbR6x+cOEI?=
 =?us-ascii?Q?uJM6mPcULgmuWXFwXtNjlhPN1p1PjA6XnHy7DL4y3oZipg8gsxDPEtW8VD9u?=
 =?us-ascii?Q?IyseoRtj+mw6g6D/r7eFLefUcYkqnB4Dy8bn/thgu77kpQtmSYb6Z0gLz6Bi?=
 =?us-ascii?Q?L2SlMblsdZCwe+foSY9AftvjlsrIBGIBZeO4psGEObQZEK2kaTJhrf1w9Sik?=
 =?us-ascii?Q?Ozz7rva7FUcsvzvt0jBeooxUJ5i8V6THx8UAytVn6IDiuzlYL2sYJK5W6bt2?=
 =?us-ascii?Q?ER2tO6Dbp83wWo0SM3jjLNMp/zM3iB5zHJeDhGSPbK+WbKO8l1BdoRxN3biN?=
 =?us-ascii?Q?isyLlJ0ItL1zdHU4R9I2PetNmwhFyjSyD1nbMPb7vn0iK0LW7Qtewc5yKoD9?=
 =?us-ascii?Q?n5CEP+QGhYeAK5ygkcBi+EfDDS44Jp6QR+/vfXtUdBgV97dGJq1jvUKZ/7C3?=
 =?us-ascii?Q?mwobJ2KW3vd7tUtf4Wp5j6Z+VgPkFIEMA4r3fh4wisq5weRx/0ZGRlsmTpmI?=
 =?us-ascii?Q?eKsrT0543L34kCmvMHtfdMQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bdfc45-535c-4535-c9b2-08ddb265127f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:53.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuGJhawcTZJE0OE8kZwE9/hHPBbvZla9h3NBSOkhQ4WTr9m4FIJ43BaG0yDVASjT5ttmuKaHhNZ6pqqVDp/ix7OmfnClD2+QQHjFx1oaq2yrxE5TERugU4rCAHOhoGVy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19211

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c4e4e22870acae3a3fe3fe0638f85175976dc906 upstream.

Add SDHI0-SDHI2 nodes to RZ/G3E ("R9A09G047") SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/20250206134047.67866-5-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 133aa3272d3a..928757b52b4a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -403,6 +403,66 @@ gic: interrupt-controller@14900000 {
 			interrupt-controller;
 			interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		sdhi0: mmc@15c00000  {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c00000 0 0x10000>;
+			interrupts =3D <GIC_SPI 735 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 736 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xa3>, <&cpg CPG_MOD 0xa5>,
+				 <&cpg CPG_MOD 0xa4>, <&cpg CPG_MOD 0xa6>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa7>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi0_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI0-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
+
+		sdhi1: mmc@15c10000 {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c10000 0 0x10000>;
+			interrupts =3D <GIC_SPI 737 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 738 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xa7>, <&cpg CPG_MOD 0xa9>,
+				 <&cpg CPG_MOD 0xa8>, <&cpg CPG_MOD 0xaa>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa8>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi1_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI1-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
+
+		sdhi2: mmc@15c20000 {
+			compatible =3D "renesas,sdhi-r9a09g047", "renesas,sdhi-r9a09g057";
+			reg =3D <0x0 0x15c20000 0 0x10000>;
+			interrupts =3D <GIC_SPI 739 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 740 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD 0xab>, <&cpg CPG_MOD 0xad>,
+				 <&cpg CPG_MOD 0xac>, <&cpg CPG_MOD 0xae>;
+			clock-names =3D "core", "clkh", "cd", "aclk";
+			resets =3D <&cpg 0xa9>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+
+			sdhi2_vqmmc: vqmmc-regulator {
+				regulator-name =3D "SDHI2-VQMMC";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				status =3D "disabled";
+			};
+		};
 	};
=20
 	timer {
--=20
2.43.0


