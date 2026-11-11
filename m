Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5728.1794388754089779950
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sBzxTyA3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.34, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhq3X1aO/4YKv9qXjDNugjfpMSutpYjvMg1QqBA4hIEnMjR0BR68rUmaNF9G66opQ/mHCia3V9wjesD/h9Cbd2234E70sm9Sh8KRDqM9xW7UVYq6aA/ePZQpSgTdI9V4CmZxvWICUmNaZHw7V+yDL/Xuwam5JKDZ6b2WMv4QTL1L6A67EmK2Kx29b4KRKBeSAbwZdFYwitsdSO3Lz/YH7hcfPK60iThnmCssMixJHTw0bikbKHPKnh+DSGnZxBEXbjhzKe7XO5ZgkCqZWGyKnJyXo5wz4G2+1X+P3EwfIRYK7Fyu+VjBEKGWxiha3wwozcLjIHlC48tPJn3BNFpyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEPEYGbK7cMZEpJbMdFiTGix2S2gVoKPfV7VJBQSaa0=;
 b=rkvtyQ6zkQdBvtF3kVtwfsQpXnFyHAExtdtTe06krz7B9kzKaozzuyiWlD6zXX3Mt0p9ea5/4UEFV8GIiICVOP4DJdSeD79mQzv8h0uLiSeJlTM6MxdX5Ccq89hzz19/SGpx+WTp8IyKl7XP5HpRHAHc+B6FfySxFs2fSWgr8sY1+ROTHl7BtwHZTHy54lSPC8kbqQ5Zc54vLKKC5e+M38qF3SZBxbWdnxqBQnbNXK+Zv4aaCW4HhHE0M0rRuYCRQBec10vLpKU25ApB2luYSE2uO8obdy8v2a+dggMHbYoqY0+Cmb9jqc4Y6oZHNlKkyhSwajGYWBmaKkfwfRkndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEPEYGbK7cMZEpJbMdFiTGix2S2gVoKPfV7VJBQSaa0=;
 b=sBzxTyA3yMAOQvMXGPBiaHO1gbX8k7wmucQ/tSRg2syDUH3auzrNatqwTLnAghQePRBqXj+iq2aCDM/OlsC/p4Mqefw8v4en2vN91RWQgn/fR7U7AzHqGdEASTq6HFmjuMpri/xeroCY4oTTamsYroPk3jA0k+xkyrhJ85nro6A=
Received: from OS7PR01CA0031.jpnprd01.prod.outlook.com (2603:1096:604:257::17)
 by TYWPR01MB9559.jpnprd01.prod.outlook.com (2603:1096:400:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 09:19:07 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:257:cafe::23) by OS7PR01CA0031.outlook.office365.com
 (2603:1096:604:257::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:06 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7F0CC3001DE8;
	Wed, 11 Nov 2026 18:19:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/21] rtc: rzn1: reduce register access
Date: Wed, 11 Nov 2026 09:18:41 +0000
Message-ID: <20261111091901.41995-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYWPR01MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a24a48e-0547-40a4-8d1b-08df3fd4d634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|18002099003|22082099003|13003099007|261028144727099003|10067099003|11063799006|56012099006|261009223027099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 5XCrnklc4/VrOAu93DBn5e/JBZuwHiJfqmYAMQKE29yflEQ0+Emi2+NybIZ8Wql2TJLQbck3lMtAIOQbf+Kzs4F23EvoqZRNEAvoJPmt8fql6a5L56gnOHIdkPe7ts7sDK9EFX6VjMpRnDhX57y+SsAxKBbn6jLKHxORc78SE8sBrqyq8VhsSs/bN8QId7wSlc3DSFMmF4Xo6ya6d/gd2AwZfCHY43NTQ8zeBr+oEixnKnj3S4TX36cDGlfSw2XBMJ+9/qtO5xsET0gkNcirEta9mtFDH6DKk+wKbilidjZjDT5V6zUJ034m2H71Eo9QwuslZx1c6f1KfCfsl5LN6fzBtyK4qjVLWJ/uptOf1QLonOw1riRGST/N1NvMk32iWN8e2gN3yFdvDOPmF/YEtGEHOwk4GpInQhqE6NECinURS0qlgyLoErMMIZL9HMrGlPLd4WwJzpfXSYAGdIiDu73WwOBSc53K/Z4i+h5EXmI9EWr+EsT4rfShI/mRarnz394XK47gZMQCVXbmQE3EnNavV48HhHNMMU9mCZEUmYEJI9BCGN6Hp+qeNRbC9LJJyaMpb9375qE3hc2KfVU8iY3mXdRruFJtyKmUaYvKk849IUtklQjvRslIWYyDl9SFUPK70e8P77KvRdIKXPPB+mzArksqwJ8/+CbQY/0YQ3Q=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(13003099007)(261028144727099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YK5sQAo+02NCdKkexNnuxjUfcNhH+UUVi55Dt8UxX4FAj+djP/iGXHPGef2rRDbH3NV/PIpWOen7CKdgw5HrO9fco3DzefHe03ky19vpqauWwuiYyB0zPN0bJDIrQXjP0TfK0ZoTwS9M42cQNWhhV04MnoKgUeEcq7iy1X3tYVSHW6gwwpWZSj5pN/98wK6gSab+BbIsAJSa2Yh3HZfjf2AqYQ01KuwcaAE4UrvZFfFt2WOMU6fvgJzYRHD0jk29wqaeZciqsObsSGchXeS9KnQk6lWXlJgyBhUoT0oUKehV//iL+43HcWjeKJXSxWx76mhAq6WrxbXskKggD3SAVhCP5jKC4hZgLK8JBmH8VqaG7ueBdbgMCs2wMfg/pQVYEzoiU3MK70Ls8DfbUN2czDplNq01/B416aF9/MUzxaYZWZsekeJc2XmTs5N50q1p
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:06.8643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a24a48e-0547-40a4-8d1b-08df3fd4d634
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9559
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24744
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 3ed345c948ef6ccd0f5dc85c5b6731593b4591f7 upstream.

This RTC has special 32bit registers which return multiple of the same
8bit registers at once. Use these to minimize register access. Also, do
the to/from BCD conversions right away, so 'tm' always contains values
as described in time.h.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/r/20241122101448.4374-3-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 75 +++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index bdd4ec02a7672..2d47fae70fe33 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -35,13 +35,13 @@
 #define   RZN1_RTC_CTL2_WUST BIT(5)
 #define   RZN1_RTC_CTL2_STOPPED (RZN1_RTC_CTL2_WAIT | RZN1_RTC_CTL2_WST)
=20
-#define RZN1_RTC_SEC 0x14
-#define RZN1_RTC_MIN 0x18
-#define RZN1_RTC_HOUR 0x1c
-#define RZN1_RTC_WEEK 0x20
-#define RZN1_RTC_DAY 0x24
-#define RZN1_RTC_MONTH 0x28
-#define RZN1_RTC_YEAR 0x2c
+#define RZN1_RTC_TIME 0x30
+#define RZN1_RTC_TIME_MIN_SHIFT 8
+#define RZN1_RTC_TIME_HOUR_SHIFT 16
+#define RZN1_RTC_CAL 0x34
+#define RZN1_RTC_CAL_DAY_SHIFT 8
+#define RZN1_RTC_CAL_MON_SHIFT 16
+#define RZN1_RTC_CAL_YEAR_SHIFT 24
=20
 #define RZN1_RTC_SUBU 0x38
 #define   RZN1_RTC_SUBU_DEV BIT(7)
@@ -52,12 +52,8 @@
 #define RZN1_RTC_ALW 0x48
=20
 #define RZN1_RTC_SECC 0x4c
-#define RZN1_RTC_MINC 0x50
-#define RZN1_RTC_HOURC 0x54
-#define RZN1_RTC_WEEKC 0x58
-#define RZN1_RTC_DAYC 0x5c
-#define RZN1_RTC_MONTHC 0x60
-#define RZN1_RTC_YEARC 0x64
+#define RZN1_RTC_TIMEC 0x68
+#define RZN1_RTC_CALC 0x6c
=20
 struct rzn1_rtc {
 	struct rtc_device *rtcdev;
@@ -66,13 +62,18 @@ struct rzn1_rtc {
=20
 static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_ti=
me *tm)
 {
-	tm->tm_sec =3D readl(rtc->base + RZN1_RTC_SECC);
-	tm->tm_min =3D readl(rtc->base + RZN1_RTC_MINC);
-	tm->tm_hour =3D readl(rtc->base + RZN1_RTC_HOURC);
-	tm->tm_wday =3D readl(rtc->base + RZN1_RTC_WEEKC);
-	tm->tm_mday =3D readl(rtc->base + RZN1_RTC_DAYC);
-	tm->tm_mon =3D readl(rtc->base + RZN1_RTC_MONTHC);
-	tm->tm_year =3D readl(rtc->base + RZN1_RTC_YEARC);
+	u32 val;
+
+	val =3D readl(rtc->base + RZN1_RTC_TIMEC);
+	tm->tm_sec =3D bcd2bin(val);
+	tm->tm_min =3D bcd2bin(val >> RZN1_RTC_TIME_MIN_SHIFT);
+	tm->tm_hour =3D bcd2bin(val >> RZN1_RTC_TIME_HOUR_SHIFT);
+
+	val =3D readl(rtc->base + RZN1_RTC_CALC);
+	tm->tm_wday =3D val & 0x0f;
+	tm->tm_mday =3D bcd2bin(val >> RZN1_RTC_CAL_DAY_SHIFT);
+	tm->tm_mon =3D bcd2bin(val >> RZN1_RTC_CAL_MON_SHIFT) - 1;
+	tm->tm_year =3D bcd2bin(val >> RZN1_RTC_CAL_YEAR_SHIFT) + 100;
 }
=20
 static int rzn1_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -90,16 +91,9 @@ static int rzn1_rtc_read_time(struct device *dev, struct=
 rtc_time *tm)
=20
 	rzn1_rtc_get_time_snapshot(rtc, tm);
 	secs =3D readl(rtc->base + RZN1_RTC_SECC);
-	if (tm->tm_sec !=3D secs)
+	if (tm->tm_sec !=3D bcd2bin(secs))
 		rzn1_rtc_get_time_snapshot(rtc, tm);
=20
-	tm->tm_sec =3D bcd2bin(tm->tm_sec);
-	tm->tm_min =3D bcd2bin(tm->tm_min);
-	tm->tm_hour =3D bcd2bin(tm->tm_hour);
-	tm->tm_mday =3D bcd2bin(tm->tm_mday);
-	tm->tm_mon =3D bcd2bin(tm->tm_mon) - 1;
-	tm->tm_year =3D bcd2bin(tm->tm_year) + 100;
-
 	return 0;
 }
=20
@@ -109,13 +103,6 @@ static int rzn1_rtc_set_time(struct device *dev, struc=
t rtc_time *tm)
 	u32 val;
 	int ret;
=20
-	tm->tm_sec =3D bin2bcd(tm->tm_sec);
-	tm->tm_min =3D bin2bcd(tm->tm_min);
-	tm->tm_hour =3D bin2bcd(tm->tm_hour);
-	tm->tm_mday =3D bin2bcd(tm->tm_mday);
-	tm->tm_mon =3D bin2bcd(tm->tm_mon + 1);
-	tm->tm_year =3D bin2bcd(tm->tm_year - 100);
-
 	val =3D readl(rtc->base + RZN1_RTC_CTL2);
 	if (!(val & RZN1_RTC_CTL2_STOPPED)) {
 		/* Hold the counter if it was counting up */
@@ -129,13 +116,17 @@ static int rzn1_rtc_set_time(struct device *dev, stru=
ct rtc_time *tm)
 			return ret;
 	}
=20
-	writel(tm->tm_sec, rtc->base + RZN1_RTC_SEC);
-	writel(tm->tm_min, rtc->base + RZN1_RTC_MIN);
-	writel(tm->tm_hour, rtc->base + RZN1_RTC_HOUR);
-	writel(tm->tm_wday, rtc->base + RZN1_RTC_WEEK);
-	writel(tm->tm_mday, rtc->base + RZN1_RTC_DAY);
-	writel(tm->tm_mon, rtc->base + RZN1_RTC_MONTH);
-	writel(tm->tm_year, rtc->base + RZN1_RTC_YEAR);
+	val =3D bin2bcd(tm->tm_sec);
+	val |=3D bin2bcd(tm->tm_min) << RZN1_RTC_TIME_MIN_SHIFT;
+	val |=3D bin2bcd(tm->tm_hour) << RZN1_RTC_TIME_HOUR_SHIFT;
+	writel(val, rtc->base + RZN1_RTC_TIME);
+
+	val =3D tm->tm_wday;
+	val |=3D bin2bcd(tm->tm_mday) << RZN1_RTC_CAL_DAY_SHIFT;
+	val |=3D bin2bcd(tm->tm_mon + 1) << RZN1_RTC_CAL_MON_SHIFT;
+	val |=3D bin2bcd(tm->tm_year - 100) << RZN1_RTC_CAL_YEAR_SHIFT;
+	writel(val, rtc->base + RZN1_RTC_CAL);
+
 	writel(0, rtc->base + RZN1_RTC_CTL2);
=20
 	return 0;
--=20
2.43.0

