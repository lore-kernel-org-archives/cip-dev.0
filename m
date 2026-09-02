Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D9C624D5
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8282.1788341066497399831
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=c+CdoG+r;
 spf=pass (domain: renesas.com, ip: 52.101.125.43, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcccaiL6V69JeEw1IQt78ccKKtXx4f5Mvx2JgFXmoqlWx26oV8hu4ydDF/3yOAf92cHBt9QgFY/N9fw6rsiqIFXAINTJFtv+es8hcIpDMgs6YV7TXG6CJhUIIfLiYvT4FFne9jBZ9M97wczNaYvrUG5fuMfe+2xxOgV8R0cIJMVKrF50lpaIcDlHbcCSlMSvkkViYixTrlwYxqPy62kawVgf4civHd9jcKKQsk31k8JrbyKT93f7imR/l0QMDsrk8+1Rq/pI76L487vAmfslGc2tBULmsvmc33+nYztwfdOTU76SJ7iEQP3o4PV4Zc51lhnmYJVExraBbOSbfuH42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+cdoXto9OSm7mhJeOzMlttdyT5AmzeWYhoV6aMC8lw=;
 b=HGoEwfDziutEeA3HzHM9hznD6yERlORkBE3FL4qTsrvsPykFp2pcLX6LXoOOOlhvPnrmvE1DFeTIUX+BOA6aao7qPfT/uqg09zg4m3se+T+48rPuyteX1bwYkxbB8b/J6USrrYzGm61zWqbV3xYnkO8q4z96oU1a/e6k5q+IbxeXKiYOZ2f3L5dXCHnU9CnJJVAyi6Kfr+8t2z0T3scQdD4++w3N2EfvQjERhuwfio1t2QXzZ4Nxif29/sNzLvvZGW4STfaNC1+ZBToJIpC7riZDUTo9pm+Al8n6nafU6MiYlCSv3E1wjSdjuJo0fAf5JLU3ytYO2QazaHZVDv0AKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+cdoXto9OSm7mhJeOzMlttdyT5AmzeWYhoV6aMC8lw=;
 b=c+CdoG+rE0niozYiZAB0THmdXoOH2TfhDBZ+jSDw13cWtkkAkFlK0MvCHoo71XeGKz9FsqTtB+tTxQWA3YuZHHjKl6oG0TQa2X5RrxcdhK7jTOSfElqKN72uuR/+dzupJGtkCNvsr+1l0INkRBcDz4BHyOtFJ7tuZU2ROgtxScI=
Received: from TY6PR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405:3bc::6)
 by OSAPR01MB7350.jpnprd01.prod.outlook.com (2603:1096:604:142::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:21 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bc:cafe::1e) by TY6PR01CA0001.outlook.office365.com
 (2603:1096:405:3bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:21 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5D8823000363;
	Wed,  2 Sep 2026 18:24:20 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 09/11] irqchip/renesas-rzv2h: Kill swint_idx[]
Date: Wed,  2 Sep 2026 09:23:50 +0000
Message-ID: <20260902092353.24648-10-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
References: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|OSAPR01MB7350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 180f5513-bc14-43cf-05ee-08df08d3f8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	UZWk9+qIlRcp59FFe0WtoFYJGS8k/Z3EL0I0ORe+WhhHSjU77hI1F/9jQBYThgrpgf5UbRakUg3Fays/6conUgpJTK4IFmRoR2tPraryULVL1ZB6w7D7P7tcNWPmWurzF4QWmHGWjzrdcqC5nyl9CHWwa64921M5FHP/tPDoJ8XReYbuRXOYBEfYs0TrA6qhJr91NoJSdnn/OhSi2P0vR0z4J0UOGmCW71MdaFEJTbDbN2lua2idRw7xHms+JbRK2HqJ1NVfeIAZKs92FL1hNl4fZlzYuNRpzokZ4qbNJWTik6zcHLeEwI5LoQlfGxo1HMWYfny7WwFZFpkX5J9pLtOq8vYoJdLQg/XjcDN+Y/n/lm3AasXzwpKhXN1XykcqdxE4ajH3NDcQ7BXZsb/YfuW7VtAMVXfw9YzCJiIl7jyktPj7W2iety1nSrT0Sj+s+KrFXaEASR8ioidoBkpxQ0n6IUWJn8OePFOoRU8g7zFOHd5AbBmDeOlI+8e6SSAimSXEGwGCDTQB7lFB+qE5W5QhCW07oNM769j/lYtBK4LdKypaDK5xC0E4mkeR/tDaUFSFyo4QFy/YsLRp+fgMS3+5Sh23k+fya9sfMH1NO3jeyI/F2ZNhVqNrUi+js8eLZGVYXCMwQmz2PLpprIKNbiqMbpHDLj6ZNGOp4wpgDKI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JqS6XWPp19QETOK9AgdPW1bQHLJ2T95XMYs1sXDR4bVjZ8LUK1QU5aED6YKdQLPEJKP1k4JoA2INhEhI5d/1EG0eNa9yg2Ibwa+/i/w6f/7TcbompFotEbI5VlcAAuUaxBr37eIG3QEuX9RBXkHalylCk2VexTy3nPpEHk9Zktlbp5Yl+QBT7zOMsnZqvK4Xo0Tlcx3utbmsCt+2n4vumWW/aSIlMlayUM4bQ38TZL2YqvDG/ZHLYfRRUm2j2aG+1nPYYYTiIIxlkKbk/sUzbEnFmsSS9bh2H7VqqyuympdGs6PC0O43A3wzXURS9L2cnqC9vo5v047Gd4ou3gIV95AYwDWTCIlmmdqu2Qb2949PmoBBbkCSh/xFpr3+fos8wXdNNI280iB2z91+uaNnt4i9sPDq/nrmrTl46Jub//c+uX5Mql8kCGsz2J5jwO0a
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:21.5429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180f5513-bc14-43cf-05ee-08df08d3f8d8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7350
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24062

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
index ce5773d7ceb0..6c1b17e1ed69 100644
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


