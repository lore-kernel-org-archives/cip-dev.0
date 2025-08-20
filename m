Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B868CCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:03 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.41])
 by mx.groups.io with SMTP id smtpd.web10.918.1755705895978179196
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q7em717t;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAhHM3O+Hn2YfrquB/IfyFDcV4ch3Te01h0KO1z4JC5TjzkcjMRgdHxSbSOK6gC5Lns3/pFDvIJfTWKZskLeyxPxrmie2zY4Xjt3dlEJs9Pjf1YJGWPtK60G+4PbLkq6Ci+lCggHbQfJIc2lYjTBsSEhnCr73aUBQJtUNciRNVGWiC7vVZX2hQ30ViGST3GytDK2Ec1Fu7t3/8kFqYi2+0kVFqaz34CrSt7ETdbEYW67eHeR+7S6RlygIgoMGRaysGxwNF1XW5ljp4uKOp/sIegqWG2zAX6nuLwXrV1XgTrEMORHC35wQ9GmtpGch8WNPmp0zJR0eN9MoWNnapnEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9pG22BJ49nssJPi1oYEGO4zleKl2TaEa6zBB1AfxSE=;
 b=DA8o7x1BkNgGcfiUeKUTDP1v79wxzBT8wbBHqqWVJ6gsjgTLx+dSoALnXgM0KG44nQ13Pfg488dfMfJUR+aiNY0FmMdpmx1ev9cH4R0cEuzTsQC0unpJzUzwGF/f8jB93ULl0L6UVtBkehTs07Oz+tk2nclEuF4ReyFLMZ4XHb+whGD25fAyIEov11caIH/fCn/TYxcvfX0Cm9vYlgr/l9GJc3sYgE7jRK+Nq/Sw2IYLofRRIcVchs/XcTJI9NNPK/m9nkop6gixONTkNUXdDjm2dY5DryCruU0goM1eHyOjHLju7lm36hsltpQ3wuJqg9YmDx8tRzNp+o8ANNBtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9pG22BJ49nssJPi1oYEGO4zleKl2TaEa6zBB1AfxSE=;
 b=Q7em717tyHWd346vNNwcprfwiN7++xOJSKVnR9DXH171k8no08fK5XJF8PW8tVwoksLZmLRWo4z4RVIIzM/gWjb3WY6rmm4EAwMtVtrsyYi7FIan3qMmt8wKFXGSb7nNPgSwVVkIBnrr6yHsxX/yTqMspoSP7IldvMwBbJmuOhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/55] media: platform: rzg2l-cru: rzg2l-video: Move request_irq() to probe()
Date: Wed, 20 Aug 2025 18:03:20 +0200
Message-ID: <20250820160413.801341-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42474627-59ae-40c6-7d4c-08dde0034b51
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DGGN1AjArVUc26zIF5YLt5E0NFRVnLudxoNSm3qV4srNYClM+Jslh2o0OtMg?=
 =?us-ascii?Q?ZbmA73xM5ikbItB/zOgVF1yOehq8Pn6PzMk11hXz5x1tTXPjb56IX3eQgFNn?=
 =?us-ascii?Q?KCZbestIXFjgcYq6RU93ZtDQrWq46ktabb7D5rdnxAz0mQHfF+YirApaj7fW?=
 =?us-ascii?Q?+0Kv/LBeTmNqeY5o/1EErr6ernXg6577FPTkGlhaln/VYSCUpt1byIpSA68i?=
 =?us-ascii?Q?8DzEvj+dtCllFJbq75BR7SWk6GeIz5Q7hA90WNjV3bKJlBJl0oavZj9fE7Y2?=
 =?us-ascii?Q?jhOsCF1RbPdqOSlufTluo5+lTibNrDe+lzhD+Fgtp+I/6EYM2DcBQAzGCFkS?=
 =?us-ascii?Q?isOXIAUuDr731ebkFO/BTtWmYlx1TUzH4yVydm79wnbfmA/x4MqLrinGKWL2?=
 =?us-ascii?Q?4vjDxlDIfGoDjzIdcy5LRK36Kc+q1mzlazmDqDS5MRDSWE9BsFsWEmlfCAGL?=
 =?us-ascii?Q?kq1wQu559/61/FeEF7DRJ7dasiiF0LQUihGBQCRylEbpdO+wpap/IndqgGbl?=
 =?us-ascii?Q?cO33VHjzHrjFg7dOFZdnBnaS4u4d9VNG0bJRROInHA0Hq8tPrOM/E5ftK278?=
 =?us-ascii?Q?gJuz6HsqFIREP/dRxQQoaHL7K0eLCaIBwAYyCPgRTSFeii4zXYzD+te6xGci?=
 =?us-ascii?Q?8vRLLP1lUjxfW1EgdXorK/ltRWIypOKcEj2ashURYDxcIOvXnP3qL5odCfLU?=
 =?us-ascii?Q?yhGgUPqHRECDZvzqCJzCqIuDTF3QbDO1dTKWUB7jm/icyiW5M+O/WPdxduZ3?=
 =?us-ascii?Q?h5eoYo/E5lz/Mt0id6RfExyLdFOgVnShkSnNMsU6JbIS6/rsp0/KZzMSwIHO?=
 =?us-ascii?Q?o34ZYRLsbzffUy4NwP1EH42OuWcIhq4W1U/EY8kp+gKtlUHldrShxZ1j29If?=
 =?us-ascii?Q?mw+ONBseByTz3wUJBYlRkEj8e/cXDal8Cmm1R6UnVodbG7B9/dciM05xkBA/?=
 =?us-ascii?Q?qPiwIBXHSTSwqghGSX2O1DXvnBAo0lX/tfoA5o1j+EWIl9gSx3sMqjpkZzwK?=
 =?us-ascii?Q?qsGesZplfOor4BQV1f5r3M1HwHcMcMFMYhDmYc5cawSw4XoTS/+wICsRKX8M?=
 =?us-ascii?Q?qdopr1lM1doZtgxz9+AoRyN7UkphJjKYEm53enR82GbgUzsWxeQmnsY9RkPC?=
 =?us-ascii?Q?qmzZvxAmD817dFxmPn+g1WAXGyma/uS/ynyXpYec90hK0s4KkFJRg1ZAP4Eq?=
 =?us-ascii?Q?1iXMdwC8F/rqRsOSBVwy2IXraSf8OVjfMBmxUoX+Jrkb/PEF3fuOVTxlcPpk?=
 =?us-ascii?Q?7WfkGEz1hF4+H13kfZkyxWJPOuHYpLoUzvgW7G8ND2nhQh1yngP3fchjd3if?=
 =?us-ascii?Q?MvQdAJfnFwuhT8j+MnPO1nvgPiKyHk0aSem5jvHDEEg8ZB56Qa6AVfAdScfE?=
 =?us-ascii?Q?bgDu2Nc3uZseZchxw7JTTFLQWRKZsNQliok/HOq5MecmRR/T3vdciQt5QeWV?=
 =?us-ascii?Q?ZywD1c9mIx9rzFJXV2r4oEXgXkicJjGsoUhF7rto6xn/HjZORSpgHg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eUGv6rlpvTbP5RFy2OEAnwNb4HWNJ3LRyiEQgpSmGbPRTfR1gYffIINfInqt?=
 =?us-ascii?Q?MlG0vlxW1XJv7ucP+T2Rt+InOC8eVAqhsN2nCE8qlkUPQuWGwz29sVLScijA?=
 =?us-ascii?Q?mZlrjEauXrlZU/l45sgCYidxFC3Sbg/NxJqw2F18hKEXBilBGvHfgpe0dL54?=
 =?us-ascii?Q?/WljuwPwz9dsLXpGIXzU9qqEW0upTj4+st7sk9T+GWvC3i8eD20NGH54JbQS?=
 =?us-ascii?Q?ezLyrBDHFKZL9wMUmRfSAZx5o3fkpNGMnT/7p07HsgYL1YUYYgA7f1HyS4pF?=
 =?us-ascii?Q?+82F0a67z4ljU31F3S+QKddjpM3/Ft2hI3WfirgOaX1U2YrJF+8vPfVD9Q+q?=
 =?us-ascii?Q?wbfhhbeo01GnuFYMaYbBYNH/t+SUuI8OtaZBIkey43zyUDhCaHGWnbaLeHc1?=
 =?us-ascii?Q?U3fMpk+k2YQjTiJSq7pno4B7JqRpgmy+zShLeSReAgPji5HWVZ8PZ9xhl8xb?=
 =?us-ascii?Q?x8LCqYg7iJ+EAtJcUVOepSlO2Uh5rd+vsaOkRPObnGzxxfq60EyHxZfBlw2A?=
 =?us-ascii?Q?FAbevFcXF3+YO2NrYFBjh8OYLyGFmcmPj8Cy/KwGDoz00ysq2jKkPaaUAAfl?=
 =?us-ascii?Q?Mvnb4jaBKdTJstSFVnwN1QOd519ic6EGhA41M0QiKOEZ6/OAn+Zq9qJE9u44?=
 =?us-ascii?Q?mIb7uNFFh0n5SMOX6zptgqAj1Eh4Z1N0Ivd6uM9AyB2EvmbLdBjMftcVEw5J?=
 =?us-ascii?Q?32VVJQGvNZfUB5oB1gD4L20rvoC/Ymdx1Xmq0FdnEaMe0Zv9QYF7HcmFFKUC?=
 =?us-ascii?Q?VeJLYLLRpO12/W96fIjbpIidVzUC8eDF2pZ2/T+l09DILS+B509D7SJ+Pr55?=
 =?us-ascii?Q?6RmQAJWyDfbl/r2aoozfYlu3Zx+D1RhGVhkwEEcWDmC4FsyoZ2GLlRH0C6vP?=
 =?us-ascii?Q?prg8x4OCOfViG528jBasi7lQ32lrD2npvxnc83GT+UUf/c771SeNz9lPlFOC?=
 =?us-ascii?Q?zsq6iwqLvrQUsrHoiUEC1x26ELAi8sruCv8CoHlNyoIEt9gc7xd+5cx8y6Ip?=
 =?us-ascii?Q?r9DLAtwRyzP1BFcOT9VqfHRlXivZPneFl9Ofg1mvkLbqTKpgPLORZ4G/SrK8?=
 =?us-ascii?Q?4HxFfShNzNNFCqt1frGuY2AD8Ox3zParEG1ed0E39bdxNTe/ZcFitrV6R+e6?=
 =?us-ascii?Q?saw0SNRIrdPCXhyrjiBdOA+pmbtMHG/3MoK7bEAlyVGFsxqt9qunievogVkx?=
 =?us-ascii?Q?Sh0+uoDrWbQMkyljMcpb8FxC6tdzwjfVigTHNzVGjXMRJTqzE/xC6f5zdaLo?=
 =?us-ascii?Q?BnkletONWF7/mP6KuwKT2WLh6g28S4/gW4CXO/bkHubxb7Zm5lzTkZh/Awh5?=
 =?us-ascii?Q?hVtiIe5p5qYPQtxXasQ3wwmEoJTVBHvaY/nhoCc9HLnETSATN46aBDADXZpQ?=
 =?us-ascii?Q?IUVyF9Mm0tdzYYMKsdDEfJhgA3q5N5kp7bj9qiG9YVpc/BA1awHQT+ga+R26?=
 =?us-ascii?Q?E0MOsCgdX5YjQqjQbropQS+apQ2ed4U4NHL5VagoWdps3sOMzuZlY5hOeJgM?=
 =?us-ascii?Q?FackmY0BS4CWZ4PiH0jPK+Fg7cmLd4tdhGUYlkHJt5fCwU8/M8qEuxHTry7W?=
 =?us-ascii?Q?UyT+EGp25G3V92Ej4U0qFhIemrtXNpGbsMgShjR6XHpXmUOy3XdQZqgjxsnS?=
 =?us-ascii?Q?oW0gXWMSE2ic442H2/Z4iEw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42474627-59ae-40c6-7d4c-08dde0034b51
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:51.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msM5RhbZvE/1yWFayxFNSGzE5JaxJWA7mm60TmUnaO65LEnasY1P9x8du0OT8z17vkNQ8yS5fouMA4/kdcfiog3X7nYgYdWkG3j78b7OJ5xHl+3QW66DChEug8ylTJfW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19829

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
index 5939f5165a5e..d583fe1ca728 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -243,7 +243,7 @@ static int rzg2l_cru_media_init(struct rzg2l_cru_dev *c=
ru)
 static int rzg2l_cru_probe(struct platform_device *pdev)
 {
 	struct rzg2l_cru_dev *cru;
-	int ret;
+	int irq, ret;
=20
 	cru =3D devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
 	if (!cru)
@@ -271,9 +271,14 @@ static int rzg2l_cru_probe(struct platform_device *pde=
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
index 9fb70d73266a..93c0850bd9b1 100644
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
index 33a38528dbc0..4e74721e2422 100644
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


