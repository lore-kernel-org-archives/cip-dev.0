Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D311BC624D0
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:52 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8338.1788341263274505446
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=lfkjKoWA;
 spf=pass (domain: renesas.com, ip: 52.101.125.54, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPuilrXLP3nOiAUyNhq9IJhmS4a/PFWoTPVihUjrQe9OBgn1ZVIwXwCZnRkUc82OEPao6+HWDayDjewqD10PDlyXYn2ewS1GmpO+/VtPxGmAvdhUKsmgZzDCFIAfrQ1843aoBpzUfd4b+HIaVLXUVBO/iC8daqLuvP26aMB9lTx1EDBmbPl2++SAJqsTylXeIenOpzAj1I/CL1EA+Kkpeq7rPvVMkjL63FJmHbO6rLWS1zM3nEovDhsy3TugFtWdktkrQ8kI570BJBsNLOVOqOxXG1C4qdyomy3WUPOcaH4j75DZqE8GHecVIyBgDy66MY4aOTUn1hFyTxepny6xkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpPnSR2YqZs0HO5dFWoA+JefALExlB7UtIwvSkchhAk=;
 b=jQ/t01iQW+cJxJV9WGUeMt1NFhethzrQ8cGscE7vV6uJ10Lvnvmyu0WkSTx8c6Ha2pDBtyLq3vJsJsl2DG0Jx38PZTaz3YL8Y58sW6JaG0QIWeTBgGyPSZ/IcEx6vHHlnn9yTxFjlNWLQvvZrO/PBv1vm6MUkmSTM4hE/vJQcAOd7Glvp0RQw1eL5ANXcKMWejRa0MzlT2vO5w8U+jmJrhBJfJpKJVWiasz65b7TgdxXOme8OOzp4mBgOz1e7qqaBX5gD4p6YiFmDt/yI20IPocB2OhFTEqFeoJ2HjSaVqM/8Nt6kVkDthh0xQACyxtnSuCD24N20j4+xl55+w7mgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpPnSR2YqZs0HO5dFWoA+JefALExlB7UtIwvSkchhAk=;
 b=lfkjKoWAOjPk9BdOsXFflTXSSaUwOLiNdK1dspVGD7owe71sqSEJJN8sAk42sprA+HL4UBFfaTO2SRNUykAfVPi+bi9/dIgIYzzWvIbI8Hzu0lDunHuuXxaAvS6dJjOJdEaSvSy4LDiijH3sTMO6ynsDbt7VLqqaq/EdrN4gQ8M=
Received: from OSTP286CA0035.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:224::20)
 by TYWPR01MB11813.jpnprd01.prod.outlook.com (2603:1096:400:3fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:34 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:224::4)
 by OSTP286CA0035.outlook.office365.com (2603:1096:604:224::20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11
 via Frontend Transport; Wed, 2 Sep 2026 09:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:34 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1EBD53000363;
	Wed,  2 Sep 2026 18:27:32 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 11/11] irqchip/renesas-rzv2h: Kill icu_err string
Date: Wed,  2 Sep 2026 09:27:02 +0000
Message-ID: <20260902092702.24746-12-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|TYWPR01MB11813:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7376f3b5-8b95-411c-8f58-08df08d46bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|13003099007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	VTPwtPNCEvdpdMDuLQSFLuKrv/ZpcBRgs/rtzBSMIGrMhze5x9qLtA8ocOX1izQu/xvT3e74Ur5MoAhq7bn0wUIkDHkUMAY+YLIyP5fd7LSbxAw15WJM5sTuOe4x+FdFP3o1kXzaWlsKowKplTg5UlZVf3WRourhNBv2Fi0LPNJHu8eQXVCLD8AKFz+tNPWlDv1qrY1vSIFKlrBRpdZcUUQC7Xtdo1+i9LeMmd9ja86UhXX2AryBHnT1u6uk5TuBdLbJbmYBx2Ivw/fwlNhsYoC5Kv932HSCFuur9O8ravyyqyKTYx7guNfffUGKkSB62dK/Z05mHJTdSbpmzXYlASBT8nbAy9sbnI4QwhuzdTUIAKLxvzlknLSJe1QnfOW3srUivZdrPpsKyyNdzy02eDAQ+WYcVddhPtoGktZrTilBaIG6HNAuhMWA0uSIQP9dNziERByxnCO1mcydJqdH+ytt/D8TU/vb+sngmGA2jpXKEE6HpVbbF7QTDqnsgYFE0j+yPAfg92/bOOVe5NuOn9p2bZehIDta37Hu0mEas+kKA+BJMHgvM049qUt7eLe/9YjX/EbL1a/yQNCc/8kBLQQaoaCn7r8SKo66xZF0/1v60rWcfe3rTgHnIZ1OQStjqiEwo3WwUAx0oxSD5sqzSg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IUc3+aKGxCUMCujuL+gewiRVMTIq8PbhGu4OYxkfjYtsAGloYQcPEuMEjY20BNDJJXvXLQOOpQhgDH9YkoEgssI+k1pIngJpRtZNmXqlyum4G5/5B97KZLSBz/X4q+lDrq6+VKUUx4IyUYnBOKTUnST3XFWdt9nfMCJGeRZzshYoXA4XFz98eTqfJkTAHWAH0jTT83P0d4DJZ0O0reMtZ3jhcVjOK0k8s6KIVISn8w8nUHLHvYX260i+BLac3Nna6wW9o3mGdpdVr5ECtk8KTf1NvofZYj/M+vfiC6gFMInTL2mUrGE4tn/oxhx8uu5/8LtyGbPhpXn8oEu5s0oQBGETJ4yttaPgacVp4v1WOQxSZS2FjIPuXU/lg7gaGbuOWfiRJmLBgNBVMMuOqFRHxDwW5+TVDkEGJdJneGNZkI94dD9i01JIdq3irUdfBtqu
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:34.4010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7376f3b5-8b95-411c-8f58-08df08d46bcd
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11813
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24078

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
index 4f687510f903..c12f7072f5cc 100644
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


