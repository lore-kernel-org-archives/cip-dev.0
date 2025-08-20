Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE2CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.24])
 by mx.groups.io with SMTP id smtpd.web10.1090.1755706165950108100
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rYy6Lwme;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.24, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUKPKupY2cokqUDGf9QF8yNBdig5VvxQ54Yr2lzijMto8Wma4da0AuVgKcGmD8E4Fa22XQViGlBSLPg5Q5NvahxZ374vmJRrg0sA7rNe9HtE9al9Yu3SvWPfet+JMiRjYuvZHUUi2B74uTZpTsjwNi27DpWa4siXHFuQfzr75P67ZkUM3CsveGAgtjeRam+HTqUl7e2ccqOK5t/KNXaVjSQIAaTvUYgVPJZVa6Js198FL+nptiC0GpyiBr1wqrFbMr1cios4NNnM1xV/s+n2urTSags4JkmOrRrmdHtCfJm7nPGcwa+5SsIw/jGImCETaxdnzUe2+5ETwPn0zhwhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0QEInytWNYYBsBdq4rz6CiZBQ015iDPCF88/0P+TqY=;
 b=F5B3X9eXNmh1CnQiY9y+LUqNfbiHQ8OHREc2ctJlpkfonASInxlz2EdoWpGxSCPjld78yNGzZEx5rlzX4CmAMBBJqvL4xKJJbR8jTQlZ2eJ/PjiZmmIoHIPm/M0x66ZgsWuVDp0YLiW/QHRS77IPDBYQJeQhw7rIv8vunsX85Y5QPVcEgppIkSnyD0ARaBZVip8mA4e8+MkD+yLvyeCbA5XjZ9ZWnTKSamGnfph124QQgsG7Z9TFTPizTFsopCle+t1MK9XQYdJzquQRPQq4l/NzJYObTJfEjk9PsohFhsQXWNjUDBFpYT4DJK2XO9Rogy5MS+XoeYKuFxHLcTi9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0QEInytWNYYBsBdq4rz6CiZBQ015iDPCF88/0P+TqY=;
 b=rYy6Lwmez5S+ieda2fHA42BYJAGk4U1VAUNPTSQcHGyN1jko8i804A42hiMp8MVNA9hjg5eJYhDGjq4sYr663j7aswf34w+1p65mxU9oVTZtNJv0yLGCyE8AfAaUY2Sb0k3mOARqiIOWJjDdEu7MZFVGIdgU7/fcX9Sk7KoO2vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:23 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 24/55] media: rzg2l-cru: csi2: Use rzg2l_csi2_formats array in enum_frame_size
Date: Wed, 20 Aug 2025 18:07:25 +0200
Message-ID: <20250820160758.801813-25-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e8f1456-0e89-4b7e-2711-08dde003edd3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EzOnTNQ6LO8tO05/RwZK0Oht9QWvy40yiC1Tlekq8/8vUw/74DO7IWm9UYVr?=
 =?us-ascii?Q?N3YBL9d+fTEHfNA2NcY1HHy2MkCE55gxkQ6srcYqmEVfsdYVnhiBfCl9rIlp?=
 =?us-ascii?Q?FwVhHStXfEqP56fVQXd1hXvGD8kpQp4CPUhrWJ8dNrjAgyp0aLb4C1SRsT9q?=
 =?us-ascii?Q?fG3pGyU+4lIVe3pEF99cPRxyK8N/hQeOcnikuLHxe5RseTamPnZ0Xl0pteo2?=
 =?us-ascii?Q?YALqchQoiQCpxZpEY7/85vk0vXMpeC4DBY1KnqpykTPA5lL4I5h/fo2OMzcy?=
 =?us-ascii?Q?vQq9Ha4mrx2AS3Ycp2WHkda8+2e1GPKy/R8lWN7TU5oWlJHxnG7MnlCvI4Mn?=
 =?us-ascii?Q?EatdtzlI3gF99RN1YphlxuAehBafylWI20ToQCPk9iIUqkUsFlEJ0pjcqpbp?=
 =?us-ascii?Q?u3NSLvLqCKowhIvYXLxl9V46Gia5SC4OZceksIDarG3f2SD5uYnYU4itMshm?=
 =?us-ascii?Q?ldybCQ9YAxF4CKTDhx9FDUOMX8xlLlYCSn7PpXqe2dJCCAAsfFnDqKuOE+Vn?=
 =?us-ascii?Q?BKzbnPexiJSltYTVXU7gRZP7zPudHZiqs/MxlV3quhty/B1FFFxI9zObM78r?=
 =?us-ascii?Q?XCFm1T4ECXoAFqLl8OeKM6Hk8cL1I+iLR6T5awtXqIg2duu+1dePQHX7MGeI?=
 =?us-ascii?Q?dQuZaByCbLRY/DdMvgDafxrFvn6mbtros8PEWXKNHUoiHQUNXjeCb/85hiaA?=
 =?us-ascii?Q?pQ+pE9AbVUDQZWR4pA/kZ/BFiu25wCEF9VW+iTyMoU6FZNcQl8R1Dfo8P3o0?=
 =?us-ascii?Q?L46ybBxvo32/en+YDglYRUDmkDJ8fj/pf+NnGXJlPFMjp9icSNTAWFx7uTrR?=
 =?us-ascii?Q?PHc+P5d9Ww7x2PNVsSTAvRlo9PfM1/Qmfm36dGxWDn1tsb6tKwA87B41pBec?=
 =?us-ascii?Q?zoxGvvqhCIHW+NRx2+l7YAnEEe208ftceq3fgEdZ7jF5jjngqfi6jafdclWz?=
 =?us-ascii?Q?znFMvXCB3xq2DVYRoPbI9nShTnhJhP5A7VC7A6PlFXXhyBdzSUvatl5gS9uS?=
 =?us-ascii?Q?yKP8FZQoUUeEvw72FbHCkGsJ4jUYWRKPZwBaulP6jIii0aQa1XQTepdhi+Ay?=
 =?us-ascii?Q?Qeo5ku0Rnjx3lxcGtbFATd4B0e9HE9VxX5vFCnpsXT0d4o7qmEemA6X4fPnv?=
 =?us-ascii?Q?NTnmQ1Fwo4iiLFeU22zG6UnQ7dCEftpaNFGcSOBMeMi/XQEg22LT3HYbvMvu?=
 =?us-ascii?Q?OavfNCi41jaRoHuPCbk1Vu78R13jNH5Rk966HyEtMmNexeoFK3LRr90ETXwY?=
 =?us-ascii?Q?YsHxNK3QaigrttBcwP60ZxCya4XtQ0+8Ghiip7gEEIhzCDgrAweJQOA7w4Ho?=
 =?us-ascii?Q?f6NUBQ8O6RGAvA0jxg/Hpx+g9OpH3VhdllPwVig4PfPNhrFVVC46S3abFjTf?=
 =?us-ascii?Q?Mf2wOwOJf7SV7hjf9XbAjLc/VVYTnzrmxzM6XbsI0Km+fo0oXDPcdjZD9We8?=
 =?us-ascii?Q?pH0rBAJ9RnojsfQ1moHq495GkUS6KdkNmPmMBOtQGbEL9u31Aa8BQ40oqKSj?=
 =?us-ascii?Q?45QVpht40suif9Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t4qqkgtfaCmI1FNjcdFCVb9En0e41BxmiAmw27fBx6kUzP0Ubw+5dzFDU9JE?=
 =?us-ascii?Q?+yTdkctjNvU2NZQFzHsSP7Y0r6zBhZq1x2F4wsar79yxbEA3Ylw6fphKP0wb?=
 =?us-ascii?Q?yl3N8nfYEPp3zlVyQpTpxPFN9jgI3r+qZ3y0ASOVxv1L0g2DSz0JV99mqlnR?=
 =?us-ascii?Q?YMS0+McOBqwKXZta8Ea3hL2+haM4BvMGLNgoGkrI8WT5OQ6N6PvdrkkD4DPJ?=
 =?us-ascii?Q?HzW1KkCHdwVBCuaWZU2Q4mmjEoB9TLIFe3h3SyRQNB/+2sfzJ4npwbZtSS6b?=
 =?us-ascii?Q?YF7Znp5kSXG18m7BwQLxdaDOOzjSBDCgOx9dNsMjS0F1fyHJdP7UA2q7wafs?=
 =?us-ascii?Q?cnNwtbtjL7lev8Q+n2dx2GcKIyDB71WR3KiWdNoJzJGwMQIwO6SI077MERGq?=
 =?us-ascii?Q?YHecG9oLRUTkgq+ADOycgKWT/7CKD+MN/DPAEy8E9BeXGtPzdXeRv/Yjp/Jk?=
 =?us-ascii?Q?Py1Alb0t4tGoip9T6ymPAdBw5H+ZcErQ/5r4SlWUpCnRkpAZbOEinYWnhRrG?=
 =?us-ascii?Q?7f3fZwu8E2W1chb42c2XVpGqkB058sxOGUfChFTMZJ6ge29nBk3mEfmhVdBa?=
 =?us-ascii?Q?XRNa3cqFnNes87XooIftgan4ffHFfIqRX48wgDDbfCLZo28OZM1nfL1mm0N1?=
 =?us-ascii?Q?hHN9qXSpT3h643pCvprM08elXOoi9uyN1nMkBG54+1S4w/NyqAxgKkL111/g?=
 =?us-ascii?Q?6i1hSnvYc8o8nb9MrVP4CxIF7N8zVibgIVK9n7afRBidqE4Gxe5fDKRx8iDz?=
 =?us-ascii?Q?kMNZsWtV0XS34PruEJPPbajZ8yMa8PGx0ShNuQDm7dcnfRoxF9VCWzqZZMtn?=
 =?us-ascii?Q?CNfh6UmCRtO3UI4mRNzv50kO9GJosRg/xsTi5qSB9zoTOpmdcDfZBsgBYftg?=
 =?us-ascii?Q?xX5F+00ltXSyztDgJZ2D3k7Rni5nm06e0ObGWY1z5gBdNmjdTOFvMbNJGmA6?=
 =?us-ascii?Q?atORyDy22sWYNwYXGivuhg89N5eaUJ2rhfz5pOI4ihgDmhPWu/BYOPHTeYvo?=
 =?us-ascii?Q?9r8RUyEw/8Om3J6x4OMJX5+Qaut8IoFgzN5qKsrPe1EevLkpfuOwh0HH/yBf?=
 =?us-ascii?Q?Cf4/sYpsmh4ddTfHJbRBhVjer94Jk4rqouwBlcG87AZAIG/hqHhkBhys7E88?=
 =?us-ascii?Q?NMXVij3+KACTxh2QJS2OfeIM88E0GH9/n7DwaRB18l+REun8xm1bWYC25D+v?=
 =?us-ascii?Q?g+5NCtOzNpBxCJYviC4xBDbuScbWOWGPEpIy90cYrFcmuiA3UrnrqHiDhdnC?=
 =?us-ascii?Q?ft9A8R/1xtssxZGrh7U43KB3oMDP1JE0zDJZiviLMFULR4+kIr1PwiYiN+Xd?=
 =?us-ascii?Q?GvFdV6kmIamtrGtpCtYYUqi3+4feRim7t1XIOMxfNUC9Ks+5ntPaoyXickdn?=
 =?us-ascii?Q?e/BfsWti8Vv028srBCJnMnEVt9Yc97DMXbK42wa8TERLBKqGoSqoaeAxGasC?=
 =?us-ascii?Q?T3qxgt6dV9g5obKXhLka9A4t/Mbo1+R6202VdYA7UX4qGNaXZEU0juem7z3h?=
 =?us-ascii?Q?beU6giBlK7xSozsM8rLsp6tNbiuDxSrdfokgDverCQSCHkkCRQpW+VPnVqDn?=
 =?us-ascii?Q?pmUhq+tSoAwbEVpCdflF7kdWR6+W2E4V/X8J39XjZpqtRjUcgD2I272R6cs+?=
 =?us-ascii?Q?b49rj1rJd0gLSuVKLs6Uh70=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f1456-0e89-4b7e-2711-08dde003edd3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:23.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37rQPr0kFX94LHOTfRW130kXwyqCk3B3eVzo11ouh/aUv5heyA71qxStyqP1Q9p1RSX5EEouELP20y2AGJqW0sibCqCuhew+A9QVjy2R3qTAfi2COqYmLKbxu6wYFkyv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19905

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit cd559c80ddbf4819f697f3e3e16db15977298cab upstream.

Make use of `rzg2l_csi2_formats` array in rzg2l_csi2_enum_frame_size() to
validate if the `fse->code` is supported.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-20-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 7b76d495cfe4..e21142d3b67d 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -573,6 +573,9 @@ static int rzg2l_csi2_enum_frame_size(struct v4l2_subde=
v *sd,
 	if (fse->index !=3D 0)
 		return -EINVAL;
=20
+	if (!rzg2l_csi2_code_to_fmt(fse->code))
+		return -EINVAL;
+
 	fse->min_width =3D RZG2L_CSI2_MIN_WIDTH;
 	fse->min_height =3D RZG2L_CSI2_MIN_HEIGHT;
 	fse->max_width =3D RZG2L_CSI2_MAX_WIDTH;
--=20
2.43.0


