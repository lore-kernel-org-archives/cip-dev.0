Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D55CD6E45
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24338.1779898500679920096
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=e+bhiYpt;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.20, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqaEjEtUZq74GE0Ry1ouySyYX88mY3MQM6LLru3J+LqrhOzX35fO1f3CNTKiSAxJXKYKSGvxC8+pDlRkXY1dQkL5uvXli20Pcu3N2kjVNIJMP9nNpScJ4v9AGboOVfHQKp/Ecp1FmF9faqMqJb0GbEcEoC1egJDql13OZ/9ML3WsKF9oriKi5Wb+53PKhOt4blTUCmLND+mjlpRgxBB0ittjTo8137boXsqsj4FRVy210VIot16f4aHHlHOYQa6rx73vfIh/3PxrUYZDE1dUZqpKVjc6lu9OH0nPoGVe8obVapMVViRV1WJnuqeKJqiXRblO0Nenh2qg3uCJaYxPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb0I9BRWWi+ZSq2RbZoY5OhrRmh+bIR47KYyIdVEFbI=;
 b=Os+E6tEcjgUYnUWax3I2Lxp0h/AicwARHjfLQ+OU+zChjrcs1lHMJESfNt4qbC5r1Jk/Zzxje7Fyt04z1Zqdjae1ZUi9dheDe7TkrYMAnj/B6miREfGKihFHnLaBqlNRbGWz91hZdhobyZ3J4yB18S8Of2dY+ukEUrrzXhOrICZMNdynqqpfMjHyFBktyP6LCc5z/IDQ1sj7+K8O4WRw2idNo6LOKOJeHcf9ySPVTDj0AJYF4aQzap1vh7ABCwBgIlxtGTYhuw5muTB4389QHdCI5Ayshw473Tfdc9S3tsERyR3PG9uDBrjH6DfhvCyThmfVN4iv3BcIQaDo1XuSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb0I9BRWWi+ZSq2RbZoY5OhrRmh+bIR47KYyIdVEFbI=;
 b=e+bhiYptkAhgrLV4CQvuWWkJMnPwJ4wYVnRVPR33EDCIZve2pTu9C47nhTYqwRPvUIBn3F6UHzD9q7WHEYdFEyupSGApPS77P/plSAOmgDs12WUD/+RQPM606h4kJ1x1TvL/fFwaIVYQWXj4VTJd0vG5W2m0d+HaXpVZOfjXX4A=
Received: from OS0P286CA0060.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9f::11)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 16:14:55 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9f:cafe::5d) by OS0P286CA0060.outlook.office365.com
 (2603:1096:604:9f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:55 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 372C73010416;
	Thu, 28 May 2026 01:14:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/9] i2c: riic: Use BIT macro consistently
Date: Wed, 27 May 2026 17:14:38 +0100
Message-ID: <20260527161446.48789-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY3PR01MB9889:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 097b6188-c5da-43c8-cfd5-08debc0b1763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	8h+whLyc/l8TQgsG61DuVVmU1zEqnlE8FyUO+kGd5sJRgj1NvF3rVgyLbDfQYyooi0W8sbkMiRx+M3/8Kk4wAQH84jhAIcvfZ2wszT8QpFgdQWtrJ7hCxQfEC5tUGYtbHHPGZLC99Ej5Xu2t2f3jBFvsFh8OKWMabDM/PA0/uZApT7u05+szxRCjI8TZFXNU3CiQkr2h6IPGRSRHhUrW1uhpsYlWRzHyD3P1PvlJ0uTTLZbEDR6W7GaAicJdckfLbjgbYoQX2DsnBLadDkNHme842NazlMmc163Y+5XicdeNU0sXUBZVxBuPzK7HmT2g/HGPzyqkj1a0KKGEj0Cx5AyXEPP3WJ+VOhdz5rI83hejsrPQ71X8FkeG8O3Nm/Qg71BnQpl0m2rftEQIWIJ2qRk9clrPY0vfX/U1C32pcn08qvuHO9IFaNvsjSJdWeDHBHkpV0CwrOEsAPEZMY61gHgf2A4Sd+Vs069UP2w5kiSSMmOKR37HOU5MN8uUR8nkoNhOLQR/MW6l3ELwIlnZcY9fiGcwQfXubmETuucQ1SZ/NUTCQQkrbfGu3UNLFFjDMbPJ59iZ2EsuyLpFSDT9ZnuIyNelvWds4JxpWi35KVNHfhY0v48RV4FDxxQS2zRXErM9koTnMVjd2OJsoK5nQU2myGkQJSwvvtgLCWM+DKHjDzHv251bU64qRMt7e2JUGdQUncyzbicbrKsLi3Ip5Aqax58ZWyoex/+NMgzx6yo=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	TQgxdV6D/+8mgslt/+7PoDsOXCh2VPFqQhIsQmzLVJJygMfQW2VRG5P0CGgsJn8oU8UV996R+42w7J3haqDD7NmK474iwIdVU5G6jMI8X0lVhvXhw+UcIZZowV/Ad03wrZWTtAmnoYMwqKsxmK91QtcZEOx8WTdb9h+0rtMzIt61r5HuN0YaotcZy3X5oxE9HydI6/HeZ7Iddsc5RGFKnN3uKsHyvtAaIc9+WW6Z3tv8pxWb5/H275m+ZQGrkU6KEx78C1TCV+fkMiYhlz7L8TmICAi1s2G7mZez8b/PP73VnG2XTHJSdebKcIbrcJCt/FQQUTDhKXGZmfralmfxlLZdJA0ycSPW87eTquwrowWQx8+SNiT8wdUlWerTxyPKWjYbdjE157Ky70Iqrg9sDDHWNea4ew3xzrWZTA6IUKc3GlvVAElBhb98JuHhZkYx
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:55.5630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097b6188-c5da-43c8-cfd5-08debc0b1763
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23019

commit 0094d6b70d6b4eb5084e3b7dd99ebfc94d3ca58d upstream.

Easier to read and ensures proper types.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 37 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 521589cb5264f..e3730b8730170 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -34,6 +34,7 @@
  * Also check the comments in the interrupt routines for some gory details=
.
  */
=20
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -47,32 +48,32 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
=20
-#define ICCR1_ICE	0x80
-#define ICCR1_IICRST	0x40
-#define ICCR1_SOWP	0x10
+#define ICCR1_ICE	BIT(7)
+#define ICCR1_IICRST	BIT(6)
+#define ICCR1_SOWP	BIT(4)
=20
-#define ICCR2_BBSY	0x80
-#define ICCR2_SP	0x08
-#define ICCR2_RS	0x04
-#define ICCR2_ST	0x02
+#define ICCR2_BBSY	BIT(7)
+#define ICCR2_SP	BIT(3)
+#define ICCR2_RS	BIT(2)
+#define ICCR2_ST	BIT(1)
=20
 #define ICMR1_CKS_MASK	0x70
-#define ICMR1_BCWP	0x08
+#define ICMR1_BCWP	BIT(3)
 #define ICMR1_CKS(_x)	((((_x) << 4) & ICMR1_CKS_MASK) | ICMR1_BCWP)
=20
-#define ICMR3_RDRFS	0x20
-#define ICMR3_ACKWP	0x10
-#define ICMR3_ACKBT	0x08
+#define ICMR3_RDRFS	BIT(5)
+#define ICMR3_ACKWP	BIT(4)
+#define ICMR3_ACKBT	BIT(3)
=20
-#define ICFER_FMPE	0x80
+#define ICFER_FMPE	BIT(7)
=20
-#define ICIER_TIE	0x80
-#define ICIER_TEIE	0x40
-#define ICIER_RIE	0x20
-#define ICIER_NAKIE	0x10
-#define ICIER_SPIE	0x08
+#define ICIER_TIE	BIT(7)
+#define ICIER_TEIE	BIT(6)
+#define ICIER_RIE	BIT(5)
+#define ICIER_NAKIE	BIT(4)
+#define ICIER_SPIE	BIT(3)
=20
-#define ICSR2_NACKF	0x10
+#define ICSR2_NACKF	BIT(4)
=20
 #define ICBR_RESERVED	0xe0 /* Should be 1 on writes */
=20
--=20
2.43.0


