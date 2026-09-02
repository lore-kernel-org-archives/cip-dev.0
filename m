Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4CDC624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8285.1788341069168952866
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=f6VzOQ9u;
 spf=pass (domain: renesas.com, ip: 40.107.74.49, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWNo7AXp8pkLNUPjVre8dXGWGN1Sfr1/7u6fTblcTtQn4iPDg8ahZulZsayj81TfEFMhbiSpAc5e1cO3zLN9DhON+i2s7HzOfbH82CEkWbRjQL7adak95dmUDXdc5L2j/QSsukPs/Yxvt3lWQUTQZMbPDVJEMBa3sJI1oPBPDWWSXd+wn6+5RXBo+vzAUwH4hx7H2GPhrsEEqL7lHnk1i0UQm4whVTiES526+uv0X8Aij8fY6m3zAoQ4q7hHwy9z0CCkVZkYf7L3LGb/0rjyhiuJ+jHOAWyYJjfc5kQK61sCIl5GiY/pj2cyHM3h/qWi1UIoNdLU4selGU7itVIhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMzqpXL8OurQtS+BTGgbCI2FC6eQZVBU9abKMMAVUjs=;
 b=F5u5aPu53tyiVgwuIf7iBaO8D98kyJMFqXsswiQ05OG078VheUL1e8PoAmQRWr549Wjs0gMv05bFIJrXZQsxitdBTokhEtirk47ghENj05xsgCUv24bCxd7JsjyudobqBYPdZHeprAVNqMxzQ9mXSFifw8FA33Hr36xrHlcf3ijm2B+w0jyA+n7GIrpSJK9v7JOMERGnFS6U+5Xmi/9eZFZsTYgJzMng0JYMbBN+cmt9dVByySLSlAwEkLEoOMyYTOn9N27+oBxeEYK5R0Apwy+qV3anWn9Mf7Bvy2Yqz7lxT8122M8rAQk26ynBrXf08ODhmLEKK2JhkD3zNUOlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMzqpXL8OurQtS+BTGgbCI2FC6eQZVBU9abKMMAVUjs=;
 b=f6VzOQ9umnxecsav7vc7d8/EdDFnExIRGu5ZCLuldAQNt0Cn+sRXFOhCtQkh7kS8ggVWxXLTn49tH+F13HQuGaG4AyPQKW4ygUjrW9wkIxpHGroCUG5y6TNVXCyEnIoREopn9qEyBNh0+Azz0ayo543yZhNuKlJHwToOyCLTnS4=
Received: from TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::12)
 by TY5PR01MB18463.jpnprd01.prod.outlook.com (2603:1096:405:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:25 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::63) by TYCP286CA0273.outlook.office365.com
 (2603:1096:400:3c9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:24 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A4556300034C;
	Wed,  2 Sep 2026 18:24:23 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 11/11] irqchip/renesas-rzv2h: Kill icu_err string
Date: Wed,  2 Sep 2026 09:23:52 +0000
Message-ID: <20260902092353.24648-12-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TY5PR01MB18463:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ab0cd4b2-cfef-4e6e-2fd1-08df08d3facf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ZHqBnf6ufkG/+/O5QwPAU22qecKRRWMhgRR+dXTMHM+tN58JgoTacXZRjzqbmOZFWd/gS62hYG4ChszLVt8C5r0O4v0oiE9cb3lMgDfIkeeLcodLBNAWcAl476yKoWThk4nsU5h1hfwiD2vFYUmyPoNdoqVxNb6cQVWjhnodcVDzsARYyA6/Ah3xPgT/PXrB5B6ZGqiNuT4LcDhrrilYGgymiiFA/IPEmRSN76Nb18CHMcc6joy378vyqQ6MO2aDF/V7VX/5sajrvgx0QVie26HBAw6qSxStfRuGipmy3UP3xc+ltp+S6uQUrNaQf295fk7lTWxMAvcpJ4koveP8KEv35ttkIOUsgCgxtw+XARsifbllFJ+pkYddeS4m2VsRrRzcquyWXqWafRqeatV7pFN4sl5FVBu29CiNauK7ZBioJgVkRKYMstfvsZ1aPJMZl5UJYfm+oPrKnAj4YMxrmqM2T3blC7Jv8OHa3lDJkpnwlrlleqmi4sOHOGUrSnECcwYz6u9FT06ajVaKetJIYtafYGCbTN1/AOcuzlKowOJhyZKwjN9y1FJfY8etNNPrDP0vAF2N2e1VAhgn2BEoNrwynhSByGHwwiUiQeEmY8zhRGg/wjn9TFJ5WkCJlxQbeUQupkIhUhA39m8co4cQ5Q==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	prY1qjGQlmLLdrcSp/irIAseGzhNDu6/LBOWvoeGsfYlAMSb5XakGjVD4Vr1dnphGOSpSh+F+lgn8XwVX4ut9Y3MPA+L5xj6MHmXfgCmFRzr6C5gERas1iRB/S2V4nBvK5eHA2EpxrZ5v+2myC2Jm9g5u9CQMgoD7ddsECWb1tNKYGHdRpBEqWRcRv9T1kz8YCxQxEA/hzenuIZyKPSJrNi4w7TfNibMSWKDqSg8OcRDe2r8BQ7dpNhfeuLbyXn96cQfxQMnbc0FTqVE6D4DksP4QJK90Gl2GBnXxgCO/F6dgjFfMxtBZFRRR6IOkoDeXO1ikZLMK57XU/4mRPXqJ9inAZCeIG0keC8+yz0SglmQZcvmUKNtWCFiw6tRc3TaRs/ppFQ3dBWDhhhdSFygvHT8C1VmlMQAFGzJwqPodDnfqNLdV1fNDgriQEQf/y67
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:24.8399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0cd4b2-cfef-4e6e-2fd1-08df08d3facf
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18463
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24066

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 669d2067e3d095d525c69e675d8b9c738e3616c6 upstream.

Replace the string variable icu_err by its expanded value where needed,
to improve readability.

This reduces generated code size by 16 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/c7472bec20dea2c4d63e390e8e293b7d7003ef39.177=
5205874.git.geert+renesas@glider.be
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index e5e1982b2c15..0e0c3b3e85bd 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -758,7 +758,6 @@ static int rzv2h_icu_setup_irqs(struct platform_device =
*pdev, struct irq_domain
 {
 	const struct rzv2h_hw_info *hw_info =3D rzv2h_icu_data->info;
 	bool irq_inject =3D IS_ENABLED(CONFIG_GENERIC_IRQ_INJECTION);
-	static const char *icu_err =3D "icu-error-ca55";
 	void __iomem *base =3D rzv2h_icu_data->base;
 	struct device *dev =3D &pdev->dev;
 	struct irq_fwspec fwspec;
@@ -803,14 +802,12 @@ static int rzv2h_icu_setup_irqs(struct platform_devic=
e *pdev, struct irq_domain
 	fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
=20
 	virq =3D irq_create_fwspec_mapping(&fwspec);
-	if (!virq) {
-		return dev_err_probe(dev, -EINVAL, "failed to create IRQ mapping for %s\=
n",
-				     icu_err);
-	}
+	if (!virq)
+		return dev_err_probe(dev, -EINVAL, "failed to create icu-error-ca55 IRQ =
mapping\n");
=20
 	ret =3D devm_request_irq(dev, virq, rzv2h_icu_error_irq, 0, dev_name(dev)=
, rzv2h_icu_data);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request %s IRQ\n", icu_err);
+		return dev_err_probe(dev, ret, "Failed to request icu-error-ca55 IRQ\n")=
;
=20
 	return 0;
 }
--=20
2.34.1


