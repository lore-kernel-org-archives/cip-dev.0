Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1928DCA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:04 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.24])
 by mx.groups.io with SMTP id smtpd.web11.1024.1755706138291523893
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=M2q0jPir;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.24, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xww0XzmUfU/oUqpr2z582vnXaV0zxf+V8In1XDxlqwtvx2+73MAChbHlV+/2QP/E4U+SbhL4Jq9q8FD2H3gtAaW+Myb4nJ9uIyj9hzlwEmFuCBd5c1d5gD4UDqRBBPSCC9z55OXPQtPV1GTm6bNuCZ9HJr4rVo2ZUwbwGv8IjXSnlEsShYMOsJ7Tr6zsU5MUcSUCw6mGpCwpyENRIIkZEku8q8GiV1qvfm/QLj47eMk3mGUS8WlOn3qlf38wQ2WH4xedzK5tV2GubpCKpMEkruFJuVz/WnWAIyJCPR9SutpjhbVAcw1OIzdCq/jg2Mu2FFEw2GSSTEgCZTL0QW1XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6261LxWKfqRuEExdPy8iTgl7jDfYK4G2j1hmITwYzks=;
 b=p/FonBscSX490VA/HQR0lfBVflhaMCCFejupSC3+3cy36x/wR0+HRi+K26da3y+ESAlmmLwc1Kw4jtUnZym7I+ficfeBIa8m8iwv3hzf/k52dkLtNKu6ELBoMUJuD+UuAXOofqllZZho1qvGT2gHSP2htfiKFSXSFmMiAEsCjF9449dFNu5MV1iHxTX+eJNSSPf+d7jOwIVw8Xj9ZPhSlWLMZ7FLCJFzAaszRyOu4T/XxEh9vs9x5+l3Jur7jSaTZXpZSLP7KcBZqq48h+WMkMPbPzeYkj8Pria8eLbC+VV8dDPB6tlHKh9s94C9UhxzrnFD5PFDZQzhHZvD7J/LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6261LxWKfqRuEExdPy8iTgl7jDfYK4G2j1hmITwYzks=;
 b=M2q0jPir616IRrOywV78nGylAP5UoiR8a4uKMrDlT8dlhDVOWigdfMtGQqYBUluby2Fn9bTMNPwMkwZFV6WFt7aDktxxsdXolrQgmpafA6U3AoU1IF2Yonj03kJf0Lbsnb6yCdBYr1d5+lsopxYtU6W/0OTkY3tbHvfyFO7Hgcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:08:56 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/55] media: rzg2l-cru: Use MIPI CSI-2 data types for ICnMC_INF definitions
Date: Wed, 20 Aug 2025 18:07:14 +0200
Message-ID: <20250820160758.801813-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42c3eac6-550f-488e-5158-08dde003dd68
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RpFYG30+n2igoo5fCx/XMHMUVexd2J2LZLXoI5PwQmJYEC30v5d0vmby6Nly?=
 =?us-ascii?Q?Vza9oEnop3NjqrcFcm/e+i9L1LzvAsUuhuNPcOL0jjjGpEPEXzBD3TOg9Jtq?=
 =?us-ascii?Q?iyqMy5DSFGiXl4zdcu0ZLYNEGrkLQoZ6kltCVG1Oq/WWeKAvoE82tJUFKVfS?=
 =?us-ascii?Q?94iXp365jCUNW9oD1aMvMpfixlNlcFbVMPhE5Ch1/jLiNFB5gaoXQEd7Q12S?=
 =?us-ascii?Q?VLnITNeDDF+kD3ow6813wyvLNvQH7yEgGT7D0SpxhA+m8PmA6uPm31IJyf6C?=
 =?us-ascii?Q?N3fTCz+LG3OhpPk0oD+QZJ1+kZrdtabz76A+ejl2jCTQKE4R3N9VmhCEzrN8?=
 =?us-ascii?Q?ff5yusCZT7lrqURJnoQ380EOmK6hf+pG9RSfiRvTBouu6Q9oU/VvWBR3Q4DQ?=
 =?us-ascii?Q?wxRZ8ZYpl31wsCA8uYAcLn7rT8k0SNtFz4Ta3jpK/Mw82aYJ+D9KKC+2mIKu?=
 =?us-ascii?Q?ftxTi5gFKO+vP6FJx+ZR9E/hxbMnRQIBIDgeLRsat0yuLZC1kDaAo+XvhNEg?=
 =?us-ascii?Q?UcRFpLSK4yxWeDpdB7b90xaqf62q6Ib5uh3Va92Fk2D0ECgcfh+j1dvV+/Hg?=
 =?us-ascii?Q?mU7r+t0XCl4OT2U5LtHGRdGhCsSAKwpCBCLmy8T5XUuSynfvP5iwObQTVCUC?=
 =?us-ascii?Q?/iJV1kVqiq359jxvbj0ITYmGeEFEuLPpYCiGnGRPdO6FGUSZBnKLIrjrOgFC?=
 =?us-ascii?Q?39xSUrJtDrs8nAFLpxXUQkiekXsrWcr3dpMh2oNULQXziMOu5T2zwdiNAWok?=
 =?us-ascii?Q?cFqfe7R/hE/6R4EqIi2BiRmEXzb8vQJQKFqJh8bR9XtdTiHOuGi3u3o5OPe5?=
 =?us-ascii?Q?Ed4Y8zHdJ2EvZyl2ohE9nrQU6oUM5+7xTKxGABs6JKJB/EMmDQUoLD5vMrvO?=
 =?us-ascii?Q?9QQsxe2sHitd1QDCocZorjm9kIjPAJ2hsskcAadv6K7419/uJaHNwoxoz0JT?=
 =?us-ascii?Q?1vRseW8fuU9dQmgVd5XD27QMuIB6Y5sO4Er9B5vwQ/6K32t0XDAikzeAwRgx?=
 =?us-ascii?Q?G/FAmYZWfpbauMVWinnRRe/Dp6d+eNDVOvq/lIf1tw020qNXHOCg4SSx5ojn?=
 =?us-ascii?Q?DG1Avlj2OSxY+yq4kkrTUDDYxGkMGYU/ktD/l8lVW7R/gcesYa3rJakJG1rQ?=
 =?us-ascii?Q?IUE98j6EaGwPlJIECs5Wg/0EF3y7Ofm+TLI/4/AahQmiGL3GHzaqbtqxrQMg?=
 =?us-ascii?Q?z6RqmpLLUjfsc9Pah/GXuF5t2piA+KgLyQvCnYU2yki3sAvUlRaCflUwpL4j?=
 =?us-ascii?Q?6v8dQtAL1UOMAQCMMuaotfurCsHQkZHaV6neDklLhkA9vPdxPC4WqdV3J/dZ?=
 =?us-ascii?Q?9ICd9bU3ntP0wbPmRxSyCkNADXz5IuU0ZGjZkdazBQexKrmCzPaVnQqi5Xrp?=
 =?us-ascii?Q?+s+hFdAKYaleAqf34QuOcMcGie+mCvDFm1GBNNjtkYSVaQLMtFmtJ7FXKmoV?=
 =?us-ascii?Q?aUB6LrrUFu6GpMZ+e/eUMMfIEir/yAdBnKXMPQVc8o0KOH5RDh/76x8ZLR6J?=
 =?us-ascii?Q?yLLXKW2vp4NREug=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1fzuQQ36S7gTf25RPhev73xCo4T48kGNFruB9XQOVvruXmXNkDlF8hFsPRPO?=
 =?us-ascii?Q?E1NgaArjUm0G+SI4SkqvRCsNqxNyvn0CCax2ZHcCP9p40uR6BTtARsHU1orz?=
 =?us-ascii?Q?mVjYKX/nw0a/60YSlrpiTppEl3GcqnT2YmjTlLH02kz23hhw5BZFOpBsdjnt?=
 =?us-ascii?Q?BqsgefYIJaCJTgNFxKOWQVjgSb7RIlUwsRJVictlrc3VZcIIRsmqSmMhmLJJ?=
 =?us-ascii?Q?p/SNyBq/HxwsXC+hu4L7yrdYtkiRTzhkZcK9qB6HJFV24FHSgOLjRNT9RlYM?=
 =?us-ascii?Q?hTzAfkcu9MqWeniL3NBD/vKAeYCgsx0r04iT0fJ5pA28uvBkSRryEpItLnEH?=
 =?us-ascii?Q?Xm3iS9D01m9I4ICI1sCw7yOlZLKrHYjrzNLhY8J32pRKRyTxmQLGDcLkOwWW?=
 =?us-ascii?Q?y7SpUpTcY9hOvb1bjKE9i4C6o7ud9wHb4Xcs+rylezAeJrZTZKB2u2rcXVgX?=
 =?us-ascii?Q?kUsk3BsJKnkc6f8usjloEu9jREhgu9HP2vsIJLx9JVu9AatP72g4Ci30435C?=
 =?us-ascii?Q?6V8lbvJPZTm7UdjrqHXAuPdxZc7YYJirM7wZMuH1+WxQilGf0MIzFj2LqwW6?=
 =?us-ascii?Q?8AbXarHpftPLayVQ9HSz7MUYLrJ2bDGQ3Pjd8VaXLcvul0oHhQ6fgV3Q6rib?=
 =?us-ascii?Q?hj+KRKW9juoTitgpwLZ+/UwLB9vjge1dZmNF+7bsb2S+ycvppRZYZeo3AXCa?=
 =?us-ascii?Q?wmd3yarZIx7aDPRsrF7gHl5PhBcWrfoyIjg5W2S5n2ARO/HLkzr+YiJopDeF?=
 =?us-ascii?Q?KfFppq5t5Nr1YZP+1xb9Rv3s7eh8p+F4ioxfZIFr2cYAwWAWmCWZym2n1+Hy?=
 =?us-ascii?Q?KXgCYwAujrRCn4wWnXgaYF5cGqiOZIfjpoSTMU78ioAmcYPppW6pJ11ytD7M?=
 =?us-ascii?Q?yjup9o5vTxdQgLKDL/qcv9KZpV8V5auWp6T276Wm7LJqj/1IHoZF7tPanDfV?=
 =?us-ascii?Q?Umc6zhRcr/7WaSVklg2KNWKicBhR3dL/mUAogtiEZkQaZOlN5a9aOKSbDhPk?=
 =?us-ascii?Q?HrU3rzWRFG1N3IWXXcznpPczece3gCML/8TgNXQF9pPsZ6hEn0KD8lX/aI+9?=
 =?us-ascii?Q?ZfbYvry7p2gqYhDmAnQRUKv9Uv2bDZha/3DbfMR4XZ39cVjR61bK+0sYIrNs?=
 =?us-ascii?Q?kRPm+luk6vqc30Qnyqb6McipMP/t5PUFMyyWHgZvJhiqtt8/jqDdoTCizhPp?=
 =?us-ascii?Q?Oksny2nauksJZzIpVPFtxdNImJdmaxu29jnccQkC/00oG/iBH27rQsHcDyMx?=
 =?us-ascii?Q?JNgID2DM3f0AFB9gncNM5vX7RsglngdWE9Jn6ney3QvBMbDmFcIE+cNXxLnY?=
 =?us-ascii?Q?S4gNVv88QBHwk/FirPrCF/HdZUW4pNsUPUq00D0aUhSJGeh8Qz4hdNO8X3el?=
 =?us-ascii?Q?tQkGWm42ZmFglzXtTmtYusgRkDJ4t1/CLL6LTxjJ3N3wosVA2BFIbb9rVuPg?=
 =?us-ascii?Q?x0HkUBud1L3O1jpHyzwC2qKxQpeeWZhQA6QE1iBJ3SWqufCqCsDPR7Vwu3Cg?=
 =?us-ascii?Q?PnKdqzKMztQjV4QtYJD0pHQUg0xL8NNEZEt9+t5nLHrI04zxY9Nouw1Ia1Ty?=
 =?us-ascii?Q?UcyoWyuhH8Q0pzNmhynVTY/3L9ldhiJObswMOYG+VKzrFSkq3HzbzXR8rzAl?=
 =?us-ascii?Q?CaHOesdxJeI1b693a3Vi71I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c3eac6-550f-488e-5158-08dde003dd68
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:56.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8TJl/B3M1z+rOo1l+3lkVaa1KHX4XaXUm3q9oELdl7S208qsfm7247D9Ie87m8NGxFq3SZdu85oicXDUymTsr+sTiXavfWa7cYjysHHLZOq5sQfQD/n18oRli3nwI0H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19894

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3b506155428ab25611e73c4ad67b78fde7c0dfc7 upstream.

The INF field in the ICnMC register accepts data type codes as specified
in the MIPI CSI-2 v2.1 specification. This patch introduces the
`ICnMC_INF()` macro to use the MIPI CSI-2 data types, which are available
in the `media/mipi-csi2.h` header.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-9-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 9ab7ef33c9da..de88c0fab961 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
=20
+#include <media/mipi-csi2.h>
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-dma-contig.h>
=20
@@ -77,8 +78,7 @@
 /* CRU Image Processing Main Control Register */
 #define ICnMC				0x208
 #define ICnMC_CSCTHR			BIT(5)
-#define ICnMC_INF_YUV8_422		(0x1e << 16)
-#define ICnMC_INF_USER			(0x30 << 16)
+#define ICnMC_INF(x)			((x) << 16)
 #define ICnMC_VCSEL(x)			((x) << 22)
 #define ICnMC_INF_MASK			GENMASK(21, 16)
=20
@@ -307,12 +307,12 @@ static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev=
 *cru, bool *input_is_yuv,
=20
 	switch (ip_sd_fmt->code) {
 	case MEDIA_BUS_FMT_UYVY8_1X16:
-		icnmc =3D ICnMC_INF_YUV8_422;
+		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_YUV422_8B);
 		*input_is_yuv =3D true;
 		break;
 	default:
 		*input_is_yuv =3D false;
-		icnmc =3D ICnMC_INF_USER;
+		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_USER_DEFINED(0));
 		break;
 	}
=20
--=20
2.43.0


