Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.840.1795110955943564635
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:56 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=Cge5FYJx;
 spf=pass (domain: renesas.com, ip: 52.101.229.17, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnksSTJyxxjv/xlEXRmXpCB5wvdzvGfawF0zFSdrJ64De8pQbc9rYa9hTjkhq7zksX0BUB6AuUZ2+Kps6si3mx0F0Az24yhAd2lFGsjs4mKXKnjj+mnF5oemeGpyWXtzMDoVfnAm82tdvq5dizcrvA4AKka0EKcNUsjIs0rj/AKqKSHEceWk8uQDw9khYB95mNI54HoD1xyE9AuFhod4G/x7XBVIbb0sZAA85Ct++hN7NJcTWK8a4aB3HVJBW0n/hqAtvWBuWu/aac97nNA7o7K18/8I9j1mbID1i8L+pW0dntqi0yFFsA9qqesdGUjHs7HuzUpp6PzkQT0CwRRyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5A4GVN39i7RGZKfsFLhMc/HInNU1ueBTm5UR0zDsLc=;
 b=wc9MZBYQ+1S2CyHGvQUFk50r+dJBP4aVwtaR1yJJpMUEUTbxL8uo2JN6FhWri9QBBs0I7ME62YJPhIabJsgxNy4f5ALVJWURxkKaF+wDn/2MRCExIw70IxG2RgIz8WfHgovD1PjLK2VHE+Af+DNhYo7P2s6L0z+f7MPd4EsrWoH1kA2VF9XuNI0Z043kyaAoj9Gqk+LoK7JL3lsn0Y9HQFBkwVoMjy1S0k1WzpErmmgjZnKetwwcHZzHTuxSQlziRb+UZ7qHVx+3YDYsv+RM0xsyfuoYV7CA/5FnH+8y6tCE1gUwqdznUqojPghpaKiLYNAOqdBIVUozZqwXiTMPqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5A4GVN39i7RGZKfsFLhMc/HInNU1ueBTm5UR0zDsLc=;
 b=Cge5FYJxNLXiEtSYzTXuubZg08Bi93lqfup5DGyGuebBt0OpXoLxSGHONSa4AOZAPqDoxGpnFUk4du2QZHmLY+HJDVW4VGbz8joNJ0V0+gzWpZUX+nDXriYyE3o/yLEOeZ+pI3l/Up95qtnbPxYSVAA88PXl9PgHxfIL9MyU+jc=
Received: from OSTPR01CA0082.jpnprd01.prod.outlook.com (2603:1096:604:218::18)
 by OS9PR01MB882205.jpnprd01.prod.outlook.com (2603:1096:604:546::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:50 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:218:cafe::8) by OSTPR01CA0082.outlook.office365.com
 (2603:1096:604:218::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:49 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F38083000253;
	Fri, 20 Nov 2026 02:55:47 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 8/8] mmc: renesas_sdhi: cleanup SCC defines
Date: Thu, 19 Nov 2026 17:55:33 +0000
Message-ID: <20261119175533.110210-9-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS9PR01MB882205:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f381f9-88b1-4b4d-9e1d-08df46665875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|261009223027099003|11063799006|56012099006|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: GPF4IZ6W03x260XMxbq9gLR0c8AGOUflZTmnG90IKM9D8Q58o10ehXuVksQA/gKklIKEB804w48c1e6oghfL69JZClg0tr5qNowu89VbwenHwTaA4NUk4SBQiB9P8w3leP6jxjMLpg5ka6j8d5FsEbolzksnZY8j1MzbKijW7tjYiYYERUnlX5zAYBGjOqtyb0QMxvaC8EOqOX9WtiZhApsTNCovi81vYlLFt3i6hp/zbS5TmMXg5zv3h71x7Cy5MBpO1ZR8+9X909aPcYvq8/FfrnQ/G2H30AzsO3i+QQ7GTeQwG8nLoEyuoSU6WLnRLPG9Usv7zt/DJ/KEIcybmUFh7Vy6dZ44QR+T22dtf6TGXvpChnq5tt9yDY/pu4C6CMB/TWQUkOFN3tjDna3eoXCTShYiCUyVoWlkckE3Z/b83kX/3ll6AdbK9NKTt38pgXAw/fGxgrRsiPp68VaPUW2FcDVni1TNEgFVizDT5lAefGov9nqDMtQ+hpdpPO0TlHNnwTBPiF8sucifOU3nILAyhyXv4lDa6Lj6OHd3WixvXZOEOZRIzbHlJl04/akZbB976ZYsnSL/UNoJTSYBW4eSZXGfaPt/Q33ojffzU+cyYPbM3bAcaPRktMnrDfZxqDwWDuAw5bXXGK8tgxWB21dwtHvxKqeVd79gpbaelAU=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O5TUxR83FRkEtK5R7rtV7OTcVuBgfpbEdRpnDsqFzK9AaT1vDiAOsvLP6QS+3VQ5cK7N93O1bqtWOdyt4xCAw40ESXjJGqIoZZCpTJm6vb4WjX5ZW6HMTrHQqvX5c88nS1aaB0uunwr1gLTv2KKsjn19cTEGgDcIjZThw0ulmESGtXED/sBn1h0PIi8Ax2xnUZYSlFqGFEDdsqLLj/eduAnePEQWuzCKABpvx4gRDyLcnDRxul+ma+F9aUsM1MmbdWxWeJJGCQxVXhKptSpyjua0BYN7KjlP7u1X9B17YtsOR56+0dqYjNXj+kO8PvIpPAyw+hsNvuaqY7ix+WiVu5RvfexQW1TxsP+IYUTrmFB50tts2KmJlrvpgyoUVRjg8EV5bB6+McWZe95CEnTi5Jzh22udEB6GI3K7MLCfNuHi6AJwGacZq3EI3GxGym0K
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:49.3979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f381f9-88b1-4b4d-9e1d-08df46665875
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB882205
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:56:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25024
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6199a10e7e53d8185f25430fbae918d0f105a0ec upstream.

Use increasing BIT numbers consistently and remove some superfluous
comments.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20191217114034.13290-6-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 422906fd7117..1f9fd4621df9 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -275,24 +275,22 @@ static int renesas_sdhi_start_signal_voltage_switch(s=
truct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_SMPCMP       0x00C
 #define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
=20
-/* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT	16
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK	0xff
=20
-/* Definitions for values the SH_MOBILE_SDHI_SCC_CKSEL register */
 #define SH_MOBILE_SDHI_SCC_CKSEL_DTSEL		BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSCNTL register */
+
 #define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
-#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
-#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
+
 #define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPDOWN	BIT(0)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_SMPCMP register */
-#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(24) | BIT(8))
-#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_REQTAPUP	BIT(1)
+#define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
+
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
-/* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT2 register */
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
+
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
=20
--=20
2.34.1

