Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABBC77B7C
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:42 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.29])
 by mx.groups.io with SMTP id smtpd.web10.375.1750690053261599722
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=exLxgeX5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOzs6yx0NJOjAG1xa6pQUA2aMUi9Er5e3kzUXmLCKieB7nVaBRP0boFI2Crc7JWUL7g88bnOKnIs+Z0mQ5CnbVz6Hhf+kc5m91QG0iEfZLnj/4oPh+4/PVYKvkHmBu5GACRre2aRtD19QnpNzL5nldl9dAtm1fFdQDgKC0XW3xCU47li2TzSupriAqH5yIhJdAI7AkA9cEQz2CJin67LvnMbxQeCbp6yGOq4tvMf9jw24XH8hZNhjPaFkmZAHt6dXGcEl9o/xBT0ODeXrmZhPxcXMuvy/89VbFGidYHMZM1WIs0JLLRibgwZaI0o9z24Xv8gqppGJCHMPZ0Q5AYTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3JiQ7dvbP961BizhywdGJA65oHt5emwWP2NLG7guFk=;
 b=gLSBKz1z71R1eaK36fH8tfxLa9exJto9fVdAzvUwnorIqHG48J9rX9ir6Jsw0iH4q5n/H6Kj/Z9Sq6uI0scEsbXMEH6o4puZ/PO96ZY1pajZwvGFuQaXiiT7pdRohHlFlMK7GgzujUjVIp3DMRqf1g/yhj8fMYQGvUNfwRg/GAxABMdeqp8cCOiliaeMEJ5zaIBq9LkkK3bnalyb+Z12Qsc3KKKhigyytVzm7pN6rywGKKkP/Bj689qNei59WFTqXRwm1y7RPnBN8XXJhM6BqA0FtgoXHLTi0vbYxlcYJOsENTnuHfUczzqw1cucBHVmBp5pJPnGlHtJc6NJ7VPQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3JiQ7dvbP961BizhywdGJA65oHt5emwWP2NLG7guFk=;
 b=exLxgeX5sZggAuVYiPj1D5AJmmpLXffykneXt8HDkdAPwg9UJ9pbbx74vWPIHmaW2t+FtsF+Eifw1z2208+Py3vFG+QiAzcoh/op4fowOibU0bes50nzCTcsqaT25MopNcc5wbcQg7dd24wITI4t2H+RhsLtKQyin1RkNkSbPvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:31 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/17] mmc: renesas_sdhi: use plain numbers for end_flags
Date: Mon, 23 Jun 2025 16:46:31 +0200
Message-ID: <20250623144639.2119707-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 244abb1a-628e-4ac9-5d36-08ddb264e1c8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GLDdjNhSNsoZcgD78g1ye3PMztKvcdg+fn87HKwOUCfHkaxsMKjUiIU4raDV?=
 =?us-ascii?Q?Y68d7dnQjxS0UoXdsVy/dS7UJU0drAmpLkXxlhtxF5bDsOedrcczkbgGpn0c?=
 =?us-ascii?Q?RrEsMTcWvdC3giCxss9F1QFYBdIVztM1GnKRyc1kJe9EL0d+IgYSdXGMGy+U?=
 =?us-ascii?Q?n6qxtoAhrWiDqyDPKhIrsX3FACEvdWcawidK4rYXjkBE2UdGF8/xsXdijYxV?=
 =?us-ascii?Q?ysomsTnFmOt4CWSJnQs/M1IM5diC0Y/DkodNSjPCw8woAEQ0BbDL6Fq+MNTl?=
 =?us-ascii?Q?XSAFxmpmhzFkxqywnbNX85hXBU5WSe+mStq8xneNUPJKslvc24Rzv5DcCRPN?=
 =?us-ascii?Q?Sf8doe2pPTl6ROhpaOTqe51cV5dAEdU9tx7hLnF9W9COSQdDRai3VCFWLCVP?=
 =?us-ascii?Q?rLVkHOlzMlUQ0hSVNm0XRGjn8d653NxpPiVwwBESmQ18whbbEtU9AjLcFsuT?=
 =?us-ascii?Q?aGhBMlCvT4QXlxJTNd/noQhuR4mVwkU+9TZcJszgYR2k1AMdnhl/nvkn93bP?=
 =?us-ascii?Q?QAlTqWmLC561yt6jYzHhxCMEhZAAj7IK+n934DOeiuuxgZ6Y7jF8OcRaxnmR?=
 =?us-ascii?Q?jIuz4O2CWrZJlBRqxYEYbdG7h+X/KQFwOlaV+eyMB84dED/35AFAdCsVSyy4?=
 =?us-ascii?Q?5x2lpIqcM9Vb47EwamU3+rsc5KdOTvEdLbp+OYx+6nR8/TFG6iMvCFcd3RSx?=
 =?us-ascii?Q?4WrpIdSNjhbukGz3AtaRXYAhX2J2uMl4+rOCHN9lQOIWw6pE8NDY+oZpUCOt?=
 =?us-ascii?Q?JEHkoD2FxzcKbFxGiE5pFncAoOeTSJaWny1EiHQR9JGiCN7QRPbN5Fo/e1Mw?=
 =?us-ascii?Q?vhGLIfNtMM2/Im8MuaUDQmXHLe0UpmWTVqk5JJ6jOzLCXeLm1cKPQkVRqe0o?=
 =?us-ascii?Q?+pH/0aEJq8srF9MIxEcHcbCd8s1T3b8M5uMnEEDAoKZLAPKyUAJ9ufQ81HdD?=
 =?us-ascii?Q?bwpxf0UCYWeVzdkm42iknmqMFC97HSGMnDCGgQlBDYQIogYZW/ljt8rNIova?=
 =?us-ascii?Q?0V9aykbzZEwAYc8bWxyjwm5909xgOcUDzOyxu1minXnQazb2ClbVq8bShdiu?=
 =?us-ascii?Q?3zfdcb4awLegGmLUhUUqhSceGxuoDAfK7e3qJxVsGAAOvMmZJHNzhKHcyz2F?=
 =?us-ascii?Q?T6zL4foRl7+uoMzHWjLwHz9Lg6QFZBfmobkbYCRdsaBkBXIpOELcwdDI7Yoc?=
 =?us-ascii?Q?K23SK5sYiA5aQONJ1mDIoExNocwjBjVevsFcP3hsHrLOK8/gyZ3gQiIRNx/+?=
 =?us-ascii?Q?qIGxeUhY+KKFmQQsJ2+Fzt50TK0XjdnmbfDbTV05Lay0IwhhaxMbiLUQOYo9?=
 =?us-ascii?Q?WM9a15iJKa/w4xbYGh+LofmLxDbQvVVQ88WFQ994pfh6dGqzyNKZtZmlPpVO?=
 =?us-ascii?Q?Z5jhdPqNUBASIat7enksuit6bIoH/5ZBLO1EE5oL4U1BlycfViPHh79yOj+u?=
 =?us-ascii?Q?n0K7TjYEOKHbLHy3Zl04GkSDdO5DfEj9U28I193YTXfbZEiGY8PrgRQDYD5/?=
 =?us-ascii?Q?oV1SflNKoVkD9C0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GbGfNqE+S9ltT31jj+8+5rM5a5448P7wBEVUA1blYwE2KPl15RS743LyMhay?=
 =?us-ascii?Q?G0Rkl5976Dah5GMJkPdzvvu20V1t5d73NHXXD3oHepgijudl42lVkRpg5Gei?=
 =?us-ascii?Q?INOw0XmahfRdJdOjZ+f1YvI2O2zZ2wdoR64saio7kEzDiEQyHPIWn9sSmW3X?=
 =?us-ascii?Q?Uzd//ffO1+lykwgHybS56FisoPgyKBKRbHm2+ECAeF2lAvNKOybe/dqCXg1K?=
 =?us-ascii?Q?eFWbmZLfNKT6SBJLeORvJ4oD09CMNw03rdWM4wZyi/E89LhvnylVtHWaGVjs?=
 =?us-ascii?Q?ruI60196sYsRTRszuOCnse7NexjXK9s/AARAKPDxFrSekh6yPXqTPQS1IqFx?=
 =?us-ascii?Q?kUPaeCGEaAaw1j2gweZus35Idqb8DFkzyFFcY3i+6CXVTF0d05kluVYM3Tcj?=
 =?us-ascii?Q?s/v+MDVjkMm5KWnMC/dSKcxCamPq4aTqhLLYR5YgnuU9ydjZiSLkJsFGY//M?=
 =?us-ascii?Q?5HqbTMi7kyLETJmpi+8A/1xqvPLvHgRDdf5J0OlrpfRTdqgCYxghqEtv5rvk?=
 =?us-ascii?Q?5302IpiIm9o96wCHRRg+mBFWaGfau4u0qxozZmXz3e2NNz4i0CC/Hgf/FwBF?=
 =?us-ascii?Q?Ezlt6KYFkhiOULmpSM6HZsKAdbNpH3v1SgMIxb47IZLwwe2Sh3QnWq9wPGLr?=
 =?us-ascii?Q?rNIJh8TzAsXokE+N/8wqOkm6fHfeYRzG+pC75X4u7Cco0biK/9XcYcM8sy2p?=
 =?us-ascii?Q?IPK7AezRpF4zX93KCnNdYhxdZB++shjiDzoVIWMfYNfYOt4PxElB/jGonjU6?=
 =?us-ascii?Q?BcdCj/spZrwl9VF5tEYaofrfe1l+5mPq+BdIvzrMUgZ9V316l5/gnzlxz7Ax?=
 =?us-ascii?Q?ET9WgnwXnykmSbhcImhogVehtgFiulIBklhpIJkf7iO/rnX45EJ9pw4/WAj3?=
 =?us-ascii?Q?WPhqlsj9MA2Jw0UM6cx99jof2hjp17DC56uuDt/KQMg2ZaQs1YTKzgSVP0ME?=
 =?us-ascii?Q?J0a3TRN9BN7cc2XwjpM89eqRS8rqF5jNODtv6qcaTo02Xdsezb6diPSh0F6b?=
 =?us-ascii?Q?Jx0klaaOBOCWfO8z/tOJQsvoel++SoSzkHoqZFg70VkntLxbY01PJ8XVh6xL?=
 =?us-ascii?Q?q27xlV/bxhkR2zFUWZ8HP2xgVUcAIaKio7d92zUyNqdnVg4ROrCr3UL9rtdE?=
 =?us-ascii?Q?IjwLpekKOPK935vZMityp0UltJ5Z86JsU4i0xmVTbWO3lcv9F73zH1FHzDxX?=
 =?us-ascii?Q?e/BnBSAiPMNXWUXB5HnMKVlrNXZ5tnp5aHwJjZXgi6WqNh6e5lklbIUMIVVw?=
 =?us-ascii?Q?hSQnmC3fg8aiHwj+P62sQ+uXLZN9Io0ZOTAlFlHzP8IvxBE3hYUOb9OCkd6/?=
 =?us-ascii?Q?hwGg8dqmK63LDYOoR9svjyX6rFxLAfP+9PKSxFWhv5HC52iv/P5FnsklWEBD?=
 =?us-ascii?Q?05iOm/DYuQFm0feOFe3JHKW351tdYDYzjl6YLPACwPDexf0rJPHEjGV8sTPo?=
 =?us-ascii?Q?Pr6BXTzUmk4DB+2rXxODdSv/IaJPZ9FURj5+mzI90L1SXvl35izfJxj62rSy?=
 =?us-ascii?Q?koRsIf8wI+NkZoxoBzklJc879IF9cHJVbxUnRQvt7i/3v6YWWvKeZYHH/V2G?=
 =?us-ascii?Q?uPF5XH4V4chM4TLE+QOX9e8calMC14OO4uqXXmbXbuCkC0aWFrAzyUMIJwmt?=
 =?us-ascii?Q?E2daiNV4A7G0kz1xXouXvdI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244abb1a-628e-4ac9-5d36-08ddb264e1c8
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:31.4406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zHVeH+itfMtAmrRtDBBpS48DrmjH3acDVt7pGke/Zhb5SlGbl2g0D2e9cEVnq+fblpc/ha4maZbKIsObNuelHdoWGDE7NQ7DaRI6H1gJaaLw0AljnLgrVHw/cPZns5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19196

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ffbace4378dc1aedb02248bbbe5d231754e4df3a upstream.

Linux *_bit accessors take plain bit numbers, no need for BIT().

Fixes: c330601c9c93 ("mmc: renesas_sdhi: take DMA end interrupts into accou=
nt")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20221122080554.4468-1-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index ea2a85174a09..68da3da9e2e5 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -57,8 +57,8 @@ struct renesas_sdhi_of_data_with_quirks {
 };
=20
 /* We want both end_flags to be set before we mark DMA as finished */
-#define SDHI_DMA_END_FLAG_DMA		BIT(0)
-#define SDHI_DMA_END_FLAG_ACCESS	BIT(1)
+#define SDHI_DMA_END_FLAG_DMA		0
+#define SDHI_DMA_END_FLAG_ACCESS	1
=20
 struct renesas_sdhi_dma {
 	unsigned long end_flags;
--=20
2.43.0


