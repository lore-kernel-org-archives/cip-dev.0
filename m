Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B77C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:02 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.2])
 by mx.groups.io with SMTP id smtpd.web10.386.1750690072755413411
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=clEIiKeS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eivKhwuZc+gpJfLhpD+yoScq0oad2DRYyf3DsDbwHcr3PRDATxK6L4SYk9LOx5QXKjGjxq1a00yhrEsS9Qw94KdkPK7PbHvA/6iB2AM76jmHHEnUTm9Nmib+MgLCDGi+/puDSst4L4whrwGAt/S0mAxZBkLBSjsKPj6uiPVXYEz4McYa8EwMyKpNqCwKNXW2D3Jd7RGN1cfz1jttuAub6f5MCC2OXQEvzaFbC2jnEhLR9P0aUpXBwUWyYjdALYxkTSh8jpGSbMvsKEdqbPQwwvUVz9G1VVnA1roVD2jo7ATSUh4h/j9Ebm0Jv4oeE2ibdHgirkrHgHZZ/R4ZDaJN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asx9eyL6wmOeNXkFOYwjFUDLfLQU5Ku+Gju8IefX1Ow=;
 b=BW9Y4/C5+OsnyJVS1ORu44VXSg+xDwo8Dfn/v85JBeHunIG9oi9gA1g02ez+2KwUDsl80Exa63ZhnE6CorYXp8OinLZhN9UhYuHp55NDzihuqf17AYkavCbSu6RrqCCndW7YixoWMLkHGghmN2RouB/GyZLu71vSuOSScAhEPnO8RalM1onLrMFcCVgcqvxHg66gGGUOrzPMYe6zW1r5N5EhVO5VGhoDqHUeXNZB7hb+zCZSiltJJPqCsRO6wLPph9iC5ZJxEKJTxv/d8ulAFqiBhEE3C1XgtOirqGI1nkH56nkfMGU9x6T63zi5Ukyd/dM9jo9LXIhlhBrSdEVA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asx9eyL6wmOeNXkFOYwjFUDLfLQU5Ku+Gju8IefX1Ow=;
 b=clEIiKeS40x8P/yH+7PPx8fZ9zsu2kgPfv7X3D7xMywgGLwIdTqkRu3s4miXsWBSGy+entqWKxHBMFoRkuWE2yzgVaPHbmvleHvbtI6Fk2JPR/j0gCYWoFDNN95ba3oQyxL59ESFxaps9UAXDlNQ332S6M9aDcS8q5iHGTzWkOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:50 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/17] arm64: dts: renesas: rzg3e-smarc-som: Add support to enable SD on SDHI0
Date: Mon, 23 Jun 2025 16:46:38 +0200
Message-ID: <20250623144639.2119707-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bcfbc84-1d54-4e66-db88-08ddb264ed65
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?intHYPQfVr7ZyG9Xb14Tye2OhEYhQVz+HlAUl2HDG7ZNMjiRcb1jhxOEDd/l?=
 =?us-ascii?Q?Lsn2msoA0kFO3Mwwvqe7ZhXavg45tLE4Nhm3Vy0HEdtzmZNRha2ptVpE1Si1?=
 =?us-ascii?Q?oQORu7nqrYONm90xPg6QqdbafjVl265XEaIkjz0Ggq8F/W6bBZUs2FrOOkO7?=
 =?us-ascii?Q?s2PX/DHp83X2Cufgz2qtSDEBr4/7ZYj2ZTByqdHs/N3uJomDX7WIm8bK5lnM?=
 =?us-ascii?Q?Z5wEQKBg+2EM9TZ9xsbHQUQmiyv93/J9HC4pEt8NbR49IGKoYo1UYISidEes?=
 =?us-ascii?Q?JeorHZOjrSv4blSYpJPfZLYl41LlFQuV9qXvhvjVqaa5cWy17Kn/kY5mFVGF?=
 =?us-ascii?Q?BeA9pZ+lZEkCcJ6C3C5AeaphnNptm8d6HlW2lLPT0vuvb+Y6DV4vEcdAANmg?=
 =?us-ascii?Q?AgREZbK3tluykEClp7ox/jl58ZiXzlp7vO6ph163PC+rWLwo06h6iagbsilH?=
 =?us-ascii?Q?lM6TmfByO1Ee8izKVSga/zQuRwntriQNMtoZDAXJsDRP25zQHrad0pSlW1yC?=
 =?us-ascii?Q?bcTH6RGqGhk/c3AF/Tic1EBYNMT2fQieranhZOsukVJqbBZgbSuUxBT4WBXm?=
 =?us-ascii?Q?SGuimiJNOT4Z4uadlWL+zyG2ibslfRV50a97Z2nf2FQ7/WkvBM9sG1PBBVWJ?=
 =?us-ascii?Q?drhI7alLucnW7Z/Bvcr9fsq3x4nsCfqvpSbST0M+UO6m8/7jl9QsUpA8vhM2?=
 =?us-ascii?Q?9Kwtkc17Zi/39/dalStlZp0dN7emYnmPaDjuh/Dv5m9bOpuBs6HGM1zwSedo?=
 =?us-ascii?Q?zH2ch4v2GiBtlKO6ks43ATb+anCfTVBHHI7Ejblru/oxYb6+WKplndfuQCmf?=
 =?us-ascii?Q?H9VqgBDXN5lyBzQ4wsTRfxlACQ/Z8JlyiqUI5Ai6tG+rndDei6RSemUF+QVw?=
 =?us-ascii?Q?NztwrnJExG30s8q5wlh1jpqRmGn9aMLj+EUHOjw3CQ/j1X64pVZw7hqf3TLk?=
 =?us-ascii?Q?/ENQ7xG740HBjjnD/5LhfCoWeRlEp0SG7oBpmkuzeqa9FSEC3SY89GavHda2?=
 =?us-ascii?Q?DksTpmJPjkjFHhUcVPJ3nADVBMYfRD6sYdnKquZNrMoltpOT9LmdokZBm/Dw?=
 =?us-ascii?Q?O+XlaWJEIVrQzjbF1xPawnljSDcvSuaZI0W8LZ4TEO0TJsTqyWeQz1P4Y+LL?=
 =?us-ascii?Q?Fwxtff6pG/nCbkJQr5/SajqI+BrjBgnMEwMFS1WTfkyVEPIyQFn4m3YSlCiC?=
 =?us-ascii?Q?b4nU85ktGAlG0qObqkcHi4DxoeQ2U2X4DN3a7c3KBEk/DHEogDL2aqRR374Q?=
 =?us-ascii?Q?evzBWd/c11Zp6CyKrArkwt1R1k6KxPLvW8A+27tMvDXr3LocCFHSZdGSQvfy?=
 =?us-ascii?Q?lgtIy1NDFiauJL5FXYBa/XuMe6iI6VelHunuZXeejtIvr94qhySF9RjkCXuM?=
 =?us-ascii?Q?hSLTSu6qougQs1PatKoqTBJFM3G3rHCf4/La1cuarnoJqA0hMwUFOJCWkoGf?=
 =?us-ascii?Q?fEhW269ziEiaYndgV/xju+RP28QDc1MzNHi0AoeT3N6Gp9llbi1XVa3WQxV5?=
 =?us-ascii?Q?6WEPCZfVly6IE2I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dXU40B0iQZEcXuNrnTuofEb8ryB7fstBWpIvT6bybgriSUPT+IgoiEspY4ws?=
 =?us-ascii?Q?YR4S9i/X9TMuyS0ban1g321svrPs82AUBGGzAxpl5CyH//m0PyYb/O+NtjFN?=
 =?us-ascii?Q?0icqIDYwu7VWbay+kCOBRu1PMqOndlJg9XpCDlSG1y7vclRl7t1MJehz7UE9?=
 =?us-ascii?Q?1HzSGMr8x2ZNJQXJIoF345biihIE4WF3iJoOcvDrQPg6hfqxpcfhSqDkR7G4?=
 =?us-ascii?Q?rtT1GCJ7A/i0z726FT27lSfggynj2hGY/6NOlIEnMamfF8KpFo3czjLNFWmg?=
 =?us-ascii?Q?aS/m/1MiYOOGgg9tr4SKJs75AjpFgzxHQN+eP2bsz/f3zs9iWYnx0mDATTiN?=
 =?us-ascii?Q?wGLuiJtMnHxYvbRDBL+p00niek9qz9RVNjgLlRbt+wC634Dmt99pk0cknsga?=
 =?us-ascii?Q?VOHKdH/AbERvVlwMLtmMb5J0Cw0SPUgpbWFpnzdVQp/4gT10THegVA//L7X+?=
 =?us-ascii?Q?ODkn2aTO9t4LDpSQpKta8N27qCzRchtf8VjpJ/DZCPU1q7Q6f90iu30uJV2S?=
 =?us-ascii?Q?dHGmwXJvkRVHiVZTxR1QdgEilpayxT7QWPxFoZ2LSwK+nJjHDWM1DDfK7TlT?=
 =?us-ascii?Q?bnex2loz9HB39eIsTpRHHBIwS7NcxxLB2X/ey+Sjvme8BxaHgCHpfvbhrf+c?=
 =?us-ascii?Q?X89sMf4Oi7Na+HpnhXd4lWSL6MkpzA5MulB9wbjQhIaprpWL/j+iYtYyZvja?=
 =?us-ascii?Q?JIWgb/e8JcR2DuqA1NOq45G9tAQAN2vSLj3eYNRX10VhLbz2c70CU+CWr93c?=
 =?us-ascii?Q?lNcW7M2yaUt0BL7cmU4vKdyo+dOhlZF61JTYII69aA4rt8Nt6v/KmWLfnDjj?=
 =?us-ascii?Q?vNtBXj55sDvAEr1r+Xfe5j9vX13omIUQn/zFVqAgb0Y4YcBBkk6miLXQvz+b?=
 =?us-ascii?Q?yyQB0nQFNk7oe4RZHluGm/wX8sPExYGnvQ8cxsjEgnU+9s6sTEmlj/PkwHDt?=
 =?us-ascii?Q?GI9z20K5BlGemBM7ZUnKZ3aHz2RHzZHSmER/lGUSdINxMIiOmjR/MUdpCy4g?=
 =?us-ascii?Q?SegCb07iY9uukCIe1Dbo3Uz5pVTM/E0I9DgO2x6DUy0RDeJ7J7cJArg3iQSm?=
 =?us-ascii?Q?BX5Oh5azAY1hgonFvvwrbu7477eaw3+zJtPi9b1/0iipJfhSL9O1yjDml3UC?=
 =?us-ascii?Q?/YshmGCzrbmDoer2xyMpN38HJQ88eCS1neB+WqakYfMVF/l1ZFhP1sf667/B?=
 =?us-ascii?Q?JatmD5a1xU+KZo2oCSkpeseZjLznwJtU+IUI7dZlOQ34gqsbkgmnicbEtKxp?=
 =?us-ascii?Q?HhxIp3SNfs0dQ51CydojnAXzX+325QDp3HmgKPDH2GYCY85tObVB1a8TXBg6?=
 =?us-ascii?Q?vgHRU00EwdUafJLPx8Ui1Y7O72EvpDKs1tBd+qVyF4pELUXZo9XJ4v+1hkmw?=
 =?us-ascii?Q?GpMnId6OF0cpJ1YDpta4IvzQ3tJ6onAl/Q9mBza2S3BGhSXXimAg9qVxnEdb?=
 =?us-ascii?Q?Z/CDYWUlqtD4Q6VL4gMXkP3L2wKn120Ahd7zI7QGoVJpRl1sm/wToUi9DEer?=
 =?us-ascii?Q?pGcGK36d6dbKET+tMM3iJUZzKVShJzxQGImW8Gkx9uAnWh3pmVGvN2nLjDXK?=
 =?us-ascii?Q?mCc6gkXj9RA4zg1rsf1S5EgjHx94o7FwKBKPemBvGWZ46/CYWx6PGe9ZIsms?=
 =?us-ascii?Q?bfumvrjUO71UMRB2cq0q6gU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcfbc84-1d54-4e66-db88-08ddb264ed65
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:50.8928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ge/j46JN7Tvw1L3tj6QQtrEauPczoQumwj6Ti+1ksGPXvGEcs7anPWMMgGbsYbd+B/GQUhtl3awKAhcx7ghPk97A27x/cukWkglhu3Gbb4EVW8DV42vS9ohOCceHuvmR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19203

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 4c85281bed1732693f2f2e32cf60e0e30722d06e upstream.

Add support for enabling SD on SDHI0 on RZ/G3E SMARC SoM. It is enabled
by setting the macro SW_SD0_DEV_SEL to 1 in board DTS and setting the
switch SYS.1 to ON position on the SoM.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250206134047.67866-8-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  3 ++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 54 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index c063d47e2952..152a00aa354b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -7,6 +7,9 @@
=20
 /dts-v1/;
=20
+/* Switch selection settings */
+#define SW_SD0_DEV_SEL		0
+
 #include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index fcbabe2cb003..72b42a81bcf3 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -5,6 +5,15 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
=20
+/*
+ * Please set the switch position SYS.1 on the SoM and the corresponding m=
acro
+ * SW_SD0_DEV_SEL on the board DTS:
+ *
+ * SW_SD0_DEV_SEL:
+ *      0 - SD0 is connected to eMMC (default)
+ *      1 - SD0 is connected to uSD0 card
+ */
+
 / {
 	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
=20
@@ -61,6 +70,32 @@ sd0-rst {
 		};
 	};
=20
+	sdhi0_usd_pins: sd0-usd {
+		sd0-cd {
+			pinmux =3D <RZG3E_PORT_PINMUX(5, 0, 8)>;
+		};
+
+		sd0-ctrl {
+			pins =3D "SD0CLK", "SD0CMD";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-data {
+			pins =3D "SD0DAT0", "SD0DAT1", "SD0DAT2", "SD0DAT3";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-iovs {
+			pins =3D "SD0IOVS";
+			renesas,output-impedance =3D <3>;
+		};
+
+		sd0-pwen {
+			pins =3D "SD0PWEN";
+			renesas,output-impedance =3D <3>;
+		};
+	};
+
 	sdhi2_pins: sd2 {
 		sd2-cd {
 			pinmux =3D <RZG3E_PORT_PINMUX(K, 0, 1)>; /* SD2CD */
@@ -96,6 +131,24 @@ &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
=20
+#if (SW_SD0_DEV_SEL)
+&sdhi0 {
+	pinctrl-0 =3D <&sdhi0_usd_pins>;
+	pinctrl-1 =3D <&sdhi0_usd_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+
+	vmmc-supply =3D <&reg_3p3v>;
+	vqmmc-supply =3D <&sdhi0_vqmmc>;
+	bus-width =3D <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status =3D "okay";
+};
+
+&sdhi0_vqmmc {
+	status =3D "okay";
+};
+#else
 &sdhi0 {
 	pinctrl-0 =3D <&sdhi0_emmc_pins>;
 	pinctrl-1 =3D <&sdhi0_emmc_pins>;
@@ -109,6 +162,7 @@ &sdhi0 {
 	fixed-emmc-driver-type =3D <1>;
 	status =3D "okay";
 };
+#endif
=20
 &sdhi2 {
 	pinctrl-0 =3D <&sdhi2_pins>;
--=20
2.43.0


