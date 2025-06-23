Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79575C77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:32 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.web10.373.1750690051247688009
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DUTwU6z7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8PX4Fns3sNBuKQ6mOxdzBZk+dLSpFIe1prWanTB7Oi+A2HxRkXUdIJ/YFqqsyiLakGQyvgI65csQvjTxbaUUZWzthSEoJE1upVmXuicYOFdH+43VuIHCjisL13iAlWEDa9ffss+VF4GhjsTsfGYERyuIrsPaL3i8wJAOa8fExTrU1ZvKp2PB4X/X2RDMfsVZhi4eQEP8kONiq2mL6j/+ha5YHMd5BAlwd/Nc55YrrrgaUpCkHE2cGjDwfVLEg6It98q3KL3cuKCvUVloXSRTPt4mjpqZjcC5TW6UaC/h2goLFpqA8TNau3XF6PFBqia8EtGMdZ6gjp1z2ydL8IyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj/gMLPQbpwW1Fy7Loi5n7ERzhrspuH42QZy64ut4XQ=;
 b=R3qn2lQWsvMLO060ZFVtMMlXD1A8smRsGTMRL2/NnMvJ9rQIJ6Sobq8Fz+y1xPWVb0Ep/0EBH7SjjbF0fOBTXhKlZUZNAG+isGkUytU2IKuiSsRzRJnJlmYDjvrOv5NsV0tydAO9tuQFHMcvMBTtqZrPl8QfFoOQirBPeigKHyy7a8p4bUZEW8TTnwI9HgQS8Bdq1JRWIwb7B97RFReo6UwWZ2LimUq7I0voYPC+hf4uBuUp8rXidGw4EKfnTlyd8HRRmztC51UfrAmCA7zcxYJsuEylWs4B83kPPwNpbA9oMYs+xuozxtV5oB+bklliWGBmHoD1Bz7QwCdE+nlhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj/gMLPQbpwW1Fy7Loi5n7ERzhrspuH42QZy64ut4XQ=;
 b=DUTwU6z7uKW2TW2gsprDndU15/cQIj3QA9H6vYdvZAGNS9eObpeswEByYkLEoKp7KZaWfs/zIgjDlQzMVUcSDpaeTODDVviOhuV4myN5IE+fmZmSaoHusu8ON7FXEawkU89SoM53rp2/oJ0BWPybZLxyOzZ57/yUIrDDvZS5BjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/17] mmc: renesas_sdhi: add helper to access quirks
Date: Mon, 23 Jun 2025 16:46:30 +0200
Message-ID: <20250623144639.2119707-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44b82205-6198-4476-9f9d-08ddb264e02e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7PtIXU7MJfUmEJPnnadKDfUsoVdAqfDCRG/YQQIJatlR7b8Fzom4cffJlJHU?=
 =?us-ascii?Q?Pw7kKUCgDbjJWbbfVREncJQBqXTciYuCj3VHd14r+jdS5DzfJVDDGKfN1FTc?=
 =?us-ascii?Q?oY6m6A6lXus5mhlymJ8kWr03BMEyqPTZDSlZiPk1ieklqBuzxqYlmZrBcucM?=
 =?us-ascii?Q?SegBQB8QOiRqnwz1PLteTNNeTP1XjdqSvGPJ/yWsyoHknSVKLgWIvypsrZRa?=
 =?us-ascii?Q?aJ5TeOUomInpp4hZbPsJMaeaTOW701gWX3BX0pic9cxkjBzw9ylO6Tiu+D1B?=
 =?us-ascii?Q?nQ9MdLrM0irSpgAZ5xyIiDv+JaqKlA9hAnhweG/Py1MLdP2RvzX63QsHkR5e?=
 =?us-ascii?Q?3IwmqhOuNqR7/aLOoB9g7ODtg7lrh+fzEr6Qa55TV16Tzmh30eSKIcVPMq/s?=
 =?us-ascii?Q?OMpTWmSNe2J8V1PVBMMqSEaUBVMKrQLDYyKcm77ZM5i0A6ot6YUi9o+uLjS0?=
 =?us-ascii?Q?oHzrXEQjqlPwfu7iRwknmOm4EMpBW8ilS+4mgJk5OTM5HsfKFZmX+zq5q6T+?=
 =?us-ascii?Q?oP8bD6pewSXz4wH/qjF/xDNyknBOd0M5ACz7NOwmbj9edTPzIUE98sw0vvME?=
 =?us-ascii?Q?hfIaSAZPC+P3s86kCZgzmR+l/4uF+6J1lYoYQZBU9ZWI/OBqzfiInxSrZyY9?=
 =?us-ascii?Q?/UO98KwdaZptWz93NY4Ei5xwM8rqQ7vy21rxHWkcYLeN+k+I/f5q3iwEFcaZ?=
 =?us-ascii?Q?1+Ec3xe3JpBM72fZb5TwCgYIZ/gMw6pUJ24y77/ShGEAR5vTPFR+jr9gbq9u?=
 =?us-ascii?Q?RczptmtlrxIMkfKooQwBG6XWgwfp34EgHzAqn1UCweuRDIXu6SCREuakVR85?=
 =?us-ascii?Q?lA8UR1gElq5xA1gEC69tt9s+J7Qy0nzYlMHlzn/M6B1DW4LH3iM/a3KCA4vp?=
 =?us-ascii?Q?tfeACVLKEXVTh4fEu0BzP7cxqYkqPriM7nkeSm+TDXzExmWVmPc3zw4YRCEN?=
 =?us-ascii?Q?XAyDrNiMpNbVsurDfjiZZictSLu0zyUIBh9XoKTnWpNBL/Q15QePDE4bNrXu?=
 =?us-ascii?Q?QpIJVcCVwfb5R/kkcGy6T9C6yA+/5mGhLdIf2FP71KRhjjRf6QJSx++Xwm4G?=
 =?us-ascii?Q?xFRkiYGavp6IPmA1LdKmA5nosnXhZR4DKIse0qDsbC/EIc7DqHSpI/X3bq1E?=
 =?us-ascii?Q?3L6c1w0y0ONU7vOC+FRtkD6sicid33PsK+sZhdxo65js4bRK2QkE1blL2+x+?=
 =?us-ascii?Q?sVq53GVyflS5tI/LsKl09QkBBuO6LqNq0lwew8P+zXTEDnVtqNnyPo0/nBNm?=
 =?us-ascii?Q?PVItF76BrnhI7cqWR9mQ+1pfpXRY1SDQB41RfFCMHS3tsWTVPf4TVOjXbOon?=
 =?us-ascii?Q?696hHOnh0dalN3DnKvck/VQnwO68uOMP+XJVVXvk7zE+wT0cnosLKBzUMUfo?=
 =?us-ascii?Q?BcB60M3qJaxXQ1Um1umdoEwCqJmkEhjOU/4Lu/RsMhJMsw5QMbpBKuGuH9r/?=
 =?us-ascii?Q?kzUS23GO3tY590NQ2lx8E4IYwQxGfKgRPGI3lOO74Y242nRAiE5/XadOoIL/?=
 =?us-ascii?Q?DElFnAZY655ghPs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PNro5adjlFeIgnYSST6oHgGO2v0Z9N0KxfAabphTlQ1qTkJaBxTUFum8+6Xg?=
 =?us-ascii?Q?fwHM1AO2PxMDeCqqXiULZsQ6poh8wAryTtJfzIrersB4FlYX7MlSfgqNHcHL?=
 =?us-ascii?Q?o5eM+1fH1Xt+8mvCVazP9qlDC4Cddphd94BZWAC/rbHMg1C5Cpi9/parBBg0?=
 =?us-ascii?Q?lp7qKH/sJfSHFiOQxtywlKCI+Hg9BFlyaebNJpCNXcPxPDVy+2GI9gEPEpCL?=
 =?us-ascii?Q?q66idLnHfIx/mPu2EeI4O+DuWDF8F0CcoyKUr3aPEd2Hl7iL8ap6uSN7ivGw?=
 =?us-ascii?Q?n33iTw3fhDT+/I9DFfdypLfKldf0j5/5B/w76QmtFF84hObZx6EzCUKW4G1W?=
 =?us-ascii?Q?mJgj+81Jmif4dn1WPXOkhXH/Jugckd/C783hj9lIshUZ0hJG2tsXfrQj8Uws?=
 =?us-ascii?Q?DWDmehwAVHuuRqULF3WT4xeCQ6WKTCF7azYrCaAjslAmpT3CnpvRqy6jrria?=
 =?us-ascii?Q?3LjPqnH8tehIhOKG8YxwfL4j+BRaw0YrVyvxmuwv1B+9BSn2R3hZCJsfSL3q?=
 =?us-ascii?Q?WhTJaOg2eP4B1mHuyuAxieSFKY+0h5AWMz34OSRlTR7lW/71+ymljG+CzpTh?=
 =?us-ascii?Q?7tHIB28HwCbFTUFWPnPD3kL4VRed9jXgaABBfW89kp4RAfclzFP32X0u6c3K?=
 =?us-ascii?Q?5KJWmHETWDWo3BcqFGYM27bWVvyTDasnLUymGeKEnRV/nIBR0dyyiRfv2idk?=
 =?us-ascii?Q?xWxhdqRRG4x7+PsSDLSW6tGQmCaY7CymLC8yXPjgRGHJ58Tm6q6367VifXG2?=
 =?us-ascii?Q?9h4WBdR6PvhRoOwNgyVZ2DlcD3UNDypHYHU5qB06IUc/Vc105/V/ZHldRNfG?=
 =?us-ascii?Q?9t1STI3QPHrWhJo4+qxT9zLSzUcx7KfYODUDof1el24XfDMddqSxZz6bC8I9?=
 =?us-ascii?Q?ZMvnFWX0MolwvrZc5w5abSxpdC+GKrAxYIPbFv46CuOKpW3Hl2TvvUTNaFb/?=
 =?us-ascii?Q?NuxoBPLBLhIJHfouUKjN2LBrvOBVnHw7oblNLXSZvAf9poqjb8+LPqKfatrC?=
 =?us-ascii?Q?qDaMP0tfCyKTVja7NxLzsHFqLA787TM1TNk0kCX17xLhhWiaT1kaSj8uD8gq?=
 =?us-ascii?Q?XZrISunHcg1Odd+66UQWDoUnHKrwDm47ivCWHKfJqtGWjtxIWZHreOfm/3VB?=
 =?us-ascii?Q?CJQ85oBkFxhZMiAC/SMk/f6K8paqQwSMGMPEgI2Lwso4t4KeG3re0gKsQdWS?=
 =?us-ascii?Q?yud84C3BKIBqlEHDw1/6/N8tFLh0jelEL2Qw2GJPIU1DgtqgZJZnxOVMifTB?=
 =?us-ascii?Q?cjSDo6bzl1AUtBKqdAhj5EcV9OLWOxJHGvRhIn37grroxpu90woUgOiLX3bV?=
 =?us-ascii?Q?th2Dw3DvFPxfLUt9bXmeubCc9d46F0CtO6PG0J7vcReVvYQ+N2nv+pnEYCTy?=
 =?us-ascii?Q?xkSOIdo44gyY6Q0jPgXj8cDA5zuSTj5SomcbGP3yxk0yRDaB36M/VIMeEXcQ?=
 =?us-ascii?Q?64PZ+Q74xSF49xIzQYMFTHM0u7xzBzHILXCdtNlkrtfGUgtxGQ8HvWtHl5iN?=
 =?us-ascii?Q?Ef4SDN4MrFH65FoQHA2KV9Ps9Mwrcc36Q4DB4ShiVQx/PhXLQ4xTRAYru10O?=
 =?us-ascii?Q?kx87xhyzGeh/ZMYptX1pnyaLynPa5mqxFO7YtmxdBoy7GAW9mcwKu/9PEg5h?=
 =?us-ascii?Q?S3CPZ39d0DBkJRHpNGMiR04=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b82205-6198-4476-9f9d-08ddb264e02e
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:28.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgJxYegeofb7fJy2swn5IOKKecT2AMAJ1efLTTgS+eAOIZiXZzMokJA/YlEymPpudb0K/ZRqsZwGZNWJ3vNlpB5CcnTKxhAeYYwBV760EqVt4561XcfdjO7SxA1H0d52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19195

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 48c917fa998c00980167ba732c8ccbf603c9fb70 upstream.

Add a macro to check for a quirk because it a) ensures that the check
for non-empty 'quirks' struct is not forgotten and b) is easier to read.
Convert existing quirk access as well.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221120113457.42010-4-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 18 +++++++++---------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  8 ++++----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index 8f96457c9739..ea2a85174a09 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -38,6 +38,8 @@ struct renesas_sdhi_of_data {
=20
 #define SDHI_CALIB_TABLE_MAX 32
=20
+#define sdhi_has_quirk(p, q) ((p)->quirks && (p)->quirks->q)
+
 struct renesas_sdhi_quirks {
 	bool hs400_disabled;
 	bool hs400_4taps;
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 3ec5695b58ca..4052ef027647 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -141,7 +141,7 @@ static unsigned int renesas_sdhi_clk_update(struct tmio=
_mmc_host *host,
=20
 	if (priv->clkh) {
 		/* HS400 with 4TAP needs different clock settings */
-		bool use_4tap =3D priv->quirks && priv->quirks->hs400_4taps;
+		bool use_4tap =3D sdhi_has_quirk(priv, hs400_4taps);
 		bool need_slow_clkh =3D host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS40=
0;
 		clkh_shift =3D use_4tap && need_slow_clkh ? 1 : 2;
 		ref_clk =3D priv->clkh;
@@ -383,7 +383,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host=
 *mmc)
 	struct tmio_mmc_host *host =3D mmc_priv(mmc);
 	struct renesas_sdhi *priv =3D host_to_priv(host);
 	u32 bad_taps =3D priv->quirks ? priv->quirks->hs400_bad_taps : 0;
-	bool use_4tap =3D priv->quirks && priv->quirks->hs400_4taps;
+	bool use_4tap =3D sdhi_has_quirk(priv, hs400_4taps);
=20
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
@@ -395,7 +395,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host=
 *mmc)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
 		       priv->scc_tappos_hs400);
=20
-	if (priv->quirks && priv->quirks->manual_tap_correction)
+	if (sdhi_has_quirk(priv, manual_tap_correction))
 		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
 			       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
@@ -546,7 +546,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_m=
mc_host *host,
 			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
 			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
=20
-	if (priv->quirks && (priv->quirks->hs400_calib_table || priv->quirks->hs4=
00_bad_taps))
+	if (sdhi_has_quirk(priv, hs400_calib_table) || sdhi_has_quirk(priv, hs400=
_bad_taps))
 		renesas_sdhi_adjust_hs400_mode_disable(host);
=20
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
@@ -732,7 +732,7 @@ static bool renesas_sdhi_manual_correction(struct tmio_=
mmc_host *host, bool use_
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
=20
 	/* Change TAP position according to correction status */
-	if (priv->quirks && priv->quirks->manual_tap_correction &&
+	if (sdhi_has_quirk(priv, manual_tap_correction) &&
 	    host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS400) {
 		u32 bad_taps =3D priv->quirks ? priv->quirks->hs400_bad_taps : 0;
 		/*
@@ -796,7 +796,7 @@ static bool renesas_sdhi_check_scc_error(struct tmio_mm=
c_host *host,
 					 struct mmc_request *mrq)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
-	bool use_4tap =3D priv->quirks && priv->quirks->hs400_4taps;
+	bool use_4tap =3D sdhi_has_quirk(priv, hs400_4taps);
 	bool ret =3D false;
=20
 	/*
@@ -990,7 +990,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	host->multi_io_quirk	=3D renesas_sdhi_multi_io_quirk;
 	host->dma_ops		=3D dma_ops;
=20
-	if (quirks && quirks->hs400_disabled)
+	if (sdhi_has_quirk(priv, hs400_disabled))
 		host->mmc->caps2 &=3D ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
=20
 	/* For some SoC, we disable internal WP. GPIO may override this */
@@ -1058,7 +1058,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ver =3D=3D SDHI_VER_GEN2_SDR50)
 		mmc_data->flags &=3D ~TMIO_MMC_HAVE_CBSY;
=20
-	if (ver =3D=3D SDHI_VER_GEN3_SDMMC && quirks && quirks->hs400_calib_table=
) {
+	if (ver =3D=3D SDHI_VER_GEN3_SDMMC && sdhi_has_quirk(priv, hs400_calib_ta=
ble)) {
 		host->fixup_request =3D renesas_sdhi_fixup_request;
 		priv->adjust_hs400_calib_table =3D *(
 			res->start =3D=3D SDHI_GEN3_MMC0_ADDR ?
@@ -1079,7 +1079,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	    host->mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR |
 				MMC_CAP2_HS400_1_8V))) {
 		const struct renesas_sdhi_scc *taps =3D of_data->taps;
-		bool use_4tap =3D quirks && quirks->hs400_4taps;
+		bool use_4tap =3D sdhi_has_quirk(priv, hs400_4taps);
 		bool hit =3D false;
=20
 		for (i =3D 0; i < of_data->taps_num; i++) {
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/ho=
st/renesas_sdhi_internal_dmac.c
index fc76370daec0..56fa2bc7146d 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -298,7 +298,7 @@ renesas_sdhi_internal_dmac_enable_dma(struct tmio_mmc_h=
ost *host, bool enable)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
 	u32 dma_irqs =3D INFO1_DTRANEND0 |
-			(priv->quirks && priv->quirks->old_info1_layout ?
+			(sdhi_has_quirk(priv, old_info1_layout) ?
 			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
=20
 	if (!host->chan_tx || !host->chan_rx)
@@ -331,7 +331,7 @@ static bool renesas_sdhi_internal_dmac_dma_irq(struct t=
mio_mmc_host *host)
 	struct renesas_sdhi_dma *dma_priv =3D &priv->dma_priv;
=20
 	u32 dma_irqs =3D INFO1_DTRANEND0 |
-			(priv->quirks && priv->quirks->old_info1_layout ?
+			(sdhi_has_quirk(priv, old_info1_layout) ?
 			INFO1_DTRANEND1_OLD : INFO1_DTRANEND1);
 	u32 status =3D readl(host->ctl + DM_CM_INFO1);
=20
@@ -409,7 +409,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_ho=
st *host,
 	struct scatterlist *sg =3D host->sg_ptr;
 	u32 dtran_mode =3D DTRAN_MODE_BUS_WIDTH;
=20
-	if (!(priv->quirks && priv->quirks->fixed_addr_mode))
+	if (!sdhi_has_quirk(priv, fixed_addr_mode))
 		dtran_mode |=3D DTRAN_MODE_ADDR_MODE;
=20
 	if (!renesas_sdhi_internal_dmac_map(host, data, COOKIE_MAPPED))
@@ -417,7 +417,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_ho=
st *host,
=20
 	if (data->flags & MMC_DATA_READ) {
 		dtran_mode |=3D DTRAN_MODE_CH_NUM_CH1;
-		if (priv->quirks && priv->quirks->dma_one_rx_only &&
+		if (sdhi_has_quirk(priv, dma_one_rx_only) &&
 		    test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
 			goto force_pio_with_unmap;
 	} else {
--=20
2.43.0


