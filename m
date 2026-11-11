Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5796.1794388777181899611
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=a+ZePt9k;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.61, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpOcVT9T6ycGI9gkb8f7S8s4Yddwu7EMJqoMCYNU+mgSUtLIWU7b1mZCbqBbifNA4n38+hEnO05iKXz0jMGCDU6rapb2RZA8Gsd+459YfwS9jOfZadhxOBUN6nzt7nyeFjsn8SOs24ZEg9FoOHgW88xpL8EbV6dkzaVoSPg/ELLrTXDTx3DAwecCkB2HDpUt/NuCwDs53t8gFjXf6DnOqie7cOVVvhK+k6eRuybIvhUK3MljOtXMhqEFAanGA2hV04f+oDGoH5D07h97ySiqPqI0h7Bc+EcV/cWPIaaoprcVUsNmmFmrny3CqSiu7n65xZQ01biKDlDGRE8mfltqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv5GUIryXOwxlx+uQ2n+er+9m7XtWETkEjiSP1VlhCI=;
 b=YmqdkHD/3MhC3nna1qAhqKobsSDOBpQJiaX2Jz9CJIQPs7WyPKQgXVWfudxCP94RDrlVVPE4ZIONeRiuIN2maqTmRk6qsYt0eRxd+svaNWgv5hUA/K4d7Hcg7ELWQCev00BLvmI6g7PBPZkxSCxVSecPO+iEgHt+EctOQjz4YaEru3KtxUN0ic2ffXQERLB6u0L66zTuGfh882tCavjg46SjIW64iQX21afTvvHgiQ+jIAOUq0+zMWQaqOM8R1/I+uejY4JKbGwmVhKrt+2URManeT8caUJ7jREm4xIxTYkZ2ns943EI1t4PDRh/rV+fQPtuVU3+7a2UHQGUO3W2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv5GUIryXOwxlx+uQ2n+er+9m7XtWETkEjiSP1VlhCI=;
 b=a+ZePt9kkm7r5kcmxqhCG3hivPb6OheVNFbgkV4GpvuYSOwBZlod75h/NY6xUclYQcMAbSWrascCN3ZnoB12L8rvEchwsbU5vI4VGPZO0CNFXIkxxxT4W+S3DNZjDraWxgEb5n0hW/l7vWOB3DHPPcOX9FVKbczGPW8XtOeHgU8=
Received: from OS7PR01CA0042.jpnprd01.prod.outlook.com (2603:1096:604:257::16)
 by TYWPR01MB8592.jpnprd01.prod.outlook.com (2603:1096:400:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 11 Nov
 2026 09:19:26 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:257:cafe::31) by OS7PR01CA0042.outlook.office365.com
 (2603:1096:604:257::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:26 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6E6B93019A07;
	Wed, 11 Nov 2026 18:19:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/21] rtc: rzn1: Consistently use dev_err_probe()
Date: Wed, 11 Nov 2026 09:18:53 +0000
Message-ID: <20261111091901.41995-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYWPR01MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6c92c6-1351-4cbd-fc21-08df3fd4e216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|22082099003|18002099003|10067099003|56012099006|261021121427099003|11063799006|261022105027099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 2hgGkhWi4E3XxRKWXQP4nTJrRKdWm1iYMIlLcOZ103DnR8hAhwNnvPRwGTM+N0NyKt0J/JMaetx1pCha55XQ6cCkvscQukvigAQVaCO1iPpaOXpzUX38lfa/xk5txZs5Gjrckw2e64hGTJnyVU/8HZVgH6YPTT55RLZ5BWMjJ4IhVehIHgF+FKEF48Q/qjFuj5E8Z3Wgq6hj7tUqSwYFA00DotIDSRBdhfqq7+fHEe8onPYb2xupEexe15RNcqhCqUwkHQ5KYm6RS/Z4VAV8NCmKEcXg35UFAP47lx9kL35+kJCGidMSAZn0PppUr26dCAVsv83EjMurxcY3MHRzPRkPT1aD2GFUhMTU3NDWvYfj8Ft32NqOF81jlAt8hmUW1R0kQH97ukC9y3G8FthszdFfquqs14kI+0vsf73kHoukjBzDp/fC9kaNPl+X9bGuJYctuSDwo21JVUUl1ZHnoeaZiLsobXUsA+ASz6ISL55cyX++piykzlucNdWZSJ549OtsNojS9PhypwTcflxumsHDWemF0LwaBD8uufGONkeEEGD0ezQZPYVMaZe9FzjzdnML8s5NjkGeeBQ9fbF0v2Th0NBqnKxvM8LH66IAECfZawqRKb/EIp25MrABWbibKPijRGwK1e+T77ladmHXIJ0zAn5Omeqy8F7Au/C4y88=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261021121427099003)(11063799006)(261022105027099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IZ6amIaLtP6GEXgvsJv4dhJFDSS+/CNM2yzz4fo4pqQPwvQ7UurN9ZBp/0LMiLAEUEp04EFp/d4ounrJ2qpa042X3pv3KGIRe1N69kmsCRXRJQM0hUEK8dd/C7AmsCPyUBxEd2InUvhgt94AegHYkO7icwStjxJg3NXCyzQ3z79PpAhBRJAdwYgE00DMMyy/TwZjvpf+jyXqIquflRvRkz/uL67vXX6IWubZpZBa+e6Nk6HtJSPSegJMmx9WG6STMPcT1QGSuehXOzl1V42nTiKI65uN8HiXan6WjbA6EvLf2R40G/eD5M5/by8sK9I82a+NPwese8hryszXvHeiPiDNKvkvGAkmy1fjwRviOQXvVm3coNgYGmnOaVeiw6XnV8JPTmdVYXzad2jFmKVt+szqVxPqohTOb3Puv+9ojnYQfFNV3UmmJqxsfOqV9cPb
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:26.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6c92c6-1351-4cbd-fc21-08df3fd4e216
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24756
Content-Type: text/plain; charset="utf-8"

commit 0e1ae8c654f05d813457bee308f864acea7b5cc1 upstream.

Use dev_err_probe() in the IRQ request error path to make error handling
consistent with the rest of rzn1_rtc_probe().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-14-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 5849c32148868..0038c8b584284 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -485,10 +485,8 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	spin_lock_init(&rtc->ctl1_access_lock);
=20
 	ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm=
", rtc);
-	if (ret) {
-		dev_err(dev, "RTC alarm interrupt not available\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
=20
 	irq =3D platform_get_irq_byname_optional(pdev, "pps");
 	if (irq =3D=3D -EPROBE_DEFER)
--=20
2.43.0

