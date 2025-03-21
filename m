Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF3C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:29 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.50])
 by mx.groups.io with SMTP id smtpd.web10.18701.1742554884017389654
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LUpmhd1J;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTeyN11PetF7btEDY78ULKsKpwX6CVDDwBWUM6As4rZhVY/XQMCd1/8wz1MHr0gCuoVpN1OyT5nWnS+v/j+eXmCCUmintQm4hrqiJMTvscm6tve74D/ByshjRA7ufbjurq7w8PTQ+Tjhi05fs/K2BXI4mUlV7NvpQ6vxr66dUOa1ojDhx1p0Hbx4Tvq1zZ6OoH7iEnfIcz9h4IyMwT9IzngHz5UY/Upo+hZ0q295kfOBSSWbzZ4K3Yby6dlVw+nIDaKnxqcs4/UYSs1kowSZZfq+M+68y7KeOgRDLViJT3vlqQOboALWa9Hm7F2o7gIEvBck1rN6roXdDh/t0M2U6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1Im8ZwA4eSDsNZp+L0hj247sGqcy+4EZ4P8pO9x6Zk=;
 b=HXyVwOQlNhfGSGXfWTCkunaqZWilINrczM9nteCvtd13m74sEZaI0pkvH9F8lW8J3ECQSarJzkKtkGzSZqECavwCTNN0BoDqo08UZfOjs7b4Mbm2jnIADKDR6vbP4jUjKGid8g+5QOnIMJDkmBUhS7Fow7dyYgO/upZY1J1rE6D0VjlZPpl9j4yqhbnyMdR/vzTIuhpY3gd+NvhjG2vz8Vy8Ph8sFvcO41guiGfr5jImer0mxNK1p22d6IV8r2vAPhiTAcSJDiDJgBiqRvnG23DA4MajdOYIf5etV3djmX5JfxFXtQ9F5esuEexPHDJJpie/c3aw92sVA1K7xFY8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1Im8ZwA4eSDsNZp+L0hj247sGqcy+4EZ4P8pO9x6Zk=;
 b=LUpmhd1Jx7pFZfA+PwGtHQGqnJpDa8VE23nwjs6szAvxL2iQAkTmSTvFUol72cymQVHVyifA3eHU5hHFbsaeC0kjwgCMpRJDDNG/GMIAFZeaklXLPCH2as1TZ08LKk5Fdtw/OSemX1HxMS70zuVOXzdWfrIJxkWC60pOYz+nADM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/21] clk: renesas: rzv2h: Add support for RZ/G3E SoC
Date: Fri, 21 Mar 2025 12:00:14 +0100
Message-ID: <20250321110021.3612805-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df38e7d-271b-46e6-cb56-08dd6867b6fe
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gOdnFH8k9yBe7zNageCEJN66aO3SL4D46NZjT5FSG/lKDlUz/jn4cc0XAZqo?=
 =?us-ascii?Q?wNro3aiZYJyFBCCzVxfUG2H61c78S7qV0bGJZfdBHt1pRtSRQ4kaEC90XRZq?=
 =?us-ascii?Q?+pEI45KUgQOfGYAyQjmrpzI8hchYg6+7E+NIW8tedcNqYyzerYbbonjk3C7S?=
 =?us-ascii?Q?YmbgLjSTUOo0ChlG31II9zVlS1c+KkDZkSaLU2YxzilXvrLmBeraoMMoJmz+?=
 =?us-ascii?Q?8vdODySXdZXGS3tzPeyo5UcbwA04dWIXsrl5dlh0bb1X3UzScnHnD02WSNNt?=
 =?us-ascii?Q?KypAYwH10El8pvY975Y8AQc6J4PGqsAj0N/DIquO3l/G6Jm1uiHiyUmP1GD9?=
 =?us-ascii?Q?LaPhBSGvY0rzYpmFjgejwGnFFQ3pAgLHd6FKbx9gvvyQtgX13UPtPWXcJFVj?=
 =?us-ascii?Q?tAzB7JcWg8UWkrijSektFA2ZWuD7z4poAN7V9ZBkd+cPKF0W96c9VPsxj4Ss?=
 =?us-ascii?Q?SENhgJ6B2q8r6olqemj6yKKcompdHduEAA+DAMI8LqC+mowlkyoYTRTN+KW6?=
 =?us-ascii?Q?aMeZ4IFsgCLNkB39+lEj2ecEihSLfU4XFpbXNmcasLI2rTDWLHRm9bKTFr58?=
 =?us-ascii?Q?quSp6ULJe9pJ1xuFygPnxXQCjOjF5z1jBVGrxvTDut2xm4JFlUHZSAM3WuER?=
 =?us-ascii?Q?4Sf3dZY+yzIMCv8VcciqMPZvyOnJ86RYW/2NGitZfE/uh1FJXmUwzIF85sQP?=
 =?us-ascii?Q?QUOMraTyz0fR8Fe+t0GMYqWAEY4ISbc52znvhueffmnMu2GuN2oHpzz4Bd5G?=
 =?us-ascii?Q?IEuTrjxedVztCoRkkv3uYCfTgkxJnOormzOJrunx5iQMQqXIGic0veqRV/Yh?=
 =?us-ascii?Q?sOSejhfmwwwgq1nqDfZh1ImVsjfh2f/28iKL5nO8vnAzEQq7yifsVASkkFaA?=
 =?us-ascii?Q?m49X0JHW3Y4yMxyDbqfEJtSFkOsOzk6KGA/bTohdfxaTOK2SDLDQuBz13BMM?=
 =?us-ascii?Q?TLOm2zCNB6nzKoDdvvCbL6wUSNFLh7F5XVa1QmyMlTqcinodC4Iy+WmGLO4n?=
 =?us-ascii?Q?YGJwMW1USO6Cd60BrRmWA1NARP3Sg/HovxwfAjzV9HyzFhMjxDrhPA9IRpUD?=
 =?us-ascii?Q?eflrEVV1ZvIwNe49hjZDadZdCRP0xFt5grxbOakQtlmTp8MVIOGLAIquX7hx?=
 =?us-ascii?Q?UftTy2hNaLHpz29NT9Y21vbOvB2titIIUrzzMyRDBoU0pAk9GU9SKs5QtYLT?=
 =?us-ascii?Q?5oV2Q01JVUSQoyn/f086pj2SwtrQ+HAKg5t3yguvmGxKskBSYMYsDkT4f9JZ?=
 =?us-ascii?Q?qGq6m686DC4QMXmGW2FPlHPbCyhu9FMcHblQYWh+cnz1kzXAgnu0d8+VdTUH?=
 =?us-ascii?Q?XjaPe5T25UZ68OkW/vbBwVa/cKGbcbyFAgHKnI3h2KnYBiuZ5RTsi9Sy/dcv?=
 =?us-ascii?Q?zpHiI6IbD9q6KN27NFB0FId2l+x6l7V3rlPGE7IZ0Ebvn1lVWDM0TUtC6QUo?=
 =?us-ascii?Q?3Udj7lZRenuZi4Dty2iJEs2Ue7XPipUZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/SINhtPCda32NCyJA3L0IQdsLjg+62GLcsHeEQHOfltb6dTeSNT+MpPtZpCP?=
 =?us-ascii?Q?251va0/qLNaQ9XQCqYF2RvGB1Lw7IaA1U2enkOaErvM2jy7YfetKIzi7saRG?=
 =?us-ascii?Q?qBEFqmE5r19Lm/5G2KWhrcTTGmUoyg6XAlUStxhrFlS/hL5rWbjltyuLupA3?=
 =?us-ascii?Q?P4qyrmIHH+SuK6AwoLIScUAwePB/85/1mVTD8AV5rhW42anNnl2EsA0e0O7W?=
 =?us-ascii?Q?QKZQYrJhx3yj7MBkBx6C7skr5GIAd1bQNcLUmX65bAjysRrYABHRxVVsd4VK?=
 =?us-ascii?Q?qWPYPPrLKzckUFKG4MhpXZLdhMVPLOjVusv+Ktru4Y3+qIq+DzpTSA/d4pPz?=
 =?us-ascii?Q?jEkJ97d14SXMosnHBHh7v5fVwMepsy4mzvz6i+zprtkwPrNAkJSoO89yWjuj?=
 =?us-ascii?Q?0NeNfpIeBkGpimzmTOGv9J63Z2wWnWlePL2FHxP+8NZ4JSRDTGLrgCnX8ch5?=
 =?us-ascii?Q?2EUJoPp6ZM1Srmu6F2rbLl/dxZ7q3NdcW/oU16S61KvqVw3NKCBEztNFpAuE?=
 =?us-ascii?Q?EiigOEofBpQHnoiTrK4jc/5ar/Ab9LPxOYjmVQEYJMmCFUWVtA0/23OT/slL?=
 =?us-ascii?Q?lyHSIbOosZ2j0kqttezvO1wZYXs8nXdET9NNjJ9hGI+whFDzonFV8+cWzuyl?=
 =?us-ascii?Q?KP7oL/n03hvIq6387pcDrUuF2MnRNtQmTVgr7vPLDBK0y0VDJdMloo2hXc4f?=
 =?us-ascii?Q?z4PmLnAmrI2XY7vwZBrX9j+pDZ4D1SVpw4M7Rt2X/NIZ5zekAACGetrS5mMc?=
 =?us-ascii?Q?//cDrWgaSoom/wmyf3OZWgRo1vbOIEnzctPJMvsF1Oo3wyEeNxUJOPpKmUmI?=
 =?us-ascii?Q?efwokuRdn+aNWCvMWaZfYpZuOcMtFBQc6qMp5s68y+VQEwZuc+fHsIYzviAM?=
 =?us-ascii?Q?Isv86k2FuHuUn1hTKI4IR89zgqDTYEtHpFIVWwf7I8g6cxvxexER6ZJmfFja?=
 =?us-ascii?Q?HvmallODZYGaMiJQ6n0PqaSdf775OgdJJ7VfjRTbdIW0tNrWftCnHCzBKu3X?=
 =?us-ascii?Q?eHBXf918S6t+cQq21mJ21of1oHyoKZ6ntejY9igeBOXbQ3oMagAsrlW9rhuU?=
 =?us-ascii?Q?+OK6fPcnhyd8xzEJjwcCqGJEmPnBXnr9DZNfAuE4F1+OemIrB1ooFnPHI8tx?=
 =?us-ascii?Q?AhIEs/xXyhCDEXskXk2rdNCnFPWYZRQrNIrgLsx7NS9XnBMtFgAgHbvHKVNA?=
 =?us-ascii?Q?8jj8WGz/uklC2jh5Mvsxm5cOSVW6ugcNZNPhHu8WOWu+k26AZ+n7yxJTKj8C?=
 =?us-ascii?Q?M6dMMYxRpWT3tC/bLnQA0IMyT3SuIbLwrlpKVXO+h35L9meTHmX2VSOBsRaL?=
 =?us-ascii?Q?NxVMyqW0tRC1r/b1aoMXAMTkZ2O53CqMOLgIZgoYCU7DbRfQ43GP4UsEoohf?=
 =?us-ascii?Q?iDu5Q4Y9QiPdoxK6KveShMXMc5Atj4QWDQJzvgqdXIMeUwOPrI+DcP9U3RgX?=
 =?us-ascii?Q?Q9ntxrZj7q+aF+0FNTh1lkH+k+UiW7ipTjbGEtPHfy7/+lwXEZ0zmvPYDl6B?=
 =?us-ascii?Q?yUnW12Z1KcHyNxupu2URWIPdKtl3GD4OFjkmbAE+3YeOKelzEt+aVkkHQVST?=
 =?us-ascii?Q?/M/JGcsv0hAekZLDAiazE1ZoCRNK0HSyKLjKPlQWguLj0qeWVAsylSEAcrDP?=
 =?us-ascii?Q?eH4850gq2ouSpv7M7ynD/M0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df38e7d-271b-46e6-cb56-08dd6867b6fe
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:22.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37Xi2L7SS5TOJ1MpwVda8X7jHJe7YaPCrM8m83D8ru+PQjABEZPt/BfEK2Dh2WiLu6ticBMxI0DH8/LN2cMEZFuyRvJdLSD1NdtNUDQDorHKmbadJXe2l76cXrSJTQYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18321

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bb6a9aaf670735d6583c76073ec41190f5404dc5 upstream.

The clock structure for RZ/G3E is almost identical to RZ/V2H SoC with
more IP blocks compared to RZ/V2H. For eg: VSPI, LVDS, DPI and LCDC1
are present only on the RZ/G3E SoC.

Add minimal clock and reset entries required to boot the Renesas RZ/G3E
SMARC EVK and binds it with the RZ/V2H CPG core driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241213123550.289193-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   7 +-
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c | 102 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     |   6 ++
 drivers/clk/renesas/rzv2h-cpg.h     |   1 +
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/renesas/r9a09g047-cpg.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 688c088a68d9..e1950ef22baa 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -39,6 +39,7 @@ config CLK_RENESAS
 	select CLK_R9A07G054 if ARCH_R9A07G054
 	select CLK_R9A08G045 if ARCH_R9A08G045
 	select CLK_R9A09G011 if ARCH_R9A09G011
+	select CLK_R9A09G047 if ARCH_R9A09G047
 	select CLK_R9A09G057 if ARCH_R9A09G057
 	select CLK_SH73A0 if ARCH_SH73A0
=20
@@ -189,6 +190,10 @@ config CLK_R9A09G011
 	bool "RZ/V2M clock support" if COMPILE_TEST
 	select CLK_RZG2L
=20
+config CLK_R9A09G047
+       bool "RZ/G3E clock support" if COMPILE_TEST
+       select CLK_RZV2H
+
 config CLK_R9A09G057
        bool "RZ/V2H(P) clock support" if COMPILE_TEST
        select CLK_RZV2H
@@ -234,7 +239,7 @@ config CLK_RENESAS_VBATTB
 	select RESET_CONTROLLER
=20
 config CLK_RZV2H
-	bool "RZ/V2H(P) family clock support" if COMPILE_TEST
+	bool "RZ/{G3E,V2H(P)} family clock support" if COMPILE_TEST
 	select RESET_CONTROLLER
=20
 # Generic
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index e7ff58c0a480..a1fdc48c5c7d 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_CLK_R9A07G044)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A07G054)		+=3D r9a07g044-cpg.o
 obj-$(CONFIG_CLK_R9A08G045)		+=3D r9a08g045-cpg.o
 obj-$(CONFIG_CLK_R9A09G011)		+=3D r9a09g011-cpg.o
+obj-$(CONFIG_CLK_R9A09G047)		+=3D r9a09g047-cpg.o
 obj-$(CONFIG_CLK_R9A09G057)		+=3D r9a09g057-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+=3D clk-sh73a0.o
=20
diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
new file mode 100644
index 000000000000..1178335dbed3
--- /dev/null
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3E CPG driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+
+#include "rzv2h-cpg.h"
+
+enum clk_ids {
+	/* Core Clock Outputs exported to DT */
+	LAST_DT_CORE_CLK =3D R9A09G047_IOTOP_0_SHCLK,
+
+	/* External Input Clocks */
+	CLK_AUDIO_EXTAL,
+	CLK_RTXIN,
+	CLK_QEXTAL,
+
+	/* PLL Clocks */
+	CLK_PLLCM33,
+	CLK_PLLDTY,
+	CLK_PLLCA55,
+
+	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV16,
+	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV4,
+
+	/* Module Clocks */
+	MOD_CLK_BASE,
+};
+
+static const struct clk_div_table dtable_2_64[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{4, 64},
+	{0, 0},
+};
+
+static const struct cpg_core_clk r9a09g047_core_clks[] __initconst =3D {
+	/* External Clock Inputs */
+	DEF_INPUT("audio_extal", CLK_AUDIO_EXTAL),
+	DEF_INPUT("rtxin", CLK_RTXIN),
+	DEF_INPUT("qextal", CLK_QEXTAL),
+
+	/* PLL Clocks */
+	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+
+	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
+
+	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+
+	/* Core Clocks */
+	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("iotop_0_shclk", R9A09G047_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
+};
+
+static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
+						BUS_MSTOP(3, BIT(5))),
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
+						BUS_MSTOP(3, BIT(14))),
+};
+
+static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
+	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
+	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
+	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+};
+
+const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
+	/* Core Clocks */
+	.core_clks =3D r9a09g047_core_clks,
+	.num_core_clks =3D ARRAY_SIZE(r9a09g047_core_clks),
+	.last_dt_core_clk =3D LAST_DT_CORE_CLK,
+	.num_total_core_clks =3D MOD_CLK_BASE,
+
+	/* Module Clocks */
+	.mod_clks =3D r9a09g047_mod_clks,
+	.num_mod_clks =3D ARRAY_SIZE(r9a09g047_mod_clks),
+	.num_hw_mod_clks =3D 28 * 16,
+
+	/* Resets */
+	.resets =3D r9a09g047_resets,
+	.num_resets =3D ARRAY_SIZE(r9a09g047_resets),
+
+	.num_mstop_bits =3D 208,
+};
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 6f096abda33c..1612864732e4 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -972,6 +972,12 @@ static const struct of_device_id rzv2h_cpg_match[] =3D=
 {
 		.compatible =3D "renesas,r9a09g057-cpg",
 		.data =3D &r9a09g057_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G047
+	{
+		.compatible =3D "renesas,r9a09g047-cpg",
+		.data =3D &r9a09g047_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index dcd65e9c09da..fd8eb985c75b 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -218,6 +218,7 @@ struct rzv2h_cpg_info {
 	unsigned int num_mstop_bits;
 };
=20
+extern const struct rzv2h_cpg_info r9a09g047_cpg_info;
 extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
=20
 #endif	/* __RENESAS_RZV2H_CPG_H__ */
--=20
2.43.0


