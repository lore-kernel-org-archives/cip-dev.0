Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F8ECF6A9C
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:50 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3006.1767864581770597123
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=USJxXZwN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hx5rplU+263bWcPPCR3Nni03ybSwRzNypdYTXQmvpXk0z9bDScnbgYz5O+KYUhrcaQ42m5g14xDuS6vEz7t/6Iu0dEEBqkXPkbkYeOG7PFtpey3ZXdimWwhuQ+I3B+ezH/MnUCyIjxfUx5XXOVJhuR4I/He8b0u5d6smVO0stT9f280VucKoWQLU6qSx3FP02YaXvY4RJbN34rBbPwIO0sfji2JkcWeffUkijrRTd68Hfjacg7iYfwt12F2YXtmyGllo95L2r1z0CQ/CFuasvy9A83lXmh42nMWNOQUQv46bfjnMZZ82gHXZxwXISfRTrVs3l3Za6xOkMIhmzJLCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Mwfhjv0/ttnMzGmaLoORQKv6DOgrld2GkTyUFLhTY=;
 b=MEYnZxb9FtwBH+S1AdXNxNmFNrKvaUHkacT+Jeps8iTaPv5ERuE35rQhUxG6luI7tRDLK25jJD7tjnvMwrf2XLqE/lys6k8SeljwMtCh4WWipozudY2bYbJjyCSa3/qP8upBefXxkuGEh36kngHqvMAnxFMiRn5yI/F9TJGvHPkrXdoj6eQh6Q5L90+JG1Xu1qjytoU79XRY6W+ETOwljgv42JcsScnvRPQXu3A84EYGt5HKP8gUy8co4xor/dXkcWkxg5UIKuY6hwymDc9B4K43vIvzrzZZv0E2XHNMWs0bDi84bISXIAg9sbZuaI4/nXo8n0LD2N9dlSjtMRnsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Mwfhjv0/ttnMzGmaLoORQKv6DOgrld2GkTyUFLhTY=;
 b=USJxXZwNK7JTAQZfLHVl1/o3QsHaZqybVCOs22mqA7lcOq/roqm/Yn0zdTSl+VtyZVw3kiaRecUPcQy2atyqMu9X/zQ+HlwoVX1SFCGMiLGVy3aQpqo4w+Re/ISlQPLeD/ERoFwG7BE48ZGhx0EnP1OME52NJi7vX6AEy5WVjro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:39 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/22] hwmon: (tmp108) Add NXP p3t1085 support
Date: Thu,  8 Jan 2026 10:28:19 +0100
Message-ID: <20260108092823.489287-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 1510a531-aae5-46f8-2d0b-08de4e98724b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HtDJDsAHsaT3rjhoig09JyTqt25yPZjUordzvfhcKPIlI8ywXe/sJgMAHyVZ?=
 =?us-ascii?Q?mnka91R53+uytwVtMD0kElsBpymVoVUeKL8+Vc4Rc1tkFuplIM9dohj7mJCS?=
 =?us-ascii?Q?VujrV3hcRZxm3wwFyKDnuCOy7Zaed2FcC/Plcf3SG92ZtzXvKKqgp1VUAtY5?=
 =?us-ascii?Q?EGfuAcjkAHEGb2dB1lf+psLC3LzcLgafzPLlTEJLsHWliOWf+avcr4ypGzDg?=
 =?us-ascii?Q?8ql2oFrSyBc9OCr8Ni0mw/HRZX1VulchKK129Oi7eCqNqYIHGWKkgLTIVrIe?=
 =?us-ascii?Q?s2Tv1Fa8E0ZI5ysM2Y2p3r4nMYXzprjCYuYi5An97ULeGpK4mt/YFzxGtcBf?=
 =?us-ascii?Q?DNWxmQuRjxMCQRHaB/PL8BtCSgDcNUOFO7jt1LlmVYdWDRVN8dE8lYgetoMg?=
 =?us-ascii?Q?BVcPdmK9+3j5yHsQaAnzUJYLLuDzGEuF2Mda7L40m+xHdlydW8rRaGZ92Cqg?=
 =?us-ascii?Q?mLlJ8UN3DYeYa+ISQgayXufKK/iNHZ3BgL1jG/cKQm0j/CrbJPRdL2ztBVX0?=
 =?us-ascii?Q?LMBow/HnX5D0pPFiHwUj8QMFT2Z/ftdQ0U6Z5qXQU/RHnByAWHmvUg3xP3Oq?=
 =?us-ascii?Q?7mt1NVQOmsDerJ56DPBmz5jXQbXZDwHTw4ztnuHYDdpikks23BPa7D5bFrEg?=
 =?us-ascii?Q?lkGBOA0TFFFSozbJ+wdJxeIlVAL0TitnrRSketXy4Z0ukKxB4Ry15cP9zE8B?=
 =?us-ascii?Q?nMj5YYEWTxpGZTleU4yuE8fBErvZPmn+FsfJv9reqIot22yM2o+elJW2MRDM?=
 =?us-ascii?Q?VNkh5AdaFLKjRqmDF6GCIpIeQm7hO3agDbrkq1q0Jr21lZyr9Hw23pGxl/jg?=
 =?us-ascii?Q?qxPvGgfEUJhJJ+C/Ju+v+omiVgDbhE1CHEdHVfHj3bUGCD9ap84Xr6brWhJ2?=
 =?us-ascii?Q?8y0L6xhIibda3CjXrGFz/cE1Gg2Lrqkj2oUY88ZwA3I8oNflGJIRUHAXF5Rr?=
 =?us-ascii?Q?TsKmr+pEqac57uqtFRr6IGqh9ArVTa4+WGleSCnGvBGMowK31fKtH9JpYB1j?=
 =?us-ascii?Q?5AppZAjiWYHAN/68obTdiAGX6bGRrdg9lklnkglUC6Qk35AR6yjm3UedVsAy?=
 =?us-ascii?Q?JBRBMeInHBCezVZKv4MSkc1ymvTjferV4D1/1uFjGHI6RGNnHRxEakibL5LS?=
 =?us-ascii?Q?J929uF1xZf9hImGLr3umj6OU0GzPBPbXddjJ3gziXQlDeKmqnLyvfh0WkHRj?=
 =?us-ascii?Q?WFQ+7F/9l5bnoiT5tTd1ESUcF8siJSY2COjOqAelEh/p/8D3RmPjLj9k28om?=
 =?us-ascii?Q?GrMUk/yOdx7l6wVT//5Pph1G+D9W7MQ3qFYL1BzCfnHk+1CbS3VrkGdJVXJh?=
 =?us-ascii?Q?6Jnjw2yTT53hE4E0dftynpWSHvSgzT39CZi1Ye/QDtMZpycW9IYNMel2Pbur?=
 =?us-ascii?Q?WNuVm/VURNHErwzjty5VH8iXWQD5iwzkXLRMbJtAozSdygXC390t3p0sMQ6t?=
 =?us-ascii?Q?i+ixvihF4tE7TfG9Z4ySOcB2cY6kT8kfgRZsObUQcda87oOYeregLAWVNTYY?=
 =?us-ascii?Q?bdYV/9G5IAXb62AEWuZsUgx2b+sOFZ9nDcjN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MCAeLrWQgkmC9VDPWnCxpRNF9lsWBfYzwvbTH/kpWof64Uq+GJU+xfepGNSk?=
 =?us-ascii?Q?BvvtKDNM9UdKCZfNR/r6bXpb1MthmmjzSCddNDUyIPd+QKw5mO0+qdoU4Nnz?=
 =?us-ascii?Q?UVrqD4njNeRRBFM/oKp8ApJVlnVpZjDRpH1gkKKSldr00K32D0QtE5B0O31t?=
 =?us-ascii?Q?Dnt1LkX5KFBkCb1Syi8TcYFiztyE5Jsn5mmb/YZaHoQjmH9r1qKADVZzHze8?=
 =?us-ascii?Q?SIsl/yEA0iJe1opgejvhrdEmeTtQiwbMxLX9ZWIeyU4nEJMe080z011n9O+9?=
 =?us-ascii?Q?kQHzurM3Ucs2IjXWca2kA5cD763NQRlMZ7koWswkUmSO92BDjJOl+KQryE4f?=
 =?us-ascii?Q?x8gTlfucNjKVy3Wk8TzQLSqj4LSR3ktz7iK5rKHn1iBM5FPZj9D+aAweOe/h?=
 =?us-ascii?Q?98sQ+HYc39XXpVGrqu211cev8UFQKqd/RUEOox66T3w6gN8zJYVFZJLvOC1F?=
 =?us-ascii?Q?sQ3lXlkjQsMrXsWxLsmbaxfGy32fp5DvMF7G3eAyoVMCqt7OnkqQNOJBWz6F?=
 =?us-ascii?Q?xU+EeWK5xwnEXmKnYDE7bko1J6k/ng/H0QgawZmut+R2j1spfgfW39mDTLOf?=
 =?us-ascii?Q?joAVd3GoSpjIeT1tG7WlekTGLOXoI/xMjv5uMvSEwTTHAHxbKD43tUdMo36k?=
 =?us-ascii?Q?VLq+r0c0/oadmue9pPnDTiNLNuehANQ8uYLvQA4xymzI9H4r7iP0624ETNAs?=
 =?us-ascii?Q?cljGtKhUTFkznnv2RYJfGwjt0c7pd8g9uG8Pn+j+fktMTslzDPx8vAsqf6n7?=
 =?us-ascii?Q?WvIoam+AXMhZRpVbbl7h7h3BfJs8jLhH/Of79xYnjkajdxW4d36cVZrp5CeM?=
 =?us-ascii?Q?VAxA6Yu8O6DFN29yHEwb+gV93T1gRuAzrEtO0pyolDveb7irqtkjuWwntMS8?=
 =?us-ascii?Q?9l/7R2UAEOIFcJ1fAMJuV9Yscmv1uAaC8ZFHXKeCAZPGAppVBcCredsxG1FY?=
 =?us-ascii?Q?jhV/NWB2So6FKxX6vYE1TnRNOcNGa2ylDf5uhGy088YO5XTiow5tQhMdF2O0?=
 =?us-ascii?Q?g7WQWd+I8ipufPTCEju5awIKVhjjQmtBMi9Mw0m3IWJOHGsg1c2DJtGH09vT?=
 =?us-ascii?Q?ff1w9Zh6AQPvoOj1lcfNCyhFEGxork3DNdMc2URtZBxwnpyFy7dm7TuIyomr?=
 =?us-ascii?Q?5Oy73RLfnTBupgmV4F8le4v1P/URWGesjs8A7On1ZDmlGczYUUQbOK7VXd4R?=
 =?us-ascii?Q?Dy4ArJGA6FClNmBVA5XpDNdL2b8OC2HvjBQoA+jm3XIOcgLcQ3VYzijD9uH2?=
 =?us-ascii?Q?hnyCMVhZyfxuJ/8pXTVWJ72FPzSs3K2NAzo1y/eDkWTgLWxdlson4wVKg+wS?=
 =?us-ascii?Q?gsjgJFeWun5CHrf091GSUn4r4d026qpgvkQU6nXuIJ2LH3u4gGy5Ftga66Me?=
 =?us-ascii?Q?SA6cZmfR68qmkjGKMKmiwF5P0pW0ViV8VAhGJ3pYJNRsCky4E7cedX4twMEe?=
 =?us-ascii?Q?yRROV6IpGQiK+MNXCX62U/hJUtrzN47RJRRtCVfa6Rj0fiILVRSBmH32a02/?=
 =?us-ascii?Q?j3fk0CO3lRLtV5eE/lXjBM6wh7d7fm4pRVxYw6SnbRueuUwAr2lz8oyh9IGD?=
 =?us-ascii?Q?l5V0XOFLdiEFHanfMyqb9Sh+FsUnAON6CKmP7+G5qGliQMYju1GS6MmOnJLB?=
 =?us-ascii?Q?ho2JDDlnDIBCQDfX/gBx2EG4eWgrodK+ZEch91Vc7tZOQsOUibuX3//+UJgb?=
 =?us-ascii?Q?MlvdCrUwVh40nJW+sy0ukeXlQY0I4tcbpaAu6lljb8UJgzBSzNm0+t1NPTlp?=
 =?us-ascii?Q?JYgQyaNSM1Apj2rCv1kc0FsJSG18qUyQ1BG+CYNO0R2phL3Q7a0U?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1510a531-aae5-46f8-2d0b-08de4e98724b
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:39.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJWiIuW3f5chNK0lwygPqSbfWbu4PzPJeXDIh7gQ6KHURGPQcspVq0rBcPKDUpKypUngZfgEgU691xuCF42eZh+tuyUHnGhkd9jDLUBLDV0Eeq/aS/0PgOBkP09mbh8h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21454

From: Frank Li <Frank.Li@nxp.com>

commit 11d35624d7696a64724160199fc94587010d7cb2 upstream.

Add compatible string 'nxp,p3t1085' since p3t1085's register layout is the
same as tmp108.

The p3t1085 supports I3C interface.

Update document tmp108.rst and Kconfig's help context.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-2-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/tmp108.rst | 8 ++++++++
 drivers/hwmon/Kconfig          | 2 +-
 drivers/hwmon/tmp108.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/tmp108.rst b/Documentation/hwmon/tmp108.rs=
t
index 6df7cf1b42f4..bc4941d98268 100644
--- a/Documentation/hwmon/tmp108.rst
+++ b/Documentation/hwmon/tmp108.rst
@@ -3,6 +3,14 @@ Kernel driver tmp108
=20
 Supported chips:
=20
+  * NXP P3T1085
+
+    Prefix: 'p3t1085'
+
+    Addresses scanned: none
+
+    Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
+
   * Texas Instruments TMP108
=20
     Prefix: 'tmp108'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7884fcb95c3e..df7a0d3b59ce 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2063,7 +2063,7 @@ config SENSORS_TMP108
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
-	  sensor chips.
+	  sensor chips and NXP P3T1085.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp108.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index acb4ba750b09..a8d9a4e00eb0 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -420,6 +420,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
=20
 #ifdef CONFIG_OF
 static const struct of_device_id tmp108_of_ids[] =3D {
+	{ .compatible =3D "nxp,p3t1085", },
 	{ .compatible =3D "ti,tmp108", },
 	{}
 };
--=20
2.43.0


