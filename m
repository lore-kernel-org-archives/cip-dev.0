Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA20C79FA1
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:52 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34548.1789114304335044402
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Prux+WeH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.2, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le79fv39mxxSSWBYDlFFWzHmw1mjC/gIW3xDFQySJgl690AbKcsOYotEBSC8h2RbcsW11Q8Q/tCehEP8Ou1GK2y8ViKFOoCBc1goh+3h2vFfFVJ+mleKxpX0LQjYtmaqKjmdH9gHQpsccxd2dOuXv7NucnADr3dLKdHFQcMtgcsFRZ+yG66AoxvyYdJfB+zqVjRlRrmzXRhYQ0rAhBqkUikAJl4cfEK2vJFXrWATf7xaTFFIB8Y0cNaVAZCA1QS5SVvGaQox/b6Xn8quPpjVwBwmHpiai+P1eq9284ojeuaTqzFDR+2L0lBAOj3yJmanAv9eLmUX3tKOpny5672hJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J242JnyXfPhQ0s7JaUMOHieK/UkTHm5HiJJe0/o3CUI=;
 b=pv2tgimexO8DtVbsjp9xnxX8BlS53TpUWOKhM/5nRr9TgF2+t0gDtBytxH6MvASXtoPPo76RZizEnVZt8vqQzl2R8a9uNuVn/kyP5z5/J69ndj5VL8oxJdLQTV/JcAeVHyJ8T6mON3znjGF7gShzD996SPw/nteSx0Uujy9AuOuqfSI8fRgd8+PZkbBerPlWc6isk+lARSHeVeHghMtXTQzd7Vpp8zNLLzkpl4UhO9mOkGFWOoYZmo3yfJ0p0JSSA8s0qpGZIz+WE4q4INII5TuDMR8D0Bp9PRTtR8kFnivlp3rsSOueVGYbPIBXaVXg0i81fKyXPpU/fUGozr06Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J242JnyXfPhQ0s7JaUMOHieK/UkTHm5HiJJe0/o3CUI=;
 b=Prux+WeHZszebsMI+U7SB5d6qiSI7APT2/TG+3+iVYSTvDBtrP8oT1V/P1RcToPpqb+Ivhoe3ZB1dY9rfvLHzoL5QSvKi9jv+gdadnItY+ApCIMiT5rOxEV603ovJ1V6fYksnfu5G09tgD6JTIzmDC9ogpX7UBaioT6GR0gl+ik=
Received: from OS0P286CA0157.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:16a::18)
 by TYCPR01MB10962.jpnprd01.prod.outlook.com (2603:1096:400:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:38 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:16a:cafe::2e) by OS0P286CA0157.outlook.office365.com
 (2603:1096:604:16a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:38 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D8BF830002A7;
	Fri, 11 Sep 2026 17:11:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/8] dmaengine: sh: rz-dmac: add r7s72100 support
Date: Fri, 11 Sep 2026 09:11:26 +0100
Message-ID: <20260911081132.11879-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYCPR01MB10962:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed1fd3b0-3139-4af8-b044-08df0fdc4dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|56012099006|13003099007|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	SR/vV7eKiowpUhHCQJYUznapJ9+NGrTIKkS/17vboAhnXh9XTY2mjxP+kFf/8oizQrdIRlfah7xlZtKivJxBdetvjvZwizsXmBF5aMMNkUEF3q8snbf4abPhB/heedJfyqLBe7KEJhmd1qxySV7M6dwRnbEYbuJ+M9YgbMWfEK/DIbw4b0/KLwS7iwvT9DLsSmNPvb6ng93YX1pNB7yO8hCQ7EjEu4DBAYdsSkkeWTOd7fNZaaraMVAjxwZ737e1D6RAzCwSw3Zy3LSIamTD4p1bxTrXV+GL66YlCy3YOwvTzc2i/kxFyG+5tPxhxmo+EegDO5uxcnbM6YblI89bhjcw/vcALEXU+3wjaklHsybBylzYw4T4AJa91/evhpHrP7L1mh/BWCknAtf5z8InWrd1+hlbB012KqXEqDcMOmriNuOja+0peGRdVrP/09SKWXUqum3/HjCy/9rdPJowp3DfePy3Iz+7RRgMElr0EOqjwGxOGlgW9Mr8q3GRpPBWkt7R4pcc7RO7rAmJSzBOA8GKXv7nVa5n/cyZIK6/Rjf5F8wdVpr11/tVWSYahWIw/vhEauI4xcAp4twjAocMyHHMVBiVdvSHaXaD0Ozpp/V2y+wQbwg2GPDSaIo+y0BE14+eb4Bml/xTvD1b4QIs2CN0SS9zvjg128d6ukZzzEE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(56012099006)(13003099007)(11063799006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Cm4Vl1mjUv1zRi2vkPo2j/JvfA/YvxoSj2+HARpqvA+2hfIe0TYe8GLVTAGEvRAzK+4Js4+XsqcuXUpLV7eMroZwK4pUgirO/z+NWuUT8LEjP9o0xV2pyPTFXSntcvKlL8CmeZdlgpgaqOqM/R0VIb0l2FrvxsxDGdWPfNGMDuXyrKYUXw+odIUeuIXHv76Hg+65G3GMpBX+Vtn4i2lAaGP64nI/dNz04XsuSglV+vjejm+OvNy3TF4nYPnHI1RyU/pjlrHgehiUZF10MQd79KFEbHqvDFxsg3F7+9Um/BOeGhgFwa7kLZcDL5kKabONcVVL4E41IDeZ7YggedjtZTQnntuznVaokDaZGgFFMOjHWTwgk0GxqMEhotlWEwCoPZuYHnui3Nmzu10a/auMG2pPWeisjIseC1Prd3h6A+FpaYmiaXrjk3zvbg2IH1S7
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:38.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1fd3b0-3139-4af8-b044-08df0fdc4dd5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10962
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24120

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 32172b3e3265833a367e41842fa8b7eaa0acae96 upstream.

This SoC needs to make getting resets optional. Descriptions are
reworded to be more generic.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241007110200.43166-8-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[PL: dropped kconfig changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 652b0f51d9e97..cfa6aca26ed24 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -953,7 +953,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
=20
-	dmac->rstc =3D devm_reset_control_array_get_exclusive(&pdev->dev);
+	dmac->rstc =3D devm_reset_control_array_get_optional_exclusive(&pdev->dev=
);
 	if (IS_ERR(dmac->rstc))
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
--=20
2.43.0


