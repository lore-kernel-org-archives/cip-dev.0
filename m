Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.298.1795708105720137094
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RofOdMRC;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAQdeiynm+tpIRmB8lIp5o+WAHm8MGCetpsRXVFNnPjwwQIUskEmb6cPYTCm8husqq7l9MNErXneSkCdbmMZ1Vx3QoYhnveA/q9s8xocKzOPdKXBGGqIgnNGQNJe9D15wDPuypW1Qq0DVzjpGAoJNmFezwsUB8GyuntZpO0V8hFBWfhQtb5J99QwPjALpv5V/o9lSIy8Pep2dzKizRbBy27W4z4OEovU/RXz/o0E5/UddhlRP4AO/zfneJRwTv8E9vjcPYw5M3nFV0hGJZZEFOERGPZWoOtB8Twe2NSa462TcMpGPtlKZvL5OLBEz9fBwAm1/r91IBj1T3ksL29lHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3dafphnwLzeDVlAv5VieyTIlOsoJZ84kuKxe1+aXRc=;
 b=rkLBEuC9DxlAU+VWq7SnYZKsjeDKtpJBcYFwXTVC5pBa5AVtXqswyI22+/ewpwnxgHdT9CYwVdAzNhwBwX8S6Znl0Eeu8L4DC4Wb9eikNvPC6wsN/Bil3Br2lbpZQuD8Jhi1HGtleBlyORYGjXXln8zto1JdnnjvQla5wT6uTAi9yGtzv8Na3mmRKkRNpIgb1KMDWULoDmCLN8pC3jcBJzYS/Htdw4Ik9y6voOtofTLy2W2OYi0J4vwS2FsPOb4YUPT+0pPlaXq4czWh5qBc4fjbVcf40jXqFnKGED1PkYnpH1vEHsUbDbQ/t3F959Q3U/vIsDHDMXIm7m1IN2UV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3dafphnwLzeDVlAv5VieyTIlOsoJZ84kuKxe1+aXRc=;
 b=RofOdMRC3Hrg4lni6ycw/xw+52A6RhBINVdvabuIHqR4NGCc47yYphN7jtbX7xxKX4byPUuWdOsGO5GL1YMaDmiIDpOJk6SUT+WfQyKzpuhCEKYPNoQl9ibE7jkSI8jmHlwu1JiysEbifafhqxLeE2ymR4fVW1ahDQ/0ssIPG1I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:23 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/27] dmaengine: sh: rz_dmac: make error interrupt optional
Date: Thu, 26 Nov 2026 16:47:24 +0100
Message-ID: <20261126154747.3832917-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c8a627d-1c79-460d-77a9-08df4bd4b3ef
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rsXssJIZqsBkIbpEzwvGBOekYMVHejcmXWKw0YKo5534onh/bOfNF/kHlnN3XAxowxkdIFRPn5xj5pFsZe9rJBssMHMbpCm7Dsupncxaikf34ob8A+7g84tiHlC/U6mlkYVLv3lRcrkpW+3/hZ3VKN1WmaJT+TsVFqWifQ6VG+F9qBN2sFP9Swlw30UGjaJ1+zhpat90mcVHh0FunDCmlxCnxPCp/+yvovYva5IOHPOf6jZ/2i03nQFje9qL+mkldRL/sQZJ09BB0jM1XiqVHr4h4cTSp94/9nTFKIznIhXkWNUxZQ0ZBEnur3fMpUk4pZG6PsW/fHtqDX3c/gMhd8mz/0OEo4YuiIq5d+cawd/DuILcmTmj8KknoC2wTFikwdRJ+jUgLGEfAuGiH1x/iGQEnz7KtbgOOftevpjaRiuHrbRDLtGKGxkXr5aKk5LZ2ClSPbdWNaxwJgaZyv0RORwMhygmiNdqVdBQxdn/oE6BCMCJaxNZrni4tBXYUqHWjVgqCoOXAgtp3dGnQ37A4tT5xpHwUVnUW0EVSM5kO/dJVGswJR1yVWMFqw9k5ishsJt/e8yoMpKTmFxyk2v9Odq7PzhSrSPZhM5cL3iJoqrGoEWSv9TNKzhuZf2vjCsQlJw011Ov8vPYFiP+SEq/BtXHtK9heBabu9/nVU0eFko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J/ldM8uINlKmwszLYK35jL/hDsHeSQPMhnpXg86bMF09uk9duxuf6eOJNYJt?=
 =?us-ascii?Q?0CNpEzV6J7EAaI4vV+28U1bZZ9gON+k49ejsk3mIIVIJKSeRHDuikCsZh1rj?=
 =?us-ascii?Q?vgJ5zPwMie9/Q57hxu7y0HIOicJxQfqBMZtqiLM/S8J9tPwrupWI+dJmIhcx?=
 =?us-ascii?Q?a737EBpypsVw+o3HEl0RoGuEa3pWq85haK8UyUrbrZzL/sysHPuitMERzE4E?=
 =?us-ascii?Q?X7lFqTtYCDqqHkJarihKrM2NpCJcff9TrRUGoUyO3JcAEPSnAZCt0A9JoVv8?=
 =?us-ascii?Q?xs+WhHTSflsbqPU5e7VnCsZ27vvR60zq85+bKPQgEuf2ijMjgZ0F3MLGVKZM?=
 =?us-ascii?Q?Me6IpL5g+qgBR6nfinDKHzt7yG75J96SougcDvMpIagpnfR1kN+ggCerQBME?=
 =?us-ascii?Q?0lKWdjCgaZJpfRl/PGGPSxldtOnk2dDCnPawe6a8coKlKDhwofx0RO10/P5T?=
 =?us-ascii?Q?nDNm6svXZTqs2723tMwljUHY153EFqpiXOIIPRK5T1TWSQSO5U4+zBy0Tfxd?=
 =?us-ascii?Q?vUBsVWhZjKaOHJAT0A0eeQEoFfeCIz7Z8ciYnHcpORO3mcMjUJR1Iwq1Z/fP?=
 =?us-ascii?Q?e1ZWXxPpTCerhVTRQMdxpPReW927ASEdB3O3cGFvahwXkNi8Zdch2zkfObc+?=
 =?us-ascii?Q?EyxOIwuwKA492y/Uag6BDzNoahY6UNbJ9sGFX6OT5SYXirdpPK38fss4xhlm?=
 =?us-ascii?Q?5xSPa5thb6MAyYv5LD2nHcNgNRBmwS5IKeiY5Eea8SJOZkuvwbLPbBNBso92?=
 =?us-ascii?Q?ZxBfpW0Bgy74ID6tL+jdL4hD5v6mO/opigh5KTzLdq6NiaGrtqHFoCsEa2tg?=
 =?us-ascii?Q?Rb8NFRg/zi52umpS0362ZZLEBb9GNBIN9ldcAk5Ck4gwtHRqCVkqsIn7PjYn?=
 =?us-ascii?Q?Pp083MvIHRlA9oXi4+1rnAfPVXzn5FHmffYVpyI0zvZh18QJJyPxWy1Jqu+J?=
 =?us-ascii?Q?AG9/pDL9aihQh4nd4M94Vf4g/lYftH1rWw52kOZpQnKYaTEKhwIOtYydCIAM?=
 =?us-ascii?Q?qQusFOpMObP6wewx8KVhMABQ0PsC3lMN3ro0JB83s8Tq0hvhR+hTeVOQLDFL?=
 =?us-ascii?Q?3jruvQfOoK91bfNf+4gw3ioqIGao9O3rHlaPV82tPKz79ZL/19R9+bZQwPPw?=
 =?us-ascii?Q?PDakc40f7Wmzrsx/AXRu/HcIJUd9vqH3VkM0vJ0J3/QuFut6YoWWIkAet9GZ?=
 =?us-ascii?Q?a7ZOc6l+jWVblx7Iz1WC/86SgDQmLmwmg0YL7TbdzrUxRclBBPKULyYFudWe?=
 =?us-ascii?Q?NwweAJ/fNbSKylf/TGYBRUYm4rBSKgYmJPk+qnq3IgwPP7E74kxKHBsdxnBM?=
 =?us-ascii?Q?kMBRbJrPHiMnn/7sW1Ik3b2xwDSohQX98pNc+d8YorlwpFMYjzCfQKgLl2kR?=
 =?us-ascii?Q?AF9DQAVuVQEA/WpdIEljZ0rKXR6y+UUHmrivGl8D1HUdtEhzjgFW+bgFhSOJ?=
 =?us-ascii?Q?OZzEuEJEOeHjLR11Xi49vdnTgc0y4Xcb9XMfQWU564EbIXEn+BClxNIGKjAb?=
 =?us-ascii?Q?E6rjFLWfUusywrGSwHo+4gydoN7cr4sKc3fr/buoot1T+nYD3L2COwLEeVpy?=
 =?us-ascii?Q?Ynynsxl3p2T0/DOnEsD8aYyt3Thw+X20N624TKIOtz8tg6jswXg/o8l8l1of?=
 =?us-ascii?Q?VFUMcy0nM6BTlmMx1CtQH6KeHJoSc1NAfbZhyhq6tqT7xIzkTLjyKcXGISwH?=
 =?us-ascii?Q?u+gSX3mxeuIh0umpO9KPPoGaJT0qQ5JeDb8/f5WpBf2MaXGD0Ax98H+igd+1?=
 =?us-ascii?Q?XaI5uBNUnBC4VxRgl8iR5FoSMfrTFKgKGJTjK2RppIZqIiQR70/Y?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8a627d-1c79-460d-77a9-08df4bd4b3ef
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:23.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbBT2TA38hooYDcAd+Fjyt19niMTDnLjuEGKOrngrkBo3NmmhIzGYOmaN8S8GSnMdcOyGRghAuOOMETW89qF/4YhK3JUYkb4wexzXVPdILaQx9FNQSgysWE9Wc9XQvY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25154
Content-Type: text/plain; charset="utf-8"

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit b34f3fcae72a0afdd1a966fd68309b461bf678e6 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have
an error interrupt for the DMACs, and the current driver implementation
does not make much use of it.

To prepare for adding support for these SoCs, do not error out if the
error interrupt is missing.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260105114445.878262-2-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: goto err instead of return, since ("dmaengine: sh: rz-dmac: Move
 interrupt request after everything is set up") already moved this block
 past the err: label.]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index cac91e45805d..6f8f109b8294 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -984,18 +984,15 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	}
=20
 	/* Register interrupt handler for error */
-	irq =3D platform_get_irq_byname(pdev, irqname);
-	if (irq < 0) {
-		ret =3D irq;
-		goto err;
-	}
-
-	ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
-			       irqname, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
-			irq, ret);
-		goto err;
+	irq =3D platform_get_irq_byname_optional(pdev, irqname);
+	if (irq > 0) {
+		ret =3D devm_request_irq(&pdev->dev, irq, rz_dmac_irq_handler, 0,
+				       irqname, NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
+				irq, ret);
+			goto err;
+		}
 	}
=20
 	/* Register the DMAC as a DMA provider for DT. */
--=20
2.54.0

