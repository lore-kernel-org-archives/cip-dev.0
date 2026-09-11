Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0B3C88E55
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34789.1789114309663988799
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=f9UsJGIQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.3, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pntKb5S0+VgxkPtVIJmo3vbKhcGHt3yyoU5lAdA5nc+W3/TWxGIDYFrLICsA5cHCP4dKRKvfrVrEZ8/f2tFAl15Ub2rzgZfuEkb5TgHqEvU7dy89sIVMWQfCXMFb4hdN+VB41/OhmUFJ7QJpQ6sKZYdXVdGLoj9X0nSXGiD9gQJuj3XvVm7/HZMnNfZdEZyxJ6rlXPcMs5n7IVJqEtX5qQ6/6Ay+lDL3RN18s6T2tiyNUAT19I+os4FAxLzhzxcUmJ0X8AY+x+RyzpO9AQA0jo6ZL8vKTBF0JGqhrKqDEkqS5MrgUVExzxF/5aqRlLQxty2xw2CK/oUgWzJxfQjT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGOQ+nAhxTwIju2f3aQpZpDlX+3opRzvAF/KUXnyrvI=;
 b=Pc9c5OeympH10OqlTPY45PXqPP9kgftdm+zsE4fbtwXUB+mCCiOSOT475s9D7aAZ1EQGfGe41KdCMv1uzednSYMsJC4q5H9xR2A5BDzTMDY/3zQnia7XKTVXbsaUYGufDIKOfGTCcMIcA3V0DVPCZiye+DRyALCA4K2nHlrZaOmvVJMlH5LA9w6C3hzPlEn6wGqwPEdlivdJBaxRkeKZ1aCQXyzV0aqbIw1HlXB22XCqsnvokyXfWmD1OKnV1JdwcGWBTKME+iLj69Zi8EdjsNKUn3juojsYcJntVuzRWg8I39VadOcItThIbqjcixHQ16sXWz1Avm5XbT7ELdSGrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGOQ+nAhxTwIju2f3aQpZpDlX+3opRzvAF/KUXnyrvI=;
 b=f9UsJGIQjozTD1kHeq/frUb39QSnI4mxtaZRiqJWHRESQBXEeWhM2SgKBfQcr25Ovljt4XVjfu5UrWEvv9/0T5NXqzLpzef3JdZS9HDI0wwuZokdEO4L2xYJQP/ovCRL8VmLl3ttD9sFcLsdDgohB5wkqoi5dCo92VNNZJDdqKU=
Received: from TY4PR01CA0085.jpnprd01.prod.outlook.com (2603:1096:405:36c::8)
 by TY4PR01MB12831.jpnprd01.prod.outlook.com (2603:1096:405:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:41 +0000
Received: from TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36c:cafe::67) by TY4PR01CA0085.outlook.office365.com
 (2603:1096:405:36c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF0000501F.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:41 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 372C030002A7;
	Fri, 11 Sep 2026 17:11:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/8] dmaengine: sh: rz_dmac: make error interrupt optional
Date: Fri, 11 Sep 2026 09:11:28 +0100
Message-ID: <20260911081132.11879-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF0000501F:EE_|TY4PR01MB12831:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e98b0455-bf3b-4256-3593-08df0fdc4fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	RjZ0qjqE6IETUN+S/0UHDv9UZ4VUKtfir6foWFKnI3xd/lTYvjp244U2BlJU8b8hdtIhYT8/Cyo0t/6XoOoCTIIC0DoMzgfoT5dqHgIQsLtQ9Tl2zMAzma3GhEfLvXu9Ah8iodzogR44AG7/HZmvpM8XBpcJ8GlIhRMKY+zQ6UMzHCvVpWskyVyeKXe9w570hDomWxGHmtGK0MyrKjQu6z4Bq9+QCQRkTl6Eph3RZacm+ljfzThanV//61xaaX1Qa7gCezzqm97BnBQ0nteqZQHbUIJEGbQZr8/Chf1JwUrorM0dCiA+5YijSxgPGXOmK72d7D0vuZ/iuT6tkpgwZV4LjfhrSJduTqNYI7LYKinDNKBwuSe56F1Efr5pVID6vopSe41H+pPvpr6v28/HmWYr5ZDrKtiMrh2RygX9e6jlyRvGz3zDQvUaSc5rLEVoHKbNXWgfj2/EIzTrx9O6uTuuPh3wmwfvN06/IwUszMhEAJZI6Svs1jTwpzJcfj3bkuy0v0VDk6e+S8fgjSuXIbO1wo6DEQ8+Sx9wEAefOyGHdEtV1JvshfA+CevV4mzKArzG2DXRkxQgzwO9b1HzKrpmmXzLKu9LmAa3p5r4Q1gaSHlsX2AgShymUH3VwgjGhehlJyYgWMzoRKddLoabQw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cb0u8JhC4SPblRAJ9P3XRi1qtpeIfJnH4BeOLGjikc6jLeMJxOcToY5PaHkeITMNFUEh69H6vyDpoWtNGf5CbSWzu2RF+CRnlwO1AYyfmZl6IPN8Z+UToA7Mg8X/dSrFunSzrxCUG/DfjQyh5XPm0vNadRKhVU1x6OCkM9M8ND7TG3mwo9pn7AM86LdAO2L2rOm39rSpX8ZsGbMKWo9EBVg8OU/mHUjljHm3Vhrtr2cIxpDR3J2WZGTZamjd8y3UB33wT9wxdZgLm9yf/HCefcQvXckAeqnyWEF7OmP2sdhwO0ZYVCfxrmp8ZNyJ2RJNAy8MEEcceb/nFg1SuvjdRZJqhj1y/dCnvx5v391pulhr3GDjhWlrrFgbCuXoUP9xMIZPfYvNOpzDqwJESNm8HtmtWNEGbjbJfLmJIsQMTrqMWDDVxAjzDygQsHwdkZVi
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:41.4882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98b0455-bf3b-4256-3593-08df0fdc4fc4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF0000501F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24122

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit b34f3fcae72a0afdd1a966fd68309b461bf678e6 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
an error interrupt for the DMACs, and the current driver implementation
does not make much use of it.

To prepare for adding support for these SoCs, do not error out if the
error interrupt is missing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260105114445.878262-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[PL: manually applied the changes.]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 52cfd31890947..2097c3033a567 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -987,18 +987,15 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	}
=20
 	/* Register interrupt handler for error */
-	irq =3D platform_get_irq_byname(pdev, irqname);
-	if (irq < 0) {
-		ret =3D irq;
-		goto err;
-	}
-
-	ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-			       irqname, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-			irq, ret);
-		goto err;
+	irq =3D platform_get_irq_byname_optional(pdev, irqname);
+	if (irq > 0) {
+		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+				       irqname, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+				irq, ret);
+			goto err;
+		}
 	}
=20
 	/* Register the DMAC as a DMA provider for DT. */
--=20
2.43.0


