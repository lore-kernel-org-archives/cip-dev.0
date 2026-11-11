Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5797.1794388777214006596
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:37 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GjKtA3af;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoIFB3wNIKuMX7i+dPRwv522mxiNLAsyEpKQbGehrW/tRwePCNQk54k1YXtnCDaLNdaRyZ/4BRWvByuXzNqP5hnclZzsuVv+y3fwdTtxCWSvwT2d8D097M8dub0fq5w4UzF2p818J/LE7iJKJI2LHbNWBkKBtHWttKq+JBSo0nxR0Sa+a+4I1CCOjJycyX5rGMjCHgB6AxyHNC8fQLFSaW6y1fdp5dvBbJPDJbFuo65EZYNqv0+Y+izVdLn4Y/O4lG/b7GsxYMELOvuyiZUjQPKsvGMojNEDVld1HtNC7Q14wamqO/t7fKsbvLoHjZ7UMphVI62zXmxuq83sBOurrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2BlkI70TMizcvOgIAXlTOSgs353oyNSrpjU+sKEAnM=;
 b=Jf/cMLQTuEulIp3qhrDZDO1btUUQzeXsyZG2CLhZClPwDTBWRPg+na68wPCHPHA/qVAMQaDgNh9j5w+N8g7n1PJnVdcfz8NFiPNM5CB9lLtpWJCMjmqCE8hb9M3j5R5n66fylnhCegnLT6QWeWN+AV1yyoeFLHJnVg5asFem0C9uOE99ex1/u+jkCDb2Y2V0qTmb/bF69zU6uyUbYF3NlQqXufnvOeY/N1aY8g9cHJyBM0mgjDKG97MOsrbHtvnK05Yure94TadlmpJu04vT1LCb5T8ZXoiOGwyyzDF/SGQDyQxVqWD616SUkR9K08/PATlyJ/poCL2aMvJe0iI3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2BlkI70TMizcvOgIAXlTOSgs353oyNSrpjU+sKEAnM=;
 b=GjKtA3afUJ86B3MwHPc2J8UdEAXAXpfgeQwjfCuOYl72Vp1T1x7x0ur9/En1nJGNs5fBZKF1NNGcFvasIfI5WH+0ZLOo5GcBoJscGHr02my6DKvF2nl81LM9zgG+LnZLRI0Rw9FY8SHwoXFXpjl+qbv/kpvAM/fVRK3dcKBlpFU=
Received: from OS3P286CA0049.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:200::6)
 by OS9PR01MB14027.jpnprd01.prod.outlook.com (2603:1096:604:360::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:31 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:200:cafe::5) by OS3P286CA0049.outlook.office365.com
 (2603:1096:604:200::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 09:19:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:31 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 681A03019A07;
	Wed, 11 Nov 2026 18:19:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/21] rtc: rzn1: Drop trailing comma from OF match table sentinel
Date: Wed, 11 Nov 2026 09:18:56 +0000
Message-ID: <20261111091901.41995-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OS9PR01MB14027:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c0a570-6755-41dc-62f2-08df3fd4e506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: VtkOcJdwM+5vZh9B9yV7h11LL5pYYUrlzae17JCjiKmCGXYjlPGa6PdfEYYZDZs20dkS8z89bE+Z3vxNJSxUZ8JfnVAC29/Ajv+QMAViJmitqTNqqSh8ZhcaK8gQb/anW5gnYBrigyEHoOjlJpki/r5V3toKwvqmBKRkLcRe5RCFpVsN+OapG+WP+WTL+HooANJc02vaqBKoXrAqSBtIHPam7fzRAK31hQQespanw/Wnd9gvOyN0U4fT48B8jFEMvZoOnNkmEMkuMUR6a7vQIu8UOcqsvXD36nxZwJrswkv3SB+h1SflGl2mG4CX49qsAYGbSpzOSiOnWaqEougJs7zBMqI/8IkdBpjd5VEKvNtdexFp1o3XB1RJakF9zOParf0aRyJsQXVHxl9DBaL/6HRf1N4afClghPIms1BS5N8Xhet+d8Rf1XjoSxosfjvqszo19GJQL9QSP0e5jNpIgCXS6QAQW23HVhEc2DQylITcmUyZi3QaQHOJn+VaVU+E8vla1FcT18D4oESkom5Q4D15Ua3/sq3j+X2da5UmmC28DJ5IGeF+Y7KpoYUn/s43bRsIK4eQHLV+0LEUlijPfQ9nO/EScVTm4gA24b9z+lwiALqX1674ox8KVVkqazVEIq5Co3agKc2pXSQplafrDA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uWoW3YSVPCqklT8u/qtCWDWR/eKpdKhez9oLguHv8EHbhTOq7f7lKp7FI6PEsHS3Y4zFu0VCmb06OHopekkTpHd/reAru7gWCRZy4WfVN1Yfh3BZziAi80qm7Px1nZIdFa+SPS/dhAFRg+XzgLsnxMXjKRkd1b+ex6WcP75HW7VvUNeb6T4ELr5lTfL10Qp0Y59tS5fPITu6gxsKBZ6hj1jci2LJsZIDfTRRqDylv0TVQvFj9y2v2bQtvHofy8RIYapirS2diHsLD9LQ6lNIEwwbqy249bs3IelgpSmbiM14AuBTOi8zaO2GnXYqFGxabLfx6uVYEOdrmiH4azPKZAdyCbdvUITmkAFjstFeMfgyyBZNcI/ppesHCcgPNV5vp+MxqXjRW/UCIOxj8HzXlJzHXjPvlfbbOKjiCga/OgfqBEVUD1JsNJg1DqEEvV/d
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:31.7270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0a570-6755-41dc-62f2-08df3fd4e506
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14027
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24757
Content-Type: text/plain; charset="utf-8"

commit 8af6331c6e7aaec3453b8a158bedb44b271314d7 upstream.

Drop the trailing comma from the final empty entry in the RZN1 RTC OF
match table and mark it explicitly as the sentinel.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-17-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-rzn1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 49014e7f5ff50..be872315b3f8e 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -529,7 +529,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =
=3D {
=20
 static const struct of_device_id rzn1_rtc_of_match[] =3D {
 	{ .compatible	=3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_data },
-	{},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);
=20
--=20
2.43.0

