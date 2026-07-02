Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EBFC44501
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66264.1782987844516718900
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cC/1IqpQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.5, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDNbgHVqxw/VjqwOLCRZetm/9D0d6csMQI1Kl/lzFzW/ujsIPS81sJpmhy0lTHEzdOssiVifm1EqJ0QZ1Z2zV20IN2dRqpcHIlc/mwivDm6ueQtcfRhIWgxF/wxFDiJ+tYyx+/641crB0qHmQsi+5umH7wZb7eSdPFZpO+B8nvyfmEvYhRRNeAGO4LFnLbZqp1S2bZBUPFx1HSG7qk/b04U0b6xv1fIMtTBems8zxQfhL0OyHo1L+JY9ZLpMWZec7hAUs7RvEbSAEa6xtRjwmvRgfl2PbREcFCNfVt4Jq69eUhiMFoCrwyF88N00ElXgRlFEmoinYZzMcq5jEboxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhSwlPX08DpWoA3vnmj2Lgl9RQBAOeRWRDjBcFN+g5U=;
 b=tefbEj6PqcDyDF89d983EyRZpLvsPWNVt9C7OWFI9NDLoN2GuyVbOvdiIY3BtWEhjAtpMUF6haRxzXKFrg7Gg9Pd3FTa3Nj4LKdz7SQXcmdqejfVYgQLCzRqtSClJWm11bXAa+3Ia5WsFmtpjzJYIFztedZ3qXjDGTGBOunt4TvQVy2jm9v1Hq+whzDsBYR66I5iQuebkkZhOn7V3Fbe8lj5BgcIPjMLqQzn9qM0zIBDNzNEaUjjeq3px+5q33AuZjP9p3PMqGDjvMX9NoQh1gpcsLQYinuUkCtAc4R9/kbxpOZ3URdKnUkOJzjFmUeSeBFPLxufLZqZFVxmyJNNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhSwlPX08DpWoA3vnmj2Lgl9RQBAOeRWRDjBcFN+g5U=;
 b=cC/1IqpQ/eCwFDPTWNjomWdmpZbqKQCmCgAuVywbVzlVb4B1c5kaBG1Q9agRFcpXMjbFUuPM289jGzOZNB2+yNaoUoyRJeKXRd0HYiLw3cXWf0KqVHTSnhRLQm41lOVplYImTXP2qXd/BaUfYBP9Jlf0lZNtBSQ5hvPmajGJWXY=
Received: from OS0P286CA0112.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:169::20)
 by TYYPR01MB6714.jpnprd01.prod.outlook.com (2603:1096:400:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 10:23:59 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169:cafe::54) by OS0P286CA0112.outlook.office365.com
 (2603:1096:604:169::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:23:58 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 543F3300024A;
	Thu,  2 Jul 2026 19:23:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 02/10] pinctrl: renesas: rzt2h: Move GPIO enable/disable into separate function
Date: Thu,  2 Jul 2026 11:23:41 +0100
Message-ID: <20260702102349.23431-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYYPR01MB6714:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e783dd01-7e69-4dd9-5f0d-08ded8240725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	i8IBZNzvCXjrTc5VDYX93gPrwtS5uoW7fGWYE5poj9fo5KghPkBnIdA+PLyjkfDQvB84IwbJMalcmDGu0Yg5FJaAs580rLTkoWGhZxYHDJc1XqNjdB/0gfBd9Bj++M7UofiegV/bdbgF/cEcxa05MEH78Bapqy6TlVgHnwHa558VakvjJ+Dg13vnCxEr+5sNKS3Ywp9CJKaxodcjSU6Mn/94xzexF/mKQgLk26gyhcTxh2l/10BNnWCko0S0Rqb7ub70Oww3pqujvDBuPwnm3c6UrxU/WELtLlzhUB34A4xXGHQD0CqBGhkjUZMXQ+PhKdi+r+NFfmuN2/RvbEZgnac2FeT1dZrpit10TeBZ7P9D3GkhV+YZfBpsJiO1XyPhpzmOfdERxVssQnU3hAJLCWozKMArxOe6gbxm3G+X2zKvkWNbEg6tMqxmS03oFnU/Bs+O90jIaIR8dJ0HBEOgB9FmWY9Y/KUlWEpZB8VihwMS8aCJ6f0bag345PE3+IInTwzG9cenrn44p46/gd9nJRvYKJeJgQPa9cYqHv3WiQ1YLNrFp2W9NDvTM2qomOsIIC2ph4aLQ+OObL1ZtqIErjrxS66+z4kli9+5NJh3vxlLCHvMUMZdxGMr+tfA7B1DVXAI3TVZEedLj/i5OKSbortSekMGXogEyC96ViwIh1w=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jU7mP4uMgGbEzNzzDarh+X1Otha4OoWLbOl5Le1YkVA6nKH1Md9z/ZRn9lvyr4mc4qP23xeErlBvKrlnZY1f418+60uHEqr6YrgkILsld2mDm1SX453EfRoSfprMO+HrlQKbddT5qhJv16lP7PwX3s3Q7oEWN+ADE/Pz3js59UW2xg+MQeOfUxnBmvGuOYi4xBlGjk80wx/8BS9LUpoEMd7sKPvyJujril8Csiq+dPhOE4cG6QOUWL4QIayOhiFmIxe28k/ErS8e9CoHlOJwDiNWjkgGpzLGvhnr9IC0HNc0/vANbc33F1pq1NGkS3GWgR6McV7aTUB16GYps3+lQACY/CCjWH4wBavewZXviGRMZDGsBjaxNGudgZE1zfyrkYH44FL277q8fzcT4GPXmuGaf9ALe+1c1Q3B3+53zdIn11rFSNueDQwYDyYk0TyA
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:23:58.2854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e783dd01-7e69-4dd9-5f0d-08ded8240725
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6714
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23383

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
v1->v2
- No change
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


