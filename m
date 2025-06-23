Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E924C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:32 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web10.367.1750690043964809166
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iFppE+Fr;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMwA0Lm8w3L/KS+029JAQsSzvCst7A1N0LNNjWdgJoyiI3hdJT4nPy/R9QzSuGPSRaXnWRd3krRMQqLkqB6yP3jcvy1FO5JDO87lfmBIdHTQU4A/ue/ZAWeYGmW425ywOrgxK2CGjoLMNJx/imIS1hQZfn7TePQPrbxvoNVXSmk/9dUDNTZCifVusQYZedRUL0VckIiXy1BSjdXY0MKItcu8wjfjPtmguUV6WGPKwui+7ZSbC/Q0VUVHSxif0b/dPpQUtIYkuxKyan2TexfMKZFI+r+d/gPoE7YzMM0nHxXUMJtoS+/NdglLUD11Cp3YRpLU1jI8KB4IDHLa2aQLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pQXiTe4HnKhaWTa3n/YTrsQ2nGMc70wCyg1wk+2Tj8=;
 b=a5o3kSgXad4Vz6YCm+QnEiLXk/cqpmzYioPdzRqBKDgUdZ62PuTr1od61WXSQusCXGa0ZdptnBCnzYovnzsqeXhxqIkk4x3ttVcjjeeUcv0LCGksqGooCAU0vkuh7s+VunKx3xJ5DcfhwuHt0vRW93nVfnIn/1y5chcjZ1guqzajhkRbB6JFnHNcLeU6Uwk+jQDxY9NGNH50Y6yjOIXCj3eRtx5vNoToyUeLoB9AploCxM6oraReqXjiuWRfUVoeZpGMk7oSyrNe+/t4sFhFiRyk0ubNxKXMzXPj+DiQ2WTI2pGhGuuIi45GnZOz4agMI6eyGJMaj83X0pke8Z7pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pQXiTe4HnKhaWTa3n/YTrsQ2nGMc70wCyg1wk+2Tj8=;
 b=iFppE+FrxDRA9XvvRA5WYLHVT14ts4lBoFfc9prZzv+RQ0zsxlhUCfowXAa6ibqL3+IKkUGCrhCeTPZ32C3bAQ/mPJUxhSxUGmmz+IPJ1ECfKk9Fh0firFDr4DB03RxVbfA9S8RIZGrvzdut/oWq8Q+6mx1S5xVGey67PjoVPqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:23 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/17] mmc: renesas_sdhi: remove accessor function for internal_dmac
Date: Mon, 23 Jun 2025 16:46:28 +0200
Message-ID: <20250623144639.2119707-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7c05603f-ec8e-45f1-cbee-08ddb264dce5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?H6hnsv0qp9KZoAAM55ZgBQuC0DJVhTXIQ2A+b7FSa4Ouv3Iwzh5bcAjgkL7s?=
 =?us-ascii?Q?u2FT6PcBBOFDA+eMc9hPSqnrCCnJETAnrbq59j62mrVwnJAwyTx+PdREAqsV?=
 =?us-ascii?Q?2IAIkLVHlSkDBOqB3PPFJsumCttR8gy1aH845axzOV1oToyHuJP4+2uZV5TY?=
 =?us-ascii?Q?P3P6NMPgul8M0yg3ipEvJ9HL/bZixXeruHHpR/ASj8G9Zuy23PVeP3FxdmHD?=
 =?us-ascii?Q?/038SGHFPPpMqq2LL443b/UC48YOjuaOc216XTniaGWuyNYholbEOptRzfsW?=
 =?us-ascii?Q?GHof4H/Qmt7xabBZiUMmqcHQhv+R6KXRSFEqRcf3KOxxD8S5kROO40BEnkWm?=
 =?us-ascii?Q?zT81ylIsqIoJq43B5pyzgrTdWqTtO3ZAQYHhePS9VWUValNuRfF9WMge2559?=
 =?us-ascii?Q?ZqABWRx8tA8Yz7oagMZcTOgrQXDX1JCjcRx1Bnyc+Bqb5FEZiw7QP3ZJ6cYT?=
 =?us-ascii?Q?uzDQBNgav7al/oAyAoL9PcUdJ40ScelSnrjaNeBG5TajSt7Wppgzf4N8/QwT?=
 =?us-ascii?Q?waFtVjgX/Rqn+kNcVjZ85t69pJlpMRg8Zf3MsbFJACHMUMPACFE2WiLBKEG6?=
 =?us-ascii?Q?Vo9Cs8V5PS51C5fo2ZX1OHnm51QXMjFlK+DtpwOq2VWC68E0Iv9Q6r2AYXgc?=
 =?us-ascii?Q?T2pqpIbDSqKb1znbQEbG70ibyQtvwtoSG/oByu/ZdzgSVuhqft+lwLJRgF0r?=
 =?us-ascii?Q?jjnsAQiUlr8nFRKAdaESriOCMFUmEBqnk4Inz8iH2qWsCsCJi/8phwg62AEE?=
 =?us-ascii?Q?/aBYuRH/QYeuskVQPfg17Fn0CGnEdAlAte5a77CHk4YXlyck7w1klSwAab/H?=
 =?us-ascii?Q?rRDeJVXTT8WxzJER3tKEDfXc4hA4D4DKUUdjwKEBs/X+iZ1yFtCNQ/tZ5sKc?=
 =?us-ascii?Q?yJArko7fd61QWHmXTBZgrkq5iG13CrCWe6Z0gA4YxCMEk56s2iMCB6zyRUCO?=
 =?us-ascii?Q?ZH2dBCEF5D6VMbQLVBob0ijG6EG31ITPsIxama3xuL9XRBUB8itaie9uotpn?=
 =?us-ascii?Q?hyhHsHOY5YX7f7C/4cFgRlY0GFCSDr2GrD6J3UHTegeA7mq/9lLV60ylGoel?=
 =?us-ascii?Q?RdlZ9rr+KdFLlpBLFtVsBcMeH+Lc59sy5ycNZMcktvn3H6cVLSVsA7iJV4kh?=
 =?us-ascii?Q?McgNojgbQOOGeb+s96qS5UnQJT4kv5Ypme7FFh1p7KOF5y76AIJhBCdjqsT/?=
 =?us-ascii?Q?r4ySkr9StqjuZ0aozCXdF11/1lpTTNU7thWdOGTVwmPVbqcsqAPaXAwtF9F+?=
 =?us-ascii?Q?E4kf8AAg1o6R4mR2l4vcDu6pwyJMRe9Uv8xKMk4DqwifaQ6f5HtTWQnQBTeJ?=
 =?us-ascii?Q?zrH0pZ7r0tUXchMjnF3/UFkyCm+3A6rz81IV4ab9KNRGM1LxOBJkG6Vd8JHS?=
 =?us-ascii?Q?X0EUZgrTmGHxZ6RbA1A25rUWQy4yhbncB67ETIzBZjUbPLDiRIjwv+74HyfD?=
 =?us-ascii?Q?l9k2/oXXSeQM9MZWSUITt45dTrCez+ISWKjeU3bK6Aw9+vVzX754kfhMNLBd?=
 =?us-ascii?Q?x9jBgEM96r7LPfQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hVlMN9ijJ5SswRurelDtN+tLYUtVT2e3qTNS2C0O+pjO6zD7OSHPDFVC4JcD?=
 =?us-ascii?Q?M/WPzTA44Ow5sGD/V+5H4lwwLpI7mdr68/ds1tOxzoIknsqcBAeg2ip1O34m?=
 =?us-ascii?Q?alXNL2ylnJ0TENjpZQgZeJv+89LBC2QfByNd18CWDx5ICUmkc46u66U4+vAM?=
 =?us-ascii?Q?H6ckIwTQx2KTa+upI6kSlWsHrazV0xht0q+AJVPqdTQqjgSCW14nI+vgu1KT?=
 =?us-ascii?Q?vdR52m0jh2JSt33SkH7Ih3sSH7jqLJG37aSayuMXcqlcbxsW3tezG/NCC+3C?=
 =?us-ascii?Q?HYugmXvZ9gtyD86e2nygbCMKsq0LaYAmEgdoU7mH2Skk7qiiUXqF4waKHdJs?=
 =?us-ascii?Q?5qeiXuyzf52WJcM1V6olOHKzgXorg8JpHqZpjNTbX80pDy6gEtj3f17yDLlj?=
 =?us-ascii?Q?pRtNpO+bTI46hFI0I31xCWOGJ6HfikEcaORdpuIoiS4LxDO4fgKVRUy599EU?=
 =?us-ascii?Q?KV7Hmi2+W8MNaQJWgnX71cbDLTl2aywp2wUexeYmVZ/sXEys56TASepjGOlI?=
 =?us-ascii?Q?/SDDWzMXjtHVAfMr01SYADzeBkYgI8AxyaX6XiUq3/VaWuNgM0M08za2CgQf?=
 =?us-ascii?Q?/N40+BmIqcH2dxeICXrWgy0guruKNEMH7Sp7mFUbTVIWNuTooYfjjHsX3VE2?=
 =?us-ascii?Q?wDaxfUHpi9FuACC0KY7KWc97Sfpo+An8saTKh/DtwELRCuWpJg6H5IV3krE+?=
 =?us-ascii?Q?zBuPjY5Uyc0heAuKtnKkjeCoB+a7PEF2gFSydgetSUIKXAqGg09Bd/wLgTtk?=
 =?us-ascii?Q?omLVWtzQbHXaXFzDeEpFY3XGnXeGf3umIi4gvmDUiCwz3pvyrn8AYjElId9y?=
 =?us-ascii?Q?n20VYihr5edOLGn6JTDknqZiG/+qo5byA9od+FRS4jYHAl1q1eu3T+3J+3Tv?=
 =?us-ascii?Q?j3s2m1nrLatwe/z2eq2wury7NxBqUKpiMjwMRXa7cwv+pFt4L1dU0YgEHFyG?=
 =?us-ascii?Q?qeQX2k+h88Ub22WtwNoHIUdsqdD5Zn2h6o26rDSzDcyNPCnKiCfddvDF1GP5?=
 =?us-ascii?Q?0teP5UcXVX/jQBRlTNMJAXDrXKMtDcGSPHOhKurZfzfvZlb8DZKb09IYpOaz?=
 =?us-ascii?Q?PthqwePJT4DgQ6IfOg+I00XL14IY5j6/F8eaCVugwAOgDo3XSDImSB0nmW5s?=
 =?us-ascii?Q?uaA6MJ/4tAJJSIPKZNAPTcPDA6VS8zvjtNZSTwqJ7CTpbcxte2ClJIo9o4qO?=
 =?us-ascii?Q?N/T9u7D7cwfTzrTBQQN3oClER98XtBbkUt6yM23LawW142s0K/S0HOA0KWaV?=
 =?us-ascii?Q?zsn6dhupXyZU8mMquU3hk0h6ZaFfIZ3oaq5gCBEofWtXmMb6t585FQo+YgGe?=
 =?us-ascii?Q?oFCRVvH4qFLi8Mzwi1aA1hIljNsPJdOfi3DVg7SV4cSBKIeUBJbOgI9sch/B?=
 =?us-ascii?Q?SeFcAU80DuUuT3q1EGcD0wfJxUt2ywak2gPsI8CItEHw0c0yw+SH626i9fYL?=
 =?us-ascii?Q?a1dh9U5/br1O9Mtyrv5ITyuErm40XWQUE40E3rlfeoU9itnNFRTr1o/vFv9j?=
 =?us-ascii?Q?GxP+Igy4EK9dFW1u8/0lo1viIS6nbdbhe5qFq1WqhFRpVdaHNCpAuSK3sRiS?=
 =?us-ascii?Q?sN6HEFlCE8wwE/KQ9fs57N4cKVCL1vpOUL5WmL5afyEjPULvfnz6oJhwfYyd?=
 =?us-ascii?Q?HipmqGO7MpYpxjgxXhDSq3E=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c05603f-ec8e-45f1-cbee-08ddb264dce5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:22.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwJBs9+/91xY96vtNUfEGk8y8dRNPykHsbgmMmZ340/L2IUAtq5XRklksWNaPmM4S5ygJGvJrWLuHkJQXZIr0av5DGl3Lxbrz9cAw6Qcdu1a0kquVF4cHYPgpXNzHoZ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19193

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a8687078fc5e7606b3e91f32cb6ba2574d83736d upstream.

This accessor function does not help readability but makes it worse.
Because I soon need to read from the registers as well and don't want to
add another function like this, I chose to remove the existing one and
use the accessor directly. I also switch from writeq to writel because
no 64 bit register is actually involved.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 31 +++++--------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/ho=
st/renesas_sdhi_internal_dmac.c
index db4815f36756..c32e65a3effe 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -294,13 +294,6 @@ static const struct of_device_id renesas_sdhi_internal=
_dmac_of_match[] =3D {
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
=20
-static void
-renesas_sdhi_internal_dmac_dm_write(struct tmio_mmc_host *host,
-				    int addr, u64 val)
-{
-	writeq(val, host->ctl + addr);
-}
-
 static void
 renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_host *host, bool ena=
ble)
 {
@@ -310,8 +303,7 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_h=
ost *host, bool enable)
 		return;
=20
 	if (!enable)
-		renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1,
-						    INFO1_CLEAR);
+		writel(INFO1_CLEAR, host->ctl + DM_CM_INFO1);
=20
 	if (priv->dma_priv.enable)
 		priv->dma_priv.enable(host, enable);
@@ -324,10 +316,8 @@ renesas_sdhi_internal_dmac_abort_dma(struct tmio_mmc_h=
ost *host)
=20
 	renesas_sdhi_internal_dmac_enable_dma(host, false);
=20
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
-					    RST_RESERVED_BITS & ~val);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_RST,
-					    RST_RESERVED_BITS | val);
+	writel(RST_RESERVED_BITS & ~val, host->ctl + DM_CM_RST);
+	writel(RST_RESERVED_BITS | val, host->ctl + DM_CM_RST);
=20
 	clear_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags);
=20
@@ -412,10 +402,8 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_h=
ost *host,
 	renesas_sdhi_internal_dmac_enable_dma(host, true);
=20
 	/* set dma parameters */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_MODE,
-					    dtran_mode);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_DTRAN_ADDR,
-					    sg_dma_address(sg));
+	writel(dtran_mode, host->ctl + DM_CM_DTRAN_MODE);
+	writel(sg_dma_address(sg), host->ctl + DM_DTRAN_ADDR);
=20
 	host->dma_on =3D true;
=20
@@ -435,8 +423,7 @@ static void renesas_sdhi_internal_dmac_issue_tasklet_fn=
(unsigned long arg)
 	tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_DATAEND);
=20
 	/* start the DMAC */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_DTRAN_CTRL,
-					    DTRAN_CTRL_DM_START);
+	writel(DTRAN_CTRL_DM_START, host->ctl + DM_CM_DTRAN_CTRL);
 }
=20
 static bool renesas_sdhi_internal_dmac_complete(struct tmio_mmc_host *host=
)
@@ -517,10 +504,8 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc=
_host *host,
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
 	/* Disable DMAC interrupts, we don't use them */
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO1_MASK,
-					    INFO1_MASK_CLEAR);
-	renesas_sdhi_internal_dmac_dm_write(host, DM_CM_INFO2_MASK,
-					    INFO2_MASK_CLEAR);
+	writel(INFO1_MASK_CLEAR, host->ctl + DM_CM_INFO1_MASK);
+	writel(INFO2_MASK_CLEAR, host->ctl + DM_CM_INFO2_MASK);
=20
 	/* Each value is set to non-zero to assume "enabling" each DMA */
 	host->chan_rx =3D host->chan_tx =3D (void *)0xdeadbeaf;
--=20
2.43.0


