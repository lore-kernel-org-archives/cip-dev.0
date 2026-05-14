Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1733CD4F3E
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:43 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6976.1778751640816255723
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nYgfkOVr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.50, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+Tlg9Uy+wN20SnEtmsNOW1VxiBE/maqodlTObMqVBfSVelz/3hpxBKNB73Z/NInTMDecxbBA57767IaGtO1YGveOuQCjKweFjick1AB5CwnPWtO0YxPs3aNVjk+y9wjcvOpC953QRn3/Thw/4TNQ1o+g8k7eppMbOCn2GKKZyu27gYi6KGgVT68seKzjjJ5armYOdoJHjwzd2mF0yZ6bNnevfZLsiPBp5xQWbxZ5xw3hMvhLvHBGhcVjMsPbuWP33LLQ0NVtI6sfmq6WcXvIGNJSW0lThN2FrIMxo7EmVAf2UDjzp2/QS904yV5ZGoCLpFxwhWOWC5DPH74IAo3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7mihzS7cohSGxbOB57kaxL6xDceyukcSZZGy2txNTk=;
 b=PF2VKfUZqw2XLijK2H3D9e6U/vCeCts5a8+miuJcGf/STjLGfBYOVYDgvXpVtw9csDR9Qr/zrpDSCxyd3B6OlLN8YiZcdh3q6Tp5OlAi4s2/H+5MvbVM5wz8/HAdBE3HcaIt9pjU7pjLHqyXvHx5pe1TZ5Ns+MbI8dWCr05RtQoLtdhnVpIocXHzHdVlDAWM6jfHXkhLVo7zEBlozs0wYUfu7qEnK10JOYL4EoLqBvnoqqFCzcV7NSom5Dc3vJlQ3uZv/ozFxranPFtX8aPEV6d3k6MQafeIXwNMucYf2+bLuOBfrG2RIgtCEvzuAcAZCPsHI1kBChyUHdDILa+zEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7mihzS7cohSGxbOB57kaxL6xDceyukcSZZGy2txNTk=;
 b=nYgfkOVrY4sfOgux/qhtWiReA1eizvT9Yt5vYI1jpjRFy4v1iNjfkhFjqdWJ4bGsPRo6xn9sLPP9TfEjaypoc0i8bqN4nt+wV0yGh/jOWRWPtxoI/qCRhb/TcB6DufpLBvaiOtwarp19Ynrmk5ZpYzY7pHfXYmYqbqgT8QeFUWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:36 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:36 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 11/17] PCI: rzg3s-host: Add SoC-specific configuration and initialization callbacks
Date: Thu, 14 May 2026 09:39:29 +0000
Message-ID: <20260514093935.2212718-12-john.madieu.xa@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8e49b7-decb-44db-d286-08deb19cd9ea
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xKjmAPJWyIpfK3UFS+AfSjpjvB2ww/SgNbX9H83tYQTEvEAu9DxXdPFIN6WjW1IqV58Oqbb5SJ7QVcKLSlzrMBcG7c6T7C4Glt64f6pFQUt2EDjuawJ+7JwL1dcEDPadxgjDu0gEAPZIx/7+i/jODBVqEWBnuk0PhoEjKqPZ8neH627viIwgjKUL5HF2beR4hVygxN62O5ssnFQe+ySKRGDOjZMULcZtk8JMYkODWZyvyZZOcnPtMnsOH1g8UxP8GXHg1vr5A9yZ/wBYpqIqjTzle6E7C6taj5Yo10XC46tZn4SgGe+5u/r92ySgjhx9N0FPAifzIRzHNSQghuYAU3Z+3lteAXfUCihm3vACIv1Xp+dEAPcFTigkNZKoJxfb0Mm2k8mp1+0t9wc/xtXYhuGE4Be9Fh9ykLV8xlJhKQuu/yI9xshREEqc3JyGtdifxz9VyVJH2jeS7bBfis8AmygT/OyAOCuwzZdtgjzns2oJxuxb7cmgu3yHFeoIVswPzxVdHVa68wYoWDE7dkLID/sVeofoJkBpe3lZZs7UMNkZWtQmKOnAfErLwJzt+M6Gg4/IQooK/nIj2mEO75ZDfOkS4Oc4AWP1yjDdGiMUFu7YRvy7f5myFTTn5eVvqUim5l7H/1H6jXllOxm/+FdUTS06ICb4bCvSNC4db9/uN+ZMfj7G00gy8uB4xztkl+yP4QvYJ0yAt3ZvArP4/FIHsg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+eldrrF4TzPl7exFwdSnMXdlMDAo7JpGVjUuOzY+WTAnNcdOvZbQNTynvW9R?=
 =?us-ascii?Q?Rb4eSbeJg4VntUgMFIVhWWwp8qJxsVpec1asZW/mVAGCShRTr6MZXHvPfqdV?=
 =?us-ascii?Q?t8pO7PhqyEszatUflHxnCCegB9VUED5jOnn92J4riMGQnfZvZG+Iyclqs6VI?=
 =?us-ascii?Q?7GblnXxeFx+Eck3tUai2tMfpR5t1OosqsaPq69G2eqY0O3vnsH9p26pwQ8R3?=
 =?us-ascii?Q?IgAt3jBvojsxwi2RMIfuqmi+nS+0vU1syPbCL1hrVsGQ3wPR2FxOLmsZK5ke?=
 =?us-ascii?Q?GfnkBwRSGpXi659w2z6CO6jRMEImjiigQNq0/hIx76npF5eUJfqgtGC/raKX?=
 =?us-ascii?Q?UUprH3bQ03B7hYuoLNUQTIxJdh35JaDZVYVfG6JzLEvECp72IMMYgb7Y9yoN?=
 =?us-ascii?Q?CYNJzyNVf+kfFGRZzgzsRenMYserH1zvsYulsoTqADYPMv2RkIUAMkuREHrm?=
 =?us-ascii?Q?81H/6y/khlRDMiFrGXAEW08St/SXizEKyiJsonmPIZlP+2tMB9cjx2xB3xWk?=
 =?us-ascii?Q?Xg72etzpk3xVSn9Mc1h2wMJRtFS/sZyt7Y+eERrsYI1HNjkkDgC6LYKRiWHj?=
 =?us-ascii?Q?E/9+rHB6PCN86hzQXHa2sPLciogLiyK669X6oUgQ+imHXtgK8mUi3MSo9iE5?=
 =?us-ascii?Q?skRwg/5OiMcGSxW92JWxtnTI3pjP3936gzne7JbfqMgcpGi81hX2ipHm2SPT?=
 =?us-ascii?Q?A/yyYu9h5pj8D7tCj+3pNV16rPdK3oZGedzPRTrcwTggf8MHj6pfhw0xJbhS?=
 =?us-ascii?Q?WgmwXttNXQxDhUNp18Ny3tkGNTLftobUNiN6qjUASzev3ehCNt8U9tOpyo4R?=
 =?us-ascii?Q?/xKSfKe1p8DLv1GU5CBU5SKUj3nliP8ieQLvCsFXUs0uj4stwSStfjGVCtx1?=
 =?us-ascii?Q?6SnPOwvC5fbSfCD0xsxpjVHwyJe4y6mbE148tQH3sX+tsIsi/uTftWiJ3bHH?=
 =?us-ascii?Q?p0QQtyeUyMtqIpuJzuaKkVMArs3rGbfehfeaqN9ATmCcgYRtS+BZwEcpPL/H?=
 =?us-ascii?Q?7GsHeQa79GlE5MoWgv32KB27yBv6E2qStIPfyGNI0NcpwWVati/C5WKFStzR?=
 =?us-ascii?Q?DlZ9+LBmHSNuMl7X0YY1+3sh3j750pflvKT9p7ZRLB0WhSe3bQW88RRfQHO6?=
 =?us-ascii?Q?NHuw+DHVQLzi2bYvkNvvGKZBMLCyUKh6dE0UbgGylebYADFI0DV5a2m7EA/Z?=
 =?us-ascii?Q?ggpClacme4ILZdlGMg36FEEjOeTjSH6z0oNhBcqPV2gk309ms68z4oF3LRYy?=
 =?us-ascii?Q?l3V/2JtiOteGD7ZDy/uRvoa57rdrZCqv5Mkzu+IDFoBKTq9RhCy0WQNxiyx1?=
 =?us-ascii?Q?OzNjmQcFp5B91UvfRahU5KBAlhDzkpCTk7A1iguUv61Ti7/HCBW1/lpxHEGG?=
 =?us-ascii?Q?I4ZLSjEIavttj2Ovvb/cDVDrKEY0BApdKlLiiw4pzhvK7oSr4/LzrgcW99I8?=
 =?us-ascii?Q?HefSY93FVJ9/h1koOuvsbyDxuDN84QdbJekoAA3BsH8VtBq+hF/2j91i1AnI?=
 =?us-ascii?Q?7TKblMzzSSYwe1dzD6kmtPd5XorURQpr9UwIUxKZojdzhDBmXxdWSWYpijmQ?=
 =?us-ascii?Q?sdOChghYdqM0RdKTSA/zargdVNMTZkFG2e7jx3WT156Th88nRF7HXEbNU3G0?=
 =?us-ascii?Q?hi5fSXl76i/Dd11KZlHbI5xGRn2v4lZ47xJtB5TWRLZK+Uq5sl4PSvLKh3qF?=
 =?us-ascii?Q?UokhM/NnRnBADxKejBUDjRuAGGpgh/fH0pscs8DmKJA7HSzoCTHGXiJhB32Y?=
 =?us-ascii?Q?KfGSufOAQlOeFhj4+pGKTbGgeiOtN7k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8e49b7-decb-44db-d286-08deb19cd9ea
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:36.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5e2sNc6SMqSH7s+6tEpEVMu0/syoYDkwv1WZTfm1g8zS7vnDW8Q0VlO9BTQSOy6aQt9K3xDuLhhf6CBa6JrAKwzwliicO4Orzch+G90Zic8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22945

[ Upstream commit 5f2c4de717786150f8d6cdbdbffb986cd3c59edb ]

Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
reset framework with dedicated reset lines, other SoC variants like RZ/G3E
control configuration resets through PCIe AXI registers.

As Linux reset bulk API gracefully handles optional NULL reset lines
(num_cfg_resets =3D 0 for RZ/G3E), the driver continues to use the standard
reset framework when reset lines are available, while custom callbacks
are only invoked when provided.

This provides a balanced pattern where:
- RZ/G3S: Uses callbacks that fall back to the reset framework
- RZ/G3E: Sets num_cfg_resets=3D0, provides
  cfg_pre_init/cfg_post_init/cfg_deinit

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-10-john.madieu.xa@bp.re=
nesas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 61 +++++++++++++++++-------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index 8620d8d31137..1de91ac54069 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -232,6 +232,9 @@ struct rzg3s_pcie_host;
 /**
  * struct rzg3s_pcie_soc_data - SoC specific data
  * @init_phy: PHY initialization function
+ * @config_pre_init: Optional callback for SoC-specific pre-configuration
+ * @config_post_init: Callback for SoC-specific post-configuration
+ * @config_deinit: Callback for SoC-specific de-initialization
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -242,6 +245,9 @@ struct rzg3s_pcie_host;
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
+	void (*config_pre_init)(struct rzg3s_pcie_host *host);
+	int (*config_post_init)(struct rzg3s_pcie_host *host);
+	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info;
@@ -1131,6 +1137,18 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_=
host *host)
 	return 0;
 }
=20
+static int rzg3s_pcie_config_post_init(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_deassert(host->data->num_cfg_resets,
+					   host->cfg_resets);
+}
+
+static int rzg3s_pcie_config_deinit(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_assert(host->data->num_cfg_resets,
+					 host->cfg_resets);
+}
+
 static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
 {
 	/*
@@ -1279,22 +1297,26 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_h=
ost *host)
 	u32 val;
 	int ret;
=20
+	/* SoC-specific pre-configuration */
+	if (host->data->config_pre_init)
+		host->data->config_pre_init(host);
+
 	/* Initialize the PCIe related registers */
 	ret =3D rzg3s_pcie_config_init(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
=20
 	ret =3D rzg3s_pcie_host_init_port(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
=20
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
=20
-	ret =3D reset_control_bulk_deassert(host->data->num_cfg_resets,
-					  host->cfg_resets);
+	/* SoC-specific post-configuration */
+	ret =3D host->data->config_post_init(host);
 	if (ret)
-		goto disable_port_refclk;
+		goto config_deinit_and_refclk;
=20
 	/* Wait for link up */
 	ret =3D readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
@@ -1303,18 +1325,20 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_h=
ost *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
 	if (ret)
-		goto cfg_resets_deassert;
+		goto config_deinit_post;
=20
 	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
=20
 	return 0;
=20
-cfg_resets_deassert:
-	reset_control_bulk_assert(host->data->num_cfg_resets,
-				  host->cfg_resets);
-disable_port_refclk:
+config_deinit_post:
+	host->data->config_deinit(host);
+config_deinit_and_refclk:
 	clk_disable_unprepare(host->port.refclk);
+config_deinit:
+	if (host->data->config_pre_init)
+		host->data->config_deinit(host);
 	return ret;
 }
=20
@@ -1675,7 +1699,7 @@ static int rzg3s_pcie_probe(struct platform_device *p=
dev)
=20
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
+	host->data->config_deinit(host);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
@@ -1708,15 +1732,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *=
dev)
=20
 	clk_disable_unprepare(port->refclk);
=20
-	ret =3D reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	/* SoC-specific de-initialization */
+	ret =3D data->config_deinit(host);
 	if (ret)
 		goto refclk_restore;
=20
 	ret =3D reset_control_bulk_assert(data->num_power_resets,
 					host->power_resets);
 	if (ret)
-		goto cfg_resets_restore;
+		goto config_reinit;
=20
 	ret =3D rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	if (ret)
@@ -1728,9 +1752,10 @@ static int rzg3s_pcie_suspend_noirq(struct device *d=
ev)
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
+config_reinit:
+	if (data->config_pre_init)
+		data->config_pre_init(host);
+	data->config_post_init(host);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
@@ -1795,6 +1820,8 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_dat=
a =3D {
 	.num_power_resets =3D ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets =3D rzg3s_soc_cfg_resets,
 	.num_cfg_resets =3D ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.config_post_init =3D rzg3s_pcie_config_post_init,
+	.config_deinit =3D rzg3s_pcie_config_deinit,
 	.init_phy =3D rzg3s_soc_pcie_init_phy,
 	.sysc_info =3D {
 		.functions =3D {
--=20
2.25.1


