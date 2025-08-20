Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7801CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.39])
 by mx.groups.io with SMTP id smtpd.web11.876.1755705905333892143
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=h75AO9ZP;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOxGigUYcLMFZBsrZLK5zhmEjUgLfGXU0Qh0T7Au/LcPXQh9rWRxryH9Yaj3dLoRRm9GPUg4N0klmJpyupzBjgJZyps1aaFJa4OltGD8gBtkojhrglxLbavPNTWuzhZBjyHMCMxkgiXTMp88XkAOtzxWIdXud98p/YRaSsKviWbwhx8jYHhIs1WQne2b15Km+tsXRxv/F5zSTyuv5k1U0hUo6PHUrJz9WdWl+u2/eHy/7kDJyPWZEgQnE0D6z+BDArt1j2qAZhN7o4EsAKVsEB3WXcj7o6SEl5wzJ+xRgPvZggbvrXtQxs4w1aRleLCX9s1v7E+J7Db6njvP2uws2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKunBN4AeYaH2pvdbHsvH6ws29l51BFXy7M0FDgAQk0=;
 b=XHAuSatUtOKL6mD1kp/FP2PHkCtO0YZFDImyszUk7tN+yMLxLLiLxlLk0Ub3CqdFhIwYAC2cUJzUGUG3As8pNxDNoHt8OrxEgKl2u1Oj2KMreIYrihxfi9V7WsKPIyvRfnA6EUFY6IGyJG8jCkFf6Kpk22WZ2pIzuyQTaWGU8fvM3B1WVXenJhgKuQBwyj4oDE4Wfp4dIDuRxCHlrXohGAoXF6zsFfKb51Bc5TuMR6Q58vx11rrGFPMTea49FkugFnOgvBlrBNfvkjd7SeXtEL+Te7qPNEhsi84PaqlabpSaoZF3S3O0LkTcb7VjasPupPWtpSBpfQSukdpr93qmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKunBN4AeYaH2pvdbHsvH6ws29l51BFXy7M0FDgAQk0=;
 b=h75AO9ZPe7sQHxob/XvYqknMT1+oeUUUnQael02mWz/eUKT9EfKtuj3jspD9MjZwaHhaCJuGI0R718ApEnsFP6QUIMV8uNdSgdmlrOWIWLm0rtGCeNIScmBEe97kCK1eEhIPcfosqnHsLPEw5fOriXYreJ8ztUtF33HsjlAP4iE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:03 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/55] media: rzg2l-cru: csi2: Use ARRAY_SIZE() in media_entity_pads_init()
Date: Wed, 20 Aug 2025 18:03:25 +0200
Message-ID: <20250820160413.801341-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bdef1d-ee91-4756-eb3b-08dde00352bf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+7QSd8QHBxpFYxRhjOqiyOkDWvOnhMagN7m3RF4zRX5IOvWOEyNeTE2fCzG2?=
 =?us-ascii?Q?usUV81wtrH30zG+5NoXpIJaOSLG+li7jhxGz0nQ57EXNMNMmNyV4UxFjCLTF?=
 =?us-ascii?Q?lrRFdbL0trS3Ss6U6fSe41/0r4Om0aONJK6GJnFj/Uysx9POkXtO35TPcYxS?=
 =?us-ascii?Q?Q2yWNKGfgkoXJpuXToXA0qWv3d8m8Gk4B5LV0j0ftM1LBFegaRJ8PfDX7X3L?=
 =?us-ascii?Q?B8q9p3A2+5lj3Ff57ieQdicat9ec4wITVJffC3gTN2/Nu9OWeumO0m/FzfTt?=
 =?us-ascii?Q?uKRz9WEZmqzysuicXK+CcR4bOzaCwz7mSVLdCreWS2pZQqLLo4ReIbh1heKj?=
 =?us-ascii?Q?2UH6Qc4WMNFvvcOFEDxrXMFrtrRPiysPxWQbC1Oc+D9JxpWUY+25S+eFPrCm?=
 =?us-ascii?Q?SPuygNuKvq+oEJkIs6p1o2Wd0Xcaq8tessp2znUOfdB92Jma1d9i3K4AYqE1?=
 =?us-ascii?Q?YCN/PbDXEcYKjTSZ48XFWjYHokKocyeB2Nyc+tw+/7KS7nZ/IFyy33Zap2a8?=
 =?us-ascii?Q?j93kJkHpmOtUUOonilCmPlj3q46K7MpvoZUnCNp6QGQiIgHQaKWwyDEVYMKd?=
 =?us-ascii?Q?Z9fgHOtzFjhjXQgZMlGINmOD230NbtHB2e6lj937FNuYuBz/ML/hcxf8wRkD?=
 =?us-ascii?Q?dsGo3F3kE+xht7kFdXM2NmS5db/wmumX6YuYOqzAZTPvV+SiWvLOLWHj5VfG?=
 =?us-ascii?Q?LvPmbPFNjUDQO6yDt8h27bpCmiSVN4Ka4G8o4cpu8g927v+n5eKUytVGRyUe?=
 =?us-ascii?Q?I8iXbdvSTuCAco/DfCQjEmltJT+VTMDIDVcAQmh4uUQggM2DArvxpVxjxhJO?=
 =?us-ascii?Q?W/W9kgdg6g79+jKDMxYq/3mioxSRgO8n9xtu8hsje2ICs2TUrf3+eRbTaIFJ?=
 =?us-ascii?Q?Xycr4mDWm57qYawAisLV+wRXzGKj1M/vVYbBm8+3RjJuRyQ1aho6fzRWOC4K?=
 =?us-ascii?Q?JvtKrfIO1F5pLjyFApWQgfFAI7J6tqfpE1QulTNmvTreDNKY6O9irUcN3ng6?=
 =?us-ascii?Q?0LS8743izE1rqsG1ct7m9yZhRXlDhIR0OLrKtEf4haACtGi6yJfxmHNRZRbC?=
 =?us-ascii?Q?eMc/MvkigmqT4tMgGG6PfISbz61VEPOqj249PYktPR606gydE2z7XaOsBwpI?=
 =?us-ascii?Q?Shfkep2nr23UwTk0sKfW73J471WjTmZ2PvTkf0nNEfA1kh4ErHFWyeg9nUj0?=
 =?us-ascii?Q?A48F+7WPAclF1bUcXcg2wHkJEaCdfS/TwuYvWSbJ2VJ3e3maz/drB9rFaJkO?=
 =?us-ascii?Q?vKfsn/jE7rRnvDedmCt4p847pGOPnGF8366z84i5Gk8NTShNvKymv/uTBBjc?=
 =?us-ascii?Q?Y2U63Ot/zXIFB5qggRoIbmR3wiP9is0JYaqVvoA/nHMn3U1wv/u+9LbIQwXl?=
 =?us-ascii?Q?pDJLRsggL/Ml2gsrDmUB0g984vOvCXRb1eEwUVN3sCXz3sZxC2GPE/Y9el4H?=
 =?us-ascii?Q?1pxvqCnlzEDJvXlmUCwCVecL3F4AIpwkdwhi8i7K1Eih+IrNMsqBg9Zk17vU?=
 =?us-ascii?Q?CLgoFtjlxB5EuDQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a78z8M5buKVdIlPeYoz9UNGM99mHLkoW5rpMovUTHBe4VfeQ0MXvnyRId+x8?=
 =?us-ascii?Q?q3+8S7j+dB/PDgJOKlWB9aYnf3u8zLbOUBruP8DmByaDSlWalJN8n9h2t27N?=
 =?us-ascii?Q?w4hzzByJoICsWlI/l4wlObFWlnKcEpTTUpTFUSwWDjOYM5tcMU6HU4/rxq9x?=
 =?us-ascii?Q?7KJZUW9aGSAenqshZ5ilia3JeAU+oHIoJJ8nsIEcKV5E9ypkWjY3M1oCI1ef?=
 =?us-ascii?Q?koAaYlnaR54/hs8YFlvjUZnItaFF62C0qydXSA8JA4OBKJUnW+oMg3tDuGEm?=
 =?us-ascii?Q?s3zXEX0Pr8YP/jpRnuwx8bAfgYR7JmZo8ioKBYi38LrYA5pH96tNwahs98eB?=
 =?us-ascii?Q?ztJs/LO2rACee7plaF0k/MhWjxysk+emgWCOJsJAFyi5eP3rdUL2w/aL3DAB?=
 =?us-ascii?Q?ahAaNxKh3mmLOS10eetAwwM/KgYo7QLiWgkuObCZ42gXPKUuZrZvMf1YmN7W?=
 =?us-ascii?Q?rbQKSkj2hDyaX38Ijl55sWQnz7V5D/rpEmXGRntBsikIb3ZmWmAt2qSJcjzV?=
 =?us-ascii?Q?85m1auBKvucLwCQDL1aY3P0rBXRkbFgIz4r0dwdGwCMlonSGVHyNCAbZFSgi?=
 =?us-ascii?Q?AMQNGolfxwup9p94OAa+O7v3K55kp1fdfBJJ0I2jH8j4PZB7KZusHob9L9yk?=
 =?us-ascii?Q?JhPA9/6ry7jMxSMdHqmTw1Ujmf3LGE4iwoRheTB9wkPJKQH7GFb35KTAZgiC?=
 =?us-ascii?Q?1O4cX9ehPnA715qOkUd/yL6yol1TsboF60Swe65m2K0kF+fGtrQnJ3IKKgnE?=
 =?us-ascii?Q?Jh/mbQ/j5mfdN/KaNe1Tq2fcTFERmKFoKmlB8sD2WZemS8ay9sETqXaH7lQC?=
 =?us-ascii?Q?MtZpdCHuIj8v3D6RgpTfSVWGwPk3llkFSxNzN+C96iCWWNQ45whWqiq6ywgd?=
 =?us-ascii?Q?AT0AyHYltg9UYlLy2LV4wq+BBqUsqHWhfOlwxd7EhDMo68nkrZVemTZI8Cup?=
 =?us-ascii?Q?tq52a1s70EyMsN7TmvJ/158dgVaJTYVH6H0a2xoRjsiYXRJSCcVB5+ycD8sp?=
 =?us-ascii?Q?LL4A+DLbsMERyhCzNLHRBLIKxv+U8C3lfVoLnadsoLpn5vAqpT6Ssm+emjfB?=
 =?us-ascii?Q?8nT4RNZqHUwOMJmw8z0xIc+xPCueWzHZrYOxD1U/BJSp4kJkfcpeYQbp1+l6?=
 =?us-ascii?Q?Aak1YR7zwifTK/2BD9B1kNUvCjFWuZYEVAH5F9UtitWD69DsxblR0k80FTTM?=
 =?us-ascii?Q?1yuRz1jkrPK7XCyTa/hpEQ3d+vBCbH6rsY+Jhdt1BR0Zl/TfuW3ybnyqO4nu?=
 =?us-ascii?Q?bnT2VKo1po1sdv1NwFdfbfaaah/BRViA5NLtx0MflQy1nqfLTXeuA3i0HLRE?=
 =?us-ascii?Q?iOdPaim35OQOzbmOIk4OMAdmGsBQZiOcPFkAzIgV4+9J3MkHVTErJzlGbkhR?=
 =?us-ascii?Q?LngduOxkXU8WHmO/nkYlHBfDmy28fAPjwVGaKIhAh07Kf0YOTCx2JfQ+U3+y?=
 =?us-ascii?Q?ez9uX1fd2Y7QjqYfjQWnhJNx9Ojxa+raHruqvcjXiWzn8VRYGWBiNXt2cll7?=
 =?us-ascii?Q?2UyvU+E26MKJsJNR2tFNx0M7h2/1lkL+urwD+35pIwTeZw+2s+q6HaVPdA/O?=
 =?us-ascii?Q?c+/fuEFJMGXURc/woNqXPvR1X/vFefdlormy8zusv31NnLcGsBqcjm4LQisc?=
 =?us-ascii?Q?vf+LSwZgcEhvCEQoGnVlSVA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bdef1d-ee91-4756-eb3b-08dde00352bf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:03.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er7q6cLLdVUvqu0wbi/m2SaHPvn3f/X25sYCG5zlrL1rhzkcjG2QpuO5h2yyjETaldiE/EuaVepH9bD9tKcMLR+U9lynPnnvyDxNuWx2ak0OlMrqU4WUMs1uWEJd7Rx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19834

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
index 5d4a54b0df85..53cc4a7c1d83 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -801,7 +801,8 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
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


