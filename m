Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D6CF6AA2
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:50 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3011.1767864588915271349
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HzZl3yh9;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAoeBT86EzSyoTBV4EcX09sgquKvtB1e2ZATQWiYFP7q3BwBqOhoefVR/NAage6iDrJh/hIaJPaCGAqRG0vKcoChGNQ20ePVvn4RKLR6f7tC8mHHomA35PJihRc18TYVisBJwQUxlxzWesCBYGma1igS9vgBM5Ugqxd2fIqbMdhYsXlGoy0BsCDUvO8VkYIIR4RZt/plFKarMa/Edupo69aIbsdKStFwjfDF08BnU5OfvE7A9XROM5L6X5XS0Fojksu9itlZsFfzoV91oMe4Dks+4jvUzDH5N6pCEim+zspD5Q+nqd46uNkogUlyreVez58sArG/6xmtb1mWImlEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ52TFnew2ScX61E9Lav1DCyEyEW0ZfMtJiIomOj3L4=;
 b=iNFoHtYOujCin5zTOXGBQ/ailOIw0BcBubnONVzQeD9QYxJ32oXe0tmtLsZttc6K4sNM8Kz9W/PzbF9st9tmtcNjyqh0mQzZBTG56QlxhPxB2DN6e+i6oc4aKNBz87av1KvMe1+SpR6tMUn/ynk8z/ERVG4pmxAnLLRXWc8LMfkF9OMisVT4ZqoSWJmTntTDn5C533DZSd98c7GX0kk/CACijSEIEav+fheEkQPy1Ts6yIwQ7Q8GMe5apWT0GLB+jFkgKPvRPUtEw1cOEUoblnKLLEk5SBRKdnX3tx9pNF0sZPrKykUJp70HYP2DGk7Zegg1x8F0zUbF58ndQ+/fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ52TFnew2ScX61E9Lav1DCyEyEW0ZfMtJiIomOj3L4=;
 b=HzZl3yh9A2V0xMmAogeiqQ3TqWt5lT3K8nFN9io+xTw2Cvs2/oyC/GgeGdyJmmB3eEYvr2ZtbJg00gsgHoQc3kX0b8QH2YURMxhoS2oJYQIllPvSUM/RLDt/RwRfWdDxrhPnL5iCpaynN2uwlGUIDez3UYCddGVqiQ8Teo4Ls2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:46 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/22] hwmon: (tmp108) Add support for I3C device
Date: Thu,  8 Jan 2026 10:28:21 +0100
Message-ID: <20260108092823.489287-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f72dbb1e-0532-4495-560e-08de4e987611
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tvDCdisBQ+vKWhW37AMvrZi3DiWB4oAfPL8tDxzN8Efkv7H2H7Y87LNUgQsJ?=
 =?us-ascii?Q?bRYc81pO8KxYeMiBPIB0udqdFy52s1FulOf7CVqs5OMvdxuA90RQtdUlEw/E?=
 =?us-ascii?Q?ww8ucordvsLYvgIAsXrGsir85DPO66D2cOx7aOf0kaXZ1mPW8Lt3QKTus04p?=
 =?us-ascii?Q?29I/VSf//j7zYXdjIXMLoH9ViKRxBXUKMxRkm4mHHpu/dVqW+8/LuKD1Ax6V?=
 =?us-ascii?Q?cBRf/Cj8NXJ4U91xbA4gSxrsRxfiIA5LignsHqy2lXeE7iJSzxcRWIqqx/D6?=
 =?us-ascii?Q?75HlHO+pTZZuDacpT2Tj97ZZfhnYnRHaZBUudY1YPx9P6zN3lVK0aBSBKxhp?=
 =?us-ascii?Q?6h22GPvPtEyHIALNqm7e92OVTCBLVJIzRolcWimpML8EqftDD3d+NigY5iDQ?=
 =?us-ascii?Q?ZIgEQXzY7ciYjZGEyXGdeIxyImgIvgUw62hB8674GmNX0hs7PuSCWxhf0V9t?=
 =?us-ascii?Q?t8Ft8oiMjzdpzj5L41X0rA4v62g4dkegSpQ+KHyC6t8f24aMbrPXP9dRY0Qq?=
 =?us-ascii?Q?Vq1H7EhmGuXuBZM4p9gXGSbdrLSo9oWKkTjd5U2yRIbGofeQ8DojofNAkNJM?=
 =?us-ascii?Q?9nGhpW6KituD3YTXmFTs8AMwjxdHNI80C6g2+5xgtNaCdcB0RjVdaa1ur6tM?=
 =?us-ascii?Q?mx3uAib9vXkPka0+oqDcuoMxKMNcRcJocqdwp26+QuRz5VUbUDFxu7/kd//L?=
 =?us-ascii?Q?u8icM/1h1TUGLfmzYKtMOAw7dUAsEqTm2U7NbNTjzuR5lSUDUCagoyVSM6oC?=
 =?us-ascii?Q?qv2y/J2/nFjjPWZpLAjC+wVbhojwj7vaW9bHYffAIX1XWOmti38NNk35dubI?=
 =?us-ascii?Q?F/gQhPdek8b/VCDk62cGndxNSd694TDL47eDjxKQcYwKj/i8JmCx1eqYLz1S?=
 =?us-ascii?Q?rX1LzCBlzuW/e1M4Xtqdk1z/M1RJrmi99ScsZ4I34FFzdgOrhgnUu9eLL2Lt?=
 =?us-ascii?Q?P1mPdkHsN7NRkx09Kh46dm45on4VKfEiL9a63DGA+IBFNMch2BzoXYHbBKI/?=
 =?us-ascii?Q?Byv/uSBnPyvjZ/3wupIakPk/eXWl+Aj6QvDnRyDeKQuL44bW0RTGahg9mM8+?=
 =?us-ascii?Q?rdqwM+RJ/8/SufWNtxXkOziF0KGm3rJD/EaoMtculGSyOe7VaKCgw+zmoLdB?=
 =?us-ascii?Q?3mrxB7Loe5F5TEvTdYTuX/9+b0t88iUqIZe6fq0bI9VIuuLxvBqmEKRIsdfD?=
 =?us-ascii?Q?+l4lODEvSUY3LOSrsM+4ak1pQOBm6mFk20vtm+YbQbEsnx9MhzdPoL1wDkaq?=
 =?us-ascii?Q?D+VBJ2rUUExtHGPPo18LankXVzmK13cH9/CrehPgYI03+iVjg6EcwQ3VA/AF?=
 =?us-ascii?Q?ckkdF0jDzalTN2+dKpshRk6g6MdCwTg/caJiWvFx1UwUD8zPyCATSzZFLSmo?=
 =?us-ascii?Q?UPtG5CmpUm7Y/DrdIMYsMX9QozULBO1jV3uqQSCjfRJ6OpMQ1arSHVax5VZt?=
 =?us-ascii?Q?2Ve8wN0oXHRr5SvEkfYrYpYLVDIHWdD0bPICaRfMXFMq8c3vwMWGUYEi1CVP?=
 =?us-ascii?Q?CBLETGfl9fGR63DkxE8+aLs74npOx6POx9KM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GdjJblKpT3OZhakWqcPitLtS5fNmvtRqzE/MwwJCO9rWgHxPXX8PBC1Gl/Ht?=
 =?us-ascii?Q?Ve+3QfcGtiLOO0X8sEFb3Sx0fACmZYDu1tKWf7bMEa24FeDGnCmiWTJaK4Tk?=
 =?us-ascii?Q?S3M/oEpQ0TQTBtZt86dkEohu0/WhVCv/UNt8fPyOu9D6CPxKQpgtGCDHH3l/?=
 =?us-ascii?Q?KJIuiZmDQMs3dWKeunjIR04bZsfPFZydU06gkPiEzIH3N9yvaJYGvA2ycuWe?=
 =?us-ascii?Q?Q8x+bcxgYLK2WZbu/niKo36OTSrTPpK8M6jGvZLK0OQliXW5sIrEDOPPjEZ+?=
 =?us-ascii?Q?yrjwfOPt0xrKAmBs/4B/gU41zWBX2369Cmu0+3TBeP2MmaVk/z45q74oSlJB?=
 =?us-ascii?Q?qMC5xohwNRh9Euyyrcf8UIFguYKJAHoq340aFygqa173GyqEh78ttLJKzxdd?=
 =?us-ascii?Q?ErkrVbR+x0N3UXhsDpMWFi8pV8wdsJOL8Xe+/+2LCvydGDMbVcBLWUSgEL4k?=
 =?us-ascii?Q?whNfrcf2kXVeiylaWnqFZUSoI09dmfiEt0sVKiDaT8T8zLXxwoOUJig+yzb1?=
 =?us-ascii?Q?+Rda99r741smOBinR9TD5nDsNVtCen4E3RMc52tf67wIp6MjBdgbKKTPwecn?=
 =?us-ascii?Q?a6N5AleScpfyoIil7NwggewQV4XRJ38MJ/XWsWvONRn7SOOXKj5oIFA+EuBi?=
 =?us-ascii?Q?CIJtHJhsk7kiB+bx5cbZARK67lMho4FC5qgAFporFzs50b/W5bTyB9KHsPLM?=
 =?us-ascii?Q?j0qUGyc0c3Q1NYkrXPmf9E1Z/QfxwL0hiM60IpRamFwAPFHw0jx+qdyGRxsV?=
 =?us-ascii?Q?2zXM4ISimKPtetWG8H15xk17bnsuqVB68iW3OHdbG2lV7mdSMN2BfIdIU2iO?=
 =?us-ascii?Q?G98QUchwKPM3YWNlHDjMu3z/j4BSd9Rsw+vuKQSpfXF3EQnM2F7fXhdIhbMv?=
 =?us-ascii?Q?+KwNcblMQ/7zNOhj6n4D96mlT/lwNmR0X1qla3sWsjAU6sv+9fDsz57/qxXb?=
 =?us-ascii?Q?GaCeiReqHjDfIobID41q+WGb94HfpIj7HHXsoUep2LZ30plWQRc7mF5T1hhA?=
 =?us-ascii?Q?6yJsmgS6NWF7IUUWSknJ6soQS76WpBeFCDl3D7QC+AhNLsgvXvwt722LcaM+?=
 =?us-ascii?Q?x1EVD8r6T0vSGkLLIdljJ3/G5VGyfKQkV7AAfXtZ26ueJ+dH33eWsWNjW/42?=
 =?us-ascii?Q?b7ougCMt0lnkOJIzOnTb/rP7t3xeJIK5Z/Iy/xcy9coY1ybFOjLAlOw1R7+O?=
 =?us-ascii?Q?DMbrf3HzlnL4A45AdwHMj7C8ByMz8E/W4D8wBVRxeMIFRJ5HqRgdUFCxDxvq?=
 =?us-ascii?Q?Un0NWneH1YTj3Yd8dtjZ3vq9D090LFp2uLrZrCy/WieXlpffVXflPuKcM68k?=
 =?us-ascii?Q?2xE7AGaMcCiJeIdpLmCD98Z9jvjHxlibu1EG+HEL622BbobGJoFSGc0qdRlZ?=
 =?us-ascii?Q?YPcb0Ji63JPzuJuNo7ehHriSNvkSg9darp7KKVmihDnTJ3+m4raQDXkgdMuO?=
 =?us-ascii?Q?7yjJV8PrUlZ1qiF6ybAnByHCH9UE0YtLufu0wZ+v1chlplLUoZKXZ/oDV6TB?=
 =?us-ascii?Q?WtamDSV5XDuYHNIpONayLVE0JJF/ROplaThI69KsyiTUuNhXm84w70VFEv3V?=
 =?us-ascii?Q?i5oRvfRtkKqVI5GguPzCr13by30feihVpdYdzEiyss4vq8OgYFI+lxrCeUxp?=
 =?us-ascii?Q?CMTnqZFs/E7hkXPZBDFv66XjPSjy7AIiyxuSrlex0oTdS1kazDO18dqiiY7x?=
 =?us-ascii?Q?RQnwKpPy06iWY8EEXoqCtAP5YGS5BevgmeAPjg9TTqu2Dnd1/ZCTW608J//e?=
 =?us-ascii?Q?GGlnDS+IAkymB31efEVmX9AT+BbEFqwAmgfTATWADF9737j9Ayq0?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72dbb1e-0532-4495-560e-08de4e987611
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:45.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oAnLVsFEewlwvO02vesOEdY/PadoiLjKL6uf9P9QTtW/PnEDazfcBLGHSrPC2LGY3PznanEz0DHt9ILz8+DMYii0AiM/TnBLwS1vIzy+3T5tvuUOWOGD5hRICAAKyyS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21456

From: Frank Li <Frank.Li@nxp.com>

commit c40655e3310649866c4ebf7a10f0d53802ebdfa9 upstream.

Add support for I3C device in the tmp108 driver to handle the P3T1085
sensor. Register the I3C device driver to enable I3C functionality for the
sensor.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241112-p3t1085-v4-2-a1334314b1e6@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/Kconfig  |  1 +
 drivers/hwmon/tmp108.c | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index df7a0d3b59ce..da55b19f244f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2061,6 +2061,7 @@ config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
 	  sensor chips and NXP P3T1085.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 63c2eaa59d21..55277ec7c54b 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
@@ -440,7 +441,39 @@ static struct i2c_driver tmp108_driver =3D {
 	.id_table	=3D tmp108_i2c_ids,
 };
=20
-module_i2c_driver(tmp108_driver);
+static const struct i3c_device_id p3t1085_i3c_ids[] =3D {
+	I3C_DEVICE(0x011b, 0x1529, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(i3c, p3t1085_i3c_ids);
+
+static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev =3D i3cdev_to_dev(i3cdev);
+	struct regmap *regmap;
+
+#ifdef CONFIG_REGMAP_I3C
+	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
+#else
+	regmap =3D ERR_PTR(-ENODEV);
+#endif
+
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to register i3c regmap\n");
+
+	return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
+}
+
+static struct i3c_driver p3t1085_driver =3D {
+	.driver =3D {
+		.name =3D "p3t1085_i3c",
+	},
+	.probe =3D p3t1085_i3c_probe,
+	.id_table =3D p3t1085_i3c_ids,
+};
+
+module_i3c_i2c_driver(p3t1085_driver, &tmp108_driver)
=20
 MODULE_AUTHOR("John Muir <john@jmuir.com>");
 MODULE_DESCRIPTION("Texas Instruments TMP108 temperature sensor driver");
--=20
2.43.0


