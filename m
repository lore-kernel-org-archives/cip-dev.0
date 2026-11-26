Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.533.1795708624168601878
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:57:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aNbgd80N;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCw6ixZt3IdWjxTzFPBIHm1kUrjmWOKcUmIQDUVWzXJR67ADt/aEhmG2oN4C+LBat0W9l9Ci/DQIBB58v1pvY8BymZNeocL7VUO11+OWaaoEV7jCd+uvK9F2k/wT4NsDnGgbrsDiFajxq6FxTaByARmtaZZ+Yus55tKbNwz9520hoBsE/AEr8MZJ+2vr/3eN0SDW7Icg8dBVSRbY6/uu4Oq2GGg4jUARAQj/6ayZlqa9ju82Fuk5n5o06SEPss9Cog0M5VZ/hmKw0PKCQGZgNEy0qeldn5xXV0A+ydgzrC+INXIfVYzGLSupijK3jvn27bQOEUW6ayWPkOueQdOFrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msKsmvWZMru4Map4b2y/luoGlRr7Ztt2fliOcJxU/Y8=;
 b=Uwm4QFKDJPFsDgETpmwajdFVwV4kRSbcAOzRwvSQwF6MtmSsQx+tyfwdryCv0c2JFur1Hz4IwSbvT7vFod0vTmLLVCXyec7xu3VB4BE9Jhj0+oLARrHWf9QAIuBz1DIt65yevI0WIJEvjzUyiazdBpVGLFp4Zs84+qiFkln4qZ8vliClA2ySEMVwwGMi8pJOi+PBlsWYBUGBbe7p2IKQB0s6dKcVoFRMRIwpksoATrR9EQO0rGxCh+iCukRPy/Kq7YCyPEzaRSJM5lOthfUijkLbjEsUvJPTeIBXzL8a8yyrZx49X9+66RoSHh7WuFW8oQ0hngLRaamcWqMhQ9RRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msKsmvWZMru4Map4b2y/luoGlRr7Ztt2fliOcJxU/Y8=;
 b=aNbgd80NXO2nGcuNfDdB+yba46CpbGjPQUhC3aWF0G+DVfQpAShbLgvyAOPkRjjKs1VczFX5r5xjzJmHrOtf8sJ1kY1MM/jF6RX2ibncrkW4KvMEU5/sFIDKkoUGRoFpc+ASQFCc5E3COqwpMv4hNZgYwR6vBmR3clZL2XqFLnE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:57:02 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:57:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 21/23] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Thu, 26 Nov 2026 16:55:43 +0100
Message-ID: <20261126155545.3834937-22-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59f93212-6a08-4ecb-d5e3-08df4bd5e942
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: Y+sAps9gjnoCu6frxjRar/bUPi34BQ53OYJBjCZmnDSTdGBjIgFfj6HaOJhX2rwtxvb9kBrQKvzkDBTI3pAXfh6Gu+TQG4WdjCtigLNr5HkJ9XL0+kLnxp6sr2oVW5Ag1aWFONh9MgTH0llZQmvKFfLlAlCYtDoximPmSWr+W5T4eiVX99A4m8AtlLl6tV3t1vdy+1osQe7h+gzububE+7S/2PVe5S195iXCfWL0HwCW9v488arDcW7Ca1FMnzg8skjytqU3SGp/ACFtqOhOCvG6xY7uapiJZrag2QPzVU6GizOufT4RoK3wfjnV7u911LcIKFJF5L4WhvI4Mh2ktcU1nJ9bUd632SgFoPRm19lSnycm0mS0Svz9fG1ojj8LIIKjXY0WCyAvo2iaR0l7P75vbI1uKhhkWkrYRD+BHXx5KXzaGus1l2l1D7jb/WVdnnGaYeP9oXaviz2tlP+eDcMOcelX1js5uWFVWMa7GCjKN0ABCr/tFTqSXkEKG9iWbQWzALG/fQHYxRMoJd62PMC7SB2Jn7HFhZbsXZ5AEfAi5FHbWoK/Ef8TeXlpjUXaZ0RElYCGfUcJyQNerfGCoDvITiPh3AOrqb0Et39QU066WsRea6+lPlbFW453+qcr3eWtGB7JDQT8BAQ0901XOg8vixqIPMFTGCnl6JbuAT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1b+GXbnkAgcIVQ0CWbvT+AW8ubbPQmAFtErFPyLZ6BR0SOMNcEcLfGTDiSp?=
 =?us-ascii?Q?6xDSYAJn063oBTAbICanFJqZADvRYOIna/YCxAYHqJyEP80cYzK977KZIIFN?=
 =?us-ascii?Q?Tpg9SJWdKQDkv731Jhf1wsoP7E5lXwKB/SANm6DMA/HUIcItB44V8ke9p8/1?=
 =?us-ascii?Q?quNT4hBDtzp51H3BgEq4BVaX5KsB8WwkVzWFaOwNVtyP0Ce0sjOTisvLRa8l?=
 =?us-ascii?Q?Ns8/A0gpgcF5/EHRYoq5MDfAdNyXGITkR1v2F/PQK0MID+KsDCAq5cBbxHqn?=
 =?us-ascii?Q?OiAc3TQnfsOGyKxfJ44NZE09sCORSmlaQXsmShMTSZUp5pvrnK/HMTQfgjgj?=
 =?us-ascii?Q?W47zixPPOfJHWqs/Y4iS00mEQag+XnpaG3KRwJpNChz7CwW1YZV9xFygVry0?=
 =?us-ascii?Q?blieS6mpwGMUuAPfxTjlRk9MEI5CCF/OVY201B+LpHZTim8MQadTLZLAxT/L?=
 =?us-ascii?Q?npKhgmrb06l8AYUsWfe727r0dZ1akQmdOlW6/VkMB6dt4jWxHQ9Ifxs0ns3o?=
 =?us-ascii?Q?I909RVE1Mo9Wmyav1iOr7cMgzYrPnOaYZewAxBsPJEu/tgeNwrkKy78Gv+3C?=
 =?us-ascii?Q?r67BBZbLm4hrZoI8kE7mZln6erPgSnQZHZVDHJ6+UWuktiSGMUE3oNhBXafj?=
 =?us-ascii?Q?odAKPsBtWnUcoYHF+uD2Y82IruQ7vR6x8jztPisdbdDazVEnH8uWcKFWABSW?=
 =?us-ascii?Q?cMtUs/tULr7a8QnhtEDPDb9QpEAookV5WzUsxE1R/npR9p8JxPsweTfXr3ox?=
 =?us-ascii?Q?PD+nwpoQdcL2St3YvMb0potTsYsuAealminL9GiJL+rlmWM99QXUCNHr5tLm?=
 =?us-ascii?Q?IUtm07aSxwYWakRpUtbe01sL3KZZ0Nt+oa0o+STnhpAyni+t2XMOkQd3i/49?=
 =?us-ascii?Q?LDuIg1CdcRgi3HtrrBaoxMeCYThGOvNbkkyHHFMrBRX7okvsFfiKgY2LlZBA?=
 =?us-ascii?Q?LO1xEv31NPBFyZZ1Bxr3OgwQeDEYORyjND7XzrFXydk84Hi2WmgAFybcZhyv?=
 =?us-ascii?Q?NJ+53ZPU+R6EUtlKjtlZdJDmXaP6ZnwxDu2r7ZCEBnrfBQnbEe4N1mtjEvlJ?=
 =?us-ascii?Q?xf8caR/wLKrfRN/IXpJVlfKR6ZpsY2q9SvDyuXdvXEK0FTFUO/9OSWlhx+2N?=
 =?us-ascii?Q?Z7KXbh3VySczHXNMSRtB/fvIr/gL9ZSMBxgzZ/DJx9Iw8oRfch3uI+RprZpg?=
 =?us-ascii?Q?STOf67baimCcJJ5pG2ctbuUARjZM0kUm3bPSVlkWss/9QBN3dDnaycxse5hi?=
 =?us-ascii?Q?MDP2VYYBDaPHGfgwH/r1I6NrhQeqy5xNvN9nBHGF+HVnvzTz58pBj6BZxVwZ?=
 =?us-ascii?Q?3g0wGmFWeph3nxFrfSm50i0P5IKBCGmjWJdHL8b+0HP3ROzB8u1fvFKhUj/1?=
 =?us-ascii?Q?E/f4WAm9+j9ephfn6tuVmhbo7ieJdEAB1op3GEP3c8uV2ugi3pfTWMb02UVA?=
 =?us-ascii?Q?6KSacvYWmikcEH9EKiGynF3HKef2QNw86/n9Wn9o3q4HZ8sRcCabcOnyQ/zD?=
 =?us-ascii?Q?dFVaaDAe60sRvWSFG34X5F0J0sPA716XqjCvs3wlE2EhmmnLRXHPVfAgtdku?=
 =?us-ascii?Q?e64GgRFggNAI7Drg/2cDC/5bQR3fey7GF4jPGqHbAcpblDHGW7JIwody8xrw?=
 =?us-ascii?Q?rPBNyBsE2QWT1qheS4Kuy1FmoUPKUfo+8YLKQ3pQ4jIZE6bTjv6W2vS0vRgj?=
 =?us-ascii?Q?ANy5VlGEhMwgDhYmnvHBY+dusopgDhQtrRG1H6wBRuEUi+IwvBcNSE0YFb6X?=
 =?us-ascii?Q?3N+ytAFVdsejbG8n32wFXe9CMCGAzM9Sy+XmXYzniibQGUn5rfD5?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f93212-6a08-4ecb-d5e3-08df4bd5e942
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:57:02.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Peiv8kIW4E6JKsg7Oe+EnicPBbIMnhzE17YlKxLVH96k8O0sb58QPnADxL5Su90DW6rIwZWuu5GuWIWQEI9/aDUL9jG94/UE7HnUlaeexasVwe7U+yRMukt/2tISiTCC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25212
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c13ce43e70719dead7009e7e708971ba1c447568 upstream.

The Renesas RZ/G3S SoC supports a power saving mode in which power to most
of the SoC components is turned off, including the DMA IP. Add suspend to
RAM support to save and restore the DMA IP registers.

Cyclic DMA channels require special handling. Since they can be paused and
resumed during system suspend/resume, the driver restores additional
registers for these channels during the system resume phase. If a channel
was not explicitly paused during suspend, the driver ensures that it is
paused and resumed as part of the system suspend/resume flow.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-16-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: Replaced PM_RUNTIME_ACQUIRE_IF_ENABLED()/PM_RUNTIME_ACQUIRE_ERR()
 in rz_dmac_suspend_recover() with the equivalent open-coded
 pm_runtime_resume_and_get()/pm_runtime_put(), as the
 DEFINE_GUARD_COND()/ACQUIRE()/ACQUIRE_ERR() infrastructure they
 rely on is not present in linux-6.12.y-cip]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 181 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 4e8103765e68..22b42b7539eb 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -69,10 +69,12 @@ struct rz_dmac_desc {
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callba=
cks
  * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
+ * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through driver =
internal logic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
 	RZ_DMAC_CHAN_STATUS_CYCLIC,
+	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
 };
=20
 struct rz_dmac_chan {
@@ -92,6 +94,10 @@ struct rz_dmac_chan {
 	u32 chctrl;
 	int mid_rid;
=20
+	struct {
+		u32 nxla;
+	} pm_state;
+
 	struct list_head ld_free;
=20
 	struct {
@@ -1028,20 +1034,57 @@ static int rz_dmac_device_pause(struct dma_chan *ch=
an)
 	return ret;
 }
=20
+static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	/* Skip channels explicitly paused by consummers or disabled. */
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
+	    !rz_dmac_chan_is_enabled(channel))
+		return 0;
+
+	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_I=
NTERNAL));
+}
+
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 				     unsigned long clear_bitmask)
 {
-	int ret =3D 0;
 	u32 val;
+	int ret;
=20
 	lockdep_assert_held(&channel->vc.lock);
=20
-	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+	/*
+	 * We can be:
+	 *
+	 * 1/ after the channel was paused by a consummer and now it
+	 *    needs to be resummed
+	 * 2/ after the channel was paused internally (as a result of
+	 *    a system suspend with power loss or not)
+	 * 3/ after the channel was paused by a consummer, the system
+	 *    went through a system suspend (with power loss or not)
+	 *    and the consummer wants to resume the channel
+	 *
+	 * To cover all the above cases we set both CLRSUS and SETEN.
+	 *
+	 * In case 1/ setting SETEN while the channel is still enabled
+	 * is harmless for the controller.
+	 *
+	 * In case 2/ the channel is disabled when calling this function
+	 * and setting CLRSUS is harmless for the controller as the
+	 * channel is disabled anyway.
+	 *
+	 * In case 3/ the channel is disabled/enabled if the system
+	 * went though a suspend with power loss/or not and setting
+	 * CLRSUS/SETEN is harmless for the controller as the channel
+	 * is enabled/disabled anyway.
+	 */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
=20
-	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
 	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-				       !(val & CHSTAT_SUS), 1, 1024, false,
-				       channel, CHSTAT, 1);
+				       ((val & (CHSTAT_SUS | CHSTAT_EN)) =3D=3D CHSTAT_EN),
+				       1, 1024, false, channel, CHSTAT, 1);
=20
 	channel->status &=3D ~clear_bitmask;
=20
@@ -1070,6 +1113,16 @@ static int rz_dmac_device_resume(struct dma_chan *ch=
an)
 	return ret;
 }
=20
+static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
+		return 0;
+
+	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED_=
INTERNAL));
+}
+
 /*
  * -----------------------------------------------------------------------=
------
  * IRQ handling
@@ -1435,6 +1488,123 @@ static void rz_dmac_remove(struct platform_device *=
pdev)
 	pm_runtime_disable(&pdev->dev);
 }
=20
+static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
+{
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
+
+	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_device_resume_internal(channel);
+	}
+
+	pm_runtime_put(dmac->dev);
+}
+
+static int rz_dmac_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
+	int ret =3D 0;
+
+	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		ret =3D rz_dmac_device_pause_internal(channel);
+		if (ret) {
+			dev_err(dev, "Failed to suspend channel %s\n",
+				dma_chan_name(&channel->vc.chan));
+			break;
+		}
+
+		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);
+	}
+
+	if (ret)
+		goto suspend_recover;
+
+	ret =3D reset_control_assert(dmac->rstc);
+	if (ret)
+		goto suspend_recover;
+
+	ret =3D pm_runtime_put_sync(dev);
+	if (ret < 0)
+		goto reset_deassert;
+
+	return 0;
+
+reset_deassert:
+	reset_control_deassert(dmac->rstc);
+suspend_recover:
+	rz_dmac_suspend_recover(dmac);
+	return ret;
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
+	int errors =3D 0, ret;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(dmac->rstc);
+	if (ret) {
+		/*
+		 * Do not put runtime PM here and keep the same state as in
+		 * probe. As subsequent suspend/resume cycles may follow, leave
+		 * the runtime PM as is, here, to avoid imbalances.
+		 */
+		return ret;
+	}
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (unsigned int i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		rz_dmac_disable_hw(&dmac->channels[i]);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
+
+		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
+		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
+
+		ret =3D rz_dmac_device_resume_internal(channel);
+		if (ret) {
+			errors =3D ret;
+			dev_err(dev, "Failed to resume channel %s, ret=3D%d\n",
+				dma_chan_name(&channel->vc.chan), ret);
+		}
+	}
+
+	return errors ? : 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rz_dmac_pm_ops, rz_dmac_suspend, rz_dmac_r=
esume);
+
 static const struct rz_dmac_info rz_dmac_v2h_info =3D {
 	.icu_register_dma_req =3D rzv2h_icu_register_dma_req,
 	.default_dma_req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
@@ -1461,6 +1631,7 @@ static struct platform_driver rz_dmac_driver =3D {
 	.driver		=3D {
 		.name	=3D "rz-dmac",
 		.of_match_table =3D of_rz_dmac_match,
+		.pm	=3D pm_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		=3D rz_dmac_probe,
 	.remove_new	=3D rz_dmac_remove,
--=20
2.54.0

