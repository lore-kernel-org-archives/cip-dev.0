Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793BACD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:23 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6966.1778751621012620683
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EAsLtoA4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT9L39xMwKfGxar9cR6/BFlOdXR+LW5HO9S54JKa6NMqdTrj6rqZ262IaopqbtKB+rEj1LDK22srt/0Q/thaiaaQG7jBvP4jq0LQXvGmW4ZxcQwDcruWwR7+X6QvcYUgYphtcI6VL5nQNnrvA1i2/RBKGn/s0pxRfeIJE6H6ET8UN+kxjQBV7yOhGDLvyww0SCqv9AIizpGttixxI4V1xamhd2wd6e49WwHXk4HV9IftVtVOfPDw3GZiBUMX6jo0kaK3ghGbqueX64ED+YInDQ7C3Lo9J2FkhsCrX/LTOmDjub4Kx6VqSXzEyAOseRmaGwdCs61PGEmfQW6AWH65Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4ffOBbqcybkOISVTsrJfP9SMoKWzaqZyIdwOMq+0RU=;
 b=RmHUgqWRf2WVKv6enQ9/KirkTZtJGhWXR1Y9CXj5IwNLqEQeCAZYMi6P78gffibejPL7o4TlmttGfC1V7R4RY+8u9ExQiKcPf4dbUKVlgItS71/ReiZ1aLE43IkjXVMn0KYw/5/QrkDAK6Bofpra42XZohjXvu3zE4y9CYIrT4t+nA73xa0q22F9TqZCqadatYoW9yqI+i3Bhte5LJn/RIsbwqaEXp7U86pzQaXiqQO4pfDTtJ8u82eCXDhb208gKy4ZA1hZSTjynWOd4bH/sg4gcOC5d+wzF+xLrxBWVnTRJQEy/nsOFFsP4OlMs4fr5XWSPobtPAAjzzryG3c4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4ffOBbqcybkOISVTsrJfP9SMoKWzaqZyIdwOMq+0RU=;
 b=EAsLtoA47x1DxWKzkZYKvWJtaeXY6gdgNmw37MzTmamB+1axZMt8vcHzfbg1BUxY0PfNdTjaiYctGlWDFais/vVIwmX6FZ7i57XPIs3zsNno2sH82pa5f2qLlKovmCjD1KMzfo5C2mDQ0c7mHIZSy87XDc5V49sZr7MZw4EV0YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYWPR01MB8821.jpnprd01.prod.outlook.com (2603:1096:400:16c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:18 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:18 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 05/17] PCI: rzg3s-host: Reorder reset assertion during suspend
Date: Thu, 14 May 2026 09:39:23 +0000
Message-ID: <20260514093935.2212718-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYWPR01MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 7536d7e3-09a9-4359-636f-08deb19ccf30
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: 
	beNvqHAmW9pHZAdh9MsZKiJUREiVyDem9mxaahOJmolMnqJjTmkcpSwcIJ7nKAEYR+QR+ExoAHt36CuFQxdlHHZsD7gOwVlHl1LimikqnJwHIr5NiInO0QFJgy371lSgkmCRQyxdNTsDiSpTs//+hSoke5ht9Cy7L9lBMUxA4ITGgR/ug6NC6IU4G1S3hlwul6zYIhQ9LpXdBD/HzH2pJT0NMLqoURTky2qxflqN9nhLJFK07yoFda+2pj2ijSxEYsImwqfJR3ghoy7Vt1xMr/6YDHGqlhp4wqzZnKWTNHxXT9Ji2fot6qV6rkjdd77+yMcM4wxcJs9yvefLjYghkt87dk1HHW9f+6NFw6UuhY09D2uVFqw18OQxKQ8YrzktJbUP/BYX8Y371XUbbNQ7YAl4SrPPcGRibULasnc4qJvq7Dr3bn7MBDfsYouldGWsxkYz74C08Z3gVYTRRPbgQ1Pbgaa4X4qlAUKfpiy0efOFexqoU/KAoHYSNhbDTZHoua5QXTt20LCPtDBHKkg/ZZveSS3GKt3jP12MW7RNwU7G/bWnfv0vXL49qNiHiM6RFFAhmrJVYCstatnH53hOUJRqyNPa2viodJlnBtWkRlJcQqD4qQbxon17oRBinhbZRufw1eOsZV57IWS0FRp+5GJvX8zMBYZRIhXYHuZg45mchPXi8+WMa1EIec/lvT2kph5sx6c9nz/ONQWaGaVzFg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5z3HcVcFavTeA4NB3ThUxOrfNvQglQ75iNC85Z4iHalwZG8EMyJtHUZaGkav?=
 =?us-ascii?Q?TT3sTSCzCKh7JNMijujR9I6A60fV99kuYMRUONiF1NJlpt7JUyAsKwJQKXDC?=
 =?us-ascii?Q?tGXO1Lk1d2KbfJUtCmV9qCK38KGwBIyFoFyIidsr08BT7bile26T4EySVqZK?=
 =?us-ascii?Q?SAK+aZhUsUHKfpbYUubRkiBH7aXKxlHiSs/sFkZgYssIG9YWzlmFY5nSF9fG?=
 =?us-ascii?Q?+sSdcDq7Jo9oWdEEpUnbhgX1B4e0gfQvv2tinoYDwzZC7Uggk4faYfox2IgE?=
 =?us-ascii?Q?YchpKRMOI8Vr3fqJasOQs22PltyGxLS3jmGgaIUlp+V1OLt6GSdN2RbRZlc0?=
 =?us-ascii?Q?z7CfmL3/bXhEgYATRT9/Kf8wYVn5CFNWTuRJOuwZJAZb30g7XxhoKKWdPSif?=
 =?us-ascii?Q?wtIb56iFTQ2KQtiaM4yT56lk0OWJcz/jRgcQdOUeDzuvZszV2JsdgP4hbptO?=
 =?us-ascii?Q?YB0SRF8sXGjwwbUIqVTTqeS4sa3N5fs1K9xosVHeKEtIgPLUhh/Z1uMZH2el?=
 =?us-ascii?Q?xMpscyjoSCMN+yXYo6b3/7nQH8SQrL5voQ3ix8WvQRMnVBMqsSdLzf+Phcsi?=
 =?us-ascii?Q?8udjt97JKHQYMDpTvc+TT6flFdIrqwl59/z9Ic7lLVMT5qD5EYaYIhPoi8lM?=
 =?us-ascii?Q?PDkgvMXwkcBVwr1Z6sjxj1n7H7WCaJyUERlejJEGKLGLJnIHgctnqhS90+ig?=
 =?us-ascii?Q?DSgyjI/432ubiIq1wYe8qT0NNe01Xn9g+tt8/rNg9+hsSWu7FQMblAxL+7DD?=
 =?us-ascii?Q?AW3fmV1y+4/BfWZF+kYpj+vxapFXA9M/dnTBwL7IbL0t6dFT2V9BDBNNjPZP?=
 =?us-ascii?Q?wAD+0w9slOyMxSFkZR+22YyVAt29STPQPtJ/ceq0Acmkjbs6vwynqHfZhHLR?=
 =?us-ascii?Q?vvytJiIuHvpCfG0xDyqQ3nS6gpeCgkNsA7mFlYig14PfzP9xi39vgkYkhTii?=
 =?us-ascii?Q?+bd3iuuYPFg14zG9IQpmK6lVL7YUK1ZJ+rBLok16HfgWpiu8Xkq5V5s6b2Qr?=
 =?us-ascii?Q?gfPTYBJJKul7Nmbx7W8/NOhQ8BG5Ic2nlM3CA7zjnzS5rRhC2r9NM79/40iJ?=
 =?us-ascii?Q?1j79k/O9yyVQDyb6BYQkyzhBlNbw1HhnMWVXKth/Y1ut5UCAjiN+m+kD+Vgw?=
 =?us-ascii?Q?l+YD1hRR4oNt/TNSsKnGVQErumOaJS/pWXLZB3p5mwq/FQwXvfHCM22NshKj?=
 =?us-ascii?Q?0I4h6xnskYSR0xCehMn/FKKujwl50RKhLl27QFFkie8Tu7gK3dc60OXhmqRw?=
 =?us-ascii?Q?j15bXlU5jIvGMIAaohnl8o5QeGncOQ0o1IB6zNBCOTBm9m+5FGHrkpvBN+g/?=
 =?us-ascii?Q?4IH8rvPDQfHAjnNdT9Gm5YbV6w7uyMznnF4UrbrF5G9vwWAx8eG92Fk7UZu3?=
 =?us-ascii?Q?pVU0o068iiZbBw+FxFIKhczLWYOMugrkUiUI84Qr11joLGjbWZeuLK/v8wDZ?=
 =?us-ascii?Q?sdBSlKg9BD94ggtvk9oTy3eo6S7slRL6yQLY6cuUYTLcIuutZMKRxSC2ttQM?=
 =?us-ascii?Q?mq9AQ9m1plHUN//BY94E7CqiefaZd2OQqsy5v3zNHdAOk0xDvho+XK3ZED5k?=
 =?us-ascii?Q?rFYwi5qLuRTBs1siTVcRGo/tvvu8EIf72maGc9/DIAPBMfJ1t0WKAKvLkJE9?=
 =?us-ascii?Q?4GxdkEF/oYN+csp+S5ClHrOjD0tDeFXzR+HpIQJItsV1rZOI7b/S5xLlTWmp?=
 =?us-ascii?Q?V8hf1MUZE2Qr84D9EOcPshUBzmw02mOeNMAwsKbroDmNwx8Q1Ll4gv2HjiOv?=
 =?us-ascii?Q?dRTJivDFn2Fg8Ui+mn5vyMLXx2lzjbU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7536d7e3-09a9-4359-636f-08deb19ccf30
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:18.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW/tboJNUntfaNtNEcJ+znIs2zNR2SWjBnLrpWMkRyBdaqEc12oJZK6fOdU4dvq3Sj570fv7jJWDa+8NACcXNo9X0Y/7UUMuSGl0AtsLOvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8821
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22939

[ Upstream commit 34735f63748daa2ea27544259c3042b4948376bf ]

Reorder the reset assertion sequence during suspend from
power_resets -> cfg_resets to cfg_resets -> power_resets.
This change ensures the suspend sequence follows the reverse order
of the probe/init sequence, where power_resets are deasserted first
followed by cfg_resets.

Additionally, this ordering is required for RZ/G3E support where
cfg resets are controlled through PCIe AXI registers (offset 0x310h).
According to the RZ/G3E hardware manual (Rev.1.15, section 6.6.6.1.1
"Changing the Initial Values of the Registers"), AXI register access
requires ARESETn to be de-asserted and the clock to be supplied.
Since ARESETn is part of power_resets, cfg_resets must be asserted
before power_resets, otherwise the AXI registers become inaccessible.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-3-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 5d524af316e4..1afccfb6d3ee 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1646,31 +1646,31 @@ static int rzg3s_pcie_suspend_noirq(struct device *=
dev)
=20
 	clk_disable_unprepare(port->refclk);
=20
-	ret =3D reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
+	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
+					host->cfg_resets);
 	if (ret)
 		goto refclk_restore;
=20
-	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	ret =3D reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
 	if (ret)
-		goto power_resets_restore;
+		goto cfg_resets_restore;
=20
 	ret =3D regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
 				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
 				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
 	if (ret)
-		goto cfg_resets_restore;
+		goto power_resets_restore;
=20
 	return 0;
=20
 	/* Restore the previous state if any error happens */
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
+cfg_resets_restore:
+	reset_control_bulk_deassert(data->num_cfg_resets,
+				    host->cfg_resets);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
--=20
2.25.1


