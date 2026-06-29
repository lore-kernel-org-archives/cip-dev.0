Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6847C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9256.1782773626378706223
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wUrt/utO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.42, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcdKIV8Wtju1v/18saKPHjE05u8c/MynYzVBhB8wU2BenzlI3+t4ZMp5HOf3UTTwVWiW3lLJHc/lnXmi3sI5NBEyG7ua81yD9MQSB+faAyM/oE4++qljn8TvajAI835m8mJqyi80yxoL2cBxacUE8xS0cfgJpkppZhxFqzyN/TWXdI/gYGefwmeZ/TaVps2arRAcyvPvfICEJtZTnf04WcsmzGj4ZA2Kp9gA8VV+a3c8OnTfiUgJzCXXJHVW2EgDpGd1g6K1M9VmdOcf74XxXXnbIzHzjOzdGOzXhf9m4vNqGQL79YIhUkyedLx8kWdrCXgVMQhxe/6WTYSC3lzCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV4cT/BJMKCAGupKbkyxG/N4CWh8uG2zyElCfpKrIUM=;
 b=sL0b+/saxQ5hfWkJOFuwKZZ/wrSl4ssrqyRSsLASZSbHYOq0QnWcLYLGbsnMOid+xPilMm5Z5ytcuUyODexhzppRcjfzDbOsix3qUS3kdwrw2Ym1eUkOEyEuHuA9nl0AGl2cpUZj6tZKTmtWcv6tAErR6s9sOm1QZvKkhMT7+jxjpONJArJYZp8pD4zOWmzNxFlaWnHI0G5xOHPbXd4az1LBPhzSbexosIQOqDE8hglmMh1Z7Y3GcipuY4H6vIAy2Jezz0yIDZtk+wds3XcOnXBkYcahZa8RdBBA9p9C59ZikcFjrrvPYv1s9BKBslfF2s9yzbXXSPQqmGF+duUkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV4cT/BJMKCAGupKbkyxG/N4CWh8uG2zyElCfpKrIUM=;
 b=wUrt/utOcNd24TGJMDKc7D0IxhCGLEdIfRNi/OodjHeXgTi1LB3Js2sx9S5FbN/ASmKj0VGfrVQ07Ds4FBgjD5S4swzglcFAlqGProykpxWTseLxYzmJqo4RpU80MfGkA/oO0cms3vK9AX7NRJy0ZCrszeUz3+U5hjtekzCwvmM=
Received: from OSTPR01CA0016.jpnprd01.prod.outlook.com (2603:1096:604:221::8)
 by TYYPR01MB13152.jpnprd01.prod.outlook.com (2603:1096:405:162::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:42 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:221:cafe::7f) by OSTPR01CA0016.outlook.office365.com
 (2603:1096:604:221::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:42 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 469513000255;
	Tue, 30 Jun 2026 07:53:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/11] pinctrl: renesas: rzt2h: Allow .get_direction() for IRQ function GPIOs
Date: Mon, 29 Jun 2026 23:53:25 +0100
Message-ID: <20260629225331.10023-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|TYYPR01MB13152:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b926fce1-4e19-40ee-f4b2-08ded63144a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|11063799006|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	JnUgvRAz+bCYnOcHJjo9E7bDJWu4tO4L/5PvX6pYdN4PpRjuWvKlAnUMftS15mwmzzA6+Ecm1I/crz4TMuaBJJiTZhzfV15sGKIXXfkKVH5Bk+P8G0Z4QLui7cxHe5WJ7FYjF6LkW0Mhnozk4S+40b2nGOulPeQMCngQ01hTw2jyBLs1CMG0ODR+rDH9hgixafDPIa5doLiBAGgSqcnkP3MJ/Jve2l0fw2sgTwtLJ8qWmeSetCiA7CbbjboK+4WwyfA2/7DTVwsr+I/aUCvFgFByW00/aKias8aCzcLbqWvKf7hFKPwQedGxEhvxSzitTSjFffEREtqNxbil/7/8nDHql/pplUSxuuqcszVNfDGTUcvJw6ZE+Y4CAplSpXk92hOs8H4uSda14k6/kMW7bnJ/3VQEYOKj4J/lgf2cNfUDYTkOktXttyaygGlkZzqnXwXXglO7mGnPawJ74SJOpsQ7afZzmXH1BYOo3mcRxpQoiv+cvQAtAevWvYMzylnsUjzmuCbLr4Pddb1SjQpB/waNHRJ9iqaIML6a8AXhdXRpylSsRca8wKol1C6zboXXtjCh+IEqnMMhwAuq7G4Blbn46/iybGogHzDh7AQXuc5NBJQHiHHj5IKZ3WtC3lb54hftuESYM841r3TvD0m6XEm3MVPqYVfSKgaqu9KdDak=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ygSHZ3Xx/0nIwDAigP2K5B+YbEg2BKspU2lP8LdjkrDiv/O8n+M7gfGpKcdwy+ibhc5LMpfSGgFkJHo9K5niQSD5J6T/wVdR9kDKH9NCibRuX90ik6kZpYl7ZrnjjkFGT6eGyDHpl+aA2HmV0b0QdGvV2IAaXSmYFMV2xTRbvJPK6lwFSK9KOeMZy3RAAWbu/zb1lb5nCI8GVKfXup+nPbJSR1DIHRa1PXzew1OneStV7o7KGgf4rW7LnQ9d4RH6tx/WHJgyjNpWt/MVsWYvLt5OQFGPJ1vt0YlvJYjM5e068S3oz5qTzvTBkZmr6qzxOfwTzcmrtb4uDSrm8q2nsg5Z1ZsXSWYFWd1mk/RXBPTQn1OHlKRKADUidbm+hpxD4r4fiWasezCRxAmQ7d/Z2JByYnzaMSNktRUkKq9hyf+kI6h+3Ah/PMuWrl0g6nDk
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:42.6097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b926fce1-4e19-40ee-f4b2-08ded63144a6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13152
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23312

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 49b039a61a314c18074c15a7047705399e1240e6 upstream.

Setting up an IRQ would normally be done in the .activate() and
.deactivate() ops of the IRQ domain, but for hierarchical IRQ domains
the .activate() and .deactivate() ops are overridden in the
gpiochip_hierarchy_setup_domain_ops() function.

As such, activating and deactivating need to be done in the .translate()
and .free() ops of the IRQ domain.

For RZ/T2H and RZ/N2H, interrupts go through the pin controller, into
the ICU, which level-translates them and forwards them to the GIC.

To use a GPIO as an interrupt it needs to be put into peripheral
function mode 0, which will connect it to the IRQ lines of the ICU.

The IRQ chip .child_to_parent_hwirq() callback is called as part of the
IRQ fwspec parsing logic (as part of irq_create_of_mapping()) which
happens before the IRQ is requested (as part of gpiochip_lock_as_irq()).

gpiochip_lock_as_irq() calls gpiod_get_direction() if the
.get_direction() callback is provided to ensure that the GPIO line is
set up as input.

In our case, IRQ function is separate from GPIO, and both cannot be true
at the same time.

Return GPIO_LINE_DIRECTION_IN even if pin is in IRQ function to allow
this setup to work.

Hold the spinlock to ensure atomicity between reading the PMC register
(which determines whether the pin is in GPIO mode or not) and reading
the function of the pin when it is not in GPIO mode.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251205150234.2958140-3-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 981a34dcc814e..f056e28f6a17e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -51,6 +51,7 @@
=20
 #define PFC_MASK		GENMASK_ULL(5, 0)
 #define PFC_PIN_MASK(pin)	(PFC_MASK << ((pin) * 8))
+#define PFC_FUNC_INTERRUPT	0
=20
 /*
  * Use 16 lower bits [15:0] for pin identifier
@@ -494,6 +495,7 @@ static int rzt2h_gpio_get_direction(struct gpio_chip *c=
hip, unsigned int offset)
 	struct rzt2h_pinctrl *pctrl =3D gpiochip_get_data(chip);
 	u8 port =3D RZT2H_PIN_ID_TO_PORT(offset);
 	u8 bit =3D RZT2H_PIN_ID_TO_PIN(offset);
+	u64 reg64;
 	u16 reg;
 	int ret;
=20
@@ -501,8 +503,25 @@ static int rzt2h_gpio_get_direction(struct gpio_chip *=
chip, unsigned int offset)
 	if (ret)
 		return ret;
=20
-	if (rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(bit))
+	guard(spinlock_irqsave)(&pctrl->lock);
+
+	if (rzt2h_pinctrl_readb(pctrl, port, PMC(port)) & BIT(bit)) {
+		/*
+		 * When a GPIO is being requested as an IRQ, the pinctrl
+		 * framework expects to be able to read the GPIO's direction.
+		 * IRQ function is separate from GPIO, and enabling it takes the
+		 * pin out of GPIO mode.
+		 * At this point, .child_to_parent_hwirq() has already been
+		 * called to enable the IRQ function.
+		 * Default to input direction for IRQ function.
+		 */
+		reg64 =3D rzt2h_pinctrl_readq(pctrl, port, PFC(port));
+		reg64 =3D (reg64 >> (bit * 8)) & PFC_MASK;
+		if (reg64 =3D=3D PFC_FUNC_INTERRUPT)
+			return GPIO_LINE_DIRECTION_IN;
+
 		return -EINVAL;
+	}
=20
 	reg =3D rzt2h_pinctrl_readw(pctrl, port, PM(port));
 	reg =3D (reg >> (bit * 2)) & PM_MASK;
--=20
2.43.0


