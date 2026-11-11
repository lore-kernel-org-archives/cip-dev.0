Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5726.1794388750814853270
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bGeCVpWs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.38, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeSKWGvwmLOD/cXavTkexmRox+XYw/mJ6/kHLC7baPdq8II8CSoj1hARaFYMvZZC+zRt9+f79PdTDqWWDApvLsugAYxfMBtOfR4j7a1KYJ2bpFPrfcM+soZtqnqelFj5G0ug5ps2wjyQ9QGsOC0B7Y72CiL2CmDTZDMCFnlL+obLCCuUbU0QzDgUqoIgACF2ZuxQDKsOxvaX7a50P2GiqrBc0qMJt2aZGThGIXpjBHvCCR2UsreBD85n3to6p9Q3UmCZogGzayppgFv4EDlCX3D02B0VbWniksVxbteBaXVgMNbf7XsNHW/nnXefuPTSTv1/fT2Bqm7yhLWPzFfwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYRHwvGFin9IEQAqa5A5XbASPOOdxMnAkigNcpko/7E=;
 b=WpGy6kuOhIfeO8ChTULXy1Wl0phEEBt63sXCzXQS4qoxxCkCno2lQMjXYXVv9jTmNTDvmvrb4ZJK4Y4H8/zv0RtuBZBnk0ZBtDx3rWd1UCeypkI1mUT6BJoGY+UuFiUoRs26BnBEs2dtcHY3VNpTpLTNRAWeca3diT0tG1XAKIszNTHaLZiJx16Mv/oNmNaEk+r4uoe8fgeJGSJBjpwYsyljcjTBK7wC0Ycj6JWFrOeq1aib0Fx/k4grJf4unWXCI98refwkgl/AMnYIGauU291vM6E79RT4tO3pflg4JeCekp1zHsrH/W5Wtg4IVBYMX5t4wt+d/3LfvOsdyIigHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYRHwvGFin9IEQAqa5A5XbASPOOdxMnAkigNcpko/7E=;
 b=bGeCVpWsLp1cAgYIQH61BDm+z8svi0v29gqLQoEhV61eolbIZuwvdg7pxQ8oM6+ETO1vORlmnZA8ZAcGqf9ozu1Z0muw1rECVFjaQD5DMinFoCxejPm4s3E0/zqH+9GzX55IJX7deQzfQqPE0RCVR95+jLu0QgUyvBLbcK2GDlo=
Received: from TYCP286CA0164.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:383::16)
 by OS7PR01MB12047.jpnprd01.prod.outlook.com (2603:1096:604:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:05 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383:cafe::32) by TYCP286CA0164.outlook.office365.com
 (2603:1096:400:383::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:05 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id CE0BB3001DE8;
	Wed, 11 Nov 2026 18:19:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/21] rtc: rzn1: drop superfluous wday calculation
Date: Wed, 11 Nov 2026 09:18:40 +0000
Message-ID: <20261111091901.41995-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|OS7PR01MB12047:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a0a46da-b93d-45f5-1bcb-08df3fd4d52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|261009223027099003|13003099007|56012099006|11063799006|261021123027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: EFjtU1kmDXZNpY38EB0abUBKL5vMHkcz1MOtegJvSTnrC14d6M7t9AFeQ/SwzfN8Sulj+yJ20TXzbEsU5q4niH+mgPT47iR35isTNJ1jr4XWbUDCmufh2iWYTjP3+lU74Pmxe3VbaeGdGh2e73BzZCKz+wTlcjpkQYOh9KXXomTgC9xOIxYrS3Jxi9OLT1rFxVU8FFjkdN6SOZ5CNMjlcBAnmKR5RMdedM4XQRQYTozLVjVIOubKaAZr49R3mcYBi/PcwpPDFVa+bnlc5WL47sZ9ZnNUpGjms+gNs+WGBAnU2J/ncBoCYwdydoWxYFzHFtPOTQaWF5KbbQPJDJHHU8oCBZgxHSCDR+6m/dW52BCuoRvvD0EqtmRO7L7HsTLrqAmEmuAKflEH79lPYViBc1EGAOhUn0m49BkoaLDgQj4HYcu3Rz3SraNX0bqz27LR4BUY3ujtjEq5nJgRiphGEVGpPYpo/x5R3b6rEizBC56JUn2s8MhxYXm/Y7eug7f+xcCbM3V9bXDxrwCGlVEbQFG2xn2FM2u+zKjD8GCw5lvqwClefVb5G5XQUgXeih6FaVtvHSMrDKjoFgBV0LjFCIzQWmA5fhys9drrAWEc7A5ot46c2FoCo9GUHAhpDcy9CVJ8Y2pCWibPPRpTnNYPnStm2Cdl7SAh7DLF1c/ndT4=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(13003099007)(56012099006)(11063799006)(261021123027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uyKimj4kqPO9ORhlChc+UAoiCeHahskbRxQsg4VJ0uWwqAzf8QJDSltyraXXQpHqnhe7H2JWqz1gSKhMLh5s1eKy8KJHrpusucE0mo7h7BArbJ9HPy/vw+b9Vm2GgDpvWNX3c1+0WxsflQPULQH42zKHsw+7yPjpyikFmCfAPwUw9bOAiM+ksw6cK+CEA2u4pOhGrra+915RLljLDss82PgZcnNgbqzzDQ0abFA74QZN/VnXVvDRPLM5pAnT4EaICLawIHA35y1oG4BMtJbrvgs0/3hqR3CqlUQMavqXjo747FPOpC8lMp+oXXcPT4Z/IkZRpwbEXCR2ykgqjNFX5Xdm+vxvEjKgsEYSDrKENQi1OQcaHVzHAJdM523LRN6laQjB9doM1bF98RKQ6v64sr8bpiZR2LG2CoFKuM7g++NmrR7R2iYyHveiQzb2N2NC
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:05.1315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0a46da-b93d-45f5-1bcb-08df3fd4d52a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24742
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 692f983b2dc933f9c4f6255dc0a5f3df42110a2a upstream.

The week register simply counts from 0 to 6 where the numbers do not
even represent a specific weekday. So we can adopt 'tm_wday' numbering
of the RTC core without converting it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241122101448.4374-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index bdc041e9498a2..bdd4ec02a7672 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -75,19 +75,6 @@ static void rzn1_rtc_get_time_snapshot(struct rzn1_rtc *=
rtc, struct rtc_time *tm
 	tm->tm_year =3D readl(rtc->base + RZN1_RTC_YEARC);
 }
=20
-static unsigned int rzn1_rtc_tm_to_wday(struct rtc_time *tm)
-{
-	time64_t time;
-	unsigned int days;
-	u32 secs;
-
-	time =3D rtc_tm_to_time64(tm);
-	days =3D div_s64_rem(time, 86400, &secs);
-
-	/* day of the week, 1970-01-01 was a Thursday */
-	return (days + 4) % 7;
-}
-
 static int rzn1_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
@@ -109,7 +96,6 @@ static int rzn1_rtc_read_time(struct device *dev, struct=
 rtc_time *tm)
 	tm->tm_sec =3D bcd2bin(tm->tm_sec);
 	tm->tm_min =3D bcd2bin(tm->tm_min);
 	tm->tm_hour =3D bcd2bin(tm->tm_hour);
-	tm->tm_wday =3D bcd2bin(tm->tm_wday);
 	tm->tm_mday =3D bcd2bin(tm->tm_mday);
 	tm->tm_mon =3D bcd2bin(tm->tm_mon) - 1;
 	tm->tm_year =3D bcd2bin(tm->tm_year) + 100;
@@ -126,7 +112,6 @@ static int rzn1_rtc_set_time(struct device *dev, struct=
 rtc_time *tm)
 	tm->tm_sec =3D bin2bcd(tm->tm_sec);
 	tm->tm_min =3D bin2bcd(tm->tm_min);
 	tm->tm_hour =3D bin2bcd(tm->tm_hour);
-	tm->tm_wday =3D bin2bcd(rzn1_rtc_tm_to_wday(tm));
 	tm->tm_mday =3D bin2bcd(tm->tm_mday);
 	tm->tm_mon =3D bin2bcd(tm->tm_mon + 1);
 	tm->tm_year =3D bin2bcd(tm->tm_year - 100);
--=20
2.43.0

