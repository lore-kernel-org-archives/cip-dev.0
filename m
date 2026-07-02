Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA9C43602
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 10:24:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.66275.1782987860322809129
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Jul 2026 03:24:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=njM5xOzA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.25, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPoveYUOXd51BXHVOPn2/XzR/RcASa8yx7xbQGc3Hq0qFLwJO86Zdjr0BAnYsLpBdocIxiRnYu2n29+b1AfnPoD50hMFesE+wbNMhEdvDYPtDHvImFVIR2ZGD4js2a4gS1VsTXNe9uKfntx7NgsFZIMF+74TU7hE8SKR3wGEU+BJykLHTfa3tPW0IysxLtoMlQrkWRVkeN3d3+HHNhS52uXTaRm/IO9pmtj6yNkxlQMAR4jcjMa+7UPeecfGX3JTG6bJtfwhU6VQIiy0TjCCEa3XBxMNOEgRYhclWtHg4PBDSRod7BbmPSJRk+mm8B8fkeE6uqIZb/95VkCwSDnRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfdrQeknW30KyC8q74ww8ko8dyHuRSkEmhRQR5w1y9o=;
 b=s0uHoqqrq6jLms6r5ruLDmYB3nn4dwI57KsT+3HlWXzE3EarxzYdRp1q2E+xM6YiNC0gt0+sJlB3FoaPMQ3UzfKo+oNgAjeu67jsvDmII/mZH7vjZkfl3oBAexq4qIEZb4xwtxezWdXcF4QqEXas7+2yvgTlKx4TXAetJTVN7+JKy1tzpD72zRw93RJEMplnNdKL6pySCyqEgU6jcExwFVLTXI4zaHqowf/S/Nou6Eu5F4NZSir6y1ggtDQlw/Io0vIsWu323sywAnS1LaYASxs6vE6Uwz6uhotTHTAB/qjZXZQ9/Y+z4kG+9nOGBtYB6hQzTYm8pkfMYvL3PL1vWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfdrQeknW30KyC8q74ww8ko8dyHuRSkEmhRQR5w1y9o=;
 b=njM5xOzAJINvLdwPT+0GI27M0kFuOWDe+hB96DBOrX8/XfFCRIGRbXCu6jlqit+xOh4MbPWhL3qH4gJVOEhSmhRuAOqkul+t9Cz2Sz8D+fkMHwy2SSPUthePo6yLFA/BcTmZvrSIGXHqpfSXclTdMBkQvh32BGcMaXJBFXHbo+0=
Received: from OSTP286CA0005.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:223::12)
 by TYYPR01MB12889.jpnprd01.prod.outlook.com (2603:1096:405:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 10:24:13 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223:cafe::45) by OSTP286CA0005.outlook.office365.com
 (2603:1096:604:223::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 2 Jul 2026 10:24:13 +0000
Received: from Ubuntu-22.. (gbr-5cg2250zyy.diasemi.com [10.24.0.18])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 46712300024D;
	Thu,  2 Jul 2026 19:24:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 08/10] pinctrl: renesas: rzt2h: Add pin configuration support
Date: Thu,  2 Jul 2026 11:23:47 +0100
Message-ID: <20260702102349.23431-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702102349.23431-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TYYPR01MB12889:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6b761a3c-2f8d-4322-c6e3-08ded8241022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	jBRBSRENjI/DCa37b+OQzLCQ+ewWid1cUsxBuyElpV12Kl0RAfSTrcFnokuJ33064ME8J6abK+7r4YPmpX5ebemL6vwEyVphRh4F2jYr7KUPVGRy881qml5RHvyu1TI4zXczDZbFC3v9Ma1DiV+MNpditzGvdqDABSDxVuoY6/ZlDtARZXU1aUyZAMy3vLtcUy8dq+prmA0uxJDNvBgEPcaUSWnQ7lqTs8anoNwUFyA9VoJD1KmKj6EMfzEoXJWX0+fuixic2ybRd6L4zgESqUsgDHlC1rioc/7Eia+kSKvfZL36eME+O0bNBw3q1S+SOrw/w+7fPX8s7IJPUDgM3Is2+cCTHq5ZoySyd5mSnU84nrowCGUdPmCGHwepNd1McjOabISHyalQMkO8zUpBPSHzQqiv5A5PZNThB7CosRyZEg2dxVP32LdVE9wbdqDSbvWHnYlXdJ20QlEJv3phhk618V6lXRqo7KFVgrWbh50HEPK4Ukebv1p5TPBPmI9T6H7t4b74sQ9UAGdhr1AI3Uxr0Z06CUtSEv+SHhsEO+I6yYYldmj495SMZsQeCxBiL9pVyPPXy3HwYqDxvAC0NMpep7GgI4tQNM/ZBl2GCnWMS/sGCb1VJLXUH0js78UELy03lOjUvGOPXw9bl62d4qdz5nm2LAXjevoGIM47+Zs=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+sZTbTnNsDHymLWqc/LwP4Tq9954nMA13HinL0CWvjqNOV/Xbiy3z30Ln2elPOUMtSMqxWIo9uvepIy/IJNr2R5GnVzt+jrXOaG8WHp0lEAKTUDwImxezf8HyuXJc3BjLH8kDJNReqouff5PayiZ5OwSyijTxJeyWo5x4JBRhruDyIAz5ToW7bL3YLLiAzTWHEJsyUw1zfUszG5hHntkbU+vGe/UT19kTPS855qRMADrYHw7qZCJSMsNugcz1rCZbtDJApTTbUSiYYqDjOc2ZDUBPaYY5VyhmluihwWbiFv5RAJvG4n3GOFiD0V6rSe0Xx9Rgut5Z/VL2QR7/QMWT6nzvp6rPradLgZXJ2pdkWgvnPUdjaahVHmkaW6ZXXal6WpK85GYDwxWLFcthbIHsPcXR0sUS/9/qaDKek0cwapdcNwWulSQQm+Q5TkWuq4o
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:24:13.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b761a3c-2f8d-4322-c6e3-08ded8241022
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Jul 2026 10:24:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23389

commit 494feecd60e876a4310cdda279d918e91f930091 upstream.

Add pin configuration support for the Renesas RZ/T2H SoC. The RZ/T2H SoC
allows configuring several electrical characteristics through the DRCTLm
(I/O Buffer Function Switching) registers. These registers control bias
configuration, Schmitt trigger input, output slew rate, and drive
strength.

Implement pinconf_ops to allow reading and updating these properties
through the generic pin configuration framework. The implementation
supports bias-disable, bias-pull-up, bias-pull-down,
input-schmitt-enable, slew-rate, and drive-strength-microamp.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260319141515.2053556-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: added non-constant versions of field_prep/field_get macros]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Added field_prep/field_get macros
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 276 ++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 9e583eeabdc7c..b754d4d725e86 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2025 Renesas Electronics Corporation.
  */
=20
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bits.h>
@@ -43,6 +44,7 @@
 #define PMC(m)		(0x400 + (m))
 #define PFC(m)		(0x600 + 8 * (m))
 #define PIN(m)		(0x800 + (m))
+#define DRCTL(n)	(0xa00 + 8 * (n))
 #define RSELP(m)	(0xc00 + (m))
=20
 #define PM_MASK			GENMASK(1, 0)
@@ -54,6 +56,15 @@
 #define PFC_PIN_MASK(pin)	(PFC_MASK << ((pin) * 8))
 #define PFC_FUNC_INTERRUPT	0
=20
+#define DRCTL_DRV_PIN_MASK(pin)	(GENMASK_ULL(1, 0) << ((pin) * 8))
+#define DRCTL_PUD_PIN_MASK(pin)	(GENMASK_ULL(3, 2) << ((pin) * 8))
+#define DRCTL_SMT_PIN_MASK(pin)	(BIT_ULL(4) << ((pin) * 8))
+#define DRCTL_SR_PIN_MASK(pin)	(BIT_ULL(5) << ((pin) * 8))
+
+#define DRCTL_PUD_NONE		0
+#define DRCTL_PUD_PULL_UP	1
+#define DRCTL_PUD_PULL_DOWN	2
+
 /*
  * Use 16 lower bits [15:0] for pin identifier
  * Use 8 higher bits [23:16] for pin mux function
@@ -69,6 +80,24 @@
 #define RZT2H_INTERRUPTS_START		16
 #define RZT2H_INTERRUPTS_NUM		17
=20
+#define field_prep(mask, val)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __val =3D (val);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;				\
+	})
+
+#define field_get(mask, reg)						\
+	({								\
+		__auto_type __mask =3D (mask);				\
+		typeof(__mask) __reg =3D  (reg);				\
+		unsigned int __shift =3D BITS_PER_TYPE(__mask) <=3D 32 ?	\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;				\
+	})
+
 struct rzt2h_pinctrl_data {
 	unsigned int n_port_pins;
 	const u8 *port_pin_configs;
@@ -91,6 +120,8 @@ struct rzt2h_pinctrl {
 	atomic_t			wakeup_path;
 };
=20
+static const unsigned int rzt2h_drive_strength_ua[] =3D { 2500, 5000, 9000=
, 11800 };
+
 #define RZT2H_GET_BASE(pctrl, port) \
 	((port) > RZT2H_MAX_SAFETY_PORTS ? (pctrl)->base0 : (pctrl)->base1)
=20
@@ -110,6 +141,37 @@ RZT2H_PINCTRL_REG_ACCESS(b, u8)
 RZT2H_PINCTRL_REG_ACCESS(w, u16)
 RZT2H_PINCTRL_REG_ACCESS(q, u64)
=20
+static int rzt2h_drive_strength_ua_to_idx(unsigned int ua)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(rzt2h_drive_strength_ua); i++) {
+		if (rzt2h_drive_strength_ua[i] =3D=3D ua)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int rzt2h_drive_strength_idx_to_ua(unsigned int idx)
+{
+	if (idx >=3D ARRAY_SIZE(rzt2h_drive_strength_ua))
+		return -EINVAL;
+
+	return rzt2h_drive_strength_ua[idx];
+}
+
+static void rzt2h_pinctrl_drctl_rmwq(struct rzt2h_pinctrl *pctrl,
+				     u32 port, u64 mask, u64 val)
+{
+	u32 offset =3D DRCTL(port);
+	u64 drctl;
+
+	guard(raw_spinlock_irqsave)(&pctrl->lock);
+	drctl =3D rzt2h_pinctrl_readq(pctrl, port, offset) & ~mask;
+	rzt2h_pinctrl_writeq(pctrl, port, drctl | val, offset);
+}
+
 static int rzt2h_validate_pin(struct rzt2h_pinctrl *pctrl, unsigned int of=
fset)
 {
 	u8 port =3D RZT2H_PIN_ID_TO_PORT(offset);
@@ -443,6 +505,210 @@ static int rzt2h_dt_node_to_map(struct pinctrl_dev *p=
ctldev,
 	return ret;
 }
=20
+static int rzt2h_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
+				     unsigned int pin,
+				     unsigned long *config)
+{
+	struct rzt2h_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
+	u32 port, param =3D pinconf_to_config_param(*config);
+	unsigned int arg;
+	u8 port_pin;
+	u64 drctl;
+	int ret;
+
+	ret =3D rzt2h_validate_pin(pctrl, pin);
+	if (ret)
+		return ret;
+
+	port =3D RZT2H_PIN_ID_TO_PORT(pin);
+	port_pin =3D RZT2H_PIN_ID_TO_PIN(pin);
+
+	switch (param) {
+	case PIN_CONFIG_SLEW_RATE:
+		drctl =3D rzt2h_pinctrl_readq(pctrl, port, DRCTL(port));
+		arg =3D field_get(DRCTL_SR_PIN_MASK(port_pin), drctl);
+		break;
+
+	case PIN_CONFIG_BIAS_DISABLE:
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		drctl =3D rzt2h_pinctrl_readq(pctrl, port, DRCTL(port));
+		arg =3D field_get(DRCTL_PUD_PIN_MASK(port_pin), drctl);
+		/* for PIN_CONFIG_BIAS_PULL_UP/DOWN when enabled we just return 1 */
+		switch (arg) {
+		case DRCTL_PUD_NONE:
+			if (param !=3D PIN_CONFIG_BIAS_DISABLE)
+				return -EINVAL;
+			break;
+		case DRCTL_PUD_PULL_UP:
+			if (param !=3D PIN_CONFIG_BIAS_PULL_UP)
+				return -EINVAL;
+			arg =3D 1;
+			break;
+		case DRCTL_PUD_PULL_DOWN:
+			if (param !=3D PIN_CONFIG_BIAS_PULL_DOWN)
+				return -EINVAL;
+			arg =3D 1;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		drctl =3D rzt2h_pinctrl_readq(pctrl, port, DRCTL(port));
+		arg =3D field_get(DRCTL_SMT_PIN_MASK(port_pin), drctl);
+		if (!arg)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_DRIVE_STRENGTH_UA: {
+		int idx_drv;
+
+		drctl =3D rzt2h_pinctrl_readq(pctrl, port, DRCTL(port));
+		arg =3D field_get(DRCTL_DRV_PIN_MASK(port_pin), drctl);
+		idx_drv =3D rzt2h_drive_strength_idx_to_ua(arg);
+		if (idx_drv < 0)
+			return idx_drv;
+		arg =3D idx_drv;
+		break;
+	}
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config =3D pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int rzt2h_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
+				     unsigned int pin,
+				     unsigned long *configs,
+				     unsigned int num_configs)
+{
+	struct rzt2h_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
+	unsigned int i;
+	u8 port_pin;
+	int ret;
+
+	ret =3D rzt2h_validate_pin(pctrl, pin);
+	if (ret)
+		return ret;
+
+	port_pin =3D RZT2H_PIN_ID_TO_PIN(pin);
+
+	for (i =3D 0; i < num_configs; i++) {
+		u32 arg =3D pinconf_to_config_argument(configs[i]);
+		u32 param =3D pinconf_to_config_param(configs[i]);
+		u64 mask, val;
+
+		switch (param) {
+		case PIN_CONFIG_SLEW_RATE:
+			mask =3D DRCTL_SR_PIN_MASK(port_pin);
+			val =3D field_prep(mask, !!arg);
+			break;
+
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN: {
+			u32 bias;
+
+			switch (param) {
+			case PIN_CONFIG_BIAS_DISABLE:
+				bias =3D DRCTL_PUD_NONE;
+				break;
+			case PIN_CONFIG_BIAS_PULL_UP:
+				bias =3D DRCTL_PUD_PULL_UP;
+				break;
+			case PIN_CONFIG_BIAS_PULL_DOWN:
+				bias =3D DRCTL_PUD_PULL_DOWN;
+				break;
+			}
+
+			mask =3D DRCTL_PUD_PIN_MASK(port_pin);
+			val =3D field_prep(mask, bias);
+			break;
+		}
+
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask =3D DRCTL_SMT_PIN_MASK(port_pin);
+			val =3D field_prep(mask, !!arg);
+			break;
+
+		case PIN_CONFIG_DRIVE_STRENGTH_UA: {
+			int drv_idx;
+
+			drv_idx =3D rzt2h_drive_strength_ua_to_idx(arg);
+			if (drv_idx < 0)
+				return drv_idx;
+
+			mask =3D DRCTL_DRV_PIN_MASK(port_pin);
+			val =3D field_prep(mask, drv_idx);
+			break;
+		}
+
+		default:
+			return -ENOTSUPP;
+		}
+
+		rzt2h_pinctrl_drctl_rmwq(pctrl, RZT2H_PIN_ID_TO_PORT(pin), mask, val);
+	}
+
+	return 0;
+}
+
+static int rzt2h_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
+					   unsigned int group,
+					   unsigned long *config)
+{
+	unsigned long prev_config =3D 0;
+	const unsigned int *pins;
+	unsigned int i, npins;
+	int ret;
+
+	ret =3D pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < npins; i++) {
+		ret =3D rzt2h_pinctrl_pinconf_get(pctldev, pins[i], config);
+		if (ret)
+			return ret;
+
+		/* Check config matches previous pins */
+		if (i && prev_config !=3D *config)
+			return -ENOTSUPP;
+
+		prev_config =3D *config;
+	}
+
+	return 0;
+}
+
+static int rzt2h_pinctrl_pinconf_group_set(struct pinctrl_dev *pctldev,
+					   unsigned int group,
+					   unsigned long *configs,
+					   unsigned int num_configs)
+{
+	const unsigned int *pins;
+	unsigned int i, npins;
+	int ret;
+
+	ret =3D pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < npins; i++) {
+		ret =3D rzt2h_pinctrl_pinconf_set(pctldev, pins[i], configs,
+						num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct pinctrl_ops rzt2h_pinctrl_pctlops =3D {
 	.get_groups_count =3D pinctrl_generic_get_group_count,
 	.get_group_name =3D pinctrl_generic_get_group_name,
@@ -459,6 +725,15 @@ static const struct pinmux_ops rzt2h_pinctrl_pmxops =
=3D {
 	.strict =3D true,
 };
=20
+static const struct pinconf_ops rzt2h_pinctrl_confops =3D {
+	.is_generic =3D true,
+	.pin_config_get =3D rzt2h_pinctrl_pinconf_get,
+	.pin_config_set =3D rzt2h_pinctrl_pinconf_set,
+	.pin_config_group_set =3D rzt2h_pinctrl_pinconf_group_set,
+	.pin_config_group_get =3D rzt2h_pinctrl_pinconf_group_get,
+	.pin_config_config_dbg_show =3D pinconf_generic_dump_config,
+};
+
 static int rzt2h_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzt2h_pinctrl *pctrl =3D gpiochip_get_data(chip);
@@ -888,6 +1163,7 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinctrl=
 *pctrl)
 	desc->npins =3D pctrl->data->n_port_pins;
 	desc->pctlops =3D &rzt2h_pinctrl_pctlops;
 	desc->pmxops =3D &rzt2h_pinctrl_pmxops;
+	desc->confops =3D &rzt2h_pinctrl_confops;
 	desc->owner =3D THIS_MODULE;
=20
 	pins =3D devm_kcalloc(dev, desc->npins, sizeof(*pins), GFP_KERNEL);
--=20
2.43.0


