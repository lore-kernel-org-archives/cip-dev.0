Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD44C624D7
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8276.1788341059012432482
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=dNqzqtRY;
 spf=pass (domain: renesas.com, ip: 52.101.229.0, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRguH3M9HuDpiWs9Xg3Er5kGb8DydMAf1f9bgocuBnM/Rp3LqwqOBTLUSFl6jx+4ubnNN6Igak2SzPws6PNHnHOy7Y4ahFU99IMT7gZXmg9qP4Fy0hPBTP2123PRv6lNaxghsfOea/TJ3i4cOItvErmoQjTBjWJx4YCkvcEMQs5kIY64/zKdgSgUEyxjSoZ9EqW9UD65B02ljAcixPwoa37rGhpMBXjW4y/I/vCPDbjKgWBq4LdI98sfGoBhlINLN+kuKOwWw1vS7sFxKd5udqwcg38Y6oDnNyvwR2kvw/VeSVL0JxgIf+Zos4/MObTE1SL4qt59w1I1G+mvnphOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN7nBqBcLue1tsGJFu0h6G7yFmOoH4R1eLmQaYhchk4=;
 b=Td05FJD7qfv8bhGSCKCT+h/vdUMFov7j/PXFgYOqwkjZy7K/v8fzS22uI91hqA5PQM54d/KqrveN7ef6WVoGepSuFrOT8s+xtWd/B4t1OlHnJ9VtHQfz9OkZ2nXuoGn/EG6c9zinel9mVOB2pr9AdIGW0cR2npJWD1iaEnmdSPyaOZbVzrLv58iTg15/sq85SouWI2hRJkO7tTk6thmLaVAcJGeEih9FcV+jw3wqLwUAhTKPohV8JsNinWO1z/QkC6KAo2ABcC858lmLgUgduuCoF4mg+0Jp8Z/sVR2yS69KAl6E4NowQo0S+opVfF+foRmgY6joVy7bnTAAdF8ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN7nBqBcLue1tsGJFu0h6G7yFmOoH4R1eLmQaYhchk4=;
 b=dNqzqtRYHckt17Q6BeJXAS2RJppqOj5ATsPOMqamN2mrssVy9aQdAHQcNOF/Ri/tnDj1FielXQGVHSJGEsHjwurU4aFujp5JBFDRKGt9t/wRxw1wck1Msr59oL2M+cVgjXG4ynhUme5pzCMJTuXa6w3C+cg2w6aEdCQgZdlC+jM=
Received: from OS0PR01CA0187.jpnprd01.prod.outlook.com (2603:1096:604:1c5::15)
 by OSZPR01MB8369.jpnprd01.prod.outlook.com (2603:1096:604:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 09:24:14 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1c5:cafe::97) by OS0PR01CA0187.outlook.office365.com
 (2603:1096:604:1c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:13 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 23FB63000363;
	Wed,  2 Sep 2026 18:24:11 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 04/11] irqchip/renesas-rzv2h: Switch to using dev_err_probe()
Date: Wed,  2 Sep 2026 09:23:45 +0000
Message-ID: <20260902092353.24648-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OSZPR01MB8369:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4bc7b5d6-9766-465d-d209-08df08d3f3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|13003099007|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	QwfUM31CJSnxqLsJ6ObgrQUaO5F5NjGy6GFYMDHIabNy0S13wics8Mk/nLcPP/lz6x89S09dL9+jNaqoMT/WmL7hB2V7RF2ioHAXH+KvkOoAlr1wehoRjSQkqk/aeRlJ9hefWOEHz8XOD1fS6h0JY6baRvgToeS7HXw4N5jjdlNkTPtO5/OqLq29S3kds+nL0mgHd2jxtCJrwf5a4tUDJjU4sBdyVJqie8o3rogLi2Zl9DtpPBPhUgpC7/zOMQHW3TRjIT9WAAPFQp3MRrGOqfDdXrZRO8VM7QvVsAosscjX01ahQtNq919iLYQmLK43pf5/8hI8AriqpjMPkznRDuzcPiGSw8/GcXuNL7MYHpHSlnCf/NmOjxaXsMBLwOQlFpapHka+GkHqbId5E6Vg+vlODMYZNMM5vnyAHiwj6vMaSA5krxVa18zjqphG+ITCjsqBzsUiVpIsGIfMYIrL4llv9AbWXTqw+Gl7K1lxR7N3CoXgRQ1SESJtnbd1u0Cs44IDFoDWN+97NW7Vc1QVXZuYhwdMrlNeOF+kHUPzT7k0zQqyIMQcZeaQHc8ScNUdCdVeRFNuf89XpfbyWu+razo2AXOH92rBWFdBCKSlV6IAtSWey0YMYXTXSg8wm+/d7qTx3QzccxwI7UgGHT/MeS0WRJ8OBnoAvAhFK247no4=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9BuInUnO0WaZWHNY4mCg/1IGdUEaeCJ2Kz8dIniI2/9Kfyp3cMIpX12w8g2j9MBwHHHmdhg7E8LsoM9blM0cGmXIQ3s+1TowIbJ16rDMioqNsfGx1zPdrnovxztF+tJQM9b/zKJkCvOUfAz7dFoINC+hnVey6NFCZv+oLIluI18593COSGKxj5TwkeqoNewCy1eYp0PJL/+iUTonwNYRhnKezlcNT/TaivzsQoLszAiBxBPclFuednqpoyUR1qlmdTooSlWpT6eGoCYzHXlmvcC6XEHc9mCqn+WnShMU16qTPMyi2WqMXH3N9qKggcO9oTKL/mglluxYwzJUxo4bnkHEppMjH4DZU7Q06SjjaGwDk1brqc9ZsZr54sbjJsvYLuLRRz4sWS5+gDQ3EWdLPC8FaErAuEungtW56B68dd7U6QuAjImPkok9aw/yu5ZD
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:13.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc7b5d6-9766-465d-d209-08df08d3f3fe
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8369
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24059

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c34368b0404b8fd610b4f589481a1339bab76e0f upstream.

Make use of dev_err_probe() to simplify rzv2h_icu_probe_common().

Keep dev_err() for -ENOMEM paths, as dev_err_probe() does not print for
allocation failures, ensuring they remain visible in logs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-4-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP: adjusted for the different error paths in 6.1, which lacks upstream
commits ad773ebc6e41 ("irqchip/renesas-rzv2h: Use
devm_reset_control_get_exclusive_deasserted()") and 5ec8cabc3b86
("irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()")]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index f0a3cd07bb6c..3898ec70462a 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -573,10 +573,8 @@ static int rzv2h_icu_init_common(struct device_node *n=
ode, struct device_node *p
 		return ret;
=20
 	parent_domain =3D irq_find_host(parent);
-	if (!parent_domain) {
-		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
-	}
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
=20
 	rzv2h_icu_data =3D devm_kzalloc(dev, sizeof(*rzv2h_icu_data), GFP_KERNEL)=
;
 	if (!rzv2h_icu_data)
@@ -589,25 +587,21 @@ static int rzv2h_icu_init_common(struct device_node *=
node, struct device_node *p
 		return PTR_ERR(rzv2h_icu_data->base);
=20
 	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
-	if (ret) {
-		dev_err(dev, "cannot parse interrupts: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts\n");
=20
 	resetn =3D devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(resetn))
 		return PTR_ERR(resetn);
=20
 	ret =3D reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to deassert resetn pin\n");
=20
 	pm_runtime_enable(dev);
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed\n");
 		goto pm_disable;
 	}
=20
--=20
2.34.1


