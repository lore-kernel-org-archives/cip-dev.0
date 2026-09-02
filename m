Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA180C61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:42 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8567.1788341257017426300
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=AhJC9inM;
 spf=pass (domain: renesas.com, ip: 52.101.229.14, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDRK5vfbsSfOToSLGrg7uIAoYHAy71MZQ042dbgYQqmbThRAAlVMS0UVCrrvY14Xa0iLxduOvb2UQ7+7kZUfyh5vhsHqWtyk9bJA30yQPQ+Jz/eO7UZoxr+pazdvF88FjvtfoAXHR3+zAj4vI0whtKK8zSTLRYKC35f/cFXXvUiurRBdFUN72jZT/lQWwoACFdBBlZ8+OlQ03zu9tOXOWwB1VWbv7MENmCJa9PDODCKXlOjfO0MxFBh87x/PbsY6IOnOEYdhLOwYgMC9z22l9bKwapHgEGk/5mTWlgS8Pb7TevX0ORtbyWCOscr+aaze8VhTiSVYBs5aFDv7ysf/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui6BR0uXPvnVTu9wuWYUPsJuBswESCi48D+raZO+/pk=;
 b=c0xvKSJv9CGjM4ht3tJevKtawntOWo31bqxwlj40ukvsuqYfqXWOmVWNhWPgeWZXD6fiE5LYmQ4QYmfEtKjqMA7KtwA9AOTK1HNLbbVqOQpGYTIjVHHF2Cf5elJika7/kNMJz77QRe1PMBXu1F5xcAWlmdUG6Xs3iwVlzT4QlUBwrMGrQzehC8qcZT/qMbLoyKx2f0W/PyuqZmKAZD7limmUosJMjNdj2xMgPZWJr2qmplxQTu10gqkUvT/VZc1sAvPDtNkPyy7tuTNajYu5FZ+XAQxwzceHL0TGPVw9T50I7ZmdivBZvpNIceZkSB4T+vJkPA72oVL+LjIXlVIEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui6BR0uXPvnVTu9wuWYUPsJuBswESCi48D+raZO+/pk=;
 b=AhJC9inMSSmHbpIJi3AyP4sqY/jVJ0E2GYVL9OinzKw06Ddq7k5DvlfKmNQgEDoHW4KxcUdzTr29v+/NOLoBaK0icbtPt4s4guW/el7jOY7neCd5A4+yDL5KDoXKBqqmddM4UPzajWtYbe4U8GfEz2RQI4PKqceHqlmjxmVgK68=
Received: from TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::20)
 by TYWPR01MB10274.jpnprd01.prod.outlook.com (2603:1096:400:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:31 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:380:cafe::9c) by TYCP301CA0036.outlook.office365.com
 (2603:1096:400:380::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:30 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C46E6300035F;
	Wed,  2 Sep 2026 18:27:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 09/11] irqchip/renesas-rzv2h: Kill swint_idx[]
Date: Wed,  2 Sep 2026 09:27:00 +0000
Message-ID: <20260902092702.24746-10-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TYWPR01MB10274:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2061f2f-ab15-4a89-42ac-08df08d469c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099006|13003099007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	xj2h0fv3dtrWS0sCiwruqObb8hk3PYEhwb2Xzpo3qn6LpxCmEQuHJ4MWbvCK5tpyGDMvjL/J4k9DbhTUSt0n0oR9K355TuhM3TNklMifiN27rysP98mi2LPmceSzSg6+L3tpZm3d3EjNW66M52T4QunVVCkhiaQ04uFtWqWdhdM5ayPA900rJ7KCVOXcJmnD3DzIrqRnruhIWq9NYWxYe+Est5nCQxgoiGmZW1FngX60GR69nH/3bw92bYRqQzbgu2z4iWzdspVJLNW9e6GPkYliZFHnoaXwwhQKgqQN54W/LwadL68gGySzMYxWyUg4E3vSOonl8/1f/JMh12syjez6AVrbJZZlIiMPxBhhS36+3lksdbC00C9RwNxIoMgcHRpwupxBa4b9XLpA8k8DHw+RXlJSe7BZqQIQlkdOe2+0+3iuLq4+XtVK9DYKhEdlCcgod4+i9ZMrfSqwwwDnXA6Re1ze7tyICgoMrncxmgrWNMaVwMBbTdKtIZUdbX26nKTtcUOjzVWo8Ci+WFDwg0HV0a7OiAgLmJbrvdr9mDD4PFk+wXQaIGO8w7BsnfLEcTfP/MErBTnd8TgTqvNS9i9yWpy9YCKPWCEBzDH33fr964pbWlpcxofvZzeGIjEZmJOemV6cALrCsXbLEp6eQpQ/8t+8UHPdP3HPU1PxJyg=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(13003099007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	21iYtvRku+xBphs06P3jzGLSZbVurzscPxZlld2pJ1whyHZt3jwXwiKtG8yMxo2hfEmiwlZLksWBr4rQhtPqy0ZB2wSugOw1zhw7nFsW1HA4R7OMwXC96a2RFesGzL00WiqnEO1HNNqPgbirPhzjAf1VCEUikyGRHOCy5OS/CcLYv023YP2LDWZnooUx99N0cfqQLQ7VgAqJbGVh6olPXd3qnZNNTRElbEXelPzTQwOstE3mRnr3pPgyGhCSiV60MpSGRX2CAQtRhwzPzvpITkIQIse3uCzzUjbFKoWj4iI9iBu5GbxMRlfNn5M/1TVI8EMgzPnCTVKcuYkpdVijxaHCGkqZpbUTxmigaz9EkyJkdvGyPSIV359pPZwfmo7jaJtgd0CYhDH7ad0B0desuxowdFh3R8Dhji33mxgjJs4NcvDpOsdcGE+x9D84chAT
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:30.9657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2061f2f-ab15-4a89-42ac-08df08d469c0
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10274
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24075

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fc4c926ccd34d4ee75669991693b47a9b8645a6c upstream.

The array swint_idx[] just contains an identity mapping.
Replace it by using the index directly, to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/0f32ba2a4701311710d02ff4fa2fd472b56745c4.177=
5205874.git.geert+renesas@glider.be
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index 238c8383b387..5a1fedb492ca 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -748,7 +748,7 @@ static irqreturn_t rzv2h_icu_error_irq(int irq, void *d=
ata)
=20
 static irqreturn_t rzv2h_icu_swint_irq(int irq, void *data)
 {
-	u8 cpu =3D *(u8 *)data;
+	unsigned int cpu =3D (uintptr_t)data;
=20
 	pr_info("SWINT interrupt for CA55 core %u\n", cpu);
 	return IRQ_HANDLED;
@@ -763,7 +763,6 @@ static int rzv2h_icu_setup_irqs(struct platform_device =
*pdev, struct irq_domain
 		"int-ca55-2", "int-ca55-3",
 	};
 	static const char *icu_err =3D "icu-error-ca55";
-	static const u8 swint_idx[] =3D { 0, 1, 2, 3 };
 	void __iomem *base =3D rzv2h_icu_data->base;
 	struct device *dev =3D &pdev->dev;
 	struct irq_fwspec fwspec;
@@ -783,7 +782,7 @@ static int rzv2h_icu_setup_irqs(struct platform_device =
*pdev, struct irq_domain
 		}
=20
 		ret =3D devm_request_irq(dev, virq, rzv2h_icu_swint_irq, 0, dev_name(dev=
),
-				       (void *)&swint_idx[i]);
+				       (void *)(uintptr_t)i);
 		if (ret) {
 			return dev_err_probe(dev, ret, "Failed to request %s IRQ\n",
 					     rzv2h_swint_names[i]);
--=20
2.34.1


