Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E043CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:14 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.47])
 by mx.groups.io with SMTP id smtpd.web10.1080.1755706153122478746
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EcnMGxc8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwJtY2C2pHFzbfmLZ78yAXFiUbhIJKBYMHb5azhkvOiPnACHQtI2sQCJoUeFyH0/dMimNMw0XEdzqqncPHBRJxF7/cSbETN8bGaQqnaKIs0jDv8AR7fJWwqMTEcE+MVm/BXeZYPadyEGqnGrsWh90hiiph8GlEfR1OP/0MkS3RPaS3rip5dBotICdxEbc0Bylk0dPbWDSPIg3csp2E0ElWqnfgvxo6zFt26QWMKu+YeBl8mRjJCXNemfXQ/7CK0k3KGUNIBdtj1dV66Stni6iYZoE94x5jV0T2RlPckEnJywBgJb6jqfAtTDjYaP6EhIiddefAoQQpaRTGsd5R05hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mmt/qjh8aWzEjxWxILpmlnA7Zcfyim0tWG3UMBxFG1M=;
 b=ekU1Sunwjg0HGqMZPV+EB6hVIhVSjVqN/0/zj3SyUWAn5mVplBfxLGpGY+4hcjbU/NQpQhgGFZFq1OXKqgU9HtZ2+GjWGB/rjV0bZH+9ZXviphFPkkZoa7FQ/UuA+hO1yYRcz/ZjRuB1jmmgHJARJGZGzn8s1BTuVXUL578n5JWuiazpXpvgj+VQXquhMd33YbROjRW+ODuSzpA98OAHIGVQnTP7T5/iOg/AtupJeBx2w/ljqTcq+v74sO0T8VMMAJ1nTe52kiMO/ZJz0PGGOa4z92IxoCqWK2DfNe2lUgDlWtSI8YdH5bG+qPKtHkvv1qEt9lqjGaEZ+A0KdHt1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mmt/qjh8aWzEjxWxILpmlnA7Zcfyim0tWG3UMBxFG1M=;
 b=EcnMGxc8zZIv3JxWgCx0Nval0t+JGtMPu0NpSgUlHMf3CDvXUdi6r6V4vqEcoMjASh2dx4nsexOYlzvEW8DWuzo43HX78FeGn7FKqoR1blWGjZxQGGCN/Y9hWWw9F6l1eCuO9E8SLae7fpValhzFHt3JonfnmQBkM0oDeLhbWVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 19/55] media: rzg2l-cru: Inline calculating bytesperline
Date: Wed, 20 Aug 2025 18:07:20 +0200
Message-ID: <20250820160758.801813-20-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9f36e04-2b8a-4de6-3985-08dde003e652
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h8FCx4iquEfQqyofgxzM7ViU8GKXHk1+LTSdDufoupoIIryTy98i0oGU11Nw?=
 =?us-ascii?Q?FNU+jUqXysSaVxVmDYFDW+js74RdavB49rYiFklLHqKc02yg1PSV2AppBI89?=
 =?us-ascii?Q?yDxYs3sJoQPe2NaVEqh5FK2PdRd5BnWLtM/iugGFuonN7e6x9Sb1Cg7Kcr0S?=
 =?us-ascii?Q?EOmNmE24yRSr6R6ZRsB0oXeQaAS5r3lpv/m4JXNlFwvdiAT78udQmV9cG2Yi?=
 =?us-ascii?Q?lcoHqmNec5sXkngXc1BLLZGEX66f1a56I1FfSRgxeqDTEROC4OA5E6tRfaMz?=
 =?us-ascii?Q?x/fdIJZnJK0hvFKD+JepGKe7xFGV8SWy8rp3k1s1Kr34oX+cXh78ZlZo8deY?=
 =?us-ascii?Q?xfxxE3zjN3ztmPFMHspUkX2zMb9SP0m1TIM+m2thSYvLMrDlQ0mqIsWdclBV?=
 =?us-ascii?Q?8PG/dWZ/DF4vSdJe+35WJw3sfuYNnCFxrEULc0fKNEWRykStSc0vgAeVxhsr?=
 =?us-ascii?Q?lwiPjd/BSfzw9qS2+uMgf8x5PiJCn9c3yBU3ndXohdrOGybnf9dIDgL9uNuX?=
 =?us-ascii?Q?+SlT56lgxJXO6aJsdILmBfjoRLQoEK+fvtSs0F/RTYfRR9PBrok7bEjl6+xi?=
 =?us-ascii?Q?UvTwFNBbYbIcZZpwo80DVXARVz75Pug08TKHs05c6d8Urk7wU/n1exN6w94l?=
 =?us-ascii?Q?gojyrDWAimbnAiyJnCk9JXwZkjrI2yApJfrLL0mn66Wmpijp+AeOINJOiSqZ?=
 =?us-ascii?Q?cxJH6hSKVyo+eezvxX+H66IskS8nesjFDJMZEp2KpWqgtoFmYFnXUURYLJJL?=
 =?us-ascii?Q?uXcIZ4yUe1idJqpeYgxW4h/5fX4WmaVfYGy2QcOBlIwsh/HzXEDzQYeWevP+?=
 =?us-ascii?Q?4bHUOqiAKmb9J7XPbjuUM4BsH9tWEBmO+8sJFP3KxUJyARXUUo+chTH4jiSD?=
 =?us-ascii?Q?8xvxuSy2GY3PnrcjAJpX9i5ECJ4+jqUS1ZWuepRB/ICDT/aYxkEkc4Ix6G+e?=
 =?us-ascii?Q?PEl1RaAsZMTJV5f8NPmZI3yTRKOfNV89VJHJ0PUvisePaSYWTp/51YYnPNa3?=
 =?us-ascii?Q?dPy2I8VxKrH/7WJkRzpE7fcKEBpKHAkWyfd0qdnXROcqyqgB8bQRLf76w4yg?=
 =?us-ascii?Q?REa/CP4GEP1SfaQCt9mhaE22vgyaSWgqYPQk5BuElrPJmUsPYrkj6NFW7bKK?=
 =?us-ascii?Q?PAedeevspHVdP59z9MS2Vr2fB0DlqeJkoMeLvpZRm26ju173w9Md0l8Yej0U?=
 =?us-ascii?Q?CvHAQU5TfmUije3zbyg3eF2JttTaENKwuwNPB4rFGTBiTfVJBU3dPz9LLubq?=
 =?us-ascii?Q?zcDvGFddwoRKQpJvnjC3TZ9uTz1VeJRVaULzKmbCK/vWWBgkiJFtG2uAgDWr?=
 =?us-ascii?Q?IPxiXK0frfN47XVKC6YnSqmbWp6Rzvg26QSCWVmTjJPp3wKnB030G2Em7pN7?=
 =?us-ascii?Q?LdGt8PkEbvci/vwd9V3ZSRBuk+435JfMhtpjsGT1qOi7+u9+E55CBamPDPPD?=
 =?us-ascii?Q?qiZ9nSZAyIeiT7CL/5B+7Oi8NO24AZI70e67gErtLCGqtRzq3DjClA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lXEeWNkWfK3aYQgnurbSzDecnm1qe2xV8IoECfFE29DLO5zEUKjeFtk1GYoy?=
 =?us-ascii?Q?UPiXLCn/GVsMjrGJ10pJKn70f1rkuK5hQQkfkBPWI3xfdD9xrubcDwhpHGAJ?=
 =?us-ascii?Q?XYY4Hi7Cku8xfgF7IvVVZQ3CO9H/3Qzw6ldAyweB6IUpNai8MpT0B9xqe9bE?=
 =?us-ascii?Q?tGPGJYVcYXiw6lMHUQvm5xhUuS4qbwHY2Un9V7l8C6K1GqefsxdZ0FIwEfpw?=
 =?us-ascii?Q?6pqmA4ezajeLMjxER9DtkGTj9sqi4pHdEGHIxHHzpuV00apdp9aWPXOkh3Pq?=
 =?us-ascii?Q?THH75OEu0FHpzeOZzl7j/7o62QKlYTayJ4qC5LTE+D0uoPw5vz+hkItK92cE?=
 =?us-ascii?Q?V4sfveCEvhydXz5krYkyHGzr+1FbEY2VySGUMWzEsR1z1PQbDXwkNcUhohOF?=
 =?us-ascii?Q?8tz8ssYnIfZh9l3bxxv9OeyawtTF0vhLU9cUv6sWXIC1CG6eJ2eOmyl+Nulb?=
 =?us-ascii?Q?D0yrjPvljfUPAZu5l06R+ipVS09YwbQV11NqqP2HJSRbxJGdz7gwwy881ZZP?=
 =?us-ascii?Q?W/sKY+rE4F+SjL+Ys8FW87U3Scd0ys2uW8Nfw5mqTy/sd6adU1evkp1jZF5b?=
 =?us-ascii?Q?yLSQ6Z162OdIvtUb0WBPyNjINSaW7UBjh0UUN6rLxo9RMgS/dUYQtNYWG7Qp?=
 =?us-ascii?Q?1MpWa9lq8eeXNCw6Qn0GFLGZYojnMrtZzidby1HBR+G+hmaWwxyGledkp438?=
 =?us-ascii?Q?8gkT4GRG1zaf3qRrTogLWl+g70ksd94ajyenuF762v2XB2NRqpdVtUBfuOrb?=
 =?us-ascii?Q?jT9ypF6GOO6MkoVP6wGFKAG1iqKJai+DPYP4mIk8sX1RSPdis4oceggdqG1t?=
 =?us-ascii?Q?yfKykODw3RS5vNO/z+o7qMvyDQaIgeYo97p66t849/qi30/pjFsfsqs4L8JN?=
 =?us-ascii?Q?AwnCpHWu9hwDStDaewFRyIsuUd39twamCVqAwrAfyavDPILwKCZdMCCtSWJ4?=
 =?us-ascii?Q?CIkd4/uN0t9dhSWJXTfF2X/fkKNuxcyC+BhJk5RJ1JhknMQaoUWae9eVBHha?=
 =?us-ascii?Q?2j+1S4u/TBm5ualwVAO/g+YlTIIMytQWdh0YVQk38q2QWenJBwcn1m03ApR4?=
 =?us-ascii?Q?AffBZavEUIVQfwq9c5g2XnjbPDYKvSVGaG0AncIYsBMfqow3Eu+4UcB2NaEy?=
 =?us-ascii?Q?bZ5IdAB8FlAYJM+rNeKRCCMRRZb7kX9T28UMJRwoJtGeBxg4H4jce1Bnuvs5?=
 =?us-ascii?Q?uXKQ8WeT3JfD12K8PMRT0fkGcnF8wQQg4y9kp318ln1gOFwhoHjSdsNLvJ/1?=
 =?us-ascii?Q?5EPuj8xRWLA6DRtUj0QbnEV5mWriO2DlWuxDAU/oLaefgqhLSNkWytP3LWMj?=
 =?us-ascii?Q?pHjS1J+XSdCJwG3VyQWDHWOT/iO+tWbizbOwv4bCWWs1zwUM6bvEeT2hysnY?=
 =?us-ascii?Q?g+gxtam2km01FhDh0cvsfCA1HdWc8rQsFzGgGwn+aXDg1TKpJ8bwITXxj7GI?=
 =?us-ascii?Q?yCqXypMpSAaLY+AlgscJ25liGJXy014R51CZZcdlbfQLPPU8iq7DUcsMZ6Nl?=
 =?us-ascii?Q?yDDWRaAxROY4Dc7ncCiG7pYuuTRdlcgmC7hyaZdQ94JwUFfJdJ9tGQvdBKnP?=
 =?us-ascii?Q?yh+u6kFiD3aClxAYBgIIWb3NdwkwPDl2AzOG66//nj0+POC6vkI4iD1SSnWS?=
 =?us-ascii?Q?nERRxp6h1W7mYUvvuF1SKqc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f36e04-2b8a-4de6-3985-08dde003e652
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:11.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY3Pg1N1VuYlhK7iEa24XRpV0MGg81AE/3CCCIOGqCSmvqgTB8m+vjplyyA4EAMGCXP/BuUNmzX42j5Z9RSEFs9tsxtS/h9jCUS7txbRW0vcuvn9CXR/n6mclDgup3pD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19900

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7e58132ca2bca4f46533604877b4fac080274699 upstream.

Remove the `rzg2l_cru_format_bytesperline()` function and inline the
calculation of `bytesperline` directly in `rzg2l_cru_format_align()`.
This simplifies the code by removing an unnecessary function call and
directly multiplying the image width by the `bpp` (bytes per pixel)
from the format structure.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-15-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c     | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a0fa4542ac43..8932fab7c656 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -812,20 +812,16 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
  * V4L2 stuff
  */
=20
-static u32 rzg2l_cru_format_bytesperline(struct v4l2_pix_format *pix)
+static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
+				   struct v4l2_pix_format *pix)
 {
 	const struct rzg2l_cru_ip_format *fmt;
=20
 	fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
-
-	return pix->width * fmt->bpp;
-}
-
-static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
-				   struct v4l2_pix_format *pix)
-{
-	if (!rzg2l_cru_ip_format_to_fmt(pix->pixelformat))
+	if (!fmt) {
 		pix->pixelformat =3D RZG2L_CRU_DEFAULT_FORMAT;
+		fmt =3D rzg2l_cru_ip_format_to_fmt(pix->pixelformat);
+	}
=20
 	switch (pix->field) {
 	case V4L2_FIELD_TOP:
@@ -844,7 +840,7 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev=
 *cru,
 	v4l_bound_align_image(&pix->width, 320, RZG2L_CRU_MAX_INPUT_WIDTH, 1,
 			      &pix->height, 240, RZG2L_CRU_MAX_INPUT_HEIGHT, 2, 0);
=20
-	pix->bytesperline =3D rzg2l_cru_format_bytesperline(pix);
+	pix->bytesperline =3D pix->width * fmt->bpp;
 	pix->sizeimage =3D pix->bytesperline * pix->height;
=20
 	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
--=20
2.43.0


