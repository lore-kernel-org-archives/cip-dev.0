Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E100C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35129.1789636596846742056
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=bW4c6Lel;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LekUVTDi9wesK/Jc7s5N7GYigLcRvVJsGec/48RPYLSl5voZT3/df3w/yntwW3uFSuTWWq5dXkDkz+hOIcGi50JXspoWmjUpz/+W2cGHdIdZXNQF6neIjNDMhYBA/x6w4CVLbyuEym6dNA7eS6uL90d6QYUp9nXogNcf1GKiSt9hHqbkziIMLC7kXknsSzXlX1apqOKeHf8j/zBGeyx7fTqtQPX8UhfM85zt8ZI9YTotskKq+4qevclBenMN29lVWK6nZUxjtghwx7qN9wLFdeaQuuPQmJMRdf81jz19hy/SsTSG/YPwcq470MkF7XWVF4o6OPX2FcI0oKXS3lpSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QGisEe2M3tG8rESeBfoufMuaaR2PvWxW56VYaB9vis=;
 b=RKT6e+4tlw8fmDHk2VuW6A0Yu1xtJOjWlJT3Araah9Y3Tjo0yH/aTWwHTNFJh/8mL7wmIGvYeQss7A5UtB7zP1W7Y1mfOjaz+G89NDKFddUJpqjgjIqVUFe6+wZ33J7jd8ZRaip8rE1AY+Py5z9zNBgZdnND0ZLwRz9Oi02Xkme2l3gbvsALgycfYVfI/NQYqgZvADZ1E59Ip4BDj3aT4jp6vddlHf8PnJeI3pVN3Kzq5hhRMD4QSppa/rryhnzGTGh7wDMus7nQDuqgoksi65DXZF1ko6uNzjukqWQP0tey1aqwmvu+yuDZeSGFD+VYC/EAzgaMyDthi9TW6VWTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QGisEe2M3tG8rESeBfoufMuaaR2PvWxW56VYaB9vis=;
 b=bW4c6LelhElDkLPOBef6w6JZ1qUMLkq0TtOwgSuhV556dbss9/bBZqf8lb/a7XfeVXjNWUNdJidar06RbAwl460CwEhSyaLwdhVKWj/jCn3asgpCAY+/F2/4AAxuPenheeZ2k/oYKqoJ7LzQrDqerULltxKhrYr/BT6kMoJU7+A=
Received: from TP0P295CA0027.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::14) by
 TYYPR01MB13215.jpnprd01.prod.outlook.com (2603:1096:405:166::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:33 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:910:5:cafe::77) by TP0P295CA0027.outlook.office365.com
 (2603:1096:910:5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:32 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 73E5430007C1;
	Thu, 17 Sep 2026 18:16:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/10] rtc: renesas-rtca3: Factor out year decoding helper
Date: Thu, 17 Sep 2026 10:16:16 +0100
Message-ID: <20260917091621.18551-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYYPR01MB13215:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 34f13b59-4da9-4aad-1cd3-08df149c5da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	4k20xXdHqoONnLaqS4GxtirBnm8GFl+1Qq4aM+LhbEd2xsR1K6wFjkmKlx03PbgI+Qzs9RWRJW0KWr+UhBjEyAb1ASPUCyHPcg1i9sd+X5w+jB/1z6FDm4gwjAYmmVztmopAmPv+TWFq7ZaA1W3vcDkGbg1nGZS+popqFBGbbocRUh26jsmhPD5q2xWUzqBBll/fv270h6jcpL+RkUwlrhf1d9zVTBvsNCJw5FooJl8JvMM1NL7+xweF1C3rglEqWg0iUC5tBxlp5envi2qARrb1EHsivyaK81zyZ6voVBUvXFre+j8CNncRIzqwiENyACTKAB12LbPw4eVOOLErk58ub0fYACYHf+MH5QeTiQh2zfuSTWiO7nfejdPxeml1/M9p+zbFFBc7/U7gTw4AIWWhLCmics390xTvjPlBtY0hu4WFO3oaU7wnRnN00vHz7esUM7gCplWdiwFRiwl5vZMsdOMsjaNtkQauOgtVHTP6DiRO8mGa5W9itGyOfdEQK1dNhuaAPggWWaVEmm520AejUrJuQKk9bAbe05y15KBo5nF5eZ3xqd/jM3q1pXYSDv8rz4d4slNcT1axVbQh2oo9eUudYaKQTk92sOlx/kyHxGsZ6ilmI3zcO7O8BdRQEENHDBKsuKTPCU5J4CZez3FPwFJE33HgQs54yhQy9G8=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(13003099007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	j7MTNXy64KIQQdR7NP0UvC+IoXUF4wgp9yrNIAk11rFem15v8l+EecnuTAwwPqwlrrUiDVCinsuOfhks6pQFq7pMi8j647oYJ56xzDhhCkIsNovJK5Vxu4OFP9aluB2NPbd40ovlvRw56iK73ckYdeJLEpTjAA4CAr8WYh/gRDeKTqWFx0P0Nh+gPaWG3SVmxt/o4K9wtYH22HNoYz4oQSHDOuIHEOHzyW5Oa9dGZ2I/O0RrHZ4ZonSiNEm7OVoxGtis31PdTIF+XG13B6xJ2wzV41scBPVmCblrWfu0co69ZBWwsso57KbLKb+0fJu10E8DV/yTjmAlE/oImPvMKpf0M/4LMLlU3X8Z6ErOfgQ5OFp1oP5a4CUra97nMsuHJMNI3rLHyVuLSQ8l1izpW6Ra2qAUb47l2AMFsYPEkwlAzZNSXA9EJiqGN6BW2rAF
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:32.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f13b59-4da9-4aad-1cd3-08df149c5da8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13215
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24212

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
index ea349dc1084b8..a968b759b6576 100644
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


