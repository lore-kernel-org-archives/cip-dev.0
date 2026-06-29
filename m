Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C201C43327
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:54:04 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9262.1782773635709439772
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Tf4nbujY;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.18, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYQx4esL9zfkLLm+4WB6Cx+721hLlsCRdBpvZq54rD7tbHIB6afpjMP+gonUQ0IC3e0/+ir5YbyOVU9YBUatdj7B8ReBLiE74aq/O2/1fuUVAoyawrVXhjzJP3ObCABwuwSItuJfow1t9XCE8wmz0wNeO+VBngvy5e4DyUSzurKLtWQtfbeKKOfFqcYN/Jv1TUJ217M0pa5NvKh99f4Ow7O8UvN8Wz75VMK9hE5x/pQ3sLWvxoMYfZGEAfNSynawbyNdiq9zJAxbecYm47XfG7wjvqv+r5AhCncK467iSIDR7TuYVtyy60xUVRFOt5h/x3w6k3GecjhLedPbnIGNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJucl9eiaUSufvup/L0kpC5lk+qVnchbYo4hIrp+xMM=;
 b=tJEkeugtGAWsLFm/lbyVIh1UhIDEu1M2RxW0C87impS/1DjnqvwmT4dTuXyuqrnWO3wgNgarloXa0BkxWSL4VQDTP9l/iY5ENBycyGBant/WW8SUBA0kBMWYyVu5razLSkfHzDsIj1v5wcAXsm8ztSIoJJZoi8Vwotm4ofpR+6EQMHMO9MLbGu1KpBTxAo5KS12DkWd9XgVlOW2miiLy2DfBwiTOp99YGfzz8JYVRTpEH4JCFRKkT5G1/LbpUVHlh/+PyKOSP0nMgUg3MiqSeTXdkgpXDl7d6huq7uS8FcudTquf5kZIBcpQwQBeOTbu7rp9hSmRH+wE76OsNWzlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJucl9eiaUSufvup/L0kpC5lk+qVnchbYo4hIrp+xMM=;
 b=Tf4nbujY6Gu5XL6soFAHyzxqKTIxA4TVyuKZfCbUn/INTgD+GcU01vEp6Il42m0PGnF5R2mjfkegJvubd7migy+mSnzs5Q6QGm7EaAXIYISPIv5PAGjt++Hy6U7TNCAOyZvDUemyQNuN2Ko7Ie8IshCrcmE5y4csNbRoVN9IslU=
Received: from OS0PR01CA0094.jpnprd01.prod.outlook.com (2603:1096:604:9a::17)
 by TYWPR01MB10003.jpnprd01.prod.outlook.com (2603:1096:400:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:49 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9a:cafe::67) by OS0PR01CA0094.outlook.office365.com
 (2603:1096:604:9a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:49 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E40FA3000256;
	Tue, 30 Jun 2026 07:53:47 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/11] pinctrl: renesas: rzt2h: Add pin configuration support
Date: Mon, 29 Jun 2026 23:53:29 +0100
Message-ID: <20260629225331.10023-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TYWPR01MB10003:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bbe423e4-eca5-4341-e26c-08ded63148a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|6133799003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	SWojjR4wt1IXFIUvT6XFleyX6tiSJzggbVV/NTPXBAVo11mF48+hw9YKKXGGSaZ7T7ARp1v6OadJYrtR5Ul4Ct43JGKf6p4MdZM7LCUQoDrdEbqLwDJAkzNcTx9NdCRex6muUorRuNcEJBxPEdhd037xE4PBvyBGLz5Bjovu6dR6bWsC5SrpxDQcU5gxdH0e8dGpT8+uynVuFWcIogxEgKac562lGEJokdhwskmbdgI9KcBupAMC6NcE/BrURLXJWGjhFa8NpuogTbXi7YAwvHtXDVYxra99GJ/z55lndcwgzTPmP86zK2G9RYO4rkPzydULqsxMqsdr7Ct2RW0g8EDKUX3cB0wSFnpJ07kpGdL/57lwpWDlCEl3+ik6FTBmxetPzya1923fsglrch4cSQINh+9Zt9wbXx/YXIhwnr59gvgYCrg5C56Bf3dhZHDmavyEPsWpkIIFvMcMVtr4U2DKhNE1HSjO6hp0ClAPjR4SIH0md9RJGFLHnv8CtOSSXr9/veQeIQtavnnA2AFihX5PusBPc1hECPv6L8p71Z0fRsM1JzaXIWHdg0jytP0gEagG/gYRy/hTL82E1Drye4piZisCiOGQmy3H+G2TqSqTrM12bE8S/nNHloLRR8VRDzfTFfndTonNYsBd6Blf3QkEs6ocQ4LrwoB0Psvl7Ms=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	MTSyu3lIo9TOuye+HVcD7Lxxxt/figJ2hFKE+zpI3w0YmVqNMDxaD+pc1Mfu2mPSlEJtweiRyzK8C9xt5gyhhylTSTMVIs9ptwz49AeZRCix/p3hK2cDAk0xW26aKlHQ+xevde0Mz6j2pB/QJECG5xrKDgIk2cw8ZfpiUkTJL/X9X6dGB8ffOMM8zQ7mHw+EFlLaCoThviVrH8agesn0r3SeWUEJodGuPu8SlcvUfKzxj9zBRrYixKBxOTRgzW2WWy2uTE/Pnj5q+lDMVFTmPAVhlJ8dAIvM2tL0cZ0xU/rbbdmCWRFzgmuE5Evkaeqdid05owWHcc5+j3QOcRwK+7uXl833hR6VIRDkjRz/5fq8xlCLE2kT/cXyMLgfQdhUjdK17nsHinTC0pMOApbl39IsrVGSS2mG4CGyCWE9CKzLaBNx8qFsFVNgy7ogoLdY
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:49.3312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe423e4-eca5-4341-e26c-08ded63148a8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10003
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23318

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
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 258 ++++++++++++++++++++++++
 1 file changed, 258 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index 9e583eeabdc7c..d127e150b41e2 100644
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
@@ -91,6 +102,8 @@ struct rzt2h_pinctrl {
 	atomic_t			wakeup_path;
 };
=20
+static const unsigned int rzt2h_drive_strength_ua[] =3D { 2500, 5000, 9000=
, 11800 };
+
 #define RZT2H_GET_BASE(pctrl, port) \
 	((port) > RZT2H_MAX_SAFETY_PORTS ? (pctrl)->base0 : (pctrl)->base1)
=20
@@ -110,6 +123,37 @@ RZT2H_PINCTRL_REG_ACCESS(b, u8)
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
@@ -443,6 +487,210 @@ static int rzt2h_dt_node_to_map(struct pinctrl_dev *p=
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
@@ -459,6 +707,15 @@ static const struct pinmux_ops rzt2h_pinctrl_pmxops =
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
@@ -888,6 +1145,7 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinctrl=
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


