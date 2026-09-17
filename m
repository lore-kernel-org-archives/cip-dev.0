Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75EC982D3
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35091.1789636456662088575
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QkL7M4th;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoviD4AZu6siWB9UQ0C+b9XjBRtsG8xJ3tu2BDwt4DRLRh7nFH2DxjHo81Aq64PoMQevQjpJh1ee3wmvS2lP+YUrs0EwVNb7GSeyUaUGULeiv2TRRdJ6pnsmLofRrKlul3d4hVekq4J3c7zzcyuNnGfuOGSpiugsNLDsvL3IbsWa1Ce2G8tgcyqcaMp8iDx1ppgyrwx0EPAr98Y6D8Uc9ysUw5v4JzozdeA2pidNZdR1mTGdnS7yJXoeO8UonU9NY4YlqFoRNMh4kWQWNg2wLVJ1M3RhrD6268NennDZqG3Y9THcIsMTSsFtijMhYIXK5iUngnmdntgt3mCzcRHqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azSaHglec+0EIFTa4zgPzlIZoIowvXeK1xv+ROx0x9k=;
 b=jE1Ef8XDGeMjQgKOxvE48LjFpb6Ql4KJqvchUxYk7pLQbI0DVrnWVoTeMdl9bok6HpvXCE0LfY1bU6yim1cIPCi0riodfL0voPF91G1aZ8TkSc2u8NZcgNrFedmTjF8OB9WgBVVobV/mZDfdq9Or7nUCdzhxHOQhMG3B97DBcaOJxGQmpa3nAeDFdB3cim9q+P3/pYPfb0mBDKsz2J0nNKsO3VkRaLcuS4CsMLKvHR2V+Jc7dDNLV+PwO8RNfuetaULqNmNXKqVGC2g2f6pdRXEFCZu/Uw2hqiyMKUZ88wrN2O8nL9CR33xX60fy+pNbUugSvtMKo41hOL8THyBbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azSaHglec+0EIFTa4zgPzlIZoIowvXeK1xv+ROx0x9k=;
 b=QkL7M4thDs6A9Exo4qyTYNPaGErSKyR9bS1Fp02rwS/YE/smhLuZicDGHj9PzCr7y5bwaZAsivnGh4cc87cVow8HkYbCybfofnVZAJ3Vcyk2GEAQpaZ+1T+iCwBjxjA+3pvhP+dOSEhuHl59TeRoglhX4yjiMrxuXVfmMWQmZfc=
Received: from OS3P301CA0026.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21f::10)
 by OS7PR01MB18247.jpnprd01.prod.outlook.com (2603:1096:604:4bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:14:11 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21f:cafe::83) by OS3P301CA0026.outlook.office365.com
 (2603:1096:604:21f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:11 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C6A9430001E3;
	Thu, 17 Sep 2026 18:14:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/10] rtc: renesas-rtca3: Factor out year decoding helper
Date: Thu, 17 Sep 2026 10:13:54 +0100
Message-ID: <20260917091359.18445-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OS7PR01MB18247:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 453efb98-f51b-4d62-9ae7-08df149c0944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|18002099003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	L/tCEt73Yliuobql6VZm79OpL6d2c5Qa2wLYq2RXc1j/aEdwoU9f+SMlxJb2vt8glw/xgrtY2QoNVc+l5Nagbh9EOUyaQC4s7yLevFVY9UK86qZn1MKeKybrHN3CqRbO7rZ5QU2i+a4ShBq+tuY2Wuhjg8weK8l8UAFmiJXZSpCmVJ+cjlKu0zhaZslcVWB8vpGULmRpc026InJIkj0qP1rpkm4yM8BrnXbxl5LUn79DkmsSOz482Axn7FDR2pUhJvsc2vktRaUY0XBNtKoe9wErwmD5rQovi9ks6Ysr7ilpeINXpioGXQmTbNTf47VoD6BSEBjzerd0lRm4lWJgetPtB4GBo/YG6d8Y0NM1HJULoilaNgx2g3MR4JT6r6JwvMwN9a/MBY5V6SdKwtNp9UHNLEb/q4a/ZeD7H0KzwLZjwhC/uGaBSe8wYwYfkw8+7DPgxx/6mw6PUB2uNOuHWjDvewze866SvvTdk/2kepau9PfcASLsdED6kx6wrf7a9YvLOjKtomxBg9zWD3U0E8l6gwj+MYorYVT1vu4nF9xEcRnFZtvxVtb2F45T+c+4zfP8/kUGlrl1hYspCRjg2mtNKOCtka8TxL7whjDwY4ikm46UJ8pHK8GCaFGHki77GHdYyOoiAsAOAODD9YagYrldom/UUW2Xwor+KjmK50g=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	B1uGqyRk0uFHrLc3rmI8wtWxcFDO4VUGRL/w2y6srFMTpWxFyhWrdwsT+4Jv6cvIMjuqSQpWzHQRxnBJU/8YWYEVjK/c0IHCJM4IvmaiSIbh9ctMdG7cEOfmcC2o639itjDNv5VInid8nuf4wRqMIj4k/1FBJzG+ah1jd9V/yjpZGmQfHtfNfQKD3j6hwHXrTx+Q+dqa5dqQy9ecRULdacZ0OFa2iVz2v3EdWKUGojStHRSsycZEIx8LgI8ymcUIS9rc76xugO5KAOeybnhga4h9HocrRD/cDg1z9l2ejqzcdnuLraUb0kDpuWeXFPgGsSI7g2JSRjiqAFoZt+thAA32GmwoLebYSyE4Pg0sbRyC0aWFAy3OAOOAHdO6sUaDC3DuTGhPVQUfHsSqZ+AhbJtZhiGZ4qEchfNIu+0q3RAox6CAY24algY/mbcVj48R
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:11.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453efb98-f51b-4d62-9ae7-08df149c0944
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18247
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24202

commit 2098bb8ac5f5a66b1a0e02512ae11b6208936c92 upstream.

The logic to decode the year value from the hardware registers is
duplicated in both rtca3_read_time() and rtca3_read_alarm().

Introduce a helper rtca3_decode_year() to centralize this conversion.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index 9ce28af388c96..66da5451eeba0 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -228,12 +228,19 @@ static void rtca3_prepare_cntalrm_regs_for_read(struc=
t rtca3_priv *priv, bool cn
 	}
 }
=20
+static u32 rtca3_decode_year(u8 mask, u16 year)
+{
+	u8 y =3D FIELD_GET(mask, year);
+	u32 century =3D bcd2bin((y =3D=3D 0x99) ? 0x19 : 0x20);
+
+	return (century * 100 + bcd2bin(y)) - 1900;
+}
+
 static int rtca3_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct rtca3_priv *priv =3D dev_get_drvdata(dev);
 	u8 sec, min, hour, wday, mday, month, tmp;
 	u8 trials =3D 0;
-	u32 year100;
 	u16 year;
=20
 	guard(spinlock_irqsave)(&priv->lock);
@@ -274,9 +281,7 @@ static int rtca3_read_time(struct device *dev, struct r=
tc_time *tm)
 	tm->tm_wday =3D bcd2bin(FIELD_GET(RTCA3_RWKCNT_WK, wday));
 	tm->tm_mday =3D bcd2bin(FIELD_GET(RTCA3_RDAYCNT_DAY, mday));
 	tm->tm_mon =3D bcd2bin(FIELD_GET(RTCA3_RMONCNT_MONTH, month)) - 1;
-	year =3D FIELD_GET(RTCA3_RYRCNT_YEAR, year);
-	year100 =3D bcd2bin((year =3D=3D 0x99) ? 0x19 : 0x20);
-	tm->tm_year =3D (year100 * 100 + bcd2bin(year)) - 1900;
+	tm->tm_year =3D rtca3_decode_year(RTCA3_RYRCNT_YEAR, year);
=20
 	return 0;
 }
@@ -354,7 +359,6 @@ static int rtca3_read_alarm(struct device *dev, struct =
rtc_wkalrm *wkalrm)
 	struct rtca3_priv *priv =3D dev_get_drvdata(dev);
 	u8 sec, min, hour, wday, mday, month;
 	struct rtc_time *tm =3D &wkalrm->time;
-	u32 year100;
 	u16 year;
=20
 	guard(spinlock_irqsave)(&priv->lock);
@@ -373,9 +377,7 @@ static int rtca3_read_alarm(struct device *dev, struct =
rtc_wkalrm *wkalrm)
 	tm->tm_wday =3D bcd2bin(FIELD_GET(RTCA3_RWKAR_DAYW, wday));
 	tm->tm_mday =3D bcd2bin(FIELD_GET(RTCA3_RDAYAR_DATE, mday));
 	tm->tm_mon =3D bcd2bin(FIELD_GET(RTCA3_RMONAR_MON, month)) - 1;
-	year =3D FIELD_GET(RTCA3_RYRAR_YR, year);
-	year100 =3D bcd2bin((year =3D=3D 0x99) ? 0x19 : 0x20);
-	tm->tm_year =3D (year100 * 100 + bcd2bin(year)) - 1900;
+	tm->tm_year =3D rtca3_decode_year(RTCA3_RYRAR_YR, year);
=20
 	wkalrm->enabled =3D !!(readb(priv->base + RTCA3_RCR1) & RTCA3_RCR1_AIE);
=20
--=20
2.43.0


