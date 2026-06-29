Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97061C44500
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9257.1782773627120480367
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XriZ7DwC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.58, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAAFIVBsZDyPk6WS26/SHZxHSn+51DF11pv3eUzjoRNI00gQI1jGXb678uUiGudgn/+BNEwhwXWLD8NDUhRad7ESmJfuJZ8X0E/1w5TAP9ANmMwaFTrHEeb4J2t0/ipDtPyKmyYPKWwr/Vsr9Kf2BWDL++ljMnBwWM9X35HlxLgSZihyarWpPNGWxvvod/za2Kcf94Q4YsrWxT57OIZtRhLouwkwww/KeUrI0TYZ1rJ7Vn3V2vVELYvnfe7E6qa7Uw2775zO25NRBjF62ZciIdNQj4ssHYyn7xZqdPq7eqUetADlVvLqqBt2xvpHnygvL6ol8Z+Dzg6/Dx8O1M+Y1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTk/D3XvKRPUtnbXV2zIoBpvBCKBxq01BBdiCj9kRyk=;
 b=cZ+wCGbwbe0oDobU9lHVN4iiVsTNQv7jJgBNh0LWgUnUj3XRWFn3yP+0/3AlaCVTM+RQXpIG0wHvdW1lm2XFdfT9mJK8jhzR1K4KtQt+BH1XIGoveeyPI91Qnh5dFf1P42KDIv2TSEiGH7JZ+Y37JpwwB3tLcDVDqQdfIImYQKHRKLgxagRRDbDdAz/ELZTfhBZ40AFAsWhoZfquvT/XVF3y8jMaFJZsCfDoRgynr6ZfSOT3O8p26tj2mgZyuMc13o7P/KbeP+UrbUQ/yKb42vJc5V3WiFGKab8F5hP69ot/ZqsLq8kCcWgqp3fe0EGrnlZIGI7e++kMUZgxbWxHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTk/D3XvKRPUtnbXV2zIoBpvBCKBxq01BBdiCj9kRyk=;
 b=XriZ7DwCeXzDa7+c0puhne1E3U6jMaDAy7EYd6INRbF7MkoSSCQp9sZpDJEx5E392E4WU9yh6XOUU/ClaqnEF6AvMNdURtwD7IHJ3WF6V+SkEn/UlWowmhX89j7ZX9O44nEnHtryTx/8hE/KrO19TMvutTpTPoSHw/D01FsMs1E=
Received: from OS0PR01CA0054.jpnprd01.prod.outlook.com (2603:1096:604:98::25)
 by OSZPR01MB8124.jpnprd01.prod.outlook.com (2603:1096:604:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:41 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:98:cafe::11) by OS0PR01CA0054.outlook.office365.com
 (2603:1096:604:98::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:40 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 97EC33000256;
	Tue, 30 Jun 2026 07:53:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/11] pinctrl: renesas: rzt2h: Move GPIO enable/disable into separate function
Date: Mon, 29 Jun 2026 23:53:24 +0100
Message-ID: <20260629225331.10023-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OSZPR01MB8124:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e389a7e5-3933-420d-6de3-08ded63143ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	kPzgfFHIWXvN6bM9QAsGL9TQseHn4gklhr01opH4fHaBuQVqtG8txNLibwTYKebPSQKNDxay4CBUwWmJ5wtAq0/23nyDjgfNry3ynKUm4dxLY8gy5C8jdBZN0hcM9D4BCc/iahYppDA/4ouMWdmp0UBqCmlTiIeF0RIcE5QSgfC9BXaEOfkLRXEilQkgf2RmDHZ/i8OCWykb7jP0Ym604Mu/XnWBKVqnFnN8UsMDZwRZUrfwV2hrFzLZ7L/GUlwpnxCSDMo1Xl12d3xOKes3rD7/o4XQimdnnwt/tzdNVHjxpOuD7SmefvWgqlghnk4z0D+ev+TXiAApC2oI8f7Ra0hXiRQ2r6qsEnIoXa871ZLv4U9Da2SBKWvDAR+RjVD93VFvgtis8NEMtEa38uooiLUDwsSw7mSUibuaD9hcgJVOg8/W0Gq/FUCYEbRQ51WCtYjqm/bHdNEf+yTajqNVVPs1F8n9h/HQNievzOFEo2ky0ltma7qo9+JuQliOD1vqkFwILysYpw+blmo0gRZl/awvpKIObC2EaedQNzqzWOpWf8x5/fNU+G3QJiENdhYwi8US1brTpZnYJUzSf+I0PrOse1Y4lM7CJeKgkKM43KUQrNFlGlzxyL+URGpNtXAMlS+Hu2AUZntuCIwS5a5P5N+no2IfOYKcNd1RlYEHUpw=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	BpdykyRSrji9MKdsoPPj0j0xg0G+7r/nnoL0KddliXoBcdV2XEfwqin0KnJiOSp6PivnaovbrnDrv9mqY/HRfo7fC5MMaHblgIyYnG2Jx7BbFw0L6nV/7nHfdykiUC2EZOsDeCZLfTcCorDKlifWH63m8HnXeMv19DJFFEyjp02cc9Z9VJNTVwNFLLbO8cIw/Qpr3qsM3nlNaxWqgV7aZGU6kGKDm6edV5iIjk8vg3yM+OjAr6eHf5wB3M47AFAaacqfPnzv65xRFi7xVujcvy4oJLyGy4YXTMz/F7H5LdH4tBcNf1a0b/2u8ui1FJP+Y5ha+Fw0TEZhbwebLvhZzDYbpKc4PZMHVKm1Tn102QMzBHPt62FQBj42/IsrnaShJV3pqno2qanQyXKJOKBGR1/mPECW42mg4FhM3sXv08fwUQbBME27WkUeoylKTEcc
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:40.9764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e389a7e5-3933-420d-6de3-08ded63143ae
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23313

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit ba4a92372bea29aa2f0294a215e04ff77d98cbe7 upstream.

GPIO is enabled or disabled in multiple places, simplify code by moving
this logic into a separate function.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-2-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 63c49e813fc15..981a34dcc814e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -119,6 +119,19 @@ static int rzt2h_validate_pin(struct rzt2h_pinctrl *pc=
trl, unsigned int offset)
 	return (pincfg & BIT(pin)) ? 0 : -EINVAL;
 }
=20
+static void rzt2h_pinctrl_set_gpio_en(struct rzt2h_pinctrl *pctrl,
+				      u8 port, u8 pin, bool en)
+{
+	u8 reg =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
+
+	if (en)
+		reg &=3D ~BIT(pin);
+	else
+		reg |=3D BIT(pin);
+
+	rzt2h_pinctrl_writeb(pctrl, port, reg, PMC(port));
+}
+
 static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pinctrl *pctrl,
 				       u8 port, u8 pin, u8 func)
 {
@@ -133,8 +146,7 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	rzt2h_pinctrl_writew(pctrl, port, reg16, PM(port));
=20
 	/* Temporarily switch to GPIO mode with PMC register */
-	reg16 =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
-	rzt2h_pinctrl_writeb(pctrl, port, reg16 & ~BIT(pin), PMC(port));
+	rzt2h_pinctrl_set_gpio_en(pctrl, port, pin, true);
=20
 	/* Select Pin function mode with PFC register */
 	reg64 =3D rzt2h_pinctrl_readq(pctrl, port, PFC(port));
@@ -142,8 +154,7 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	rzt2h_pinctrl_writeq(pctrl, port, reg64 | ((u64)func << (pin * 8)), PFC(p=
ort));
=20
 	/* Switch to Peripheral pin function with PMC register */
-	reg16 =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
-	rzt2h_pinctrl_writeb(pctrl, port, reg16 | BIT(pin), PMC(port));
+	rzt2h_pinctrl_set_gpio_en(pctrl, port, pin, false);
 }
=20
 static int rzt2h_pinctrl_set_mux(struct pinctrl_dev *pctldev,
@@ -447,7 +458,6 @@ static int rzt2h_gpio_request(struct gpio_chip *chip, u=
nsigned int offset)
 	u8 port =3D RZT2H_PIN_ID_TO_PORT(offset);
 	u8 bit =3D RZT2H_PIN_ID_TO_PIN(offset);
 	int ret;
-	u8 reg;
=20
 	ret =3D rzt2h_validate_pin(pctrl, offset);
 	if (ret)
@@ -460,9 +470,7 @@ static int rzt2h_gpio_request(struct gpio_chip *chip, u=
nsigned int offset)
 	guard(spinlock_irqsave)(&pctrl->lock);
=20
 	/* Select GPIO mode in PMC Register */
-	reg =3D rzt2h_pinctrl_readb(pctrl, port, PMC(port));
-	reg &=3D ~BIT(bit);
-	rzt2h_pinctrl_writeb(pctrl, port, reg, PMC(port));
+	rzt2h_pinctrl_set_gpio_en(pctrl, port, bit, true);
=20
 	return 0;
 }
--=20
2.43.0


