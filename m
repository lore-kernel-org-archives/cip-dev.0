Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.835.1795110950356312629
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=bz5/oQ1r;
 spf=pass (domain: renesas.com, ip: 40.107.74.66, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFMn5jeMzfdDMZpPu3CMf0vGwX1pvpJwo1xvNZ7Nz9fr5fyBR4DuFZps8S8NYbqHi1QTKaSikQ8g+E6LX/heMQYkc4svnTYuKRl2WMchVcTvUIBpNef5DOs16aGl3AMfqCalGY5k/VGez0pCQ5nEq0AWvhOlkZBgJqc3ocJPjp4t5M0mJyQA5goYYcBV7DNlefnDY48YHn86qTbEdHV2l/b+uA7JIlUGs8KIdyUYOy4EkQSxvVVh+xJOZ/Tw6c+dN2fmHdwsEqw7sS1Dk3Iu7+W9gHWGKdOTl504cfVlHnTKuT+W6hu3K2nD9CoLvidRT/Zg85si1WMXEGH9xQzhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwYaQIWOGfbhCSNDNNkmRQaooRJhfVNMTBWk91NlIeg=;
 b=jLKwyfrfhgvKNcA2yqoWUfpBeVyYz07HIY3TgOdeavf0E1uer+SSckA4BxVq0syOLcLecH2HnLjUGP2S04IbwpUJMIwIH8b19KoUeOKqrKoKgrLgkRlnrbEANQ84MXhJDwXvc7FE4OPVlH4PW/48WsazquLoY9rlqQQtXlvNtemf6S+ph47jBy177nFIOeqzyrC9OvHvJOe5St30DX893x+LMFs3jSnKdbA+JW7kJeD9crKW/NZdfD6OhA6WRahVoja0lfPZP2gGdMMIRVMKOj9ImlgQxPTz9EhsCTW4LsuCS3PBzUF0i+e5lm3S2LsyMhJjyf8h1fWltfHV89YkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwYaQIWOGfbhCSNDNNkmRQaooRJhfVNMTBWk91NlIeg=;
 b=bz5/oQ1rdgWj39SL8DfNYm0N3SrtQhsR6yLSuNuIU7D63DnFwHG5aaAMSP7VviBGrknS7A+TZC99Vh9IeoIFoKUUyj/kqDpG04hw6dlgJJDxnkjltBLHp2GZDRMrgY/NllQiVn0OIxzPJNjVYjgYzuJ5DNhwvUT8DcV0pHhzhyY=
Received: from TYCPR01CA0187.jpnprd01.prod.outlook.com (2603:1096:400:2b0::8)
 by OSCPR01MB12736.jpnprd01.prod.outlook.com (2603:1096:604:337::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:45 +0000
Received: from TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::17) by TYCPR01CA0187.outlook.office365.com
 (2603:1096:400:2b0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005623.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:44 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E9F92300024B;
	Fri, 20 Nov 2026 02:55:42 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 5/8] mmc: renesas_sdhi: Add manual correction
Date: Thu, 19 Nov 2026 17:55:30 +0000
Message-ID: <20261119175533.110210-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005623:EE_|OSCPR01MB12736:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b342323-dc72-45c6-fb5c-08df46665559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|22082099003|13003099007|261026121527099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: KChhFx9f+5nUlzEqHTKtbc30Maz4vU8iz0K7260YJdXDl7/1XNF4VBcWg9ZZiacn5AdTfBBahcMeHRvx1cKGx1o1LRxImDk65N1xlUf6ZXIuA4Vdbo5ZIZxgkP3fAwPrPoaJFojzk5fF5En8dNsja047i8kMFBjZxn21U4Ihi8O1mtN5dhbmRXjysUAXtmcch+ntCsyEgn2+2kJwW7dnoGPA+TBEEdF5ak5VSiXBmylb2r64HbBwK39TR16VVfVnbPo2MEO5Iyx9cM6P0LaG3gylS078Hg+b7tH12P47yg+bVeFrhDd8FE5vx2HeZOXPNjs6KqMRVO0e9Jjgw+f3+h2kqEvFVCnoknoTT7LyJYdnH3mWCwdr2P3Vvb/Ucl8G8z/qDK6JH2605kbPAyzANXBzw5Qee68q50FuMXCj+68yojyTMRKZWqCJnUNVFeiDuANaoGsD8jxwIyrBVBEkOh2u1XgxtGyyEYKQY1M2xiS60aFAV24LYjxYLTZyjjoW6BuczGpimWB/G5p/vvK2fxeFJPqJpKp9pNOwKL97KIRfzfgpWEmTDIeAd37EkCAVVF/QFzrd05thj1oj1Y9G7mm6jtloClZecY4tzalKB05sbRC7GeeSfXkL5nShaWkgdaVlerBkyRw7DbUOX5z4UA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(13003099007)(261026121527099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +bgRU+pQJCHZT3BljheePXtSGlz/6EwYq8s8QyFMZovdgbXhfR3Pd8h3F4g1wz9eGaZwN9KgP50pbPxd8XdXRoA0C1JKRMxh6wS5v+VSQ10XoXCmsEVkqsw1XpbzuEn2kA20VOEbL4HM/nL8EIIqQZZlvgjWiEBmfiET7mtlTGTeKv4m68QIIdp4/YLZSd4t765hgiKsohTr8S6vKmgLXChD5/dAtYroJsokkWnJuCxaT4KMPV7O73ivqrZ4uWHeWnZwZPU73eI39FiRO5ZtL39eIv3REdB7m3kL6QgKQAAz3jqxRxuURpLlJPrWw7ZyD26hoTwX4/3SDIdaEuDFUk/nfZ5Wmky22U/SLZpyLyAoQp5W5pFVMwLMPl8WSjUKaBdsLZzAgbYOvGmftBOSJdV2nlQQ6gIHr/1xtoj7k3KpS4AIyeOh5hmrK0IhfBgh
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:44.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b342323-dc72-45c6-fb5c-08df46665559
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005623.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12736
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25021
Content-Type: text/plain; charset="utf-8"

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit 11a219606a9bc7f1fcdb4fde285100fd8a601d0d upstream.

This patch adds a manual correction mechanism for SDHI. Currently, SDHI
uses automatic TAP position correction. However, TAP position can also
be corrected manually via correction error status flags.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20191217114034.13290-3-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      |  1 +
 drivers/mmc/host/renesas_sdhi_core.c | 61 +++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index d58fcfaa8d50..7bac2422f0c5 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -54,6 +54,7 @@ struct renesas_sdhi {
 	void __iomem *scc_ctl;
 	u32 scc_tappos;
 	u32 scc_tappos_hs400;
+	bool doing_tune;
 };
=20
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 572880df60f7..a10eb50884b2 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -285,6 +285,8 @@ static int renesas_sdhi_start_signal_voltage_switch(str=
uct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(0)
 /* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
 #define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN	BIT(0)
 /* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT2 register */
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
@@ -343,6 +345,8 @@ static void renesas_sdhi_prepare_tuning(struct tmio_mmc=
_host *host,
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
=20
+	priv->doing_tune =3D true;
+
 	/* Set sampling clock position */
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap);
 }
@@ -448,6 +452,8 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_h=
ost *host)
 	unsigned long ntap;     /* temporary counter of tuning success */
 	unsigned long i;
=20
+	priv->doing_tune =3D false;
+
 	/* Clear SCC_RVSREQ */
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
=20
@@ -507,6 +513,47 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_=
host *host)
 	return 0;
 }
=20
+static bool renesas_sdhi_manual_correction(struct tmio_mmc_host *host, boo=
l use_4tap)
+{
+	struct renesas_sdhi *priv =3D host_to_priv(host);
+	u32 val;
+
+	val =3D sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ);
+	if (!val)
+		return false;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
+
+	/* Change TAP position according to correction status */
+	if (val & SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR)
+		return true;    /* Need re-tune */
+	else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP)
+		host->tap_set =3D (host->tap_set + 1) % host->tap_num;
+	else if (val & SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN)
+		host->tap_set =3D (host->tap_set - 1) % host->tap_num;
+	else
+		return false;
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET,
+		       host->tap_set / (use_4tap ? 2 : 1));
+
+	return false;
+}
+
+static bool renesas_sdhi_auto_correction(struct tmio_mmc_host *host)
+{
+	struct renesas_sdhi *priv =3D host_to_priv(host);
+
+	/* Check SCC error */
+	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ) &
+	    SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR) {
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
+		return true;
+	}
+
+	return false;
+}
+
 static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
@@ -521,20 +568,14 @@ static bool renesas_sdhi_check_scc_error(struct tmio_=
mmc_host *host)
 	    !(host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS400 && !use_4tap))
 		return false;
=20
-	if (mmc_doing_retune(host->mmc))
+	if (mmc_doing_retune(host->mmc) || priv->doing_tune)
 		return false;
=20
-	/* Check SCC error */
 	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
-	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &&
-	    sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ) &
-	    SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR) {
-		/* Clear SCC error */
-		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSREQ, 0);
-		return true;
-	}
+	    SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN)
+		return renesas_sdhi_auto_correction(host);
=20
-	return false;
+	return renesas_sdhi_manual_correction(host, use_4tap);
 }
=20
 static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
--=20
2.34.1

