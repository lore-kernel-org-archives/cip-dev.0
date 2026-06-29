Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043FC43602
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9690.1782773632765313963
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eWIFIJUa;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.49, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcw9dS2/x3dpwcayScjQFiRYTNWbuFlWYBqPbm9GANIEJZ+a9XgrfVc1v41ccnjfsLojy5nPpR0UL+z75WEPVCEQgEksZABiko85OTTVWmbRJXIhJWGYgJWqqJAUxmE4WKic5dUyMKzPzTrG6U8/ZzpCGPG8rfzSXwAygqmbOSct/r6uEWfXHOguyJT+CXEBLbvDKlXEDG3xMXuIK9SAork3d10466vso16Y825Gm/18l8melb61Wgw7IeBeHm7VDH+Udz2DkDCqpOVIDLmRHt7Ebok3ZceQ3cXE0JHVgUNhrHA7Uu5twbfZMd5+XUwR5u0SFRkegxyugM/NbkYftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZqLIoKvJ/mKxzXyCg4CNuRr1k+M+Ugsv0+1bYWZkes=;
 b=mJllzQp/le/OgaR2RrpKWmuxV8PA3SVczz/bMsfmJ/KckYCIGpQVw4zen93OTERxj5ITwxBl/+3FnMd3X5aXuPThO84QHMkXuzMkqdubgnKvjd1tgagCUgLnBLChFpRfXKFN+dkLvw1LDhtAHisipdHJv6DmHAX0bOdcH8VlYnxuV0N2qx7SO3xrYiQAAkBrOjuTfCzxbPoDmXbcez03qcPiNguKsUHJkGQewMZYphqSpAVMWujuobdXc/U9A86M8G/+KdTTZxYycrmdAKozmzYQTwNSajwyZng1CsklNpPeom9kgRMtwyhLh+Alk+uXjbENSPcB9NB916iGZJFdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZqLIoKvJ/mKxzXyCg4CNuRr1k+M+Ugsv0+1bYWZkes=;
 b=eWIFIJUaT+nFCCjcN9Ynro6qdbymVoOrmrst2cnC9186hW3FpHQTmpqhlBlEWnnbDrtd3o0vb2wOiINufJPtfGUQfnPsjg3HymHtCXqcIo0mHiCAqdyGTQzTSDNTSSxc0/J30omBx86KYH7MmmgPPfD2QEVX5+yqpSe4EOz6/Js=
Received: from OS3PR01CA0020.jpnprd01.prod.outlook.com (2603:1096:604:db::7)
 by TYVPR01MB11169.jpnprd01.prod.outlook.com (2603:1096:400:36b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:47 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:db:cafe::5d) by OS3PR01CA0020.outlook.office365.com
 (2603:1096:604:db::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:47 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 467C83000255;
	Tue, 30 Jun 2026 07:53:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/11] pinctrl: renesas: rzt2h: Fix invalid wait context
Date: Mon, 29 Jun 2026 23:53:28 +0100
Message-ID: <20260629225331.10023-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TYVPR01MB11169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ba2ad10-4bfb-4b99-b22f-08ded63147a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|6133799003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	iz3YFRZLiZ6yR4azM1yEGc3s5I3kMN1rQQkFnetTjyUrzNWrEctZ5WWAtD35cvyM6l7thPfZAFOAsCg0TXzO/s0jmN7/i1IiaxMCjotSKs75VlPpiyjwFJohQWh7Z+0h0FTSH5rwT9nhastXPLWOZyu+Em8gG+0LIU3QUAzvddH4gOw7d7cR3CnX4EAe8RUH3FUjs212VS7mVJSX6AvhJxRInZHdkRwepoExyK3rh8npckf00bplkvJEATtMzRslvEmdw4VqIH80BqWlqeazRdAavDI6yqa605ycRDb2482zISH6EAvLPPjIZAf1FPrxMITSTnYC2xt8G+WgNaylD1BqOarldVunu2LIG9inhCvyo0QeF8o2hH7b31ri+yWtig1AOrRyiAdWp0Eb7OaJ9X0rXWyPvRgzUH+fMBZzcs3g6mwVf3HYsP/5ILvaEd+lOktB9YSiJlH/rOTvf1AyOSUxJB3ncUUXUnsBPVDyh58fopM2ggNF4srWKMit3UkMldfYXGAgE6pNWVhlZOYDC9Peg7ZGkm6dhE9MVVZCT9cS6UoYL9a0qiElrqxmRJEeeCsZCVt7jV8SSjy8dwjKS4mue4whDrt/SM0NN5S1NSmIL8UUhiJ4ptOgXzQBaBiVhIvDiqxiarEzLw/pT0saAjzuEZZQPVyKJVCkRC5SI8Q=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	1cGJ7VhYP8c6uJz3an7c2fPiC7XhJoLm3AlsjrWi/1OrNa1k1zJpSOrzTMGurIle62iFK9BHiokgaBFEQUNvpO9QpSLeA9XB7Dl6l1VSxQ8PM/zJPHjo+E8GeQdsQZLhxEWstcZiwJfMGiK4JJWqhmDHeqBHy/dl9y3oN1kFAd1FZv1wDdPtSbLAU6Vlp11Sa8UUKtfwHd9zjbe/lfZ2t7KTAZOfGX4NZLsFjFtcerWP2Bt0i0tokc1wMEnE2HbV9QTJXKfP8qqEAk45IUCeG0GGEENSm2ccWlWfxIwS0MY3VicOQYpvbb775Iwu0j7UB9FpssyAZzv8yKsH8j65zMOLwH9LIC36bu0yJxa8yH3PFPs3lGSYVgvja9OnzDd5pCyNI5gJ4ls1kpOKaW3baYklTzf71JSj+Q5r8FeksMM2gBwxvJqLrMsTZ/idt2S/
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:47.6273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba2ad10-4bfb-4b99-b22f-08ded63147a4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11169
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23316

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


