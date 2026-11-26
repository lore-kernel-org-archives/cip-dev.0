Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.297.1795708146113469528
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=RR3xJKPL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huz9sCsNrfm+YuZFC+/t00VAvcOYQc1HxrqU1P9KKw0zoZMbrXInFGAEpeXkDiXPqbQfYsnA+sTOI/QF+7TACXc0t3/LOhiFdkZYomEXNgtzLkWjgfhDv92rVx48uKokBnkH1bl+MFbwYM9wzWSNSUxDGPylLRu4eHagZR9B7lJDpK4dWEthbwLCT9pqGIgcZmp/cGoEH0OW6Pd7B0SyePvFMfDVW6/d1qOURRyPV0iQyNFzxkGJeiVmNFxh/1NlJMLJ/IhUjuoQyZnKlTIviUbKy62FrTW32hX9ewhH5WN4CDTW7xmZI5aIZS0DM4KA5Ma9Rz44z8WQuAqTE9GIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfCeM9Wwk27on7ClJRzn5pynOLDGRb9cRaxqDzOQAgE=;
 b=tsurO2VtOZx0vMCvZ8dDtaxUb87gtqb3NMpDs6PbdVdAiW/oAd9dasu/TP3qvYBBYPusKpCxop+9DDux8sdbCHt0KyHnnLwJG2+bYSNImZMznRSzJEi/6d1AzUD6O+kQLgJNxiIn0/kHXUlgbOsWrZvDV+l35IPO3y93ZjSVPzZyYQ1a1gjWf5NyYxunayPW0lGd9LRHvOAmftofYVreOL2++8L+TMpklhSKbMAqubdYmTYL2HDnCtxU9J8hCr5DMbNM5+1244jzu4xkHBbsmgZPC+2kMNbiQaYTawKUUkcV/jeMT37kxa/w7GXNnXERybX/WEig0HaVU9d0Yp8hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfCeM9Wwk27on7ClJRzn5pynOLDGRb9cRaxqDzOQAgE=;
 b=RR3xJKPLZHJnsCLpC2QcyDq1z8CfZYEtFvzx5yEyjGOdig5zIoEiaQ+YEHmjKm5zAg01EUOigi52Ojs+NoL1PdBnIgNcr4D594SaKx2dp4cscWEFUpxVa7moi2SpEVnBV5FRQZgyss1rMxiLAzzZ7pK/rMeDf57K5+Mv6Ta1Y2w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:06 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/27] dmaengine: sh: rz-dmac: Refactor pause/resume code
Date: Thu, 26 Nov 2026 16:47:40 +0100
Message-ID: <20261126154747.3832917-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af5fd81-7d3d-475b-5322-08df4bd4cd4d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: QCmToZx2bOnw3Y836YVfpK8/n3ZZhHD1cdCJFJaiWiwIDTHaOQUzU09VCoLIZfVqiEES437Jjub4RKsqh9ZiZ0OQsSHVvEH3TMIIE7dMbTFY57Cf/GrsfZi/JgvuTJNG0gk+o65eAo64g9klP7ZfyidHdRcpf2eH5nVXURg7H16z3jhTjiWcKAx8J2jtwsxUtCaHo03YNAFvfhUq/fnBSjwDfmhr4DOGzzfNvtRM5rmB9urimok2oMY0m3WDOEZ1uHmPp+27tnXGovA8TfAaKcb39sf7pj8bXjCIFzdyj3E44Gr0oUjMGdhW9nIdLx5dYRFlCbFY6rRmKy2r/GwV+8T0531RBQk0r3VsWMx7Ow9BioKPMxHhbgDZHrdzfZObMBe/12uhvEbtnmFgQVYUnJgPNX7UxZDh0VKAxHjhoTl4D7I5DJ4dmq/2FGJR4n8VnuYWAgrIt9kbFLxruIGvDRy3TI6Z3e80BM17vxXKAVcKVHbzYfNsx7E9y/qZS6qi2Uclaz1iSm+d26P8MAxJHte0WJOQm+xTskCs66vQ4/613ZorK7zBwp34sETBIA3FfEzhGzexwConRapgPM4lK6z3VIalkVHA/957iVbWSorzpvNvL6FSj+MaXTrMG6UuRZnZ9pXG930FfwEiGYEPsiAacd+D9r70rqgbYeVavzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wiAURx4jb4AQTlNLpLBh6Jl/ESsnsyqRG6Rn+wK64gtbKPEZoorK12hmjQKb?=
 =?us-ascii?Q?d6/UxUefEJJD6WmK+mAbMBuas4gT8XMQz0fqIFkcJ9WJM6O2kETEm/lLqJ9X?=
 =?us-ascii?Q?q+vNQL3bSJyzCHMktY9cq/lgBXTknI2IfplwTHTJkiiXnIkXOyNFVKG0nDV6?=
 =?us-ascii?Q?Nr3YXt83ob+7bnhLrv/D/nAVsL/q8yxMnshyz5DtL8YZ3pKKtAsmuEac5Q6c?=
 =?us-ascii?Q?rSAwaNdj0ZkWvwZBKjMpHKOrdPwFo509MDHXga41eHFJZ/SMzDAWecDyijKU?=
 =?us-ascii?Q?+ResAclOf7qwTj+iL9taY3hRbCCziuuOsMi9lQkLQzpS6mkLqALp932p4wd1?=
 =?us-ascii?Q?7i0+IdxXzoVjD06Z2YtlLkeFULT4SUnkRgHCnqb5tunphwvKqfUBJ9z7tDm4?=
 =?us-ascii?Q?P74sOBXFpW48j7aXyJBystzqkgm0+l73DeO8wBnsZtcVc7xTiRs0RrpFTrN3?=
 =?us-ascii?Q?TLLozh5VRJ2cJ3YgNgCOrnefiZlNoTc4VcdTl1idqHN3MkYC+B5kOqzYov39?=
 =?us-ascii?Q?msP4epjdxxzG+/osWw71obv3+2feantjK1T+3MFP3wnAn0NWRIdxazLf6Xjw?=
 =?us-ascii?Q?3y8HeNCTyG1LhFGuE0T+LX6JeKTp6JvGEsH0A0KPbbYgl0lffmQQbxfmx2Bi?=
 =?us-ascii?Q?OCr7+5Bd+Iai6wEqFsBtZwt/LyMb1jbczt2xTF4125tlJVP6RECo1ssZLvsb?=
 =?us-ascii?Q?4x1GrWdbO7YCajQ3nV74K9qd+A/ijB6llDJ2Tn1L0yvXLOmXkC+gu/LLSzgG?=
 =?us-ascii?Q?DZDM61sMz/ICE7XKj8y7RX9+TMaMgi8a2jEbCyjhORs6bhD1zWa2mbgfzna1?=
 =?us-ascii?Q?hNM+rnTwM3vIOwPero8E09rzVc8UJY6kHVk+AM/9NpaO4b8lkYGbzFoDRwrs?=
 =?us-ascii?Q?WE6rZb80QOdHUNQ6hLKw+5GBQFa10IhaL1MBg6Ody7k/wYjkGuecek/1F3kT?=
 =?us-ascii?Q?yZ5yPwAfaHx6FfQvsHS/MZLtemmJE/sgjhKXKKpFnZe7rGVJsxpfQHRecyfQ?=
 =?us-ascii?Q?PXZFay2JjM5MNX0eN+h97ld5Q6WKhtHXfqJfJlpQFImp9OzJBR+9cxzRU9DX?=
 =?us-ascii?Q?fydGqHX6G6JUNfEhGQ8AriCfQxkopavmYFxVJTRFL31nmRvYpNWKA774+emi?=
 =?us-ascii?Q?AmPsNZdPz0a4zazKr12f9RrwmnWjewDYPMY1HscE8pcjf001NJGFSgSoL9dV?=
 =?us-ascii?Q?YyPQtdJx0RmPk7f56TnXXLz/3ek7fWGatkEtJB/x3OHujOhDKHFz+hNYPU9M?=
 =?us-ascii?Q?OQAETwCSMod68kzBL5TkDjlpCwsD5E34Z12U1SMUonrCminLlNKmCkSoFj0b?=
 =?us-ascii?Q?1IYeI7Ui4Fzyit6cP2PSABxbewOIy+Ou9f8cn3ngkTq2Ny7QamIXzyki2Mp4?=
 =?us-ascii?Q?5gDFAC3OzH5VgvJhVva2pxqXXEphu0+bQ6wGbBm8q7q8+iTecoVat9k0D7ul?=
 =?us-ascii?Q?EqCJmJ5HiXhFLG0/uXh7yiAV7bTd8zv4xGN6W1cvAYlbztqOBaMhz3RyaPG/?=
 =?us-ascii?Q?omJ5DLDFi9UxtDqvUsDVEVzrmgmQeg/CDUe5zfKwY27uVThQMomsY1IBqOct?=
 =?us-ascii?Q?PbeG1gAbxLyCJ6wPFHKuzcdEMmMmn1PnijsvL9KfuVvD0Ht3hkZYTLgZQCWo?=
 =?us-ascii?Q?Uw/XOQhgGYj69oWKiWWlwjfde0CPGFYmcLPCK01W4xwyYKFyVxU1MZUF+po3?=
 =?us-ascii?Q?EGmlsQnQCeVh0SVMcyw5HPtRLp5MxdprsyhoG31QU83+847R12McnevYdbCa?=
 =?us-ascii?Q?ti2Z97rI6LnChzbni6/Cfkha3jgwniZ+eiXT+N2zlSQx4MDF15jR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af5fd81-7d3d-475b-5322-08df4bd4cd4d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:05.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA4FEUu/FGvn5VipGbV6RJOaohGYpJCurBMh03vfAV40LyLVKe+KC/eOjfwjkzrFDRD3CoCx5Qic+Kwg3Vx5A7VBqYFYGPQn2O4M9o3+tT51j7/YHo9CgMgg1fifIIXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25170
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
index e6eeb4fa55c4..f96d1ce45271 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -17,6 +17,7 @@
 #include <linux/iopoll.h>
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -62,6 +63,14 @@ struct rz_dmac_desc {
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
@@ -73,6 +82,8 @@ struct rz_dmac_chan {
 	dma_addr_t src_per_address;
 	dma_addr_t dst_per_address;
=20
+	unsigned long status;
+
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
@@ -490,6 +501,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan=
 *chan)
 		channel->mid_rid =3D -EINVAL;
 	}
=20
+	channel->status =3D 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
 	vchan_free_chan_resources(&channel->vc);
@@ -588,6 +601,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	}
=20
 	vchan_get_all_descriptors(&channel->vc, &head);
+
+	channel->status =3D 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
=20
@@ -794,35 +810,70 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
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

