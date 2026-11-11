Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5795.1794388776577848746
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ss78N9O5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.43, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEPBqlAhtzyZhVQWfxVgTKTa14RO0JCy0QoaBq7LssaVE+stwtEIe0LqQCM1a0vRsSEJNAu4I3ihXCVITAAMnm67Tza3CXxhXvUgrIxkPij83R1vEYYKiKGO35uqoNxpM/UqYNxTajpntqk6LSNZTy34X9rjIBhfhWcczvtL5rO3wN9o+QXXSugI+b3FZDyEjJ2ae2/l3P7J6WiOeS6twh/V6XwE02Rd174n3vt+PZactGl1ZC4RWMdHYQIWGhtmYGKTtYBnGYXpUu2TBAD5AQ9R8S80X5yCevakl9Lkrn6L/TZJtOTA12NjHTaPo5cKb04CpRVUzgrZVkihrepvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytz6GzfngSqfi7eWuPOL3cKmpORUMHras+XUwK26wxI=;
 b=qBXfvAj/RTrRBkjpAuPn8xxV/0l4H+4FHPw6+VdLpVkReBQgAH1Z+r3vnhUdvf+IE6mfQVznsvjF0nv2vaX4JDKUojpDKmtFQTkU5KCH7tjaN1oWKRyptTLQFF+9GbJeb+JditFzaKIBFX0UNqiU237jHkCAE7ECnb4zuJnCfcIt9SDd8zVSHUsf5Xd2Agv2lBY7L4CdMaK5z2x+doT+5wAoRylbL+xoVVApQi97W2SmXtsPW9IWWSVUJbFK17TXFD/6de7IbNkTQ5aYvNW8cUP5sMxr84i9luEycdndxDk5UNS+ey4g19aPzaDnzOcJdMOX984qeMPKeafGUiX3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytz6GzfngSqfi7eWuPOL3cKmpORUMHras+XUwK26wxI=;
 b=Ss78N9O55XRW/v+pld5/cWZckRVL4d1kGVqIBEpoMT926ZyMy15QkGwzcYahAlnF0pEWl5vraqqKpF9ZRYNd7Y6kMkLAQBxe3bvNR6xDJg9h1Pvxj5PZA2jmhL1IdqebCoGI9ZpzzECsY8vfjMEes1rW9/s07Mlvj+bNy13iJwk=
Received: from OS3P301CA0060.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21c::16)
 by OSOPR01MB12360.jpnprd01.prod.outlook.com (2603:1096:604:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:31 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21c:cafe::89) by OS3P301CA0060.outlook.office365.com
 (2603:1096:604:21c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:28 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1A0653001DE8;
	Wed, 11 Nov 2026 18:19:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/21] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
Date: Wed, 11 Nov 2026 09:18:54 +0000
Message-ID: <20261111091901.41995-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OSOPR01MB12360:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa3def5-315d-4bf8-3527-08df3fd4e314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bXI1SgZqW5Rpre2FraPQ7DnQ1i/r+o3c9N471gfCsEFQ3MLmkIr6FZEUv08PaEcPC34cwC4GomioO41EGi8jW64odexbijqzPIvHQivOwijxY2rKNvl3vkqC3mmf+FAFqQ05rISrfvrkxXbD6pD0t0RGdzkva8s0S4qDeYggFBB0iDvq3R02/sLKDGeStJuA3FrX7Jvy4DEwIU4kK28ReNE/NpGJ/0EhNvIai/CtBVNinwToEXSSQsWZgNsRT3qKUKnso7uq/aJ4hdI6mUXUXrtL5qKWOqoGkf69G/Qleyblz3PiReKVhFyHr/xzrokMD1olBX9bqRXRX2kMAoNR06LEZGBBUqx2YBzCk3kZ1lahR82smkEQ3KipP0kw7gUozBDxEO370E1TnLJp/XcmgnBIuWSa3cAhR3VBZql4dXSpxr1UQi+h09h0OTYWlZ51Zz9Q7VnHhLLo7ZSF3ejhtdk+qT2y0l9CJapFVmeWmLv7StKRtfXHTjSJYPBaeCeB4rZCSu8EKiTvdpVtUIWdq6f+L3qEfQa3XnoTkb7Lja3mcGk8lnGk44+qaqccoHty9v24XqB01vHGm1BDVzylmYrxfQcOWanoGfhhf4lTtfz4KyQEUBQfhG+fH1xEhWVyZvz4THrl7MVFIzuhUR1qzw9yQNwYv1rdP0PY0vKZAmw=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7VOaGLKUVZIlw3MkkfVF1jUIVwjO/cbXCBrZ5PJOBotAqBp5GrxzUjF5JRkUR+PXW8RstjO2fuap6bvfvnEif5NPxTfszchySFiON6/+jhn4ejTHywfftEfGIQfUcD10cL5eu9s0s5nJk2xkhVaR1ubmKM5dhZdMwMtouUxCealSgFl+RqueKpKkh741loSQHtK5Y/y+Zmh6SZEhR3C67YX9rcG+w8Udvi12HCmLeiXOal4fM4mBOHwRE97uh/7k8Oef0QkGP4lnCACiWjCu1hJjoA2F2NBVLuc0XhVCigHhDyp49yoQN1PfL0h1Q1oMYSaam9VWLDn2yMmtad89auzIoM6sFfOYuUmkmGUnyfk6jChTz9shIt45gYoaeT05MtivMeduzeiZWSJDHqoGdcEBf3dhiopYYE7SYmJh8d8ogWNctcIO6HHIa6E4FZfz
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:28.4623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa3def5-315d-4bf8-3527-08df3fd4e314
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12360
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24755
Content-Type: text/plain; charset="utf-8"

commit 5ae93269d3e51db730ca3ee96f8833e4d3befd95 upstream.

Replace open-coded shift and mask operations with the bitfield API.

Note that the weekday field is changed from an explicit 0x0f mask to
an 8-bit field definition, matching the hardware manual. This does not
change behaviour, as valid weekday values cannot exceed 7.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-15-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 0038c8b584284..2f2b2f855fb90 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -12,6 +12,8 @@
  */
=20
 #include <linux/bcd.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
@@ -39,14 +41,18 @@
 #define   RZN1_RTC_CTL2_STOPPED (RZN1_RTC_CTL2_WAIT | RZN1_RTC_CTL2_WST)
=20
 #define RZN1_RTC_TIME 0x30
-#define RZN1_RTC_TIME_MIN_SHIFT 8
-#define RZN1_RTC_TIME_HOUR_SHIFT 16
+#define RZN1_RTC_TIME_SEC GENMASK(7, 0)
+#define RZN1_RTC_TIME_MIN GENMASK(15, 8)
+#define RZN1_RTC_TIME_HOUR GENMASK(23, 16)
+
 #define RZN1_RTC_CAL 0x34
-#define RZN1_RTC_CAL_DAY_SHIFT 8
-#define RZN1_RTC_CAL_MON_SHIFT 16
-#define RZN1_RTC_CAL_YEAR_SHIFT 24
+#define RZN1_RTC_CAL_WDAY GENMASK(7, 0)
+#define RZN1_RTC_CAL_DAY GENMASK(15, 8)
+#define RZN1_RTC_CAL_MON GENMASK(23, 16)
+#define RZN1_RTC_CAL_YEAR GENMASK(31, 24)
=20
 #define RZN1_RTC_SUBU 0x38
+#define   RZN1_RTC_SUBU_RTCA0FX GENMASK(5, 0)
 #define   RZN1_RTC_SUBU_DEV BIT(7)
 #define   RZN1_RTC_SUBU_DECR BIT(6)
=20
@@ -78,15 +84,15 @@ static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc =
*rtc, struct rtc_time *tm
 	u32 val;
=20
 	val =3D readl(rtc->base + RZN1_RTC_TIMEC);
-	tm->tm_sec =3D bcd2bin(val);
-	tm->tm_min =3D bcd2bin(val >> RZN1_RTC_TIME_MIN_SHIFT);
-	tm->tm_hour =3D bcd2bin(val >> RZN1_RTC_TIME_HOUR_SHIFT);
+	tm->tm_sec =3D bcd2bin(FIELD_GET(RZN1_RTC_TIME_SEC, val));
+	tm->tm_min =3D bcd2bin(FIELD_GET(RZN1_RTC_TIME_MIN, val));
+	tm->tm_hour =3D bcd2bin(FIELD_GET(RZN1_RTC_TIME_HOUR, val));
=20
 	val =3D readl(rtc->base + RZN1_RTC_CALC);
-	tm->tm_wday =3D val & 0x0f;
-	tm->tm_mday =3D bcd2bin(val >> RZN1_RTC_CAL_DAY_SHIFT);
-	tm->tm_mon =3D bcd2bin(val >> RZN1_RTC_CAL_MON_SHIFT) - 1;
-	tm->tm_year =3D bcd2bin(val >> RZN1_RTC_CAL_YEAR_SHIFT) + 100;
+	tm->tm_wday =3D FIELD_GET(RZN1_RTC_CAL_WDAY, val);
+	tm->tm_mday =3D bcd2bin(FIELD_GET(RZN1_RTC_CAL_DAY, val));
+	tm->tm_mon =3D bcd2bin(FIELD_GET(RZN1_RTC_CAL_MON, val)) - 1;
+	tm->tm_year =3D bcd2bin(FIELD_GET(RZN1_RTC_CAL_YEAR, val)) + 100;
 }
=20
 static int rzn1_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -129,15 +135,15 @@ static int rzn1_rtc_set_time(struct device *dev, stru=
ct rtc_time *tm)
 			return ret;
 	}
=20
-	val =3D bin2bcd(tm->tm_sec);
-	val |=3D bin2bcd(tm->tm_min) << RZN1_RTC_TIME_MIN_SHIFT;
-	val |=3D bin2bcd(tm->tm_hour) << RZN1_RTC_TIME_HOUR_SHIFT;
+	val =3D FIELD_PREP(RZN1_RTC_TIME_SEC, bin2bcd(tm->tm_sec)) |
+	      FIELD_PREP(RZN1_RTC_TIME_MIN, bin2bcd(tm->tm_min)) |
+	      FIELD_PREP(RZN1_RTC_TIME_HOUR, bin2bcd(tm->tm_hour));
 	writel(val, rtc->base + RZN1_RTC_TIME);
=20
-	val =3D tm->tm_wday;
-	val |=3D bin2bcd(tm->tm_mday) << RZN1_RTC_CAL_DAY_SHIFT;
-	val |=3D bin2bcd(tm->tm_mon + 1) << RZN1_RTC_CAL_MON_SHIFT;
-	val |=3D bin2bcd(tm->tm_year - 100) << RZN1_RTC_CAL_YEAR_SHIFT;
+	val =3D FIELD_PREP(RZN1_RTC_CAL_WDAY, tm->tm_wday) |
+	      FIELD_PREP(RZN1_RTC_CAL_DAY, bin2bcd(tm->tm_mday)) |
+	      FIELD_PREP(RZN1_RTC_CAL_MON, bin2bcd(tm->tm_mon + 1)) |
+	      FIELD_PREP(RZN1_RTC_CAL_YEAR, bin2bcd(tm->tm_year - 100));
 	writel(val, rtc->base + RZN1_RTC_CAL);
=20
 	writel(0, rtc->base + RZN1_RTC_CTL2);
@@ -308,12 +314,12 @@ static int rzn1_rtc_read_offset(struct device *dev, l=
ong *offset)
 	val =3D readl(rtc->base + RZN1_RTC_SUBU);
 	ppb_per_step =3D val & RZN1_RTC_SUBU_DEV ? 1017 : 3051;
 	subtract =3D val & RZN1_RTC_SUBU_DECR;
-	val &=3D 0x3F;
+	val =3D FIELD_GET(RZN1_RTC_SUBU_RTCA0FX, val);
=20
 	if (!val)
 		*offset =3D 0;
 	else if (subtract)
-		*offset =3D -(((~val) & 0x3F) + 1) * ppb_per_step;
+		*offset =3D -(((~val) & RZN1_RTC_SUBU_RTCA0FX) + 1) * ppb_per_step;
 	else
 		*offset =3D (val - 1) * ppb_per_step;
=20
@@ -355,7 +361,7 @@ static int rzn1_rtc_set_offset(struct device *dev, long=
 offset)
 		subu |=3D steps + 1;
 	} else {
 		subu |=3D RZN1_RTC_SUBU_DECR;
-		subu |=3D (~(-steps - 1)) & 0x3F;
+		subu |=3D (~(-steps - 1)) & RZN1_RTC_SUBU_RTCA0FX;
 	}
=20
 	ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, ctl2,
--=20
2.43.0

