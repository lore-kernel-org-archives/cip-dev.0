Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D9C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:32 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web10.367.1750690043964809166
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YkS+UPNd;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDxDszf8FrobodWnhCM1suLdut4pGPFSyS8lBV9WbssIw1nhouBDtsEoSNgvgrNES3XGx3bs3PBk47yLnTsiqCvnmev3EH7W/nj7rFXyMiZqrg036ZcT+FdEuuncGtO6KocRvk5/g9nF/Goi/DcDNs+ra5wdEptuxt7ZjGBdPiR9vpnKkqmrVckW3uV8kvazjlLE+koK8+t+SiS/8VGOnlmP3mcQazsLUO8nZPCMbcf3ou/aHCbIDmAToOADvLP0/AfIhxYbZj3eHRN8Zb32vP+MGy0LvaA2nQYPungjz9TThv5z74j4V0DSAVnc29hnMN56ZG8sqsJP+Rz5r14auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUSYalGHX5P44lb6ZnY08RBKqTJWmfjzcW5k86Qzed8=;
 b=ej3G5WvpUEUo+jmncdUZAFkUagcbx6l+rnwUT4DmEz+xmuU8bWGaV5koQKZ5X3M8iysqjV9k+4IxMkE4bu9rIGT6RFJKMqc3fGJdTDVHsoOMjBfq5qnCrZs+WSoG+MYxIyk0XnrpG8FOt29AKxQqzwau04Urfgk5o7yhW1nvwOd3GtQPUkSya9cpPHHXQMbPIpzRa56LG8aVO4KvB26zYVI2z+8vP+sjid32J2pZrEW2dgWwhHZZdbuHu3YVEguPbNUSNPMRS5DS3hxb4jrdTLTbukMZZIeSQNoh3EyyHs4gz0eu056eR6r9y6Aj2iLUA3Axc+XRKxGzwArGme2qlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUSYalGHX5P44lb6ZnY08RBKqTJWmfjzcW5k86Qzed8=;
 b=YkS+UPNdtYDhDgTwR0zo3SuhaeEIJPuWsXdzkFmWF7MSf8oE9JWGDZ3EOtq4KRX+msm90Tq7s3tvoY5yGoJXVHa7CLHJTKfZ9WZIXDTgEWT5MQNeJytt4nQJhmBnZY07H2aPmPbKcgpKQB1DLP3PAjoCrXgPcXbo2WsuKRHV05M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:20 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/17] mmc: renesas_sdhi: improve naming of DMA struct
Date: Mon, 23 Jun 2025 16:46:27 +0200
Message-ID: <20250623144639.2119707-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: ecd9b287-3d21-4f27-9c1f-08ddb264db3b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G6Gu0vihjDsvXS4uD4pcE3kNUGOWsD76rlFBj8qQu8KTVjLdAwxViVNIgIx8?=
 =?us-ascii?Q?hEZawxMub0AJYFev8Tm6MJTNeLGzuEbvAtyGjxDwPEpN5It3JkFXR93Y4M/T?=
 =?us-ascii?Q?X0lJ8A8TVqvfs9Cb18elHHLdWW+/9JqlUoHvGZAGcxafVZH278jdLLuWCYFj?=
 =?us-ascii?Q?3mPBCkA7wwkIsGCqcgZvGSLIEVf0GcXLMa1ymCaoV3VAesovUbT7oab3GL5l?=
 =?us-ascii?Q?NEVYaX2x5lwUKspQkf9eWYqFvyxFUaYHyJpmgzsPlnPhXDUOY5cQW8n+NurG?=
 =?us-ascii?Q?mVCITA8V9lMIDhdlG/oQ8Oybetv0B08uqzPX5pXAmenUPzrRKJG4sQr6WRkc?=
 =?us-ascii?Q?tHi+cpCR4vVRizy7iOobVQqzRFy+h0Cx9xPD6L7+K6+03cGGK1KtqdVYxzIc?=
 =?us-ascii?Q?TnA7oXFEPYK0h1drtos/CzVFjZfxqMv2+Z54Hx7Mxg2DpXdcUeFF82DOeeu2?=
 =?us-ascii?Q?4KGlhDQNrvbV/xdFfdaMhpWb8EidYQhnZ4qUazIE2vQ79r0S5PvsQK1HVEkx?=
 =?us-ascii?Q?YuCuabvFtP9GiQwmrcd9gpA1XW3NynCkyHaNUKB4cTYnCNhtv8c4TwTyalvR?=
 =?us-ascii?Q?qgC+cbfEwnU5QL++gI1fxSG7R9hrJF4OkxAxCp+bfHwQv9MmOR7ZQC4icxia?=
 =?us-ascii?Q?Qr7HEr/5hUIiOKtf3/U7lG5eNNY6n70e8b3AKVB4jb00Z9dP45+XuhJBcp1w?=
 =?us-ascii?Q?77L3mC30Ilc/Yud0vF09sr/GUdlQ9YLBIbjyjS1166jzpkDbPnX6L+6W7GX8?=
 =?us-ascii?Q?Jumhd0HI0jXYk7uQd27bELwITYNGam9NmPZ6M+xFsysMNowmJMRfLD0Z+2Uy?=
 =?us-ascii?Q?4xNPeWY5f/7B3qH7DJly+dvDOV3jMQ+dOh8oDODKtZpDBFlXWffWF6o3gP1k?=
 =?us-ascii?Q?YE4uciXeME31BRgJEcLDG6n8hcuopuWG5B1uB87XCvJ53Q7xW2G1FyI6+4YU?=
 =?us-ascii?Q?AWP3AG2c8INBaOwpZqn1SmUTD+iCgOBSxDsgs+XyW3TWKar7J5TT4+mOPRPA?=
 =?us-ascii?Q?53wBnihSFxxN7TSYY2fjgNzNVMZB9P5K25eT1i+LPPyV/x/ODu1K8oby18sq?=
 =?us-ascii?Q?kYSIL8Faz0UjeVXYipiLPDlANRm/jzoQrfV7lr6pVl2TzvGGinVeg+TtiqkZ?=
 =?us-ascii?Q?82N0yJAxwPpbHOQjLvqWRZaI6ABQxk1vpv6eG/4o8bCGU0XKHFiGNBj/UOot?=
 =?us-ascii?Q?7XM9F+8Nas1z+pdt1wSsTsTp3gIr1/Im5ZNFVY5PJV3Mo7oJFmtEe/wncN3n?=
 =?us-ascii?Q?vDJXJHD1mu5WZMJvdSMfOXhambc3wLZxGrxYFbwfbt8y+S3uq4Ri0apkBNHL?=
 =?us-ascii?Q?MJsWWYloTh5+sqm21ibPh2E9gRNQ8DUg6RZG6074TbviEzpW27nOhQRZVz9G?=
 =?us-ascii?Q?fEVlDmr3f989cYh9nQMZECf7d5vkgjSvXuM8ZiyTu/RbdzwQYeigqRDiLk0M?=
 =?us-ascii?Q?JKTCmNLUPNwlalHufSIZ2M4OCTDHHuzosa85RFB3r0isz1kjXu663CqsoU4/?=
 =?us-ascii?Q?acrC7Snu1Lg4RYk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xlVv2fYDIenExUBt3PddvpyVjIvxF6b/1KEq4EzcbZXHPndZUrOCrqQGKGpl?=
 =?us-ascii?Q?fWOfhsv9ZgPrig65xypfHCWhnmReD2qfuHNtp9af+7IHWIdiAYTlUR9t/3Ty?=
 =?us-ascii?Q?2eJhJFO+/a56lW0ewVuZRMxDJeErU4eUDnznFytrp37UNgo6RE5zNEcuwk+b?=
 =?us-ascii?Q?Mg8g04wmzSy74bjC/AVMEc7V0w84LqgfQKMEo+Jo9jtROUUIxhaqwvd/66a8?=
 =?us-ascii?Q?8rcAWkL8pUSbM4Pjwei3w46EIxAZ0upz0TFEPf1ikiO/7e3jVxRp9vUWmEvE?=
 =?us-ascii?Q?G349fOXG0A706t0xrn9jdRKLhrDmJn6lINYKiCg3a+klj9PRjNAefbPOfokl?=
 =?us-ascii?Q?HvymBlIj6oKWUOburd9D+6PyMD9QxLSfCgG2rKBewhzNuPM/OaFsIznmf3E9?=
 =?us-ascii?Q?TdLC4LDyh28ni/S7E6C+jd4ZnjVkhR3qh6yaL/Pe9f666DdjJfQNDI2uudNO?=
 =?us-ascii?Q?jy+b/O7BjaZy8ucdtLVe8EIGGzugdDJyPjuVFxZsKpPxR03fgVAk5Ve3BXAb?=
 =?us-ascii?Q?UlAEMHztDLjxiAw7DUoFLqpG/lp3ayRIKeVcCEY2k3HB0oKll+kpGkPoncUH?=
 =?us-ascii?Q?SukikFJnvNTOG0I0nY7v8onKtY/y6CqkTirU8h4lcO+TNhaImyS625ubF8uT?=
 =?us-ascii?Q?GfV4joOvKOP3tFsoKLLqmVLIa9MuVZi/sn+bVK304GtNQzum6FV4QBbh8TUv?=
 =?us-ascii?Q?ac/PZ855H2R+M0s9ojLBpJhz7kL+2vxIznJHkbRaDCRGVdSoNHDLjTd0RRW4?=
 =?us-ascii?Q?pa/gSvCzD799g4cdTC9+ZQ8lKOLuMsQYgY6+ohQCvhSzT0aDddoSE01+Z9WM?=
 =?us-ascii?Q?MdfUQICsVzezrpYKvi/mQqRUkTdYzb/b90PLmb6y4mhwieSVMXE4FKKm7Nqy?=
 =?us-ascii?Q?iRv4Cik40mWXVsjXmNlqIw+3nnWoExbPIs6SVecUysKJvjscOAYpPcBJthQY?=
 =?us-ascii?Q?3abADBj7HCVeGe4YFgpzh2SLXAUBYVNtZqfT1HnwbuRnVqIYk8IR3kvq6RFI?=
 =?us-ascii?Q?VNbxChsYRTyR+oNCFfqIWYy5yb5k4TgYSMi72bn91Y1RUM8SEo2X2e6MvPrZ?=
 =?us-ascii?Q?a2h6zwfO0/n1YlL+tyc31lYBtYZE5xpriTxpLin0wgR8x7XPcwWt/VKeTtpN?=
 =?us-ascii?Q?57rRapuJ3hEZOm4cOekexuVaj7kmobzxYtXnbM3A/rtIT5ITAdoiTV/Jxuab?=
 =?us-ascii?Q?TgFZykIAL16robAmJr7+JBXXHVZJgBZobA8iQ0sOpCw+oy4VmJ+xv7Mi9IrO?=
 =?us-ascii?Q?0uKJAGLcVR2GEmoLJtqU6Jx24976ctSPIyk4VPugi8ESeNhGAa3GPICE6zAd?=
 =?us-ascii?Q?/DOekuA5pazHQlMpZTShpLJbXuQZOzGMH0TftxYwCCaH9R0J1ZDs5gmTT1FI?=
 =?us-ascii?Q?CQRCMDhgzV4yRPElqoUr2IJL5cIMyQu0qcogCJZt719neb3l1dBPoqGtDk61?=
 =?us-ascii?Q?Mb9I4DUR/SaSHRcg4dkZhAobomgsSPIep31OV2HCZzLPp9mjh0+4KutCI3z+?=
 =?us-ascii?Q?x7Ir/Sv6jGmTQX0uLTiZO4gv3r2zy3LGgmBSHgwG8JsVCOHbfTrtV5a5i8Gy?=
 =?us-ascii?Q?/qEJh8SKh1IWpyn3fYVAHOgQY7f8ftcaWVbAGQQGbHooWt/6b2yxWG+w0OxC?=
 =?us-ascii?Q?/JDMDAhjQN1QWoqgHqHRXJk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd9b287-3d21-4f27-9c1f-08ddb264db3b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:20.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WBW43p4A4/oGoNEhcuTyqEYDYPYqvUYKPBjJdmMiMNde9GgtB0WMp4PVqJrn7rJ6yzbIfR+MqnDPz1uIKIp66r/SwTB8+zeN5sUAEHfyduDFZlpq6Q+cqRZbE7rM9AE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19192

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7f3ea248cd1b2ea9b49f6f3523250bc8e622dd5e upstream.

Commit 058db2868cd8 ("mmc: tmio, renesas_sdhi: move struct tmio_mmc_dma
to renesas_sdhi.h") is correct. The DMA struct should be prefixed with
'renesas_sdhi' to avoid confusion about is namespace. Fix some
indentation while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-3-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      | 8 ++++----
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index e4c490729c98..fa88b721364c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -54,12 +54,12 @@ struct renesas_sdhi_of_data_with_quirks {
 	const struct renesas_sdhi_quirks *quirks;
 };
=20
-struct tmio_mmc_dma {
+struct renesas_sdhi_dma {
 	enum dma_slave_buswidth dma_buswidth;
 	bool (*filter)(struct dma_chan *chan, void *arg);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
-	struct completion	dma_dataend;
-	struct tasklet_struct	dma_complete;
+	struct completion dma_dataend;
+	struct tasklet_struct dma_complete;
 };
=20
 struct renesas_sdhi {
@@ -67,7 +67,7 @@ struct renesas_sdhi {
 	struct clk *clkh;
 	struct clk *clk_cd;
 	struct tmio_mmc_data mmc_data;
-	struct tmio_mmc_dma dma_priv;
+	struct renesas_sdhi_dma dma_priv;
 	const struct renesas_sdhi_quirks *quirks;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default, *pins_uhs;
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index d0a15645a0b8..3ec5695b58ca 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -908,7 +908,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 {
 	struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
 	struct tmio_mmc_data *mmc_data;
-	struct tmio_mmc_dma *dma_priv;
+	struct renesas_sdhi_dma *dma_priv;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
--=20
2.43.0


