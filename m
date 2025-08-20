Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA08CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:10:14 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.1])
 by mx.groups.io with SMTP id smtpd.web11.1077.1755706208573561646
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:10:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PhjkzYg9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDXgnXn5z9dzLjtTHw3mHE7sEPfpxVYULW7qOReQ8hyX8NuECY+/Gr6nDJHFNRB1pE3bNztEK4g786VZnnA1qKWJLcgnoLU9faMK7oVGkUPZfD2SpwPPgH4iRf94AnbnQM7nVjt+rRuT/3tWxI7N1v3ppZeyyMBmaUxR/52X+qumDIDY/MHlhHT0Hg2hBazo36kFK1Up+JnIJQSpY4EU7rQh6xKPwVd5c1qQtBI3wvStXpXKDwDoG1j734oU7DsP7JNJiuGFvnjtSK5qNmPMQo95rY3meYPEwRJGz6fsSt/Xrk8eyMhpqQUoSiH7kWzlK0e2pA9O2LE6hd/rM6nDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDhUHYdr6ZV3Vf5iVRqtB27l1V4c6YEWJuX2E9M6mzM=;
 b=LF7oLjTGqxT4CWMTY7SI+/nsQiVIJPLlrtNK0uBBkyp3sc0mrujUDqcf00o5cfvCy+xl7qTOO+dqdo4W2ijrwKYbQqr+XhZO7ESa25fzV9lhwBr2jkAxiI1WZ+ADtJI/uh9ZtgWzSGtd0mVjQCp9/AMyRErlP0yofG4c14MIo0WjDJV+vLSN5fpcwXj4+7Hj/CLhxKPPiFfcEwjgHXsu41Ng1kIJXISAzC+bwL9jubPK8vzVbklTa+fefS02RPIfSptPLttOv4khPzTiDgOskoMpfJ/dOLis1nTF3ho9KKtlawgjEa1uymLCBDWTkeWfT+4X9CnRVzmltgUxVoWarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDhUHYdr6ZV3Vf5iVRqtB27l1V4c6YEWJuX2E9M6mzM=;
 b=PhjkzYg9RQz7IMVlcYlGHNpmrOJQ04lZ0JEzct5lDO7U/vLamfDbss9LrEcMyFTw0eOPcC1y1OBttRHnWld/WWfDhuOdZ9zWvpYDSdXPRFHAwyAe/yL0Lx/pDz4VdR3QUIhGhp4/fQGxxZppuMJhhtyKecmBJql3I0zf9sDqPFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:10:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:10:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 41/55] media: rzg2l-cru: Add function pointer to check if FIFO is empty
Date: Wed, 20 Aug 2025 18:07:42 +0200
Message-ID: <20250820160758.801813-42-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18427266-a7ac-42ee-73f1-08dde00406f6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HJUUDpnM1WhAewZ0QMKt0ycI2Myr9PHv1MwsjsdTR5rGzAAMmJoFLod9iYZR?=
 =?us-ascii?Q?Uxvp5UeoNG2hXZqMNAQAt3Ztn4N4EeQqg4IuZlR0T333shudR9rDxzWnYShS?=
 =?us-ascii?Q?JQp/tav75lcjfvXWIMLTVzXoAhGPHWhtvNt6hBqr2aKcDvkiWr0DnlflAHmq?=
 =?us-ascii?Q?3vpcZRzJ+T3pzmkVx+ZvDacABcj5HTcgGRNFtkJKxRpK/jIEfmWCzXmq9Naj?=
 =?us-ascii?Q?XXgSQhqsS2QIajWvNhxKMc55JF8OOJbvfNInFAqNd+YtDGjDWC7KxHBxyVCR?=
 =?us-ascii?Q?a7CIZAIUx9eWJvE+RBzB0bz+cJGKFTNAC7BwjAtsp+XQESUNgRSoTQ5lR+pN?=
 =?us-ascii?Q?M5mFrUC3iNxZjgcAkqmputTq6qjnVx18IKdz8iWDOc6eM4Xue0SiNi/AiHhD?=
 =?us-ascii?Q?UgYvW5B/pJAh/uuGTJC/xWr+mPa2rWXThxz3r5gFu7RHSTuUNldSnYKkHEzP?=
 =?us-ascii?Q?R5jENOcTP6BaiF4SCafm6dn759XYJx3Xu7oC4uXSF7kqCpcbXhbKgMe3TaMM?=
 =?us-ascii?Q?P7TYySCk7W9WmOvOYWUtYvUYyG9o9BPf+0201FfeARVCKd3Td8IwIK8ZL6Sy?=
 =?us-ascii?Q?nqA/rx7L69IA3TQHR/YyfBcfHFyEhtC0NV9XfPkA4dnFsuRYvhjYEmrQGs+/?=
 =?us-ascii?Q?wc8xLXafiNE9IhLbZ8CjQfGCBXzdnmAcoIOaK0FBmnKJRlRIyQQijcYivmN7?=
 =?us-ascii?Q?XSbYl9v6ku7Wy1enruRoHCgkgS2Qiij66G+cuFgfUVGVgYqE3G0g9NTyw5LQ?=
 =?us-ascii?Q?dFKOTFRAy7o5SVkmhaDoYUfMP9tQ3hTsSKBBugeaew6BUioWGZ62kdtVUT4y?=
 =?us-ascii?Q?sJ2zXGSEmA9TO7kHrXHAE1/8EQ8nqsKCZORQ6b42H1YjVfLsco1PoQxPyGg8?=
 =?us-ascii?Q?KSux71a+RtH63DB14d/NguenIRRlBKtkR1b/BdF7aRd6GZzjdFmYgJRxoPmf?=
 =?us-ascii?Q?bGBtiLZ3jiD4EcOoQhx+hYlM2bQ2gUB8tWmhADiVU9GvYHAErheU6/xEOQfD?=
 =?us-ascii?Q?igcFp2V30LiD9ruIiZE9tdbMNbZj7R11M5UQ3LwgNMjyLW+fcqrJMGSGyfMd?=
 =?us-ascii?Q?Ei/K4YQSIoGCWcA1PHHSMdHnl9S+c9TBgqBpi+N35Drvp3cE9aLxtkMKoJ5l?=
 =?us-ascii?Q?8oCi15jKYYMeuh4UYmHMmWFqevAA446FQrotfofasHLb2y/fIx07MXSpuNcU?=
 =?us-ascii?Q?EeD2gUKOjeABBUDCMy96LikX6vatKt5thgZDFIRqhaCtAXFsES4+7VrkvKgv?=
 =?us-ascii?Q?AAI0YjhAp1BrDf6T8LQYcUyjALNwvRQ2/oc4p6GIl0z+JRT+Dxsn3lzM7k1l?=
 =?us-ascii?Q?Hl8d7hkyi0F5MGQf6BChMPS6iVpvcsOq2Btt02WqDTQXx2fhpiAXpwdhjJ9z?=
 =?us-ascii?Q?hXeksy3M7T9oWPDK1NQs39sSW7m5O0gGk09tF5qkf1j9sU1OxTMesAsca3d4?=
 =?us-ascii?Q?CEeNQFheSOXbRzZy82nB6QJtpU3PTKvhTs+c3PDf8dRFABVpjP8ohQz51JXF?=
 =?us-ascii?Q?qsyfH71Vv6buUS4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+YwMJUY9qNSmjyYw4kZ0zOYnwPaxUa+9fDGTaCjxR3aDjTUAUOYjKjm+5bMo?=
 =?us-ascii?Q?2f+7YuMIdVgmLNtgAygNYbkow9NgiPDNf9W7QJ6BKoF/0+cb0OYkYMNpL8r/?=
 =?us-ascii?Q?hTh/4G3PLr6gmtlE61U4yvLdsn5ZLs00pen2TvJOeul4WxlBGk2P1eQIYtOV?=
 =?us-ascii?Q?v24CM1GvUwoRiUIvXmCEXFiCiqlHoi7+rlw8+bMrKUzDC0SXF6e9l6UEtTmE?=
 =?us-ascii?Q?nu+nNVAYDFcPagyuEq3bv8GNO55FvPUrRFswU7OWOQ+fVa9kNFgnctLx2jJv?=
 =?us-ascii?Q?lkp2fUUDS4ytp0PU9fHCvWXe+qSNe4YINH4x476jy1Zgnp5rGquC7IVPbUNp?=
 =?us-ascii?Q?uD7XdluSjXinPDBPHm1vcZyvZ8sQJA2DYs/OFXBDMfOwwtFI41KJIe85j0Gd?=
 =?us-ascii?Q?yf+maJdG32kHbVBHgoKGOQ4y5b/Z2b6YEruI/udaou7TIeShZm4vuViS/5DB?=
 =?us-ascii?Q?W/5OG5AR379G7uSryPE5cWrqy9REDc7v8tP9hW5oxL3NzyY9ffFX1Vhq0J6y?=
 =?us-ascii?Q?+JgHRXZ33jVK7jirwYsDHil3cbd5IVLSnRKsCpJZW2SgQr1ByBN4E7lajvx9?=
 =?us-ascii?Q?s0iPRuxOP5uAIhPaeDC1TnzP7w0RuDRNEGcWuEE2gD6MVm0qXCHl/rSLYZd7?=
 =?us-ascii?Q?VzvpPCPrBD56ii74wK5ny3wAKsDgnhEi3XTV2kFJzGlbzjzplU4mGeq0asyw?=
 =?us-ascii?Q?uvNdf+YUiG5W/Y2l/L/hIG7EA1SazTq1BU3uk93/03v6s18JM965nwk5suGf?=
 =?us-ascii?Q?oTlL3C/l+xdggNNi8XyXoHhMu8iW3GeQ7hkkZnslWwNPrt0EDGblK6AOZKPw?=
 =?us-ascii?Q?hZSg8iXENUO+h0aWFIY3xftK80O8CQlJiOnxJ6JdYogTrGSyJ+Gl/wipMrJh?=
 =?us-ascii?Q?38Xt7QfdDnPy/cd/a137SOeSOix5MmOnS86oNkd4qhwu6kFz7q/YrFhmrn37?=
 =?us-ascii?Q?Zq+yuGtsHTkKXQ4au8dWr1RCCXLA+8ZRhS8t7t4cVDzvd3qttr6kYAY2qp/J?=
 =?us-ascii?Q?nJqONbllbLd/j845LjwFUVF1iNFPToW2k7loyneeKLXUlpcaiU77J9cjhOSw?=
 =?us-ascii?Q?7UFwCK3MvD4yABK5Qdn2TuiKNhKaXZOme0AtdHch2u7bhCYnMM+tcHsoM0FO?=
 =?us-ascii?Q?UZHEn6z9jD+V/B6NBE8BlWMkCsoow7IPNm0QnsMYA744rGk2kuIv6t1/6oi3?=
 =?us-ascii?Q?UrVSP4dW2kNRXLpQ8X/aRoiQ/cG/7RI1tzSTZ5K6IXURBIB6Tb2Af6C6hPMu?=
 =?us-ascii?Q?d3AYSlGBtvP0aRl9OGifo096rMxGL3/PBoevqKMTjwXE8ogTVHj1KIz0x6of?=
 =?us-ascii?Q?bVSSfQ+aeeGgdHnu/ix8ygOIOs9z3zD4zsql2mbUnT3kwnlaypRCDiqTMXXj?=
 =?us-ascii?Q?kZtzHG6Z40fT7sb+UxNrLy39h5HU0gsV/1bHSZin94LmASKEz73EbUiIa2au?=
 =?us-ascii?Q?JDuTSliBcxVwsPwX5m6W2DMTNPzgTGRR4NeD+Rw90eJodU/7li5QatP323dO?=
 =?us-ascii?Q?lDwHwUiaHVt8EoTmP86wSTuDLwZwMLd1U6iL47PRAv/CPFR3ZnZQDFGbVOMG?=
 =?us-ascii?Q?K/RwLQEPbV7bY7CDcDSDpmTxvnnOHP+WbGrXLXzjEfavlp7utJsjDgYz/c4D?=
 =?us-ascii?Q?ac2jku/ubiXqEdO+HTIkSm4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18427266-a7ac-42ee-73f1-08dde00406f6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:10:06.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQwL7yzWA4d9dYtyOBovw2j/CboVoC1i2/qxoO3R7LkiFk1SCJ9VvsmJM996e0kgsfuradAD8CWw1PYerbWvGPOCISn7AVBJ+wISSYNIm2XiXptIyxpDNo5uOZI8/JEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19922

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 446c645f7fe480a4420072728faa1f261530b984 upstream.

Add a `fifo_empty` function pointer to the `rzg2l_cru_info` structure and
pass it as part of the OF data. On RZ/G3E and RZ/V2H(P) SoCs, checking if
the FIFO is empty requires a different register configuration.

Implement `rzg2l_fifo_empty()` and update the code to use it from the
function pointer.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-16-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  1 +
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  3 +++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 23 +++++++++++++------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index 1522c3b10c73..ccdac9785014 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -359,6 +359,7 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.irq_handler =3D rzg2l_cru_irq,
 	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
 	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
+	.fifo_empty =3D rzg2l_fifo_empty,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 3f694044d8cd..2e17bfef43ce 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -88,6 +88,7 @@ struct rzg2l_cru_info {
 	irqreturn_t (*irq_handler)(int irq, void *data);
 	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
 	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
+	bool (*fifo_empty)(struct rzg2l_cru_dev *cru);
 };
=20
 /**
@@ -185,4 +186,6 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to=
_fmt(u32 index);
 void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
 void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
=20
+bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index d5a9149baeca..ddd4c2ce12c5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -290,9 +290,23 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 	return 0;
 }
=20
-void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
+bool rzg2l_fifo_empty(struct rzg2l_cru_dev *cru)
 {
 	u32 amnfifopntr, amnfifopntr_w, amnfifopntr_r_y;
+
+	amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
+
+	amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
+	amnfifopntr_r_y =3D
+		(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
+	if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
+		return true;
+
+	return amnfifopntr_w =3D=3D amnfifopntr_r_y;
+}
+
+void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
+{
 	unsigned int retries =3D 0;
 	unsigned long flags;
 	u32 icnms;
@@ -320,12 +334,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_=
dev *cru)
=20
 	/* Wait until the FIFO becomes empty */
 	for (retries =3D 5; retries > 0; retries--) {
-		amnfifopntr =3D rzg2l_cru_read(cru, AMnFIFOPNTR);
-
-		amnfifopntr_w =3D amnfifopntr & AMnFIFOPNTR_FIFOWPNTR;
-		amnfifopntr_r_y =3D
-			(amnfifopntr & AMnFIFOPNTR_FIFORPNTR_Y) >> 16;
-		if (amnfifopntr_w =3D=3D amnfifopntr_r_y)
+		if (cru->info->fifo_empty(cru))
 			break;
=20
 		usleep_range(10, 20);
--=20
2.43.0


