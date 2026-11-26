Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.309.1795708162899912729
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UBDC5C23;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL3jbWMegGCFMvbC4+U/2hiOfivoaHXfWeCKE9mY6P1v2idrtg2QN2/c2DyTNYxE8rDKWjZyT7UsO5ZkyZ5sj8xhkToEyQW0esFySHAcpxF9cmpbhqg+DDCf8mT0ePI3fYj14bE+W+oryLJGeTARGTTyqUUnKMUBOoY6fm/7zWlYwmkIi+H5YzRhtqZ1FSHuvBbvdAi3ZPW1y8H+uHeC05FDMp0DZDP10g3EfRTQRGv7Y43LIwjZ5lpK8liKq1x9zyDSds/dDHhJzo0nLVjwuIFheqi3zKKEVx8xWb0N8MKd9hVRFBjYnBG8SYzT9Yf2ClaaXDsD84mtpLig0GMT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUFrNh6a/6B/QGCuJCqm42c/tpnrel+wJOKsXVBHskA=;
 b=DRFZHfMwxUXdmp51bZkhYzxanLNVX39oXHSRK5IocoppzmYtNTGCDgDMMB/3rpOx3JgBQnhFVXb3bwusvxQow6OT9piD8t6nn8h8vu82iizKASBpYqGCI6b+zOViGMzXAap990lkyOnzi0iRbM74kf1wv1b3IOZdl5JZhEEULZ/O3EufF+CUQcA1SosSh0oM0RqUpRuYQqsZqUsCi8t3k9aXERcc4QFbi8pD9gpLtLkKZtw1styi767fNqVhFejTeaMBfPZidE0y9KO9SZo1xWYi7l4IHUuNADLRjnwldnSyliiYjol2bHqvi8nqHOBsRAQbn/LTWzF0sCAxDk4wbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUFrNh6a/6B/QGCuJCqm42c/tpnrel+wJOKsXVBHskA=;
 b=UBDC5C23aW9G1qh3TfZVAFgtDK8m4fzzkQqVtOtrOfX8/m+6efH3xIGr8E89DdufexO6s+uWN/Qzv16SzW1ESD5tG6Zql7AAw0vfEeOf/v8tPSU32Y5ruwZqFc5gphosl/o+FCVKpQmOwam8EUYEfhwceOw+yhBLtA5jjbHOR0E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:17 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 24/27] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Thu, 26 Nov 2026 16:47:44 +0100
Message-ID: <20261126154747.3832917-25-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6d9e91f-cf61-4404-00bf-08df4bd4d3ac
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|260925022911599003|11063799006|260925021911599003|260925021311599003|56012099006|261022115727099003|261022105027099003|261009221227099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026130827099003|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021130227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Bl/9JVu7EuQjbkLmzFTkBndNvhu4eriQs/udotmV+7EFGsGZYKN/DnF+T+GCRUzV3uMQ/WCtL5cVjBw/no9QxcOa2HzZ0SBEomhYW5yV9NUxJKIy7TMB7VQZsSia3neyUTpc4Eu2HR6HOZtysAwWFeQel5Mt0d6BReeFRdGG1auuCAuVMcVFkJvMgIaDeCrnQlh99H3QURb1zqBJzog2ZXb0fWYpng5ZKRpbP5KfKJ2sKFKn6msdUgwzJQAcPb+RlPvSQE5jZelfni2Kgv/6TrnIufVCAbI3wuq200LQxRjthLSpyl+UdKNfUBYkHuFAJmbfnR/PPGsBEguRMdG07TIAXFQBzMMKYqAE0oxfGsuRPg5EX0wWKI/XAvW4IYOMhB+OlBzS1FW4ePplow2+BWw1zHiyXFFZOgrZIHx8hL2pEU+SKNo7NokedpCeh90k7laZPFR16ajygY0pUw9LNiN+1CvowCl0Wisskcpw/q4xzp9eEfWUTw314eFkiUkxqA4QLpNkBHO86IKheq8Sc33fYTcw0uPkiJCUVdQRA2y1uwSI0SlISlktRmbBuHsAJrghTIvl59iOSQoSSQ6B/Xe15cUvyyAsQ4cQorTo0Y5JAPotCdB9QA+be3dhqunx7FWbfw7DH00+HpJ0gQlhJ54bqkABwSnxVa7uqlAw5pg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(56012099006)(261022115727099003)(261022105027099003)(261009221227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026130827099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021130227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tUvmHkYzqXh+NszrvjT/RZiHBblfbT7vGxgXMKoM15dWF/kRP5r7Gbm60IYr?=
 =?us-ascii?Q?h2ffc+VQ6Z4Xcg/uvIWXAtAY1uzPtFzwFelepnKKgZdSAMuLuHRIlLT2Go+H?=
 =?us-ascii?Q?M4Oi2L56X1D8os/J2UF4rDUgE/SuNfYi13VkdKzuT3OAqh3OmZDNfpn3oxxP?=
 =?us-ascii?Q?sGIAdCALRHHsoNBJ+x2GJhApgHDiei2cK2TOOhT4iKLnwbXpqe/29Rw1ipPE?=
 =?us-ascii?Q?5WYCA8ZxkTDqtYbpkmJoHELavj9omgq6trZp9afX0UlzeZkP1yGseWE3Z8PI?=
 =?us-ascii?Q?CYgyoPPVupEyEqFoNj7VdhcY1n1+HRre3BOjsL6F0cgA4KCUH+BCddf8c5qi?=
 =?us-ascii?Q?TZwvfrkCfrJKxDqggNaovDf2BVYPz5bGAAivCYs1DttzYRFomhgqxCNg3v5K?=
 =?us-ascii?Q?dv4pj6Swe9S+H9BTN3fi8ljZWE/7suWZohTXVjsZ7nULHdU7+XDx7RNaI3Zo?=
 =?us-ascii?Q?zohRbQ7/IbMr4wFOryb3gOiFwmatVGfoAAI8ZKdLa+voOW/+fyIitzKZtFmQ?=
 =?us-ascii?Q?mTL6RuJHTnqNj/V8qjMDAA3MzsIqoLWAFYVHxTq+58pdzCnF51ub57P4Btb5?=
 =?us-ascii?Q?TXln0X89gYznwWY8hhM70aoAqR3Xd4VcLAw8k9NGsHIfQkAre+vAWySQDCTp?=
 =?us-ascii?Q?blPD4ao3B5hR1I3HRRr0t+8D5LLhRJbcIYuHFe5AuMVNUJkTDPqIty57L0bT?=
 =?us-ascii?Q?r1z8HgnLEy1sEIZLzMc7aveKeoDrKjq2mgX5HUct9wRFz2AvkO3fOtK+eW3S?=
 =?us-ascii?Q?1QtvHmZ8R1IGeYok3QxzQw5Nvnu17M+QKQB7lBSCY+XzS5OYZPVSA92ZaNRz?=
 =?us-ascii?Q?yfJ39dfzgmHTcB3OggTyMNRWjiYU9BXtUEkpLVY/sRYxmEdl23qujr9KQ4EB?=
 =?us-ascii?Q?KWa7kuypLYOgoL4E2dE2fH/y3APxvXE+eb2nGKrCACuoNNpYlv9jMtqqc4pM?=
 =?us-ascii?Q?9nmtxnveAJGqbpud/CVaL4pCSmYgGIRsw9K0loxqleZTFDbcAiN9p6d7KTu3?=
 =?us-ascii?Q?GqwnoZ/BykWtxQur8i52wSBK6oOv50HU9+ubOkU4PCB6Me1ianHJsk9Sm/Bq?=
 =?us-ascii?Q?BLvwN6/9IKf7CDY1aogo+csrXSdJMK21XAThOKS7OWr3Qbw6U4LBZNh53FSN?=
 =?us-ascii?Q?rXY7q+yPHl2BEZNelyrR6PxQTBXmmPJ/rKF9eDjvtGdB912hZgpK2cYK4SiG?=
 =?us-ascii?Q?r5zGvdCXg3x86KLLmlkWwElKFd2CehRRYyIH1sFDpVm0I8qLHk65kjnL8izu?=
 =?us-ascii?Q?bnM57eH32kMlfpO5JuW5azTpF9NN648KJyYoY8sl9b4Nw+0ZFbxKrEOkbNT2?=
 =?us-ascii?Q?eRL4uoc+8XYth+VbNDcnbOHwg66jR4Lm7/KCFioDAB9gtxk73cw4V2oYnr8f?=
 =?us-ascii?Q?hkcEF+wUdMISLnaa3zAI+CR47VpsehjVSQyygq7QcaC7rDVNthPbJ2SM1o1P?=
 =?us-ascii?Q?fM7feoCDkuPKtQbGVzXk1lpZbpGAtolsZQgVznjFxdN0QgepFQPycvQNpRg0?=
 =?us-ascii?Q?zwp8Egzj0aQCSdfM9D5JJcoPMq8XdsAfVfIrDDSIqaavFdg7I+zWotfW/wnp?=
 =?us-ascii?Q?A370PzL5MxpAxdfx5cPGOkUQtEbm/xMr6ti3+0ussUpgz7AjrLL3w4GJ/amB?=
 =?us-ascii?Q?ZHpgE7a9w6OgwerUnqunT/DwFexAUs1ShXdPGdGOyySLwv4uRSbtREU6FBl9?=
 =?us-ascii?Q?UmrX+zSLlqNJES6A1ioVLOjSvztCOYrNocP4nuaK2XXfDtgkTlc6iDuoMyYl?=
 =?us-ascii?Q?FWP6vTIb6tychgCbsoa2SukIlrw0/8eiIJ4/Xf6cxtr4qNWs64ja?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d9e91f-cf61-4404-00bf-08df4bd4d3ac
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:16.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsZvYo97dBRp++wk2e6f86xQP/VK75x3dP7EzD/pVUGHJeiUPsvZwbfi6113wLYRfmu2rwFyL3WpL4k3nNW+eGaNyfa40AG37AFD/lTZIWOpEQPeZdje1RLpxIImhHoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25174
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7c27a4d54d48d0774518390e4ce6cf3309aac141 upstream.

Protect the driver exposed APIs with runtime PM suspend/resume calls
before accessing HW registers. As the current driver leaves runtime PM
enabled in probe, the purpose of the changes in this patch is to avoid
accessing HW registers after a failed system suspend leaves the runtime
PM state of the device improperly reinitialized.

In that case, the driver remains bound to the device, the APIs are still
exposed, and any access to HW registers without runtime resuming the
device may lead to synchronous aborts.

To avoid leaking resources in case of runtime PM failures, save the error
code returned by PM_RUNTIME_ACQUIRE_ERR() in rz_dmac_terminate_all() and
return it only at the end of the function to allow the cleanup code to
run. A similar approach is used in rz_dmac_free_chan_resources().

Because some exposed APIs (e.g. ->device_terminate_all()) may be called
from atomic context according to the documentation, mark the DMA device as
pm_runtime_irq_safe().

This patch prepares the driver for suspend-to-RAM support.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-15-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: Replaced PM_RUNTIME_ACQUIRE_IF_ENABLED()/PM_RUNTIME_ACQUIRE_ERR()
 with the equivalent open-coded pm_runtime_resume_and_get()/
 pm_runtime_put(), as the DEFINE_GUARD_COND()/ACQUIRE()/ACQUIRE_ERR()
 infrastructure they rely on is not present in 6.1.y.
 Converted the guard(spinlock_irqsave) in rz_dmac_device_pause()/
 rz_dmac_device_resume() to explicit scoped_guard() section to preserve
 the same release order (unlock before pm_runtime_put())]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 86 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 7b79795a54d9..90a8625f84b3 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -548,12 +548,21 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=3D%d\n!",
+			dma_chan_name(chan), ret);
+	}
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
-	rz_dmac_disable_hw(channel);
+	/*  Skip touching HW if RPM resume failed. Let the cleanup do its jobs. *=
/
+	if (!ret)
+		rz_dmac_disable_hw(channel);
=20
 	if (channel->mid_rid >=3D 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -577,6 +586,9 @@ static void rz_dmac_free_chan_resources(struct dma_chan=
 *chan)
 	INIT_LIST_HEAD(&channel->ld_free);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	if (!ret)
+		pm_runtime_put(dmac->dev);
 }
=20
 static struct dma_async_tx_descriptor *
@@ -696,11 +708,21 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_ad=
dr_t buf_addr,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	unsigned long flags;
 	LIST_HEAD(head);
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=3D%d\n!",
+			dma_chan_name(chan), ret);
+	}
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
-	rz_dmac_disable_hw(channel);
+	/* Don't return if RPM failed. Let the cleanup do its jobs. */
+	if (!ret)
+		rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	if (channel->desc) {
@@ -715,13 +737,22 @@ static int rz_dmac_terminate_all(struct dma_chan *cha=
n)
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
=20
-	return 0;
+	if (!ret)
+		pm_runtime_put(dmac->dev);
+
+	return ret;
 }
=20
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	unsigned long flags;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
@@ -733,6 +764,8 @@ static void rz_dmac_issue_pending(struct dma_chan *chan=
)
 		rz_dmac_xfer_desc(channel);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	pm_runtime_put(dmac->dev);
 }
=20
 static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
@@ -806,12 +839,18 @@ static void rz_dmac_device_synchronize(struct dma_cha=
n *chan)
=20
 	vchan_synchronize(&channel->vc);
=20
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
+
 	ret =3D read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN)=
,
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
=20
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
+
+	pm_runtime_put(dmac->dev);
 }
=20
 static struct rz_lmdesc *
@@ -865,6 +904,7 @@ static int rz_dmac_chan_get_residue(struct device *dev,=
 struct rz_dmac_chan *cha
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
+	int ret;
=20
 	vd =3D vchan_find_desc(&channel->vc, cookie);
 	if (vd) {
@@ -883,6 +923,10 @@ static int rz_dmac_chan_get_residue(struct device *dev=
, struct rz_dmac_chan *cha
 		return 0;
 	}
=20
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * We need to read two registers. Make sure the hardware does not move
 	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
@@ -904,6 +948,8 @@ static int rz_dmac_chan_get_residue(struct device *dev,=
 struct rz_dmac_chan *cha
 	 */
 	*residue =3D crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, =
crla);
=20
+	pm_runtime_put(dev);
+
 	return 0;
 }
=20
@@ -964,10 +1010,21 @@ static int rz_dmac_device_pause_set(struct rz_dmac_c=
han *channel,
 static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	int ret;
=20
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		ret =3D rz_dmac_device_pause_set(channel,
+					       BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
+	}
+
+	pm_runtime_put(dmac->dev);
=20
-	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED))=
;
+	return ret;
 }
=20
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
@@ -993,13 +1050,23 @@ static int rz_dmac_device_resume_set(struct rz_dmac_=
chan *channel,
 static int rz_dmac_device_resume(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	int ret;
=20
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return ret;
=20
-	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
-		return 0;
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)) {
+			ret =3D rz_dmac_device_resume_set(channel,
+							BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
+		}
+	}
+
+	pm_runtime_put(dmac->dev);
=20
-	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED)=
);
+	return ret;
 }
=20
 /*
@@ -1273,6 +1340,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
=20
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
--=20
2.54.0

