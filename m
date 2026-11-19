Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.839.1795110952044915043
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=PjMcMwNJ;
 spf=pass (domain: renesas.com, ip: 52.101.228.37, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsRMkeTImyr9y9PbGJiYYWQKi1w6GOZI7nY/a5s0Foj5IkziQs5W8/Sx4ja1JReJ5WyWM1ivLSRogEw4w4noDvZuXQcivJDoT+xnRIQoBrJFwmgPaS1rlCsbu5DVxWSaqfMnJ3TbKQHCD/QM/M30It3zFR9wslJTifh5tkVUf+nzf+q3PxunbScXJpMlkk7qAtls9NWm/WtYjcqmildlYrkRL5cc1wnb3yVhuDy5kvLlCFGozjFfOcntaHwbsir69bWXgMino261MY3RyV37zvQLQr9bUgX7aTIpcm/jYfpOAjBAPTOIMYN/NdO3pxkMhvL0hXBaKsbc+sPXG6m85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FUoudaj9trljoaLPfcbsxLUK/SGYjgzonWGRQLpQkU=;
 b=UNQ76Ic4hpXCVB1a0z08hXKkBfZBxN/mFlMcUyYZmbXB0QtIHtItobXkyl0LI60x0dlGxmeMy9LKdVApFOq1DU8sstBB8o+lW9vvIL0NR5EJ/Y5h4HrJLHZ5NoWjz+yJDSAzLiMshQ6RxC/vFKTApP4hnua3vusyq1blO5VQPKVrn8QDF1WTSazEysbLBXYExp4tDXJRJ3uGCh0Vpo2ZqD7fyS7XTWsxqcMhhdZncGCmtyArjwchzetsaPboB2X/SncyGfClvRBLWy/Ed454QWTKR0KBtCp3fI3KL+sdtX6DiSm0utptyoeXakM3Lrfk/FtrwypnzAJGHsXIj20msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FUoudaj9trljoaLPfcbsxLUK/SGYjgzonWGRQLpQkU=;
 b=PjMcMwNJEY1uaCrMzLkGV8171DDO1RB94HuU7rdGeqzHut0KrGO3lKDnOqiEHhNzwAuXJfK+MEtJ3Nv+g947Zi9bgqnJH2BXTCw2pBm3iB2gU9sNnZ7wYaM/rKQWtXhQ5/GSxAnU+aw288N6KDJt6DNnHU9LdAqBfXmrFpimF1s=
Received: from TYCP286CA0271.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::16)
 by TYCPR01MB10006.jpnprd01.prod.outlook.com (2603:1096:400:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:47 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::7a) by TYCP286CA0271.outlook.office365.com
 (2603:1096:400:3c9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:47 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4D053300024B;
	Fri, 20 Nov 2026 02:55:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 7/8] mmc: renesas_sdhi: enforce manual correction for Gen3
Date: Thu, 19 Nov 2026 17:55:32 +0000
Message-ID: <20261119175533.110210-8-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYCPR01MB10006:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c731c9c-1433-4c19-3dbc-08df46665758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: BwFHchHvF75yyNoFlrjGPdeMBi+nvOIgQGz7pZYr8+VHAbBS2RguR3QDn58lfLs5+6pHYqrN83kirE2UM+GPh0Gh1+kPwXiUjxOXGKMMBpoVwRXRZHTFHDkWly3RrAgxN2y3P/XsA856SSDUyeEglm1PhuWilte/N8TSC2PkBkb3mAFpL1T3OZs51Iapi/y2cBy+lHnS83NDJATeTUcGGD/U6xu45oY1/fI5B3/lmyx7cgRVXFRfMl2LT2ZwNu3m9+pvJSwUvRYDDLNWlDhzEOfSbIwKHodYA0kzSa0SHwh55vlp7H445PJ4KMT7hMPOAH5LfpsAgXvzfXpwC0R7enAdkURAdcqnwCz1TwZI2ZDHoct/IsNam0xiceypsJtzRjffljsUhHZ6zFZvV3fHOTzur5du7OtvPAcUoRxm4wmodXviyTYLIoLyFuTAJz+k1Z8uroPdJppATSY9U0xThEjMMV2a4YTJgRCGljijyMxBg1piKav/L1rMz2FvbqsjtpM7MSrSe6fUpoG/FYh/n9VNbaGCQjxVXLMU6l/eLF/IIgrFDcs3lIXwd/0AuaRbvRWPocH/w/JMRdp0BQ/J737uoVhFQ5VXsCpxWCB8xrw8W7CSkrL5e9rcMCxC1+QJCToIAmauBj79dXUeMWbK3ogBycU6NzoaOQMrlhJYhPk=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eCZq6jzA9B3BjKQN9x9lq/1e4ZhnRLN9bqlIJuG/8QIrB3WIUgWYzMROWNy02eMyuHhKHk13++Hx/K66W9TKLXC79B+BI07Bk8YuZKlGIcPmgrXQay6//x1FfXMuxRSYKDofBn06uyFkjytuyd3gh4Sawi0Tn0tQMHFOSY+sFBokBrTir5oMX2Bf0W4T1jf0P/bibeDwxshH12+WAwIUatHi9MUvQci/eeBaj03EvMO8rktUZ4/38IKnyOpwzlfG2CdMJXvb51Jaa1MnlVC42p4CovdkZIxKZppAu3mOZsolk1yLUz5dY+n1bb3gzGTpc4fEyUpswwaEBxZuTTbNnEAfmTgzkfCJ7O1c6loSssYE+iR+1+aV9TzluyclMSpnV1mG3P8tXxaaRLeBcxmSFhV2J0l+bKX1M5Thk1Rp4u0xl8jalMFccoA+xpwd3ZZZ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:47.5392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c731c9c-1433-4c19-3dbc-08df46665758
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10006
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25023
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9b0d6855e756b60dd09c2a3d2a697130ffdc297d upstream.

HW engineers say that automatic tap correction cannot be used for HS400
in all R-Car Gen3 SoCs. So, check for that SDHI variant and disable it
when HS400 is about to be enabled.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20191217114034.13290-5-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 09d23a770f70..422906fd7117 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -370,6 +370,12 @@ static void renesas_sdhi_hs400_complete(struct tmio_mm=
c_host *host)
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
 		       priv->scc_tappos_hs400);
=20
+	/* Gen3 can't do automatic tap correction with HS400, so disable it */
+	if (sd_ctrl_read16(host, CTL_VERSION) =3D=3D SDHI_VER_GEN3_SDMMC)
+		sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
+			       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
+			       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
 			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
--=20
2.34.1

