Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.309.1795708162899912729
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=d7zy5AHQ;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qusH9oIIvTyxW47IwwznHOcW134tGePwuFooTfuNYOVP4oHpKabLGD1hqFKW5J2Gu/06yKYVC6uudGmvfzqA+Eu+D+5GYamldM65X1FKYxs7P+vZs8vwUl6UOOLcFgocR9KauvpYbEJ+k32bK7O8RTZB7d3ckbmTXGBy9PJmai39/6d9jFokXu7tR4dd6HTooF5F5QCOX2x57GmXCNBARj+jRVDQFfaDnPhGeNnAdnXRiIJwnmmM1dZEpNYvRnQg1oHxtPixShPI9zOg798iKk7/m2xqweXdhoGR1OWkhhh5ZpPq67Gvv3MOrE7byujshzOq9kRTBELB/Vu0k7euCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LatOqqwW4gpBJqhyBc4dM3KBLSAh/4E/rvinRvCrDgw=;
 b=JwQ7CMrh9wNTzGyeXXShj6ndNCLgcMEtj/YmoSW3t4w0oSTnXP6/j40NsgfkVuNq2gNNEqnhBcT01QnXBlgju5gFLfeELCt369jsEFkf1Tr8ClQbmTft4+y/xxbadGVq7gtnUiUMPia4N2QUlzbA02RC56wIkAle49eauhcqe4AjTJApmDtYt04B2qOeuJEZSgU7HFwXPy2O1k3zspdCd/I00v40ouqjDHJir3ut3XfS4zDvhUSsGszoj7+KuuoN8W5kwASNPMayvz4aPGH58ixY5C4j02LjraPrZ4F+2PLKlf2BLvKqqyVQK1FPfendxpqLnHwwZMpZFpkP5Wj5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LatOqqwW4gpBJqhyBc4dM3KBLSAh/4E/rvinRvCrDgw=;
 b=d7zy5AHQfHFgr3h1i+1Q6ecHxABlv5TmW5uOg9MfC7dxZTESrm9LILKJETs2xLJ6SYLzKAGRoVU4K8gQ24oddjVDmO3nsacoObeSvm4HfrqzRQtKvzlYIj0O+dVIQkizDMAUXErtYeQ+cqvJuWa4F45zjjLrMjWZDU6lOqLj3po=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:21 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 25/27] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Thu, 26 Nov 2026 16:47:45 +0100
Message-ID: <20261126154747.3832917-26-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f03ffa0-3207-4800-e1bc-08df4bd4d559
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Fc6ae4Fd1jKJpGnE/4ODJRvG2ITtM5wPZGVlsSQEiINWIfmxQ5M0ZObOVLI6d/ByHrbxlQ8KCY+3/dSrjP/8TETLIY/uJ+xXEzwuGcRtVtdezAlzKvZLSjnz0VF0ZFbZ8oSM4BV/IiTFRXJyWR5hx0E+MSCqPRpnnOA/ubA9w0Qv6qf4KTKEWa5z+OzgillMKSJ1xiZo+/lbF/b4Eh+KmKPvxflsJuM0cUvarN6xcsvLBwjbsp5yUxUFP2e1y38r0A/AMle4oZge2vWFozuV62X6lzi/5wfHAASbu+2io5KxhhUKMu8ush8jVVDtBTESRmTE9BQAT5nT1ld1Rvnp9LN+ZIe+Fn86ls6dTVN7Rz0IDOHYyLiDol2Ld0T1w+1Ly1t/iuKG80CDDUUZbr5DHhPPTTj/LUNJl8dNyRaKb+gLkKPa/UsBzQio5NAZMSbCpvVd6gM93+knlrNyqk5DDDHHaedrXyq2hNmWHIMJIWQH43JNYXKWWGMp6iWTG9zzD2UloKxugyWJGDN9/e3RNN9CneZvY+2jhIL06EDVyBsc/YA1iVsFMlb4KHjOj8+0xXDuLoIHP8JLKSGOKW+GDaY0yT2ZJ1nv6QMqzLbpwhvrxetCOSC7VxCx1/3UuzJVznMFPcjVJwsr2XRTiD1eQsMJeXwFa99L1EsegumGYnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DnuOzfGkMspgFk4kiUhkssgD4lQgC0gkdRCik7RSJb0oVE2MRq3ULcAgQ8nv?=
 =?us-ascii?Q?TRA84PzZX56qyTcfkZUaggfGjRXJ/GVZ9nH5w1wXWgmwvbWuQueokb9l14/n?=
 =?us-ascii?Q?ozJjWpf28gkgkxiSrT28X1sBBXwPY+IAmBF03UQuNJMZLpcNhpagGpq89qQP?=
 =?us-ascii?Q?9rd/ec2gWvG88JAtLCDf08268bfHQnRvN2Jntn9kFk1/PnH2vb6rMNNLIrLj?=
 =?us-ascii?Q?xqOXfVcb0o+3D7tI7E/jntHa7BwryYGpsfrl0AH7vermTgR/Mf5ZJ349MadZ?=
 =?us-ascii?Q?E5kfIZYygrQvrIR+O867CgByrveISV1UAM8zBmzAWeP1ARt6LQK1dgoD1VRL?=
 =?us-ascii?Q?/JsIHBO/gshxji0AuePe86YtxJ/rILUGX0v4q77dDice417HTjRmANRuEkJZ?=
 =?us-ascii?Q?NWX+HOPJGwlJMlIrDHBN/Oe6QZV15eZuTuORFjzR/H2sJSRpmm1OBaQZN9eC?=
 =?us-ascii?Q?954G9VZCL6GTJUKLiRWNoP2jOCPvHLeGIrDOr/YPHvi48VM/tBlQdrKXkksU?=
 =?us-ascii?Q?vwqPn8jdLVIDKFDq7F+YKaogCK1s2LrHEzY060zr4sE02jAa9ww2gHF819+N?=
 =?us-ascii?Q?NB6J6O1GvcEcH7aIIvcJW6PuqZ83TRKVuOieWYjPppCKSkLVHdESdH2+P/28?=
 =?us-ascii?Q?u9HmBXQ1UoM/hoq86WEsqaKf7DiVOsuVcna5G3g0MjM3r2DXz2WV8ZT8S0/q?=
 =?us-ascii?Q?98HGb1pq9oGF3DMcYdJD3Kl8Lj+p69lCYddoZmcrT2pBxCpooNsxfrh3WX2x?=
 =?us-ascii?Q?Hg9D1lhNBq5KhImszwmHqIzUDde4BjTb/agxCI7QSI/e8PVcaxzyAnbcl2Js?=
 =?us-ascii?Q?Nbw+Ste2uexwIGp331ZxGHFub4Tj/HfrhLFP33PCoqrKgLcMvrQJKRmvKD7j?=
 =?us-ascii?Q?E8/06VePcc/0+sdEW2c50qiYOchUz91o4iyqxCIG/7xyDPBEpBcLiBKMB9X2?=
 =?us-ascii?Q?lr6mlvCV1SbxOVO3iK4KqXr0JFoZDMWNcJyplrbrvGn1ccNYWsq+mkuRFhox?=
 =?us-ascii?Q?R0Jmm+Pi705TljUD6ZdB7Jh67egm5UjhBa9Vjdm0d3K9DgblUUsb9hTB2EEI?=
 =?us-ascii?Q?3DLV5D797Cmmt5LlNSD6QivqB+PWrgXCumVXMZCXJWGLTJsY/LJrQj+W4JNo?=
 =?us-ascii?Q?7OsompsUGFIGHY9X7xTAhtG2xIRFj45/BZQqo3eH9RfLXr34JGJOsdffeDCm?=
 =?us-ascii?Q?jM7UKA4EFIy7ghHcQcXbytB/CGU8oRE9tpUVfDY/z7dpJNuqpl9K6326ROQ9?=
 =?us-ascii?Q?wwE8lLyonLy/X1Xnq9Ukw67CwfEQLqMkAIttS5wQVuRX6Zrl7up0UZvLrUb0?=
 =?us-ascii?Q?d7rGGwJ2LsFQu7Ab+Zz5D9Uh89MffTlm9SUql0wMnM0VlkcvqgwSL2VM1KA6?=
 =?us-ascii?Q?BmTRwRPxDrMB0JUZswyQ4ySnl1kS51PFK3bSMJ+GRhfNrvnAqD9vqAfA0qxF?=
 =?us-ascii?Q?6aTYs72kQYyvxZxgTuKXDYA7nYFOxEPPorbqBDZy7vHZa6AlZkUkn9t6W7+x?=
 =?us-ascii?Q?vtu4mEJSSuSeAtNcH1Ctx/vk5ZxV7Cgjh7QaVIzWYD7a9X9IBExch+93wNEj?=
 =?us-ascii?Q?fFpeMse4RRnbELDwDo4piWlOrJudiJcREa3D4v0we9tVLoKbqsw3wS0xRnjB?=
 =?us-ascii?Q?mYG7QgzqRXlIDcDPlDy6WhZphXzxu9u3TaPo1+lZnwivEFIZoMIYK2qjcHcI?=
 =?us-ascii?Q?uQ4+HaLRnDnuStcFp33Yr4iFLLGD6nCYbrJyeYIXdXSObEYoxmGb57AI/jcj?=
 =?us-ascii?Q?OfZhyreSF+KWUp7R389lmK9fQmXjjS/wQLyhKLM8i3ZBnxG5eNZJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f03ffa0-3207-4800-e1bc-08df4bd4d559
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:19.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ewkhPriTFjzlRzv9qFVdsCalLSZLTI9enQmeMSd/x+eNSKXxUaz3NEoXYlhYOM3UGatolNUr051v84QaqXTpQkYWbGrkyC8SAsbj6vXqJrVRQV9SJPDxpY1ZGPoqWQZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25175
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
 rely on is not present in linux-6.1.y-cip]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 181 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 176 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 90a8625f84b3..351753dd5049 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -68,10 +68,12 @@ struct rz_dmac_desc {
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
@@ -91,6 +93,10 @@ struct rz_dmac_chan {
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
@@ -1027,20 +1033,57 @@ static int rz_dmac_device_pause(struct dma_chan *ch=
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
@@ -1069,6 +1112,16 @@ static int rz_dmac_device_resume(struct dma_chan *ch=
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
@@ -1434,6 +1487,123 @@ static void rz_dmac_remove(struct platform_device *=
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
@@ -1454,6 +1624,7 @@ static struct platform_driver rz_dmac_driver =3D {
 	.driver		=3D {
 		.name	=3D "rz-dmac",
 		.of_match_table =3D of_rz_dmac_match,
+		.pm	=3D pm_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		=3D rz_dmac_probe,
 	.remove_new	=3D rz_dmac_remove,
--=20
2.54.0

