Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1815.1793653902613443112
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uj0ZYFLl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.24, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3dnu2tl4jupfT7P/zpI/D8l3HA+1GBicO7dpLUZM7hjktXPgv2HsXVXeQD03QTxPJ2lIU799xp9dcUbOAHXyJaLEkEtKvHeqbIXrtnJABcWsOXgFDb95GZBKYUHSaLk7i3aGmZ4oD3pGUHAbjXcYFrDo/UHWmSKG2PkSCFOAClURVhUYICpTibTfKbgL2EoMLE7X9Q8qJahVOoqfM5PNNC4wK4RMrw48jxdVCWaPfI/DlsCId3q95hV1pxKygUrBQrjG04wFoxxsAmSksVbhY8NhqoPJqEicQmakH5u10gieHhljfDtuZ215XnTVOCEYwlRBi/3FouQXc+ZWEfoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRY2lhuP2ckn9wwb2I8/tw+NmA+erRGyuMpDS6gkg0w=;
 b=NeInFKUqN72XerwtluFUIr6WaaC8CLnB7L3fmidcnwOCUp1vEu288lkFoXLRWPaoIcvAbsOBj30KgP9dyNoQ3ZQvdhvfJ/I+IB9o74krK8FsOscUVjxMGlAj+ZAZOwdkBtLobQKjPZhfAAXyZVL1oJPBOq4b6U2MnOqakKoTW4MH+3lQvR8Txwl7m/MHVxHNsr66+n/ebHA9wfa5hx+Ftm2Ilt1AYrWb/TCtKvWT6ZZ4+ON6keNS3eOAilIY8KcQECt385Hh78DwhoTemgBImrokJmNoLFLkokDXA0q8NwoQDbVQHz1OL5HgZSJJ73LHMshjU25/WIwTZoL0fiXJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRY2lhuP2ckn9wwb2I8/tw+NmA+erRGyuMpDS6gkg0w=;
 b=uj0ZYFLl4d9rEx90bG8Ben0v5EVpdacU+kLPnu2o7DBfVc0TVbrQL561rXGzCx2DZiZaUV5VlsHERyldxA6SQh1wGa7Bf8pofsZRi8eyJg7fU20418r7hoqSIW8qa7XOR6o+8TPEuXxRuiKnQy4noI8FsQOZyZ0XIc8lnuFTWHc=
Received: from TY6P301CA0007.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3be::17)
 by TYYPR01MB8184.jpnprd01.prod.outlook.com (2603:1096:400:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:36 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3be:cafe::23) by TY6P301CA0007.outlook.office365.com
 (2603:1096:405:3be::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:36 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D37F73000230;
	Tue,  3 Nov 2026 06:11:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/8] spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
Date: Mon,  2 Nov 2026 21:11:24 +0000
Message-ID: <20261102211132.22646-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|TYYPR01MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: b80565c8-e8ec-41af-5dbc-08df3925e10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009221727099003|261009223027099003|261009223327099003|261009220027099003|261021121427099003|261026121527099003|261009221227099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|261102123227099003|13003099007;
X-Microsoft-Antispam-Message-Info: faQHkcAYIbk8o68GMVjRrBfuZUfYVZzWlrCbREX+pLvf1fQeKnQRUUhrKc9myPUqz5JQwVmC82T6mf70zTrqhXygT/lSgW7ikM8foHVPKsNvCbTo4bX9jaKtT1Fm4vxTw+toQQhDVVKcDoR6XySO7qdIQa7/HqQEIkJcwEM6om92tNeGnNq8VqN1WKoZXpZQi4vWuAjwJW7UqDjR4PUbCpz9mkD0hzq9J7O5Z06S32HJiRJi5QnODmNwtuu8DDK/sOrCbvWJWGRUa6tlZcLJLuGRF0sxHRq7F9CIxJGQZBQbT7ziZLVsh5kCofw//SqakW4q5eeuPop4i5Sjc1ivLQUg5/QdyyYvktE1mn//rQHbcVOUT/ZTPIhEgCvxOfByRj5tkndaoq3AZ6Di+MLuyUpk+NJcex9BqJborzTaAM58NT/TN94F7mSADJEFqVNkmSEBBxDQi2eUddyd2qzWW+EmliYMP8Pcr+ZHuCaOs3QCU1hEPsHj0JvEHeesc1P6PFLDLsCEjFqX97JD4JERNgjlLzkKe6vStBaatCrjz1jmOpBHV2qLbJWufAafwNoh6KKjo0mpMRsIBQSPQ6XPavr4bPv9QP4ri7dVsn+ItsAdbtnNRPhDTWG7FibMTzFvlpSo/8Zd+XqKgoIN4sWBxV8jLeSGKlKHc/t8BoQLmyU=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009221727099003)(261009223027099003)(261009223327099003)(261009220027099003)(261021121427099003)(261026121527099003)(261009221227099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vsEAY52v480HOoAJ0q0J091VfpUcoKN2DctJSywNgo4pezmg+odxGPlMuK95eATUQYkPTAStrkuzDQBb44ZkH3imY5VO88T2MHLXqq8340Y7wqklxuXTsotNXCQT9vWv7urxdx8yoogB/iVx7Djc5z2dndHiUX5hfa/YokzkSao1J7m4ClbUWzcMqos3gyWwIToZA+uT6PVIPYLnD1yGAef1389a9FYEpxICO1Iq6M4hWHAxO8IBGd+D/O06mm75VOf1ru5LGFsm/8qAJv6ZJDul2ts64MYKlREchKXvJjCI1f9ql0ayr+7GCLiB6LyBco9Jz2iDZmDA7FeQCjY7gj0SWtGCt2ENk3cyzEa+ycRopYXxJR2JeuOl5kIfCfQBpJLLB2o7+C7MT3zcVrUdL3quUlF5AkU3/mhdpcWhkvQ4RJyTs8r+scmMatb5oy3U
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:36.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b80565c8-e8ec-41af-5dbc-08df3925e10a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8184
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24620
Content-Type: text/plain; charset="utf-8"

commit af4b98e33d5607f80b49e792e0a74cb068d810f0 upstream.

Enable and configure the runtime PM autosuspend infrastructure during
the controller probe sequence to safeguard chunked flash operations.

The underlying hardware controller handles memory-mapped page programming
by dividing data transfers into an automated sequence of consecutive
64-byte chunks. To prevent the power management framework from
aggressively gating the interface between these individual chunk frames
or during immediate out-of-band status checks, an explicit 200ms delay
window is required.

Configure this temporal cushion using pm_runtime_set_autosuspend_delay()
and pm_runtime_use_autosuspend() at probe time, ensuring proper cleanup
via pm_runtime_dont_use_autosuspend() in error and driver removal
pathways. This guarantees interface continuity across the full lifecycle
of a multi-chunk write operation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260715222417.2997712-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index ef1e7a0565c1d..229cd6ca98164 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -161,6 +161,8 @@ static int rpcif_spi_probe(struct platform_device *pdev=
)
=20
 	ctlr->dev.of_node =3D parent->of_node;
=20
+	pm_runtime_set_autosuspend_delay(rpc->dev, 200);
+	pm_runtime_use_autosuspend(rpc->dev);
 	pm_runtime_enable(rpc->dev);
=20
 	ctlr->num_chipselect =3D 1;
@@ -183,6 +185,7 @@ static int rpcif_spi_probe(struct platform_device *pdev=
)
 	return 0;
=20
 out_disable_rpm:
+	pm_runtime_dont_use_autosuspend(rpc->dev);
 	pm_runtime_disable(rpc->dev);
 	return error;
 }
@@ -193,6 +196,7 @@ static void rpcif_spi_remove(struct platform_device *pd=
ev)
 	struct rpcif *rpc =3D spi_controller_get_devdata(ctlr);
=20
 	spi_unregister_controller(ctlr);
+	pm_runtime_dont_use_autosuspend(rpc->dev);
 	pm_runtime_disable(rpc->dev);
 }
=20
--=20
2.43.0

