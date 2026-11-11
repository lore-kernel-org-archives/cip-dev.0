Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5798.1794388777286202825
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oUozwOcu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awHHdjg0+0eBMtOrSi0mPuayfyC7S5MIY5VfjaXf0FsWN7XBM/0pC0n6FiAQ3gnVDHFofplXk/pVK7jlqxSf7ByA+HYTG6eWCJxQESlzayS9SWdIiZSKrAn9z4PL2iu3iWx/qZxQ/vzgSN51R0bvwm3rfOoN3q+N9jWo7Jbyz6G345tM+j45AkzEhvgIh/hZG0GsgcduDeox6eV/ba7uetico2dhWYB1dJdEK2FhFip6zVAuIitIF1fRx76kxCZmzmxgB+ST1kQ16byju05XMa0o774F0vPgSBmOk/OZNWWxTbaxNBfveyuBbHd88dmiM0hjvgSnkpntWpj1k4mJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neHYLDVjT5ReP/ce1GvXEL/0K52a+m0bx4XzbTMlUks=;
 b=Y4j/ivlMM3O/Y0UhVAfk+ofs9p7Bh/K8fG888u7N65iJ4RridtOi1Wa1adzQSbQm0R6/v4lpQYId4SlAwOo/HeE++LvHOk5SIX8vHQ/lmXZwAd97x6sDHZWrfZoxkfd5KB0z1fVMvPjYf0SbTajnjDsBbMBWv3TxV2gWaP44f1L2u8jWYsMjTEL7rFpLGSiWuNJK3NcVgvDSldzjanpyemoEI7ZZJ1RrscnVn5zxnTsMX7XCWP5RgSni9KMv5Zx/iZHhqVCvdECZysoLYqCBj+9oC78a2gEUWjVX+Y/yLaLUTKLq+mr1bxCfF7nbf3AoGi7nLozM6LHcKGIUCQn82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neHYLDVjT5ReP/ce1GvXEL/0K52a+m0bx4XzbTMlUks=;
 b=oUozwOcuUMLG+LWR/hURqc2GTTz1WJDu49Nlz2yoGv/fjkIEi1FoN7AnzGqRyLhfHaUgpKMNSCbfz9k6rXhXjzV37APeQi3rb4ArBOR9ouchPRZ5e366NIrlAwE5UsHH6dY5qmgmLAWn8wEXbsk5IYbRiPl/eQYP+6wj2snf1XA=
Received: from TY6PR01CA0029.jpnprd01.prod.outlook.com (2603:1096:405:3bd::6)
 by TYCPR01MB10276.jpnprd01.prod.outlook.com (2603:1096:400:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:19:25 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bd:cafe::2f) by TY6PR01CA0029.outlook.office365.com
 (2603:1096:405:3bd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:25 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C169E3001DE8;
	Wed, 11 Nov 2026 18:19:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/21] rtc: rzn1: Use temporary variable for struct device
Date: Wed, 11 Nov 2026 09:18:52 +0000
Message-ID: <20261111091901.41995-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TYCPR01MB10276:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cc3045-78c4-4c2f-84c1-08df3fd4e10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|261009223027099003|11063799006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: JQgb3aIRricThZsYn8sJeFljSfPHfhtghirCGlIAl+TqCMwk0HS2Z3Kgb639B6EPtgrURQw9o0F3BdZ4nz2Hy1LscKO2chOpeR90BSvFYqc8mfso4KUjPUyhpEbubXqj/NYUIHQnlEDSEnv/dfOOXRcdrMHPeXMmSMzbaqD4rNkM1/dwXMooN1HdBm9mvIAA7xekaMiHLeLK0EiOT2K80UejqagS8+Q8Z9txFtVT/h4og90qs9HKwj+3D/1RDEeTpsOI3Ij/67PdXHKLFbIkFLjc9QVaF780ttBvvy7NoUmsU6SqofZfoHoCEJ3aPA7IxSBNLXt26WRSnblBWmJ5c21vqrbKzmdD9I0NQyNEzz4Uof0TC3C19Pps/CyAnfCKcVYbjq/DTOwc2SO5x+vjX8xtCpHTCHRDBq0SC/ORNb8Qj8RJc1+rxlXeNycrSyTrNlURBdXOJIWJcnqZoefTtcaHKzlu0DxkcthhJOZnaOzc+3MiuDwslCI7Im+NQKjF8q9PkIML7y85UDomQb0Uiq7BshUpsUA248NWAfkFG/0BKMMNtHGTVOyEM39gPXt93NRxKng6mQ7V9yatZ3KSkH8JItPCuVHtC4t5BmK4dBsUE4faqlC8f4Fc3SpU2BBEAdl+F2sYLem/F30kr/+vcShlQXwaepbblsYxdS9MzEU=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(11063799006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qxbtVHCOL+X03AFuX4liqhg/+78wJSV7XiIgiCouoI/A5Vs/3buz8n8Gcv0h69glkBhybOoYcPiDt0KUjfXoUCB03gJTe3BPAZeFoXmoBbfK0WlVqTDfw+4ZJPnpTmxCBN8Q8aY1R0BxSGyI7fAwmlQN36A/+neKrkQro12dyjCopYzbMvKLFurSnYTxYQRFjwZvbTmJcXBCsxyqaGNWp5I7mUBIHd4xyusI/iq9tjNBXbgwebCeBlgNpJlimmU9048IxU5C3Bld8pp6Wfx1IgMmrh/kLVUXVRtaviezNpAt+qly2bWek4YIKl9k+PDejIYS5wQO+UKoPnN+MsudI/cmAw49kJIkT3qzvQemHFP0ub5gu8eiHeLkLZrf0c5NEDa5zdof/gXeH8WLh0VaqxTfz2EQNDpc9Nl8ZN1owdFf3H69/Dv3p6KqW/UGrw97
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:25.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cc3045-78c4-4c2f-84c1-08df3fd4e10a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10276
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24758
Content-Type: text/plain; charset="utf-8"

commit b587001387c16b3a75b8ed9399feee157ad3d3b4 upstream.

Use a temporary variable for the struct device pointers to avoid
dereferencing.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-13-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 001ce0cc2d550..5849c32148868 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -399,13 +399,14 @@ static void rzn1_rtc_disable_hardware(void *data)
=20
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	unsigned long rate =3D 32768;
 	struct rzn1_rtc *rtc;
 	u32 val, scmp_val =3D 0;
 	struct clk *xtal;
 	int irq, ret;
=20
-	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	rtc =3D devm_kzalloc(dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
=20
@@ -413,13 +414,13 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
=20
 	rtc->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->base))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->base), "Missing reg\n");
+		return dev_err_probe(dev, PTR_ERR(rtc->base), "Missing reg\n");
=20
 	irq =3D platform_get_irq_byname(pdev, "alarm");
 	if (irq < 0)
 		return irq;
=20
-	rtc->rtcdev =3D devm_rtc_allocate_device(&pdev->dev);
+	rtc->rtcdev =3D devm_rtc_allocate_device(dev);
 	if (IS_ERR(rtc->rtcdev))
 		return PTR_ERR(rtc->rtcdev);
=20
@@ -427,19 +428,19 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;
 	rtc->rtcdev->alarm_offset_max =3D 7 * 86400;
=20
-	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	ret =3D devm_pm_runtime_enable(dev);
 	if (ret < 0)
 		return ret;
-	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
=20
-	ret =3D devm_add_action_or_reset(&pdev->dev, rzn1_rtc_disable_hardware, &=
pdev->dev);
+	ret =3D devm_add_action_or_reset(dev, rzn1_rtc_disable_hardware, dev);
 	if (ret)
 		return ret;
=20
 	/* Only switch to scmp if we have an xtal clock with a valid rate and !=
=3D 32768 */
-	xtal =3D devm_clk_get_optional(&pdev->dev, "xtal");
+	xtal =3D devm_clk_get_optional(dev, "xtal");
 	if (IS_ERR(xtal)) {
 		return PTR_ERR(xtal);
 	} else if (xtal) {
@@ -483,9 +484,9 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
=20
 	spin_lock_init(&rtc->ctl1_access_lock);
=20
-	ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RT=
C Alarm", rtc);
+	ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm=
", rtc);
 	if (ret) {
-		dev_err(&pdev->dev, "RTC alarm interrupt not available\n");
+		dev_err(dev, "RTC alarm interrupt not available\n");
 		return ret;
 	}
=20
@@ -493,12 +494,12 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 	if (irq =3D=3D -EPROBE_DEFER)
 		return irq;
 	if (irq >=3D 0)
-		ret =3D devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC =
1s", rtc);
+		ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rt=
c);
=20
 	if (irq < 0 || ret) {
 		set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
 		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
-		dev_warn(&pdev->dev, "RTC pps interrupt not available. Alarm has only mi=
nute accuracy\n");
+		dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute ac=
curacy\n");
 	}
=20
 	return devm_rtc_register_device(rtc->rtcdev);
--=20
2.43.0

