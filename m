Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F5AC88E54
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34788.1789114306923775760
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HsoWL3Tm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlOma6k4kvhAlwB6tNXZxdwlUTzSJ+cTM6qpb6jP4nkGsFgbCm8eY0tdm6SCVA+gpMEmQ4nD96A73JKL9M05u/oBa0oqxpPLdIM+x7+1FVJBRriknj5W34dQ0OiplU7w/TdIynH/mS6jNJUsALjTh2ORw2R4iCPirgzguRaPTMAScQlkfW9w4wPpd9PpoYfrGGQvicq4VyXPDEnSDcmhOC/feQSfzhi8tjsflk0IAiS1vMK6yxu5xx39KeXUCm4Mbuvm1auqbzuulG0Hc8bZNFIH+tJbYPJVS2bjO+l4so9J08HNACPg1OW7APpv2EUEdEUgVe0Ay6Ot9crmToGCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8cuDd+JH34X1q2UMorFNQi46UR0wogG3Ca5Rx+CIdI=;
 b=cNNsqISdgu2MpW12SirTix0uoPvF3id+hHtLSjSD3kg53OS3cWjXXUeviMwRYeemZRG+7AVXUNSBQ1oH684+ArDxgGZgq8syh9GfYTW2G8Qmw9jy5jMYEi+G585CajAFIH6f83rVvcRXDb59SLrwEu9Nx45xNdH5QIZCzUJQucLVcPqrGrPf5QeYHyYJPCw2lmjCdGeIv8XnDkPlF8STcw6HVNLgdFp8VerYKg9WYfsEaCoBVYEhApIARwdnMKzxKWh13ubnlaFGk0pL3CHg76pgVQur32HRDeD9ZLbzzVpV/KFoGDaWG3uAIWV8GX1D+SM9DY1XtEkkGl4dy7TizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8cuDd+JH34X1q2UMorFNQi46UR0wogG3Ca5Rx+CIdI=;
 b=HsoWL3TmWMCcmRgrt7NSy45+rn4ibthaA9aoB4iJClkPi15s3fGdOHFD1Xyu0AFx1BcPcsjXQHOcXJLY8MqDmKEngy6vSdgvFaG73USIQIjRvfZv87W0VoVEgtdoSWPUBPrNWOVpe0cIXvu5kK+cDJWE3KTQsI0Gk3Ip9IJ03DE=
Received: from TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:7b::20)
 by TYYPR01MB16351.jpnprd01.prod.outlook.com (2603:1096:405:14c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:39 +0000
Received: from TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7b:cafe::a9) by TYCP301CA0082.outlook.office365.com
 (2603:1096:405:7b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005026.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:39 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8896F30002A7;
	Fri, 11 Sep 2026 17:11:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/8] dmaengine: sh: rz-dmac: fix device leak on probe failure
Date: Fri, 11 Sep 2026 09:11:27 +0100
Message-ID: <20260911081132.11879-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005026:EE_|TYYPR01MB16351:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08baff29-c8ee-4b4b-6227-08df0fdc4ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	mJh/FuQkl9be8DqJxLqROB0VOXW6BSwG3G04z5Uhk4IkViOSCM2Za7iWkDVHibjJk31dAd7fvbwQ1aYgJHIht2m7nKvdafOPYbrt6KsdvKq4VZpcg4IGUn0OjLcW/VR4WNhJ7pmkDcSqpBzVhmAvT6Ozs3cGckIIzIYQebEoZg7VRTjXCKS5Zpef78IF+D2WQDwqIvel/d93Wut53x/WuubhPSxcSUqB2mteoDWTPhHIF8dobeXWQ48c/R4OxvUPolFsQyM+Ltc0nom3ale7pao7TTJQo+UgbKt+4AAcHdQptnchcAiD0dTcgMbSjHYJFKN6ziENe+8KHNeHWGwhMuHLM86pYHtxFaYgNSKQwh2yf+R3xnoT2fJjPqmxCbQ9Nb1VJa8++xqVyPYDoD/uVK06CLWzsZUSurFjpuRBNrCV2uhSDaPtZiNZeGG+kj8+Q9TI6JTQFEkyM9cEoGLo5uSni3kCzeAm2buL1oxWREm05Hiz4r+W/TZTqAOycQ473PUT5mwVYceSJvWsgdezLkVw701QbniSwZe4u7YPYAJ1z/97sUWevTb+ViS7p5SDBjfoW+3osnf27cgn4io3RMq/bXqdTAC0TxfxQV84DfMD9kM6b2nBDM5eg5DQQrwJ5CJwqCfXtfbcJBDJRnsHkYvOETGSAr/3MUd8GWYQaHc=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	YuzzMzQqbsLPwggwB8zSDQWV7s8PSDsIQnAygD1Pbk1esDT5lllswikL/v9e+u8ZrM+34udipeiF3Rro1Hbb/UKWobs5PNf+6BKxRrp7hzi67a+2219/xV/wsrSHPBuJSX2P8tZeGOLHcpjuOqJxXPPu+4+U1RVentmERT1+kOdQHR+WKsf4is1fGUEY2PMowaEM0XHKDiTHvDHeD0yxPyIyMShrH8X7/rCjeLwU/IVrJPD7RgGDzxoUQGHuWSA9zr8gjX0GXyejNEz63tMwn5B1194YjjwmSy8Z65MaRqCzecygQEa+VX/y0I1PhGH8gANQ/z5uA0DqmKCUkAjaZkrgIooueiNA52MwC7vG4bRekD7PiGBSR4hsqYD3je0FmdYnpIjWlZOG+qXrsHYiO8Ty62RC6bXi/s7rGMTv73oSJ4E2E7K+Vp5BkO2SQmJr
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:39.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08baff29-c8ee-4b4b-6227-08df0fdc4ec9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005026.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16351
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24121

From: Johan Hovold <johan@kernel.org>

commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.

Make sure to drop the reference taken when looking up the ICU device
during probe also on probe failures (e.g. probe deferral).

Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
Cc: stable@vger.kernel.org	# 6.16
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://patch.msgid.link/20251117161258.10679-10-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index cfa6aca26ed24..52cfd31890947 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -863,6 +863,13 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return ret;
 }
=20
+static void rz_dmac_put_device(void *_dev)
+{
+	struct device *dev =3D _dev;
+
+	put_device(dev);
+}
+
 static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np =3D dev->of_node;
@@ -885,6 +892,10 @@ static int rz_dmac_parse_of_icu(struct device *dev, st=
ruct rz_dmac *dmac)
 		return -ENODEV;
 	}
=20
+	ret =3D devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pdev=
->dev);
+	if (ret)
+		return ret;
+
 	dmac_index =3D args.args[0];
 	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
 		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
@@ -1046,8 +1057,6 @@ static void rz_dmac_remove(struct platform_device *pd=
ev)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	platform_device_put(dmac->icu.pdev);
 }
=20
 static const struct of_device_id of_rz_dmac_match[] =3D {
--=20
2.43.0


