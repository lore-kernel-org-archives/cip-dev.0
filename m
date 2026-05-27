Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119DFCD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:14:59 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24212.1779898496354468034
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kvTaBt6P;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.34, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi1dJ6fva2uv8QJGKsBX8AWO8flniJbuUeM/7MH//od1FKJ6y4idnKQNO2Hgt46GgNMmYsFlTB6m1L356Rm6LqwCxIbWcNC6FzLKx1+emi2fQwtX0vJ/UddZI7srRu0eQ+AV+xehFPr3GvnNRG1baU3oYh05Ii1ANugk3qDc4LjiB1WD/ORuDFvg+pB+JkXyr1NmmXl+kMgdR6ZXZipSqiJm8xKOv1WnIuwTs9/OdiUNnrEjcd8YB88XXSEMCsiTspDbDNxzcJjh3wJb6ShRof6VBftFp3huCKan0wHmGbupNw6wl/6sGhQEkhQxB6UKoGLqguXDDu9gBdXvLNaABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqKu/13fwrZ0cfnY3CurjIzi/FFnu9Gz3IE6P7aVPec=;
 b=NO5TeXslSayB48ynmDh5HtDUQxS4R32R7tnQnqeigH/uZRRxwVXTSCTphvgD1+zNJRl0IEVuh/t3ySwKsIwOd2KDsVh04WBUtZPpiqIdfs0v8COMCNbyGTOHGLserk/Y8FHFg/P9bGlIRfg+kbGFIb9CypKNSWmnbrPsKnKQqyvB4r4sngK/LDZZpk2eeKt/Q2DoDIK+C5ihtnG1EQNAQIt8Vbf7+4IT765yfQYXYB2H/r1YSpcG64N+ZBewtGRn8SSggcQyoyjO0IptgKMUTHF/JA8y9pS1CPnRIpjSM0jXIKFvQogLoMYG9gNn/Czcw/ZIGZnMW8j904YXuONegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqKu/13fwrZ0cfnY3CurjIzi/FFnu9Gz3IE6P7aVPec=;
 b=kvTaBt6PQuRCQvZ1w+Nm51ApyD7GCCBYU4MQbrI6rwhWu+wMSNAsNmFersyOeYEy33bHCewJt8aYpxUvuTdJ3NsAgc0U5nUvfKLSZgOI4er9JBogjffZ57CLqdksckLUVpk52JuSDAT5mOXXtH2LvRJa7VhkSxenQ7w8wVVFMV0=
Received: from OSTPR01CA0054.jpnprd01.prod.outlook.com (2603:1096:604:222::8)
 by TYRPR01MB12239.jpnprd01.prod.outlook.com (2603:1096:405:106::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:14:50 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:222:cafe::89) by OSTPR01CA0054.outlook.office365.com
 (2603:1096:604:222::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:50 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 47AF3300025D;
	Thu, 28 May 2026 01:14:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/9] i2c: riic: Introduce a separate variable for IRQ
Date: Wed, 27 May 2026 17:14:35 +0100
Message-ID: <20260527161446.48789-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYRPR01MB12239:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8b09144e-55ce-48d0-a88a-08debc0b1473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	jCug8qcMW4RTbfJ+ZEM8VTnjGjt14Sqt1UvaxGDq4tF1+zx7K5QfvOEsainFKlPzuVBs5cqL/EmdPLL/wBqOlGwEX1IyscEC5uOV+yTwIybiudKIBbFUmcJ8tGAjXXQ4v5eIwzA0VLDlvAUPgDROxklTkXTNZf9kiMh0NGJ+szYerCENwc6zAOQ1CvZB5UY7d5VlEx5PXFq9AtFL1zMpzJqy/yTAUahynQy59zsWhfH56p5d19su8Oot9s8zLn9y13tz3mgNtMFIiRVatxO+eeRvfh9IvGSJpOa/67n9xoJWjrVmagPuIHaMUcUaib+CLenCPtSw+oSN+mQ9dkyHECqHJwbjJs8tSKE+OQC6fnw6Pk9w/l8lCXSbRFOzfzklBSKvPOEFJKJmrREpwRlZFXbcyZ4ygKW57EGB7RlYHlGObOouj0kKZL10K4maGsJNLZUSxD9/QtXGPiZsajzJw1a+7eH37cvrN5iLSFsci/eOapxOxOfWObaO2hQwdb/OMQbR9G9buxiNFUBi/vpW7cKEfnY392OMPuijtu4v5zGVIwUnQf6YEOXMEzSmZDLEe1ZRNBKKZI6ZREccfaSX5zZm9KcmkbrwTT+6Dixs3jmvBp24rjC9AOV/75km7SZPXNfyIc1ynJCJqkZsMrqtHbRU2C/h65dS2Eye2lB81iqk9MQM6x8VkenGfEZMJCish98pNNVg/DYFVVFruErx0m/G/zR1frO/7uFDbfZAA14=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	mOjaKeKRQfLRr075fX44hI0WyxzR/tRptUbvX2L0U5BPbMwg2Xl+FXjj8V+IqiukIiTOkM50RduvFwBToWeoYR+hT11UrMtjJWIDuE0TtmcKNVZtnwF94iKdsAqVYdyjzhmXAp1jtCiHaPG78UFgb8VtKgP7umIuLwMb8pBuRUZtBNL9G/M9ooZErRr/Z4IYhmbobx84L5Y6lEVrnpZM+8c6pDn0RfulOAflx1OJ4KeCysSGp2lAx28WPwk+IawfmQwIlZWGHV6gxBDLRWWA2OqiR0OtFBHelx7P2jD1b9w9aHJ9/mZO+IUZsTqnuYvZo6f0Fdouu0OVECuob1jBVyn1+ClixeERbaw+r2PXm0Km8V41R+lt4+XhWJL7ZHkI7idOKEaOzyZK0g7LCvdlQ5eae+OyrTNWZmve1NS5QYS/Vbt4cP4s1JuWcriZz5Zt
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:50.6314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b09144e-55ce-48d0-a88a-08debc0b1473
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23016

commit 76dc16296124ec478ec9ac011f0b9b52462c88d5 upstream.

Refactor the IRQ handling in riic_i2c_probe by introducing a local variable
`irq` to store IRQ numbers instead of assigning them to `ret`. This change
improves code readability and clarity.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 4d76f066dd4c7..feab444495a4e 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -465,11 +465,13 @@ static int riic_i2c_probe(struct platform_device *pde=
v)
 		return ret;
=20
 	for (i =3D 0; i < ARRAY_SIZE(riic_irqs); i++) {
-		ret =3D platform_get_irq(pdev, riic_irqs[i].res_num);
-		if (ret < 0)
-			return ret;
+		int irq;
+
+		irq =3D platform_get_irq(pdev, riic_irqs[i].res_num);
+		if (irq < 0)
+			return irq;
=20
-		ret =3D devm_request_irq(dev, ret, riic_irqs[i].isr,
+		ret =3D devm_request_irq(dev, irq, riic_irqs[i].isr,
 				       0, riic_irqs[i].name, riic);
 		if (ret) {
 			dev_err(dev, "failed to request irq %s\n", riic_irqs[i].name);
--=20
2.43.0


