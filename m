Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB8C44521
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13281.1784294047217631671
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PIK+fPp0;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsEi2rTwMqNxnz2Hw5nIGFJPb0Os5SLNm5xfO21v5ByALSSZEdp+oz6NvhLVeHJhn3tFS6XCyqU/IhdgOuxCa2TVTyCkTwOnr+nAWGk3SlmHJtpPxGCJ3uUix1f4pprEJ4EDShoSA/dIH9wCS4sD3vYQZJ00+uMXPUhNEKGG6e3GBaHviGR2hI1BzkqIdDnPc0ZzTWBCmMqt2zSUJE/PpE8ePU2NhGZ/nbcAZAB4GhH33PV/eZeM0MBmZ4GUuLYoBBfA4f4BnbGJSHfPsCte2kc7w8Xrf7K+XKLUVnL5RJIpb00LSlJmhg60czNsFVaL9I94SpdAY0GN3g6+FD6Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNLzClwRAkq/ePXDzUoIhcOpnV5/6y5JqMnvdBFycIY=;
 b=gUwSCempFJZzJpnMSTFPpxKXaepRFWHcN49XTLhr+ZME3Db/LdlsUJiPud9GL88/G5f9V61HfPZlJVbkud2kDKsApAD25DRACxN62/LFOmQP3v4repzOT8D8QNWr5fQjM6Y+qkvmz+rtKFAKZp2EuFeeXSwnk7CGMpcIDPSHa1KYJbeTfdx5A2LBkdI30yDcLAGpmj32IHoK1qcg8B0HhebQZU+CbqbKXlc6M6FyfIgWztZgM0ixmNKeHvKosCem/krcxA4ZbW2Ii1IwvkVXu3gDW32KSjDhv5LLE6HUVCTISRWtr97uo1yQ4aPsj2hn9biRxrn5tq+tDJ7a1XScsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNLzClwRAkq/ePXDzUoIhcOpnV5/6y5JqMnvdBFycIY=;
 b=PIK+fPp0rixyIljjXerc2wvXcS5iJdhh4VnYFR6FkcUdXucEBm/9kEYH7MK1ds7eObBt6Hpwmahu3OaL00X3R7g+KvxSiQrzASMcEaP6uQlDXYpB+yv8HlzWSmi2xEUQ59u+kqX/+niUqv9Ga/r2uAOlDpsfSOa4AFst5CUQfG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:03 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/23] hwmon: (lm75) Add NXP P3T1755 support
Date: Fri, 17 Jul 2026 15:12:34 +0200
Message-ID: <20260717131241.2233788-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fdda64-af4a-4696-b6d3-08dee40545a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	CaZg9SqxuAOC/fEb8zYoAPU6CSppbRi6N9DswFNsrCo5wtzLBGMyUuGGWuHQn4QHYJJa7L4isBlXzs9PG9Mpb5b8vE8YuvnalwixRLYhAPwCxtza4W3tyLvZYqC2LRA3wsfzxS9+dtDlR7nyeMG/yp6ssVuT3nhXui4lkVCmVTP014C/OuRcYEsTG5Xe2HxidcROl+Xi7+LPqU+bnj342e7hGw9GOX5pne1FTQSoKjR4Dnx8ZU29VaYfAhIBXWdsjdTP8apmzwVHwx73MNjivGOHHYQZV3JYSDIAlFrsP8pFYiHOgnwxbldO7KOwFT1m0OAxjCl+BDPeEk/FqU0GL2+q6FG8ENBGj0iR7CL0MvwsDzi0wUbg1cewFI65gZ9jBqhh51pkUwLDLweEllWF+WblmxjuEyso+WYLRtN17MU8Vzvm5ddJ1WuT+vUYWsyYVnzGNUNpIE/tdJy1QV65vxc5P+40N0xfI2Nb4KuJteYuyc+RMjVjAb1ef6foMBHztxAnHvfMvBWxaYmNxvYsVbqoZlVT7MSVn5B8DHWQVwrphoBenk984gW1rMBVWM6ilD0TPOQMluTzVBIpKx2qXwho9rbDDpkkemoLghBmak0fyhzCZcF67B9fn/rvWQpJ9DTZB2HHIL+Mdx9kNnIz0L6s0W5WWVWOMqnxKOionXNvwUJLbqY94sWYbzr6p1Q/BTTquxruBGH/MaM6sUeCPcMjkQGuqHpZhuJU/PNKTEI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BwIu2GcMqTFo6e7hBY4h4R3wHN5xd/uOIl1ctmWsDLHyz/6gwir00F6OXljs?=
 =?us-ascii?Q?AreZg2NRsZlxJAVXD76kbEElT+0nTMufTkZOoIY0wtcjGOqtAJBQSV0crzd+?=
 =?us-ascii?Q?Lc8y3+rM9RbGMvFDy1Z12Fb3BPsn+iqwE2llWEdAiCyd0lM24ewBNo4DhJRn?=
 =?us-ascii?Q?zr7HyoEX5Qrc7hDqiGNP9hjc/NKR1SVNbOgkbSTcPhnfOK5ngDXP93T4Bko5?=
 =?us-ascii?Q?c1jwkvt3lfKQI/L0qUW6RKnpiLCeCtzQwM6Shv9O5aZHa8Q27AAUZZ6+aVlm?=
 =?us-ascii?Q?wkZQCLRtIfhmOnV6SABZqOqz5AV2UlaH/1Xt1e2ofgP5bJPBgr6NNkfo6GNz?=
 =?us-ascii?Q?BeP0m0nNGPk0u8A4meYwiWi+4x4jDnax4Ti55it0sIT2u6/bktHTeXIHFhg0?=
 =?us-ascii?Q?cVbovH8Uo1KgFJA87Kgj3x01sgnCP7vrDVJ9m9VC2mroFfs6t97OcRsBuo/h?=
 =?us-ascii?Q?wgIjq6x8TsAj6HyCrE1YfPYfO8LOePbNZ1G0AT3H/Va5dzVUp30/Bw+jC2d8?=
 =?us-ascii?Q?ka6PXzeAT0ohJS694hqZNuEh0b++YjOkL3Y4cT9DGWLWIfkEllbCpAtJQcp4?=
 =?us-ascii?Q?bOYfiR56p3+dddTSJtCsSy5bWNj8NuKuMUcAseRDr/h8FAmPzjrrNhHQkyds?=
 =?us-ascii?Q?8M205soCV+nUVQEtfrx3paE8fEUPh8xw0kdSfH2QHqUm0vJAwaNGQq4VwioA?=
 =?us-ascii?Q?IoidOS0aBmuYPRggTJAlDLclR9rV5J0B43CzTTs28OfQgx/JP7tZpPV4n0xM?=
 =?us-ascii?Q?PcR16kbIjpC+KZUGfUXFqsTDvNdXJbMe0mNb2Fx/0KWeDtJAMu69Kc/Qfg1C?=
 =?us-ascii?Q?pMYZ4cyhPka0URrYIDdlbPwDWOg2ZZAqGqnApOIazaAo5F1hM2LVhhFKIDZ2?=
 =?us-ascii?Q?vlA+TgmiSUYPx4FwBpVbQJqmvAivH2VuwOWAR5gI0TmV+iiMaC6MzOdN4lNg?=
 =?us-ascii?Q?hR57xCtZoih6ot7kYBq8bmHlKeqx6qQL6ePUBn1zCnV8GHMjtwmEPGByaaU3?=
 =?us-ascii?Q?iWnMqpBrTIREF1PNaJVXQCqJMPXrUW4AXMSUgjynYXuvB59mbNiQOKh1gYOk?=
 =?us-ascii?Q?ABMARxucirQPt1liGhqRXQnjRLzxROoV1MrRlg4S2FOIBFffPW/1F22++Mk3?=
 =?us-ascii?Q?wN+YmjhF/UZIeuie6G8+cdaIxCcJXud/HBtaGjkE7GWF4RziPmN5VBOv0oHT?=
 =?us-ascii?Q?YN9GUXlEeooubDegzYDDSlCdGg7t8ggvwoXEK1Qb4UH5DW1hmDJVKJRDK8vV?=
 =?us-ascii?Q?eJiZxAKLO4WWNiw+rrernJZT6qG2upN3Eln0gQaxq0VJKK3Uiy0vbRu+Uq7g?=
 =?us-ascii?Q?zHXz+sl4EaSCZy6adxHYpkB9Rcn/6c5dbPZnxQnapb4pukMK3DnqEN9alwPG?=
 =?us-ascii?Q?5YWcWztniwh8b7WE8bufmYsYUmfC+uOQtFhbGWGZUJs6V9539Kja6mIAs3hR?=
 =?us-ascii?Q?yafuJudj+a0qL6U8UaC6RcJFMoMj+246IPkkj4nG6a2eql26wegemfJ9NapB?=
 =?us-ascii?Q?o6tf0s/P+80MAx6HzigNLfrcM3N+hEdz6u1uCk85+Lz6BJH2TAnB4j7UDkkk?=
 =?us-ascii?Q?wkE0dJJ1W9K7D9lI4ybX6kRcoQ706mEZprHL/Dsy4uqgGqK1Pn8XZZvacBqB?=
 =?us-ascii?Q?rVtwwT2GBboBfltWL6fbPf4x422WiNXDTNkz76FpXIROENLoYeQePNYwThrr?=
 =?us-ascii?Q?MFa2sQKIe4zuVz1od0afR5GNyxcJu15Gx4PfWzCsbF9qV6eSCIRNeDr6NzR/?=
 =?us-ascii?Q?xNIzlowzMKURzx5Wnicjnds3NdprFGTBXW7zUfj/e9t4420bNXay?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fdda64-af4a-4696-b6d3-08dee40545a1
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:03.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKSF6QcCLJPPtnbDEo20g1V/lO5hZt350mpyBzwcsGkMlnuUv2Mx/Kk4kYokjNd0s2bjNxMRa8BSnx5U5BHtUGcaGZz/AGo3AFGXFRGfCtLK3fqF46To1JEKgOeQM7dR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23644

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d3506653d01c0df1f1c86cd49fe70c98f00f1aef upstream.

Add this LM75 compatible sensor which needs a separate entry because of
its default sampling time and SMBusAlert handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241218074131.4351-7-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/lm75.rst |  6 ++++--
 drivers/hwmon/lm75.c         | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 6adab608dd05..9877ddbbf7c8 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -121,9 +121,9 @@ Supported chips:
=20
          https://www.ti.com/product/TMP1075
=20
-  * NXP LM75B, PCT2075
+  * NXP LM75B, P3T1755, PCT2075
=20
-    Prefix: 'lm75b', 'pct2075'
+    Prefix: 'lm75b', 'p3t1755', 'pct2075'
=20
     Addresses scanned: none
=20
@@ -131,6 +131,8 @@ Supported chips:
=20
 	       https://www.nxp.com/documents/data_sheet/LM75B.pdf
=20
+               https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
+
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
=20
   * AMS OSRAM AS6200
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4f54a50f2c12..1d0040e3276f 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -39,6 +39,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	max6626,
 	max31725,
 	mcp980x,
+	p3t1755,
 	pct2075,
 	stds75,
 	stlm75,
@@ -223,6 +224,13 @@ static const struct lm75_params device_params[] =3D {
 		.default_resolution =3D 9,
 		.default_sample_time =3D MSEC_PER_SEC / 18,
 	},
+	[p3t1755] =3D {
+		.clr_mask =3D 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
+		.default_resolution =3D 12,
+		.default_sample_time =3D 55,
+		.num_sample_times =3D 4,
+		.sample_times =3D (unsigned int []){ 28, 55, 110, 220 },
+	},
 	[pct2075] =3D {
 		.default_resolution =3D 11,
 		.default_sample_time =3D MSEC_PER_SEC / 10,
@@ -735,6 +743,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "max31725", max31725, },
 	{ "max31726", max31725, },
 	{ "mcp980x", mcp980x, },
+	{ "p3t1755", p3t1755, },
 	{ "pct2075", pct2075, },
 	{ "stds75", stds75, },
 	{ "stlm75", stlm75, },
@@ -814,6 +823,10 @@ static const struct of_device_id __maybe_unused lm75_o=
f_match[] =3D {
 		.compatible =3D "maxim,mcp980x",
 		.data =3D (void *)mcp980x
 	},
+	{
+		.compatible =3D "nxp,p3t1755",
+		.data =3D (void *)p3t1755
+	},
 	{
 		.compatible =3D "nxp,pct2075",
 		.data =3D (void *)pct2075
--=20
2.54.0


