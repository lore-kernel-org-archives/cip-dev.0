Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EA9C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13325.1784294137719031092
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A3pkgVWT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCQfGQvvP3iTBpwEwdFZuCKY2URDdLOak44J0m4brTwSEq20AXYQqS/np78hEaMedv04SfI1L7iKQRVMN0yxA4Gt8qTwr87B0Px5SL/0ZrE4hxmXwMZmX+rnvqqWvx3VwJiW5Esy5d4wv8ZYnWlhcFpGL9mxdP+cnHR+kDATYMe5UZDcmkmyBQyjH2IWMArzOeZT4qnQJrtx8T/FlCfJpC4GZHhSyucK1J37d5BqY8Az5E130Ov1VwK02pfFrv5a+qUpuxEzMRLLVsmjBgEgh+bUfT/g8STblaaKdj7dzW5g3ZkltJSsqkUyNI6a4YXp4lilFRoeU5D/I9G6tZ/f/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSHol9FQBbm/G6ZkFOdOosLyG6XRE9TaNPYy5/Ioktc=;
 b=HmcGHgIafmNdnWF2BFBz1ts0+7Z+4H2oZG2Ro0NTW3a7VgugNa26tbE+6M2woltq5Rn5TjNN/Ys6try8tulaqlim1HAj/uVcco3Wv/boYtw3Na8PHp02ORmm9HY5zw+RIP1BYgFdretQV+wDQQVkKOJNJMzZyisl7+n6wDoCMXhQ1VZfJGqFVW/5hMacR0Vpq7x8GD3af6I9U1vdSEpSHuXxQpjrjgDMbqGIkjxin8rcb9u2TW8bBskyMD4jYIidmJvTUEyGrJMzXN4gkMYEsWXdIu5VPDQYt1dZtAKuYe11dug952Zt0fEB4xToNIHFIjgemhNXN/6QkQoJ9YjvJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSHol9FQBbm/G6ZkFOdOosLyG6XRE9TaNPYy5/Ioktc=;
 b=A3pkgVWTL2zr/Cmof8/ElUkkMswd/jLqTqkgYDzXMBEHHX3jN1ly4X+75zTj1meu6TmvlugiQ002tLLgF5RdDxFSum1WgvLCGOIEZ3igC7gtexerotkS4UcOVrYUgH9Tg4/2xvJGdgKP0Wd+lL2nEG7EcjUHVBee1FhzA2IVsis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:35 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/15] hwmon: (tmp108) Add support for I3C device
Date: Fri, 17 Jul 2026 15:14:51 +0200
Message-ID: <20260717131502.2234020-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f18778f-1f6b-4c21-0fde-08dee4057cd8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	NRtxG5PiieAu4+9LEVmtoHDIl3b7G+Izu1/nHRiu0h62ReAsMv7ipYStXiaP0PmvQlDcNgRa4n6nyb8fKUYMDLT16bBl0SLjNVp4YrszoKpKXDzXpg1HE/RsSNQIXNQXR4FjkAJ6hgJfBWKV7qCS86sN1Idt8NB0YnQ2FfCl2Kb8/9R0AgSPeXj+aO9iii44i4PA5E3OA/Xhy91Mv4WIhLvDgmbl4Isz74PcpLUPg5Y2MrFatefpflG2XNaSv3gcYgndG4j+bufCD2KBKiRFCOuAPnKPo7mwMCaGw7Nk07P9oaOhOkGEFFppg65Aa/pfkBt27s13y3Z8r6ZD2Av9ZdVsp5LmkFYBUMpyoO2eoH8OgWCTU9gwSVZKg1Xrhx7kWL3Hxa+36E1Fnt4UXFIss7LbZuZ3m+bumCf6dG+KZS5IZfQm3TSqkoZtqn6ss0uo8+dyLIBv9zb75IETTg0JEVcr4ZzVM3IkMd74gKIoYI5ubxtg9zj5Ax2kDpHX7+pZUvH/9qaRGXYwa8Iz3kVPPvj5in4rQylFqBS99VqNnWzNyMiafcB06UFDX8g+lWThThaVd5yjeR+mm90WRvylM2gGhEdKE+2rpGDShDhLuGGrrC66bZzEz4OoBYukNGGjFSatjhPVhW8Clrk/l+y/5nkbZrI79V2btuPNmx93Psu5PwDgiqwCE1NachbYJkywfCiGNiBnY6y1yg5+piIA3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UGGM7yMqFQaS7ixlY4V+Kva0+Tu/6/2bJ9RL0eEq5m6OqJhtt1BRqh9cDbfT?=
 =?us-ascii?Q?D2fGIWTH3IrNkb87At1c63XUw+MkR+gAKv2Pnfj/PErc54kojSPhinvaUFQD?=
 =?us-ascii?Q?MktYLnkF0yI+Z9hhWJx9viFqwhyJkIKD8QqH+2OTXvwMZAoAcK33u7CTOfYI?=
 =?us-ascii?Q?Y25PPU8FRC/g/Nv4GJ8VAGHx6Wiuju3m2AAY2M8fjRYHK106bNSu6/HV7ILd?=
 =?us-ascii?Q?/ZMR0oOKdNRilhVLqD8xem8Je+oDGMPITXBIpLgSf1KcT1eqs3axjjGXn1GV?=
 =?us-ascii?Q?j6oqZMhq3Irygc3sb+foWxnvV25jQVNIAPaUEj2Fqqd+wKJLKwHWM5XRFlTk?=
 =?us-ascii?Q?5Kqukz2a2lE4LZDj6PbN/ri7c9ytF5BwXhjoDbBMc3V0ApoTdkVum88c9xX9?=
 =?us-ascii?Q?W5jI9DrqTFk5E4Mxthe15UxFgkOoZXRd/fmfYdcn7K0m1nKqD9fYQr9kGCfo?=
 =?us-ascii?Q?MCRWQewGtVW9sFtMOJ6FpOFn/vLaSzt4NR/8km6pZLX38znYp/PaHFAc599D?=
 =?us-ascii?Q?WznCzGoS5NRFQwDZuQKlb6y2S1eD3KjCc+8zy/H6m/urNJvFLV3aepI/5lTY?=
 =?us-ascii?Q?ChVsnGIRXj7FIUHfGcrX0iNW5Bt1iOG4FaJVLIIuJh+Dpwaxf+x0/RyxFWFr?=
 =?us-ascii?Q?PL4BeZGdVs4W59VxrUOB7DT2RZplMnViBnmJrucCV4YjT4xRTVMAzvZbSdIP?=
 =?us-ascii?Q?aXqISyNk/UCFKHNQT6l0FVcvfaA4EBOdiAN5H8zcfmXzVejjVEM4DrJpX3cN?=
 =?us-ascii?Q?rR0ZyRnw/4iZoc6tCQ13uRqXHHRefelHzNG7aM/keX3o8EwThkBFdJhfLxEd?=
 =?us-ascii?Q?lH9ZaAx4wFqLauVkNlcK/fzhBvuADpmt3Nz6marpsiZf6yM9BupBvYFkqw3g?=
 =?us-ascii?Q?An4Ri3MeZ723zQGOE/N6a9bBuDQ9Eb+AIC2jkk2cbELvn5a0hhRqksOhaJHZ?=
 =?us-ascii?Q?64/ZVjNs536DTgEUiB9ezKBNQ7iUEwJ3c6L8mNDfQ0i58RNY18LJGyhDd2Nk?=
 =?us-ascii?Q?aqK7JxtQPusYSuvXt65WwiPgf8JToXy3+493TqAfBtdd11D+93Gk/f1wRXvn?=
 =?us-ascii?Q?/119rZxC/j+inYUDL0k4J949PAdJMRvDitCYDIyqI6DpHPVkkzhgZNwm3XDv?=
 =?us-ascii?Q?XG5nCswjhY6V7qskNxPjW2eqDzTiXWfEUKsWNBCb69bKkZ1AySNoPXAmklCi?=
 =?us-ascii?Q?hHWGKdmopqG19oGi84/ebbk9hC85bZU2xM1Gd0ufKd2vzmt66eR1X15RXU4v?=
 =?us-ascii?Q?hZz0WdWxTfqv0t5jiO/wUq4PBBWZOxyZFYq6O3PDXpnSHYo/3Mj0Vct2gg0H?=
 =?us-ascii?Q?r3mu2y5hb9poAKx1G7PPBmqQYzj0jxVq5/GLjXmV4Fuj9OespytR+6oAPk7N?=
 =?us-ascii?Q?0JmxbV00zJjsoB5AkY2PlbNpmG3N4PyLGtyX3l3UCEPGNm/aFrvu8evplBnx?=
 =?us-ascii?Q?GUnfvPh58EwbAywzaGrY4CbCqDs8WwaxCwlEMOTcNDN3dRONGR/sOxHDelFy?=
 =?us-ascii?Q?ucraWxpFH8UawEpKKPpZSEjARMwZHCr3IWNJhYt5A6QzAOJKDfCHvz5ftBiB?=
 =?us-ascii?Q?1RWd53ZlrxvI05a6/Tc90JosfX4du7fXek9YAA1AlESbzTQkzhoLNEcZE12D?=
 =?us-ascii?Q?XAT5luZ2Xk+xgqDGHa0qLq0KA+RX1fE7JEem5OlNTX8Q5yha0vwvQkGvB17W?=
 =?us-ascii?Q?9Xb4Jv2UBcclrUicNfp6xi7oVdzSQgmfiK0tl9y8yDY+pu9eGENPJpweU2Sd?=
 =?us-ascii?Q?E5sKJEzXLFZn+vewAN3A63amwlPpC/iaODhZBBGpJoYTJ1B7Wz+e?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f18778f-1f6b-4c21-0fde-08dee4057cd8
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:35.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGxy3rtqyw4t3tyPTrAsu/IKqk+tTcUeYY6BYRvcc5k3kzu2U8rkEiOqbU9ABzodY3+2qhgwmQKL6HeVeZNX4zciYtotqtkhI5duDY+9UwdIZLb3GSs18eYCLoYm5ESP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23656

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
index 930fb2cfdc00..c757d0dd546b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2275,6 +2275,7 @@ config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
 	  sensor chips and NXP P3T1085.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index bfbea6349a95..1f36af2cd2d9 100644
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
2.54.0


