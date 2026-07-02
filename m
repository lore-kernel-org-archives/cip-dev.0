Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D74C43602
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.65747.1782987847891236121
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=U0gUv4Bc;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.44, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoEJnnVY4eb3G0lN8Y6SlZAkrJyRYNqSA56PPOknERSHCjFO0IfhZFJVV9znKsi+NchacZT512jwRqGZWbomR+cg2w+4JRzDNWI96XzuyTYzWqP518pX5WoPWQgKSn1zwMYQKy6tymzMzYqzsbtM4GKJrFeS3/ifmEKkY+aoDCaBCMMICsZeVZNNh8kBXkNNn2QlgB8Beop0d0hqP1Kp8f0ZnpZgC1nlztK2GFmZShLoqsYM8MQmLnm5czi1kRMvGg24AqCReUhFiTFRtHi3MV0lkuEchZeFByYhMz8kb3nKuDZ3pxU+TjznCL1CC1F1FHy8kmKKmolLLa5P8R98Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZu3ueC6zkxRkcP0q0XGPWLRMKnjhHPFeMmkt5bG/fI=;
 b=VNLgBlx3qVsLbXFzlGPmPu+7Tn6ff6hYOrI2ewvQhDIDg7cc/WJyLW3D0FVaJVfQwn6Vgqx2GDvqCYsFiJ16wd9EVE3KG3LbS3YvKEeHHvFRlALSJPEjl+/B0Advu2nD7KVyttfU3l8hbThISt6p13WuoEdMjX1xOGYOMTLzvZWeBBBg1C4+8p5wSd7gS3yhiTJg8S+7ywDilSmdlPx5EOerT6wp0Hd0qq6voR5xM70CK054UYMJTVsOI6olIyCYwnEkg1Bf2W0sgWpvstzVG9KTaq6EHQWSsyrR+Z+4YJh6tVYTf/Hs7Fng7f7m5oh+uHtm/EC47y7s/J/x65Vq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZu3ueC6zkxRkcP0q0XGPWLRMKnjhHPFeMmkt5bG/fI=;
 b=U0gUv4BcSZTP9nbcpRNgqWpUEH8Olt0WbVY1GvsoH+JYgkc5GDKBqK6lJ0dXwYn8SB/UTRegdFEjr+60emImbdoW3ZNCuFs2Lz/sllRqRpBAIjWIVvTOLvDlkAI1F1HnbI1qKYnxLBnAolWR8xjZ+MUpRDzqYtES2Kn3MI+EGk4=
Received: from TYCP286CA0205.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::9)
 by TY3PR01MB12069.jpnprd01.prod.outlook.com (2603:1096:400:3d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:24:00 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385:cafe::1b) by TYCP286CA0205.outlook.office365.com
 (2603:1096:400:385::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:00 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id CA781300024B;
	Thu,  2 Jul 2026 19:23:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 03/10] pinctrl: renesas: rzt2h: Allow .get_direction() for IRQ function GPIOs
Date: Thu,  2 Jul 2026 11:23:42 +0100
Message-ID: <20260702102349.23431-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|TY3PR01MB12069:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d826fe94-82a0-45c9-d41e-08ded8240894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	xL3/6b8OWIWFN8hAXEv2H8R+iTtOmvTHWpQntpYiiBXo8GhhBaLxRtHkqe2+YVq7Qyd1sRy0rQFM/fntKPjDbFgDEL9oU6/k3DPGKZUmcOuyWlbYIgDbfRe9UZo//RyZVsyWumQqsGlPiFQIPUPi6HkssibFMS+APXg9Dh9Q15QQWsArx3ZAWEAhiAqm87IPik/BCJW1yXCi0D+QrSMcjnMwJygSFZvwKhSKaZALHW4cOpBdl5D9t/NPDc3ksT1gBd2H1K1yuAyyDJPJ7x5fBdikPCZgbDXoZI6MMPa+UOQ6nc4vhgxwU3l7qesxjVn3MSPeyQdmX1iTdEdy5UF1g8sjjj8NBl2x/ya66Prs7LDZn3qexOgRLoHU+TBs0qUyxb/zqKayqnOSmaTfh5B8KORMoOtATQCIoIXxp2s8FdReIFpolPT5B6/3U5YUkvqB28s2L0v7dhY2Xiu7JzBWCtPqkAD99tpJi/1JAciKbkP82Ne1aUEWUbhz9q7mZ/egloO0lgZetSXyGu4rUSETh8k2BA0N/gLh282irjnEflxqVne8LT0WmM6MwztRU3uksNSffFO5tAzWCy3GDa3X9xixkAOdAiMNyAOZMVJ2E8WubLdiwVMF1uIRucGYvt3ccbQgKAEXqenYM1qdY6ZpbVy56wkxdDP4FBWV/BCPwuE=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	LoXUuropuH3YCH69cJHzWxCiu1xxFgaYRXDCV3IFep1C4Gjbfp8pyieu13pX6RQ5FHZ7pRDqCy8m3eM3/o6Zdu1Bn4puuyi9oDwOFKkjyCtDcaYEXH/MttmiAYD5aVwua0BxFuhW6lUV3TwBZ7zg0b+p7TIKQJQFLRqdoyPqxYnzUqcqxacHAW3T5QzGlcOz14f7Qdbs82w8Gll4ob8+OrsB1OQSHo3zgTPXhxOXOy40VNFCMHO50zA5PUb4kqeWUzcs6OGpEXV4/0bL+d5a2epJCAUcvlNFh5v5G7RdL6UtXiHBY8m0+ua2ydfi32GxDZak1oD1/lIzjdA0zzP+LzaZl5/JewpjlT7CwLPXeWypHFZrfGDTA9G1SCjZajapDcGbnthVqHeyWSCKv+cQzEq5iucbbvt+YcVL4UiqBUaTYknE6h1sk1EO2Hmmq3np
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:00.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d826fe94-82a0-45c9-d41e-08ded8240894
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12069
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23384

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
v1->v2
- No change
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


