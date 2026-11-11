Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5777.1794388755764147175
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pQpN6pkg;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.54, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJvqITbpbFVHmoIB9QUM+nXjwqWRfqXUuGoW/PT/ACyugPlqKxN8rHefCp/vYaLVMDNaIswEt58EJu5oBvZ3APfAZGHt+umVgyI6ja2bhXwiwo5BJV0zyhR8NTf44B1OXydEQ5pAIiYrmxjAxad9BfWcNQZ1pV6sKm7FLoq7QLD1xV50S8GP3spPrIveJnbJ+ggamrNTjHt/pN3CnbhhqpMJOdzPFpt/gHiqusQk8aqSsUA2ifhaVvCdfQp1F9chDFgl2fsOBczpQvihDWESAMGX9zY+LER9B3GDkf3kGUkwTI4f0vhendg4FzWeOT/5VmQaBLMnP0BJW8JIYA2q2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KGJhmSfMakvo05bEfgmFCkJDsouilsA2+sKP8CuQJI=;
 b=QifsMQm4bKdai4e9LxQW3xnHqtEUlJ33KqDGci1ZM4qjTuV5ik2N85WlfYOl9YZkhvTiL/e5bGPfwaUv4UIGuelPQbuRqqJXZDjaLgavv1h9sQ54tne4F7yqkUCcUoyafo8enaOxUWvij0/WLIJ1rctDrCAHtJ5opHumVyOi4+iS5VGUNwr8XnbWncRci1eyMmsUXVg+gf4quokxRLFF38AcQdZGXf0EOa45c/IV0NoNpZKhkkok5gMEvs0R7NC+IyPfAhmLlGN3fDC5HWnBAgMHpqRBwnp7y/sbSNwCfGGK1VJZNhKyOWG7mvRKLa1Q13Ej3/PmAArKk9gEPREfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KGJhmSfMakvo05bEfgmFCkJDsouilsA2+sKP8CuQJI=;
 b=pQpN6pkgWhn6UJoCMfAxJvRtLM0ag7HH85EnHqm7dyzHg/T71hltYY9Rnva0CkzAAdii44PlRBKkcKruSA8f/xIw4+g3B0NDLzgiRmMZ3C/J45UQZHiQkc1o8WzJCkVsy0YS9CQIVpLmOkKif231TLU/Mo857HNG6jrJIrpqGoI=
Received: from TY4P286CA0058.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:371::16)
 by TY7PR01MB17729.jpnprd01.prod.outlook.com (2603:1096:405:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:11 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371:cafe::63) by TY4P286CA0058.outlook.office365.com
 (2603:1096:405:371::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:11 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7BB0B3001DE8;
	Wed, 11 Nov 2026 18:19:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/21] rtc: rzn1: Disable controller before initialization
Date: Wed, 11 Nov 2026 09:18:44 +0000
Message-ID: <20261111091901.41995-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|TY7PR01MB17729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc8c167-2e16-4814-cd2d-08df3fd4d91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|261009223027099003|13003099007|11063799006|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 3lvR6KNOUbxFx26X/1TI9+HKZ3FESsfa2qyEFkyvWJXnzUUut1ZXQkzj4V0AYLVyTFpQCSrA9FjoW8PoCZUqDEre5r3ozUmB9XUEw0IuOtQyQuvRqVonYpyXFwOapwaHjDMiSEKYbKzQs7ptXzTEgy4qWLH7zjnV2G0x+ANTYbCDtw4xtQbFnqW2pkZ/NaWDlWrd0zLCvXvHy78s/LKQICwE1/hu+YyJKzL1BXbcSittJyATAz4VPl8kbjPxpaj7ekeXGhXf1DqNB0xo1tmGTssC9IlVO6TPO0Cm9Z8t/ps0hAhHzMQKyKSY+ccoj7zARrvZE3Hqb6iCtW97rsuUoHQmgp5ulxrvrRGm1kkAchEFfACNRV8Tq4cnUdz5rckUOmNdbFsPhtRZZvWTNerEDGW68XW70JAuO6WYUj5qj1Dq7USfM29mf+mCxJU2K+JAQ6zde3HExJmeQTHMIAPynOihEKavxMLr0tUgmVm2+44xTM6Ba/TI0xVsqadgqAxKRPT9R0aigvEilNKy6azKDIInxFmBNSPMN13xeBr5wSXPbP6pM/e4BcuZvMc0VWDBBuNlhd7jADB70eRyuN9ZotNyANk4kBewqKK/VmkH10YZ+izRzqzU04wdvPYs1Y5y495b1v+Kk6AkjW/gt6Wjxw==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(13003099007)(11063799006)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H0gk5ST7RRCHT2iDuAKGhp8Q9QrNGBuTcT5zZ/ClDz9vmxXsLMRedSGkmLgXSM1hngQOP6pODmV2l/xDFm5LuwNvTG1ppgGZ8NWdb32D3T5axbYHFz1DMct9GxaMsW9Qa8pwgTCeO68n4Lit9CYZTfmneEXwnbBvCQEV5YyQAK30SoVkMkKPCwyX7CnAuLgDGPdqnEzYrVIYM+0vBdyRz5l6hL5XsJM11u2U8a0L1+mKJgkcAo5Hm6x5IyCDi5pGcbQhhVtqLGzzAVf7cqkvpisvvI98CwT7+nDwYMbw73BgHq0dT7Ni9AHLx6B43KV4pxWW4jm0CWQ6hHuHKhBKi1XvyEeo4TS63Q5cxt0AFgtMufSzuRQE750eGQ68EwBBoTt88zL+PdVEY3pg1QeonUym7a0xZQHX6IDf1C2iXRZQMTHqqf4A9HqbHPjUg8+N
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:11.7619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc8c167-2e16-4814-cd2d-08df3fd4d91d
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17729
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24745
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a50f00cb87b1c69eb4a08ae5c79e9536da839dfd upstream.

Datasheet says that the controller must be disabled before setting up
either SUBU or SCMP. This did not matter so far because the driver only
supported SUBU which was the default, too. It is good practice to follow
datasheet recommendations, though. It will also be needed because SCMP
mode will be added in a later patch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20250526095801.35781-7-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 8aa42e433a04e..da5e3e973ac81 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -25,6 +25,7 @@
 #define   RZN1_RTC_CTL0_SLSB_SUBU 0
 #define   RZN1_RTC_CTL0_SLSB_SCMP BIT(4)
 #define   RZN1_RTC_CTL0_AMPM BIT(5)
+#define   RZN1_RTC_CTL0_CEST BIT(6)
 #define   RZN1_RTC_CTL0_CE BIT(7)
=20
 #define RZN1_RTC_CTL1 0x04
@@ -377,6 +378,7 @@ static const struct rtc_class_ops rzn1_rtc_ops =3D {
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
+	u32 val;
 	int irq;
 	int ret;
=20
@@ -414,6 +416,14 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	 * Ensure the clock counter is enabled.
 	 * Set 24-hour mode and possible oscillator offset compensation in SUBU m=
ode.
 	 */
+	val =3D readl(rtc->base + RZN1_RTC_CTL0) & ~RZN1_RTC_CTL0_CE;
+	writel(val, rtc->base + RZN1_RTC_CTL0);
+	/* Wait 2-4 32k clock cycles for the disabled controller */
+	ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
+				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
+	if (ret)
+		goto dis_runtime_pm;
+
 	writel(RZN1_RTC_CTL0_CE | RZN1_RTC_CTL0_AMPM | RZN1_RTC_CTL0_SLSB_SUBU,
 	       rtc->base + RZN1_RTC_CTL0);
=20
--=20
2.43.0

