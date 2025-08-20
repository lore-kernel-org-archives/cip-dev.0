Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A2CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:23 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.web11.891.1755705922345479249
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=h+EE0GmA;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHe7jB/1LPLJ1lsg0LsZRKPAe8yAm1w4dz5/4ni9C49NLyYYoxGNiLjEGuh24+U7O95qfniqAQrEn39uVhUDnmOHLs9m44WF6OV5Mx21rnojR73n98KkuNpzzYRaMc0kCcoCEoKKddbHat6i9KtuSlI5YhMx2ZdEhEl/mwGLwqtx6I0k+GosvygZ4z9beVGAi0n9zI4p4JSVdWHshf5+d5cJMdbiFy++1yVnKV1g0pcydUqaN2A+7yGCb3ot9xdYRSbtXJbgizEgJG4OrZ2HzWFHi7daoZ5rhxvf4fV/cRvjgJ5bIGrMPXa+Reb+RjlnvmdyykZWvcNgisVQ/WqVLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPYy+5gmWXdvuHvPjMF0lGo5kByzgwGuOrPaZnLOO5Q=;
 b=bVXAm4Pgbs8ozqQON4BD0FPBIA1jGD56rPtIA0jKr1CxoDJoAgc5ZoOsKNkAcngHjLbpZjbCWVei/aSPAoEXosqAbGsUoktHpgkDSxXuXVPFaRGkk3xkadWJCLGrvtF1hNDYNeWdZd5B/I694zt4Nodlb0RHgt0YT+cepLXNT1RKzeKaAHJ0oW+mX9/WPNUOLLUTh2xUj3jN3iZMCi0xV0dDv+r9CUpMnR5obQI+0/OwzrK0r7dMwJucuKuZ9JklQJv6MGeojJP1JvdPa88rz92E+aAJf145yE4Jt1+4gcvxGxVugVxUwKM4LnNKf19yd9Inm3rPMjraYh96uPAbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPYy+5gmWXdvuHvPjMF0lGo5kByzgwGuOrPaZnLOO5Q=;
 b=h+EE0GmAGeMHE1nH/umr/Ys2bDlEpcN5COgggkDJdf/V9C+wl4Sd8n0+Tz6aJTRCwcg6TnnC0/7WRlPmGtVH8WCEQuINXXZqvhdwQKFfedPsPuNlYLmOqZPD5628aN7zZnjP2YO4NUi9ONGV04/ppeA1hjk/IF+nSeaUfPTiEfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:19 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/55] media: rzg2l-cru: Use MIPI CSI-2 data types for ICnMC_INF definitions
Date: Wed, 20 Aug 2025 18:03:29 +0200
Message-ID: <20250820160413.801341-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc237d02-01fb-4972-879a-08dde00358ac
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/CUO1t68rFtpON/wMzUBPeOyhwrwjHWbRYQQccFKBbWf8GUyFBZUNlBRS8ut?=
 =?us-ascii?Q?rCMK9ouVug3rXoZqK3dqDFyc3AtDPWNRMSLvPgZeQ1i1p8ZvAJ7ZrwcTcxP9?=
 =?us-ascii?Q?c+IZs1Dq9GjTGB5lvavO4Ij4HTqszct6AkhbZNv/U7nTRNl89lHp8EL11bxs?=
 =?us-ascii?Q?pUWyCw3g3F+hhsoI42MJcpYyixrppY4zIzDUWYFlw2fsdugthSBDyR+xSRHQ?=
 =?us-ascii?Q?MllAou6RrNv0ArfrXxxU+vVFWnjAOzl/x2dJTrUwLLxqqXJ0SaxhmcxMNYhv?=
 =?us-ascii?Q?kQnScz9yp6orYdoM69Cy6hVIxD54rFp9GR+OQvV4fXkSBTj4QmvIuEX6G4d7?=
 =?us-ascii?Q?FybBkFju45K/9IrBTKdR13jQ+9gKY9gbJ/XpuNSNszbEJEQpEy3EHdDnvn/H?=
 =?us-ascii?Q?GfcneYRPf9FmZTb53/8i0a/kPk5qyl7iYnzSlgv/kcKrbgKj3fg17vvKVnI7?=
 =?us-ascii?Q?cpL0rKrT3PwZ0HsJqrMSDSOp2i41TNr+Sb7LLG4xwGD0xHn6KRLoeQxwQI9R?=
 =?us-ascii?Q?uDRg0dUGQin9lqe3Jou3qGZnlrsrqC5fg9h25GQp3/VffqgPdqADL3H+DwJt?=
 =?us-ascii?Q?hqkcnFadp+9jwq9rQA+6gnqUJIHET9NV9ZqHsuKe82IDP3CdEluwgg4UbLHH?=
 =?us-ascii?Q?72/vhRSv/WQKKrzxSBkQpTXq9i9s21aUvwS1VrhlVPLmfFiB9nhqQxpLArn3?=
 =?us-ascii?Q?AzqULOfaB2pgJcvw7pv/LLC7gYHquZSst29LddEeqkiOmWC63V9RxiKcuf+B?=
 =?us-ascii?Q?qwVNXh3eGgQZ5NYytCQiQamNRwerbqT5l1urqVGkBpNUZr7cxvyYbmASBcFA?=
 =?us-ascii?Q?e7nB1pbk3pADqtjwBtGophCmjukVCXmNCC62pH4baO1FdhyOlG/OQBMyZtJl?=
 =?us-ascii?Q?OmOaI2e8WhvizxARjF2zsqS+m3EOJQuwHE0tW1hHtIgc1vCnLzqtUpmOFHW9?=
 =?us-ascii?Q?5KEwlgP1KawA4k3bAHNbSVgGTgXS+UWywGpSKFnLxbp2xQYtginZC55bZ6M8?=
 =?us-ascii?Q?9JJ4xCnOccjoyFBu3mytlFpTelEkwLfl3oL45tJZUVsy8YLotOvM3YBO9nYf?=
 =?us-ascii?Q?I+FpqadZd4RxM6DSgBmP2f4AnCvXeYqhfTTQaQYJHa1ErqeJqpuDpFkMaVbH?=
 =?us-ascii?Q?/Jdx68n1ff12pOTX09bXGEy9RV3j9fj5incVFKnRi6eRzPwV2SUuoQEGvumy?=
 =?us-ascii?Q?oXhLQqAwqxRBO5FmaCRx+2SuyafSjcBc+Z//ndvTHz2iK5jaMeRhlRnBA7Gi?=
 =?us-ascii?Q?QUmF9zcKbQVIWfxlvKMkCr3QXANHHQseV+hWQEHALsd1I1q4iqL6fNIfnJZl?=
 =?us-ascii?Q?xY0xZZOo8Cvd0L90yzLPbx0iSoq7joPq33XWUqys9UAQm/V513EOd/zkxHyE?=
 =?us-ascii?Q?YBmki1c9K+lRc9KKnws/OgGQDe72AJXAM79EgqrlhMGSocqZMt9mEBRNHYmK?=
 =?us-ascii?Q?Ll89MXgaFoEc/dG8gcdwrY+45+JcroYQDkt5ntqk0fgB8qjbMFRw7/7fxjNg?=
 =?us-ascii?Q?TuB+tVu6KaYNETA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?97TXowmLhOOCmvX10EImAP18Vn7epdqFFCuqa1EjgeA4mK5aE+qg2psHdqPw?=
 =?us-ascii?Q?u74GWqSTUY6EZyNVdSpDIhjpC+ykRZPEo/2fqgeU91tEY/75BudOk5XJHZs3?=
 =?us-ascii?Q?9E4Y7xorXtGA7laZS74CCrhY2l/ECkxV85akXhjD3soernFj5AltyWT19Fip?=
 =?us-ascii?Q?MPzrArP6MvH7Kt6ZvtTO7Iqgclm4Zce3wQKp0dIlh6un4SsYk/O9L1CAjJol?=
 =?us-ascii?Q?3ws1BTRVOfnLOhNOqPbU+I+iweOT0+t8+Lo8M9o/sqbS515yVjmNZ0hrbvyR?=
 =?us-ascii?Q?v1ZeKVkynRcGzegeb0t44qIP62vWGrctkI/LyGUoemufr988kv7DHdPV/7Ft?=
 =?us-ascii?Q?rhF+gwrTWyKGotAzM9BYr8M2HX5s/Fs7laLthS2jX1r5oI20TzzDKffgZSYB?=
 =?us-ascii?Q?go/bwCsXl+tyy+sqlFhUUNXoWFQVxKiAs3CFAKKqCzbo6fD7dkl7Iqsuf3bH?=
 =?us-ascii?Q?1Tq4rgldZ+ugtfzCJtLXsuoGM6KVs9RpxFvUOhAWfecBJ3UQrNrHNvfDQsTV?=
 =?us-ascii?Q?Il0FvtzuLpNGdZWjTGugd89BWTcJS/v123a2uZYrmeRtLH5RMLloLhS1Cxnv?=
 =?us-ascii?Q?c0oVOzZ8K5u+w+FNCvhy5Sf3M+OrlipdsT7pkBVQWxRjFs4yXMNu+ZF1gLV4?=
 =?us-ascii?Q?U0L9K1KSawj2dpXawd+vOCg2bol7Y0+PbLr2AiZnu91Y1RAL+Vr6BOVOzF24?=
 =?us-ascii?Q?HI3PwgkxkirskXVuFoBniWZa1N+ToMt2HzU3pyQuSkNQN76X9BEciJenJK+Y?=
 =?us-ascii?Q?9RpkF3Ggtfl8oaqoxeueDXvj/SNjUYuUGX65ImQNpLTTqTi02gTl11NULSck?=
 =?us-ascii?Q?nR4vOnIcsY8eR+mQ9l7HkH9Ubb1psUnQsW7t7n2SmAlzM0qvqVEaGAt6fJ8/?=
 =?us-ascii?Q?eosxnJ95B7j+ZlBMpLfG+FcmXV+DoKpNNTvKAgncQaxTbc/iNRg0Zfei1Sh0?=
 =?us-ascii?Q?a4e9qbotsWujIAVeWbNgWMHfuMwVbVAXNVyDGu+TLHrdTPq2F/dPn3AMtiqF?=
 =?us-ascii?Q?Q82+oqctj0dfZ/DVA5s73DJGK+UhOjiNsvCHfCKpy9BSQgSW4ifry1HJkkwJ?=
 =?us-ascii?Q?NYove88oTtVMk2xCdPlhehboGNrVgQgTF6i1+5xxWsrXbUoFc49S3UE1Mtau?=
 =?us-ascii?Q?v64M1ziZTW2sDRyQ5alx+4QvZGM7CwP+2AihAWNNI5kQ6riP+LGWoW/HeCmk?=
 =?us-ascii?Q?ugaq+xY4iy+mU99Q+tY/hTpneRU1zGw5NjUZqXjAQCeP6sGfjoIKkNojZKoa?=
 =?us-ascii?Q?wrML42vt9Jlf/3qPRr3U/0un37YBfz7q0DJRhwfLtoSMZ9pYrWYU2AGiRdZy?=
 =?us-ascii?Q?lkzDweAhqhhPeB3mdRjybzqNqdyY49mvi6Bd+pPbiwEdZshqyC9R3sNaFiAo?=
 =?us-ascii?Q?AB50XyfbTSF47RQQvsB1VQiOT/lRJLhFAldAHuQb6rRbNKKlDLR0/M7PztMy?=
 =?us-ascii?Q?F2DDYoIt6v6v+KO928G9irR0rV+M3fsXSGVe5kziJ+JpvLdtqrkLLWR0AZWN?=
 =?us-ascii?Q?szlM9AOvayuMyrn7EWIlX40Lrq3HHFGC2Fd4dJCHYOs7T1RiBVh7qGkQPIlR?=
 =?us-ascii?Q?4y9fOGVyAZGSVs98Fl18WSTIwpJS0vpM/KTu6IvvRxvQVS6VDcYECqrX2/5R?=
 =?us-ascii?Q?QOXyBxE4Q9iRqyhB9UuRRcY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc237d02-01fb-4972-879a-08dde00358ac
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:13.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aYAuUVBW2M4z9BE5hsKmb5thXDWP3gGVza0yYxfnHErSOefJXbBhogiajjIG0uHWwR4SAyWSBTTEbeudWuH+cvfZ0xdOIhyI+tU93VUgLtpqSjHiElQoncbI3cN+FQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19838

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
index 9e8a14949a57..37a81dcebb32 100644
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


