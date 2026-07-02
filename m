Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE0C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:20 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66271.1782987853443587790
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EwN4W26r;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.20, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkAkmTyVxZs1P8LX6tBTqvNgLf8xaY2laE5vMvHdeGxdSeGId8Mihb6KdUV27SSw8Bg3vZB990GANUN9b19s/g+Dy3/ubAK0MH22cujMly7psSE0CbD4dQlzjYIZQvww8ecDPx5ApP9PFlJq3o+7RlnXm4+ZDVm3PhNM+A76KnEtX1EqZ5JT3mshDJraNR2mPIGIIX/kCZVhslTXX04VNOePr2T0qMtG2MGLkyTga8sg13CRMDXLC3sYg6do1Y1kd4weKHf95fdcZz/6HqiqKooCpWUBh4Sd3fNZOmkJOFcMnG8Dyt/D2iVU3QtFn365GPVA9bIT3K5B61B/hkBXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaOzxuWUv4YX8SATs0EnJWIpPyXtBu8E1cA/ilB0qro=;
 b=MajoSLI70ANDSQy8iZD3Mdoi4Z910NStX7FdNvZufbQBP5LxI/GLCN/KpA/UWLQBdS6CcXNIi/27Rewq6bAujC6aPczTdpBzyFy9jfjXiS28/P7ipsm4M2SLRN1qylU1sRAwtxTYC7Ygq/+XP0bdW6P5EJvlS6xXuPmVU/kxWQhe0GeGvqXCLZh4/+gA5ulcmxZcdv9R5ZwWaw+lV/tjZVyXoIW64jmgxmrlTNwNO0nlyCmALgrg0zmEjAgc4UbYwrkhLZ1Gd5hC+HHscTT3R9G3i739YQh+zkuoULSMI0bGsV0ebivFtcj+9qbbvBzsducefP59oRE66MEjRLVmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaOzxuWUv4YX8SATs0EnJWIpPyXtBu8E1cA/ilB0qro=;
 b=EwN4W26rE7WXfl/FsITNii3VjAvgJnb6Rz4+MCtRAmQwvl9SgNwi1Yq4UMftA9U30I7iyadewNMy3YX+oj3WJ91XU9KhaBrOt+rkz3hcCWD7s6NV6pYLGUKloal3z1gmQXid09I7B4dg67aBGYa56NxsOUoun6Zt25EKizeavu0=
Received: from TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c7::7)
 by OS7PR01MB14573.jpnprd01.prod.outlook.com (2603:1096:604:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 10:24:08 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7:cafe::2e) by TYCP286CA0228.outlook.office365.com
 (2603:1096:400:3c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:08 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4A0BF300024B;
	Thu,  2 Jul 2026 19:24:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 06/10] pinctrl: renesas: rzt2h: Fix invalid wait context
Date: Thu,  2 Jul 2026 11:23:45 +0100
Message-ID: <20260702102349.23431-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OS7PR01MB14573:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 586d79b2-8b0a-4e75-a119-08ded8240d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|11063799006|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	XOhUBUq4EDoGQgl2NSoMRYYsrORA3Ar8QOsekspd7Gw41KGgmI79J09kGvSWR4sA/+O3XFlWO1JDoHQAQGiArL/kJY7MgHjLuaCfiFhyXEccKoGk1SEN0SgvOVa6i0UZUxW4C+mEhcEQ/OFw1hmr0G8PsP8PffuPIFzwbpvk9oIgBslwDiZFeIBPKFvgMUtSVAcukaLAmVPoVyWCHHbQGwS1YiofQPcNicgz2ezCj09u/c/Kv9UuQHy5K17Wi4JtSKEUEbeU1BH1vNatJrt+M7uCBHxQa/x4WGPsYmYEcZNJD6Mr3MAO65q5w7hZaCjQOJKoqKRCyCbwvreu1N097MPWXp/VmzCBfsiBWwLfwW0pRj6UfrnDUFHoTr7zX31RGPFmTLKTdawHtr9utj0GYTg3wZjNu5xUoIpFpKYHUCHsK+1e1yHj2BJwDNQiWH55UNX/YBh5M+w1RWcC3XAt+6kq229xhSVrUOnBuM1YC+kfDo0Z7O3YbkF4YmsaqWrQcLPjmX3UbFB9SM+b1V8/oL9Nqs7aYOPAXt/qyvwWhz6uhTF1FELsL1y4zaZbOC2k/JZgDw45S72sWHQuvCStgc9MwuyFMb9yo2Kfuy2D18xL+/dMElNEmwHp54ZARus5wdE6tJ6+PTlLuv7qmjs95teuFpTM2Y4MYHv8qMQxuXU=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(11063799006)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	EHddun9gmKtrlba8fcGp3ydMslOKJ83duaY/8+iJI2hDeQS17a8IV4bF2kgxBerFPMnlHoaOkWW9AJR+Hows/Kw/udjqPRyCRSviFFuCLFyDLbNRFFQlPj/2rqQuNpbOXzZapX/9uJ6rI8m1+I+wpss6xYFl3P1J2Uc+j/0j0NryZlYZsKEkw/7zHt8E7n/DWlBOEaqw8mcxyy3KnAzgcfhhgiRbvVqaOfCYpyIiXl3tfVYb+bDRTplwoDAaqmXBbjL2qJ3O3QTcelKwL/1yVcffn7oyGxeq6G1u06OxTdUFTjIFt1TWqtkCl/frq7byxx4maMVDfqb8jUFxTXEYtGLxFsy3sQF65iSwWxuymT/bWWUayz8Wmkd3PU4NP313m/b1CzB+qI8nb2uNLnQNESfJKIc29Is6dApETeFWjGU6VI42B7hHqtXkKY96C5J0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:08.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586d79b2-8b0a-4e75-a119-08ded8240d08
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14573
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23386

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit ebe7561e9b9203611cea72a764bc321ff308f737 upstream.

The rzt2h_gpio_get_direction() function is called from
gpiod_get_direction(), which ends up being used within the __setup_irq()
call stack when requesting an interrupt.

__setup_irq() holds a raw_spinlock_t with IRQs disabled, which creates
an atomic context. spinlock_t cannot be used within atomic context
when PREEMPT_RT is enabled, since it may become a sleeping lock.

An "[ BUG: Invalid wait context ]" splat is observed when running with
CONFIG_PROVE_LOCKING enabled, describing exactly the aforementioned call
stack.

__setup_irq() needs to hold a raw_spinlock_t with IRQs disabled to
serialize access against a concurrent hard interrupt.

Switch to raw_spinlock_t to fix this.

Fixes: 829dde3369a9 ("pinctrl: renesas: rzt2h: Add GPIO IRQ chip to handle =
interrupts")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260205103930.666051-1-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- No change
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 8dfdedeac23f2..9e583eeabdc7c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -85,7 +85,7 @@ struct rzt2h_pinctrl {
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
 	DECLARE_BITMAP(used_irqs, RZT2H_INTERRUPTS_NUM);
-	spinlock_t			lock; /* lock read/write registers */
+	raw_spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
 	bool				safety_port_enabled;
 	atomic_t			wakeup_path;
@@ -145,7 +145,7 @@ static void rzt2h_pinctrl_set_pfc_mode(struct rzt2h_pin=
ctrl *pctrl,
 	u64 reg64;
 	u16 reg16;
=20
-	guard(spinlock_irqsave)(&pctrl->lock);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
 	reg16 =3D rzt2h_pinctrl_readw(pctrl, port, PM(port));
@@ -474,7 +474,7 @@ static int rzt2h_gpio_request(struct gpio_chip *chip, u=
nsigned int offset)
 	if (ret)
 		return ret;
=20
-	guard(spinlock_irqsave)(&pctrl->lock);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
 	/* Select GPIO mode in PMC Register */
 	rzt2h_pinctrl_set_gpio_en(pctrl, port, bit, true);
@@ -487,7 +487,7 @@ static void rzt2h_gpio_set_direction(struct rzt2h_pinct=
rl *pctrl, u32 port,
 {
 	u16 reg;
=20
-	guard(spinlock_irqsave)(&pctrl->lock);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
 	reg =3D rzt2h_pinctrl_readw(pctrl, port, PM(port));
 	reg &=3D ~PM_PIN_MASK(bit);
@@ -509,7 +509,7 @@ static int rzt2h_gpio_get_direction(struct gpio_chip *c=
hip, unsigned int offset)
 	if (ret)
 		return ret;
=20
-	guard(spinlock_irqsave)(&pctrl->lock);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
 	if (rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(bit)) {
 		/*
@@ -547,7 +547,7 @@ static void rzt2h_gpio_set(struct gpio_chip *chip, unsi=
gned int offset,
 	u8 bit =3D RZT2H_PIN_ID_TO_PIN(offset);
 	u8 reg;
=20
-	guard(spinlock_irqsave)(&pctrl->lock);
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
=20
 	reg =3D rzt2h_pinctrl_readb(pctrl, port, P(port));
 	if (value)
@@ -963,7 +963,7 @@ static int rzt2h_pinctrl_probe(struct platform_device *=
pdev)
 	if (ret)
 		return ret;
=20
-	spin_lock_init(&pctrl->lock);
+	raw_spin_lock_init(&pctrl->lock);
 	mutex_init(&pctrl->mutex);
 	platform_set_drvdata(pdev, pctrl);
=20
--=20
2.43.0


