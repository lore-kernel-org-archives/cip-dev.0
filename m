Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BF5C44500
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:10 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65743.1782987844020409605
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Grf8vFAB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.19, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysDdjWQY1CLtHMaGX2km+bIxyy5IMRCNTIcGixz3YAIusYQVT/xrknSbhyC7V9dy2Z6dSrxRs9LSlY1XIu2Bd6t/cT7SVepxwpNjV2CKdwLSLSoApDSrSGMIxqDyvOKfrL5nSagSRLZ46FWfuYfKBiCmHZQ1KMa+42zcAk+l33hHgn5t1Hqw4FyFDljxK4+oNFxH9pDgpg7MnmLTiD2ATLhWt2NM3OIq4SJivtw0gWAppZ0HP81nIYqwwu7DO9pIVnGJXjpqSlc85rvALS67nkQI6Gkja+fgd+bC/F1Jg5ksVFNdjC27IrGaTv+B9TKAFuvrucNjW7w5kKjXQGQkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmMTrNNE63wQBNNkyrvkxTcyIurxSKIo23aWopdF57A=;
 b=GUKS/FmbH0gRn6M6lf98ohRiN16MmslKGI9zkWTHusScZhsoxFyEBGi4Bt5ht8UFs5MZB1CkVcsSdLtmjXEtXOEMaJmSJpiKZWkHbf6UVFKMGqRhbszhEYsYX0sYfGa63btqWw9dq9qLgA4s5An+1r6X9FZDYVUNR1OXaL8ADv8PAzR+I2S1N4yEHMxvhI65Jkfsq5W46jHR+EABAa+ff0BtbitgsULFdNm6KXtuKxsYMxIBezqAH47GSNz6AdtxnbbIUtrCuDoD9/DDvC96ycSt5MOOQmSOtrRNomvHw0Fjvs9Y1NVJaAMMRz7vJx6btpipbvjcrd5aguzW2Wic7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmMTrNNE63wQBNNkyrvkxTcyIurxSKIo23aWopdF57A=;
 b=Grf8vFABhFiscHGCPpdW946sYQS0p76etGtsy/l44cmLVV/lakmCJrNAqBjKTs+xymT7OjmmOhostST4P00fdJdjecfDw/Ne+OPSGVIra+5PUQQbzvyWh27a0DzcNRStaIn8dd2dprm1DsqltZCUzaRwDwK1fRBQDGrecyAayL4=
Received: from OS3P301CA0050.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21c::20)
 by TY4PR01MB14162.jpnprd01.prod.outlook.com (2603:1096:405:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:23:56 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21c:cafe::42) by OS3P301CA0050.outlook.office365.com
 (2603:1096:604:21c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:23:56 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D407B300024F;
	Thu,  2 Jul 2026 19:23:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 01/10] pinctrl: renesas: Remove unneeded semicolons
Date: Thu,  2 Jul 2026 11:23:40 +0100
Message-ID: <20260702102349.23431-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY4PR01MB14162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29ba94ab-a73d-4d51-5d17-08ded82405c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|13003099007|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	jOKsr77k77uaxJvmz0I8hvWaAO+WbsaeRjmvlR6491girAUA5E3LbDFRw4zDZapvAv6tofJI8TI1u8f5/Z9eLjogkCRWtCf+6elAvZukZo36Hc//7uQg8ZCv+UX3TI/NbBKMCNvn82kjT/h0ky52UJhb+aOHbU39IVX2rs+Kzi2anMGIxzGxzT26SdQM1DPfyeP+QKGT2g1EqCmxdfjD3gpkycwfVCNLlRevWsR4UflfY4NzaE3nz13N7sGr0rfLzBnu7hQaHlMmJ+lIdI3okQYN6kgr7nQi+VrdqqAlz/JHATpShMQJDlvfGQrt8njxYIXfzY6TM2d2xRsHYA4hU2wes8ZwPMYiDiWIdnahWyuSKc9gmQ9nPsec9nM1/7oWkaxfg5QAOG5fy1mBPN0mc7aw24Yh4gcpwtWtCpq++/YeR4IDsbA71VxA3ES+jzYvmGr61nf0FjWLNq+Yj72AUXttbwViGa0qULoOW0I+SbGdeCN94kqI6HWwRyMdq4WGGI5vPVbW4gA7LNBAHpBA2pTZlIq2NIG0RP+u00wxDVGNaOmH1ZVkB6Bw6eiZfCIKOQMRgsScwr+mAJUxgyQKbsXjg1SaXwOOQ31S20IoTbM/N/oOkE3QYm69fZpC9DNQp3W17cAUjcCFow5U5ZVlkw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5KxlCqQyiM/V5mrGk2mQgN3s2NxD+u8Gei+pdv3OIfIryVZ0G06JiTSWhf7MpoOkys4NS2/2rH7k3Sge2C5vRC95JudToIfUtFgSspUNrd3oO49k+EQgEv/2Zx+zC5fxGdzTN0b5a8jX4Wb6TfYTrT4AQcO/yuY6ktqX/uuZocoucJPCJFsGFoQgo/JJNOYaBRgBFcAmb+WtRsbQqgGLDJrOK9yLvK4+1fOL0wSmiGEyw8x4aR77OYyiW+xftTsnKlKKPuBVLcBOlFfs6QIwyXf5PiHY8n9v2UmyPYhnMjYsImRiyTEHl7hYwsBrWQT8IQsYPhG38O218FOsCANPgqtJQEh8ZbIynZNDYvp3Zs0ej+cCNwNzDdXczOFGKjixVs/CJENc40DuUdb9ytaFK5tJ4cNtkBjtt0K/p5VuzJYH6DbfKFgiewvVmU/w55/d
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:23:56.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ba94ab-a73d-4d51-5d17-08ded82405c9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14162
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23382

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bf48f99d95dfd664ddb7c4d69b182606f5ed8605 upstream.

Semicolons after end of function braces are not needed, remove them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/99db8c1bfb64980b54a4b5c4988c7935609133e1.175=
8718027.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c |  4 ++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index d567612b30953..63c49e813fc15 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -144,7 +144,7 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	/* Switch to Peripheral pin function with PMC register */
 	reg16 =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
 	rzt2h_pinctrl_writeb(pctrl, port, reg16 | BIT(pin), PMC(port));
-};
+}
=20
 static int rzt2h_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
@@ -182,7 +182,7 @@ static int rzt2h_pinctrl_set_mux(struct pinctrl_dev *pc=
tldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzt2h_map_add_config(struct pinctrl_map *map,
 				const char *group_or_pin,
diff --git a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/rene=
sas/pinctrl-rzv2m.c
index 8c7169db4fcce..fec603758687d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -155,7 +155,7 @@ static void rzv2m_pinctrl_set_pfc_mode(struct rzv2m_pin=
ctrl *pctrl,
 	/* Unmask input/output */
 	rzv2m_writel_we(pctrl->base + EN_MSK(port), pin, 0);
 	rzv2m_writel_we(pctrl->base + DI_MSK(port), pin, 0);
-};
+}
=20
 static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 				 unsigned int func_selector,
@@ -186,7 +186,7 @@ static int rzv2m_pinctrl_set_mux(struct pinctrl_dev *pc=
tldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzv2m_map_add_config(struct pinctrl_map *map,
 				const char *group_or_pin,
@@ -551,7 +551,7 @@ static int rzv2m_pinctrl_pinconf_get(struct pinctrl_dev=
 *pctldev,
 	*config =3D pinconf_to_config_packed(param, arg);
=20
 	return 0;
-};
+}
=20
 static int rzv2m_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
@@ -689,7 +689,7 @@ static int rzv2m_pinctrl_pinconf_group_set(struct pinct=
rl_dev *pctldev,
 	}
=20
 	return 0;
-};
+}
=20
 static int rzv2m_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
 					   unsigned int group,
@@ -716,7 +716,7 @@ static int rzv2m_pinctrl_pinconf_group_get(struct pinct=
rl_dev *pctldev,
 	}
=20
 	return 0;
-};
+}
=20
 static const struct pinctrl_ops rzv2m_pinctrl_pctlops =3D {
 	.get_groups_count =3D pinctrl_generic_get_group_count,
--=20
2.43.0


