Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4574.1794226512895643533
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pjVaZ4gn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.40, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUNwfWOK9LlxhW0+pQKJ1e9oN+Y+SlsbYqtNR8hHPlSSg3b2hAANeKAOQYOZzV6N2cj9rTEr0HGyGClHIFNIlGBrAMGoa+ogx4tXC46GFxAJG0mJ4UUnnoLi9Q2S3iHP+44oEEXGGyAj8Q1wXiuAAxvhRJu6BMfXTVTgptgW7AZveb+9hWcoc+OJBLlW/Se9lf8e+9a7Jd+T+RUqR99pqRvsioqCLj/Y9UJrOVA2mVvxUdGHIghwaZEHUB1oeJTBdbmpgYsZfKMyJMkUrRyu71crz2unNpvoVGmow3COMAetdEG3aUlIOf46Nf/o3xGMblyfjcmCLEyLQHnYNwxBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbz4xqH6NeGwWYAeer3zrmOrxSg3jd1zej0nujsoMe4=;
 b=QRTbPh/XiYhbYf8L4GAgHxNcmCllEb6zGDVdKee2T6j9jvZmBgGUHNy0nC9pKDQLB7ZBGXYJpBgJ07+bv2Pp38lKylmiHVNCqyzGv15FDmrVDxz+7LRk5JwnB/BnU/P+NgzZDX82gRvN3H+1x18aFGe9cdl4hkPhChypGquGz2PxG8phG0cG91p7U8I3iEuGpm/wY92GBfVTa/Y6H51Nt45K3NrVDZY0MybFe0hmntEmOU+FzcSFTu+llgkWOwn39lXayLRK36FE7ABX6U1gWBpYWdvkrY/sCTRrICCkh3veQziTxNcHnS2zq1MbpoUUMixRK0NtSrZi6JzBeF3hGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbz4xqH6NeGwWYAeer3zrmOrxSg3jd1zej0nujsoMe4=;
 b=pjVaZ4gnCPQ3EmlhbGXzBmswSXg06EEg/sfBwGnCeHlBdEJTqNKyS6eOeDIRLekzht6KqJwpu+kn/qZ/1bi3axhJPcEgFBzj1qHBOtAqKPlRPrBiIivna/e5S0G3Bh7dVKXiDd7Oneyhz+gSK9jirXx/TWS3RBZj9Vol97hxHU4=
Received: from TY6P301CA0016.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::12)
 by TYWPR01MB12006.jpnprd01.prod.outlook.com (2603:1096:400:3fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:07 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::41) by TY6P301CA0016.outlook.office365.com
 (2603:1096:405:3bf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:07 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F0FEA300028E;
	Mon,  9 Nov 2026 21:15:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/24] drm: renesas: rz-du: Move mode_valid logic to per-SoC clock limits
Date: Mon,  9 Nov 2026 12:14:35 +0000
Message-ID: <20261109121451.6042-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|TYWPR01MB12006:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e9bab6-0b4b-4e77-26b7-08df3e5b17d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: vlkzl8J8Alpa2Q8VG9aB9FSdAP4h1ctgtGJkL5GE1KgZN/OBpHTs0xe3txxCRebJorMTjAl5InwCyfV7wGHAsB2SJBG4YmPO+PIukbbPQq9r9ebI0DExzf/3l63PCTS9l1IKRfucUsSxDsNxFgkB50rGTCWJzFQhKzmmGJ34Bz2pprY+/Dk9ugiTf6ww+5O4UTbxX2XiL2BtuT4Bz8FLupbXhgr5fI7JFqvkDr3h3sUNM9ZvIO37QGx+n08mKh4XinJ3wuMUOz22f31ZMT3R7BBuKFZ6CVz0Ki1ZDn4gaaQ3pUXgbC9PSaPDg94UmgIz2aj7iH/HdMo2ms35kAPZwzYEbvZdC7CwnVDYIqIQuSMqAm3Bjqk3S7Gy5KLMSIRXj89mq3U6bwVewGQOHxCWi6o0gh1Rx2JeP2ryavXNyWaKzr8CuJZJhf6rfc2y8P+6L+fh74kYa1y1SED6JB8VCFcU7ALCEsUABJegVqbxnJmPRwvpyaaPzVsOLFs8vHwU0f97EIZrA1S1cyIFbbqiut6WPDlv4tzODWBlhXidCkLx/GQ2htjV8+gpbiqBeYfsDDq9d3XFJ8Dle/VKxWwqXi2BGNHWonavTuAE/KKMRVuHl9opKr8xgQopNvBDf+q3polkSc+BJ9rR5NR1DqB/ZQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KcJ3grT32n1q/558zSdokFYPiJZDFk6B4jb4gFRfSJPOlpKHKLboCEuReWttUoj+n4fUFegHPiRg1j1Glwz/ePksTIqGzu8ejPV4tkW59JIc6rSiXD/Jm1vhsuFY/7Y0WX8qamf4a6AWrtqpfcd70gmY65B16hQgLHTRxBR0QQpQvAb2cn/xrlg7w3+jyds496hYSPLErybS7OmVV+rBFrB2+wl2y0MVm8XPMBNtfx30OdczvcYjSKilGCxlW4sf3vJqzwQfvoPzLpdyif+ICmD8q1Y+P0ZvnkgKOL17vMI50XzMW07vh1JAEQfcWEdnL0PWE8MLWZM3rRZRvOW/nZy8nw7yezj6tgIoUtYsWJLsQeGZx8HuHO6JzrqCZojk4GHuuaKUPQAeuxZ+bRy6QbmmKEFWk3M29l2eDYXIRuQCcpZptsLiTUMzPvwUd+i5
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:07.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e9bab6-0b4b-4e77-26b7-08df3e5b17d9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB12006
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24711
Content-Type: text/plain; charset="utf-8"

commit 332d72b9513cee25682108b5b37fe9fe9468ba73 upstream.

Move pixel clock validation from a fixed encoder check to per SoC
constraints stored in rzg2l_du_device_info.

Pixel clock limits differ across SoCs in the RZ DU family and cannot be
expressed by a single shared rule. For example, RZ/G2UL and RZ/G2L limit
the DPAD0 pixel clock to a narrow window, while other SoCs such as
RZ/T2H require a wider operating range.

Add mode_clock_min and mode_clock_max fields to rzg2l_du_device_info to
describe the supported pixel clock range for each SoC. Update
rzg2l_du_encoder_mode_valid() to check these bounds when evaluating
DPAD0 outputs, returning MODE_CLOCK_LOW when the pixel clock falls
below mode_clock_min and MODE_CLOCK_HIGH when it exceeds mode_clock_max.

Populate the pixel clock limits for both the RZ/G2UL (R9A07G043U) and
RZ/G2L (R9A07G044) variants to a minimum of 20875 kHz and a maximum of
83500 kHz.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260519160825.4082566-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c     | 6 +++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h     | 4 ++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c | 9 ++++++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm=
/renesas/rz-du/rzg2l_du_drv.c
index c74afd18f70d7..962bd84b87597 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -33,6 +33,8 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g0=
43u_info =3D {
 			.port =3D 0,
 		},
 	},
+	.mode_clock_min =3D 20875,
+	.mode_clock_max =3D 83500,
 };
=20
 static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info =3D {
@@ -46,7 +48,9 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g0=
44_info =3D {
 			.possible_outputs =3D BIT(0),
 			.port =3D 1,
 		}
-	}
+	},
+	.mode_clock_min =3D 20875,
+	.mode_clock_max =3D 83500,
 };
=20
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info =3D {
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm=
/renesas/rz-du/rzg2l_du_drv.h
index 58806c2a8f2bf..885558eb9547f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -44,10 +44,14 @@ struct rzg2l_du_output_routing {
  * struct rzg2l_du_device_info - DU model-specific information
  * @channels_mask: bit mask of available DU channels
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OU=
TPUT_*)
+ * @mode_clock_min: minimum pixel clock in kHz
+ * @mode_clock_max: maximum pixel clock in kHz
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
+	u32 mode_clock_min;
+	u32 mode_clock_max;
 };
=20
 #define RZG2L_DU_MAX_CRTCS		1
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu=
/drm/renesas/rz-du/rzg2l_du_encoder.c
index 564ab4cb3d37d..32ec5350f3a6f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -30,8 +30,15 @@ rzg2l_du_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct rzg2l_du_encoder *renc =3D to_rzg2l_encoder(encoder);
+	struct rzg2l_du_device *rcdu =3D to_rzg2l_du_device(renc->base.dev);
+	const struct rzg2l_du_device_info *info =3D rcdu->info;
=20
-	if (renc->output =3D=3D RZG2L_DU_OUTPUT_DPAD0 && mode->clock > 83500)
+	if (renc->output !=3D RZG2L_DU_OUTPUT_DPAD0)
+		return MODE_OK;
+
+	if (mode->clock < info->mode_clock_min)
+		return MODE_CLOCK_LOW;
+	if (mode->clock > info->mode_clock_max)
 		return MODE_CLOCK_HIGH;
=20
 	return MODE_OK;
--=20
2.43.0

