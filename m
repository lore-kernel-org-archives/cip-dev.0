Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.525.1795708611153963115
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L1yEGm3F;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffYrWe6StbwBdIsblzvQXzI2uc75mP40Zah2GjsnM1fpcq6N8YkUGMymC1OCFLGhARbrPoOL2yvkb1CRJJ8vIFqz39C3AlPS+dBCC+u13Uu2JMTMnvaAM5PcvFVEnWQIjUBIPKxFRir2I101xydg/QcQl05nGRbV0gLYjG2bkoX1JDwWPww1iEifDp7P1HxtLdp68NR07Y9TH+9efhwFWVaz0ZQViyOoZT6yF7R6G/papwLgLmk7QOcAfWs8WI12MntvMkfvmB0eqmXvk/dbPmy3W0opYIhYcYuz6FnZWn5p44Cz3Zr2aCS16PlooGQHTajFYnce3q0LxXtLQbn/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYkLBupV69Inp1e/naqd22aDiw257xBl/RIn03wqMIs=;
 b=Q0hpRhz7p5nczx04dQOcVV0Meu9MwqYDd6QTomtgAX+Nb8Ao6DDCpqy19/v9R9HzUPCfoWl7IiQxSngS/ul0YuERCViPGl1dcn6625rdDF05etl+n62iL+a99alHWkOj8Er/wMXD02Un488O4yI8K5RBziuCtJcuEdWh9QUpZtZe05fOHNAOymjWf4xoEEIs60i2/nTloUVB0QSetlOGXokdK3+YUF0qDsbS6ZNi54wDjspcauw/QlgRo+sybFUCLorD7zozqAlSK/ecgT/oPCAwKaWHHaLl0VikxOAYtBJzB09DRKpn0e4icmSJsLWuBXF6lYhsGe0Gmsxhx6WapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYkLBupV69Inp1e/naqd22aDiw257xBl/RIn03wqMIs=;
 b=L1yEGm3F78QZnZ0dCdnlIzDeKi7PXkSRl5nGMWhZ4uwlwB4JVngdhTtfkUb4HEROaZhTkn4KkxRdEtwSX0VCH2o0BLXnJbDzv3TwijuRIcyEFaG+aH2p+mvSl46ycRPWLCDMwy4/D2WLCMlo9SYB1mKe+1OGXJv5pQSXoHlEdV0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:49 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/23] dmaengine: sh: rz-dmac: Refactor pause/resume code
Date: Thu, 26 Nov 2026 16:55:38 +0100
Message-ID: <20261126155545.3834937-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3b64d7-ff01-43a1-2fb2-08df4bd5e133
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: noQr5NMhb/EfKtzf5BJ9oMkxHXh5CGkKM+TSg5s4pK7CMUDcoFqNPIFZp4yW7UWcfVWtZZOxzvFmVWC2WrcQZp/gsPX7yL5nHXzyemu9r5/dCkA+LC2BTudQQsC2HoDjzsQAgsv0+UTEsiL5nO8SBjFcvEiSkcffjqLyIvO+cqzRXpTOmYjPH99WgcqvnE4dNKe7gr5C97YPrMW4/xkWBjmDOoh9qMPRgTQoc8g0mnQOEhIzEulJp/BMmkpCCznEvZQIUvqiSpoD7DBLR+lAk8YRaV83/sVoEk5NLTkFUNYr4b76Q4Kd0Hqv7/hPyOMok+soq9MLlNDwQ+xe/V6RP8R7FOCiVaOVwHHEi+dNDrvTfTrfb07mPPZI3B+DQcJ7+5iluANcIv+0Xx+2CJBo4U9XO7XOYR8MNgEXds0RGxTDRFsreJljlUCMpYxHAPWZA4XtbEScGTmypi276F/byK6vYIJkr0tq8gs26Ea/5y3ErJPl3CK8mRiDH1TMZ/vx9V54C75y22ffQ51i3ScyOwIPyAm04eSf6gKjsr4jFVNTly3XHNlLmFIRuQOAlGoF/UrlnmhbgpCNqkBE4fiRH+Z9QKDXBgoE49sws73j3VBRAJhK4XoSq/iZdpRHSgk4eGO15GujrUEDyVsgcysmp12zVZp+AbtCKWgTm+RCwnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSubzRp2U/8q6Cr+/9btdnL0v4wHxh/lFWcM66rvu8kNq1fDx6dOuSn/UjwB?=
 =?us-ascii?Q?5NNzw5Av11rwra5f7xKot7Svk9YAwwtvK8Y6z+N7Oe4RIfqyA74eUG0H8vYI?=
 =?us-ascii?Q?ppkXfuD6lz6iNTHprI9eqI/cAQiUTvbc5Sx+PYB/YSIupohOF5cO2F1lXEir?=
 =?us-ascii?Q?pymMgKS4s5YLv/yP0u2ToNfsk5rJnhJqCDTpezRaSWfPtnkzmXSGNAIDCFkl?=
 =?us-ascii?Q?rx78dOdaEw1kXY0YvaJoxZ8nXQCJME88xqGLe8WD9+9fl+mcs5yw4YYqR8dq?=
 =?us-ascii?Q?MVBHGShKZNaPCKTPT5BOBiG+HNoKsFt7p8RDOAniFjbfP6rutQUPnqdzkLKb?=
 =?us-ascii?Q?cT6enWnX33GBXkain0mQ+k6U3liTyiterxaPUghhEY5KQdyb+Nv65oMUZMTr?=
 =?us-ascii?Q?L73bxLsKuuLfpCvpSwb4UoLd7lbKflMfNmeQL84vfyYLW5xpBiAYBgASTIur?=
 =?us-ascii?Q?OEiBnZyof0yxDgOXYqFhUSe+yqMYR+7QCEZtI/+72E9YoXrmUAjLpIK8CbxA?=
 =?us-ascii?Q?inYIwrSK2LJUdCe1kgaZWG076GMo5LAH0gvb/VSUueHXiBIzQyqxhCCi1WA+?=
 =?us-ascii?Q?nf5RmCzbwEee5qhbdE4eXTpM5HC/43b+NGpTNfNL9Otbuo8/InQ0D1CQDZD2?=
 =?us-ascii?Q?VFfjV8T3vn0s0lEOCjieaAOP94QUzSdYoKgDMCGwEBcXZfR0AMvGzpcaDE9u?=
 =?us-ascii?Q?vDgloDBMlT8VzQi3KuwqIiEdbtv0jqT+j53KdBWWLbKuclkiYCJY8IrIaqeA?=
 =?us-ascii?Q?0IQLbppscABZ0+cY7f8efbz0mK60SMe1icxMCbnWdmOokjgHBQgWHwGRmvVO?=
 =?us-ascii?Q?GOjzW5h8JT66z2KKtycSgtOVtG88O/g+NqhzNQ9oBEvjZPc7lFkQOJxDwLzt?=
 =?us-ascii?Q?TA6Pllye95cKF6FHbSi9OTrsolod9JEd7/kW39kGjYM2Yw885/3Wkif49Hsi?=
 =?us-ascii?Q?+TXCTJ0K59bBR31e277TYNF/PyBU1eoS1hgTK9skQg0+DbO3QJVg1eJCwg/q?=
 =?us-ascii?Q?vY6VWsXESFvA/i0OW5GdxfUT1SH0RDO1JZww7yFGUjNtekAri4tksjvwvGZq?=
 =?us-ascii?Q?cMPyyht5cuDSVXYZSne3kDE4VQoRgUKko57D1s2z51+KJwYjkNJAcNh5eAcc?=
 =?us-ascii?Q?cUGEGELDdpqnSD0mkkAn8d8p3b1vNH6SIxAaO3d+S5udJOyxY40eS7hhx24p?=
 =?us-ascii?Q?2EzpT9TfYbE/E6Nl7FnQPwMTkrLMoTJAIkdVqXeFTyRCyHP+ocGmcLhWp10N?=
 =?us-ascii?Q?KU58sOMFwRoqyYUH+xP8fmWD75J7LroXaJfi8fue5HAjwyM/kwyRgyMp/yAK?=
 =?us-ascii?Q?MW5lyXC8rAIkKEskrZBPwX6QugfszaiwuiLW0YW5oWhuch4jcXpbQOaMhA3V?=
 =?us-ascii?Q?OyLL4uWZT/OliENadBueN+AzKq4WLN2tdcEr5T5LXAOGgDIrooU4bK3o1yto?=
 =?us-ascii?Q?119BnX7WDTNhPtPcifT+iXMJlL27DwfwkLDEizK2IBgCbQlRoYM30SgA5ZSh?=
 =?us-ascii?Q?Va3jY33OsXv4MbrXRzAr+08aLVBADC5wasdJlqpnC726lG3zJo5Tk45Dul1R?=
 =?us-ascii?Q?Of69GB5r8Q/ooZzlacDsaBhDaR0BNFvsgKeX8LfJixK6f4RysDQkaG5GguzJ?=
 =?us-ascii?Q?TJkdFKT7ILvQRT/s42nRWRCFlQ8/3JUfcwBKh9xcFpa5f6AMVLrBdf/HIjOE?=
 =?us-ascii?Q?hss0HpGQBTE4C+8bi3CQYlgkuR9p0up/7haoSYXXUmHErtL1zqLJNRt7/Ac/?=
 =?us-ascii?Q?W7FaARCEyM0NQaYK0ZoCSHl2dppRJHelcqy2uailjHvqmlT25/sm?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3b64d7-ff01-43a1-2fb2-08df4bd5e133
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:49.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnt/YmCu+IR3HPwkrafHkuX5IoXv07KSnsKYvV9aOn4HxRvltZvqNfbctCI2DQ+mlRzxIcJhtZWFXgOCxD3daM6IvNRjXzD4N0TXhVp6q8JHAW2bt26hGqpOsTGByXtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25207
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dc86e47ca9b1021e258c366a5a9aa15d71c814a5 upstream.

Subsequent patches will add suspend/resume and cyclic DMA support to the
rz-dmac driver. This support needs to work on SoCs where power to most
components (including DMA) is turned off during system suspend. For this,
some channels (for example cyclic ones) may need to be paused and resumed
manually by the DMA driver during system suspend/resume.

Refactor the pause/resume support so the same code can be reused in the
system suspend/resume path.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-11-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 73 ++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index bf04092969e9..54f59462b969 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -18,6 +18,7 @@
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqchip/irq-renesas-rzt2h.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -63,6 +64,14 @@ struct rz_dmac_desc {
=20
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
=20
+/**
+ * enum rz_dmac_chan_status: RZ DMAC channel status
+ * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callba=
cks
+ */
+enum rz_dmac_chan_status {
+	RZ_DMAC_CHAN_STATUS_PAUSED,
+};
+
 struct rz_dmac_chan {
 	struct virt_dma_chan vc;
 	void __iomem *ch_base;
@@ -74,6 +83,8 @@ struct rz_dmac_chan {
 	dma_addr_t src_per_address;
 	dma_addr_t dst_per_address;
=20
+	unsigned long status;
+
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
@@ -491,6 +502,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan=
 *chan)
 		channel->mid_rid =3D -EINVAL;
 	}
=20
+	channel->status =3D 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
 	vchan_free_chan_resources(&channel->vc);
@@ -589,6 +602,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	}
=20
 	vchan_get_all_descriptors(&channel->vc, &head);
+
+	channel->status =3D 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
=20
@@ -795,35 +811,70 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	return status;
 }
=20
-static int rz_dmac_device_pause(struct dma_chan *chan)
+static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
+				    unsigned long set_bitmask)
 {
-	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	int ret =3D 0;
 	u32 val;
=20
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	lockdep_assert_held(&channel->vc.lock);
=20
 	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
=20
+	if (rz_dmac_chan_is_paused(channel))
+		goto set_bit;
+
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       (val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+
+set_bit:
+	channel->status |=3D set_bitmask;
+
+	return ret;
 }
=20
-static int rz_dmac_device_resume(struct dma_chan *chan)
+static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
-	u32 val;
=20
 	guard(spinlock_irqsave)(&channel->vc.lock);
=20
+	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED))=
;
+}
+
+static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
+				     unsigned long clear_bitmask)
+{
+	int ret =3D 0;
+	u32 val;
+
+	lockdep_assert_held(&channel->vc.lock);
+
 	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
=20
 	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					!(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       !(val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+
+	channel->status &=3D ~clear_bitmask;
+
+	return ret;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
+		return 0;
+
+	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED)=
);
 }
=20
 /*
--=20
2.54.0

