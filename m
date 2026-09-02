Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75311C624D6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8325.1788341245629801333
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=ouwtXm1p;
 spf=pass (domain: renesas.com, ip: 52.101.229.15, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgK8y/ieU8/v+q6tBBtcCyElpReKz4rWG5Bqj7DEEiJnP8tDbb2f7hCK0XmYdnT/14JX71o/tTQumQGD8/cmGeyCV1X43VdycT4W/MK14DjvYhSJfPnfgG0KloJ91/dFYzeHVMA1Uk4wdsF/XdzpOMC1rGG6wbXYXXkXIMgH4dEUEqaGAbYYwfxKFnXd2xW+q12fMIJBq1HQImn+5yZxbeVZFjUMP5WVbZbkocHWh2+BKMB4l0tT1l4saUIe9lCqJO3+KYMqyVxfTIp9E9Ieodr0GOtrEAcBBHRBqDgbKmbs383/rOLuL6vHK1cfRYhGT4JY9xaaI07mCKFn8PovXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CArjiQMQ11BUZzSmbIAkeolZyGoV/v9e6QvbXY20/Vo=;
 b=J9TZ6hvm3+FX8qnpRHLYsU6u0bY4IgE509tsJS2KpjLlf/WCbkihKzoaMkhJ+ouqajqjeMHQbO4Cj32SZuDCVZEPwpOnKq6KpXDK3irnojDP0aEqWh2k4SCdEaYMwpflQnfSYOExirm2DekDDtj2hTSoxwPzBaxZVObYVkFlUM9gGIG2JoqXBdzdT6u6/psTx4rB/9F55V9Z7cXxtCpsZMtQBYTwGh1eaJhOHtY6t7M6XCa2jahVdRrSDQl439B74MFPPwnSNO5/Lq3OK21qH2wKi/Vw8Mbwx3DvmWcgfaDYH5K1sU/YhUZgjTcbDp+0+0QHadKX2ax2ZmSshcJMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CArjiQMQ11BUZzSmbIAkeolZyGoV/v9e6QvbXY20/Vo=;
 b=ouwtXm1pQdVhlUyXju9MRFFRNQGNcSAVs/7BU4csS4PyI2KQ3OlpEKmX7rxqPyej2NhZP0KZxZnS2JZ072PEt7w5u4XtSZndRppQsuoOMLcI/7gQu0AlWRxup5wJgiMSkBdeGt+gemmyxvr3Jp7vGnGQf0+4FWR/kll30C8T7rE=
Received: from TYCPR01CA0191.jpnprd01.prod.outlook.com (2603:1096:400:2b0::16)
 by OSZPR01MB8878.jpnprd01.prod.outlook.com (2603:1096:604:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:21 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::3) by TYCPR01CA0191.outlook.office365.com
 (2603:1096:400:2b0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:20 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A3454300034C;
	Wed,  2 Sep 2026 18:27:19 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 03/11] irqchip/renesas-rzv2h: Use local device pointer in ICU probe
Date: Wed,  2 Sep 2026 09:26:54 +0000
Message-ID: <20260902092702.24746-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OSZPR01MB8878:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a1298e0-bf38-4018-3768-08df08d463b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dURnQdKaVmuc84UxFEndm7sFlP4W695vBrc0/n2U++4DZyQlCD2paUd8ahPngDM3QPOTnsDBAbrpJyaqdOAhkhYTZRBuhUfmMtQvmzPkc2i/nShc/qsCWs2MR7nejFQebmnt84k1V6URH5edAszt6PEgTVtQXhVXwM9KTTy81nevzkQg0SvKEK1iMh/HqPXHTplNOi9yzM7SskzYi7lViTLNOm/EbtlKB0I7mEP/jyXBt1NJjUMFNOWKcrpX+GeLIpDqpCQPDBD3yEEbcAymhTqQIFl4HJdoDWbk35D5LCvYBQi0+38pG2pT/IQuynLwyQJz1ewrft1KmKOmP/C0ifl5duSbmvGgMowNVrYHVzgkqOXuDymqIVgbPhIx9wHDzimC/0ErgPGs/0lwUCEa0kDDGbAV5vBuvTADNZUxxJuxmjtBqcv8dnBN2D8JAW5FNE2M/RD+/IQMEUoag4dW6K/7H5h/ea64fPEnoq2MfSy0hzHsEt5pTsHVLTSlDYCJ6mBtvhhSEE1vGjO85HJ7fUnLT0JEInBz6yhOhizjWf5m2ziILKbKWWs/W6mCfKYU3sztmd3SY46GQWApce/2HqJKOSPzOmY++KqgSL1q0yiXtMovGPpuAbGiDfpMwL4Fcl6KYJxXGJM7nMZU+DzfSPZgQ90C2fwD1wqLg0tR5as=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jF8eF9KfKphxp2Mp0DV+X1ca2TE7gKn+LzwX40JK576qoVMK2YarV+FH58TfEJW3B5k0tsnoU98+h2D+nXCiP0QAsgkYomzuXHYj/iM/UDZVZlI+lxTzimM2lFP6HksM8LAfRhVieF/LNyPYVC352/MB4flWRTdjweI208eKVqyCniWPSNZXLs2LCCl0Tp7m+KBN/M2MgMGRpr2Dtf898ERMk8OdtmNcnqSAEJe5LjZG9p/0LHMhXMO/CbQVMWWOcG5R1s9EBEml+Jf05jrvvmgDdAycOsIcoDv+iMHpwVCpsEmjJhSUNewGiHIEhe9FKv+JiykpmhKTtsbRhr/OmHilhzTZsXz4aNvExDov0h4x8PHr8J6xt5cd7uczNlO84LDc+96vyOvA5cdd8hr5G+PwUEXBwuaCUCDbVz90zJY0T/Nxu8RKKWPFc6GBJ5SE
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:20.8497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1298e0-bf38-4018-3768-08df08d463b8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24070

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit bbe78cb1399b4ba6b6d14943fb9dadefe9c17b5b upstream.

Use a local struct device pointer in rzv2h_icu_probe_common() to avoid
repeated dereferencing of pdev->dev.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-3-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP:
- applied changes in rzv2h_icu_init_common(), as upstream commit
1e3e330c0707 ("irqchip: Pass platform device to platform drivers") is
not present in 6.12 CIP
- dropped the dev_fwnode() hunk, as commit affdc0d1bdfa ("irqchip: Switch
to irq_domain_create_*()") is not present either]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index ba40cb51afb5..e9784900db97 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -559,55 +559,57 @@ static int rzv2h_icu_init_common(struct device_node *=
node, struct device_node *p
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
 	struct reset_control *resetn;
+	struct device *dev;
 	int ret;
=20
 	pdev =3D of_find_device_by_node(node);
 	if (!pdev)
 		return -ENODEV;
=20
-	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
-				       &pdev->dev);
+	dev =3D &pdev->dev;
+
+	ret =3D devm_add_action_or_reset(dev, rzv2h_icu_put_device, dev);
 	if (ret < 0)
 		return ret;
=20
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
-		dev_err(&pdev->dev, "cannot find parent domain\n");
+		dev_err(dev, "cannot find parent domain\n");
 		return -ENODEV;
 	}
=20
-	rzv2h_icu_data =3D devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_=
KERNEL);
+	rzv2h_icu_data =3D devm_kzalloc(dev, sizeof(*rzv2h_icu_data), GFP_KERNEL)=
;
 	if (!rzv2h_icu_data)
 		return -ENOMEM;
=20
 	platform_set_drvdata(pdev, rzv2h_icu_data);
=20
-	rzv2h_icu_data->base =3D devm_of_iomap(&pdev->dev, node, 0, NULL);
+	rzv2h_icu_data->base =3D devm_of_iomap(dev, node, 0, NULL);
 	if (IS_ERR(rzv2h_icu_data->base))
 		return PTR_ERR(rzv2h_icu_data->base);
=20
 	ret =3D rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		dev_err(dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
 	}
=20
-	resetn =3D devm_reset_control_get_exclusive_deasserted(&pdev->dev, NULL);
+	resetn =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(resetn)) {
 		ret =3D PTR_ERR(resetn);
-		dev_err(&pdev->dev, "failed to acquire deasserted reset: %d\n", ret);
+		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
 		return ret;
 	}
=20
-	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	ret =3D devm_pm_runtime_enable(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_pm_runtime_enable failed, %d\n", ret);
+		dev_err(dev, "devm_pm_runtime_enable failed, %d\n", ret);
 		return ret;
 	}
=20
-	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
 		return ret;
 	}
=20
@@ -616,7 +618,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
de, struct device_node *p
 	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0, ICU_NUM_IRQ, no=
de,
 					      &rzv2h_icu_domain_ops, rzv2h_icu_data);
 	if (!irq_domain) {
-		dev_err(&pdev->dev, "failed to add irq domain\n");
+		dev_err(dev, "failed to add irq domain\n");
 		ret =3D -ENOMEM;
 		goto pm_put;
 	}
@@ -627,12 +629,12 @@ static int rzv2h_icu_init_common(struct device_node *=
node, struct device_node *p
=20
 	/*
 	 * coccicheck complains about a missing put_device call before returning,=
 but it's a false
-	 * positive. We still need &pdev->dev after successfully returning from t=
his function.
+	 * positive. We still need dev after successfully returning from this fun=
ction.
 	 */
 	return 0;
=20
 pm_put:
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync(dev);
=20
 	return ret;
 }
--=20
2.34.1


