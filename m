Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46756CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.17])
 by mx.groups.io with SMTP id smtpd.web11.1057.1755706183701525022
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sxxykx8u;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW1kcFNMypq5nP/GRRblC6t6Y9jWmTxmi9fMJjIwRoZncEINUKO0xS0T52wDz9+rj9BlwkOcd/njVTSY6Op7Exb8/WADLmqiJvTQbwR83sJAO0JCku9OGJYrdZSX0PO0J/2aSEgxfGGY6dEQahYcxnAcJAkUf1pRzbGtoH0UTrtSnWgSw2EelYd1BMsAFbicNl4XC2HBxn66yTgl7WVq67xlyNF9/nxky5s5YkiF1N+CXz8ZykaR00QU/n3mqbeXJMWo8YBeenibVGBHGRPG08gCzWDBOccSZ/aFOUZh6cPyiCXrqqZlr5ErVGkkU8gwLt7AjVj0Np0ggkrkDgzcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZ62JzdyrsQ/HfzTO084UHCuTL7KBlRvfBiXf4PCyFk=;
 b=yVl6FSP7unoOY/8OXolECX4jZlAKHhR4iOMO4T7qZioGHzQNAYb69GD/5oL7v30mmMUmQMS9ihxdxrljrhqx/ZWTOWVsewgYuRq1NZqvxdHiHQmaMVtkau12Xvo+woIG0ldmg2RX5JTtWHrNkYIjuyKPbnY6obm50QB7J73kGY4U1h1HD2ewMd6rTt+wyxFhcyRhdtkkmYy1pYltpciqrdC21YQnoIw/QSeVcgoZ8JpwiVT9oA/Fn7uRCQMgYEPURFJp4lfAsms4TCcgjJbvEUiJprTyNM4aUYBW56yQnTaTIuDPao8as8YzKHpv+eMGF3bPIN4Q6dYo0Uq5Le1b9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ62JzdyrsQ/HfzTO084UHCuTL7KBlRvfBiXf4PCyFk=;
 b=sxxykx8uWZBuNhewycUfiwRX5ISZ8VJiHyZ13x40q2XyWxXLm8BbfdP/53lJbFTV9Vel5d071Sg9q7QEjsrdl5wPkFx4pyU3wTqxJbOsnuWA68VhZF+WaiQCwF4ANjnQYGZ4L+/B/ptrXGzkgwD98xqZd7nJPGUm/LkXTjAIv+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:41 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 31/55] media: rzg2l-cru: csi2: Use devm_pm_runtime_enable()
Date: Wed, 20 Aug 2025 18:07:32 +0200
Message-ID: <20250820160758.801813-32-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: b1071db4-9623-49e2-5efc-08dde003f831
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3SluqIu2fdrfqBgBAno19y3xJjVl6LYRACxAKxEcZtkqMBxg2cjHip9K28WH?=
 =?us-ascii?Q?GZSiRSd92fshc5N9tdqRVh16Xpq6zUQN3Ax62oQKfiAtx17kSgSv0U8UxX0w?=
 =?us-ascii?Q?TwmZYNHTRvPjSiyWgIwrzOaqQXg2vdu9yp7rFtQCsv9AU5tLd8js4jHIB0eM?=
 =?us-ascii?Q?vVPolf9qApCmUf0KoQXz0HGI7qtt3+8qntsYZKtb8XqlSQ0IPjRMYKnlZ6TW?=
 =?us-ascii?Q?MW/QVCHX6TbOtUHVCTY9Xl6Il3YbL+pE8XgXS75wgu2hdYsUmMMaj2HH7UOy?=
 =?us-ascii?Q?vxzfg/OdNygsjzihckWuWKu0jNZXJJQMh44/yjpInwhFsMX6lnV4GRwqdHkf?=
 =?us-ascii?Q?e7c7neNFPowiyBo19rDe4IFrmMNiFiyk7zfjREAF9z+w4g4xaVNpp+ilYdiH?=
 =?us-ascii?Q?gmxQskMvVHduCmLnl8TMYG5T+ZvLhZpEhlm7dMHXnQJGUW33GfZJ18pjrYNb?=
 =?us-ascii?Q?wVf34JWYUKFpbla8aWpcuW4JY582Ged5ZAiRA6WDekYznO1dVQWP3If1+nZc?=
 =?us-ascii?Q?4PWJnuuOdlZ3xHLjHK2uz0wo+5z8a8HkmrcgrdKgLB2628oGYQnMdwlGl9ns?=
 =?us-ascii?Q?6V7HpeyHhJ7t6XuHE67FEqcs8Q5UQhLXxDQCDOl6DNTh0hnyWAb/tIVVgoVo?=
 =?us-ascii?Q?jQJM12JwiA3JhVFcuWxiZ7YNjxuxQ3TTJp8vRgsP0a9rIYyY1mJ3tcCnlBhv?=
 =?us-ascii?Q?lofHkb4N4PdFLb7CYcwekk5OaF+vomN7CBG36Kn3EEQhO7E6Gf+9wi2UdrhW?=
 =?us-ascii?Q?UaINFF3PSFbqP6ooHrb64128XL+/GIrsVPDxYxfXlbAHl0ru+hL3VrS/5Ztn?=
 =?us-ascii?Q?zNZQO7848wRCa3t0uVJoSt8D3ek/T35AbV/N8g3Vhk/yJykff9KgSCCx44Vz?=
 =?us-ascii?Q?ycMFcMeNMJVhWTKChSOmC4cGv5H07Ii04WvSUf1zlN7/TocL083DgEEUwWkL?=
 =?us-ascii?Q?Av7NZcjdfY1Iyl1y1vjc5n5i8indsTIT23BP9aKzy2xKt9gp7HGzbny5cln8?=
 =?us-ascii?Q?HlacxkPhlsEOrWB1sSv3PA6Jh097Vwm8KttuEj8PL5YdSkQMp3frDk49xo2l?=
 =?us-ascii?Q?8CvsIR9gCN7rHlVIf65PFyOUMb3JG/I69b5Aq9pBjdSVGpjTTeahc7tCdy0i?=
 =?us-ascii?Q?s9Dj1aae4mitbr3kXE+nng/C/zsVknyLyL+2kwbrnLaBuL1XOvXzJ8gY8Q2D?=
 =?us-ascii?Q?GFRydqeOFmP25MXdFpvYWznWeaCMkonuI3A7/X44TzmmomfVyq8rVf3AVO/d?=
 =?us-ascii?Q?/PT0R9epPD6+8wGSvB+ECKyfBusJFXz3nH9IZR+Ttjh+Y1YragtDOh9epR55?=
 =?us-ascii?Q?8GWbsHta37QN7JbOpkGTDH+0vGW1yym82w8g9w3B6+kEdCibWWW6AN7IYM6p?=
 =?us-ascii?Q?5K2M6S+0eSl/A/L2ulfXeo3Vs5wLyXo7Hk4nXJSHw9U8CyflITSflcvWWALp?=
 =?us-ascii?Q?17TGVZ/neGsuEKzCxnuStry5lUItM3d04enUMKVgg/MnXJUWb6QL3yRjFDWw?=
 =?us-ascii?Q?QlvVk6ITg4r73RE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y+BjKJVxm0ZPvBlTJqcSqtt0WcJ/nGRQqpbg1OJnBMZRbE2fOdOoN6GGuaoB?=
 =?us-ascii?Q?956Yi4b8YdtgxNe5l7IGcfMHBNOvrTxx5aIKwXgT8ZT3cZ8q26Qy0ncQsTOs?=
 =?us-ascii?Q?hSa/6mNSZpiOPANIDyKilKF9EDwCCaNx6NTdxOdP/4HyF/J+Oe95DiReUxhn?=
 =?us-ascii?Q?76bKI0pGnBdUUQpyppVGwWtAZan7ylONLk/0aJZyPEQzYWAl+YUS5Pu/1p01?=
 =?us-ascii?Q?j4E0zG6zHPwOPWTP3HQvxhoqrvtOBuWtr/MV4Zd/0wGoGQ1y5JtkodfSiGQK?=
 =?us-ascii?Q?X/vafzZBAltiLETvkNnT56j4CfZEb7uz0Rvil5gXbQZuuhPiItoaDfRkQwGH?=
 =?us-ascii?Q?apxbhjXgRbIMFxmlF5Huv+i6G2dl2us/rTQVJdkFPNYUue09gtT3xJ3ZSf85?=
 =?us-ascii?Q?X1bowcfbn6bgFidD4zrVQrYkBQFuCslrhBkOBn6aT4yl5yeeN0DfXvRDzwvR?=
 =?us-ascii?Q?7BjxFlun7Q90ox4fHzhWZtjl5bRACT6m3/7J1Vuy4PZvmy6EKWc/e2W7iVO2?=
 =?us-ascii?Q?K8HpPj60fABSx/GhQ1zqoNSE9RYB8uQQHL7fUoz5w8v63Bqoflg4elU8hrFz?=
 =?us-ascii?Q?dFOKe38Q1k7JvAAeBvJMflNOG6YCuFOW8PlsEXefLqFoldWQuD8HfKYbR0oC?=
 =?us-ascii?Q?WjvFd/oJIlBDiLOwoAQZDDSJ5NAO7VrJRQTy7ebrOAOlIveByUUejtaRGEnZ?=
 =?us-ascii?Q?AJg3KSMTB8zVK21lRYkjPjdmrjK8rWbDzzyOf7RH6iYfDZYt7/0ifZLY5UwF?=
 =?us-ascii?Q?CnOztAkX/hC6U1nXIk6C21RKJF/jrmSicMhl7pCnhN+yH+yRPbb66ieVfJzk?=
 =?us-ascii?Q?FMl+4ffaeiavTUm/MOwc37Tc9TbO3Q6bbZ2Dci9L7FIVg3wGESgkPqit2CLp?=
 =?us-ascii?Q?mN+7c55krJEiyB3FRKXhoRKLguFAp2jal73wdX7cnZtLTECvn17rvYP6cVP/?=
 =?us-ascii?Q?BbsK01B1yRKrM3ppB6HApOmoGLsyU5SdcZQAnecm2dzHB+jIxZQfk70ZYldT?=
 =?us-ascii?Q?rzOuxHA5gM/JVEDcqNeekTCvX02tv1/5AJtLVOLScn72BgsZbMu7L0pUMool?=
 =?us-ascii?Q?lyGWaShzRckU7sOOK2K2/dMZGCGtuLkCD7DJMemXzeUb2knw2zjllk7FwXYQ?=
 =?us-ascii?Q?EVvJnPvshRLEjvSXe0F4aY8DLqTnsclcMkhEY6vtZGOgXm6hzS3aSMSZSO3w?=
 =?us-ascii?Q?h3vAusuujj1aOjWEw7NK8CovgMB47sWuqA1QOlGOVaFs0GUEsLcav5iiGxSV?=
 =?us-ascii?Q?rdWOBNSoSwNZmil+JrgRxJpKxPX+8qTqKUYpQ6+63fafcKdNAlPHX9EM7EMd?=
 =?us-ascii?Q?nHWqlzHpMS/HUtg79RwFSW2Pi7tY6wpgd8hHl1r40GBBQ9xyFbFsfhaj8hm0?=
 =?us-ascii?Q?x/E7092pZSQt2uFT6zPM7USfqaKboVg7sDjTuBqM0IgHuAsVp6/c3sOFS8VB?=
 =?us-ascii?Q?6FvBBZAwpFli3z2NjHiubkcl/pbJWrMTnzyiH97UOpxatrEAYJ3utgNpQJ55?=
 =?us-ascii?Q?9Ovj6+IJNfvWK03yshywegZvgsbEbnFBdMh8C93BX25h1fFVPJZcKs0gfiQF?=
 =?us-ascii?Q?6RfFZ6m8M/Sbfck3VDQ99EoJBoKhsjUEGV05PEZIDAtXGHsId19/rTSA9XDU?=
 =?us-ascii?Q?Cu+6ZgH1oocLJaaIXTlidqQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1071db4-9623-49e2-5efc-08dde003f831
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:41.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1YV6PM74CZu08vaBV0jwBKRd85FYuSBO1R+UQBtJpytez/D/rOsemfIwQmi/iOAS60j5vSpCZ8p2KLr2BFuPA98sxBj7651d3bs6feT4h2HH6vdo0iBBQgz4ORfMTtf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19912

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
index 7f75db9917cf..d7c8022fc9b7 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -805,11 +805,13 @@ static int rzg2l_csi2_probe(struct platform_device *p=
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
@@ -834,7 +836,7 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
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
@@ -852,8 +854,6 @@ static int rzg2l_csi2_probe(struct platform_device *pde=
v)
 	v4l2_async_nf_unregister(&csi2->notifier);
 	v4l2_async_nf_cleanup(&csi2->notifier);
 	media_entity_cleanup(&csi2->subdev.entity);
-error_pm:
-	pm_runtime_disable(dev);
=20
 	return ret;
 }
@@ -867,7 +867,6 @@ static void rzg2l_csi2_remove(struct platform_device *p=
dev)
 	v4l2_async_unregister_subdev(&csi2->subdev);
 	v4l2_subdev_cleanup(&csi2->subdev);
 	media_entity_cleanup(&csi2->subdev.entity);
-	pm_runtime_disable(&pdev->dev);
 }
=20
 static int rzg2l_csi2_pm_runtime_suspend(struct device *dev)
--=20
2.43.0


