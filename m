Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162BCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.8])
 by mx.groups.io with SMTP id smtpd.web11.904.1755705943287676103
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=SPFswEBW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVveNx/srodBa0ff3fI8QM4LdmB91nnxGkgrGnzVevBeGPt4483LDdk9pVyR4RBXQCM8t4BQqaxxZ4xNTYadlYmk2mef6y0j9tNb9GAEdxvXAy/yZ5SwVAbNhO8DJj5lIo4ybGVeovO5b37Kx5rRMXAUAjigN4Ogurz8hj14WdNh9TgEaSB1H/yNNkIRtc2dg7h74oXJgZ5wCppdKcF+ewu+GA22+vCz981Ryz0Ct82ofgZxKELuNzp5IWgwb3JkD0vg07rzPRyvQ5b232sw99+hxpsDiEIW2X9YsqWNWU73wxBDtlZEHWMIcGvlRKvhnM4ov9HbbRzCUs4IY9hWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0N+8v2YeykdFJJc/VIW3rysFCkCD6gs77/FlAt6zOU=;
 b=sUkDMtGEr/4hxdDgG+fi6usvg5UYgcl1D5EcNmH/ugUTgGadEvzGZiC+S0A9Bwy81EclZLkf4kQdKPqCOszA6ZYWaAxhVXBLUGUWYlj/4FWhjyB6WelwkUTRAAniAQ5/lVH/GJbpVdKS1eGIh7dz4eUS1SwHBmGUEP+dwITB2c5IZ77T4SUYkS8LwjNqB96O9wP/UCUjCvqIqKDzl5ujqbu/tCCGEBeunlotU0E1lF+URNHIoV4HLvXyJcAeXnKnHyEpScldtplDpDNE0FBD0QwiqXgNs3n+5/sA4MfZxGcan66LfeHcbZQb6XrJnPVgu6ASMGwEMNlhcqDGNBnppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0N+8v2YeykdFJJc/VIW3rysFCkCD6gs77/FlAt6zOU=;
 b=SPFswEBWMwb2e6OmBoVprLzITzqQDCAb9GSEIU4V+8a8tE31z2iLH4Kw1774wcU56HoNCQflfhXBNL30UoIrOQ/rs8IDN84F45eL9IymS1RuErWH6yxlZhDApDATvaT3anqEY3O3oZsRv6yAQnCd8TK19/p2YboO6FwKGLvQXR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:40 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:40 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 24/55] media: rzg2l-cru: csi2: Use rzg2l_csi2_formats array in enum_frame_size
Date: Wed, 20 Aug 2025 18:03:40 +0200
Message-ID: <20250820160413.801341-25-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 625b4f07-01f3-438f-d612-08dde00368f0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LQs6CufEM+Dygw2FMX2TLQC33ayxbZEItKyynGAk85B0jjCM1qpQqn4mBLeJ?=
 =?us-ascii?Q?YgIr2Z3DluHX51HfvwaMg+lFNfWm5/uXjm5Sqgb6rRm9pSxsLNjOmG9GLUPB?=
 =?us-ascii?Q?ITZVhoy/jTYQH15VMA8vvg7mM4pWzNbb9iiJAg1R8x/kB7uQRgFP3lq42Q1o?=
 =?us-ascii?Q?Nhcu3ZqPkqugNZffF7PWZI/Dc57k/80lR4aHPRiLaoDZU5z5uaA4uCJ4BIKR?=
 =?us-ascii?Q?Lupqi6US8PGci9AI/dORkh6NIT9Ts1ThLsGru5eSc61hF99jDilTG9fMbbeb?=
 =?us-ascii?Q?tW+J7sHhCCvRdC1V5Uewbapy07d1alQauf4aMK1zxSfi3lzWofy/KCoZjdFE?=
 =?us-ascii?Q?v8BxUewlqm75ebc3In5/fwTFk5TxRwrrABxvZnlmEphTs0c6C/kO5tm1P7Hf?=
 =?us-ascii?Q?FD1x9/rAwJCpidHyucO6LSo9NT4C2/L9mM1rMnTgbaHm3Qg8/3LEHg02LOev?=
 =?us-ascii?Q?rAbNz1nWTv6Y5RC2CjHASCyToDIL6tEseNT1d9JTlmm0ngq8bJVA4sDNB4mk?=
 =?us-ascii?Q?67P+Dd6t8mQR9jOUDNR+wNw6FIKh+YOa4mU/p3weDrKIP4YmQi9skGGGYaKm?=
 =?us-ascii?Q?qMwSwIykTlCkNhBsjK/vF/6WqCaUFU+TeZpc/oAFfWDpPBeTYo6dSJLclft2?=
 =?us-ascii?Q?BCno69Zp0d/uaiUa+t845xIl27MKXLrzSqb4ra+a++q0Cf8FD1jxbRwxgtmJ?=
 =?us-ascii?Q?ZEhjFjVI/8GjYqTUfNX9zm5XSfEtjLT7kspb3HLt1zUgexIgg2yCPfo0RwlZ?=
 =?us-ascii?Q?88NwH6CZHIvu6hGgpH8ipjWJjvpTZ74nc+UxC/XtyBqszLnS0s665/2nc3f2?=
 =?us-ascii?Q?A+eve5vXJaO5mUHJ+lFOm7QyXK1N1+30oM+AID+sf2Jo+uWJPaQsxjP5zb9P?=
 =?us-ascii?Q?R9Vq+34eEZfnBbrz69/97PSGvIKoliEBpNqGVqdFFsK6/hz4FGT7EM+2OESS?=
 =?us-ascii?Q?HS2vJvAyBZMboylCZrywl2sbygh4MwoHBIUqCNDB94xZ7cOiFMa8yXg+Cl0P?=
 =?us-ascii?Q?Cx687Oq3sfWfnGBICxMWin1BB0mqcf2iVWsS4rZZ5jeCGbkRLeQb20DQhqRY?=
 =?us-ascii?Q?soDbx5ETU+XNPDZ96ACmjNDUY8Pk+OfUOAjRWqPp1zRpaqQPTR4+2n40BPaX?=
 =?us-ascii?Q?1589UyMwCaH2kr9/AtV3CD7ZVL8TCViK0UghYajZhfbXwMfQKr6y8Vm+wQAN?=
 =?us-ascii?Q?FVEsG/MKx96LSli6Q4Ad96awEK2GUuI2p0JfjGSE0BT/JGuHTXDPk6s+1Kc3?=
 =?us-ascii?Q?8zzCa+twryC1MHOLOf5PcADJKuRMLu3vFgsGW6feuBi49qHipISYa1D686TM?=
 =?us-ascii?Q?E73tht1nfoIaS9RXFQ18z0WrT3vtXIo+8tdv2HuMLaDubzERlzw5zqpcJqiV?=
 =?us-ascii?Q?ii/UaloyZBIoscaAbazYgKvY8ywDaxLUkQwznCpRgZDphcdKS9v6ZQfYqCY1?=
 =?us-ascii?Q?JeZbwGr6tczCVcOogkTQ4hApkMByObJDsjTgl3317WtEkIH7yopjhjNbFHU4?=
 =?us-ascii?Q?oIM5RVIENTUQBas=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WCv8c6olXM5KJh7UUhBFbh6mAbLgwBL2mJO7YNxC8UvsUVUkRn7zKn+uX8e5?=
 =?us-ascii?Q?TObigTN76hUCSt0Lm+jV2uq+a2zTyeXiK4C19cZt0eR6WdfYU2iiuxIh7EMX?=
 =?us-ascii?Q?jxnCpMo3c/LWOnfCaE1axKv/GRUHqoQQAF2HyULq97YSOAbiJzzMMBsjnzaD?=
 =?us-ascii?Q?9vhV0//4jyqKFcERBj+yfFS6XFJuHVrJdUMZWnHt7WqJrlUZAi4uCuvKooEE?=
 =?us-ascii?Q?EzOvYLCEAy9V2HPSvdXWdEfWDBYtrp4uylPZfIXt07ZVggbDAzLHoKRq5w3h?=
 =?us-ascii?Q?gYwXhS2MWJYKkewGZw3dOh6QmJZj8xDOQ+qwAL97aWsOKM7ZTLIWDGsp+Gql?=
 =?us-ascii?Q?aqI0XevBN77X3uBsNqSbh3VdF0CniN/CHBF0aaFIcelnaZKfDnnE5/tWYSS3?=
 =?us-ascii?Q?4JgzUE2QAmU5MVFVYzTwA0ImdNCuUXtyPo59ep0rNiGTOu7QnEH+DdeYc5r4?=
 =?us-ascii?Q?FfhXA2IlqmQ1faE+a9xHmxRh6Ba9GYZFuKqJuh+MHt93Cb6O0/fYoJiRDGui?=
 =?us-ascii?Q?7lafVnRcHu06BKgUqN5MNbTcNb0Jr2PeNu3/QW88uPBaBQZENySTb3xWMMCY?=
 =?us-ascii?Q?oxWUhgrMWwhTcFIcSaOtetwfQpxW/7a5agA9fdC+b67+nvKZ5qI+NSsHCLtv?=
 =?us-ascii?Q?cR8L+ObmGC3hj/uxdeAy2NkP58ewyVignuJT6/i6fnukL7qUODWqDjvV4q/0?=
 =?us-ascii?Q?yx0z466ULrK1Yw2bduy05uQUoG65LwKiRDZtSYTLAaXZ1Pg4rjTg0qiBZBCG?=
 =?us-ascii?Q?GZLOMQKQZzqYFdzN7UT1N1X/OG+IyM7YW1FeuI0XZ3xCyRTbojqcXFWVXXbW?=
 =?us-ascii?Q?tHxAsgeP1DqxF9sD+wNb+iY6ZvfXRJvWbCKKQjpDpSL+yIeFTiFTD73wxcPM?=
 =?us-ascii?Q?X3XzY+RZjID74lazdyAMjFUfo4UiJqgHmUA9JVcNDt5rkcu/47Lp1FzbKc1C?=
 =?us-ascii?Q?AiiM4UlBdUuzk1GsqXiRke2UTk2q4cCih/Uy0npyJ9ZTgXhVQYCJ2TzG5jAL?=
 =?us-ascii?Q?yxtIT21hPtBEQ/zKb6SxxU4+D/ch1xqvcWiYPZaQ4XYLLyXLkZHrn/cGE+Zo?=
 =?us-ascii?Q?C4fXaPaQ6naVnIwnwbRELMK4lD3DCZDB8dFAp4Td3GI68iOZeG+LFG19OsQj?=
 =?us-ascii?Q?XMhV0symHclMCa9wSbkq89B0k3TVQz8fMeShuXLAoehz/n0QEOMRNz/GHFIU?=
 =?us-ascii?Q?Hyt49FA2Cz1YeXdZ7/JXN6DRGvc1MlwvSDrDMZhf0N7JaNn6MIKYgl6rvmIt?=
 =?us-ascii?Q?R/pKTyv9Mqxgpy0o6Tjz6CeGtUMIiZAlEjZzT4/+iY6O8PLZ9x3/+jQuTjLk?=
 =?us-ascii?Q?Dg+3OQFIyRza8hZCzH9da7K5n9SX3TbxRffXXrcXApfa5VxAXzo6XhyKvf9p?=
 =?us-ascii?Q?eEliP9YVbH1miVXxtlTTJ67m4DOsk3d6FuFQRy0fJQrM5tY40nlN8Bf+8a6I?=
 =?us-ascii?Q?3JKT5jimGyeau+OGRTbcVahCIkRQtN973CP6SWPvMw+ZxXOpREpl+SaK6pPh?=
 =?us-ascii?Q?VHQJcLtDn7JkfF/D1X9PmoT6sr8hd4itn/bDNaZiJUoTWz2XvkmoSfb9/O2G?=
 =?us-ascii?Q?YWoJOyPKUeBRnt7sxzJ0CvYVlgK1vQ5PGepdKE7mm+D92SfSwn67FSj3zb9Q?=
 =?us-ascii?Q?qfpxx1kgADyuSpiLSnr/oLA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b4f07-01f3-438f-d612-08dde00368f0
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:40.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCc90l4M3Vub59z9fgnCPSvfdeFXFCvqksP2xFS91LWhdPP7XaJ6+weZ2TANvcSzU4jEZg9o7J9tgzIQv+Vgq+YhNKkzZxaGXQJbkkOBXF1Davdn2NmQbMvH+R5e+r0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19849

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
index 3416bbaf4dd2..c11158f5fea2 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -574,6 +574,9 @@ static int rzg2l_csi2_enum_frame_size(struct v4l2_subde=
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


