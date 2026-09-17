Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95427C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35284.1789636458517520129
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=jzMByAjT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.63, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlklmS5f7Gf7pgWlBDaMcRUs6FMFTg2f9vWRRbKpzQoMAH57jihrwkyUs10YpUdREFebZKqzSqpKJR3PLZwCm/Zl0pAVeYq2TQfX6IiYOsOsbWzu6gjhJ0qWd3bsjiEMkMr0QquTG5AcKNkB/inuX+R9+6UT1qYi/Xu0daPM4auc/+2//f1xupbrHwPdnhJW9gZNKagOyt9nZLkXvrVhMlm9wjoDHITThaCuxczKclVeU5V2s1AAXadoOuiBN5KJkBx6UEZyM+tZnpM9IzR4RK1bZU5CqI6YqezIimxyEJjMwagJDn6ZV+ZonVLzh3hZP9vX8vt/DENPwk/5VIZuNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EojDCp+VKaQfwVMuP6kupBXYQbf0Jjw8VKFbTwUO8FI=;
 b=FZPiEQI9SB8MTSXdwF1DEUCUCCeb8+wAVBu2uffrorH/gMV+EMMu+ITDGY3Rn2uSUlNP6XIb7xfyKA6zhp7GuUtbOt5zHcQNKzFQw9pReWNZRk1DG2UX7UQjGflvROdO9DIcp4L1uyizMBCd1Hcla0x3iEMp7yLozt9YoXtlO0ZafaUVmVbipg8jDlANsdOxK7XodTHe9VUaQxKUwu7jCcA3jcVo5F4zWx8QD+mhSiaBpZwhNkmzOa8+VphHKinDSZ3+zgWtaRKkLmnDU6jqX5KW8EIi1l0JpqFYDmx1kP8yKPZJoCa2YZKsuRq2e2yjSsw80YkGGv/pvjUZWGnUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EojDCp+VKaQfwVMuP6kupBXYQbf0Jjw8VKFbTwUO8FI=;
 b=jzMByAjTNsaENL3UNcYHwgsf3I/vUZBnNeQn6M4CyJDR2gD/motzKcKaTC/qj6baIkHZsZW2oylLM75uKCrGa0mzykyBHg7w67yYPalg0wUwoPuC5KiH5m56YDcSvVynNhzuHGEerzP96yJslNJAqzYfkODxT3ZNl6TnwdDavkQ=
Received: from TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c6::18)
 by TYWPR01MB8332.jpnprd01.prod.outlook.com (2603:1096:400:161::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:14:14 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6:cafe::62) by TYCP286CA0168.outlook.office365.com
 (2603:1096:400:3c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:14 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4B8C530001E3;
	Thu, 17 Sep 2026 18:14:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/10] clk: renesas: r9a09g056: Add clock and reset entries for RTC
Date: Thu, 17 Sep 2026 10:13:56 +0100
Message-ID: <20260917091359.18445-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYWPR01MB8332:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27dd7c01-bacc-4181-3acc-08df149c0b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	NoQvRsTDEwNanFtK2OmDEu4lHxxneQvqxPFQAoVZpxzIdMBBaCk/oIMJ0r84nagzQ/jxSc6DnY4GsrE+gjyP6Oam0aIfxoHNCOVbnSm+jRVt9mmbqUeXJR44Sd7NV/z/FX6CBFa9uZaKOWrk6P7Nwp9xDyO0mt9WmhH34sFHWd0uSn6QDgbJfpW1r4WXc31h34jUCPr4a3bgzQ343LfZO4nmA4dRWhWMW34VvLsss8MrUnPK9gt1beF8AgxoYwWKnXNQraxPKo/ira7EyPcuG8WnaoEr7QhW8xAIYtPw46zPcME0WbDctCWOTkMMSxu7DDRM+lPUGjK6WDGKIlxfieB4xgcdNUi1AA5w81bKKfUIwGuqsNflZI1qHENQc3ILXrvG/pV9ykhP3HsX944U4EL69SlTQ0Ga+95PmKC2Yb++FN86ZJm4sszuw12ZN94/GkwHQwQ28rftHk5rSixsyLZhr4x3sAxHjmpxkUp4sg3xs7YHVWjRiLz267rl38GmDM2qIpgf880r1qLPqt2ZQVdO1XGx6B47cpiBo50dlk435Fb2Xb47cUE1aIzgXy/F3yoSXgpPpiD5OXsykkWRC/6tNnFSkGRPnuV4I7rNAztO79AmHpr4njnlDQ5PVCtr3lXeDyJcaXny6RqQ5s1Jog==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	t9PQ9Q66te0DrbBYJnmJjwM03ktGI0xVj6hcKT+DMY83ZwflfDCp0dqsgzB4QGnbrT2Ap06CYCWejc1eXICiddmYQ7F/07TSL2EpgvTII0az6gqCrzxVFiQeWrycdxp+5gniRIEhdd8g6fbXMFYqGo8nBRiTocYycSC0USY7CBoHeOpfobP/CZINcLvJrOLCvIzUK4GjYA8OQtHiJ+Wbgg1LtyL5ZxUZGIk/atB4VjF5R9Vo59ljpDJAjIeZk8DsKXyMn3yIhmQmt35kzzoGynhJfNKYPD/pFULzU/fX86TEntOhblzTFfEvEwUTi8GGya5zfUGh4hl2w8B9hkJA6PczsrDASD6EFQ2nh1nw0dozXj8M7mz01STkkT8oYHCCo8gmDoCCX37pqmj1D4xxTYN2UIJlqBqINSXAwLEqI3cDij3+EjAuH6drXDYpRTjs
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:14.6199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dd7c01-bacc-4181-3acc-08df149c0b49
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8332
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24203

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit c8d5972a25408b1daf73653ccd5207fdfc80c964 upstream.

Add module clock and reset entries for the RTC module on the Renesas
RZ/V2N (R9A09G056) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-3-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a0=
9g056-cpg.c
index 197f3392c6ed2..bbaaaf3f9894a 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -268,6 +268,8 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] =
__initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rtc_0_clk_rtc",		CLK_PLLCM33_DIV16, 5, 3, 2, 19,
+						BUS_MSTOP(3, BIT(11) | BIT(12))),
 	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
 						BUS_MSTOP(11, BIT(0))),
 	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
@@ -430,6 +432,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __in=
itconst =3D {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 9, 3, 10),		/* RTC_0_RST_RTC */
+	DEF_RST(7, 10, 3, 11),		/* RTC_0_RST_RTC_V */
 	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
 	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
 	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
--=20
2.43.0


