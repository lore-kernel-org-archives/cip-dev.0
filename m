Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.298.1795708105720137094
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WQiFNVdo;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2VPwbRQYjjPvt65FdwBRZzYrmMLSPafOdZHMY4Jf0ilRPUR1l3zzCDsWiHU+NPjHqHN4v6YXmbw0RVyOXr4YqnQeyzjoCDFxx/UmugRvrBdlcQdHgJcl9+uTZZ3nX+NeD+rHQBFmHKybgUbunCdRQVksKBXSJKzZ5tlaTDwhNE6X/2gKJCKAH4aTX4IV11G703TMXczos6DwPNttD1IG+B0Q1cRs0R2nyaV/bxIEYPE6wPB/j8Ij0DU8soDRfcSCsgX/VamTqWAMGFqnY8TL5tmieAojxb5CM64HQT49r04mxrQCbY+b1mPkwp626CbVupQqkoecHiNJiZqRtVjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KRg9Bq6yZKVIiSDmXfZt4xDpZk/y92PbL9c+HudetY=;
 b=KEacON35N3rPQzlWyvZnaBSm3iJV1X/hEEAmCK34Ga2lS12+s0TeFKVMcaPnDT0TDwIUfrPd+YGvc2HUEtftlNmYVkR+rmM77U3swhc1w1YYIrWO3+PChDt8JcHxHfEv/DFKy9NQsT/ToNkK/f8+OvUT7DsccuvLOE2esn67Kdw/rISSiMepXZQY5hnzFGVo7YPfbazROWFwcw1dLUlTBDgQkkKGDDtQeCqrj4Q9OuTAQ82P6wDEIN4Y5Yd5wFuyf82idGSD8HIDq+5dhOexMmnbDaSnA/05VAFrPgXrFLq9EO6k51Fk5WN5NE5bB1Ym/H6DrbTmGgQpSZVTzsOg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KRg9Bq6yZKVIiSDmXfZt4xDpZk/y92PbL9c+HudetY=;
 b=WQiFNVdo1zf5VQvIv3PVNPZmIpOlOA+Tlqa3mWgxM0uygbbrAfjDP5fyrLT9tEAZwAkSmH+svCrTH2d4ujrCjsYj1S3yvnlerliYnJh+k2GUeFEBelqzwCKqasYkG8UrUgy64s9AbgEDmRPJHjabhVsg3BSouFh62dk2ofQPci0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:21 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/27] dmaengine: sh: rz-dmac: Make channel irq local
Date: Thu, 26 Nov 2026 16:47:23 +0100
Message-ID: <20261126154747.3832917-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4241ce-5d63-4818-b12c-08df4bd4b24e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|260925022911599003|260925021311599003|260925021911599003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gWFDGer65HNCP/3D5JRc/Zc3DhZ/2SNhYCIglgt9iFWEgEy0EGPfIs2ktGfvQ57hxj4Dq23iUuzTK08odnUtWboHVnN7i6vks5FXvV4jsRyrO+zNnTwD5y8gx20UvtvMnhAua+PsM5FpioD/9Q+PaX/IosGv3ukZm1CEVnC/V/0+F3bfC8BBImFrSethoVDZNmUcgEScGCkjWoRs7QWNABI1mf5k09ZqyVYDJSP1ble0y58PfAPhkU3SRPWe29kXKUzS3aa73m6CcubuVoQLck9p1RYiFlx9yjxUnsX+6kG6qzVrLIicIfzV4YaF3+ekUrMIPj4vIraCzt5KOJRBFHNxdA6sm6x1Mq49VabmABc9iS6xrVRGA0u8/lHa9YcXfTqd0Zru5U5rUfz7MAbKsDCwRiiy/KH2MlkfKzq6hLrA7zqd1Gi4KPSna8rQCrmSw1JcBCciWWOB1VzlxThF36bngWpnPcstSfTcoQiqqf8adavaJQCU4ER56oh6D/6uguL9Tufcs5N8cOP0kW67c9eFJ+Z8rQDjbS3FRYNFrXmuh+0AAuX80VnI54AdR8wfDgjavWVQS3w90h4RVEn3Jb6rDVGD9W1vLr8WslDVtfKjyyPn+etyTBBXVhdbYKxbCL0s5jbI1u4L9P/LbdmAr+gs2ul1WD0UWXNyBOL3A9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bGZivjDz6NBLKWlBxNilxAMwI0xm6zMbgw27kvvC+E9KgRoS7FEcWDaa/jFN?=
 =?us-ascii?Q?cg6ZlfT9/n1ybCp8Sj+cuWMjuS6QyHWTP3GCnKMoEOsXewxMtptR3dZ5aIon?=
 =?us-ascii?Q?45rUHIXZvENCJR1MMFOyg3jD91JYXxCsYNYhwDX55kiEO7Ou2S9pcH22kkA5?=
 =?us-ascii?Q?4XdPTtQ5xROtD7KDA6xQh1A76YJA7xiL7oT6PZT5m444x9b5Gwx4OOPKqw9b?=
 =?us-ascii?Q?EWjmhbOvao5Iivo8ruIMdnXh6s9C7C5RnmYp24U0ZIbYnwiZCm0JFAUPBtrh?=
 =?us-ascii?Q?iH9wPZ11hTLjT0lA5SnVxoBl5vDxmYLoF4vyHaekE8S/ByHHIB5phAVdvUua?=
 =?us-ascii?Q?oONCqlHtptxfjXDPQKmeKdAFBfGyOBtjIlPGLso5HWs8jUhgNwHCAp5v12JJ?=
 =?us-ascii?Q?CqI80KdBGuxnraaefOsRsLJjANN+8B8pfVGX8Pbh5q66nE6LV67FLU7XQDU6?=
 =?us-ascii?Q?wU+gQjV7IA8PU/7mp3oYkkKKj9oI/BqlByB+O0Ft3qwavYqSXU7KOD9Gy0gj?=
 =?us-ascii?Q?Ia7ArdVFtc7vppjS6uN+jFDjxrln3zxHradcYgRd3bVbSvZZIybs0b7s4KgI?=
 =?us-ascii?Q?CI3tb19Q6cqzLUfwsgtJfhqOpFP1kGXysO5OgQKIkAL77cYGKzNFhBfaCR1V?=
 =?us-ascii?Q?0n1uYVsDZ0Kl6yUZ+Sd1CHPhKXMbYuXN8YBxDEUNG0SRvwAaK5X1Tjv6H+wC?=
 =?us-ascii?Q?QU7G8JKUBQfbGyJMHkFrI2YiVJoVPPFUtFkav52qnYwdVp2R8f+FijRhjdHj?=
 =?us-ascii?Q?aWndBmuW8hN2zTOz9tB4By/sTZ60heY5G94OOwJqZ8MnY4H8QCDVBc1fzraW?=
 =?us-ascii?Q?YvX51Kw88y7r767UB+YDRn4o+r4EjG1OCHF/MYE3fMk6IXliBiv4dPIrYDYa?=
 =?us-ascii?Q?4JAwBwz2HNB/NlXzVTXglDCNl60ipFlvgGAgXaW/xkKQEAC+r5XMEOIUiONU?=
 =?us-ascii?Q?kSTFB6tvSBS12HqcCltZ77rdbebJa3trBEH+FhFkCjFeY0zqTzqdbpab0s3C?=
 =?us-ascii?Q?LD0t/fQtK6vqWjZPusRHXew5BJixGB0yVZDn6kJyp3MkALXiqeAYreHw2cHa?=
 =?us-ascii?Q?K0Eq5gEPcYJQYWYhDtmWXaXboa6AEGc1XI6Uwey6S+vtwOtz4qfc/2nXSnZm?=
 =?us-ascii?Q?PmshuBPSJZ0OLLnkGPyLzc2I3A1UCtVFYf4g+rl0A9A0SRoYCv8inYKymrfH?=
 =?us-ascii?Q?fxH3Zldixnk0S5WmlfohIoaKzVDExA5K13JSa1XuqcAoUTrlzijoP+gdq3Yb?=
 =?us-ascii?Q?PR8Rvu9J928+oSZ8OcHEsQ0KlQXA0AjrTAKdZCIMQJQHhTPkL4BPaUKcvaC7?=
 =?us-ascii?Q?RJkDOCABJcly2omEKZ8HNdRlf6JMYQr5GwWZFMjae7FSZnJuA/L5NS4OnWaY?=
 =?us-ascii?Q?Peser/fi7RQCOa+wpslF4DqTOJg6aWMmvqufOXdxquLpug3Hws4qL9uCEpsI?=
 =?us-ascii?Q?VhBzelfJekg6nMgOtBNWBubawvpoYL9dq5FVzGGLkmm9EMXTb0qD8r8OYnOf?=
 =?us-ascii?Q?gQGRo31thTfTRuqD6JISeRa/g23CgVVn5fzOH+mivCkU0cq9TrcG/xIEToy1?=
 =?us-ascii?Q?LqvF9Ve/FdZcSjFgfAwkcmec+bXCfq+30kfx7vBtAYAcCxuiDc4OXTMYz7Og?=
 =?us-ascii?Q?pcFR2guuoKo0Ho9FgAieSxyRuuX1cLHB5dBUIkS4ojNT8+ClVPOT8fqzGdWd?=
 =?us-ascii?Q?NoNRXhDpUCeCubynmqcdTa6LGySHy7dHpA5as707HZZsOaQdqJGSCoJUIZIB?=
 =?us-ascii?Q?Y22i4GD6Er8//IIeTWWJARdL6rBvC8M9Z5U7YkU2Q/lHbIkOo0WP?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4241ce-5d63-4818-b12c-08df4bd4b24e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:20.9219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK2BWCuKZU0tKbAkXHBmV0NteIskUjR7BcC7ETQYp3dIn0dF/JOTNeFwnC8TqRQRHGEVNVD2d936MXM/qeUgwJ2xuKlrm7+3Bxi9VXDIYtVZf4TbTeA0Ylo52bc1Ssjw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25153
Content-Type: text/plain; charset="utf-8"

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit e0c51fd02f9cfab341907f6764d2f15c134eea55 upstream.

The channel IRQ is only used inside the function rz_dmac_chan_probe(),
so there is no need to store it in the rz_dmac_chan structure for later
use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/312c2e3349f4747e0bca861632bfc3592224b012.176=
7718556.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: channel->irq is now stored in the local variable irq at the end
 of the function instead of at the beginning, since commit ("dmaengine:
 sh: rz-dmac: Move interrupt request after everything is set up")
 already moved the IRQ request there.]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8bde48cce20a..cac91e45805d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -66,7 +66,6 @@ struct rz_dmac_chan {
 	void __iomem *ch_base;
 	void __iomem *ch_cmn_base;
 	unsigned int index;
-	int irq;
 	struct rz_dmac_desc *desc;
 	int descs_allocated;
=20
@@ -806,7 +805,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	struct rz_lmdesc *lmdesc;
 	char pdev_irqname[6];
 	char *irqname;
-	int ret;
+	int irq, ret;
=20
 	channel->index =3D index;
 	channel->mid_rid =3D -EINVAL;
@@ -843,22 +842,20 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
=20
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
-	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
-	if (channel->irq < 0)
-		return channel->irq;
+	irq =3D platform_get_irq_byname(pdev, pdev_irqname);
+	if (irq < 0)
+		return irq;
=20
 	irqname =3D devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
 	if (!irqname)
 		return -ENOMEM;
=20
-	ret =3D devm_request_threaded_irq(dmac->dev, channel->irq,
-					rz_dmac_irq_handler,
+	ret =3D devm_request_threaded_irq(dmac->dev, irq, rz_dmac_irq_handler,
 					rz_dmac_irq_handler_thread, 0,
 					irqname, channel);
 	if (ret)
-		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n",
-			channel->irq, ret);
+		dev_err(dmac->dev, "failed to request IRQ %u (%d)\n", irq, ret);
=20
 	return ret;
 }
--=20
2.54.0

