Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5735.1794388774830758119
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DtoJpqrg;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlVCrW0mMh1y2Wm4B8frMQqsaytYdGrExqLhUxDgX9HNKUvuiw0fPOkTkCRNtTmUOY3C0DhtudrvitaRVoqNeA0507Dge4JPxA83g4pLoqdBczDqaaR24t3inZ2r9sG5AXuFGLZOopV76YLa0+NBbzmnrC57yhtf/SZisk8dTM6Jaknzr9XiSR/5ltMD4jJHTa9rEdXN5OiWfuy+0Q8hthQjLqeG3PPdNdXILLex5V02vzavDOM88GiV9GtVPBsAXC9ST1YMdjzadWGZ5NZFXuOVR2YnFfCfhKiB3YnDT5R6Nzozb2EVdojTF8dsp1JV+OZXRyfOBkhfzeigZ/yATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgBb5HznyWuO3L6f2urFEM+Hiz9S/i45fcsROz5wLxg=;
 b=AzutHKuAH4O1dRbEy4rW0HRe67jLnxEsTTnsOSUkMtUAd8eY5JxIDPxUcD2HO/A+qS2lHKOWoAziPm/7hx2Kj2BJTVLIQeviqLL1c6mVZDasmAXsjqrP5bwROPuqGc9uOUmMO00SV0/tP/CBnBbVZgoebtOSv8lSoxBJXHZC8XdBiH/cjt6Tw4hCw390nR6rDIQQ+bsuNEv0ox1ahXV6OeLmgKU2UqGTTtlYcCOurjQygn/TUtOyvroAgysi6AYxNCTRSejV1Lw4AYFr+/ZN7lvlQG+2hwEXvtvYCosa59olBZqo8VHJbnrFKWJ73Ql+7VhKLoebi7VNYZNiIpoGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgBb5HznyWuO3L6f2urFEM+Hiz9S/i45fcsROz5wLxg=;
 b=DtoJpqrg+eQhXVfmZM8YXud9VcAD+fA7+DZDyI5aXKkc2t7z/1eeUXyJfuI8BPobLLVvoz/mvNGGEv8MFT6WAHzh2dtTNsCnxqrXxo0Sl47f7YUL0UBLyE0ckXdCoAcbyA+mr8rMZ9yM5X/JByhEqQ4gMVs0/i8ZC0ONPCkl0nE=
Received: from OS0P286CA0112.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:169::20)
 by TY5PR01MB608024.jpnprd01.prod.outlook.com (2603:1096:403:50d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:31 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:169:cafe::25) by OS0P286CA0112.outlook.office365.com
 (2603:1096:604:169::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:30 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id BADB73001DF5;
	Wed, 11 Nov 2026 18:19:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/21] rtc: rzn1: Add OF match data to gate SUBU register access
Date: Wed, 11 Nov 2026 09:18:55 +0000
Message-ID: <20261111091901.41995-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY5PR01MB608024:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb987cb-2abb-4e7b-7fba-08df3fd4e410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|13003099007|11063799006|56012099006|261102123227099003|261021121427099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: b9tSdo5gz/HaiAKsXPDzay1kZ374KECOu/KCuSMD/X0sLcPRecwxqduNiLXg05Urc+lcDz/OYUcOE9E4/qjhrKdCzEp8bej1IrVEB7yjtekTyF+iUVEA8fr9v+++EfFs6lfy7u0+517ScG7rM+YrSM84NSv1tKjwT5fXRNdN0uIU1xp4ovG5W/asvjzZdE6Wwr1A3f9hYv85KBqKe6/Zb1kQb1V+3CHits9kCJmyJSSoxznJYbXC07Cg8ILBLl8BJPjjfVZ93TrfZpYrnQdOPs2hIn9OvHFDqTpysrPfbuUbBg9BV5YK9r9If2VMTomVWFL0beH3MV3R9sRbKh0G4apG0Oyo5rCHp2RJI2gsqxDykx2rwcnnSyt475SZh+QlmyOVrHV/+0p56NLZY3W/6ERZdu7rzXc1aEn32tBHTQylKkqgOcc+D3M7SAK8vdHKPmVqzpB5Zxwp5ms/7SSYr8jwLZELV1Md+LNrn8f+qNV4BGtUfU4YsX1dL49gyBTNjAyfTWufiyli050hzTXybSTOFsQyGf8BNx+XlmQ7GacYLY6gk4bkfM+4pDfC08kWwMGlsFKxZaRhwjLbdgnzJDy9M1WVOnuKbK107yfROwpg5RrdzEzsWpcGUtGn2IKZ1QtRNjRwesY3fuRgSJKkEWOp3oBMlexiNqoa1hJKUdg=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b2beCEfhPvVUC6iGNQIfaWLdR8cXoKL9lXbG9/zL3jtug14mNZl+IX5aaWfMQ3vdifYTOeSRV0haTRHkhLrB6jRuxAC4ZtNhzLfbeewrJ4tnWfcVVDlRQVdemWD/tJEJzTh0unIZU6cTd28rGNlBe4mGm4XlLeCxAFdkI4DQoFELnvTVgYfXFVcIjAW4BM1XU6442GzIn8pFjsfgv71Vk8THopK3c8SjYMQVrNlB+aDECrZrpWkdqIidBP7HZMW4y5bIQh91+yXUf2ACmO/0kZ+0thuYGXv6SMwveEY3Df/J2T+CbYn87tubtQSW5DCjJ40cSOu6ZVFdfQMFYHfc8HmNSSRvORT6BdBkXfMF30AbP90FLVP5qTULA6EuHfOYZlNgCqcS85ctUnCsCc5GUEcrD9Qt7Ty71szLF7MMRUYJ/7YLWIg85qnPtzRK7Qef
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:30.1170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb987cb-2abb-4e7b-7fba-08df3fd4e410
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB608024
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24754
Content-Type: text/plain; charset="utf-8"

commit 38a3a3b09958d9f2d2a2c72b90a0437cbe8618bf upstream.

The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
is provided at a valid rate other than 32768 Hz. Without an xtal clock,
or when it runs at 32768 Hz, the driver uses SUBU mode.

However, the RTCA0SUBU register used by SUBU mode is not present on all
SoCs that integrate a similar variant of the RTC block. Allowing SUBU
mode on those variants would expose RTC offset operations that access a
non-existent register.

Add OF match data to describe whether the RTC supports the SUBU register.
Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
variant without SUBU support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-16-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 2f2b2f855fb90..49014e7f5ff50 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
@@ -66,6 +67,10 @@
 #define RZN1_RTC_TIMEC 0x68
 #define RZN1_RTC_CALC 0x6c
=20
+struct rzn1_rtc_data {
+	bool has_subu;
+};
+
 struct rzn1_rtc {
 	struct rtc_device *rtcdev;
 	void __iomem *base;
@@ -405,6 +410,7 @@ static void rzn1_rtc_disable_hardware(void *data)
=20
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	const struct rzn1_rtc_data *data;
 	struct device *dev =3D &pdev->dev;
 	unsigned long rate =3D 32768;
 	struct rzn1_rtc *rtc;
@@ -412,6 +418,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	struct clk *xtal;
 	int irq, ret;
=20
+	data =3D of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
 	rtc =3D devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
@@ -455,8 +465,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 		if (rate < 32000 || rate > BIT(22))
 			return -EOPNOTSUPP;
=20
-		if (rate !=3D 32768)
+		if (rate !=3D 32768 || !data->has_subu)
 			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
+	} else if (!data->has_subu) {
+		/* xtal is NULL here */
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "No valid XTAL provided and SUBU mode not supported\n");
 	}
=20
 	/* Calculate the duration of two RTC_PCLK clock cycles */
@@ -509,8 +523,12 @@ static int rzn1_rtc_probe(struct platform_device *pdev=
)
 	return devm_rtc_register_device(rtc->rtcdev);
 }
=20
+static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =3D {
+	.has_subu =3D true,
+};
+
 static const struct of_device_id rzn1_rtc_of_match[] =3D {
-	{ .compatible	=3D "renesas,rzn1-rtc" },
+	{ .compatible	=3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
--=20
2.43.0

