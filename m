Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0676CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:03 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.7])
 by mx.groups.io with SMTP id smtpd.web11.913.1755705958786965057
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UAP4r0eW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwCrLSfaaLW79Z7fnknd+uiIJXas4cyo5HGNqCua+dafwABDApmOUNkbGg1r31b8LJyxKrqjtWK91ShcVHrwBzboOZIA1XS+4//Qf1E0Ld4OCVFPAbHIjXtDwH1CHYW0YkTFagRRUAWMtEEtTmYvMpSGZ8mXgqwD7C/pbJI09zhN5plfh0k7gvi9VFk+i1DvBW8sBlCcYOkNTJ8p3qF9oOov7QNWAcklTHuwZAh84rpCml7lHe0BZ5mVDA+MfRtIdgk1UkKHDShqs2Lr9xHruKznff4W96oXd5jSRAxrIkCNI1kSeLwqKAuMGS6sLFRPbalTCJcYAruHvZqydwmDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg6GOOzrpVwbhbosziDiupXmF+Y0pMpbuI1vgi1xD1s=;
 b=hQEPuvaYXuijpcmGlXHDbiTn4iAhhi1awq57iklsmq7larVo7oeuC4Onwx8CTvKXRbwckoFCOsUDQVg5k/OO+um0NHaOrW/LiYdg8iHtIMxaIpDdPONiw4rboWF1LiCfn6f2VXa3YLOsTLZyNDsOGnQaruoJqoNtOFaRwiQj0Lq/DDhsQAOQQZdOq6UsxuGNfCXQ8SJJf5d9dJ4lPzuLzt9HWajo4xmRvAOSoLlZnNX1PbDjrUM1YXL62HqvBnWWsYsStzQwnQNE23jbCMNYuLneP9s+prIdF5eYNYlhmzHRzzaxbjVHLjSLO+Sbg9lF6i1WwJiD/qyXdXZOnT1Wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg6GOOzrpVwbhbosziDiupXmF+Y0pMpbuI1vgi1xD1s=;
 b=UAP4r0eW7TmXXUdgUUrHmb2tmg98jNZ5CrX6mi+EKh3PLCheXN13cMiM8vn8jbAv58lg9i7WdPp97iXFgXvE0zSabFAvbJIEsvUAemZ2Wm4TDQHt+sBpXzoP1oXZZ25NdIRYnpo2fNF0rhZWBX4deJ2eF2IEV3ayTKqnPGkSqzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:58 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 31/55] media: rzg2l-cru: csi2: Use devm_pm_runtime_enable()
Date: Wed, 20 Aug 2025 18:03:47 +0200
Message-ID: <20250820160413.801341-32-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fd8cad-7ab8-46a1-bab3-08dde003734f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DSrz1Zs5s6XKK1Y+j43PSH/piE0WBFveZdATxWB2qrFxgt/dCK7VVOMDl3Yv?=
 =?us-ascii?Q?9cMxCDHBv2VVMRGuVPzuf2YDeMEFknHm0ZxSFXvShEWwbmYtC8/IfVC+vnY4?=
 =?us-ascii?Q?ip1Y8qvjVZSulso0++DlK0WxSYggXVvdZupydN9cZgc8bqFllhX6NmT54xVV?=
 =?us-ascii?Q?LVFkA3Ro/Tfc6BbbPgbSXHcp7xF7HfhFJevUZnVXLx/1LVrFVrb2xePNB3R3?=
 =?us-ascii?Q?3kiPGmEu5rY0nEZuPnIC0W5Vri20FHR+OkBhVBM4dR1KPmFKKJ94fjK/Yx6E?=
 =?us-ascii?Q?1xARfb+PZdStuGXlezbIUtzix7TCnGi+URH8+Lc5NIm3vavPOCiuOKSMefQl?=
 =?us-ascii?Q?oZpr3eLmwHgwqanV0xUY3FAB9Pv275KwJDHLTEszIeV209I4Lm58z0roki4S?=
 =?us-ascii?Q?s60VKZbprz8DBSII+23Bo5A3OTsZEIpp+4WrPn9hRo430QqtjufsxCrYesJB?=
 =?us-ascii?Q?E8yMxwbg9je14XBk1ANjIYd095LT+ZlauT1CAuQpA33vTRPSCZZH6xXYSO7w?=
 =?us-ascii?Q?lkSGrBod3e9hY0VH8uC0hx2tCRHr3ccs7i/0R/qyHKTQb60No24U5uLCBhmz?=
 =?us-ascii?Q?5P4o16ajzYNWmYBY0DU6d8roZJ1dihCfZ+9JJZGIq0Vihdf2K24DwnBxgVTD?=
 =?us-ascii?Q?lShz/X74aHfp7L1XvGj9tbcFdWjPQGGOKELpYH+Ii3+9EOJzEtnwoFmrIecV?=
 =?us-ascii?Q?3zJmixWNvgKFs9PNC+ZVQKb4ArQwVIA7MXB7gb1QPcRYRSkIEFmt+S2keBAn?=
 =?us-ascii?Q?8jiwvNZTJXC7T3q7PN8FAPDawmkk8AR6OboZVJlNS9u1AJi+T1RTnFhIMo+W?=
 =?us-ascii?Q?CB4swj18RcKvtmbWOAhfTJLmcO21h9fNOcscUcdobsVhe48IISY4ReRgbkF9?=
 =?us-ascii?Q?9WdJq1OtAHDM5j2hQ+8IT6YAX3D7ZixP7LXGv4AR3KxevgxeJ6A0Ey3mbKax?=
 =?us-ascii?Q?Agse5aG3rZcVlHHkhriltUHLbVI1D5EKHVF+Hl7l/Q7LNM3lqfc39VUZv7XE?=
 =?us-ascii?Q?kg/erp39cJZqfsF9qZ1lI7cdQTS/CSds7H2d2Yu0TaQU+DwRJoth7Nykrchv?=
 =?us-ascii?Q?iUC5rFHyaVzCONMsi2sRxsf1y898V2yyNJvA2Al07AZbDOeuWYpEzcOMk7q3?=
 =?us-ascii?Q?HeQ6nzTR/TG3DmpYds6hB/Wz8Ml9CogOQg7X/T6hv4O+nYXCMSJysrrEHOyV?=
 =?us-ascii?Q?7Cb760vUs5W8FWN0Qog8O6k+PhrSvUFaYYK24uf2Cyf+F4GUbNJDv1e+FU57?=
 =?us-ascii?Q?UbMgCn/esDD+AXh8EXzyMAf4H1KBQlUa6bnTY2JRWRUlDiBA8HU1lmKfmxNa?=
 =?us-ascii?Q?oxP7kqSkOWBNtF3vlvWLE9slgHJ1YtTyVRIUN9IMc/CDbaR/ohuupNEgzsa8?=
 =?us-ascii?Q?85VclMV9DuCvjSe7OoA1b+SFyMALMbparoFMLfsX3RFnqr1HstOM5oIqxa6s?=
 =?us-ascii?Q?2+J4wCrIXwDbKH5dqP+GvN/M+dbmDZ/d2rePrXpVUIKysUPEyEkthkzkgIDk?=
 =?us-ascii?Q?hUVHs2J9vDa59sE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ioiJHaqOUUjU50XMzODfla7L5x5PoWIzvKmkaHlQmk+g5vVAFxKV9xHXawcI?=
 =?us-ascii?Q?SQCjxRHeTaCG1MGAwaLF8ReprodjkU/FQ6EPR34eF+Ytg41xX9lyFnt+htoC?=
 =?us-ascii?Q?1TYh+srzql5C83XrVV2EwzU6SXIfrnFujsimyEPKo0MWIVHntffyb4TWL1eo?=
 =?us-ascii?Q?htj5ZOANxq+4HIxNm3vf6S/l8PNzFau+mtD3U7TLf/VrB4ALhnVQAo8Odg0K?=
 =?us-ascii?Q?Ww8qxLUD0Z1j7kUCkN+eqnUBTEzujYbRPvHUaD2npVHVPLJs6IzMWAd3sBDF?=
 =?us-ascii?Q?rHC64JDBgFYxVnGFwpqBAMPqlc0bGhpntFdmiXTh5odJkNzNp77zLc3l73CR?=
 =?us-ascii?Q?Y43JGsPpAiCgVH95UjAxfhYU5RdfW+3nnesfsDXswUFuL5+nQLeCXGjrmR/V?=
 =?us-ascii?Q?E53ReGL7IscfAqIMMmEmnhkbHdxszk/yBJsbw8NklwL7psjmBuNBdz2LbLk3?=
 =?us-ascii?Q?9VuBxo9s7VZDmMn4hqfIqNStoYn8a8kt5+1+7u3kKvi5r0z4O6ET1e0JD3en?=
 =?us-ascii?Q?jdcE1LBdlnc3WQ57a38lCfaqKKuXTcHargjSailNkRsHyKoXScLgEZRjAibL?=
 =?us-ascii?Q?LT2gJpWt2Pi6EMDC+eDfrXxFlzVY+AuPyhwp6bPvHm8oQ4rtLKaXWmz2ccjy?=
 =?us-ascii?Q?kxLpnbYR3UuYyW0h1e1BhjzfBIu1EupjHAiKWLPCVvVcJ2o+ZvOAKsYPpAei?=
 =?us-ascii?Q?qWpx2vlr8bUbvW2/4fwT03GhxgKFA8bbAM4VW2DZBHxshboz0DA7qj8DyZJP?=
 =?us-ascii?Q?V/jaUiywp7YoSriaA1L+lslIZi0858cWpdeGfGSOzrHP0fAjP67/2iUXtSW5?=
 =?us-ascii?Q?8vwTWlhmqdRaLdrUi/DNmd1RFLh78gj7iq/V72OjGmbt6H1gV2QBbiQs3+gD?=
 =?us-ascii?Q?WDqqKEKpaAcxDJaMd+dVd/ix28xKxuIlt5lcUnkMOiyERmaP9gEPjPKNn9/1?=
 =?us-ascii?Q?Ow/y6tJYcI/gkGTbT4kCWBWpxJDJXEfG97R40IvWp71co0017YUsqu7KwNXJ?=
 =?us-ascii?Q?ORe+Fc/yUIFLUabrN4FtnsiMYdYTYUXcLAxTfNejwpYItvHO8SKr8idmTY7d?=
 =?us-ascii?Q?VyKD8ANUNYP73W5TNrRDxU3rMeKgMp4vfDMufTKIg9f4+00cj7X+Nh3KE+9i?=
 =?us-ascii?Q?hdtbEo9nry6FI/Hzeut78jTqI/YiTcsBs07EmBKPaR856Y7kV6XT0jJOANF+?=
 =?us-ascii?Q?LO1RnRClfXGZrAypekaBg+b+UKgHYHw907H0WH3mX8QHkIL7bRxb4XZH6KwC?=
 =?us-ascii?Q?8aRrmtnv8hdXT6eYACNk3l1DUvqQ3zv7VxAmy6hZrxAm+wy8ROR5GeKl1Kre?=
 =?us-ascii?Q?VpLowWPwjJzhS19iEIZBzxy70Yc98oaXjC3iFwIStCHGbrQtGP9LCrrLyP/m?=
 =?us-ascii?Q?7chanT8gsm8UFqF0mJkj6lSPnbVpM7YR3Tnvd7pUfD1yvgLBXeDn3s7gKK1k?=
 =?us-ascii?Q?tJ9U8BlyucEJ1OdBQCbxyyEhy4eWwz+uc2cNNiz3huhoK3V2HjuYPlQFOzX1?=
 =?us-ascii?Q?ZAO4isERrwabhEIdR07w1NScwKF29mh6n+AM0irGZCLpLCluKtWO8WDlBtVa?=
 =?us-ascii?Q?bk0zlcJe4jPtuB9F91m8VXSgHArMiLyeTZkyNmBkRvJ+TQFqh6URMzVlu+kL?=
 =?us-ascii?Q?Bo4w7CjNjyzMraB3S6n+XT0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fd8cad-7ab8-46a1-bab3-08dde003734f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:58.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHjLZsRQwvmVTkw0wqFeOycrH4qFp4CAWFNTouMRULjmqag2g6xft1bXy0tUYa/BoXYzPKv4rUkNRS1VJGoOkd0EY3yMONJfGqL2dHqnyXlNNnv1urEBhMVys7+Gel+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19856

commit 198be9e98bda5b18d203134c293597e6add9f5c6 upstream.

Use newly added devm_pm_runtime_enable() into rzg2l_csi2_probe() and
drop error path accordingly. Drop also unnecessary pm_runtime_disable()
from rzg2l_csi2_remove().

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-6-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 5becd840d706..eacd7941ac39 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -803,11 +803,13 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 	if (ret)
 		return ret;
=20
-	pm_runtime_enable(dev);
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
=20
 	ret =3D rzg2l_validate_csi2_lanes(csi2);
 	if (ret)
-		goto error_pm;
+		return ret;
=20
 	csi2->subdev.dev =3D dev;
 	v4l2_subdev_init(&csi2->subdev, &rzg2l_csi2_subdev_ops);
@@ -831,7 +833,7 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	ret =3D media_entity_pads_init(&csi2->subdev.entity, ARRAY_SIZE(csi2->pad=
s),
 				     csi2->pads);
 	if (ret)
-		goto error_pm;
+		return ret;
=20
 	ret =3D v4l2_subdev_init_finalize(&csi2->subdev);
 	if (ret < 0)
@@ -849,8 +851,6 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	v4l2_async_nf_unregister(&csi2->notifier);
 	v4l2_async_nf_cleanup(&csi2->notifier);
 	media_entity_cleanup(&csi2->subdev.entity);
-error_pm:
-	pm_runtime_disable(dev);
=20
 	return ret;
 }
@@ -864,7 +864,6 @@ static int rzg2l_csi2_remove(struct platform_device *pd=
ev)
 	v4l2_async_unregister_subdev(&csi2->subdev);
 	v4l2_subdev_cleanup(&csi2->subdev);
 	media_entity_cleanup(&csi2->subdev.entity);
-	pm_runtime_disable(&pdev->dev);
=20
 	return 0;
 }
--=20
2.43.0


