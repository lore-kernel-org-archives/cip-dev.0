Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E22CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.16])
 by mx.groups.io with SMTP id smtpd.web10.1096.1755706173181330404
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TL49qMJ5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.16, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEhFVkx5iOzvej0smjextRTZqcpoJ9bVOobOeg0jQMuvpjjF8XoauoGgvbgHALii12lFHTigAbS6aWFIRsQeCb3hoDtGvV6LT8UyHiMxB98FlV2PTPOODJH/GCbLM1tjx4GBEKJb2HNNU+lsCjByuzlfqUEzLgFIYPmxpoHVvKMnIHTHeYawZHEab/TSjitLpi+WnduukEnTLiGsevynyGJ1/3NspUyfs6KweFqyVIJacNKwQH9ESpct3vxp1DALtZp7ecZH2ne1ayGDhi+Z88dne7qHOOaNyQzH7gCqa8rbLJnbBSyfbPx1/L/7UpRX01zLBA866zzwjnSKqcxe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK0qYpSCY2s4vs4a3rt58ebJKnW4nwByoa+zjd+Tuoc=;
 b=pkX7Ccguq/zveY7jdoXHoIeV2x2K6hWjsnuMOqbHEj03of2D+z1SaiEvwWXo33DUTNrmUuH5zPf5S5j4j9zkXerBEEUWgTqKq1T46pADhVe0e6EPdyjdB0E9Yfy/2vFvR2lIlDO08oTT50OCcNiaLomiJ6HP6GmJ17+mvzXOriA1b4QoUVm2pI8k/4bGfwdnqhwpAsLL+g4b+HV1hnRc/2U1p3LEhqmBl40bllEdkIUidon4Meo8oWc9MGaE5LPRs48ygNHGQLcJk+66nt9sxxuublrXw55XCCLVRjvhHJkVQ2vxvPIiUIhYzAEFh/CMXdUXcm2k4YqcYx+dmPKh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK0qYpSCY2s4vs4a3rt58ebJKnW4nwByoa+zjd+Tuoc=;
 b=TL49qMJ5kxnzeOddYpX9FgHuDz9dh+BYC6ytHrlqRlsrZu/8tHQFfGLvax4bEisjStSGlSsLhg2vUZGRNmuhGLhkEN/neqyoMeWRPXQ/KodIxI7CAIXR5/g5fSBAYBR0ey2jArcdaSU4110wRpSpeNboYmkLnGO9r0/uXQBBqZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 27/55] media: rzg2l-cru: Move register definitions to a separate file
Date: Wed, 20 Aug 2025 18:07:28 +0200
Message-ID: <20250820160758.801813-28-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 919f6cdf-b80b-4fa3-842d-08dde003f232
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tzYQHgxb4oxthL0pJ2CylVB6J/SBgML4DxD8oI6t6FtWWhyhijCI7UMhlPtr?=
 =?us-ascii?Q?vLFl0mGWqZYeZGvuz1xKT9GglSaz4TwVImHsi0l/ynX4a2PIwUrNMLLCmfyz?=
 =?us-ascii?Q?VdC1xSbnD1MMwU4c80sa8Qm/KfyVyvTAvZ9V2YZCqoIBvQXHAlpgWzzhg28o?=
 =?us-ascii?Q?YkYMWZI427csC/P1LBHY/h/gugdokZEMrB3LH9q4UIwTovtqmE8p/89nJWDD?=
 =?us-ascii?Q?4v4Dr5jBuWdINB/gq8THwriygBamDSKdqyt0bwnIydCXOOgeKnikFofRmofj?=
 =?us-ascii?Q?hMgALmwYpkcY0K8QzfsYjO47g9LTQzlZ2uxfbNJ0+lU4iSmOgjDkjWPhRmSz?=
 =?us-ascii?Q?MT15Zrm7KT27FrSLuMqThY84l9Xd/8FyZTP7i680pk3T55+7v5Kw96nwbrj2?=
 =?us-ascii?Q?bVVY8DM9tdbzC2XfY7S+EWRJkQdTxeFXE7A4iZDW8+wqimIsIItDGFY0fDJW?=
 =?us-ascii?Q?4wn/x+j2nKTHiZgWLFy03hMMhwX9pubg+iuyyUmhjtVY+pJTx7blP7NQz8uM?=
 =?us-ascii?Q?mFuMW4bO5hviusbFtZPilF2kO2H15UKjRBUkMgsnt5ZK/JvpN++p0Ab4HZ4u?=
 =?us-ascii?Q?l/QZX1x+tetIzuouB0bzk+AtDZjuijmu9YQFictHP5/YNsb67r0V4uJzT1Ne?=
 =?us-ascii?Q?4Mt3FsFIPESbTXMFHrgaQrypjTD03x54n6bUrrui5EZsw2APrXraAzdZkZ3F?=
 =?us-ascii?Q?EoayPy75ITdmUZHMtGOvcNV0Xep7dzgPVqrZ4tlcJ96gxXgF/BMEAExSdrDS?=
 =?us-ascii?Q?jrpfbNlgD9UCxHJPXHM4sQUWY/nignXZqMKl415BD7sL7dWc5DjEE9eqG3Ar?=
 =?us-ascii?Q?0nNGOmZAZgcTEIgPTvJ/RB0fHU/I0Uvf8Ilks4LDxB8Budcs4cv2iWSbRm5W?=
 =?us-ascii?Q?kS/n2txDjlZeqeQpFqg2zlHQs4BpUQ35UyuUHg08aQsUO1GekT6Ykf8UNnhi?=
 =?us-ascii?Q?+MmO2HslMO/MHsTYi70jOoNiJ8dRSxBm8mJdAz+8qttRF5ACwq9OnkGmKGeK?=
 =?us-ascii?Q?Z5BypVYfEJq9TlSeIPbx+V4rigFMN5tsSHVgklZI0ylvv7rG6UKYWL0VyxB2?=
 =?us-ascii?Q?O1+0RBZS494G7cp36gaN2VZIxEvjwJcTtLFclZ4g9FpLy/jOmzGa33DKfkfk?=
 =?us-ascii?Q?Jq01Tb8l1MJcITyGYztyMpOBwqtvEQ6ogDlbbiK8Jy6IWzYf3mBkyXR7E19Q?=
 =?us-ascii?Q?2yTTEP4jufySQSuUjSQQSmrTazf14EnjFIDaymcroXfeB3puR0L9dGLkUXNc?=
 =?us-ascii?Q?/Ho2MtjpQCdxnwhIxxWI+5D+cdFXeK1co+dgoCu6wOU1wGwNWIOvkLGQlYXf?=
 =?us-ascii?Q?ryFnMd/t65FiQ9ru+5W7xbq3h+gUFz2jk9mhuWJglG/1WPf72uIeG7cBBrvC?=
 =?us-ascii?Q?8uKW5Py8l+obGrnQoYtc6H9QND2avaNtGhfzLJqwK4lWy7b2NkviqPE9UgSv?=
 =?us-ascii?Q?ACmczpbY/aSp/uyqGOc99QYVLs6S1Tvo5eGOiTTMeya5CcYsF8CX+DHcR7U6?=
 =?us-ascii?Q?UUk62zhNaG9kjL0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UidJO3B9H/4BiL6Cm3PxaGRzuN/Wcjb4cjwawojAEUoYyaHMnX/sBK9YM54Y?=
 =?us-ascii?Q?WI1sKmk5Bv/zkfcVn2xVFvFpaWKwkK25xf29CFmaxC2G0irHrjY8c9WZkZcL?=
 =?us-ascii?Q?LYGUVlfX6Byu5bn6ygqu54AId/fIiZvk9EP1vbOJT0JgJ3whLRZWQnfvdKmq?=
 =?us-ascii?Q?CNHeYIkGWYCsUZ9/Dk29PrLUJbnXej5Zf63GXYX1s1aSRopgckT/WTENC/jf?=
 =?us-ascii?Q?cSXW2+wmHxxRn4thDi6+fkUOgfh+RLxIaqPzWB47Yach4FtIEtlQlnuk/vim?=
 =?us-ascii?Q?rq4a9tJrOJUfeDq5dBGbW4t7zAgeD03OHS1+DOrfar4vKHyawVmPVWg00X1z?=
 =?us-ascii?Q?RRq+0YBfqyvAH9h4BftjwsJzqtRJkTmOk/g+mJMn8z+AXFI3id7OXGqervc3?=
 =?us-ascii?Q?roHOCIsi1aAGNMyPp7gYep8RGaMQ8VgFaGJq5KdPB/X00y4jyCYh89nbAbd6?=
 =?us-ascii?Q?7YhNfgHu3xeJf7FiEjIiSzXvzj44VTDl5sB50BX8l4q8m6iyVxtjKn+3CMHb?=
 =?us-ascii?Q?14Bz++Sbgx0IfJYnVwyDUKPKjgUaQKeDaql6bnQ6j+bfZRAjK5B5VdyFhUh2?=
 =?us-ascii?Q?uTi8Uck9SLCqn4+Ph49R4U3cENPpNOthyUUmq5HRdruvZL0bIsY0MDIVCcLf?=
 =?us-ascii?Q?JMpbzqv4ej1WCyxv6cKo1xBjqHi21z6H1q9JW3UIpiqxWgtSdwJq0dmM2r4l?=
 =?us-ascii?Q?/MZgxJ2bGCuC4Vcy5S0tvEqTj0mfLShpoiJMlOoHA2sgjOQ+Bd+crko3wznF?=
 =?us-ascii?Q?L4ss3QGBW0ILn16yC53P6q0zKNkOsy0r50bSV9N8PFwAdLaCK4NdsucXOCED?=
 =?us-ascii?Q?n20u9YYll1/NwSiLZd6yECPJPcspA6Uuk3GpNdcGz4TLSY39TLcscJQ9TzFH?=
 =?us-ascii?Q?gD1vWj7QTnonI8hHNK1xc4Z3wSxy2ZykYOYby72a2270nNz3rPS7Aep87+xz?=
 =?us-ascii?Q?VSToJxRffL2D12SdbSXcKDw4OsD3Xpezy/3oRwmvZkVD5urbAoiDZ5eIp8F9?=
 =?us-ascii?Q?ji9lMu/C/GhhJB8TRir03vQmGdS6M4xIf8W+QdYSrz50f0qfb9qDtprfd6iZ?=
 =?us-ascii?Q?eDF3+b40MPh+ooWKcOkdU25PE0fUJ/cAIXm8hnhXh6gm0KCobzeIt9fiWbkv?=
 =?us-ascii?Q?KXuwj7cVZkQtRqU/jfgDLi6cVffu+SUAlw+9SzNRMlGj0iSUUl9KiyliaW15?=
 =?us-ascii?Q?+duhPhAabLcw8T6C8iF+EKkJVxqBuKL+FXvFTfbeHI5jzZZLFlZtPfm4CQcA?=
 =?us-ascii?Q?JcrE4ZyfFo/IOr63AOC6sWURVD8SvSzLXsT8i5ecq9O9wcCB7/+Yu6d5ZVrK?=
 =?us-ascii?Q?PsZAbmfaSzEiJ7CrS6XUloN121IzHaj2nN0U0CovaIXwTWaVEM+blYrctNV9?=
 =?us-ascii?Q?zjXUwSSQqSt7W1pDG1rmYTnC7ZmIRJK8N+nRHmxxIeXHFvVcoyljpgdWMCds?=
 =?us-ascii?Q?1BEjNlJ4lmvRpP6Gxbz66hwAabrqNkSggw3/Me+7pAoO+bvsFGudaCYoJFVv?=
 =?us-ascii?Q?/brgESRUPmsPopp5jivWhliW8/pDzoPYtobKWKbSLrIu+OcN8iyxDCOWbzRf?=
 =?us-ascii?Q?Jm7eu4qZuk/KtAN1ZYmHksyMnscSRqw/FlSmvVRTe0dBni/YtFOlX2+d2Y1K?=
 =?us-ascii?Q?SGpY2CQmkvMyzh0/3uVU1qk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919f6cdf-b80b-4fa3-842d-08dde003f232
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:31.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKUaldRq/dPpovbxQnBFsf4a2QnmUYMDCsDIOVMNG7V3qegnmo1XT2QYVW51VztdNAvgZr2TSfIbBGd0Slifq3LBcWLTCXCkOSF5YDOEHUalrk9sR/9hCDOoJhB05NCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19908

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c0fc8dd01ffc37f3ce4132b7b2b579fbf64aaca7 upstream.

Move the RZ/G2L CRU register definitions from `rzg2l-video.c` to a
dedicated header file, `rzg2l-cru-regs.h`. Separating these definitions
into their own file improves the readability of the code.

Suggested-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-23-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 80 +++++++++++++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  2 -
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  1 +
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 69 +---------------
 4 files changed, 82 insertions(+), 70 deletions(-)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs=
.h

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h b/dr=
ivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
new file mode 100644
index 000000000000..1c9f22118a5d
--- /dev/null
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * rzg2l-cru-regs.h--RZ/G2L (and alike SoCs) CRU Registers Definitions
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RZG2L_CRU_REGS_H__
+#define __RZG2L_CRU_REGS_H__
+
+/* HW CRU Registers Definition */
+
+/* CRU Control Register */
+#define CRUnCTRL			0x0
+#define CRUnCTRL_VINSEL(x)		((x) << 0)
+
+/* CRU Interrupt Enable Register */
+#define CRUnIE				0x4
+#define CRUnIE_EFE			BIT(17)
+
+/* CRU Interrupt Status Register */
+#define CRUnINTS			0x8
+#define CRUnINTS_SFS			BIT(16)
+
+/* CRU Reset Register */
+#define CRUnRST				0xc
+#define CRUnRST_VRESETN			BIT(0)
+
+/* Memory Bank Base Address (Lower) Register for CRU Image Data */
+#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
+
+/* Memory Bank Base Address (Higher) Register for CRU Image Data */
+#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
+
+/* Memory Bank Enable Register for CRU Image Data */
+#define AMnMBVALID			0x148
+#define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
+
+/* Memory Bank Status Register for CRU Image Data */
+#define AMnMBS				0x14c
+#define AMnMBS_MBSTS			0x7
+
+/* AXI Master Transfer Setting Register for CRU Image Data */
+#define AMnAXIATTR			0x158
+#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
+#define AMnAXIATTR_AXILEN		(0xf)
+
+/* AXI Master FIFO Pointer Register for CRU Image Data */
+#define AMnFIFOPNTR			0x168
+#define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
+#define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
+
+/* AXI Master Transfer Stop Register for CRU Image Data */
+#define AMnAXISTP			0x174
+#define AMnAXISTP_AXI_STOP		BIT(0)
+
+/* AXI Master Transfer Stop Status Register for CRU Image Data */
+#define AMnAXISTPACK			0x178
+#define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
+
+/* CRU Image Processing Enable Register */
+#define ICnEN				0x200
+#define ICnEN_ICEN			BIT(0)
+
+/* CRU Image Processing Main Control Register */
+#define ICnMC				0x208
+#define ICnMC_CSCTHR			BIT(5)
+#define ICnMC_INF(x)			((x) << 16)
+#define ICnMC_VCSEL(x)			((x) << 22)
+#define ICnMC_INF_MASK			GENMASK(21, 16)
+
+/* CRU Module Status Register */
+#define ICnMS				0x254
+#define ICnMS_IA			BIT(2)
+
+/* CRU Data Output Mode Register */
+#define ICnDMR				0x26c
+#define ICnDMR_YCMODE_UYVY		(1 << 4)
+
+#endif /* __RZG2L_CRU_REGS_H__ */
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index c40754732576..a83e78d9b0be 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,8 +31,6 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
-#define ICnDMR_YCMODE_UYVY		(1 << 4)
-
 enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SINK =3D 0,
 	RZG2L_CRU_IP_SOURCE,
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 982c996cc777..d935d981f9d3 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -9,6 +9,7 @@
 #include <media/mipi-csi2.h>
=20
 #include "rzg2l-cru.h"
+#include "rzg2l-cru-regs.h"
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
 	{
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a686a5cd4f59..a4dc3689599c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -20,74 +20,7 @@
 #include <media/videobuf2-dma-contig.h>
=20
 #include "rzg2l-cru.h"
-
-/* HW CRU Registers Definition */
-
-/* CRU Control Register */
-#define CRUnCTRL			0x0
-#define CRUnCTRL_VINSEL(x)		((x) << 0)
-
-/* CRU Interrupt Enable Register */
-#define CRUnIE				0x4
-#define CRUnIE_EFE			BIT(17)
-
-/* CRU Interrupt Status Register */
-#define CRUnINTS			0x8
-#define CRUnINTS_SFS			BIT(16)
-
-/* CRU Reset Register */
-#define CRUnRST				0xc
-#define CRUnRST_VRESETN			BIT(0)
-
-/* Memory Bank Base Address (Lower) Register for CRU Image Data */
-#define AMnMBxADDRL(x)			(0x100 + ((x) * 8))
-
-/* Memory Bank Base Address (Higher) Register for CRU Image Data */
-#define AMnMBxADDRH(x)			(0x104 + ((x) * 8))
-
-/* Memory Bank Enable Register for CRU Image Data */
-#define AMnMBVALID			0x148
-#define AMnMBVALID_MBVALID(x)		GENMASK(x, 0)
-
-/* Memory Bank Status Register for CRU Image Data */
-#define AMnMBS				0x14c
-#define AMnMBS_MBSTS			0x7
-
-/* AXI Master Transfer Setting Register for CRU Image Data */
-#define AMnAXIATTR			0x158
-#define AMnAXIATTR_AXILEN_MASK		GENMASK(3, 0)
-#define AMnAXIATTR_AXILEN		(0xf)
-
-/* AXI Master FIFO Pointer Register for CRU Image Data */
-#define AMnFIFOPNTR			0x168
-#define AMnFIFOPNTR_FIFOWPNTR		GENMASK(7, 0)
-#define AMnFIFOPNTR_FIFORPNTR_Y		GENMASK(23, 16)
-
-/* AXI Master Transfer Stop Register for CRU Image Data */
-#define AMnAXISTP			0x174
-#define AMnAXISTP_AXI_STOP		BIT(0)
-
-/* AXI Master Transfer Stop Status Register for CRU Image Data */
-#define AMnAXISTPACK			0x178
-#define AMnAXISTPACK_AXI_STOP_ACK	BIT(0)
-
-/* CRU Image Processing Enable Register */
-#define ICnEN				0x200
-#define ICnEN_ICEN			BIT(0)
-
-/* CRU Image Processing Main Control Register */
-#define ICnMC				0x208
-#define ICnMC_CSCTHR			BIT(5)
-#define ICnMC_INF(x)			((x) << 16)
-#define ICnMC_VCSEL(x)			((x) << 22)
-#define ICnMC_INF_MASK			GENMASK(21, 16)
-
-/* CRU Module Status Register */
-#define ICnMS				0x254
-#define ICnMS_IA			BIT(2)
-
-/* CRU Data Output Mode Register */
-#define ICnDMR				0x26c
+#include "rzg2l-cru-regs.h"
=20
 #define RZG2L_TIMEOUT_MS		100
 #define RZG2L_RETRIES			10
--=20
2.43.0


