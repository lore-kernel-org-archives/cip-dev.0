Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.832.1795110945744188891
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=lJi8rFWK;
 spf=pass (domain: renesas.com, ip: 52.101.229.34, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rp5jhKQCfTOWqzlz1kZl7iVk5cRH76VN0ezISO+PcN9pkHNM/hXtQPZ44jqIVC3rG/rJZQaDFVP4A1EPcmfZy+9CyNIcfJ4WSpU26KBXxEnJdF3PXwI0XYzwVn4ThSKOpwLcu2T7mU2IABdZ86XCUCUYKNtwDUBn+VQSmY2ulXvtEmKa2WnmNi4BeFyLOYAeTZHd4TQpc3ip/5NIXJi4h8a5deeVU/r1nhWHiF1sQj1n5wPTis705rh7Qd08alrIaztGCW942oUueGUOAB5gk6xJFIcOa3ixCKXmIFQei1s77NLnvzPHNqdJki0FKQkKMUSRR0HXZ/q0y77JMtZS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEMlj6gF6s4Ruc0pDLW4HcphWLPMxkw2AQ18YPHHILo=;
 b=UVG79IaCawoa7jOnqtpUr2Hh3yKZ2o0bbqOCaVqv1GfjAf/UTmt0CHpBIYpP0KuFZny3UBjAIggGapAisJ97hbd9Fzx3apjIpwwIZBRIhWgCTxvsLMS9G3Wwm6PEekI0zdlsfX9b8VrU2wXXfUkIij0mpnQwgvpl0SGgNKsGqaaTUnTkuiNEvohEKavzJdYicrwB3Pm3T2jcjgWPhhAMt1Llv/8GTyWaR5iqeArb/nH1gGqJzBErGd6g5PDSXoIQT/M122WnLdKNAGV3+ztHEuMt097/jbrrMRpqBfjvYxyJozUWZozq37N18PObTk+vb81RIHzyjDc13T1qoKFLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEMlj6gF6s4Ruc0pDLW4HcphWLPMxkw2AQ18YPHHILo=;
 b=lJi8rFWK8NyN6/xYjE3EKePNNigwMpmKGq5fOMEhMGBa98iIsUWfbElpVfx48PgYPvihTtGCap2Lh9XkwvwCzeXW3SrsEgQdAMVDgodaKJ7cDjZyUh3R4EE99AJD27E3aWhKJq4uxq6zu3+f8AKFZSIi03FTDafp8+1ES98JOxA=
Received: from TYCP301CA0088.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:7b::16)
 by OS7PR01MB14784.jpnprd01.prod.outlook.com (2603:1096:604:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:40 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7b:cafe::5c) by TYCP301CA0088.outlook.office365.com
 (2603:1096:405:7b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:39 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DDC923000230;
	Fri, 20 Nov 2026 02:55:37 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 2/8] mmc: renesas_sdhi: skip SCC error check when retuning
Date: Thu, 19 Nov 2026 17:55:27 +0000
Message-ID: <20261119175533.110210-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OS7PR01MB14784:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e231b6-0be1-4080-ca43-08df46665257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|11063799006|56012099006|261102123227099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: giDONV/mBJb0lOx3jwo4g0Or0DNuAJHees6tkrBUrIvKm3ZstXSu8wGmVgYosfFDE4lZIbfMR2n6lmQiJL/iLcpsafdYB54YDIHVa5Vlg+mNavrbuB6Ys9NaiRH+/JN2gjvkUXr+jxx1KfKzJVlKQ89JEUY8IUG7rvhRvYBsEVKGyL1GW1jsRS2C4rY3NZPKn1Bc7IsGUgg0JH8tUB/Fl4CZd6TAorxWjm7QE/KaPZYKqLZswn451DtkCZD6b76hswlcNxJprbAyMFB8WHnWskWeeorXgX0mX8rQXjNISuNdyOGXN2Gda2EFDdhl5UuPfN2mH9CeQyMdoTrpEUhRQt9GbMn0GCLZxWpNoGHQ7s5JSnKMk64dUnlk+Zpv35JUChAvEGUB2Ww+TvSFmIfEjS9BdiY/WNAEHPVqHmP2JELvubMHoC+UAqOwyyg6AK+K7sxINGh8ocMFHGlYvKkv5wfnQjqA3VcrsKvvEMQq/LqvmVK5GPWAgs/Yy9O7/dFE7ccrRerPmtcEhKNdEt6f9eAMuJPcJif678ebCYo3p/iBldFL3cAWuDdZVcpiOkKtqZgK1YwKV6qEJIWA/eOBoM0848czlwmOcFyHt7rJv7uAoGb6O/XvuK+TYEkH1qaRvxgvocfzjjaUayVKSK4zForTiFgT0M46bbMUzsGz8oZOLaEc5sIhSVfs4i2KnmHIud6iKDnraMAsToa/2eDvjA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4rKMYIyFRHBI+cBMH6K/R4kdvPgK3GyFijFGN0aEJ6/f6BfEWXnQeMlJlVy7p7yDH/M5GuTvtXPyUp+kSGvQ5RI6IG+mZnal2iqCZJkOhuYu7ZKkCcCTvEBEBrtnjfKlUCn6mDP5KoaoHU0UYwI2gcS8DPKOLodr8VTmytTevTTT//bUqbqep8WcZRbKGNlsWt8tB7ZKyd+dd/QW+2sBtoxqkzTV9bu31s5mdKZXhsbMmWjuwCLShqumo7yPqPBidlnlwj+pXPATmR6nk0gzTx/2j2EDBYTwEkcWGWIL63R2DOFVqYEMhv0gh0fE+pe9SR5Crz6MYK6/hc2e2VQ0D4w1T0MAXMWsFFQUAYjQxpQxKV/1CuNnjeqAR+Rdgr5KumqhdHBtldQKLTQ1MH/sZA+EO+zGFEKNGZkF3E3Rka/7BA69esn/L/jbqJQsfSpW
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:39.1484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e231b6-0be1-4080-ca43-08df46665257
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25018

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

commit 75f349a153062d507b99b9ef35e9ad9531cc0fd0 upstream.

Checking for SCC error during retuning is unnecessary.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[Niklas: fix small style issue]
Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 3f08e14e1dee..dea592a33f7f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -510,6 +510,19 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_=
host *host)
 static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv =3D host_to_priv(host);
+	bool use_4tap =3D host->pdata->flags & TMIO_MMC_HAVE_4TAP_HS400;
+
+	/*
+	 * Skip checking SCC errors when running on 4 taps in HS400 mode as
+	 * any retuning would still result in the same 4 taps being used.
+	 */
+	if (!(host->mmc->ios.timing =3D=3D MMC_TIMING_UHS_SDR104) &&
+	    !(host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS200) &&
+	    !(host->mmc->ios.timing =3D=3D MMC_TIMING_MMC_HS400 && !use_4tap))
+		return false;
+
+	if (mmc_doing_retune(host->mmc))
+		return false;
=20
 	/* Check SCC error */
 	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
--=20
2.34.1

