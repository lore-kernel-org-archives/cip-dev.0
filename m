Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4682.1794226512814408645
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=N4WDe93A;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thWqD70L4qpgBtFdw/mLIMoyZrOFtgIXFtlBaXzI8knw7gylR3BxxCfUXrglUqQRU9kuy9F9Xm5hhA3849/rYm6LhAFBe9oef5GyoOdWykjL6MP2kQdXlvsj3SA4czynIfvbfHlrXlvx9Vu5XCUlO5FHEqgZKWBgbnM9TBX4zxvjv/LK7hMlCWC6u1uQbyQznWw61G3fCZurzPpD8BevKzlJLnu6oBO2wByV8C70q+V6K2+MzLOJGmggK7lRl8EOoEavkOlNLp5IxXqd79JpkYDLWLJXpYDlVwzWnm4aIjIVHfTbI8nr5/MHV9o5r6TERf3b3+KZfiTTt0Gf8KMD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILY908bPXZjagmvne5O0kOtlsrXU+0kob5UhLQT+t0Q=;
 b=l3p8qfbSi9ynNnjTUykc0TvG7OCvVKrVmQ92v8GU9N5xcupgr8iWl/XmWQr16BrWtCaZ/yQ/Jn5FBXmMZsKGZCmDxuGLJtx7CML4LgXzhc/k1k7BhmV5mLcNte2M0zWx3eepuYulYL3MY4f5qDRMrnnqQsp1jL/QjfMv9PqtOH/kz8eQcv91TE2AbgbnfdC7yKmslwGddPuYggd9bJbXW1mUmn5o5vv0rxVJjOQ67uuwyzQzsVwK+Repy+e19uP5U9XenXcP1M2U93+9lynsLQoe5bGcalJoJXXZHvgxuyrGikKDVEKQoQ46EgheO8Qs7HMMhArGxs+/23ZUaUJXsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILY908bPXZjagmvne5O0kOtlsrXU+0kob5UhLQT+t0Q=;
 b=N4WDe93AM+HO8XYSNCjfbkdALyBN7LbLkyvZtLCjcjU0Ud83Q96KZrOpBcni/l4Qd677Y1IkcTsdgVQQJtT2WKRLkVh4nFYgpwu8L9Zqe34JC2ZNHLmi5iMv9RDhNY0+iMQ/wIUdFfVZs9gmQ6x9hXLUIDc8dTi5AC48zoAeXlI=
Received: from OS0P286CA0105.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:b1::20)
 by TYRPR01MB12775.jpnprd01.prod.outlook.com (2603:1096:405:1b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:05 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1:cafe::8) by OS0P286CA0105.outlook.office365.com
 (2603:1096:604:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:05 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4FFB830002A8;
	Mon,  9 Nov 2026 21:15:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/24] drm: renesas: rz-du: Make DU reset control optional for RZ/T2H support
Date: Mon,  9 Nov 2026 12:14:34 +0000
Message-ID: <20261109121451.6042-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB12775:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ba9481-901e-406a-fd0d-08df3e5b16eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003|261102124527099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: YYCh8y3NjMUCzVteAPSP1mZwcaBxUTNo8NcOTHf5OE3lMxydW/Y/PxalnwMSNCQ1QPUbw0fYy/8ZYV15+DwzoTtfhxV2IxdHhxv0HW8dn7RY8QumACFo+LHcBKQLMNx+G+vYm/EUEyHRz0lFMV6UvFSLYWTX11NzD5Y0AECXy5wAn2Kak1gtvvShnXL++f5IehJakj7wriXZlw2o418wPQWJGYJD3vn9WXScJd7QFVAKdmVDSHLCyhUTuy5c+mrPz/3WhPrunohFEUUG4NJVBu0zeGVRc89IrpDZrB3y7Ex6LDwFUJqySj2E9aJn3Ns7QYNPLeU+E9monHx5bs9sjV/8CgBVoe1NjnlFRatVk+j/Hu7PWI9fMtMchhngMXQTbWtImxJkJ4kOD78IqifvL6wlMbtNFmHNUPtHXmHk+hWqrqStUAWL4chH2KNfTfD5Y2HO/3IRf6Qqp/P9DlZXJ6wf7KE2eMa8lIimOISgdxnob0yrkcWi9GpGn0QyHyOr50bqw8gV1w9/Xuksb1v5i1B8UGUrNevIeWEFskhRajF1yY8CHTGXO/aLa5DYXuawMOMsr6HP6eq3HFvCJKAtG04HHTXBThFimd5scJMWrUDXYs3OLKKZMYVoEkK4bq6PEWxm3wk7mnYEwThZ70/d6sQ2n+GGa1Q7ATH6XXQ57so=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261102124527099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: poJPUSqZ51N6WQfAwN7byB6gskRpXL/F26vrIG9yd2to+Iyw+z8kBKjYg+pXEyjC5lGrT9DBr5nWKV0XxnHkgmsqzlf6HMlFL9EXRqI6Ovz1PrFiBLwhoSranzqX7H5QFWjBzloRsgS/zo53WmQJfE//nf+2S8cw7O7jJ5Ixgf+Wxpp4iUhCaZyjeezFaktsUGw6Lar85agc7hP0jJQf3euW+xXhbQpPVwb6wVB3eJd3GrK4xWwJLSSOh1Wvm8bMYW8jy+rsg3e5u/c9PQyMSCo+yEbKLZ/NNX20CW/50EVKEJ43Yp7NwirnwklKNVDm19q+IC64v7AfzFsnSWdT33S38EboXDe4s4tSzphHThRtmdHV9LszSyHLETHUAffj+e33ckP5LbuB7uE1xKuJLLEf+PLekfIDJwixKE/ssTHquvYbS01s6vsL3dlhA9Lw
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:05.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ba9481-901e-406a-fd0d-08df3e5b16eb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12775
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24710
Content-Type: text/plain; charset="utf-8"

commit 62ca607fcb1f442e909e6729fa9e1e7a18e6ae5d upstream.

Update the DU CRTC initialisation to request the reset control using
devm_reset_control_get_optional_shared(). On RZ/T2H SoCs the DU block does
not expose a reset line, and treating the reset as mandatory prevents the
driver from probing on those platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patch.msgid.link/20260519160825.4082566-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/dr=
m/renesas/rz-du/rzg2l_du_crtc.c
index 6e7aac6219bed..b917556d14fba 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -380,7 +380,7 @@ int rzg2l_du_crtc_create(struct rzg2l_du_device *rcdu)
 	struct drm_plane *primary;
 	int ret;
=20
-	rcrtc->rstc =3D devm_reset_control_get_shared(rcdu->dev, NULL);
+	rcrtc->rstc =3D devm_reset_control_get_optional_shared(rcdu->dev, NULL);
 	if (IS_ERR(rcrtc->rstc)) {
 		dev_err(rcdu->dev, "can't get cpg reset\n");
 		return PTR_ERR(rcrtc->rstc);
--=20
2.43.0

