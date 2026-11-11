Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5727.1794388754077745935
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qQzam8GQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKJoaPHTkp2L4GHp7td52MHOFsSd/k3m7GT95quO3TLzOBuMUS+cies6NvktrZyYxahI1aEEGRbdJUtaMlSZtTLtTqD7qYFTx8XylBXRc2N6F/8p8IBUNVigUPC1U6e14cTxZ3TlTQ9Y7l+932Az7JjgUUE2YKBsLTZ6GvUiFfOoZfWFMrt20t1Z5NPyyaAMnOTqe/j4ufyzSxnT85+XDnAYmRQC2GCBdunjMKcGacC29AQTQ1uygVbyWG1Ne7S9BEfUsw7mwZu8Fb31CKjlC4cfpWEoJKfbQhv7LBA08zeUzQoihgR1UVO3sZa7kAD7ozncIHatys/brT5jonMb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNZfqXI4s5lmVg5uDQC6P3S8UbXha8A41XG22FYLMZ8=;
 b=qwsFRTJ17OE6lA0o/LNA0Bcd4jDbqqWEMpin2uylfHaYhrpZAXIGuLKqsFhzJlx/krKnckwcnKdNHZ6vmMSpJ7JgSoHJSxDkZNTbaAHD5TRpuAFJt61ZaNzrfIeqGqYp7adRb+chVeMF2lxiogzAcJQYkfPLX6pB9dzXXzoyaK2W5y7KAsk15QqXu3uM6tXitoDUCyFO6KKuXGPXN1d2KRKQrr4sjJk+njN++JIoBPLnqPhg0wrVESdzm/pPb+VVwsX2LAjgkhUJjxoBSGWfcfYY2xcKxwNimGpBXasw6q5MHXgK8MA/b6ig2i0PwJSQgbnausLFKnTvCZbafPLXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNZfqXI4s5lmVg5uDQC6P3S8UbXha8A41XG22FYLMZ8=;
 b=qQzam8GQuQyfTLBrYJgxbuWYvdzdGIKZ9T2ugVmbwNGhe8Ym3XGXa3sMZuftE1gWkgdp5tVglRtlJDBuOQhX9i8y7czWpNxk2kAyZr6dwHxWV7LIDQ8uOQ/sQTp6QIuIeO2iSNQCEPlqHjmcr5eVurhDNeAPnIgN71bfxSq8pzs=
Received: from TY4P301CA0117.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37e::8)
 by TY1PR01MB10752.jpnprd01.prod.outlook.com (2603:1096:400:321::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:08 +0000
Received: from TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37e:cafe::5b) by TY4P301CA0117.outlook.office365.com
 (2603:1096:405:37e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4F.mail.protection.outlook.com (10.167.253.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:08 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2B4DF3001DF5;
	Wed, 11 Nov 2026 18:19:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/21] rtc: rzn1: implement one-second accuracy for alarms
Date: Wed, 11 Nov 2026 09:18:42 +0000
Message-ID: <20261111091901.41995-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4F:EE_|TY1PR01MB10752:EE_
X-MS-Office365-Filtering-Correlation-Id: 32441ec0-9842-46ba-b27a-08df3fd4d721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|13003099007|11063799006|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: rjTlYLphgbgakFhZJcMfuX+l5iAK7aeL+mCLQNVbqrqJJOkYYnwwEUlnosaJLi+/SpP26a6ZtMmIUFe80lIjotek8ZCOHqzTkfVWHt3ZAuF/nQlHpVLFjoxG13Dyn5WIgI49njPZiyxjgorhPoEKHLyqjNT8m3pykVpQDkoNNYhWnrTQBRK+TjklmYaKGXEkFlJtc+W2JjJ3ados7kvRNfUD57LvcTsjdn5IigBHVuxH5gNDORvbMGZnN29LwxBNxHkigOkgqna0lzeZKB9LPGt3vJO8X0/Hm6VThOqKjGxIN7tdv0smId+MQJuQBgkYTtD+y+9Pp3wxKRHMDamruz4AJu7X0NY/Ua3kCPY98aBr3Zn81xc9BMiNkAJT0+btX2tWoHeca9/NvlFo/oyBqW/E2UhXd/lBhO0W4m2X+4izUMJhqe+DJfCFs85kM6ppeX9FS3YeN4RDo0G/LtrIkAqHchvV/1FBqXzR4LH1eqEt2TTgBMknMibch188UVn7mhUznI2ACcOR6UtW8nD286VLmY1NvBBnhEfJXD0Ss3JI66sxc/Ss0FJKAWTKWHVZesBTYCjnxA74z/jQ0iOrF1Ui8AbLnAEHvAEHp5Mx6FSB+8vSTArFU5PdDyBnU1NMW5MCS2/I2GNedWkWSY1K4QQEQYyveDTy3RyANfXFuqU=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzMHWpXSsJNpah+VX4nPu/LjxFW1G74VQgTStXt9HU43/FPaus46pbdaKnb2+lFfFYDp3SvbLRjJaQAelAWB1YfoovFbynU9o8fEOCOfdIUMdORX10WFxNsjo7q7BnFVMmlc3H0x8uXH1LYHpMEIcy/MEk9J8hDBv4gwyPGM84vWiyGrzPlGi8NHvh/TK0Tyivo6FRkwJLVvDFsvRBQH8ojHqK8wYplkURWOzt0YF84ryzKpVg3E58LagEBCnPS2RzVnZ12VzRtT1S7j02zI0+tAt1fVkfKYhQRpZqPPow1TKfoimz5ct2aW0TOs6CCwi8h67HgBo6AguyH1fLoqsspx0oUfUoEjs1GA0eb2VKVueEK71hrllkqp8/JJ9QBCNqJiznXL7MzR4Mt8DMOD8VUH+6fSGe4XOoNSCBhIizw0x8ihnfP4iQHop4UOA6CK
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:08.4322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32441ec0-9842-46ba-b27a-08df3fd4d721
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24743
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit eea7791e00f33a2a7a0c56479805bf1642ba378d upstream.

The hardware alarm only supports one-minute accuracy which is coarse and
disables UIE usage. Use the 1-second interrupt to achieve per-second
accuracy. It is activated once we hit the per-minute alarm. The new
feature is optional. When there is no 1-second interrupt, old behaviour
with per-minute accuracy is used as before. With this feature, all tests
of 'rtctest' are successfully passed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250305101038.9933-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[PL: manually applied the fix]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 108 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 2d47fae70fe33..0fe6137a9f7d4 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtc.h>
+#include <linux/spinlock.h>
=20
 #define RZN1_RTC_CTL0 0x00
 #define   RZN1_RTC_CTL0_SLSB_SUBU 0
@@ -27,6 +28,7 @@
 #define   RZN1_RTC_CTL0_CE BIT(7)
=20
 #define RZN1_RTC_CTL1 0x04
+#define   RZN1_RTC_CTL1_1SE BIT(3)
 #define   RZN1_RTC_CTL1_ALME BIT(4)
=20
 #define RZN1_RTC_CTL2 0x08
@@ -58,6 +60,13 @@
 struct rzn1_rtc {
 	struct rtc_device *rtcdev;
 	void __iomem *base;
+	/*
+	 * Protects access to RZN1_RTC_CTL1 reg. rtc_lock with threaded_irqs
+	 * would introduce race conditions when switching interrupts because
+	 * of potential sleeps
+	 */
+	spinlock_t ctl1_access_lock;
+	struct rtc_time tm_alarm;
 };
=20
 static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_ti=
me *tm)
@@ -135,8 +144,38 @@ static int rzn1_rtc_set_time(struct device *dev, struc=
t rtc_time *tm)
 static irqreturn_t rzn1_rtc_alarm_irq(int irq, void *dev_id)
 {
 	struct rzn1_rtc *rtc =3D dev_id;
+	u32 ctl1, set_irq_bits =3D 0;
+
+	if (rtc->tm_alarm.tm_sec =3D=3D 0)
+		rtc_update_irq(rtc->rtcdev, 1, RTC_AF | RTC_IRQF);
+	else
+		/* Switch to 1s interrupts */
+		set_irq_bits =3D RZN1_RTC_CTL1_1SE;
=20
-	rtc_update_irq(rtc->rtcdev, 1, RTC_AF | RTC_IRQF);
+	guard(spinlock)(&rtc->ctl1_access_lock);
+
+	ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
+	ctl1 &=3D ~RZN1_RTC_CTL1_ALME;
+	ctl1 |=3D set_irq_bits;
+	writel(ctl1, rtc->base + RZN1_RTC_CTL1);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rzn1_rtc_1s_irq(int irq, void *dev_id)
+{
+	struct rzn1_rtc *rtc =3D dev_id;
+	u32 ctl1;
+
+	if (readl(rtc->base + RZN1_RTC_SECC) =3D=3D bin2bcd(rtc->tm_alarm.tm_sec)=
) {
+		guard(spinlock)(&rtc->ctl1_access_lock);
+
+		ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
+		ctl1 &=3D ~RZN1_RTC_CTL1_1SE;
+		writel(ctl1, rtc->base + RZN1_RTC_CTL1);
+
+		rtc_update_irq(rtc->rtcdev, 1, RTC_AF | RTC_IRQF);
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -144,14 +183,38 @@ static irqreturn_t rzn1_rtc_alarm_irq(int irq, void *=
dev_id)
 static int rzn1_rtc_alarm_irq_enable(struct device *dev, unsigned int enab=
le)
 {
 	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
-	u32 ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
+	struct rtc_time *tm =3D &rtc->tm_alarm, tm_now;
+	u32 ctl1;
+	int ret;
=20
-	if (enable)
-		ctl1 |=3D RZN1_RTC_CTL1_ALME;
-	else
-		ctl1 &=3D ~RZN1_RTC_CTL1_ALME;
+	guard(spinlock_irqsave)(&rtc->ctl1_access_lock);
=20
-	writel(ctl1, rtc->base + RZN1_RTC_CTL1);
+	ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
+
+	if (enable) {
+		/*
+		 * Use alarm interrupt if alarm time is at least a minute away
+		 * or less than a minute but in the next minute. Otherwise use
+		 * 1 second interrupt to wait for the proper second
+		 */
+		do {
+			ctl1 &=3D ~(RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE);
+
+			ret =3D rzn1_rtc_read_time(dev, &tm_now);
+			if (ret)
+				return ret;
+
+			if (rtc_tm_sub(tm, &tm_now) > 59 || tm->tm_min !=3D tm_now.tm_min)
+				ctl1 |=3D RZN1_RTC_CTL1_ALME;
+			else
+				ctl1 |=3D RZN1_RTC_CTL1_1SE;
+
+			writel(ctl1, rtc->base + RZN1_RTC_CTL1);
+		} while (readl(rtc->base + RZN1_RTC_SECC) !=3D bin2bcd(tm_now.tm_sec));
+	} else {
+		ctl1 &=3D ~(RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE);
+		writel(ctl1, rtc->base + RZN1_RTC_CTL1);
+	}
=20
 	return 0;
 }
@@ -170,7 +233,7 @@ static int rzn1_rtc_read_alarm(struct device *dev, stru=
ct rtc_wkalrm *alrm)
 		return ret;
=20
 	ctl1 =3D readl(rtc->base + RZN1_RTC_CTL1);
-	alrm->enabled =3D !!(ctl1 & RZN1_RTC_CTL1_ALME);
+	alrm->enabled =3D !!(ctl1 & (RZN1_RTC_CTL1_ALME | RZN1_RTC_CTL1_1SE));
=20
 	min =3D readl(rtc->base + RZN1_RTC_ALM);
 	hour =3D readl(rtc->base + RZN1_RTC_ALH);
@@ -224,6 +287,8 @@ static int rzn1_rtc_set_alarm(struct device *dev, struc=
t rtc_wkalrm *alrm)
 	writel(bin2bcd(tm->tm_hour), rtc->base + RZN1_RTC_ALH);
 	writel(BIT(tm->tm_wday), rtc->base + RZN1_RTC_ALW);
=20
+	rtc->tm_alarm =3D alrm->time;
+
 	rzn1_rtc_alarm_irq_enable(dev, alrm->enabled);
=20
 	return 0;
@@ -312,7 +377,7 @@ static const struct rtc_class_ops rzn1_rtc_ops =3D {
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
 	struct rzn1_rtc *rtc;
-	int alarm_irq;
+	int irq;
 	int ret;
=20
 	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -325,9 +390,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->base), "Missing reg\n");
=20
-	alarm_irq =3D platform_get_irq(pdev, 0);
-	if (alarm_irq < 0)
-		return alarm_irq;
+	irq =3D platform_get_irq_byname(pdev, "alarm");
+	if (irq < 0)
+		return irq;
=20
 	rtc->rtcdev =3D devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtcdev))
@@ -337,8 +402,6 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;
 	rtc->rtcdev->alarm_offset_max =3D 7 * 86400;
 	rtc->rtcdev->ops =3D &rzn1_rtc_ops;
-	set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
-	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
=20
 	ret =3D devm_pm_runtime_enable(&pdev->dev);
 	if (ret < 0)
@@ -357,13 +420,24 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	/* Disable all interrupts */
 	writel(0, rtc->base + RZN1_RTC_CTL1);
=20
-	ret =3D devm_request_irq(&pdev->dev, alarm_irq, rzn1_rtc_alarm_irq, 0,
-			       dev_name(&pdev->dev), rtc);
+	spin_lock_init(&rtc->ctl1_access_lock);
+
+	ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RT=
C Alarm", rtc);
 	if (ret) {
-		dev_err(&pdev->dev, "RTC timer interrupt not available\n");
+		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
 		goto dis_runtime_pm;
 	}
=20
+	irq =3D platform_get_irq_byname_optional(pdev, "pps");
+	if (irq >=3D 0)
+		ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC =
1s", rtc);
+
+	if (irq < 0 || ret) {
+		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
+		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only mi=
nute accuracy\n");
+	}
+
 	ret =3D devm_rtc_register_device(rtc->rtcdev);
 	if (ret)
 		goto dis_runtime_pm;
--=20
2.43.0

