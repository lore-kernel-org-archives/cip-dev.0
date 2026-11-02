Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1824.1793653904826467875
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=CLqBhaoI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.71, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STh0zb4DowV75fmIUXDwttAlWZEfLBHUAJDlpnp6hNqOwJ23HtkkHlkgBWIbh4IUwARvtQ9lCudwU/7dFU65xOA0UDIBO8HV/FdYBotIfJNtZKdq3cc/eJml+lmrVPXKSONk0jG6rynyXThT9vn4b1+QZhdaJ0bTbewntFuMzpnj0N9VOUQRSWx0qAPA7A1PP2760LVR47z7ruVB9dp+lWgIkkf/d1ofp2dukOd5PCwA71dDs8NAW9rqw9scHAkog1RpqrHpY+k/Qi5HF2BM8+hAq/sMZgHt+ywp2NbOHxMTdtaJqUPwQpL0nOe1hy32Qykc/cdD2wnQ3hpKVdatPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klXfzvNitjhSuL55j8QdXyeCK4QgRY8w2Hiyh9pPs9A=;
 b=rkpQb7++7S07ytw7RioEGHABdkj2HLZSjy5xq14OpkESQRMUIHB8fFP8iC9XSa7LpW4nvD+85Da+THizMBQ51iRGRy328UQO44MULKdwkVUSx7oPaSJ+JoJ3gW+/iertUql7xHSLZ85Cx9pLCDCJQvggo/y3ISjFO8/ScyKdn0v8cunUzpcrEhZHyksHQbSIHfg1Eqol/U/9iFFNn561SuYxBIv+KXgKcPxKfFoTY2zIhCF11MbwMqB2qv8XDzLvE9ZhBzY5uRCRnaa8lRnogrAzmgTSABFFLnxx3ZsA3QQ+Wv98sdQPmWxuaOiz6btSIs7onTRAWqbNQrn4r79PzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klXfzvNitjhSuL55j8QdXyeCK4QgRY8w2Hiyh9pPs9A=;
 b=CLqBhaoItdcewBk/bongZ4IZfmQJezuQWiY7SvfP8LKd6WuM9Z0nR/W066tI8kiR8fYwufMSWDGxNuZhvKnP2LhWRHaj68XqXJ+ItXXPxChlbxOnVl7CshYyk0alYxSokRoeE9blXO+Bto9Xa1HJe3KFiY9MUdTl+sY47/STwzk=
Received: from OS7PR01CA0098.jpnprd01.prod.outlook.com (2603:1096:604:256::6)
 by TYYPR01MB6684.jpnprd01.prod.outlook.com (2603:1096:400:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:39 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:256:cafe::76) by OS7PR01CA0098.outlook.office365.com
 (2603:1096:604:256::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:39 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2B1123000230;
	Tue,  3 Nov 2026 06:11:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/8] memory: renesas-rpc-if: Move static bridge configurations out of dirmap hot paths
Date: Mon,  2 Nov 2026 21:11:26 +0000
Message-ID: <20261102211132.22646-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|TYYPR01MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: a4caa44a-7f57-4230-efb0-08df3925e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|56012099006|11063799006|261022075727099003|261026140227099003|261021121427099003|261022105027099003|261028144727099003|261009221227099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 9OQpx4/ssXDP5RAjRkniOkKtL5eivwST5oRGBWG/ZW2pba6mneaL18eVsYTncqUjeKyoSz6QujLOUVz4e6sFM6pFYFMQn2qgiUNY3neyZwatSfaLUR7KLJN6aR1uhGIt/aDVSUEPWr9qnZfNbEouwhfouWRQm5bbAFERx6W+lJXx6pRMsY3Sv2imtZdjb5Rhw/PZoq2AyToBjjtbi8bD7X446eYVak8lwuHGWRPkGT2AxjbMTJCGnJUChVk/YDsBti2qqoy3ElidYg00xFziJZmvpMolSnjw5k783tvLodYtGGsQqBjBQf8BzP4jNWmLBW7gSiFhFZDshnbdt0nHlSDWKfvAIBweOrVStBIvfaGdlzR45OaBtC+P0Fv6KZriTqnsJLJLE+S3/pR2dk1PCFRkUk1VyK2y3d/UiuK1Gtj7iIQUqAoU8EpyLQMEMovJ1RUIvXFhRLoJj9ASQXG9OV2Z0pBqeXVq5bdzQQrDVfdXbSyV3q1rko7fmOk+aocatzWT2vWgfi5gKqckJopMxmbGRh2P63Oz3BqdiuqfgGIev9JfZzj/iGhEeH9cSXdqgFvs4bSTtA2MFvRp/oCl2sD+HbKo2mG5kj8TWykdBOWLw8UDezhMAnRv8G9QiW2FzrwQiMnZiokRiVg7attcRg==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009221227099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F6prYJguymyxgJqEI8NbDY5ROQZrHeDESKOXtMxYHjalgKBqoLRhd/73+6G+8T51hDc/BgVzDwVw2TXbs0l/dmw66KlKKSZtB7GrtLvkF4jIavVvoCPXMorApkBvKPZQ6pYGnQbetSzf9qe8FJKALFopwem+cUJu5M8LbFdOkcJCJDH30EBVvPT5xRN1whE2gtzXEykGlhKkKEFZBXyIzJHtEzG8acgqh+J7467clRTNzVlS/txqy9HikcyT63xRIpZQTbtFqnud8l30jSjKB+MZPaElS9FYiSMcd4yx7e1Fa4oAqeBLfjvMm+eZO6nuJCb5iiZ3lgNzhtgW3g85XD4beG+l0mUkXO/zgW8uBt0kQq7X3p4AvPbrwdxiPlZf4kEBKNadHNtgWprkXI0j/iwNPXKGS1CLGlAnztaoma2SUC4J0tXcR8T11byYsPRq
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:39.5231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4caa44a-7f57-4230-efb0-08df3925e30e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6684
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24622
Content-Type: text/plain; charset="utf-8"

commit 12e44bfc2a0e97f139c37b33925cd49d1621fa91 upstream.

Move the initialization of the xSPI Bridge Control Register 0
(XSPI_BMCTL0) and Bridge Configuration Register (XSPI_BMCFG) from the
dirmap read and write implementations into the hardware initialization
function.

The bridge configuration values remain unchanged across sequential dirmap
transfers. Keeping these regmap_update_bits() calls inside the hot paths
(xspi_dirmap_read_impl and xspi_dirmap_write) introduces significant
software overhead and redundant register locking cycles.

Statically setting CS0ACC to 0x3 during xspi_hw_init_impl() permanently
enables the memory area for both read and write operations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260727103449.3188105-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 14d4ed227a65e..655ca50d1c6a1 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -312,6 +312,14 @@ static int xspi_hw_init_impl(struct rpcif_priv *xspi, =
bool hyperflash)
 	regmap_update_bits(xspi->regmap, XSPI_INTE, XSPI_INTE_CMDCMPE,
 			   XSPI_INTE_CMDCMPE);
=20
+	regmap_update_bits(xspi->regmap, XSPI_BMCTL0,
+			   XSPI_BMCTL0_CS0ACC(0xff), XSPI_BMCTL0_CS0ACC(0x03));
+
+	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
+			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
+			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
+			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
+			   XSPI_BMCFG_PREEN);
 	return 0;
 }
=20
@@ -869,15 +877,6 @@ static size_t xspi_dirmap_read_impl(struct rpcif_priv =
*xspi, u64 offs,
 			   XSPI_CMCFG1_RDCMD_UPPER_BYTE(xspi->command) |
 			   XSPI_CMCFG1_RDLATE(xspi->dummy));
=20
-	regmap_update_bits(xspi->regmap, XSPI_BMCTL0, XSPI_BMCTL0_CS0ACC(0xff),
-			   XSPI_BMCTL0_CS0ACC(0x01));
-
-	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
-			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
-			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
-			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
-			   XSPI_BMCFG_PREEN);
-
 	regmap_update_bits(xspi->regmap, XSPI_LIOCFGCS0, XSPI_LIOCFG_PRTMD(0x3ff)=
,
 			   XSPI_LIOCFG_PRTMD(xspi->proto));
=20
@@ -945,15 +944,6 @@ ssize_t xspi_dirmap_write(struct device *dev, u64 offs=
, size_t len, const void *
 			   XSPI_CMCFG2_WRCMD_UPPER(xspi->command) |
 			   XSPI_CMCFG2_WRLATE(xspi->dummy));
=20
-	regmap_update_bits(xspi->regmap, XSPI_BMCTL0,
-			   XSPI_BMCTL0_CS0ACC(0xff), XSPI_BMCTL0_CS0ACC(0x03));
-
-	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
-			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
-			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
-			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
-			   XSPI_BMCFG_PREEN);
-
 	regmap_update_bits(xspi->regmap, XSPI_LIOCFGCS0, XSPI_LIOCFG_PRTMD(0x3ff)=
,
 			   XSPI_LIOCFG_PRTMD(xspi->proto));
=20
--=20
2.43.0

