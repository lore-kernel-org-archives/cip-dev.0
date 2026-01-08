Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBAECF6AB3
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3053.1767864691044403323
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=apPKKj11;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAe5OFFg17RZpA0tD0ktG7tWAwnD45ttvkttxjBOi4PDg6HiBRLk6Ufa13Khps62xr2yJYsEDK4+0SDUCW7PxseYoTs4Dg2hanL8e0Bsjln4Fp931ghsyB4BHno8FjGQIE3UCGxLctEeeG9YfFw8577aP77DXXhumFEC2DFo5aTKofWIo1R4fUtMi8ZmaJE48WNpmznoVR4WmlJPocKn2YtB4ImMSJQQmupnCmuXMMdWJE5MsEoEvpfM72OCGtaRyrx5TwhSDd2W4VBfhSW2wChT7sHW93R/RcJgUsib3hR/zhM6CX2pWVUoqd3UQKaKN10ICLCmC9ZN43OFC4hsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Bt/HvOWGC/95GJP7SSvHpKw1iCXn9r030zVYvrDWFs=;
 b=mbkkf7zGBaMRnxQfecd841KNCyMDGdgGdznA6BCQnRR8bH3wvOssnmLoL54sncn97u/NtuWtvlvz8PNjiVUgfhkr8AhM+L5DA/4Zjs74VKnluBqwAmbnVz0llj1lVUWWX9uOKKJB3A2YcDZYtZ4YesGPPd3+224GgeY7vlzsoYFYGSKiB4r4u0H1YUJfSHk5VGy4/nrUhcXegTePxExeEJQ4NNAY/rFb+iUNp5Ah/OZZJAug9LgUnMv7yr33lhyGFgYzsR26ruDOoAsq9lKxsO9HWdsEeQ+SdcMTXbEX+GWzu1pYyvH2qmGg+F4n6R9QmIZhCVBUzKVKDr7qszg2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Bt/HvOWGC/95GJP7SSvHpKw1iCXn9r030zVYvrDWFs=;
 b=apPKKj11HzMVGqATeWG+lg9db0NbBJp1o5vqMIgh1zMmwdgtVcFaQA4hrr/1NdeKdSbzdmJPMtOLHKCitYTwRC3+d8MM9M9ujIyl95jJ/9y5HGy/EJ3nJhF0toLYJzrDQCkPqncND7MZmlOU2PLqD2uCL/MY7ECrfqOmsD7bsN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:28 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 15/19] hwmon: (tmp108) Add NXP p3t1085 support
Date: Thu,  8 Jan 2026 10:30:19 +0100
Message-ID: <20260108093023.489513-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d519c05-8d4a-4898-9a52-08de4e98b31d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xt1ElVHlbp7GNlQTLOZc1epB7H5oihG83OOyM8fK2Igu5Ub8WiVEu92FhUhb?=
 =?us-ascii?Q?rB8NCOZXezGl86o5l82S14v9KrpDg/bz4fixyzKokXvf/4hBtPKz9yrdJysh?=
 =?us-ascii?Q?YROdctcwMxO0GrNNas578bbJ2rLbWW4ai6I0jlYozgntE5oADwcDvorsYWGb?=
 =?us-ascii?Q?h00TKhzIDFn4vlFsMdB5zmpze1khHppLiuYiJ3VesIgm/A6dq7s6EcIyivE6?=
 =?us-ascii?Q?WCozoEAR7erpbATNO9UiduJz5XWQ74DiFVd0h79msszc0vygQDs7400IQzrr?=
 =?us-ascii?Q?N14+Gg1+Dga9Sze4MDSmQnRPFry2N+5soGHEPunay5oU2xhuQzM+YQiyrevU?=
 =?us-ascii?Q?EzzecABck0y0u9wyN+T3yRRwIThrCLcIS66XpOa8zgJ8NyD13SD6AxOuGWel?=
 =?us-ascii?Q?mYvJ7ISleMWpc99h+b3QdchGkJaInymJpr6b+IKD7W+UZW9itspaJJ1ZWxye?=
 =?us-ascii?Q?ft2VzgZMN91yqLxxyjRMpFxCPMOsre9afAAtm3M+AIAJEYe1eywTmW/omkNp?=
 =?us-ascii?Q?UkxeAjrqy5PwjWo4ofxwsGunnuaIIsEEiaXs/Cp3H7yxIP5iI+Kb2CVuHI7b?=
 =?us-ascii?Q?f6mNb8u+2fetEZ1d+ilIV/RjjkJBkYrkNv15hr64JBsT0IdlJBhUXjBf0Zfs?=
 =?us-ascii?Q?e5tmPweYSMmXeJ4J+XWVsHmbU9I19xNJTnvIaREWEZl/IEcQfVNZ+qfd121R?=
 =?us-ascii?Q?Nq4d9RMR1d+7N3GuNEnZU133qpITWykmhYl38axkDGiQuWqeHbkkgDs55sHs?=
 =?us-ascii?Q?9oybwJ7GvXeso8UK3/6sRYxJuCNhds4f3Q8FtrpbA+O0iHgUzW58Kg7YHLq4?=
 =?us-ascii?Q?h6mmU6VvRKdIrfCqgb8/IfEuzEtAfBl1ueDnjN6761wJcWjDIqfKCFhLhKNm?=
 =?us-ascii?Q?FOPFQwtDw7JU6Ts2JQxC+nHUWXaftS2kPtXvwxQegNdiMS7iqoLPpWiaK/Ho?=
 =?us-ascii?Q?G5vcGsYFbEpowuERskORkSe1TTA3GgX0/T3BsAwgMckd7n53XRZ2EMzCgJe7?=
 =?us-ascii?Q?vtwG0ebdDWcFhspw2pzeNqwfy4gFeSMlJopK2s5fdk4ICjSO8JvkyXAyRbVV?=
 =?us-ascii?Q?N0BwFJvloSnLYdrNk8fg9VQFgkmPIbnO2yRE7cr0xBPGTkJdAtCV98/F3BBy?=
 =?us-ascii?Q?bPz7gNbJzIFI4OCU9nNKwU2buvduhGs8yhRW0OHlh+GI8DKo7ZJ9ieSPbKKE?=
 =?us-ascii?Q?tPwrPN5lh/ORr6oQzYf6UvZjVCy+L8Th6fKP7tcRLQgOy/asoMgfs31oZyqg?=
 =?us-ascii?Q?cRmxey5tZHssC+Y1xmqTSHNyHR8iQUgEkgQKF3Tf6P57vVY14cP9vWB0eb69?=
 =?us-ascii?Q?esEgPuUZyIVqJSgdZudl7AcXPar4kDY0ZNnYrvbCSOfv2Cjj84b3mmajRPHo?=
 =?us-ascii?Q?fxa8yFrYYXv/l5Br0zpi2fZiJOdls9lUzoA3aX+6Jbi9RdwkSmV8mcDQq0GF?=
 =?us-ascii?Q?Fo3egp0pXHzSRidhZ2bq3v+/gw2Y3bLJwwfLZG1yM8s6xbks4k/FtrfiAiRX?=
 =?us-ascii?Q?w7UVVBmDd9LpdAJ9EceHUREkKr7xMYNcgoDc?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+mnP00pFxW9IFFPNgKVjEZISLXa1oc6WI9g7cabMew2I2xe1i38hCsNyS8XA?=
 =?us-ascii?Q?fbNU8UQi4/gEI6RIpYxGSkVRotIrT/nA2nTzIKcdbBQNS2/ne/8h3WDT7M7P?=
 =?us-ascii?Q?n7seIh8vu3bx8dSzON+IN5EUJcVIugtpLgPCjpX1N8O4sJRc9LkERO4Pagj/?=
 =?us-ascii?Q?agZhF3lhX8964Hzy1f/gkLFHf8XyGU708chy5A0CWUVKxYN+4ehdOgDQNBrx?=
 =?us-ascii?Q?vEQGyuJVY0B5sqMqtbKvADNrn267r2kKBpmIiy4WEiAqcGn5T3YPHyD8zxiQ?=
 =?us-ascii?Q?rnt3E0F/cKbzhkPkxP+7h/3PTGhJoam2BxWOjI8Pb5hTS+vt7HF/K1XsLsb0?=
 =?us-ascii?Q?D6KM5OkD+2/4G7M5uVklqmaqqssVwPitQtLouRDO+8tY02tK8p87X4U9ZRhA?=
 =?us-ascii?Q?CvoqKwSBZgNXzXeIxcdHVOBVskClObm4asbg4jCmrSlWUr3zQetJp+AI0Azj?=
 =?us-ascii?Q?pblWPh4KBiyB6F3e8LdcMLaDsBJro3wmIXuKrOlj9xg+qdX6rFf0vegPR8ar?=
 =?us-ascii?Q?ZNNmB0LvKiAh01sLwT6KGnh0wUCOHm294XUBFRpf0e6SQGb8MZaToBGIXPrn?=
 =?us-ascii?Q?HEPJfCId4nwPnWUUfdjr1In9+EsOYD7fXnG3s/b0XT/WKI055n4i2U+Jj69a?=
 =?us-ascii?Q?8y7gwT1Y1LZt/uyptLtiHW4+I0bEKAvR2b4gs4aO3ZxFfLKsZ1Y/HZvIXb0u?=
 =?us-ascii?Q?ZB2d4XC/M67cno3gFktToGXsoSgnim55X6Kg7nhItcBpREK/9LYckHO3qu3t?=
 =?us-ascii?Q?ju+WdveEyPxuJ4RrF4X0bUgj2RmScr9Db4qC5xf4qqKna0FKMfHnvBXvd2oC?=
 =?us-ascii?Q?OkfpokNXGjKpex6bEC59NmCNtiRXfmdhyxftBtpRGbGTiHXmuuNq1KVf0uwd?=
 =?us-ascii?Q?/I7UnunSTd8HCYjvMEh2JdLWDmTxZeqodSIyG3yAKvELsgIh2jGCbM4RTuqJ?=
 =?us-ascii?Q?hFOPns5E9KNU7jhbOjeEtZKG20amgJU2TorxYzjTBcmy6g+mc0Mwd67vY9/v?=
 =?us-ascii?Q?FxVNJ9apw55k1JXxdSZkWq7N+xCe59zsYGbL19YfaQS6fXaaKUscl16mEFwY?=
 =?us-ascii?Q?lHgADrFQEUjlwisRK4istDr2mjPOCVeCpH5VE240u78ZeyQOWCxje3p7gNd8?=
 =?us-ascii?Q?ScjurBPMglEh3b8ueSd7q1h48zidek5sFFyylGgL+qx383vUY5m70LmkEOK6?=
 =?us-ascii?Q?4+RBgdJfIik95GMoHE/NKg3vqUZWqH8Ym1I8zHREcLYl6Fku7SWt4OnNq0Bk?=
 =?us-ascii?Q?R6HmdVVjztDxHIGYcCtAQUQZWfI2XM6K/uPlpkWKFCwF2QmUM1eX8sRhtSMv?=
 =?us-ascii?Q?NEQ48JRLgdQUf/xLH+Z5ZPNF3YTGMYtprd0nY8Z3HFZbGkzGa6b7KfBgF22T?=
 =?us-ascii?Q?J+N9AlTDFAKNB43NL0HdeGF/YdWfYGSJ5GQ+LvydnDIXWEnZp5YiwlVQy6ah?=
 =?us-ascii?Q?40DzaEXOz4EClvtGeWGCrmzIB+iEdKGtkcf3T2pODHIU0EYZ8+Jsr/hMnN0Y?=
 =?us-ascii?Q?Eo55iH7yKXQnp/JcSiWOFXfUwLIaABmSFNU1xFctRSoyNBrLpu+o+6XVBFo+?=
 =?us-ascii?Q?Q0TRuwau1VYRuJ+seSjOKGKMr7JWeEix9eexz0yRHfG838ceBaXlWv2y14eE?=
 =?us-ascii?Q?arU+GBi3/iir6n0SpiF425ya/LzVDtp1z3XjEFzTbncWme7wPZRy9099Sigh?=
 =?us-ascii?Q?qwbSw6t13XHZFtvHB/UN4IwE/9pEXtnrO/MCAo3RwuCiGYlzadAS8dJSDQ+X?=
 =?us-ascii?Q?846o1bKgDRHXeRd9IlOXIZ9IBn8mWd7XDP9rVXe6L8j8oA9rEBwj?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d519c05-8d4a-4898-9a52-08de4e98b31d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:28.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13spTYaqwkPwPq1SLBxVsc8PvlScJeSaKwl9Fzd8KeRJUqgrXwXIpws7o2buLOFlud6PkV11ZCj+0XttxqQ/RYVtXgqH5IkECIYhForfNRSI/bPzY3tsbHXzHvRAewdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21474

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
index 58480a3f4683..6cb831da6048 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2277,7 +2277,7 @@ config SENSORS_TMP108
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
-	  sensor chips.
+	  sensor chips and NXP P3T1085.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp108.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a82bbc959eb1..b561b452d8d3 100644
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


