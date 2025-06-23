Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976FC7EE33
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:32 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.32])
 by mx.groups.io with SMTP id smtpd.web10.370.1750690047782069851
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WWfAqrz1;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7HB+apa82hQfC/7SSHcFXN4evIvRYBnjDY9zRiMVyvB3pz2Ocjl4KBT1em/LMCwYIzzT6sa4rBLw4uVjWimqWwZRK66fpV63k3E8SD9arDCUi+RwXGc8z+E++IxfksjgTB4ubi2Lxowvh1xCj4GUv/VxIRD+gmEC2Yxxl86Mx9LsOYzkzVPfWgh4bShk/Bu0uxF0oPIj4yGMxJfnvYA8qnEmWqkkY8fgvpNT6TVuhNQ6A+TAMb24m8R/CbJ9XiArZGJUM0QwrEGE+btZ6ygJUhl0FPYfNIr+6ZwcHG8vwUWSxqDD99i89CyIt8BcMfVbl1ZqSQk29MjC/L+YsrzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDk4REKApahVodayyU645YS3no/gYXfS9Se6TA721I8=;
 b=T2kHEhPhDvr3teKzs/jdOC5xZXRQesHQyOcVkfqh18YGpxQyzae1gwzxjuCN8Hc9M7pmN7GgMRU+TKDZcBSRw0nVWg7uS3zkaqC9/dF3NWbEYP+Lpw2TSoHiKkN+NDBpczOxBTI5R/jyJrZ9JimaA1CHqwm04MonPMaVMr+8v/rGbLA5mt8IMmjeWFxj3u/BPVeSeujlx0LdIA40S1MM4uRTnVkS1o8t5WdLRtMd4IzY4o7e2JgntbB6ge9PjiDqwhGPJIeigHw48Q1MnIurBzcHLh0Mrid7Ctj1HQ5vHYxHHeTh9CbPu1L+HbVNWawspn85JyCUAImzBcd/B57ljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDk4REKApahVodayyU645YS3no/gYXfS9Se6TA721I8=;
 b=WWfAqrz1K4vI0zbHdJ6iPQdY+hKL+lytopHg+algEmZSwZmQEWVLROd49pllDS97TYpFWCmqvxKWdVYe4fdONumLBOMDttJPpok3qFsDJSZi3UUF4znLnempwrr+vICfpBcJZ4NVGpP8MVKivspJXlJgDe800hWGjKR526E2nuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:26 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/17] mmc: renesas_sdhi: take DMA end interrupts into account
Date: Mon, 23 Jun 2025 16:46:29 +0200
Message-ID: <20250623144639.2119707-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1644f5ed-4156-43a4-7091-08ddb264de80
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Tka30PvpjYjMXlLpzF5taHWfRvTKg3bcasfHY4H8zJF7sPxaNswhkcyEjK/o?=
 =?us-ascii?Q?vQVeXV+ao3PjBqmyifOZ8LS9I4oE6RjNEnvPv7eW9Vg/KDt9EpeV13Bvpbl1?=
 =?us-ascii?Q?iI1BnZ9ycI5qJzdlNQhUKVK5Nmm5OQEcAYTWbMPOcPF/vM72MQdTY6eKjHz8?=
 =?us-ascii?Q?ipqUPWWO8hwX678kRntsz6llTRiFg9138t0ZcGhTdKYkM37ZuTjP07WCa6bF?=
 =?us-ascii?Q?mPc2bhhSoT22RUIXj49G+lIsSSaeN0f/SXMrSzJrubx70U67ELH1DyvFlnkb?=
 =?us-ascii?Q?9fPdvBpOo1Re50CECZadnz2LkLpVkM/W1iY05o7nITEQpqIzfkq31IJTM4Tz?=
 =?us-ascii?Q?KJNALLsmCN0usYCxxaPOOnlAw6VpO64kDrQuUiwsdlOwDIEbk5s5W+Hxa+tN?=
 =?us-ascii?Q?LlAEDdTNUgXUHdHHSlI0ZWkaecH+0tKvg9bNXNNMwr9/ptCfHplpIuJJ75io?=
 =?us-ascii?Q?t9fHORTP+xBHAiLQvG5w3uUkRnkZSiMxNoaDBzTPgaS7+dGPTJWsanD4Z5R3?=
 =?us-ascii?Q?+s2K0bM9TJ1TpRLLeJi2ZrQh4+jeoQ05uiIoJXgNo5kcfRF5Zrb3PbzFtI4P?=
 =?us-ascii?Q?7JvhWWPqAzCvWn4a9yljSt/zsrNtINO/01KRTh/us2hDOZk7eiTSAQh/JN5W?=
 =?us-ascii?Q?JxyhoLD/B+ramnTQSTLgamBFxe7dhkvHf4Wz3d1Oa7MPBusGVWbuTVfIdkg4?=
 =?us-ascii?Q?IPMdBiOqlJUuMyqWQuWUOMzOUNaMJUb3jtMK9uFcetWMiQpKC13+7VfqzYpY?=
 =?us-ascii?Q?46+jRbJ8/P8u5YRz9JXB0EzXZLr0xwnLFeH76WP8N8TlIJ/7t63Y9wYlQqtH?=
 =?us-ascii?Q?dyk2fFGGeZ994xAztQIe8N0ttiDPV0Ui9D3cPq4QO6unVd1ezONE00CxSuk0?=
 =?us-ascii?Q?PibNdJAxzk9B6eO4jwKA+WJXzjQ+ms0PMyAfeG0STL/k64KPiDUT+lEMTagI?=
 =?us-ascii?Q?Eip0Au/aylUMmVK5eJx06k6+M997KU+QyuL3fJQz3/DVf9FF1qbPxfR7aNHW?=
 =?us-ascii?Q?ztL69Jk3LOI6/gXwL2fttc4369fyPEMBKgrbSoP8965nNhDNzu18iyKhRp6U?=
 =?us-ascii?Q?ZDCr51P7nidSeWKoQxtKYaeEZ0IiBXuqzOc+V3gnF06cz4rKVy0OLCpaITRH?=
 =?us-ascii?Q?pzfsOLOU0AsZfqdNNrK9XRiXLoXX/AGM7AD1lk5aSADG+NVb7kb+lS1L20T7?=
 =?us-ascii?Q?fHHUQ0ZVQXzexV8OI5tWBWGRKp0vl7dh4TwwjkfUuCo3AM+qES8bcDaXfbMo?=
 =?us-ascii?Q?rUM9+vgp/sawGsKLyqqDO4vESROaqFiQhqo/MHCslqfCu8Wl6fWv239TBjfg?=
 =?us-ascii?Q?RX06waVU9cKjvMAs7EoVxoCUWfHx71o6rJ+nI3UzHDPCetKVsSnzPkuiZaW+?=
 =?us-ascii?Q?YRPcABk22g2euB2WArWqzC2SqW/MPV6rmcUmQZZKqvj7ykP/HJwTTNVgXXWM?=
 =?us-ascii?Q?OAnvDe4mNaTSY3bGB7rfv4Mkq9obkr81ct6nA+BtTNAFnjKX9Rda0V6nNeuB?=
 =?us-ascii?Q?erA3HFf5KXeQUoQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ne6THcWRXl8j2CvtmwpKVBl2z5PArvTbgaq1bFSZqHpE2apKbPWdEXKWmV9+?=
 =?us-ascii?Q?8lNgWuFaaER3lX2zDnyatZfo46FiicOwVt1kTNJ9gqTjdPRrU7BT2tNuJfeW?=
 =?us-ascii?Q?wxGd5fOwX5mrGhtktWfseDMzkhfAOesCufNJCx3pFBb9XEVZ8po8mDzS5zF+?=
 =?us-ascii?Q?vhLjt2VJsr49LnFfD8ajkjp8MjXZoc6TE68uiE0K8wmnvlqiWSnLRRYkVXjO?=
 =?us-ascii?Q?VhhCEOSfWlZ57BmCLeBXFLnYZ+6YLsK+43WycShVV+/a7zYLhSb6/lx8ul7a?=
 =?us-ascii?Q?DLuLOD/xBSEAcxZzVlUeht1wpwOyF/vhF+w9wK/PZmoDcC0fux4J2s9FP4sG?=
 =?us-ascii?Q?2EVm5+foY5SGBRC6ccof4n08ps3nRLfJ1b4nfjk43Of95tNS6qOKLDuDQ8V4?=
 =?us-ascii?Q?lZ2c6SbrjIqqQG8ceiN+ea2YIMQa9T8+0blJRHGkDwBGNFiLC+KrEAbSQ/cU?=
 =?us-ascii?Q?mqnU30Uiq+RQGma1hzXsQHUGml5jmgfx0WBWuoNyi4oJBdNxYLoNlGg9XgsL?=
 =?us-ascii?Q?6Ls6yJ5VKwgkBy4OE6LoxcazQsN4Fb428F2fhwu4BHKwgzaKKuP4h9vFXbpg?=
 =?us-ascii?Q?4CA2lpw9hKmL3Con31zNxUV23YdKHaGL5mKJDWRbEngRErkEaBTzTZrSR/Jc?=
 =?us-ascii?Q?1j8UryM6wxgQL9vpCiQ5N1/Mp9ZMRePcGnBhp4MFmwAPwvai7vZe/MAJfjCj?=
 =?us-ascii?Q?yYsKpQRAMo5BEnNR7VibeJPoEcwt8Gfu86Z6mpzobkLqQ3sTtIY5iQvwB6fD?=
 =?us-ascii?Q?9pIPBry0vEj9sdSIk8M7nNpHhijOhIGZqYHVTUBXb2PGo5gZ3QqlGU+iWziY?=
 =?us-ascii?Q?EpwdteSTo5W3EGutlgFw/M44yM6EWmpTlHbVjfi5CIQDq9WR7eNZACaoRKcU?=
 =?us-ascii?Q?rFjFA56prkmsYaxSHf0sqzo/Ec3Vg1asTtV5nOQajF+AkI2SahC10HEi0DHz?=
 =?us-ascii?Q?mK42alCwFH1vL4iTSExt5t+eVHB12kg+Wv7iziRBpSQ52RrkAMErj2uCjg6O?=
 =?us-ascii?Q?aDcsuiD+asHiz+AffMDy0msNyFHJdzn3rcgi5cYNieUpRcTWhRvnFUsIiDfx?=
 =?us-ascii?Q?4Ka91kGT3zxRZRkaQTGmLkazXwDPihL0ag2uhVwpWUTwge0AVT6wzWqcrQdU?=
 =?us-ascii?Q?tNf7kcJ899dy8ewt/0sIxyfBj2XlsZbelI8z3oyszx88c2s5cVb2WXzJPxCh?=
 =?us-ascii?Q?/P+WIBV1sDzcWZbQz2XWY25DhTtyTxzMjbaQegc/5poTBisDamBRNzkUAIcb?=
 =?us-ascii?Q?dpX1hvwPNldg8yQ//p5an+lLX7dfSKp37aRxgQ7QCk7WU1u0gENY0BPVH+X5?=
 =?us-ascii?Q?9/q6BIDjutc5ZCDgWAawgGjYAhS5tkArSKDnpDD/LcmEjTg3jBGcT7Trv42Q?=
 =?us-ascii?Q?6YiowshkXV8Vmghmis70i2+DupgGMtNrh+cw57SXBhRpyPgSmalpwq1XMlMv?=
 =?us-ascii?Q?i+WtyjLyDrjkQFdUtuu63vyM00r9hqeKGurBX8q/vrsHlyECLLsNS3yOoM5a?=
 =?us-ascii?Q?cC5BVfK8d8sxQaiWjJhF6t+Il3c+SQmEb1pR08alxus/kPF6c1MSlhIHxGp9?=
 =?us-ascii?Q?kRdszTvUiwDGGTamW5d7j2CRFanVtOdFaMhVlw//1TQkUtRBsV5Hq5CMbAMW?=
 =?us-ascii?Q?Bx0KdPytNAKcbNyNUgRTN9E=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1644f5ed-4156-43a4-7091-08ddb264de80
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:25.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85xdKi7kzp/XZVA+xcAAYZjf31o1uryO9cLYMdoclueJrE1vYVdsKcHcGAPQckqfaaFSdMdKcGZlZWnogM9bvGmQB3ld6H41tCaImkGbt9qAJzyGSZeXMfMe/gMDGNip
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19194

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c330601c9c93392000c077d973b182cc0164b9ac upstream.

So far, we have been relying on access_end interrupts only to mark DMA
transfers as done implying that DMA end interrupts have occurred by then
anyhow. On some SoCs under some conditions, this turned out to be not
enough. So, we enable DMA interrupts as well and make sure that both
events, DMA irq and access_end irq, have happened before finishing the
DMA transfer.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-6-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  5 ++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 51 ++++++++++++++++---
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index fa88b721364c..8f96457c9739 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -54,7 +54,12 @@ struct renesas_sdhi_of_data_with_quirks {
 	const struct renesas_sdhi_quirks *quirks;
 };
=20
+/* We want both end_flags to be set before we mark DMA as finished */
+#define SDHI_DMA_END_FLAG_DMA		BIT(0)
+#define SDHI_DMA_END_FLAG_ACCESS	BIT(1)
+
 struct renesas_sdhi_dma {
+	unsigned long end_flags;
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/ho=
st/renesas_sdhi_internal_dmac.c
index c32e65a3effe..fc76370daec0 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -47,7 +47,6 @@
 #define RST_RESERVED_BITS	GENMASK_ULL(31, 0)
=20
 /* DM_CM_INFO1 and DM_CM_INFO1_MASK */
-#define INFO1_CLEAR		0
 #define INFO1_MASK_CLEAR	GENMASK_ULL(31, 0)
 #define INFO1_DTRANEND1		BIT(20)
 #define INFO1_DTRANEND1_OLD	BIT(17)
@@ -298,12 +297,14 @@ static void
 renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool ena=
ble)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	u32 dma_irqs =3D INFO1_DTRANEND0 |
+			(priv->quirks && priv->quirks->old_info1_layout ?
+			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
=20
 	if (!host->chan_tx || !host->chan_rx)
 		return;
=20
-	if (!enable)
-		writel(INFO1_CLEAR, host->ctl + DM_CM_INFO1);
+	writel(enable ? ~dma_irqs : INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_MAS=
K);
=20
 	if (priv->dma_priv.enable)
 		priv->dma_priv.enable(host, enable);
@@ -324,12 +325,36 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_=
host *host)
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
 }
=20
+static bool renesas_sdhi_internal_dmac_dma_irq(struct tmio_mmc_host *host)
+{
+	struct renesas_sdhi *priv =3D host_to_priv(host);
+	struct renesas_sdhi_dma *dma_priv =3D &priv->dma_priv;
+
+	u32 dma_irqs =3D INFO1_DTRANEND0 |
+			(priv->quirks && priv->quirks->old_info1_layout ?
+			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
+	u32 status =3D readl(host->ctl + DM_CM_INFO1);
+
+	if (status & dma_irqs) {
+		writel(status ^ dma_irqs, host->ctl + DM_CM_INFO1);
+		set_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags);
+		if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags))
+			tasklet_schedule(&dma_priv->dma_complete);
+	}
+
+	return status & dma_irqs;
+}
+
 static void
 renesas_sdhi_internal_dmac_dataend_dma(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	struct renesas_sdhi_dma *dma_priv =3D &priv->dma_priv;
=20
-	tasklet_schedule(&priv->dma_priv.dma_complete);
+	set_bit(SDHI_DMA_END_FLAG_ACCESS, &dma_priv->end_flags);
+	if (test_bit(SDHI_DMA_END_FLAG_DMA, &dma_priv->end_flags) ||
+	    host->data->error)
+		tasklet_schedule(&dma_priv->dma_complete);
 }
=20
 /*
@@ -399,6 +424,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_ho=
st *host,
 		dtran_mode |=3D DTRAN_MODE_CH_NUM_CH0;
 	}
=20
+	priv->dma_priv.end_flags =3D 0;
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
=20
 	/* set dma parameters */
@@ -419,11 +445,19 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_=
host *host,
 static void renesas_sdhi_internal_dmac_issue_tasklet_fn(unsigned long arg)
 {
 	struct tmio_mmc_host *host =3D (struct tmio_mmc_host *)arg;
+	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
 	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
=20
-	/* start the DMAC */
-	writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
+	if (!host->cmd->error) {
+		/* start the DMAC */
+		writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
+	} else {
+		/* on CMD errors, simulate DMA end immediately */
+		set_bit(SDHI_DMA_END_FLAG_DMA, &priv->dma_priv.end_flags);
+		if (test_bit(SDHI_DMA_END_FLAG_ACCESS, &priv->dma_priv.end_flags))
+			tasklet_schedule(&priv->dma_priv.dma_complete);
+	}
 }
=20
 static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host=
)
@@ -503,9 +537,11 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc=
_host *host,
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
-	/* Disable DMAC interrupts, we don't use them */
+	/* Disable DMAC interrupts initially */
 	writel(INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_MASK);
 	writel(INFO2_MASK_CLEAR, host->ctl + DM_CM_INFO2_MASK);
+	writel(0, host->ctl + DM_CM_INFO1);
+	writel(0, host->ctl + DM_CM_INFO2);
=20
 	/* Each value is set to non-zero to assume "enabling" each DMA */
 	host->chan_rx =3D host->chan_tx =3D (void *)0xdeadbeaf;
@@ -537,6 +573,7 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_inter=
nal_dmac_dma_ops =3D {
 	.abort =3D renesas_sdhi_internal_dmac_abort_dma,
 	.dataend =3D renesas_sdhi_internal_dmac_dataend_dma,
 	.end =3D renesas_sdhi_internal_dmac_end_dma,
+	.dma_irq =3D renesas_sdhi_internal_dmac_dma_irq,
 };
=20
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
--=20
2.43.0


