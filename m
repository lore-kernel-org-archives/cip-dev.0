Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2FCCA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:33 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.54])
 by mx.groups.io with SMTP id smtpd.web11.933.1755705987166781426
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IcRAvLyC;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+r2Ke+ooQA7csnqQKE9+a9hvVhSUEK+cm7N/Nk0xQwdBzrZffFucq649Y0Xl8KirZxb8Wx5BgGd7e4AAIh+HC3EogfYjd26tclKuVUQD19V7/FNSB2v2rffmaBd2k1s7E/W0voFK+5ZC186PXbEXZqOaxRD9aeZn01p7p5qeXaR9SBvbD6Onua9x/RpRXewNNg8WyGtXDSkdj+h2qjvkvrQQBJJi0GTCXGF2nGtpVGn6t+aLxu3I/iokR2X7KmOI8Pnbvn/UOrs8ui4NvB9uq95Wa314KULaC3oyCg3xATkyedVNnlImVMwNiUkmGH8qsqxdi1F3bV37GttXr6VDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNzgJUndMTTBZSXHwg+DWbVFYVLdsiWcNWqp5webfCo=;
 b=LOdMpVR4pgZHbv0+vmTyPlIkx7ix1590/XbJNu9uVWx7PCpNyfJdcjipjQ4uzFcfGbl0ef2lk1HSobVCN9qhuJ11rJj13J90Ots+2ZBUZfURNvRd2fVKjafCWWw4624uwmHT786bZTF6apD45jN+kOT+luqYJGFYDQG030yjVB2AsZIjKnINJtOCwFvse/CfRTl8LZabZZ7A4Gp0lR0feGO61xWUhlqFibpGv+AsOux4b2kMz4N2bosbcWiefUzrCqHRXyPbkQPeTOGCXMMmhMvBiQmYcSHCllq+0uLWKSc4gOZpOEwko36OU9ifGONqRmcIhXoXONXXbH0rS9HHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNzgJUndMTTBZSXHwg+DWbVFYVLdsiWcNWqp5webfCo=;
 b=IcRAvLyCQFivCK/mtUpG1kHsuG4+UK5Jm3+NvGd+iXOuDi1mD+EQ4zaxr0J/J0i3gD1Xuntlatxw5IUBqVy9tb0dXBH9wA4v+ZohkeSAesY7hKqhOvCeXG3lzExoX9RRudASpzJmgaxRFuGeQrrUjEV92MNgQOLdIs9XSNOg/sQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:25 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 42/55] media: rzg2l-cru: Add function pointer to configure CSI
Date: Wed, 20 Aug 2025 18:03:58 +0200
Message-ID: <20250820160413.801341-43-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af5e4de-ac6b-42d6-004c-08dde0038353
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?U10QyyYV//KXoY4K/9PxCNT/pdt8Ph5C/LgB35NDIxN3aKCGgpAJRHHo/cA9?=
 =?us-ascii?Q?HyKVghDrVripOEoHe+TIoZ1VXa3hg1QVyeQI5I9u5fnygxJLwTibvH0eFSIh?=
 =?us-ascii?Q?kQNnAHFRJ61OkXSar+v9I76f1vCUkLqzPHK+JvG2DmxqLWkM70DIzy1ll4tE?=
 =?us-ascii?Q?TvERx8ZYYj7oXDI8j3jhuRFgADqPi2iIv7fai2VbxlLj9Mi5z2yM4Mk47ZO4?=
 =?us-ascii?Q?uxDPU3M5AStiW507TrZFstNGNOsiYRiAZaI3Xfp7qto+160zkSoc4nYn6wBV?=
 =?us-ascii?Q?uQ607XsM49z/DJEVPfzAy+e849tGfzUKw8Ut40tGuMxlojeVR2RN9CYqaBNS?=
 =?us-ascii?Q?dI0D/uo0YDWTkLAUckgNS+pB8E19ts+AEjMdeiQY3ijZcxyIU7ueec0DS9JC?=
 =?us-ascii?Q?YElwYEgJ3wHfWEnRZ0wEqTEnSCDg+0PAY4Ki1k2KY/pSD24pTmFRJskWGYI/?=
 =?us-ascii?Q?3HO40BMZCZ5vkbINbwhpn0XgxDzTuUhyDNTQGRRnVIC/hxeQVjcA7SibNbE2?=
 =?us-ascii?Q?RE07WuiHbjN0AwC1aeO/2hqUvixvo5ejcqW+p7tb7WjUczkT43yd/e/wfigm?=
 =?us-ascii?Q?Y0AMBDjUQJ8rp8iV0+VC3rnPZjkPwNEV0XBo5qBEFzu+l7YnrulGp5OGMZb4?=
 =?us-ascii?Q?bPenQ9f0tPYHTxl8fIc/qTY4zEJVnCbYVWpCntHrNWqwsSHe2LKGLHec3DvJ?=
 =?us-ascii?Q?6x3XSmwX6Z+dk73g+F5E5HcC1pFxEQkAfo7b6TfTDznqcLwQA73296aBadqf?=
 =?us-ascii?Q?Z48smsWHTu2c4S1w/XfbEfrqoQ4nDGM0Zr+UzfGgF3atFARGJ9PX8vHYpM+2?=
 =?us-ascii?Q?CWck9UQoWcG1UXJV1RCDJvElOJhz85yX04LpsEWkIu47bRiwhZBdrrPcvb+s?=
 =?us-ascii?Q?5fUX2BY0ZQn8SxbhCwUOQktdwHpH4q9V9x1og7puJLWTWfV8uH+HAhy5W9k1?=
 =?us-ascii?Q?6sNBdbloinb7t7Uh34Pxr3GYZ2epJOVS++4emaHWgVnZp9gbzEYcvThZA4Vm?=
 =?us-ascii?Q?V/BZzJ7+FwKM79h5PaVHVtPNW+x72x4dVPxnzE43qrQHnVMgCF7AwCCJSEVw?=
 =?us-ascii?Q?+7vomUcIXhIY03eG2DsFmBVgAL1d6bmUQB31jrMWW/X3Z+ocKNXy7rNMKTVU?=
 =?us-ascii?Q?mAfvvi25tIzkul01Z/P5cZrux6sNM3EcXJsU8WmxACj2p9tTRlQrJvruBpjg?=
 =?us-ascii?Q?phkuJ6PHzw+Ee4mSjMWg0jnJZg9F4W1sE+nXPn21FV07dGXH15AdxFy/tVKQ?=
 =?us-ascii?Q?cHDTBMIWMnhTnWvX6mInpOvphU2mIVMeCtwJdbEgt86z5QPyngNEl7MzahmJ?=
 =?us-ascii?Q?azB8j7w2fu0rb+0pZUoLEAXEhTxe/al3Xq55ehwO9q7E3S7j7UdSJ8iBHR3y?=
 =?us-ascii?Q?t5TKEd/+bIPs0v/pTbb0GOFHTryy1FQdIpzpLd8auc9eDRchMRY739QrQfby?=
 =?us-ascii?Q?D/cRpszEg14ZdlpjE+eMf9O3/Ca7DOZ2JcLVnPKNsWg/a6Id3mvD+aFvHJ8a?=
 =?us-ascii?Q?TwgwZrQi80z2DJI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RecJA5dHSja/Bo0fqzb+tgjrV62yOWC60kZLo2riRKtn9cvm/9EO0RVwEGRX?=
 =?us-ascii?Q?NItT+MPhZz8GE5ePGQpJXs66omCpV0NRqitpxc5IRakGYLwE9fj3pYkmziaS?=
 =?us-ascii?Q?Y/wbeHq18KRQoitKHDszHXLD+TsrM3qcJHV1984hEjMQ9j9tnI5nqyDBC5Ro?=
 =?us-ascii?Q?59w873SmBeV8RlKQ+ZMKutkg2MmoQnMj1d/ci6JubIU/GmB76N9+qph1iE5I?=
 =?us-ascii?Q?vWSKaCFx9j1cOKuQSq2dtwxnwjagSx/U2QqsI8Vid+FvswBMD/XvKsFQuRk/?=
 =?us-ascii?Q?S9TrO/XnF4ulZdShxsSElBMqvRchGvdT3nFGO4DS6En4glaA5fju9xQaCN9U?=
 =?us-ascii?Q?zVyuwLNVkmlUBO7FLbvrFFh3bucPDICicT66GHkseqnVqOeXb+HebgtIBYPn?=
 =?us-ascii?Q?M3CBGZzpSCqNkVGhaiv+Aahi0BB2vHSW8LeSITTLuFGe9oKITtlPJFMonMeX?=
 =?us-ascii?Q?2i4f5lLCtt6OetFi3mGrhKpyBpMT/9lSAv7JQKH7a77W4mk2L34gpfpysJEu?=
 =?us-ascii?Q?bDcUT/2ZKSIZdln/4qiDeiGFvTdgDryXTlFAS1cfj7PgFfrrlWHwS9hnaqWL?=
 =?us-ascii?Q?O5tGCEuCQi0/PgUDKJfeqPcUk62SbdDTHj9BbMUbTY8VCtqzrdEUScKS8pKP?=
 =?us-ascii?Q?GYFOrWCUqictKZQ0ucODpsmV6sQJyv1aqO94pyZ/4cdIa/pYr8Cywp/IFwR/?=
 =?us-ascii?Q?GHNIkBCq3+tCSAzvjYFXIqaBSxQItBNH6wkenhtWJJASxJJR9rwu+wHPd3sl?=
 =?us-ascii?Q?H5mBZMXg2JjpgxJ7cUOeVB2wVwtPu17zH2EXIPoutPqtUmJqe9V1S9IYg/su?=
 =?us-ascii?Q?hdX8tqiuAfC92Yf13WP3/NUrmuZsqO66O6tcVdQsphozTN5TrZE6AR22oUnn?=
 =?us-ascii?Q?QtHzKNFvVjr8K33iMVkTNdg8xmDzhIImpCCo0TfV8aOBMq/IYlYEnahPEx7j?=
 =?us-ascii?Q?SjJrzuE3G7qvy6do1JqYsg/Xgzoii7v2joOBnSZld89QYBnpAJxLasf04SGg?=
 =?us-ascii?Q?D8fJf5kVojC/ySqtVoZyx5H6Dicm5BxrFxvKRKOLxkNCRVYpntK1hZTO7UL+?=
 =?us-ascii?Q?FMPWZXN92Zt0pkUz4Ig7JN9l1rsqzbvKqe+fqe6IaQrdazJU0P/LBJKlc2vs?=
 =?us-ascii?Q?nE2Ac/fd/t7dgrfLtTCKciw2F5Phky0rGPrtwMCW59uaSQgzQ3/iNc6nhTnA?=
 =?us-ascii?Q?G9Up/kYLcLLE9kvIgEaUKmt9K2IE1izmqGUxGU7Hn9RoKdfs17M590QRoNM2?=
 =?us-ascii?Q?J3yvwbNZQNFuIv4Dxh5ARJpHkNCqboz7kSf4JCRsLklaAmQetRM3r81+tNyq?=
 =?us-ascii?Q?LkuDPkMxhJ8SQUF5BhDWPKH+0/2NGSta5leDtZkpFA7ewtaD7dtHmUa7bLkN?=
 =?us-ascii?Q?NzFEATsEjv2PL9o1XcSAAY6LbgOM6aBdHJBSfhtZk6N5lJViSbVP3HrvGYng?=
 =?us-ascii?Q?Bdh488vm9/Kt7iBT2NK2MlzGD/kVXf38maygtjVdGtFTcJhU/XMzgFiwZmlW?=
 =?us-ascii?Q?v8t/YmiXNkLh3SJXw0y1S4QzUxHXuAtulpK6AQPhnQ5lghOWG2GvSZE+v/Zd?=
 =?us-ascii?Q?z4wQVZRgJ3zTIXDC+kevOcBY1IfOux4kx/cj25IgytE06FMGxUC5HqHxRQ/0?=
 =?us-ascii?Q?WwFKn/jJieRRw7jh+QnmDZk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af5e4de-ac6b-42d6-004c-08dde0038353
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:25.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNhL+2U1YuA3Q21E459y8/LAJGHD5KaN66kM78g0gkkg78SyndClwM4borprkc+dbDZ8J7Ye+iZaslpeYHJ40i51IeoHsbMexXrl/W4W0SIl71i3SxXc198IY9Ac106P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19867

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3c3433c5b3a0c34dd36d770e2950ad3377d97372 upstream.

Add a `csi_setup` function pointer to the `rzg2l_cru_info` structure and
pass it as part of the OF data. On RZ/G3E and RZ/V2H(P) SoCs, additional
register configurations are required compared to the RZ/G2L SoC.

Modify `rzg2l_cru_csi2_setup()` to be referenced through this function
pointer and update the code to use it accordingly.

This change is in preparation for adding support for RZ/G3E and RZ/V2H(P)
SoCs.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-17-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c  | 1 +
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h   | 6 ++++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 1f01b4dbbcb6..459644e5af0c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -363,6 +363,7 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
 	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
 	.fifo_empty =3D rzg2l_fifo_empty,
+	.csi_setup =3D rzg2l_cru_csi2_setup,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 142c158a40c4..0c73e1ee415b 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -89,6 +89,9 @@ struct rzg2l_cru_info {
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
 	bool (*fifo_empty)(struct rzg2l_cru_dev *cru);
+	void (*csi_setup)(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
 };
=20
 /**
@@ -187,5 +190,8 @@ void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *=
cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
 bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc);
=20
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 9b4366ef910c..a1d4ef07a00f 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -242,9 +242,9 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_write(cru, AMnAXIATTR, amnaxiattr);
 }
=20
-static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
-				 const struct rzg2l_cru_ip_format *ip_fmt,
-				 u8 csi_vc)
+void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru,
+			  const struct rzg2l_cru_ip_format *ip_fmt,
+			  u8 csi_vc)
 {
 	const struct rzg2l_cru_info *info =3D cru->info;
 	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
@@ -266,7 +266,7 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
 	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
-	rzg2l_cru_csi2_setup(cru, cru_ip_fmt, csi_vc);
+	info->csi_setup(cru, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
 	cru_video_fmt =3D rzg2l_cru_ip_format_to_fmt(cru->format.pixelformat);
--=20
2.43.0


