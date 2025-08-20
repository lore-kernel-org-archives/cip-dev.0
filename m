Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BD4CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.8])
 by mx.groups.io with SMTP id smtpd.web10.1069.1755706133314806249
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lBvIMLhw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl0ktGD772nqQnDZs4mOYdznsLXKERwEMjOdDFC+IKM26qCsX+hPK+MCdvaA8xutFuweilenFfQnollJx6iH/xAbg4u86drw/AaCNtQU+M0VtPLORp7PG1kz93sUNOnQI6M9mBKMZ1sxCwNc/eYzS/ySH/Thtiv3E2W+3+J+Ek8cYSrDTJ5mzxi3Xp9W/b0yciLvmL3xuEWJ8iyWoxYkBxyBM8vwVgdWr8jKjE05UlaIUScPorM9kHG8bqr+hwxNJcRs+Psk40tFo1KB2VfNnKAFTU62w6giRiwXq8DUpVUpM5KherQOSpdpMQZMxTwCMwbb4X4Qiz8jYVEgPpYnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8AcQ+HzpF2B4zCzWJRssHbxOQkYWUarcRcqvY04bbw=;
 b=AvMdvny6aE+KFvrRgLy48IDD0OfamdgqwyxDe1PQbRHnkb3uCB/ImQ8HWR91Les9bT1IdZWdou8s2+TSMCcUqy29tshFOq/zGZq566rd4dkKAbxaI73hgDjAqX3T6B2iiontP7wyv+kmfetabYUj2Z07J0Aa2uUAIN8/lrO1+zkgq7I4oNVQOqhI4chtmVencDXAfXL/sKlqCd1pgt8vYAb0/n7A5RatEruXX9g8EqfvrBH2PFZjLQlyHAytnBqmxf3GuIqvSzvKlfrkXnI7elvTN8owclFtOiCRcVQkQjaOFM5D/iEaHfmJbfiFgTqSZp7aH50BrQeqB8jxSjPUhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8AcQ+HzpF2B4zCzWJRssHbxOQkYWUarcRcqvY04bbw=;
 b=lBvIMLhw1D6RwQziEQFZOCoTL0M4C9ycO/jp9pzCG6x/6Ho0Ys6w+eUrhcllvDBMWYMCYqnf7L3EzuzscgldjwN1o8v1xxoWQQTwxZlL8G/kA8OkqUdkgtaG1CtTYIhova0ghefPae70KriceI8ZP/Zs6UHi0YrSTBg8i6YTrPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/55] media: rzg2l-cru: Retrieve virtual channel information
Date: Wed, 20 Aug 2025 18:07:12 +0200
Message-ID: <20250820160758.801813-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f36d50da-f08a-4f74-4c87-08dde003da6c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rv4+5+sDUUnoY7ooUBa+6LD+I8hnJHv5B+BpUBMB0+jpKfJR+EcgpUFRRqG5?=
 =?us-ascii?Q?ZWLz6uOP7mSCC6U/ZZTamMXdLa9nKy2LeEZJ8hMTmPrWIgUqI9UidJ0B13sy?=
 =?us-ascii?Q?Ay/JuKzVp9sE2XMC5SOzSnDkwYz2IjKJFdxtL7wVkTT9G3qxzdmbALp29Be7?=
 =?us-ascii?Q?c+9CxTsaUOldMvPOwmWuPXf57rJsPkSTfOFo5cvm5z35sygXZcdpT4wS+wve?=
 =?us-ascii?Q?ALyngINDyXsDPh2QPotlQS1zZ2iw84ckZw2QVdMHtxRlmFITtU/ZLSyqELU7?=
 =?us-ascii?Q?Cql9s8+TmDqn0o8KQatMWaA4dXfKexkaO4VH2y0Tj5d+IA2eE2MgZ4u6qB13?=
 =?us-ascii?Q?295kngRPwt5okSHXCSpEbg5yTKJqCvaILu4RLeFp4frDXmNSBZZy7G4e/UsI?=
 =?us-ascii?Q?rdq/A4v0QbwnZzekIarW81sfDhnQXepvXlY31YhSGit/DCxQbL7OPQq1PYzu?=
 =?us-ascii?Q?dyTYjzS4yFFVEbkhadv5SXSK/X1BZ1ky3U1Ed46LgnGOIFeOYfNpr2ejiVAy?=
 =?us-ascii?Q?KoWLyPQD7qxqd6bvDu6vvAHwZQGhO91WKnYh5UWCGn3sIaSKbbVNc8z5UmW/?=
 =?us-ascii?Q?uaCVep5ER0FZK+RhG98JDRo61oX1P5SrH6LeXD5zwOlXXxpQvaN5UcewaDac?=
 =?us-ascii?Q?o6W9rDtgGLN7q0m9k86L1vRoSOtQhoidDW+ppz5fcmYQPQ1adNAWffA17CCp?=
 =?us-ascii?Q?DsxaQROfWXEZ0m1MA85kKInO7yXNXZzt/vYu9nuMWCeZFbWkrom08WdklVPF?=
 =?us-ascii?Q?9N/5ACOZfZZ208C4lI5pf88ZMpaWMn4ifgtRBfkHQKWh33wIxTEqVmSQ+aJh?=
 =?us-ascii?Q?oBlYq4sB0t2hCZJwttM8FyGkS8xU2cz8D7jkSgvuqcC0JTj76JZYrKHTYRWM?=
 =?us-ascii?Q?Gv+/YLH+lSrGD1beoi2OQ/HrfikQNkn7+qDqCC8IfbN1WD4EVjKBfr/3SGnL?=
 =?us-ascii?Q?E64RCLsxt+ccjIn04jGoKM5SBC9vv87AzG0m89CnR4LHnm/OQpRbALBjovGl?=
 =?us-ascii?Q?MbgnUa3dZ9OSrDIrEP8hI/feoE5T/cwlgPOgOlygNP/RdG7Unji9UDXTp+w5?=
 =?us-ascii?Q?LP4qa78NVUF65ngHl4+XFTdkEcwJCqT84SuMxK/Q4eFVJ7gsp3j71bFlKAeG?=
 =?us-ascii?Q?duuU1JsSRU2ZESsBoS3rYTk+2DpLRs/vPjm1BCDxKeDkpX1gQYnNkNib5ik9?=
 =?us-ascii?Q?oAEDah2TFyE9X7JsafUKf4CcZwzCEGci77ioRCKRhWuzBFFoKoeBvVZxKczf?=
 =?us-ascii?Q?81mKh70Ua7RKCsuUjdZ3rWBEBK1dXaipGLGVV4E0/0CH24N4bcRSVDaI1lIe?=
 =?us-ascii?Q?17RrSvxbCQO6zuzu7JJnhysx7xTsQzYXcwlg/r74X+6kIIX3w6mRmixonuNJ?=
 =?us-ascii?Q?AqEB6VK48J8UkXX7IvSmIB90t8s9Aadwi0WIZRY+DFg1fIoP85GCyJRYb/cq?=
 =?us-ascii?Q?dc9jky95UX0unD1I3ohH2V47LX6y2iJYGgX+U/zFfv8IbjsXKkj+MWHU0f0Y?=
 =?us-ascii?Q?+LtUYD3p8CikyNU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JIUa7xFA6Tdtk1JxeKUutLw3gh4RVLQM49w9A/nCn6jX2TqFwkdrtCu6hdSI?=
 =?us-ascii?Q?YUTt6G0J8wg43l08UYgE2HwqLxrqn+jg/vxW9aVatdCn3z9y1uEf56U6RTI2?=
 =?us-ascii?Q?OP7MnBsAXtP6+ahlRWo0oBoyrYXhGgd9qZpKhjMg8LPwDj02129psoi1qIU2?=
 =?us-ascii?Q?3QzIxIpFaLHtVbCzgNieAfL344Cn/c9w0g3nCYn6JDDLL1MrdrXk3p+29BoK?=
 =?us-ascii?Q?kjDODbVJp9EwteYMNqMkk76YW+d8wjU9GuRKx3x+ufUScUxfSL9oTWrvX+8M?=
 =?us-ascii?Q?SmWFZw8UFPekGkJCCT9gqQYQYUe9w5c7hGwIVTWKN7vHaJDMjt2F1LpCcpPN?=
 =?us-ascii?Q?73D6qMsI/Xfn2t67EZepp/Tnph7+k+djYP6n3W8Y2EWO0fmkOCMR9xEPWEDc?=
 =?us-ascii?Q?CNg7Lx7i01WXp0bzlXNN7wgyU7RxYCDGJN2NzntE7FP12tq032yVEhoYX5xA?=
 =?us-ascii?Q?NZVIgLD+7zZjXQWkIOSx3ztZr4ez++3G63SMTcY1WJ7KIWOn9O6bHKH749Lt?=
 =?us-ascii?Q?ePthogTeAwPUNpFCCpNiWlKHX0oaDoPLQ+DrWc8eAnuCbJp85mgU7ugElG6W?=
 =?us-ascii?Q?y94/FaIZsHmPg2ABQVWIktYLtkErwXGmKugqfY3YBFDxCYIA+vKrzVueVaxO?=
 =?us-ascii?Q?TkMIKVu2WYwV2Z2MjsNriYVhb49ehtXS8B2n0wpgSobXraJaRKvS1KtlkaLm?=
 =?us-ascii?Q?mZCzm/yE0AOPplEvERVoVyn8YtfXp4INbPi4UqwwnbkthkMW+QOvjGYobQ2G?=
 =?us-ascii?Q?njFB0+GIvuuZA1US1D/1n80meLHrTsPYAgyP1ZtRP48OI7DF8fIwMGWn2ie7?=
 =?us-ascii?Q?XFWGSXdTh8BEQq9BPmlhH+8cdn3tyErKAayjD/MCiictsG0iWmojw6Irk5iF?=
 =?us-ascii?Q?GtvjoxyoKfawhgBLhi/LYhtL/TDoEI935Hjt2Pw4RIH5sNUvtJe4Cu5Bzfw+?=
 =?us-ascii?Q?BPZ77e6RBRzb9sDfs5lAAG6xg/gRjV1/GYTaI/RQeqKo59ZFY0BP6OxWuO94?=
 =?us-ascii?Q?Vtd/k0A2fLCCM48fCQiio3f8PXtd49rwPweKMmdUGaimGodz7gkZ1ga9szH8?=
 =?us-ascii?Q?nMLxnmWYpx6W4VBnhYaf+JfDBbCqRq256WB5W1O2ax5RyNLiaSox7vB9ZRfo?=
 =?us-ascii?Q?UUx5LYaRRk5nYOQvUGCdAxgheJbD5A7vEdCIYnWjhsKmYNpMiu64sgl/kLWX?=
 =?us-ascii?Q?8jgdRWGBZLU5Kf+7GLhJXDm/vaTZMepaqqFHSbJA9BNS5ZXKDmiJOgPs795Q?=
 =?us-ascii?Q?NmsEdlilJ8vCgA5n/ioAzTwOG+sd62pcHc25Qd2ZJ8+QgyudvlZ8JFyI9flS?=
 =?us-ascii?Q?VPO87kLAYOSMvqyQoCWOs4S/Oe6cFdDqLYLlMqFGHwvgtrhJGZkPsE8dvEBz?=
 =?us-ascii?Q?2B6MgBzcQ+/tfSvXpgsow8R9bRkkHP4tTe4ymNrRq9nzeDAA49yDOTeCjS+n?=
 =?us-ascii?Q?X24ntHs0GO4eFF8i3sBXvZ0bkLaP27nCR6QY3ntrPuf+Y91Skc9k4OeXlW2F?=
 =?us-ascii?Q?piEKiJJkPm+q5vahjWcn9nDdqhpApWVak+AenWBe8w5p5s/4VEBb4hY48NgS?=
 =?us-ascii?Q?RThdF6dDW1qx5UK8LKczY5rDKT60UJN6ojMBQCINzjlytTmGijqKiC0zKlJu?=
 =?us-ascii?Q?uSIBDlWIj4xxnviJiiSJpi4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36d50da-f08a-4f74-4c87-08dde003da6c
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:51.3341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFDxNSaK8XoAwHB7a3/481k5CHguZKcNCc56tFiIHvLK/w8/pwPrQgH5O3FHxHxkE+Z7LBcCXEod278YECk/9XGu8uVNxCUHQl+LuE44sDgNOdf0X6OIgBWyPh8Otlr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19892

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d7d72dae81d5d77c4167d793aacb73c77a13172a upstream.

The RZ/G2L CRU needs to configure the ICnMC.VCSEL bits to specify which
virtual channel should be processed from the four available VCs. To
retrieve this information from the connected subdevice, the
.get_frame_desc() function is called.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  5 +++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  5 ---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 34 +++++++++++++++++++
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 174760239548..8fbd45c43763 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,6 +31,11 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
+enum rzg2l_csi2_pads {
+	RZG2L_CRU_IP_SINK =3D 0,
+	RZG2L_CRU_IP_SOURCE,
+};
+
 /**
  * enum rzg2l_cru_dma_state - DMA states
  * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 700d8b704689..aee7d4ba70b0 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -18,11 +18,6 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_for=
mats[] =3D {
 	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
 };
=20
-enum rzg2l_csi2_pads {
-	RZG2L_CRU_IP_SINK =3D 0,
-	RZG2L_CRU_IP_SOURCE,
-};
-
 static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
 {
 	unsigned int i;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index bbf4674f888d..7cd33eb1939c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -433,12 +433,46 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru=
_dev *cru)
 	spin_unlock_irqrestore(&cru->qlock, flags);
 }
=20
+static int rzg2l_cru_get_virtual_channel(struct rzg2l_cru_dev *cru)
+{
+	struct v4l2_mbus_frame_desc fd =3D { };
+	struct media_pad *remote_pad;
+	int ret;
+
+	remote_pad =3D media_pad_remote_pad_unique(&cru->ip.pads[RZG2L_CRU_IP_SIN=
K]);
+	ret =3D v4l2_subdev_call(cru->ip.remote, pad, get_frame_desc, remote_pad-=
>index, &fd);
+	if (ret < 0 && ret !=3D -ENOIOCTLCMD) {
+		dev_err(cru->dev, "get_frame_desc failed on IP remote subdev\n");
+		return ret;
+	}
+	/* If remote subdev does not implement .get_frame_desc default to VC0. */
+	if (ret =3D=3D -ENOIOCTLCMD)
+		return 0;
+
+	if (fd.type !=3D V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		dev_err(cru->dev, "get_frame_desc returned invalid bus type %d\n", fd.ty=
pe);
+		return -EINVAL;
+	}
+
+	if (!fd.num_entries) {
+		dev_err(cru->dev, "get_frame_desc returned zero entries\n");
+		return -EINVAL;
+	}
+
+	return fd.entry[0].bus.csi2.vc;
+}
+
 int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 {
 	struct v4l2_mbus_framefmt *fmt =3D rzg2l_cru_ip_get_src_fmt(cru);
 	unsigned long flags;
 	int ret;
=20
+	ret =3D rzg2l_cru_get_virtual_channel(cru);
+	if (ret < 0)
+		return ret;
+	cru->csi.channel =3D ret;
+
 	spin_lock_irqsave(&cru->qlock, flags);
=20
 	/* Select a video input */
--=20
2.43.0


