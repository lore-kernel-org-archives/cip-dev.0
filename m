Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A7C61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8326.1788341246611725611
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=KUx1OZ9v;
 spf=pass (domain: renesas.com, ip: 52.101.229.24, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A46hj4GaFXHhCAqUdTBg396ZM093OVyWBRYgO1aVQgqllWiKi116JXJfrbXm5lcq2ubgrxcT4A/y281kP3ppJO70VXJoFjb7gow3+9ZE+ht7agi0Dnp9lz4wttl15FnmDv2e/TpuxeKhtm3RCLXbiEndgEiOaMKMeSvMcBg2AC8AzscWySyhhk22FQ1fbZnJQcGTcm4eLZ2jvDtVdkgmdOS96jR+yQNxFT/lS1hVLs1MsKEFEXpk0vnnrNpPqKg2Epb90tgvG2KibtnjwdMczxbEtvVnNY2rB6NlEs+tEYeoUmQwAU13HO/1vlohLr+oA8gMTEMB/paJu84Ti7gAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz77XTgMWnfQvOghMusNJWWBJV+gdU74lT1X4rCRa5o=;
 b=Gm/X6cXj+Sd2gWkhq2k3obiTg/OOyw/DL81KfiQ4mJEVzsGLIk8IZTYXSbV9ARcgllaFB5vrNJuOZsGxVdiAzIzrNnlHeNxUuMaQ1lu750ehrqpCJni3lWaozoMqt1cJDkaxtkDNwSXq6sYn2KJ5wLUX8L/pDN9KdDZHjxqnEBL7p6Vz8d48dVlzhb2VnhV4sUQ1pkKy83mYxyhHCikHv4M/s85vAWCjNpymgG5Wv+e8LRsUti5uRqzbmGUpjGtxlTfniR98S+BGiJjKajAJKpf4AQlpLlOG28RHUB1LCK6nb8kCtootR3CzsQlSGWnQWD8llUNZM3Jrg+8v0hbppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz77XTgMWnfQvOghMusNJWWBJV+gdU74lT1X4rCRa5o=;
 b=KUx1OZ9vkeKpl50b3E7gsLvNC1J/8DaVEj6nNZxtTOLUXSpxx1u1zMdGrN7VjJvrSAnf89IOrdfjUhp1f2Mm16jsr1oF9ogGX2rYD9iPgUMBSimEhx8mZsKSqgscvs8g0z+Axnk0Tda7kibGQMqVQSZz3p/Qh4xuVbUX7g3HoS8=
Received: from TY4P301CA0015.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::17)
 by TY4PR01MB17511.jpnprd01.prod.outlook.com (2603:1096:405:356::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:27:22 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::31) by TY4P301CA0015.outlook.office365.com
 (2603:1096:405:2b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:22 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5139A300034C;
	Wed,  2 Sep 2026 18:27:21 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 04/11] irqchip/renesas-rzv2h: Switch to using dev_err_probe()
Date: Wed,  2 Sep 2026 09:26:55 +0000
Message-ID: <20260902092702.24746-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
References: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TY4PR01MB17511:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bf4f611-003f-4695-267b-08df08d464b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|13003099007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	L/BqmC5aFJhhyyRiYhE2AvPDKjlbCiQQJORhTrj0/GqjwziPMWiAphzfPYXEHgtwY2sGfaAkuS6PzixJfki3nFx2pCwc4bBNU0YP8KABPjcN1k3HMjaSC5HuVwVeggpCUCY+/jOIKRXzqrcNaxJG75kY9Nb7a5gYu6YYIkgOpf6AQPTXoJX7ptX1gT4mR9IyHQjwEXUCMbwKyxUnaqIz0Vrb0QV2aGJaGdLCzy9hzzEDsfBI80/nqOoY5EXNb5s2OQZgxxhZeAUpkH9iMD8WenJJMhQP5VFNIga5aTeE4fkr/OtZCbDyzYPXVjDYDYpG/j8urhSgQ0NGymOmVi1EJk6+N+ICUfdGI6CRwNt9mC153D//y1iNjV3qCQC4TGlKpgkG0a+qfOTx1lRLQINk4/HNxUKxUWKsv7b1pPXYcWGGekRILu1yOtjzJh6jSPcN3aBbyiE+jYEvkjhWD7gcvPcrokm27CNYz4wtWMzXM+TDtNiOZWbyvF2EeXopaL2bm/nRkbcbnOys6a/A7Ag3oO0mdDKlaO9H9Q1uB4zGue0E4UK/pKXkpUw+KBclk+YXWJnFUBJ+4WZwBFwjgbIuTN7e0dSzVHwIlgF9uzQVkRWqPMZNRTQJEa04qpK+JIUm7nEhdeCwhQMSgwfEMEEXjA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(13003099007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	njHaNZqaIS7O6GP0z8ES32Pl8H+9WBT81DYmYUEjpL8SzGxtlcWQrxG5tPEib0eBQmUvWWXOJ6YJz4sIcaZ5afyoWdJUr7V7H6quqOnSqTeiVnyOfPKaD9tZJ2UKkm7i5L9huisZqQo4teq++ycnRBO2TY5S4029fOr1HojdLXXIHZOhE1S2O7gMi/DIP2G4NBrlspJgGzO8IfWqPWy4cUYo3di7olsWMGbUZp6XbDKxF1bscTN7qh8rcYjlZizLoqIpNtjpTdbkroh/zFXPVcgw/GW2i3saAraGOicxIqw65bj58OKLHN2AUkw01fEh507BI6R1wdIzyAiD4PUpd6qoKlzFiFwOB2WDmVSOpYSd8v/gi2Yq8urWLJqhFLsbG7NtwOJZbxCRTanyyf8H+PWlUI2+mvCtKhL/6rdyXcq2OOOy3qFxYDp4+57NpQns
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:22.5018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf4f611-003f-4695-267b-08df08d464b4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24071

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c34368b0404b8fd610b4f589481a1339bab76e0f upstream.

Make use of dev_err_probe() to simplify rzv2h_icu_probe_common().

Keep dev_err() for -ENOMEM paths, as dev_err_probe() does not print for
allocation failures, ensuring they remain visible in logs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260304113317.129339-4-prabhakar.mahadev-la=
d.rj@bp.renesas.com
[OP: Fixed minor context difference]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 31 ++++++++++-------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index e9784900db97..7468eaec6bad 100644
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
@@ -589,29 +587,20 @@ static int rzv2h_icu_init_common(struct device_node *=
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
 	resetn =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
-	if (IS_ERR(resetn)) {
-		ret =3D PTR_ERR(resetn);
-		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(resetn))
+		return dev_err_probe(dev, PTR_ERR(resetn), "failed to acquire deasserted=
 reset\n");
=20
 	ret =3D devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "devm_pm_runtime_enable failed, %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed\n");
=20
 	ret =3D pm_runtime_resume_and_get(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed\n");
=20
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
=20
--=20
2.34.1


