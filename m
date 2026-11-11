Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5781.1794388758999497014
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A2r2APv6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P++hlzLtzwuZof2xMQUMiBVnooiCTkd1R9GL/1rL6ZSD9yeVSBhn45hIkkqFq0HbHw7/EUBXw2ftkjbNEOZdNYoq4x/3jNwTq/T1cfe9fKfPaB1sT0TmuKf0qgAT4WONozuLO4rbkYzufDF31W/xT9z3lMWwvLtGnG8mVyVPHlokFIhmSpnXDXSfXicH26IngQBfIyYaPXpIplSvnmKREJlxo5BY+gMN5++a4ZC6TDzPTr9zGetrS3QW6DBNjybbCSaPhNiXEP0Mz+FXLw2pbzXmrPXsUw7emiPOqWv8wi/9MS5KiuMRq9z09lfqtFKP1AS0IIm1ULBTFGzN4zcIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbeFMPp0E2TadzanNssxlRGciwYDBvQ6R5bLiVzwLsI=;
 b=B545lJ/pSPa6BkfAEix9skRXT5HvO50LmPrMBErY903mafPUrEviUnn35coclxORaNtJUE0FeEm4Ete9kMRMkWVbSvk2VI2lQMQwAjoBk3i0Y3J0bhaUt9gPKma0W/dYO3aaxbgCtckC8HbX0f/1vZLC8qsSdBmaO/PPIqdQ7f03t6D6Yh3spGSh1DDxLKK0bc7h+FNAx0QHHc4kipnRvzKkuydYrccEWSPaM2NCK7Y4tJmwD/pcUT9GTXZwIufYAcZdJwi6L8AAdBukAB4A5OZqbAKXGeA+FmL282IHws24rB6UVSbAG8yyT5i+5TLa9mQnd5YruDigZe5jMPBNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbeFMPp0E2TadzanNssxlRGciwYDBvQ6R5bLiVzwLsI=;
 b=A2r2APv6PLXPSeFFMYh7bMR76Z+P/fPU2zo1GwrpYfCFnKgp9LMQdW+8gavDUSFyDvUFEza9ehdL6oEi7Tn/J3K2kEHOS4SNHkOu9LCJ8Kx8oeFOnrP/Fuy5Nxc7QlfuUtFi6JIV5qExVtFgQjNCkVmm4ZdXU7mr3pu6KB2+ldc=
Received: from TYCPR01CA0142.jpnprd01.prod.outlook.com (2603:1096:400:2b7::11)
 by TY4PR01MB602744.jpnprd01.prod.outlook.com (2603:1096:403:703::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 09:19:13 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b7:cafe::2a) by TYCPR01CA0142.outlook.office365.com
 (2603:1096:400:2b7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:13 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 275793001DE8;
	Wed, 11 Nov 2026 18:19:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/21] rtc: rzn1: support input frequencies other than 32768Hz
Date: Wed, 11 Nov 2026 09:18:45 +0000
Message-ID: <20261111091901.41995-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|TY4PR01MB602744:EE_
X-MS-Office365-Filtering-Correlation-Id: d06d54ae-9f89-4823-38f7-08df3fd4da1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|13003099007|10067099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|56012099006|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 3den1G691uth/VVBP+fsCCozbg29wnPBI6h7h20I6q/Dy1PVUVkN7kHZRxqpS0u/ZEtCYlgWEAXPle4GG3S6qmRtOpXoSh4KgFfRdpwM1TLFTHc0uD68MA9gjF0TVEongyU1mtaheP/vygpv6cwiMId1ye5+VTrpU7sPerqJSqUxLBurQybQ1CLo/OzBYHI6yuUcesQA1hxQS/RVztjIR9pkC4Mb9QaMVjK1qzyWkZ9GH/56EoaHUgdDQv4HvYEohKeqKMmcc3BqiZjEoXjik+OOC6zg0jF2vn8HGFvDt0qqaAl2o4LLnFr5BWOXr/iuZ7ZVzl8faVV9OLO/H5CJqKFCEtk2EzmW3iyrJDODHqJi8E1wtlW7yJ8gajGpF/g6Sq1e0TfGDvW6uIYHFLn5JegiZcFXeupuVwPflDAAESt/IUVxjVNMsNGuIu8DYs1RLfYuPmt9drf4TOaulzumOpB387K5mlSe4LCXX8kyuL5n8Jl3+9y6O7AJwgCDkLgNciLinUHQqxa5qYgIV20mcpZpDchvsn6RZx4wRKrQVnaxEmxMuIL7+rHL2APTDCwJ7xqsJjfEfdP37UGQrfTtz34ggLha9CGbrIG4matT9P5lJ5SpS0K0Vmm4GYXI+1Mmb7FYXg1kakO2PqzB6VLTXxyAWmH3cRYSujVvkJibGAo=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(13003099007)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(56012099006)(261022075727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QyUcjASDat8+uLZvODXt5ZKjrz3SnrBivqBzkiCkehZD4Ab3Wn+hiJGyeLHrMBOtqOVDc5VGhkiaKClXtvpx9RnsC7Db50wzTnVyJrC9iw26PsipBGQI6AP+TUZX5Y4RhFz7tfe+ZvBoDfJSUgYhIOmrAfpuVil33lZJIt+cSmQYO4bf3yPvHAwjWpJlov3/fCmLxpqjBnbCC+FFD89s4L27xmIFKvFTRXECPnPhDlBQ3etUxnqeD2C9kYocLhOdGj+RNvy+5cu1lCRCsd7bmsDZQ5fPfF4kZhhd/Ab6MDhg3tlKRVVER2t+6iA0/JYAlmbff48vTKBV5132jkbHfUSlu5c8wFuaZKew3chFnLQ+0fGaqwMEOnMBX/ddElYqAI79HpA3GkzYmS39hl+WE/P+4X6x0UNwTq3mvsG5dgn44Fq7asrTJpEbFNZfaLNo
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:13.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06d54ae-9f89-4823-38f7-08df3fd4da1f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB602744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24747
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit f096bdbf08c9c696a6b5c18a36b75c43f8d86eba upstream.

When using the SCMP mode instead of SUBU, this RTC can also support
other input frequencies than 32768Hz. Also, upcoming SoCs will only
support SCMP.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20250526095801.35781-8-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 58 +++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index da5e3e973ac81..03411d81b2772 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -12,6 +12,7 @@
  */
=20
 #include <linux/bcd.h>
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -22,7 +23,6 @@
 #include <linux/spinlock.h>
=20
 #define RZN1_RTC_CTL0 0x00
-#define   RZN1_RTC_CTL0_SLSB_SUBU 0
 #define   RZN1_RTC_CTL0_SLSB_SCMP BIT(4)
 #define   RZN1_RTC_CTL0_AMPM BIT(5)
 #define   RZN1_RTC_CTL0_CEST BIT(6)
@@ -50,6 +50,8 @@
 #define   RZN1_RTC_SUBU_DEV BIT(7)
 #define   RZN1_RTC_SUBU_DECR BIT(6)
=20
+#define RZN1_RTC_SCMP 0x3c
+
 #define RZN1_RTC_ALM 0x40
 #define RZN1_RTC_ALH 0x44
 #define RZN1_RTC_ALW 0x48
@@ -365,7 +367,7 @@ static int rzn1_rtc_set_offset(struct device *dev, long=
 offset)
 	return 0;
 }
=20
-static const struct rtc_class_ops rzn1_rtc_ops =3D {
+static const struct rtc_class_ops rzn1_rtc_ops_subu =3D {
 	.read_time =3D rzn1_rtc_read_time,
 	.set_time =3D rzn1_rtc_set_time,
 	.read_alarm =3D rzn1_rtc_read_alarm,
@@ -375,12 +377,21 @@ static const struct rtc_class_ops rzn1_rtc_ops =3D {
 	.set_offset =3D rzn1_rtc_set_offset,
 };
=20
+static const struct rtc_class_ops rzn1_rtc_ops_scmp =3D {
+	.read_time =3D rzn1_rtc_read_time,
+	.set_time =3D rzn1_rtc_set_time,
+	.read_alarm =3D rzn1_rtc_read_alarm,
+	.set_alarm =3D rzn1_rtc_set_alarm,
+	.alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable,
+};
+
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
-	u32 val;
-	int irq;
-	int ret;
+	u32 val, scmp_val =3D 0;
+	struct clk *xtal;
+	unsigned long rate;
+	int irq, ret;
=20
 	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -403,7 +414,6 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	rtc->rtcdev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;
 	rtc->rtcdev->alarm_offset_max =3D 7 * 86400;
-	rtc->rtcdev->ops =3D &rzn1_rtc_ops;
=20
 	ret =3D devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
@@ -412,10 +422,24 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	if (ret < 0)
 		return ret;
=20
-	/*
-	 * Ensure the clock counter is enabled.
-	 * Set 24-hour mode and possible oscillator offset compensation in SUBU m=
ode.
-	 */
+	/* Only switch to scmp if we have an xtal clock with a valid rate and !=
=3D 32768 */
+	xtal =3D devm_clk_get_optional(&pdev->dev, "xtal");
+	if (IS_ERR(xtal)) {
+		ret =3D PTR_ERR(xtal);
+		goto dis_runtime_pm;
+	} else if (xtal) {
+		rate =3D clk_get_rate(xtal);
+
+		if (rate < 32000 || rate > BIT(22)) {
+			ret =3D -EOPNOTSUPP;
+			goto dis_runtime_pm;
+		}
+
+		if (rate !=3D 32768)
+			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
+	}
+
+	/* Disable controller during SUBU/SCMP setup */
 	val =3D readl(rtc->base + RZN1_RTC_CTL0) & ~RZN1_RTC_CTL0_CE;
 	writel(val, rtc->base + RZN1_RTC_CTL0);
 	/* Wait 2-4 32k clock cycles for the disabled controller */
@@ -424,8 +448,18 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	if (ret)
 		goto dis_runtime_pm;
=20
-	writel(RZN1_RTC_CTL0_CE | RZN1_RTC_CTL0_AMPM | RZN1_RTC_CTL0_SLSB_SUBU,
-	       rtc->base + RZN1_RTC_CTL0);
+	/* Set desired modes leaving the controller disabled */
+	writel(RZN1_RTC_CTL0_AMPM | scmp_val, rtc->base + RZN1_RTC_CTL0);
+
+	if (scmp_val) {
+		writel(rate - 1, rtc->base + RZN1_RTC_SCMP);
+		rtc->rtcdev->ops =3D &rzn1_rtc_ops_scmp;
+	} else {
+		rtc->rtcdev->ops =3D &rzn1_rtc_ops_subu;
+	}
+
+	/* Enable controller finally */
+	writel(RZN1_RTC_CTL0_CE | RZN1_RTC_CTL0_AMPM | scmp_val, rtc->base + RZN1=
_RTC_CTL0);
=20
 	/* Disable all interrupts */
 	writel(0, rtc->base + RZN1_RTC_CTL1);
--=20
2.43.0

