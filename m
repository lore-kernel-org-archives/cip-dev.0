Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F09FC624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:21 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8274.1788341058309608252
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=RRa6EUXq;
 spf=pass (domain: renesas.com, ip: 52.101.228.15, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncWq7yIQN0izu2kQbNVTOB7EuIdfTeHeg8AexJoJN9z5WmfpHpKBMvJmdwj+/KeNvrUR43CQtHpwSox/FaFMRdNSFT2WfKiYGte84wVM0ee1LaMTe4i3xI5XsoWi8tU4GO39YvvepaxrDIBk9SN+QryYVSr/gYc/p2ivo3LdlAgNtC12qrhdZ9TwLDAcAsbGPxj/g4aR7mBrcU/wtVj60hBXtWfXL3xwsZEVyKpC4MDuU3YTBZZBh239Nu0OW//sSSl1nhU/R3DUnIXlE6g/FZbfRyi86kqaq0yl4FclM30J1PxVNoTbUfjaZ9hCz0pNf5OGZ5CWF/Fzu6XZNmIGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnAybUbrEPE1bT2+aGMnQpoez7xFYARynSQhBQve+5k=;
 b=gV+i27OO//dliueK2LQcwy4b9rLWP9+lA51mBixHEGCAR8EEeZvFi6xnshk3AulbHEi7H2wBnZ2X0nCwlb6vH6WaHl4/mAPRHXiNV5ah03FG5kTYVXv4xZ/SwHigTedY/1ygeO2fAKYdk/CQu/xJA/2apxCS12i6zFyjYpx9gCFspLFsZ/aeYGhH7vGx2ADfKdlmuZYPMcO9+uDRIbSBQ0lCWhdxqTE0vta+Bnldx0DtcNBJ3wPzuNE1W8Hd5MovRYoP/5wzSMqMQZRu8ebOnBzl3x+s3XTF1U4qmTmauEz1aoCaHSkjN9yabYvyuftv7sAvSNZdbHWzt8TQkOIctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnAybUbrEPE1bT2+aGMnQpoez7xFYARynSQhBQve+5k=;
 b=RRa6EUXqW4l2Ay77CmaM9/do1QkX6RFLUP8GJQhwfM4vG7QsGhQKpmgdh1Rl5AnEewoaiGtMUlwZ5Pe1IuoJWs8XFVop9wnO72u2WJjA9QExLeG5ampqRYpJS4K7XGAHwKotEqSgVHqLVesJitA3+bPdl96+9JfIcDy+Z0I8TuY=
Received: from OS7P301CA0017.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26b::11)
 by TYYPR01MB12967.jpnprd01.prod.outlook.com (2603:1096:405:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:12 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26b:cafe::93) by OS7P301CA0017.outlook.office365.com
 (2603:1096:604:26b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:11 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 74D04300034C;
	Wed,  2 Sep 2026 18:24:10 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 03/11] irqchip/renesas-rzv2h: Use local device pointer in ICU probe
Date: Wed,  2 Sep 2026 09:23:44 +0000
Message-ID: <20260902092353.24648-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TYYPR01MB12967:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d07d87e5-1850-4b1e-cc5a-08df08d3f305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	71VGfUjOk01rYly3MM3WuokVkJsfC339+/cUGmiKwu466w0w1eSHPkoy5ktFgz7TqTJ4jEhKzpmaXXZJTFY1xN0+8cKGNaoankmuHYV/9ity4DP5xGX+2F1DBIuZ5aWbASGK0tTil4vr5AnzXF8BKO0ZkbVCeQLAQAc5wziG1sdP8t7dvfAFK1OgBR6U2bGym3xhuGhko/2PporWa8UJVDbn6a/pCA5YOVnkgzMqLFM8etDYE03WO2FURnRc1q5rn69BJef1Gcn6O4SUwslLglNFM7bGrS6HA3QzfuWxet09cWAvMaFnUjOsm5R3BBmQwrIpOnX7Rait5XSn0pyM8wDQz2h0IuPV8gWuBwvW/eirGVh6WqHGQrRQBS7+Sp9mbbDYHUgFFB7furz4amV1J5v/kf+uis+VcNTdccNeF9eaFbvBqRTHE9kn6WxaaOJKlsuvJpk3uXPimssV1VNgmXReuofoX1vdwpqLAwc8eyUcJHvt0pEaGXApbX8fwyk//czv2lKBNDJGW+xuYqtswV9d2ILqAwKM8u74ztXpuE7vPx1EIOW1Jcrf0+skTaCFcHeh6ateepWDjMnB4CVP3OHZ90DGeObrNfj2k8bLstQ5GTvucOgiBAoHG2NPcUCWxaUDWUybEpUvv7yjn1yZJ1a7S1WE1rvus6q+FeppYCw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jivs3ZR7xWyXdQSdhw8XIxpOOxrie6NwmdxyOE1K6zK2o8zXgLutvjV368rp4ixUJAxwpOfIPFGyd3FPj8Iooi8z2fB1gVVc/V5iBOZYjonungYoxC0iDUUrcxUT7Zw9clTlWH8i4sy3Q8Kv1qk49R5fNnn0sIHCYVLvTKOcTfbkPFUvpntI1foe0uRd+QpOPSh8FEdyKAVJJK6W/i6zEgx9ezzVSUNMicc+bv/TrE74xjBkJmHMM2r+8F7vKGkmHa+yreKd/sWlh7X21qodlpBeHA50ZuiL4/8jNNjdcQdgSka6482FxHJCIOS2Gu27vZ5j5O5jzUCeqqUzNxHYPR6OZXJ64/Hp6Ha/LISdiqzLpD9O6l7UGngIv3TN0JO81R3WzgdV0vxMlK8bMZY9eEKAZAYud0esi7LsdFn9q/IOv7PwJOsxqx57bR9kZ47v
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:11.7624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07d87e5-1850-4b1e-cc5a-08df08d3f305
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12967
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24058

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
not present in 6.1 CIP
- dropped the dev_fwnode() hunk, as commit affdc0d1bdfa ("irqchip: Switch
to irq_domain_create_*()") is not present either
- adjusted for differences in error handling in 6.1 CIP]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index e599ac398237..f0a3cd07bb6c 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -559,53 +559,55 @@ static int rzv2h_icu_init_common(struct device_node *=
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
-	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	resetn =3D devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(resetn))
 		return PTR_ERR(resetn);
=20
 	ret =3D reset_control_deassert(resetn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
 		return ret;
 	}
=20
-	pm_runtime_enable(&pdev->dev);
-	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
 		goto pm_disable;
 	}
=20
@@ -614,7 +616,7 @@ static int rzv2h_icu_init_common(struct device_node *no=
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
@@ -625,14 +627,14 @@ static int rzv2h_icu_init_common(struct device_node *=
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
 pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	reset_control_assert(resetn);
=20
 	return ret;
--=20
2.34.1


