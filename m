Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB551C44500
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:43 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.157788.1783362219283435075
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DnmFHpWn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgOkdU0fZNpvbMbi0vEoaAYI+WTgm1wQOWbPqGnDH9Kz2U0Z4rJ1ILG8KvQjw1gqm6J8hq5sg1tigngzdgsbU0SVg5DUGyFfJxuE+NqWP+s3FVtnfn6nffHm7ESCVcGMpBZEpeZTUPMivTx87Btlyq8aptXow1xw6zQWPQDr1iNBS54qT02T2UHhG4QBNzbP9Ov45tY1gSvoI/4h7n2WoUlHpqUPa0uFbOiS3hmwQAHBTW7kMC+sb3woZ7sfs1jXfu6iJhT11nrgwcHdCIt6mePSEt5kcH/ApKPC0xdHrNcsCdGPXwNYs+x4WJtUsfr1IJTYPp3199zjy4nkzc6aBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goFcOr1MmM4DJ59Kz2XOemXUTXbQ4WOD9bhiT0YEFAM=;
 b=lWf92YLdeWyPFHGoNWR+9fKg3JxvcBNVhd8pPFgRJDWJ6yL+mRksYjw1FPz+RDSmV2JbnevfdkCIGwQ6p5Un7lT5cwe1rmUm71MXMAmG55+90tFTOITtaX74Uge/pWlXlqtHt+gXqTw0v7fpU39IgthZMeUWoG+3GAMgYLZ1PXPh2ZNOYwlhWkKiPJSDOHeSHc76NY+AZVTeZMJioeeuj3r69DxSHrphOTO2v/ASRSp78TmclK3BZrMBntFDOg+Z7QbNtPJHDsTu6maJaOlHY9u2hgd9o/SG7hHHEacTfXCwalQuYLmWty4FDS6k7fKx9aGu/KaP13kEohuXHk/g2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goFcOr1MmM4DJ59Kz2XOemXUTXbQ4WOD9bhiT0YEFAM=;
 b=DnmFHpWnZQC/3T5iLhCnxnd6tq/m+QDq+86blMwDgIeqkSnAj3X8V09lf6Dgbxp7EdWyl6MrGvix5T/NspU4X0LFVuiAwVJJ+JTUp7IqEePomqKd45dLR+Z46gKoPqyRp7tsTQoyJlOk3KiSPeuuEpHPakyMmN3fa3fx9fNTizg=
Received: from OS7PR01CA0216.jpnprd01.prod.outlook.com (2603:1096:604:252::9)
 by TYRPR01MB13105.jpnprd01.prod.outlook.com (2603:1096:405:1ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 18:23:33 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:252:cafe::1d) by OS7PR01CA0216.outlook.office365.com
 (2603:1096:604:252::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:33 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C702A3000152;
	Tue,  7 Jul 2026 03:23:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/8] mtd: spi-nor: add support for Macronix Octal flash
Date: Mon,  6 Jul 2026 19:23:21 +0100
Message-ID: <20260706182328.5237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYRPR01MB13105:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0399b130-95a1-4ba4-d944-08dedb8baffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Ny8ZVczQAbZeRnwNM4Z2fzj7KGlh3SULOgirYO07vwIfLqCAco2XVLyKEahxwlYb87rR/s/Ozy+pUq7QN7Nc8enMNBhOAULufHPuO2pjGX/vEit0mmWC6XSoU0BNFSpUhbDQYADHZoXi9vU3UIRVgOMT8lnKrQCq97pnXD87mVmNnLDH40zBvOtXpGQCnLevSxScLkR+iCVvD/DyJN73rQR5PtXYOXOCpO+AzeWMcBcG/4hJfRyUMhNPfWC0G2zvGFYYZ6A6uf8WGF1QJSiqdU7JTbRMgH3MbaMIzbv8/DMMDk430zqqTr8TmDGGnnyxp1WJiWhKP8Za+rRZIvLfrZqW9JXK/j0ePYOC5TN0zCoFzITgVNSWiPJzkVfJb+2l21q5pTWAmztwEWbYwZEgHUfhu2u4SPvHCljeopLdVijDZb717XUdu9FVOyMmntJ40qUiVaVmPhVZ/ECRXyUhm4QMlIuHZeWreLMfWu7OREmmScr0Hl3Svu+1Uv+UAbQraJIJVPyWbBRkNKNLJ11bqaBuBKbd+U7J031VCysv0NHn5b3oWS34uCXdmaD/VxttBuMW82t8EbOXXvcQqBoF1xslqp3t5/qXhNqftjvGYYknfXbX4MdQVSyGQUANjF3TlBc6hPJjybY1IkeOaaULu3HHfUJjenQMdsmUzvy3xfEuhI/TMhPn8et4vuikPBMKFLxdVRrwfum4DAP7m+WtAQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	n1W16ysgWTVWf74u1bYio0JjIFif/ZZLGV8qFUiejbOP8WG1dYqhCBvgx+ePoqpYd3nd16wIF2zGVSbvc+2/lGo+0veDtA2aRDgMiVwUZjjDorKRZJj806XZTQCMyIeisp8UItvDxEqEXV6MwzBJ4p2LMdG77qaSDe1bzojj+awSWaD+UmJVQOh3X1CoY3wdXL8j/hMrpWvcpaxTcYejylm4UOEemH8guJd4ildxqodDjowMedO0qYkhxmyf0Pvfvfaiscw4xD0+YyJ43/u3TbLhV8gSMK77s49uXWSuKS5HSJqW6Lo9zPpzzecWHU6ktHlp7sOJ4vRW/DyBEQGx+dZJZr5p0taobDgQHueS5d17xXlCpC73201M/6uK9t+B8/S0Qa2cA4hPkLFuPfLkZaP7JSOwegKcX5dHEA/Lm4fkTS8ppcFjoHD4RZc/8VWb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:33.2197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0399b130-95a1-4ba4-d944-08dedb8baffe
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13105
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23463

From: AlvinZhou <alvinzhou@mxic.com.tw>

commit afe1ea1344bbd3a40be5a2547ff1b13899c5a7fa upstream.

Add manufacturer ID 0xc2 at the end of ID table to allow manufacturer
fixups to be applied for any Macronix flash. This spares us of adding
new flash entries for flashes that can be initialized solely based on
the SFDP data, but still need the manufacturer hooks to set parameters
that can't be discovered at SFDP parsing time.

The ID is added in order to set the octal DTR methods. SFDP defines a
"Command Sequences to Change to Octal DDR (8D-8D-8D) Mode" which can
enable the octal DTR mode. Until that is parsed and used, use the
local defined method.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
Link: https://lore.kernel.org/r/20240926141956.2386374-7-alvinzhou.tw@gmail=
.com
[ta: update commit message and comment in the code]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mtd/spi-nor/macronix.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.=
c
index ea6be95e75a5..3f33f793da15 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -182,7 +182,14 @@ static const struct flash_info macronix_nor_parts[] =
=3D {
 		.name =3D "mx25l3255e",
 		.size =3D SZ_4M,
 		.no_sfdp_flags =3D SECT_4K,
-	}
+	},
+	/*
+	 * This spares us of adding new flash entries for flashes that can be
+	 * initialized solely based on the SFDP data, but still need the
+	 * manufacturer hooks to set parameters that can't be discovered at SFDP
+	 * parsing time.
+	 */
+	{ .id =3D SNOR_ID(0xc2) }
 };
=20
 static void macronix_nor_default_init(struct spi_nor *nor)
--=20
2.43.0


