Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1831.1793653910027159220
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YuMN8JEs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itqWWoOzI9m80EQyyDoMTwoZUEHaaI6LcnvTDOrtNTCpumjpoG50l78c9zoRTmaTmwA2ahq349AlXsK/LL1f1G2YsseMfRNNxVEIMglgshl5GKzi34Pe+tW+4wIN3aqFmrtP5LIdNZCVhmdv/p5TcwP1p7Stb1Bx9SnmzkFOm5K58esqiCJBxXDuGqfUS0tZ02v4Rqjg6/Ca70g88VdDYG2mp1/XK93uDKz+83JMAQ0qiFHpknP2wapurXdqGSha/uzDzBmOnaLTjoZu42THhQG1pO1aTZTD9J/d8FCOVqt3tLO8HOYhJcGmuS7kgW3VTfk1pZ+MbCq8p/usaSGK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls6JyZ1/JJzZYiMCmBQB1nJmXxqCqwXoHt8Z6YuAkeM=;
 b=y8rUYz4iH5V8c46935zZDcU/OdvzdhZxwNLDAjYwy7pzw5cDNO83YHd2fRaBP4fuoSSlMso3VytKTzhO1VJRcQOhkQHr9ZQ5nKxQAvXm/1LUuoCDXYFVARuM5s/izLYBmFwXrxPLXpgl2NyKFE+M/y0YnB/BvRKGjDOCOfNJ0d8MJRt4bYKJUp/8jHMlm2/xtyqHLkmmBRuptysRIIiwdtLA+UXyp32a/I0Va3wcWoHgb0wjINEu/FBAkZQsl8FqK+oDWOe7K/UAhgyVSbOH7hGQrd0uSM5oywv4Wr9TzlOasketDpF6uu2UfhA736C3enxbspVjfZCEtf7/MIvHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls6JyZ1/JJzZYiMCmBQB1nJmXxqCqwXoHt8Z6YuAkeM=;
 b=YuMN8JEsKCo03KA+xFm+kfALQyx0oFHzqDb5orI2BUitE9B1G+Xw/JsYd3ml0p5BXx1dRTwWaXOxjobtHcsRszRaRipart74vmsoa1DM8u5noHMxHwPo6WQPl+UHeNKFnBhTJGfDlBWFp608NmRZm2Pafe37NlC+yO+ZHNRdqDo=
Received: from TY4P301CA0080.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::8)
 by OS3PR01MB7175.jpnprd01.prod.outlook.com (2603:1096:604:14b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:44 +0000
Received: from TY1PEPF00046B4C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::18) by TY4P301CA0080.outlook.office365.com
 (2603:1096:405:36f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4C.mail.protection.outlook.com (10.167.253.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:44 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 20C5E3000230;
	Tue,  3 Nov 2026 06:11:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/8] memory: renesas-rpc-if: Consolidate command setup register programming
Date: Mon,  2 Nov 2026 21:11:29 +0000
Message-ID: <20261102211132.22646-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4C:EE_|OS3PR01MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 72255545-674a-48f5-04ae-08df3925e5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|11063799006|56012099006|261009223027099003|261009221227099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|261102123227099003|13003099007;
X-Microsoft-Antispam-Message-Info: JNOhjqBwV3jQbXJwsmay9vHa7VLwItQXi+apXG0QRJP0iGy4DdB6u96cdjjPQXiB9VNgIrCcRy6wCsknHooZuS9g3lrVyxp9z6Luwh3i4NqoM9n8653YwnaSst2jISpaK9RlDcBWVkjvsGqpocJrt5aAbelRudZiQCLst9qZgi666BrSDqJhxWEH3YAcxozk2e5Mcj/LMAbP5/hMA3H7pEjKs1qgUa9HMh7/PHmaFBQH84ZGJ/vgQddeMiqGFYH4NUauueP2fl3IMiorYRceH43UUwReDQgFULtHFAflGfsEvXPI5usDLQemzLFD9/pAdstMFqww4d5WkKDuD3Lec+jXXUrjxC6Ht54cOIL/MH8qnj1wTvsaEuTuq1j/MpDh6VH1mNj93CDI8OYz+76fK53dY/dc6E0+4f1HvVrGmZlccBLHq/NXwf7MDuhFBagL3NDzTwztcZfjlQe0uNPRBkclHE8sQoioadPd/+cXxLmYI/vrGArNotZt506U21wibNVR/nkCNtlgg2A+vZA9Fh7NoAAz3I+6otsrihRy79glBED6qSLQuIZL0I1ddyMIW8TKWulic0QlYdlQigeQ0tDjxfvB/RJi4WcQcQ2nCiWYqMIExkXAMfD9nRN0ekWDbffhbqJoBZvObRLXPWJ+pHY6sXKRtS3oDcc1mzFbbyg=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MbyXuENECUFOoiJw9hcEpSHBb0dmlz/g7FOSLkT1n/7uju8Imiv7241tldlCCDDZwqrnHyKGqZrhIx3YBZDnQjZJkM1sqFiPLeAbVhAIz4T56u/0gvMKBWLs6sVAX0Wohhd6fNzzu/37h2mEPtRRj+zGtj9SxIu6GBvHeYJX1/JjQO3IorG/Ik1hZctsvPtsYw/PrqnrPE4lW3v8fb52ftadtHkG7y3Cr9HRNEe8E/hkI67UkRsLp7efuc7auTYtGUhsN0XiCU2KqHt6x/Y/Tk9whSN19xrdxOo7r3hyZhbSrxZgube/o1XXITGNozeT9w/FczMMm4Ou+zytCt7iONEs9J3HY5ULEY0nqUAC/l+3AAt1AX5MvhPpEizfM1OmJ1yQbDM6dGm8vuju3RsLUbdWcGfMBQ55GjZVDxRxIpyyBRo9NDsKqS7DtuXaVgrI
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:44.4281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72255545-674a-48f5-04ae-08df3925e5f9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7175
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24625
Content-Type: text/plain; charset="utf-8"

commit 0c49783b0ed5c3d27efb2d0d91a3272db154458d upstream.

Simplify the command setup sequence in xspi_manual_xfer_impl() by
combining updates to XSPI_CDCTL0 and XSPI_CDTBUF0.

Clear the TRNUM and TRREQ fields in XSPI_CDCTL0 with a single
regmap_update_bits() call. Likewise, program the command, command size
and address size fields in XSPI_CDTBUF0 with a single regmap_write(),
eliminating the subsequent ADDSIZE update. The intermediate write of
zero to XSPI_CDABUF0 is also redundant, as the register is immediately
programmed with the transfer address.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260727103449.3188105-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 883893ff6500c..7ea91f7d519e0 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -636,18 +636,14 @@ static int xspi_manual_xfer_impl(struct rpcif_priv *x=
spi)
 	u32 pos =3D 0, max =3D 8;
 	int ret =3D 0;
=20
-	regmap_update_bits(xspi->regmap, XSPI_CDCTL0, XSPI_CDCTL0_TRNUM(0x3),
+	/* Clear transaction number and request */
+	regmap_update_bits(xspi->regmap, XSPI_CDCTL0,
+			   XSPI_CDCTL0_TRNUM(0x3) | XSPI_CDCTL0_TRREQ,
 			   XSPI_CDCTL0_TRNUM(0));
=20
-	regmap_update_bits(xspi->regmap, XSPI_CDCTL0, XSPI_CDCTL0_TRREQ, 0);
-
 	regmap_write(xspi->regmap, XSPI_CDTBUF0,
-		     XSPI_CDTBUF_CMDSIZE(0x1) | XSPI_CDTBUF_CMD_FIELD(xspi->command));
-
-	regmap_write(xspi->regmap, XSPI_CDABUF0, 0);
-
-	regmap_update_bits(xspi->regmap, XSPI_CDTBUF0, XSPI_CDTBUF_ADDSIZE(0x7),
-			   XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
+		     XSPI_CDTBUF_CMDSIZE(0x1) | XSPI_CDTBUF_CMD_FIELD(xspi->command) |
+		     XSPI_CDTBUF_ADDSIZE(xspi->addr_nbytes));
=20
 	regmap_write(xspi->regmap, XSPI_CDABUF0, xspi->smadr);
=20
--=20
2.43.0

