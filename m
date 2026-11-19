Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.809.1795110946208295196
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=aXZjILYo;
 spf=pass (domain: renesas.com, ip: 52.101.228.15, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG7VJwYZ3OwpSYkJ2GCGadxy8s4xEdpYfyw80NXPcaBGurtN0liRNVRabuGXwBQDUZOxGdfx0RciBhVh8ws6Wv022TLAPktNtZKfDjRKiqJdetZ0o04jqWjkL94IbqcTDzRB5Aez1F4OeXV9WOp+M8YDYe+cMyeFnm1osHMwqy6u/B6We/IIPY4+TEQhK/eYOz7BFvetlpF0tRrBpknolbYIG9W+lYGYtegQxvJdPyhppdo6ZdvJSIGS/fjHa03GHI1IaerRo32CDvrgylD9AypWyxBNmrRQml0OffoPBubk//sTOYZNjJWOp9oPeL/u7vdIek9Ihf+Aiu+yUZSo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzCgHGUjeTaqTw1vr6ZCJB8PGA+TRSQqmKXUQH/dJX0=;
 b=Njw7Udu3YURrTFSDAJW3RDEEICw8VF+CnV1OMBLIPaictiYJmT+Ss3CznzfghkgU8/lANNsIcuXJYGt08F7u6EagLmc5GrcdRK1dR/rgKFYtSxxeLj+ncyVxuEwdgCzHUSc0Dm+vLMlSartZFK3qjIdn1n+LIphm1Gc6ISHJVc+jG0jcQzJG77lJyVG7ZR1LcHQiTgLFGSDH+SEmVm5TIZzbIl2BAf51ZA6bc3CFBIviu9gYmEuTlPPJttmXykt5g0GNStGMvDK3aQ/ltW0JIFgMvKo2XWZvggx4//7tEyp52RJIJAnC1nQoo3agtV56FnOhtaTvdcNAhTFy4MlYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzCgHGUjeTaqTw1vr6ZCJB8PGA+TRSQqmKXUQH/dJX0=;
 b=aXZjILYoxnockdzJ9qs7vXw8O3mHi3y/LfPyK3/Dx1dlR01CPVJEzMmGmdnKd0z9h0zZkWSBGNDkpfB5yN9uiXNfu+DDiWs8BxUBbLPYrYJXXmDQGaXkS5ouiX0QGMkfML6R0ImVvicG1CTfVsZUKDrjUolaDWLUOd7Hvd2jzQ4=
Received: from TYCP286CA0275.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::17)
 by TY7PR01MB14592.jpnprd01.prod.outlook.com (2603:1096:405:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:42 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::60) by TYCP286CA0275.outlook.office365.com
 (2603:1096:400:3c9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:40 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9099E300024B;
	Fri, 20 Nov 2026 02:55:39 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 3/8] mmc: renesas_sdhi: add initial setting of interrupt mask register
Date: Thu, 19 Nov 2026 17:55:28 +0000
Message-ID: <20261119175533.110210-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TY7PR01MB14592:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a609cf-8767-4d1d-eca5-08df46665358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ckx5FpvW6+H1revIsXVHEZoqE0ZWQOAXe66IaxhNRRNvsbDtxCsvtiZ0U9Ju2tEUO7ULdnxs3LxKN5URecFtzvnflh0WeqY6M3IoxYgnV2IY+GgSnQVUIjzTPy/7KZPAf66eFG0Vfm7OtUBGJ/ceh3A71HsEmcYDDmvYundgjffSObgs+s+1SMzYUelXK1KI0Zq8LJ1tw2WXwmMfBEIi358QkkHzlMVBRp18x8zyHA4W9wuRqesFTacnz7wJHxxN83yZUmbvNT+oXSnp8y0FUn8lKwe/cS9af5zbEIpHJNObUfbkn+h916tK/2pwutlUwzHevAAcqKnArxNUVXeLI2QSFGsN2LmXBQWzpF0Bj8V5tgWfh22vNRy4LYguF8Ri9dA7A7bhBsCQpmaux3vBPezBgkrHNImxOX4MxD+7mAvPKs6khzESt+z3l4hW5NnOQIbOMu0WspTm9WovZ7L1+0sJcyrvTTeoTlAIxjDxMj+4Nlq+n8Dbme0KElHI9oeR4dbaA3AXjnlZmAQIqjqhVH5cGU3xnbMfILVcaMbND28U2nori7fGzLJucww7YLarIFnBicunkZzRfkAFQ5JvhKesUFmcO/OOkcFX59KbXNF8uM+unJu2sUJSo5dyVCt1YYzJD+HKCA5jY47lv1Xj3dtqD2g6+ecQqlWbw2Z7M1uNXarHsyd2FbSLXFRVkGBFV3BZ8wqMwSSeBA0OZy1nuA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uXWMR+9KOqZmJZLXlmSqfij2kqjqgeV5Kn6MT9MGL07Tm9UZnK6rVdB3QTJjL1E9X1DntNVnT1X/udlXixpB5wTfZh5dCkGonQJ4OaaypdpgAd3225IsbObYQVAKG31EODjXxPTbAx3IP/iFxG2Rou+kZvuaK6U5SZh4cdJjEPJfK752JF+1yG3Q6CGH21Ijlj1Rc8Fwz2DaJGfROzA0wXbFUHMh3Os7tjomSCvAKMWPUtBBR8E4+Ky/Yl8LwRyWGRYb8NjbEABOKq49Pl6UA6kocKFCYvohNgcoEz3/1TJ39InDWVHPYoNdwZQXGIv3MgciqLOrnADsSLHTHrZSAIJsmLuCZ3weRESfC2EZgx0Ppu5LRbJbFeeEgN6AUVe0edLRSEVhBaewrweMeYqr4RatQgOAg7DeDQpfPWs9lvtkjtCspsxnEymrWsfWuCs9
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:40.8320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a609cf-8767-4d1d-eca5-08df46665358
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14592
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25019

From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

commit 202367cb8d09c5b003ba4a07860ecd0ea50148b8 upstream.

The initial value of the interrupt mask register may be different from
the H/W manual at the startup of the kernel by setting from the
bootloader. Since the error interrupts may be unmasked, the driver sets
initial value.

The initial value is only known for R-Car Gen2 and Gen3 platforms so
limit the initialization to those platforms.

Based on work from Masaharu Hayakawa.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 4 ++++
 drivers/mmc/host/tmio_mmc.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index dea592a33f7f..1d5d1b8cc340 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -556,6 +556,10 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host=
 *host)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
 		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
+
+	if (host->pdata->flags & TMIO_MMC_MIN_RCAR2)
+		sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK,
+					     TMIO_MASK_INIT_RCAR2);
 }
=20
 static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host, u32 bit)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 807aa152b5ff..5dafb00cdba2 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -103,6 +103,7 @@
=20
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
+#define TMIO_MASK_INIT_RCAR2	0x8b7f031d /* Initial value for R-Car Gen2+ *=
/
 #define TMIO_MASK_ALL           0x837f031d
 #define TMIO_MASK_READOP  (TMIO_STAT_RXRDY | TMIO_STAT_DATAEND)
 #define TMIO_MASK_WRITEOP (TMIO_STAT_TXRQ | TMIO_STAT_DATAEND)
--=20
2.34.1

