Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.533.1795708624168601878
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:57:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=dal9FdXC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlqSBazRPiqkRzM6GK//tmWjTRMkry/IzMOlnXFf13k241vi1LeHnh7NN01Oe4geH9a5pXT6XmBygoAsJt6ufJlpc4D1QyTMJC1fan7aejweHBFmrdZewKBDLdlBoVOXKpehpcRh4G73x+UtJrMYNEOVMOmVXwts+W/ZqDmig48Z82lugMQIpfZ7du79CcjCQrJajc37lkMmn9PAY7F0ubJ/YndPsdXj0Bw134gIoFwPINn+Rv/3C25AlNNktlUN7RL8+cQ70q3whEKMMLk9/0dVUkNYa96E0jAB7IDkkhpzALjSoaDFfYJMETqWwqpVeVgtfENqJVNJmAvaTM9foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0s41NnWg5WMv+trAkhbOCu63K3GxsGL3bcRL0fVZIA=;
 b=MRYDayZEo2PdXd76VSLL8T2ehyJ6yIsnX0vAEKdJlk+WIV60jL02djrpwF/KoaoHka9tWUPpmvZlnWT9I/eWWBHEWFawsOeIcMf8xLUGgUibrn04m895Xkx6THFYmjYurxTX5B9NlpkGXKkOKfXiq+TQ7nlwN2mS+4mY/98X+zKC3pfKCrsDSBuUPdIM8wPAbJFcj17Wqzmqefpuqf49pYRQ+wFIyATfwMzH/iEQ85kBeYiAYCmALZEF0puxMWTO9J2cn2dNhhzp5x7CtUQE6iJ8+AOb0JhdQm4smtXJQ/WCWuorCJWD6F5UaEP71Ys1tww1NdVqjzSucNG6sZLksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0s41NnWg5WMv+trAkhbOCu63K3GxsGL3bcRL0fVZIA=;
 b=dal9FdXCgC39TVWQJQlR1CQtZhH+epG3DgCWByAgaQrW/jKy/Dfm835UZpbvCStOvjXj2RNJLYYJv/BPSaZ0CbQ3TJFLQqRrdKLzrMcvvTv7iXNs0Llr4lYxuc3FRLUoiBkTc6m77l7Zkoui7cF+qI1ohCceOlRVSaieeTfSoGw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:57:00 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:59 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 20/23] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Thu, 26 Nov 2026 16:55:42 +0100
Message-ID: <20261126155545.3834937-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd047a78-c0aa-4f7d-f3d3-08df4bd5e7a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|261009221227099003|18002099003|22082099003|260925022911599003|260925021311599003|260925021911599003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: lE4CoSNYXtQkfiQsc+IujLj5+zPPKlLP3X+TAoPNWKG1jlkssg3FeLMfSgfKWf7t24Zqgh2grD+nlq2xWgPifGi9yvjw4JMcFfs2+oSkkxOQaSBn0ruGpIlo/hy2DIDkNnrWQCif+2xPoZyRwQfkIOa+TgAV2L17KWAk+GAXB0Oh5/s/T8BJNTk0G+OEBOFjYmKGPP3Ry30+AfATNqXjtnXvTT1+6VVhvIpZGdSPMoeqR4yo6KIXGifdSeNxq2An8buTYevvvQocqU129a2blsvUF/qboQW98VtzBmnMg/1dRQkMR5i1yvIDvfexLiczjf1aCb2dwiC56o7ueMKGToVIReke9lDHG6ByrB65E2LtVPlVgEacOrJCxmfESBMpFeq23HKles/esMTuE+OTFTNe6aVXMadbRXj4TH2v9jBOpiXijUHXIxnsqC3XbXuR6eeu7hUjKefursdO+is8PYgv5LKLiGotXoAy8sUNInKutsKYW1H999l9H6VBLZmiBsGE1GvE1KTUlwGtZs24rw3N8S1VNfsuOzN58f7TfAkC7HXgwzALOxloDVPaPn5rsPC8mGRj4QbKDYVYdmjt6SFWJCRxE1yugrOY0erad5Z5vAqvpb1i9KrRYCDuioiW7ndil1PQ+IcyNMcHFl/G+eI3KA+FlU58e0B9Wg/Q194=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BDgEYE050F69lDYxd4Ohwzx2e4dl2m7EpmzKzvDK61TYgmfCY4FChcp/PXBp?=
 =?us-ascii?Q?6pA+DuoXdyAvL6roMb0B3qvHErJboFKIJnnZSnli9yoTkdKGqBvQdSIbpHct?=
 =?us-ascii?Q?8Ie4xa4x18WTKmvxmM+Z/rZUcYW9vpN8k4y7KzdYG0P6c7i50Mi6N4q+SCWI?=
 =?us-ascii?Q?cHxlrRidLtpJRDMnQ9/RGNP3rvsGLYdkZA9+9xwiC+8gAM7Fdw7FyYOrvmm3?=
 =?us-ascii?Q?1AOyJTsS3skTQQo9YpsxKjxwTuKaut9J5xNUwgd1f8La8XhKQ5hzGpgl6cU+?=
 =?us-ascii?Q?CRUYZymkEltiDUnV1Rjfk4NrE5D1RnIm3+KRHM8FVB9WeiEJ9Q+ZSacd+8jF?=
 =?us-ascii?Q?kG5a9Vj4fwY9kiOvmtsDnLTgKG/CpuUzVTWT25sgdvkgk0EmmI3RvgA0QSjh?=
 =?us-ascii?Q?USYaW4TOO4ljL5jgK2Pyr2YbWz5fYSuHIZ2qhvcHEDHgUxroW+KrDyMfN3GY?=
 =?us-ascii?Q?3GvfCXD1W8wlOj3wKBBk6egj1gJVLhFJCWYpDXN/biDQL5375NCyLQWXtTWd?=
 =?us-ascii?Q?XDOaOHZyT2jkP9Cb0z4i8q2gaMJpytL5RcRVNyB507QQ7u9n55GIl+DoLor0?=
 =?us-ascii?Q?4fOJA33AvtN0WyAXSMrzTOvx65YO3wLfTDxL1Fc7DXkMj5OS43duKC8tYcSP?=
 =?us-ascii?Q?ZwMZENLlunB80lPewGHZpP2ZmUgBsnOSAhCoTOPLJBFtKfXPI5AJc7tAqqMw?=
 =?us-ascii?Q?IQZCmk3B2NxZf/0jA7s6gdAJ4gYKgjSC+Gmht+hRExtpljeU7geqgYcY3Q3n?=
 =?us-ascii?Q?8m2G3HUdz47WqmX/DRAOTPew0MSYq19/QOKnQlYG6j9Ac6OgtT6eof8jO6Pq?=
 =?us-ascii?Q?l7Q6LRgT9l/srP0Ct91AP0DUzFmir00CTq7RWk9C3Pm3/mLNV+YZf+vhYKku?=
 =?us-ascii?Q?fcdW2kLXXLhQpm3vEUu7bPioRWwHqH+rZ4gazIxhm9vsiNlTUQv2h5zXds7R?=
 =?us-ascii?Q?/U1yJ6jW96AIjLoJGf8HlpoWbB/34M8CqgbSQGYpUEyYZN6lkBTW8Ocna0vR?=
 =?us-ascii?Q?/Gk3s62bFIoefn/kAlwFK0T9qDil0qtWHqPSEo4RCFWcubG3/4goH4OLpg/B?=
 =?us-ascii?Q?n2jRHurqwb0pC+dqiNZuSfFwYwnkYpA3DleX6lTiY9tEIkj34Es0QCnQv8hn?=
 =?us-ascii?Q?SawiMLKBMuTIpwLuL0jpyoviFyklJuDHlmr3AxlRk70dhpAf1A1YqKKA1cmD?=
 =?us-ascii?Q?RQpmVtfukotXrtcUDsuJ7y1SL/Hsr8KKRlBHsFdlHRBa4jbilRLeQ4r6vSH6?=
 =?us-ascii?Q?XGn5DtRWslY00Wlr2bSH5fyNuJb4N+iSyd2hEzONItHRdyhbEgmihSuU/pR1?=
 =?us-ascii?Q?igZmPr9qa1LV7qGfwCnkHZf6RSSfqP2mVc36PfOqp8aT/pDahBwkCA6gbtAp?=
 =?us-ascii?Q?Jn9UeHqVYT3/MekQkt88hFkMUaacsLoOB4fNj8A23F7gxNNDfK7CSZu5qqkR?=
 =?us-ascii?Q?INcRw/kkejZGwxCAQWh5MsZm6DYQmGyTW16t+jxnH6GGQIXfk41NUy1ZHePF?=
 =?us-ascii?Q?YaBvNHSB3McxEvQjyhosOe7Of0WTjwwIQw0j/G6E0OTplf3zMWVSM89jssnS?=
 =?us-ascii?Q?MPh1HDp+vV6Y8NsV3Eo+q5P8P2rB0gtEyrJ+7EjoT4LP2FxNMMtjmg2vbDIm?=
 =?us-ascii?Q?0P54nJYe6TIePnnNUzki0tdo59co0pvvQ35LbYvWeWAv+PVUH7Ooa6v/zjXu?=
 =?us-ascii?Q?ntfEnh37kX7wC9oIZJMAVR+CdQQIPe7kqKzhA1viHecOgbt+YnH3G44byEmQ?=
 =?us-ascii?Q?SCOMQdi9T35LxLeJgZo6PoVXlHr/FFFWTlunIODWrrjEJWEcQEuf?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd047a78-c0aa-4f7d-f3d3-08df4bd5e7a1
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:59.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bf4GKHhLgyrXrvRAPyhE1Kwgcz4Oa89WnkLOQLDsuqef/3JRc0GL2jrboZP8KCoXwDJczqMKkXydcRM23cjqa//3pmKZzde8WYcbWbuiOtyqMV0B0GSv5xfEf0A+QfJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25211
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
 infrastructure they rely on is not present in linux-6.12.y-cip.
 Converted the guard(spinlock_irqsave) in rz_dmac_device_pause()/
 rz_dmac_device_resume() to explicit scoped_guard() section to preserve
 the same release order (unlock before pm_runtime_put())]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 86 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3d3ba95a14a4..4e8103765e68 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -549,12 +549,21 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
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
@@ -578,6 +587,9 @@ static void rz_dmac_free_chan_resources(struct dma_chan=
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
@@ -697,11 +709,21 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_ad=
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
@@ -716,13 +738,22 @@ static int rz_dmac_terminate_all(struct dma_chan *cha=
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
@@ -734,6 +765,8 @@ static void rz_dmac_issue_pending(struct dma_chan *chan=
)
 		rz_dmac_xfer_desc(channel);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	pm_runtime_put(dmac->dev);
 }
=20
 static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
@@ -807,12 +840,18 @@ static void rz_dmac_device_synchronize(struct dma_cha=
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
@@ -866,6 +905,7 @@ static int rz_dmac_chan_get_residue(struct device *dev,=
 struct rz_dmac_chan *cha
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
+	int ret;
=20
 	vd =3D vchan_find_desc(&channel->vc, cookie);
 	if (vd) {
@@ -884,6 +924,10 @@ static int rz_dmac_chan_get_residue(struct device *dev=
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
@@ -905,6 +949,8 @@ static int rz_dmac_chan_get_residue(struct device *dev,=
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
@@ -965,10 +1011,21 @@ static int rz_dmac_device_pause_set(struct rz_dmac_c=
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
@@ -994,13 +1051,23 @@ static int rz_dmac_device_resume_set(struct rz_dmac_=
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
@@ -1274,6 +1341,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
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

