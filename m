Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4685.1794226515056253107
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L3mc9wBe;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vifl+/tH/pzO+EAB5uezcTxj5X/y1hkNDy799f2KccZxcwMLkDpmXiSs2fMN7KmvPPdXh4rBMmK1sMhqwVYGS6EnVaRvsIB/6UvnZlSPRiYjSYnrtd8fyaiQwKaBW365GLNP0FdwlFAG/QOYbOjl5XcQbQajxOnHHEN2ua9IQqcE/PyRgnRe3wiz/XocQKcJPtOHAChGAPpFODT0W3+7goT30DbugaNtsnfbqfVRAJouMboHR3kLL9htHiOL1/IVGTyeAGi8WfHbizCqHI4blyI0Mvgl+FTFfeLhXyRywGXb2A0yPfU8Rz/YJ/3b3zWX18i71QdXdf4ACYtokGQDYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUHaQyZSGww3wLowfsJZj+w/ikCsnwci4Rb13VSLEic=;
 b=yknKXTXWAxqqTHBWMHir57J3XiuYH5W86lD8IxtKkd+eXnmcBg+tmPQqfijLZ/0n9/A4qM1ra/L3WGB9+IuKvQCXfTjRfLuhcuSI7WzZAhQztdRS9UZuklG2VSCZbxOU4GACdVO69o01ztx7ztWQZi3MOeD3A/RWzXSB0uF4Cs9r4S+Sh2KCmi2t4vLw0SbPLVLky9AjV1ly6WgzgBBd/fgfsAtqdT9TRPsaIxIQMAxskanrD87pwNBgSmNBOwZTdoPyj4pF40UuY1i7Kq7dsmCY+4feQ4DPvvNFO/a9Z+mhk81GlJfbEGACFW0itgSlxfwzvNRy78ZUc67nc02eXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUHaQyZSGww3wLowfsJZj+w/ikCsnwci4Rb13VSLEic=;
 b=L3mc9wBeN1EEz9k4kobPFDzTLr7ucTpI8ZQ55xPzc0vf5noLJd23beuSfmefk/fMkysvVZrjGqeiGkSGzeLshYDuSoGZzCKYLmr3FXdYG+neVZS8oNachB1ppD6CF30qbKz0Yo2DctEImbvagmLDMXTw731w7t/9pXhw5L4Zj1U=
Received: from TY6P301CA0016.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::12)
 by TYRPR01MB13292.jpnprd01.prod.outlook.com (2603:1096:405:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:15:08 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::41) by TY6P301CA0016.outlook.office365.com
 (2603:1096:405:3bf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:08 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9F0B1300028E;
	Mon,  9 Nov 2026 21:15:07 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/24] drm: renesas: rz-du: Add support for RZ/T2H SoC
Date: Mon,  9 Nov 2026 12:14:36 +0000
Message-ID: <20261109121451.6042-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYRPR01MB13292:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f5c834-962f-4d70-bfe7-08df3e5b18d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|10067099003|3023799007|56012099006|5023799004|11063799006|261028144727099003|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: dWqKok3A/ZMee4QpyYg0fXbCtaXj72LhQOq5zt6zkaSZHa6CQhwhEi09PnqQUK1s7uGxXTzEaMnC2n8kGKFhmx8AZ8Mwnskb4xUFz/tXmHzLBF/V35DUd3ePE0zrdHUEsA5fHB0l4/kOx0SzpzvNcMCRVZLDkfnpnuHuhI5zATvHU75PARcqbU9JJ+TBAm8KpC4ryu9CO2brzJt0aOvQXTtoa6IO/XzS8ZC4c74qnMOyE5x8bsBENCwQm8aTqVz+bZwbVeRkvsIqF4mPElS/SZnX4iTn9YJwRAYn8e1az9wln3pcaPfSK4Fd+kogpOimjggQxtUTr+GIC9Ofigxre9I7k2+BsaF5YxR6ogUXk2upAwh8uvXN2A++dtO3OzTqkChXmwmuMWryBWXv4YKAmV7WwMOfoB8wtDBu3zC7GqbBZiWysiMJN6YGa6VFG0K41ZMRk0E1THxXZZ7+NripEKbH2S2mL/ZDVaUPE/v/1TXKxTrb1vqzluIYaNWpmG7nuntGSjofHvm5Fec9TeNlcT40yM6f4VfUetaKXwqq6oOvkQz+0usCdFD0iE6o5m7XmhZqb7lxtAcTu9MnIAGV9OYk3NdqOMTrlJZuaGD7Lf9dN8QHuMRMBHZWpiKlsHrehBLAheiHTtW93O6DAZG65A==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(5023799004)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m5qRPultPLRQafpie6NQVz53KsqNJiTto8MGtcjfb0UgzphlIhAQYbsqAWwD4bgKLIr7wrbA7InGbY7hL8gm00UPUv3EpRMWJ7Sh7sDIZ0GBr4vk0jEsRULAhqg1hprvKAGE9moCGAZ46mE2TG2OoWh1TMQE2bKFX7TIz6c5D5ZRNYXz0LoDnHCDYpFlgw8hT6hiSIm4a5qix1B7gLTQ9M8oC6b9ZbX3lXofdqAOpL7/YZxl0wTjM2ACcGg7O4RvroAlw8gDFFZD/ROCmF4ZyloFV8mleloxnNxPNMjXYlJqi3nXfYZmMzTE2z0A9ClBa7zYOXD1UEG23st1cAnyNffRts5ti8h+EG0MYtjjGuVKr/qbFjOI3Rd6HfJ5oqvbKA4FvbhHNqoNQnFKo8v2ZmFnU5LXuwqmmmWUolLSfluQ/AfMcqJ01FHfU7Go01W/
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:08.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f5c834-962f-4d70-bfe7-08df3e5b18d7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24713
Content-Type: text/plain; charset="utf-8"

commit 4f2e625f3d5d27242f0f18ba106b9442d29a51ad upstream.

The RZ/T2H (R9A09G077) SoC includes a DU with a DPI interface,
supporting resolutions up to WXGA with two RPFs for layer blending.
Unlike earlier RZ/G2L SoCs, RZ/T2H requires explicit assertion of a
DPI output-enable signal (DU_MCR0_DPI_EN) during CRTC startup.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patch.msgid.link/20260519160825.4082566-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  7 ++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 14 ++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 10 ++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/dr=
m/renesas/rz-du/rzg2l_du_crtc.c
index b917556d14fba..c95716992b12e 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -28,6 +28,7 @@
 #include "rzg2l_du_vsp.h"
=20
 #define DU_MCR0			0x00
+#define DU_MCR0_DPI_EN		BIT(0)
 #define DU_MCR0_DI_EN		BIT(8)
=20
 #define DU_DITR0		0x10
@@ -217,8 +218,12 @@ static void rzg2l_du_crtc_put(struct rzg2l_du_crtc *rc=
rtc)
 static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
 {
 	struct rzg2l_du_device *rcdu =3D rcrtc->dev;
+	u32 val =3D DU_MCR0_DI_EN;
=20
-	writel(start ? DU_MCR0_DI_EN : 0, rcdu->mmio + DU_MCR0);
+	if (start && rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_DPIO_OE))
+		val |=3D DU_MCR0_DPI_EN;
+
+	writel(start ? val : 0, rcdu->mmio + DU_MCR0);
 }
=20
 static void rzg2l_du_crtc_start(struct rzg2l_du_crtc *rcrtc)
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm=
/renesas/rz-du/rzg2l_du_drv.c
index 962bd84b87597..52b16239b7cff 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -63,10 +63,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09=
g057_info =3D {
 	},
 };
=20
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info =3D {
+	.channels_mask =3D BIT(0),
+	.routes =3D {
+		[RZG2L_DU_OUTPUT_DPAD0] =3D {
+			.possible_outputs =3D BIT(0),
+			.port =3D 0,
+		},
+	},
+	.features =3D RZG2L_DU_FEATURE_DPIO_OE,
+	.mode_clock_min =3D 5000,
+	.mode_clock_max =3D 100000,
+};
+
 static const struct of_device_id rzg2l_du_of_table[] =3D {
 	{ .compatible =3D "renesas,r9a07g043u-du", .data =3D &rzg2l_du_r9a07g043u=
_info },
 	{ .compatible =3D "renesas,r9a07g044-du", .data =3D &rzg2l_du_r9a07g044_i=
nfo },
 	{ .compatible =3D "renesas,r9a09g057-du", .data =3D &rzg2l_du_r9a09g057_i=
nfo },
+	{ .compatible =3D "renesas,r9a09g077-du", .data =3D &rzg2l_du_r9a09g077_i=
nfo },
 	{ /* sentinel */ }
 };
=20
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm=
/renesas/rz-du/rzg2l_du_drv.h
index 885558eb9547f..baf076d69cdaa 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -20,6 +20,8 @@
 struct device;
 struct drm_property;
=20
+#define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control =
*/
+
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
@@ -46,12 +48,14 @@ struct rzg2l_du_output_routing {
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OU=
TPUT_*)
  * @mode_clock_min: minimum pixel clock in kHz
  * @mode_clock_max: maximum pixel clock in kHz
+ * @features: device features (RZG2L_DU_FEATURE_*)
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
 	u32 mode_clock_min;
 	u32 mode_clock_max;
+	unsigned int features;
 };
=20
 #define RZG2L_DU_MAX_CRTCS		1
@@ -77,6 +81,12 @@ static inline struct rzg2l_du_device *to_rzg2l_du_device=
(struct drm_device *dev)
 	return container_of(dev, struct rzg2l_du_device, ddev);
 }
=20
+static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
+				unsigned int feature)
+{
+	return rcdu->info->features & feature;
+}
+
 const char *rzg2l_du_output_name(enum rzg2l_du_output output);
=20
 #endif /* __RZG2L_DU_DRV_H__ */
--=20
2.43.0

