Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C217CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:54 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.web11.1018.1755706129196453865
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wSlLkiHQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5/xQC5Xxs73OBPVN3ttsRBp9YA+sX7oTzZoK5IDNQRPOBGn25XfvmhE4nyXh/Pax8C9jcfw3nyGHSjf2v7qp5tmTTLcbS7LqzUpunK93NB70hLqT4r8KsmYX7UZEKkrL7DAsgzG2aO3XdTffMPxCFGW2jPPDTI35UyrX4RgTjuHjDPPZB2t/78hPzpCU/kE54ERcB625hJI6uisa3as5I2AcN1fNHPxizyH6jfB8ol12xNw6+UBCi9KwMJEk35DbCrYlOr8p4vnPEeJjJgffNSrVSFWi8A4fxix8DA9bA2dOTL4Bra1oyXopPPbLDUeMNxw3curuNaOVo++Hoh9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzWYd7nEdTUGcMii+lzNGrThGYtfemB4jAK73jPInSg=;
 b=UM+5xK2vF9VhUFVup5+tZwJbSdlHNZMeuSBdDWsOM2GVarmpyFsEKS4TNxuzSxcv5qibC96Sn6UGsYxs4HF8jWBCQXJ0dTzGusPFIYLa5RjRwYpN4jUu5Lf8lcrbPQyQpgTIKCDll9dEaHI6H/prXINgw/vkygcqPYQ0KU7sO7PGKsmeUA8H/I8S4ZLNY7yiUPEm8bFYlMi8QMdXYFE2bL/yu4YSfibt+o2PkX11HJbKR1NSWah1XEUGOKoT1x07A3tUpp0oK8q3tNU0R1ZFL1AHYI5CaIWCRmOUqW/GYU9UOtxQFWBWvJU82axdnqsCVzBQjldDlKQ3Bi/AQNBlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzWYd7nEdTUGcMii+lzNGrThGYtfemB4jAK73jPInSg=;
 b=wSlLkiHQ6kd8btF+3lJGHGaHSs7Kd+sfvnSoGo0YFSVGvC+zkVL2YUz36jV5wp5eQSlsKDsrMOjhpbNoCcf+TxzAsZavBEJzooKv1LBxz71lQM0E6n9/hj1FuvXKcVYYGVf/HktrgW7m2G8b0dbB+l2KSuXRqrAQCc3rX0EJQw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/55] media: rzg2l-cru: csi2: Use ARRAY_SIZE() in media_entity_pads_init()
Date: Wed, 20 Aug 2025 18:07:10 +0200
Message-ID: <20250820160758.801813-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 7668d710-9de1-4119-7eb0-08dde003d781
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?icB/39//awzd225ckBf7ZJia7IGbUTtI+YoWhQV8qYTC2+89pzZP67fjWkom?=
 =?us-ascii?Q?YOZ7VIeDXPrQvxpg6K6W2JMc4KXpCPrApcELZQmkakE41/ZS771KL/JlgNCP?=
 =?us-ascii?Q?On/fYtKyEK4KLT5YBdnVE+2YP/iAehVAAP2AFslvr3PlRdtUmTh3exNCJz0m?=
 =?us-ascii?Q?m8VpvTYlUMxRTOCa7cCoBArxEvXX6utIk5c+oEEtTcIZMlWaoW+j+lO5ZF/q?=
 =?us-ascii?Q?/1wH0aj5U4iJ/GfB8G0oPy9UYjctrUgsOQrYNrbbzBYFJz56FXY1Cv0VX6LX?=
 =?us-ascii?Q?Vm8eWypy0QmO5S9zU2hwPsDPVRbecQqe2rjcJoQfQU3gNYG3BcxMid0tbJ2N?=
 =?us-ascii?Q?nXmW480/FZfeMf7R9vFzMwp9rPy192/nPBnBzxy3lxpEFzNxRRrlDcSp83zw?=
 =?us-ascii?Q?4IBsQuX2WEx1r2blUnQ+r062O9KXmyHmHfEKFSwSv0/39bHf6Lr9NL8NfH6p?=
 =?us-ascii?Q?gHDYXrXjV1j2k7QzNQnVDf9YsEcDlK34oVcQP36MWdMKiRcZ0WzTQvT0HuYB?=
 =?us-ascii?Q?glAjXS1EZaEvufd6H6AzPQXAHzvFZRFklNu0AskVTWJXywKaQlQem/LHOSBn?=
 =?us-ascii?Q?Fqbh+Ly1zB7bt6/2QWgc7Y/XyN5qZSxAOgVIxdBMPRKrifnNVQi4ve2wo1Q/?=
 =?us-ascii?Q?/SJtlASXXL9kdUPYASfgnGFgDBcjf+XeWEemvZ4Diu1Z5KmsX4UBY8Wiz5m/?=
 =?us-ascii?Q?1ejRXkcWOMH4sVHitYgbUlKhejYIoQEl5SL0piBJnvSvvLiGJEN6WBuZNb/l?=
 =?us-ascii?Q?gU/NIfvojKxdFYfgK+Ha6ry4xXbMUL0GngETY6Ypdga7FNXn8Dna5MbbBIqM?=
 =?us-ascii?Q?LCri6U1Tz+g0vDK8V8PDGPDGC+W0SJBUK9iX5LckVn5WpNwlsv2QQYGJ8IvD?=
 =?us-ascii?Q?YobwtjsarXnlMPjQmGYqHxZ4Hm7kzkRT4VAAUcfV7VQbGkQc8xbp7hR54bDk?=
 =?us-ascii?Q?ygNainKhZTsc103wAdN6ju2q/tTXLg6+YxyakhK7i1C1ffVhaUckwIPGoKOB?=
 =?us-ascii?Q?OCVcT9jond/WWO3SUqte7urPcQERwiAShFArppZMWbGgQHCjeF4lMOFE1h8h?=
 =?us-ascii?Q?XJmkf181IgYKoMlKp0HrdwevVibRzFy9lbb62yRzuIuRwQ99pP4H6KEPTQw5?=
 =?us-ascii?Q?aWbMWsqOJ5mIwmQQDHoXRSNOtxkt4l0wcyE9XIOkhGoIr8UpjrpvgQjrthyM?=
 =?us-ascii?Q?WhNnGLffXI2yAjjF5FQjpI5hOGLrPu1bRgl8ojKHSYmKqCgVVlr+hFjd8Zy4?=
 =?us-ascii?Q?otqzrbIGAIRHALtqzcjH+UowbuNX3qSlTYS2gf2kKl3LauCk3JsdczDN4kEv?=
 =?us-ascii?Q?fH0q60n1RADvM4BPKjFxpaNV3B7atxNKccZxl3/uEyFYwFNb8bYcWOVe2qgv?=
 =?us-ascii?Q?3brpHc7A5FOG+BMXzKLEk2Qrye81yIXCQoT4AzV5i9TqfB4CXryvaxTPk2xv?=
 =?us-ascii?Q?HuDvJhfh2eZfKdBVHjWU+Pgen09Oqd64U1C9h4vH/sdyClbhS6Qy5CJ25HAu?=
 =?us-ascii?Q?0mvwEdmMSA2uj1Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xenX9nw8Zn6UJaLPe/VLlCycSWHZ3MLuGJdZwRVW4yBucd6vk9M3iUnIrIgg?=
 =?us-ascii?Q?1vh5TCung+FZuRVzNIcqTx4WW/lFqvVNvSj1/1LYKIgr6bVx1AHCB2fYVvId?=
 =?us-ascii?Q?xgjHhd2VYHkHqtX8IehUShH2CQj9x3FcM46h/TNQL1zUPBYQToST/ChYPrsx?=
 =?us-ascii?Q?zebggq6QQ7xlM57zkjYmbWKeyOYLHZwOlebrwDqogeXnQi2DXJzWl+6/3a/E?=
 =?us-ascii?Q?w053eREtSPSBtnSr2Pj3onSWr2SlU4w0OwX2gtl7t7hfpAekDlTHh+12vLD5?=
 =?us-ascii?Q?lp/KOTaI7EBGORYnEecwITbuvskcRNMCXHZBf0Qae/nir0lKDgPeidVxUE/b?=
 =?us-ascii?Q?Kc5JJcqDEl8oS3QhDbyhlsgOs+m5TfCEDD6fNGQVI4pT01UJYA5eJB/Dbmw8?=
 =?us-ascii?Q?mORpdHVST8cTU8XL8l9TrEtPpDr7k/s4PqTqaRvL18eqQSN+DUvoWQ41Mjxg?=
 =?us-ascii?Q?2B0e2yEhCCf1eOpDaqDa5Rz3zXY5NeEDQBMCZ/32Pmq7CBFx6E1yaWZciikn?=
 =?us-ascii?Q?cJWRhNiVJl6W2f4vAxrHyjYpQokm12jaP9Gtvn9oAvw43Lio6y+FsZ7ZO1Nd?=
 =?us-ascii?Q?jGf6Sn3taynzAOVvHC9RNa6cubE/UGkTgFqvHSUOLGpu4xQd9jVz28Ai0oDo?=
 =?us-ascii?Q?zXErKtHuZshl0gl6QPnQoslIaSupxPebkljRZEjQGvN2UcQoUk5tHwMPCoJW?=
 =?us-ascii?Q?PXFiME6dFPS2dXsJZB6J8fFNLzZdDXpOxgTmYUBZ2P9EMKqehBgtnihMvmzA?=
 =?us-ascii?Q?0XNykq0+v81QCBqOBc7WpEFXhTbXkMvQePj76NdTJAH+qvS0rIPuM5eXqcpP?=
 =?us-ascii?Q?B1t1uOdrSdfb2wgPPuHOP0vujj/crf3ULzoa1qqlaoFsr5/vtcvxXSpgYdhh?=
 =?us-ascii?Q?HhTOe6pw3bkN9lRyxK733dSApdeUVlMflOYKIwirOg9BXgkzHipvJmgWIW7h?=
 =?us-ascii?Q?T5iU1wvjhJBliTpH8oYOBBPkYqOYmaCTcgJKwK7WkpiwT25sZYUw1YV1zxsq?=
 =?us-ascii?Q?561fi9yhyW/57VSEL4KxZsUU72bZA5YqMcd0F4T+Y8s9i5/+RSGuI+fZopei?=
 =?us-ascii?Q?mBBScbn9OsE5t3KRtA+G7HbYkH1V3NUQJBiiEXfEWqOlOQuvPegDqn5Ims7V?=
 =?us-ascii?Q?PcN2cNAQDbVdR44+wq3qLcnEz5/Blg+j/BGMuB03ObqnfTXkuykHbtxNgwMb?=
 =?us-ascii?Q?ZnC09kCedc2+fwgJXGGfT65E1VRdGJF5IaBkxmy9pG2Dw61upKzjrl6MMS7F?=
 =?us-ascii?Q?qhRer74Qu/M38Chg+E3uHnRipMGUgoHnkBw0VNbTVVXBy3ME6x1Zi6ew0/XF?=
 =?us-ascii?Q?nxLDg8AXnaY4qT757L4w9EqTfVxoaCVhRWaBGXi4Hl9Qt+twdLqXAs7Un3ix?=
 =?us-ascii?Q?iF92YrUKzfRH87eoTLkrRzVWH50BL32725Hg8ORqiY42HPde2rIaJBrSskfk?=
 =?us-ascii?Q?JgAHgbFdtj1cdHd8FZ4Ud5UMNXbZB937Ezcl6/guTilR7WK5N1/PCW+2BT1K?=
 =?us-ascii?Q?9ri6R3sBoOkmhdkUn4Ljw3VaGvJ9l7PHYYRgCrFbQTxv56eWxdqFIh269cqI?=
 =?us-ascii?Q?Uu067aKlUO4M9yfNFatyj9XM1tUBwPGGaI//HD6JdE+tH0kx6vWnwurEyIzF?=
 =?us-ascii?Q?LCNLW/56RrNzhF6hiq7sZz8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7668d710-9de1-4119-7eb0-08dde003d781
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:46.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqzkw0uhFkCaFDZMx5X9Cbbutc7eTFvJJEhAWa0ANYwQjZhAk+2ksAo6Oz87fvwycodhWP5m5XQmZ5q9dTf/k081CP4dxA5tIfcrqlI9QweHpSlmABd8C6roGunhYfML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19890

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a5754e5db387b90e6d2090e58bf50860e2cd8c7e upstream.

The media_entity_pads_init() function was previously hardcoded to use a
magic number for the number of pads. Replace the magic number with the
ARRAY_SIZE() macro to determine the number of pads dynamically.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 2f4c87ede8bf..abacf53b944c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -804,7 +804,8 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	 */
 	csi2->pads[RZG2L_CSI2_SOURCE].flags =3D MEDIA_PAD_FL_SOURCE |
 					      MEDIA_PAD_FL_MUST_CONNECT;
-	ret =3D media_entity_pads_init(&csi2->subdev.entity, 2, csi2->pads);
+	ret =3D media_entity_pads_init(&csi2->subdev.entity, ARRAY_SIZE(csi2->pad=
s),
+				     csi2->pads);
 	if (ret)
 		goto error_pm;
=20
--=20
2.43.0


