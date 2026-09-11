Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B7C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:12:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34555.1789114321291289583
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:12:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mPTjbcrW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3G8Uce0TNhQfcxVmxoiro1ww+vSBstBIc/LHbLCi4chyxoYKR+FMom7Ety+6v2sB58nBTSxfKePjjfxMXJukQTkm7JX95lH7BGQuO2rdhJjgIUWDiLJuPzslgisNamLmc47JjgQmcj1WlqfIiSyW5lI6Uoc18s69hxjQjT5plM3l3vfVoJPynCFUPtnqpJw8lezAwqABJxF98U9Ed//pXm9eQgGgHhgoAW9u0rLn3v7LgJGblVOtBc+MeEbjiUrYwcSKmxgHFzvtkjsgS02vH9TQbVIUDuGCOVgPC7KvuB4Wu43rJUlYVea3hNuuxC8FaRiSgYzM+AgRGcwAjws3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USVQdJdvKIEwzLoG71Isszzj0wGfG//YNnzFi7SzLuQ=;
 b=O5K/NAQHQdnIfhXBO648FtmBtJ4hHBvBVaril3fjXMUYrGy8xGhYOtHpXYKAzLc/U1l8oDCy5F7I/rnMGhwwp2QB91YgJtjNzsiLniPncrpaPjDwSOF8EA9aWAAiDbi+Mamvz+5EpMc/OQqkrj1qQzQMnAOO8G6FkCUalf9NSgwmDwKZoFDyFRBWLzkWibqUNv5UGC/IaNRNhps82El7FrBeKX0giqfa/fM9/nKRo5V8rUe7kWryRFyuVdhf9D1w41krcbXVoguaaLcXO9U6B9Yl4vCqTGgMcTCP9DVX6Xgz2ov6DiIhnSSEjImrGugDT5HlZ2Z20camuhK8K+GVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USVQdJdvKIEwzLoG71Isszzj0wGfG//YNnzFi7SzLuQ=;
 b=mPTjbcrW/QP6cFTgidn0TTFg8wOPfy25SrS86EVknJG0ThL5k3tsLXg1lcXbiLcmq4kDDj9DzDcDegPws/hW9QbaxyO+f1d1o2FjfKHe552rkDyCp74RQH81DkfTWA3tbsNotLjIB6V83EAP61C1AXut9K5SMSeg0REf+HKpvcE=
Received: from TY4PR01CA0040.jpnprd01.prod.outlook.com (2603:1096:405:2bd::15)
 by TYCPR01MB11024.jpnprd01.prod.outlook.com (2603:1096:400:3a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:44 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::98) by TY4PR01CA0040.outlook.office365.com
 (2603:1096:405:2bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:44 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8814630002A8;
	Fri, 11 Sep 2026 17:11:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/8] dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
Date: Fri, 11 Sep 2026 09:11:30 +0100
Message-ID: <20260911081132.11879-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYCPR01MB11024:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b47354e0-6f09-4dd4-7230-08df0fdc51c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	wf6F6lF7qxXFTXGWqfEOogrutVfjJ8YBUBKERV4DBlAZineQWfPxeM5tAGhnDQ5RVjDFRVpjV6ZZPOOUK/RL/5o9zQPmRKF4/GEHu8bzMFvNiHQm3M8UTL7r8nDFYGnkbcVsHNRKuTi1m/+lNzfAJNBjn5ft3tyLO919uJ+UGitsD4XR2ZQu0WxuEG9Fih6eo5deR8J+D3IEzWWgwfFFBv4Xiwf6kfQjWD2ONowovYxeqdEWQJMp4O32rivKsCo0ZIjodqF+v0gSXd1qJig6oD/wOAtb/TINoQUrnW8UMAyJ2dlS1SuR0Ul8glTrbACfuMZjBYgB21FxCW+hIB//1FTpdmHu2C0vPlUSQ0J7u4ZeL4kv9zDzzHD20PDXcNwOXLjRu3VjXjrI+VVPKjannWARjLb+ndnJG4UOEPUROWhdcWwJ807AJHQwJFdP2F1Mczly61Cb1yx0qVjAo6/vnYL+YGlKdz639gC+8pnY5U5tLD/9IYOSbTXeO9DeWPjmRxxkT7wNZK+28DAsY6nBMtCXmqXvJe1tiST7B68Smd4Kjr5pb6cC+COs8J+Rd4rN3uTSsSqmBZbz/MavPerTHJ+DbAPYuasQaDk8lat7e34eWyutrsC/7y/Y2l7lLJsBSuERbw+u5AtaLQJp8IzwHJfyj2fruwZUfm/cvVbGXPg=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	a5rtJl6ftW178h54lDanra7r3O5p9dd5Gz7GDAKtuS5Kv+btNP2EXfYQHxjcfXm6ANfoC8ah1Z0fGMNyEChUoHpKeeSxAwYfc/u2xFDzVR3hy62ijXmfEVnvnsgjUcmscAkdfuUNsav+ReTROpKJf+uBhxK/sec+ELS18dHVe4UqMAIdOoUk5N4zLHlxho2m3luUMtuiztbyntR/0+7xsJSf0x6pWPXLEljSqrE8WRu8egZYmAapATk3GrS6MkUXQv253lXFDtNcWLw6kygk7RxmdoaI7OBTo0heR3LzgeXqESjOs77UPYecN38YF8ZvTkJxuV5/9gsjoUaYY98mE0kPOIeXSmX0JXCK3mTM0CESkRZa2B732QywKH6enb+EWHv6aI7DUZZXRwNSFZOkjga+cVyobLl/NauOQV4/w2NQnMllEu08FGZE6DUu62G9
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:44.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b47354e0-6f09-4dd4-7230-08df0fdc51c4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:12:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24126

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit c03d8b5462bcb0022f9477d09eb37dae66c3a769 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs use a
completely different ICU unit compared to RZ/V2H, which requires a
separate implementation.

Add support for them.

RZ/N2H will use RZ/T2H as a fallback.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260105114445.878262-5-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6ff4e01245bd7..dc744823a35a6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
+#include <linux/irqchip/irq-renesas-rzt2h.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -1059,12 +1060,18 @@ static const struct rz_dmac_info rz_dmac_v2h_info =
=3D {
 	.default_dma_req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
 };
=20
+static const struct rz_dmac_info rz_dmac_t2h_info =3D {
+	.icu_register_dma_req =3D rzt2h_icu_register_dma_req,
+	.default_dma_req_no =3D RZT2H_ICU_DMAC_REQ_NO_DEFAULT,
+};
+
 static const struct rz_dmac_info rz_dmac_generic_info =3D {
 	.default_dma_req_no =3D 0,
 };
=20
 static const struct of_device_id of_rz_dmac_match[] =3D {
 	{ .compatible =3D "renesas,r9a09g057-dmac", .data =3D &rz_dmac_v2h_info }=
,
+	{ .compatible =3D "renesas,r9a09g077-dmac", .data =3D &rz_dmac_t2h_info }=
,
 	{ .compatible =3D "renesas,rz-dmac", .data =3D &rz_dmac_generic_info },
 	{ /* Sentinel */ }
 };
--=20
2.43.0


