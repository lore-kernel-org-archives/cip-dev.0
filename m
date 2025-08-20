Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C84CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.30])
 by mx.groups.io with SMTP id smtpd.web11.1010.1755706114670889665
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LPoFwixO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfOrqFU4eQE8fEOHeD3IVCnoUKWhTDnoyulvEkvB6WtbHz6qt58YhlGkN73MHxRhcWZ2RozO2asb6Ql3dBqYlk+Pbp2mtN0YfL4Es0N7e5h1nK+tKbRy2r0svojXonWo7EHglzuq0yV4x05ym5xC7RaQjWsHRcNV4FO0kcXTtUw4PqRou5lm4fvOmPLhOFR/1iSmuAMPrmUtUGyIJStMujTsJX9pQvctT/+7CLmSRc0tHnpFbcu3DF17uYjeZhYK7slMnS2R1cwna4NvFhqbL75FBfUtclZidFTSOHdI0PtrJMHjSxlTmNW+68A2Hab/hsM/LFmD7ou5NZkAiH7Pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhIwN3mBtFhMq/+hehWrVgvrl8mAVH4cyg8ZI34h5C8=;
 b=QTX7gHz5rYNGIG0UtYTzhvjPEBfiJIVkZGyjyh2JqVPsvOcSVCPHnLTeOa1Owk6VPpTw1wS3Czg9FfX5xEMMPzMFB+P9+OlOBebypRde4gguP7Qou2DzWHXft3zaOx43EmEWICEzmyOHo7p+VvzK3w6zDKq1M4Ka5Cbu9bMy9cBnOcwOs+mdOASFazDaeGukytAa4IVpRScTcvS/UhqORcUm+O1kaGJABJ7IdXSxUhJxBkpdjrk5fZy76mrwh1c4GmNQuHxGPEwOVc2oHto+gnVyz4BixseyGXBmwgnw0gxReGI3ZGPFTtVn1+c3BeeGEzpiTmT9BvAPilnPC0y+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhIwN3mBtFhMq/+hehWrVgvrl8mAVH4cyg8ZI34h5C8=;
 b=LPoFwixO2p7D+95V+jS/aAm1ncVSGQIQNgjmjolAHJ3+uUk3ARNNZzTTk8z/3oBq1m54PLO2MAYkQxCVayC/dxrVyVIAGt25v8+Gg1HB/hOCOhktRbWGeuJFjHtzm3bTn6QvKO+kZwgdDW1qBa0cae3j+i+7XBGEncZxPVj4KtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:34 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/55] media: platform: rzg2l-cru: rzg2l-video: Move request_irq() to probe()
Date: Wed, 20 Aug 2025 18:07:05 +0200
Message-ID: <20250820160758.801813-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: df75abf8-1987-43c5-7870-08dde003d028
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SnwgumUn3Ux44A++vmmOKzqChNIfdq9m3rGmQqnGRCU8Kx2eECs26rHYf82W?=
 =?us-ascii?Q?IxLiL31dnL+31hCgVtP6wXEsL8w2RlIOX2iY6GJidn16544tPdO4e/AVxIt1?=
 =?us-ascii?Q?qVQTyG+C121WgI6SurMCrpSHDjToHKjbxjxjpN5m6PZAB38lkX4rNNnbfILS?=
 =?us-ascii?Q?+OsHJ3/wcvTPmLOXSmc8uCNe7m0cBqTAunLOOl9C+B/n73nzR65IA2UDFVxS?=
 =?us-ascii?Q?YraSsNjILySZR56qLHhy9o+O839rcZge2WsQvftEL3rj3+QvbnQj5QZKK7Jp?=
 =?us-ascii?Q?7PyL2pRrs5jJStN6ttJBnnVyEe7J0lIJ73NKHmwsKhXNS5IIYGxqoyujXfqP?=
 =?us-ascii?Q?ISFYRatuy1eHLNxVnh9Apa87Z9SO7h9SiWue6I4xfGB7uiWNbulSOndvVsxo?=
 =?us-ascii?Q?DuArxwAsZtSWFEe1y/Og9wqahrpBm/Cv5b/yRnG2uW7l12WNLcqegHvOTo/j?=
 =?us-ascii?Q?3PrQE+ARxOnDe2liNKI9qA4f3Yt8GQHlICAR8JwyNjLxa6QfpX4R2IHn9ZpY?=
 =?us-ascii?Q?ypIQc1zlEaxSrtplPb0HZhHGIVE7zg2dXUtgI0lF6AfPL3YTmkLLkgnOrjel?=
 =?us-ascii?Q?IThMgoThknVyWfitxKWRYpVHBp6SopL9p5ETpbTyAT4r1QM63FxqwxshlWNr?=
 =?us-ascii?Q?cLjeU8TVSkgdF+BrY27LtjFV2Ou1pCsHSr61O7hwGltUOnSRFd8qUisQLlOH?=
 =?us-ascii?Q?d6Rxpj3YFRy3/58PVJX1qBg59GGDg5m+gpbAyslyd3IIi4uFD6fldnihUUzW?=
 =?us-ascii?Q?5/1PVIUH3lC0o89O4euyhhIbAQWvZVNlux7Q2OnqQSRu6fxnrDxbL0Gf7MKl?=
 =?us-ascii?Q?FpNMxBZweiglpGaha6WxLyssgPhijiYeTxMdh2a95iVdaXN1xKSqNuwZxCPI?=
 =?us-ascii?Q?tjlxmbt+WK5ykV/JAugWvWL9kjmLuQvvcBOWv1ZnaOWHY4bQq0zt5eVHn0AY?=
 =?us-ascii?Q?JuBNGBhYIfrB8g+vhas9oyZGCr9VtUGIlFHpfb4SQnGsYg6wuEWn4sRsq861?=
 =?us-ascii?Q?LfBrbpxwDpvcT1ioy5k2ubjgbdKBU2CIwXZ9UWOQNH2xkEARv4wsWoe300Cb?=
 =?us-ascii?Q?YQsKkxzksoyesjUHe6AhqZmSRLxN4gJYxY+RkniCmw7tjahNa4i8ydf1e13M?=
 =?us-ascii?Q?Po7a+xVszhPv6hWseu7TYuwV+V44DVNDCFEH8ojgc2RCnP/CKo4ygg5d+3I9?=
 =?us-ascii?Q?UNu79tm6VpqZ1B2Ko8rDIcpgx8SZ2SdS3oVzhYtjrSidaoM4mvIe5m7L2yQt?=
 =?us-ascii?Q?TJ+WrbeICgzDJ7to4qkvP9TWQ5MzxVC5KY+sLhpK/vMBQN1AGBT3vCQU9uhf?=
 =?us-ascii?Q?dUu80FnWCPfG6yFMSqXiS8NuUi7+TkvzkqHbWsnZSpxFeD9G8FK02vXjiJHe?=
 =?us-ascii?Q?B0ygxw0sdsPJqnqLOXgEP7omILtw91dUPibNAQ2+ib3+ZWtpf46XYLy80u/l?=
 =?us-ascii?Q?I7ZlTnOCMrklVQ1UUXjl4YKDzWpmLRTRHQK2TQafyI/IxMq9HQxFuA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AYH1nusvmw92IrZGVGZhUXaAFB1b88ZaHDmXRR41dH6jGl+FcdQRZlOi2cvP?=
 =?us-ascii?Q?14VyOmJAB7SAxxrhe1EozY1Nx7IwkPlinofumP9sC7VsRPDH8Is2I/rFaI0S?=
 =?us-ascii?Q?9J9IbLIumey5yus8ZMtedNl58avNbbuX1ZAyAPSXxp3aX5rXCc2kr/t9+OGs?=
 =?us-ascii?Q?4hVBtqnZ0LPioEos5R9ZqQ98JOD6Gua/hIviLJxy4iiPHyTwV2Uavsck2FGN?=
 =?us-ascii?Q?NFh+q2qQEY6EFGxtmY3chGgUrY0ZpqOsO2++L8gnY2og6WjdkvatjIzDz9/f?=
 =?us-ascii?Q?mFBeV/wrXTEICZIQ/jc0RgcwIIhAJlKI7KTCrNBBsM4lOilyhz4NKi0dbJBi?=
 =?us-ascii?Q?Jg/nwSgS42U/juputzLfp4g4ptF/sxOORAJX2S+aCh8cpwOa/lvV2AvtA48x?=
 =?us-ascii?Q?YK7qf0Dw6Dc7KX2nOqRS04QwLMXRrUyjuwJUFwTxcH8ug62eYS9j7uDbtHa2?=
 =?us-ascii?Q?hBUpvZM8idH8ysiies2QU3hSKDDL1c/dzuw6Fer5NsWfqrti1CRp8aY/+h7M?=
 =?us-ascii?Q?Y+IfLCGUwUSRv0o4KYm5tJR/Ly8k8issPhKAY3NoDarizltj+bvSzEfOzUnx?=
 =?us-ascii?Q?yUzAF8pi2+GXFJkShfZAAFyYbYSekuGwuI3xXJ44OMbxDdzRCD1LN6Bqy5o7?=
 =?us-ascii?Q?jQjpV2WiGmKPjnVSlsOXr8sZW0ZiJ8k6Wuw/emol/QHIdg1sgi+CNPs4hPYZ?=
 =?us-ascii?Q?GiwSAhTcHbvJEMMPORZPFUTXZ+6A3jChnJ08mAgbBlo47aEeRjm+xl0FDaR7?=
 =?us-ascii?Q?tXkKNdcazani9zgRkJVbarvcp/KvIn85m5EDn+tj8EduNgiBz2fptcoe7Mg1?=
 =?us-ascii?Q?0IuQCMT7uYwWUCX3qaOTMlTQEgVQW9GDZeJFq1de7GUHgQkHYN+r5jxE4Bri?=
 =?us-ascii?Q?Asr6Hx7odefKkVfPIqfwuH0kGfSNC0gMC0gWx9q+4dFmwiJy9xtIuI74mvIJ?=
 =?us-ascii?Q?ypYEngGW93J6kpeAbRuCmjaVWGzmpBdsJWM9HdeGbaOV2lORMJu1O4MU7iI9?=
 =?us-ascii?Q?Wpk0NQ4Bc0r5e8cwGJkGE1ZYx7F3w4S5tj4zk9HLPaPvUlGuC5XgLb5PAGl4?=
 =?us-ascii?Q?0dq46tkU/Eh4KHt+kvPTSF0Vs1KJDG0MpWHeLNv6o2KqXaDG6kR/ecwvUpwk?=
 =?us-ascii?Q?Ou12HdSGQOdkTtdrBxZhNU57f+w8X1UIxN3Trl6fYFkxoNCJYU5VBIlUOG2m?=
 =?us-ascii?Q?mgmU1YqoEtIU8eFUhVWTpAQkpVBlo9nY/l1tPr95/z6ds0eolYSkEd7SWaok?=
 =?us-ascii?Q?VwDIyTiiYK0E2jc1LqmmdYgAw3+fAcf/+1l33msLUd95kqJCW07eVFUgY7mK?=
 =?us-ascii?Q?ykJ63n9BuYh8xGN4O1CRdkiLgO45sLElTER7PBQS+ecZ6HDIrLlJAd4aRVb7?=
 =?us-ascii?Q?Usi+bgSdGFeaAmSx96cVwS5ooy78vMmUQrNxIUvG6bsv4ZQifDAEiULJJJq9?=
 =?us-ascii?Q?0CSXM+mm0RKs5kAPDLAtLcBoxsAHON0jzXypl3A/4v8dQYluxG/wnpl3olUp?=
 =?us-ascii?Q?+aubQACVmB93ZgUWjlRmRdLyEDfyCMDrBvpp1UlWXw3fsBchm3S98wekcIG6?=
 =?us-ascii?Q?D/z86U9g6EsXf0GlcLEB9MFTc3FShwbDjINsgxU2DMXXC/2YmFkTqsoo3lFL?=
 =?us-ascii?Q?Z7HLnnUlLoBlIkcHatAC//8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df75abf8-1987-43c5-7870-08dde003d028
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:34.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlS/j0dGSDeuBwRi5CJFLVT6jCRBnqohdO3kVlpzyCupCcEbY/WsbWWXVPB5g9jK5SLjf2IIq8R4Hs/RIfZeZDBA2ocLAgAqkH4c44yUL72O+I7SgJpXpzGvqiRXFop/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19885

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0c200daa5780f3d0ba6fff4b6bf9e4bb924fa5ca upstream.

Move request_irq() to probe(), in order to avoid requesting IRQ during
device start which happens frequently. As this function is in probe(), it
is better to replace it with its devm variant for managing the resource
efficiently.

While at it, drop the IRQF_SHARED flag as currently there is a single user
for this IRQ.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c | 13 +++++++++----
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h  |  6 ++----
 .../platform/renesas/rzg2l-cru/rzg2l-video.c      | 15 ++-------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 280efd2a8185..19e0ba9596c9 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -242,7 +242,7 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev *c=
ru)
 static int rzg2l_cru_probe(struct platform_device *pdev)
 {
 	struct rzg2l_cru_dev *cru;
-	int ret;
+	int irq, ret;
=20
 	cru =3D devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
 	if (!cru)
@@ -270,9 +270,14 @@ static int rzg2l_cru_probe(struct platform_device *pde=
v)
 	cru->dev =3D &pdev->dev;
 	cru->info =3D of_device_get_match_data(&pdev->dev);
=20
-	cru->image_conv_irq =3D platform_get_irq(pdev, 0);
-	if (cru->image_conv_irq < 0)
-		return cru->image_conv_irq;
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret =3D devm_request_irq(&pdev->dev, irq, rzg2l_cru_irq, 0,
+			       KBUILD_MODNAME, cru);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to request irq\n");
=20
 	platform_set_drvdata(pdev, cru);
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index a5a99b004322..174760239548 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -8,6 +8,7 @@
 #ifndef __RZG2L_CRU__
 #define __RZG2L_CRU__
=20
+#include <linux/irqreturn.h>
 #include <linux/reset.h>
=20
 #include <media/v4l2-async.h>
@@ -68,8 +69,6 @@ struct rzg2l_cru_ip {
  *
  * @vclk:		CRU Main clock
  *
- * @image_conv_irq:	Holds image conversion interrupt number
- *
  * @vdev:		V4L2 video device associated with CRU
  * @v4l2_dev:		V4L2 device
  * @num_buf:		Holds the current number of buffers enabled
@@ -105,8 +104,6 @@ struct rzg2l_cru_dev {
=20
 	struct clk *vclk;
=20
-	int image_conv_irq;
-
 	struct video_device vdev;
 	struct v4l2_device v4l2_dev;
 	u8 num_buf;
@@ -141,6 +138,7 @@ void rzg2l_cru_dma_unregister(struct rzg2l_cru_dev *cru=
);
=20
 int rzg2l_cru_video_register(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_video_unregister(struct rzg2l_cru_dev *cru);
+irqreturn_t rzg2l_cru_irq(int irq, void *data);
=20
 const struct v4l2_format_info *rzg2l_cru_format_from_pixel(u32 format);
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index b16b8af6e8f8..e80bfb9fc1af 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -527,7 +527,7 @@ static void rzg2l_cru_stop_streaming(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_set_stream(cru, 0);
 }
=20
-static irqreturn_t rzg2l_cru_irq(int irq, void *data)
+irqreturn_t rzg2l_cru_irq(int irq, void *data)
 {
 	struct rzg2l_cru_dev *cru =3D data;
 	unsigned int handled =3D 0;
@@ -637,13 +637,6 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_que=
ue *vq, unsigned int count
 		goto assert_aresetn;
 	}
=20
-	ret =3D request_irq(cru->image_conv_irq, rzg2l_cru_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, cru);
-	if (ret) {
-		dev_err(cru->dev, "failed to request irq\n");
-		goto assert_presetn;
-	}
-
 	/* Allocate scratch buffer. */
 	cru->scratch =3D dma_alloc_coherent(cru->dev, cru->format.sizeimage,
 					  &cru->scratch_phys, GFP_KERNEL);
@@ -651,7 +644,7 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queu=
e *vq, unsigned int count
 		return_unused_buffers(cru, VB2_BUF_STATE_QUEUED);
 		dev_err(cru->dev, "Failed to allocate scratch buffer\n");
 		ret =3D -ENOMEM;
-		goto free_image_conv_irq;
+		goto assert_presetn;
 	}
=20
 	cru->sequence =3D 0;
@@ -670,9 +663,6 @@ static int rzg2l_cru_start_streaming_vq(struct vb2_queu=
e *vq, unsigned int count
 	if (ret)
 		dma_free_coherent(cru->dev, cru->format.sizeimage, cru->scratch,
 				  cru->scratch_phys);
-free_image_conv_irq:
-	free_irq(cru->image_conv_irq, cru);
-
 assert_presetn:
 	reset_control_assert(cru->presetn);
=20
@@ -698,7 +688,6 @@ static void rzg2l_cru_stop_streaming_vq(struct vb2_queu=
e *vq)
 	dma_free_coherent(cru->dev, cru->format.sizeimage,
 			  cru->scratch, cru->scratch_phys);
=20
-	free_irq(cru->image_conv_irq, cru);
 	return_unused_buffers(cru, VB2_BUF_STATE_ERROR);
=20
 	reset_control_assert(cru->presetn);
--=20
2.43.0


