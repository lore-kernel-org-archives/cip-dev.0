Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B5DCA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:24 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.63])
 by mx.groups.io with SMTP id smtpd.web10.984.1755705982192710152
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Yvou4uk7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYaeCHw/BX7HeXf00pqkiUuPPzkcyed29KT3H/yrYq441SyENuva+InVwWeCccdC7HM20MLbufCt9qG/E46TC3KH5/aInUZFhIBZUrDZYn/y3z+ccXrLsS16DPmwxNDfZdJijqiziTt3BeHFPCjBLJO3iXFNZCbTQBuaM7m2aU/sl/2ueSwAonyjKeq/QBKtq6XcWuQh8HiISh7NJJzliJDsW8BWgvhilnL+DCD7vvQGWRs9KUvcuIyB63ItAgu8/+pUcrEYNekJXkku8UPH2L/jzNmJXRHd26o5iKM1meinZpLoqO8aqDkMNfUhQZF5A+csJFF1qAhh+7TBh/nLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS2ZgXkaHWYoF+cr1eqiY0pK9MhBd77vpkkpHdRnew8=;
 b=fAKE/7yGCTO07aON6RHrF5wmXnavw0ylSFQfoI9q+JzCFqODEC9DKK7YO7FVnim58Tl4ZdbRQIVhoAzFoxhkogfCFvrMKzMOrQdUALoL11T6hJ4Ff/YE3OYVqjNJKKhsEDRswoS+WGDpM4IvH8fT3UwahyBFUs7AezcEzh0PJkp6MEG0ieQVIsYjyoufY+v2cgPksJkznM+L3jak9K4AvUHxCiDIA5wD2SLRc0Bc8/JzjM5/Gex+m/OF2lYZTCcefH3nSANhwenkJfT4IsOFJEM70Ee030rSsEeSxzrkztHbq952w0dP4EuubT1w8zVSDLhGBjsZ+8h/KxJMRLYMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2ZgXkaHWYoF+cr1eqiY0pK9MhBd77vpkkpHdRnew8=;
 b=Yvou4uk7gY3jRhyZpqUs7S84RtGDgQzSCKrRwt1vfjIOm5i2TFAUHATfjmFcyP3Ykk6Qe56sMAykrao5BsoiDp/FSEPAsEcOWcHD/RcSclMk2BBtWytaUEZAkJeEkCt0eLw7M4aS5W15axV+5FDGvu7bUrBa+G9Z4azp5/nXHGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:20 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 40/55] media: rzg2l-cru: Add IRQ handler to OF data
Date: Wed, 20 Aug 2025 18:03:56 +0200
Message-ID: <20250820160413.801341-41-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f085abe-337a-44c8-aea6-08dde003806d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZJvF1WO6N2ust3gBmE4kkGtiMc1fXE+ERiltWOTVdeUc5eWaNSUfZhmztf2n?=
 =?us-ascii?Q?FNzX7CGttj6oh+jtQQ1pLIikjpuzF8UjBV5++CsA9DzS/sY3J1VnEI0QbbCr?=
 =?us-ascii?Q?l5gAYz4WlNynNPrxCwaPEWYDEDDxndi303lpsD+jXlnDAoNQHvb2bWpWWkOA?=
 =?us-ascii?Q?cnLRs6ytWFwIrUvKQPFnk0AE++6EXTewnugMX9tEK67PSGZdEjO4CXWjkxBG?=
 =?us-ascii?Q?uknloKQeP0pBBEPigWpiu//gq106MQgHwhHty79K+NNbqhYkBvABdO6Rc01o?=
 =?us-ascii?Q?605s+cG0OQmfzjAQcGG1/CUqZtjhBTUuwmyPj/Z98oSV1NgRgyyXAtAW6rXp?=
 =?us-ascii?Q?W4ZrOU1dYK4weRm+2BKPYOLFSL/PokukHjyTmM1vRhpVLJPh5whGc9WEjXbJ?=
 =?us-ascii?Q?2hdmizGLpEyhxA0ASRGLm2NozaXIi+f9gt+P7VeO10Ya+FXoi3tOcmmDWnCh?=
 =?us-ascii?Q?y3AfCOcNShokkBtyRDSdjidpev97VgcVricA3fPCVqBSvRJkY3eXilumBItF?=
 =?us-ascii?Q?HOwgeRaQBX/bn+C1J8vR4kMkEZG2AjPvygYyttyAw2qBp0F9NbB7GaZ3RI68?=
 =?us-ascii?Q?6a1UildH6w9wol5v2iJDEd+ytNPEhQv1wtnoSR8xGiqJZ4siKlpnKXIvqqtQ?=
 =?us-ascii?Q?kRrW4YSSeyRE34St133o9TiTODyk/T14d+xzgxcmxhl8PmydbxX6z63MYflM?=
 =?us-ascii?Q?2NdCeDOZjNBp5JfmHi9crzFuJblON8lxOJhPZBL631GNS48A2Ubhb9W68NI0?=
 =?us-ascii?Q?qKTqmRip+i1jaqCmkHOU990/zzAGpLhuZJ0I1xvVkC0SoleYbenc4bXJb4z+?=
 =?us-ascii?Q?zWccVMO/95Um9f8GZzW7Y0SiqCvXEq+ftA/P3XeHuA0w3aONpEI5QJmpjOgg?=
 =?us-ascii?Q?Nf4W9k31qqPTCuIUdEqRY/3+kjDc7P3Am7ywAH/gkbxnQagp+l1pFBM9B7Ys?=
 =?us-ascii?Q?JDwep3xFC/c93TrVfLNkKYk+slkKYkaccFJiqK4Rp3iZQGrbPBP8MVl1Xogi?=
 =?us-ascii?Q?yo1zqWTMIWOWiaWZXlo+EA2Uov72xrEFEVk6WmnapBzGepeSz/xZ2kE+YB5h?=
 =?us-ascii?Q?i9q8AXqCru0GdH1Pyky2ZjOk/nlNNRsAFpr383DAhQtx8+BdDZLozP4mGtLk?=
 =?us-ascii?Q?ZMyXaT9XUXIm1r5ex3Vwjwf/lnEFz0SjmV9qVG9rRVPPtY869VMkx8hjQ6/7?=
 =?us-ascii?Q?of5sitEAw8MPjfWyZbLJOnxrS5a62czgn6UaVJK30geSxup4sPULU5GZgArV?=
 =?us-ascii?Q?ayUfNCzk44f5hrn5nIEv34rJjEGAjmT/1zt4P+8fRNTU2yBWP9cLYEaxVSuw?=
 =?us-ascii?Q?jdf4msFPV6sPKHSiXMc23fWqDV6ZQ/fyoegV0Fl0oz4IREvgOZBp/sxP56c0?=
 =?us-ascii?Q?rAvsUS8pBvoy5jpRpv7vPqtaQnPGrSBxWJjX9qs56F2amUczbL2xn97bJFLO?=
 =?us-ascii?Q?j8GMaKJReTiliydmZb/4oEBgFcaqlZ4vzXXb4MW7D1ryQAx+xfWnV80BhOU4?=
 =?us-ascii?Q?7K0XykIVeEzHvKM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P7AsOWRLGhwYxVqrRukbENJxzmDl2PfKVgM5WeLMsTm5ZinoqmnLyh0BEsuc?=
 =?us-ascii?Q?4T36FXZWN29oNOOvupBXHnysCP12Nv/kVKXA0dX1NMxK4fowHsLpouEWVba7?=
 =?us-ascii?Q?DNQdmbK31OiVCAB2Sf41e+OQQjycga4cUSVIE57R00DbIuZTc8qhsqK26L9C?=
 =?us-ascii?Q?qmivCjEG9/MkggOTyaMx4LRiASks4SQh5k+Xc4IoU8g8GoPTHW4CwglLNy15?=
 =?us-ascii?Q?tlK3+0cZABI7TMrsxapCBcuvU+rUkvH9cIYRG/LGiEp9gtIM1a3eAC+zlNFk?=
 =?us-ascii?Q?TcLdff7u3WXhnL1c/Qt84zlQC9xPYmtrot6/Cm8iAE0AeuwitpU11r6Dhnp9?=
 =?us-ascii?Q?s8y2fauIrgV6QNuTQQXttktBmfEN4GPVPqTYqfLo0ADt+5b1WAmYEO1zdYum?=
 =?us-ascii?Q?h0F0U2qjdq1Bpy/6Fqfr+Ws6ZaCaywLBx/aEDtMaAohuRTVXsfrg4+EmfgYp?=
 =?us-ascii?Q?XFDYSSbfFjhf91CkwqrW4yzP2jq5HHDpxEhFu4qRGhW3+ZFOB7wGIeiahkCu?=
 =?us-ascii?Q?pzLq3kC7LlGVNoefCT4yhGyLB8koW8JZyLDtdwiDn5fRDUGFZE8N+VbiTcZF?=
 =?us-ascii?Q?Q+/AkLAnvBkSEn0Nn8tVB2kVNAq8aEGTdQ4i5HqptfRocWF1PmjNfW7XfQsV?=
 =?us-ascii?Q?6UytxevUvi2y+XiiEvIZfmH4yTliPinRjVxVLZfGD17of3oprPTsCSk4yeCC?=
 =?us-ascii?Q?qoe8ffE5+rhaI+mVY7vDT/gR2dMXnVcBkIeYSNT6Bv/JoSIdbPBG1hu2QImU?=
 =?us-ascii?Q?zwnmCZ+Q+6IMrYf9RyFX+xjbICO8vHNL3V8mtJpzjzXr+qHCe48LGbIJjgIk?=
 =?us-ascii?Q?8MmAmftgYSxV4itClCCikX/wXUb5WY3G75KQXZJ/C4ae38YHdTyyi3Mqff6A?=
 =?us-ascii?Q?9QY5LtG8Krr5OMBlG7aoS8ZluKY232ZGdPnzlsHRtBzibgcmQqaLW72SB3iI?=
 =?us-ascii?Q?juZIm9YPKuXwbZyiU8jNAQEQRqzMmRIk6uJjgB8zivSf9I21BnRDCN+6foAy?=
 =?us-ascii?Q?5uAEntsVBsPrPW9Gioy8dQGzdJXZx1EmLa2UApWzzA3GXcjPg84Nw3eo5HJ4?=
 =?us-ascii?Q?N7rQuSI++RvTDBbR3K9LoI0inK7l4/j1rKgh8lkxtoB6dIaPUDpjZ7SRRI4U?=
 =?us-ascii?Q?i1oFiWyW6w23bHdf7WvJo8kpksubTtJKGOEbBj7fs6h4cKYch6ITPXjFxqq5?=
 =?us-ascii?Q?38Uk/68qx8eiSa+5Gzoi+XOExE9PXiBSW9tTQcDiNh9Xzx/nBgwXHhzohCUy?=
 =?us-ascii?Q?UeZf6QRFmkHvxoEopeWgRm4niA/NHnneP4r3I/Q0CnTGKK/t+85QGMkCdLW0?=
 =?us-ascii?Q?CNDufJbl1u/0oi1wC6JB5eaqeNc0Up8pfhVfWW+ebqAF/oSFyedDBOZLEcyE?=
 =?us-ascii?Q?9TrfYX2Lx6mRr8uZz9Ut5WBlVTIbcnO9I+MXMoiGCOQTiFD9lx9GwbAMgt0k?=
 =?us-ascii?Q?SXqArTl+rFhA6M8jnlUrLcP92zjxmQMhuTFblE9Kxlx3J9g/N7dOOTpNYw0V?=
 =?us-ascii?Q?OYxKD0D3c+WOQg2awnTSQqOeHBq7RPP2AvwpHl3R5Vs+8dORjQZFoiExJeno?=
 =?us-ascii?Q?bRwbHWNRh22tAp8BPu2kr1z+YNiHxybfULdxJhsl6+L02J+kjizzwXtlQmUI?=
 =?us-ascii?Q?dMqZYBUgM0jb4wIgYlmxXDA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f085abe-337a-44c8-aea6-08dde003806d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:20.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdUgVbPkPMpOXT70roWXJcaJxCBTIM6mev5ryGbzkBtHk8bBk++maJTIxni47ESnTqUgxwSw34H6PLX9xNtRdSO4CRheLRh4QOW5TeJVBUWnrUWPSkqn0j+SEpsf2AkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19865

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2d9e3eb740b7d256d0ee53a6a242f0ffc60b0c9b upstream.

Add `irq_handler` to the `rzg2l_cru_info` structure and pass it as part of
the OF data. This prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which
require a different IRQ handler. Update the IRQ request code to use the
handler from the OF data.

Add `enable_interrupts` and `disable_interrupts` function pointers to the
`rzg2l_cru_info` structure and pass them as part of the OF data. This
prepares for supporting RZ/G3E and RZ/V2H(P) SoCs, which require different
interrupt configurations.

Implement `rzg2l_cru_enable_interrupts()` and
`rzg2l_cru_disable_interrupts()` functions and update the code to use them
instead of directly writing to interrupt registers.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-15-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   |  5 ++++-
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  8 ++++++++
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 19 ++++++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-core.c
index b9ab8c067b71..c3da7dbebd8d 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
@@ -276,7 +276,7 @@ static int rzg2l_cru_probe(struct platform_device *pdev=
)
 	if (irq < 0)
 		return irq;
=20
-	ret =3D devm_request_irq(dev, irq, rzg2l_cru_irq, 0,
+	ret =3D devm_request_irq(dev, irq, cru->info->irq_handler, 0,
 			       KBUILD_MODNAME, cru);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
@@ -359,6 +359,9 @@ static const struct rzg2l_cru_info rzgl2_cru_info =3D {
 	.max_height =3D 4095,
 	.image_conv =3D ICnMC,
 	.regs =3D rzg2l_cru_regs,
+	.irq_handler =3D rzg2l_cru_irq,
+	.enable_interrupts =3D rzg2l_cru_enable_interrupts,
+	.disable_interrupts =3D rzg2l_cru_disable_interrupts,
 };
=20
 static const struct of_device_id rzg2l_cru_of_id_table[] =3D {
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 07d1ed76bafd..2084766a658e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -34,6 +34,8 @@ enum rzg2l_csi2_pads {
 	RZG2L_CRU_IP_SOURCE,
 };
=20
+struct rzg2l_cru_dev;
+
 /**
  * enum rzg2l_cru_dma_state - DMA states
  * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
@@ -83,6 +85,9 @@ struct rzg2l_cru_info {
 	unsigned int max_height;
 	u16 image_conv;
 	const u16 *regs;
+	irqreturn_t (*irq_handler)(int irq, void *data);
+	void (*enable_interrupts)(struct rzg2l_cru_dev *cru);
+	void (*disable_interrupts)(struct rzg2l_cru_dev *cru);
 };
=20
 /**
@@ -177,4 +182,7 @@ const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_=
fmt(unsigned int code);
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_format_to_fmt(u32 format);
 const struct rzg2l_cru_ip_format *rzg2l_cru_ip_index_to_fmt(u32 index);
=20
+void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru);
+void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 3ad0e20425cb..54967bf5a850 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -300,8 +300,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_d=
ev *cru)
 	spin_lock_irqsave(&cru->qlock, flags);
=20
 	/* Disable and clear the interrupt */
-	rzg2l_cru_write(cru, CRUnIE, 0);
-	rzg2l_cru_write(cru, CRUnINTS, 0x001F0F0F);
+	cru->info->disable_interrupts(cru);
=20
 	/* Stop the operation of image conversion */
 	rzg2l_cru_write(cru, ICnEN, 0);
@@ -393,6 +392,17 @@ static int rzg2l_cru_get_virtual_channel(struct rzg2l_=
cru_dev *cru)
 	return fd.entry[0].bus.csi2.vc;
 }
=20
+void rzg2l_cru_enable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
+}
+
+void rzg2l_cru_disable_interrupts(struct rzg2l_cru_dev *cru)
+{
+	rzg2l_cru_write(cru, CRUnIE, 0);
+	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
+}
+
 int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 {
 	struct v4l2_mbus_framefmt *fmt =3D rzg2l_cru_ip_get_src_fmt(cru);
@@ -414,8 +424,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	rzg2l_cru_write(cru, CRUnRST, CRUnRST_VRESETN);
=20
 	/* Disable and clear the interrupt before using */
-	rzg2l_cru_write(cru, CRUnIE, 0);
-	rzg2l_cru_write(cru, CRUnINTS, 0x001f000f);
+	cru->info->disable_interrupts(cru);
=20
 	/* Initialize the AXI master */
 	rzg2l_cru_initialize_axi(cru);
@@ -428,7 +437,7 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_d=
ev *cru)
 	}
=20
 	/* Enable interrupt */
-	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
+	cru->info->enable_interrupts(cru);
=20
 	/* Enable image processing reception */
 	rzg2l_cru_write(cru, ICnEN, ICnEN_ICEN);
--=20
2.43.0


