Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5733.1794388767862141452
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tS/hFML0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzKPpKS8XJMiQdu142IO4CTOsDf19iQFyfy4boiwo0qN5+Ba7Y7rnGTzU5LOyaSgru9+yBbHocBZIELDcCMGBKQH1vXIjcvWqcwZ7wXbe4uMXFo6oCUzfHDXjtwuVzdLL8FjIQBX8w0qJ791NxM2O7ugD1H0yZJE1/HGMG1JhsOmaUOCKZjpZvwWCf2HCm4W4uFanh4//e8EsOnWjLXapn5qu3VNFHcqz4mb9gG3AfOJbvr29vhqEp8u7ev62eaO33Sw3E4AOWhe5uc90LynBm9MCIJ9d+cAyyCvN0G30rU++d+qxoZtHj0UMqhAY+Z2dePg7v8/K0P/qJUbZhHFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR6z504n1cZH8M1Koa/Z6cPrQNnXWsszaJVtIdAv3Vc=;
 b=LLSvRPjrlMwigUyi9ycSeG3VeuJU2I/uq3DaCAF9TGxcLBeljdctWphhIHiIEzcQ4sx0w6Bct/WXgV+RTtd8EvHvtZ4BkKTk2W2hWR9fk16oJ2cehKaxbEMa4M5xuTWCK04sbbOkTf/pVHZ8rubiIY76bvVTPRv6XAF4vJ937PwP8S5iTGYnfKhC6GGyo+qK17tISuBXPuKqReudvNJiRT+JuwO6J6lkHRSDIpjoBUPoN7uSyujyBYJAHbJypZi11YmOqx8mGLNv+cMr1T3Gs/BYBSKVOGqicos96UwkURx19UY1WYrRZWtH6NPHSoiXdy9/i/a47jl2tCJEn0cZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6z504n1cZH8M1Koa/Z6cPrQNnXWsszaJVtIdAv3Vc=;
 b=tS/hFML04O58GkzitbiIEwMGQGgh57sO2LZp1SC1eoRYuhWzbYI2FWH/MSL/izd6K11ZSVZ4pJLf5KVEanV9arIKibTqsWH/ehV26XqWtu4PdpQr0A8i5oF0wZLRWjVhw2RS3QPmyFhKVTyO1s7gbJASAZi3axcxMfpuXGqUHl8=
Received: from TY4PR01CA0074.jpnprd01.prod.outlook.com (2603:1096:405:36c::18)
 by OS3PR01MB8636.jpnprd01.prod.outlook.com (2603:1096:604:19a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:23 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36c:cafe::65) by TY4PR01CA0074.outlook.office365.com
 (2603:1096:405:36c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:23 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 1C5A13001DE8;
	Wed, 11 Nov 2026 18:19:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/21] rtc: rzn1: Dynamically calculate synchronization delay based on clock rate
Date: Wed, 11 Nov 2026 09:18:51 +0000
Message-ID: <20261111091901.41995-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OS3PR01MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 327f3085-2212-49ad-b22a-08df3fd4e010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 64TDj5KCC4HXTiQyoYBpPgmk31ClD1AcaUDpDU1jtxYhA4JS0n3e9jg3FYfDfIG1IWWXxI1JQDvJSXmdWmYKyNpeH9a9Ud+JrMEpU/fup/NuOCh+0D9KnzYVA5shdlAXf6XdV6+lv/ilJfjhbNfsPHDyr8CKPmCaszoMflIJyHXgjNDbbZiDn0lkV3xV5B3xa4bse+//8sf+4oOpRPX+yubcJqcG3dRODo2Ntc3ksgCdPn6njVD4Pbs24oWWAzhMzDC+GgK3J3Tahix7ToaoUo5h0gTBInbnldmyqE76Q9Kh1jAhMiK6pMnwbrJdMryIaRApnRudSWZnBBUgCeyx5UMZ/8wqOs73WulsAAQI8vMxccCfhKkWLDC7BsefWq+Bg8HUMWuasSF3fx98W+uoW92FuJGJUdgwQCw/obcLZ6lkHEc9+9/PZT8644Av3VRC+kGhm1ohzfTfKRFkZneOxUUSTIqG5t21GwB5WvuqJu44ab/QRlG1/BciQDEL24UTDNZu6MiLzjuKt+aSL3PLNhD1ZBmfY6bfg+7re9PrmgNSwGIa/QQevPzBTiy2BdrMQiVUv5MCTIHsmz1S9+3UG6OBzwvqYtU6umXX5hK6PyQwZPRButJPIasbZroAEWtTvlFAX7ao43JbpP8a9wpHx2WnxjcCcgQPzQv24E0PoF0=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EmBpBMlzLWLCx4MYUcvk9E2gWiIKNNr2oLu8Z13bFpItuXtKnK9/0UmkU8nadpvFt+TcgHpZp9dhohRKy/J7aBK49OQVfzI3V/aFCpK5TldkpM3Wj++4asQ+rUXW3yeIt6ZnztsfqN+yZixRsC+/NNclXQn75M7s3N2ljY9Yxa3t9F13mkVMT3eA2B136Qj2CQUucbpJwfyKQPRQo15f8Lisd/A55nCGiEpPMpUUo99EbIP0ATsiZyq9nX9+txJss/Sved6aBSwGAjMn5FaFaci0Y/VqH2taPLvdQy0Nc7r47/gcBtl3WnNSiJiLWmj6cJRWZf7GSJS1DZP/TTN6gUTM0QqSamc9tuEWHZ5tLf+LCZPf3vM7dpnaY4R1YrYO4jB0yIFHTikWxv2HP1Qe/LNP1dAonI8UaSR4lFX8VlvCpsNoqRjVqfzvAjltaar/
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:23.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327f3085-2212-49ad-b22a-08df3fd4e010
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8636
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24752
Content-Type: text/plain; charset="utf-8"

commit afb8972b9e36cd519bc30fb63081fe9ae96adec2 upstream.

Replace the hardcoded hardware synchronization delays with a calculated
time window derived from the operating sub-clock frequency.

The driver currently hardcodes microsecond ranges assuming a fixed
sub-clock frequency of 32.768 kHz. Newer SoC variants, such as the
RZ/T2H, drive this hardware block using a much faster clock rate
(~195.3 kHz). Hardcoding these wait windows forces faster blocks to
over-sleep, introducing unnecessary delays during clock initialization
and register configuration.

Calculate the duration of the required clock cycles in microseconds based
on the runtime clock rate, and store this value in the driver private
structure to adjust the usleep_range() and readl_poll_timeout() boundaries
dynamically.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-12-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index fdf603ab4f246..001ce0cc2d550 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -70,6 +70,7 @@ struct rzn1_rtc {
 	 */
 	spinlock_t ctl1_access_lock;
 	struct rtc_time tm_alarm;
+	unsigned long sync_time;
 };
=20
 static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *rtc, struct rtc_ti=
me *tm)
@@ -120,8 +121,8 @@ static int rzn1_rtc_set_time(struct device *dev, struct=
 rtc_time *tm)
 		/* Hold the counter if it was counting up */
 		writel(RZN1_RTC_CTL2_WAIT, rtc->base + RZN1_RTC_CTL2);
=20
-		/* Wait for the counter to stop: two 32k clock cycles */
-		usleep_range(61, 100);
+		/* Wait 2-4 RTC_PCLK clock cycles for the counter to stop */
+		usleep_range(rtc->sync_time, rtc->sync_time * 2);
 		ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, val,
 					 val & RZN1_RTC_CTL2_WST, 0, 100);
 		if (ret)
@@ -398,10 +399,10 @@ static void rzn1_rtc_disable_hardware(void *data)
=20
 static int rzn1_rtc_probe(struct platform_device *pdev)
 {
+	unsigned long rate =3D 32768;
 	struct rzn1_rtc *rtc;
 	u32 val, scmp_val =3D 0;
 	struct clk *xtal;
-	unsigned long rate;
 	int irq, ret;
=20
 	rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
@@ -451,12 +452,16 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
 			scmp_val =3D RZN1_RTC_CTL0_SLSB_SCMP;
 	}
=20
+	/* Calculate the duration of two RTC_PCLK clock cycles */
+	rtc->sync_time =3D DIV_ROUND_UP(2 * USEC_PER_SEC, rate);
+
 	/* Disable controller during SUBU/SCMP setup */
 	val =3D readl(rtc->base + RZN1_RTC_CTL0) & ~RZN1_RTC_CTL0_CE;
 	writel(val, rtc->base + RZN1_RTC_CTL0);
-	/* Wait 2-4 32k clock cycles for the disabled controller */
+	/* Wait 2-4 RTC_PCLK clock cycles for the disabled controller to stop */
 	ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL0, val,
-				 !(val & RZN1_RTC_CTL0_CEST), 62, 123);
+				 !(val & RZN1_RTC_CTL0_CEST), rtc->sync_time,
+				 rtc->sync_time * 2);
 	if (ret)
 		return ret;
=20
--=20
2.43.0

