Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D329C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:39 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13245.1784294010068247005
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PqI09QBr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPQaiqLuv66ntwqvQtyzLvCZF5dZqQGEfthUco3KbsEm31GHuatMFbTHjKQko9HyUu389IUi9IRVtmxGxW39QCBKXlRVigz0U4xAbVu6SC9cuF9zuRWzc8GxI1ov/uCD0b29Z6FebrKe0OprPCaCrJ2lx37iQcbMLjH93jEMRg12wxxra5GzsJIJia1Iggzo5E9wABksRsZy8K/JLw13mzXdiERyfLNyrFqLJDLWrQWs66nhK+C68R0J3QgNn8DhLKmXs5FrjUjzqMa8uq6DkcT9QxRnPQotMQOKlTc+HsmJD/jbZ4KozDUpqsfL4P2r46fDAzxTz3ShH6oBmvsyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7pP9WCBQ0X4zC/gJjUFV+mKNhidsVki0uAKi8yMd2I=;
 b=N4S1Abv+Ppcii8Qbzbj9sySPc3UQ56YKAuBSYMRZJ7sZgAHKPgyqSx90ycqLsfeqrPCukX+7f3kAHvIpa0V/8MDTh//K51AMbY4m3UuCsfND9g7OuISJTJZrtwfbR6M+Q/I5cM63E8qhZ515DhByWsFQmuuD4asTFO/fmTeJx+GUbh7455aGArZKUzqqJdFBaEYyMMQxjE5zIl41TSgGXcGbURvFhrmo7bsLCj/PG+SLf+iE+2XXycjD77MzoXO1OIkBbJuJ7KHRqzwejX+/QljewPcrtLCmPGzrAWL97aPL0dLzKfLBLMozCveRlfrWSNm4k2HHJ9p+WFDLcD1eoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7pP9WCBQ0X4zC/gJjUFV+mKNhidsVki0uAKi8yMd2I=;
 b=PqI09QBrvGgWt6YS+uOu/M6WTaG/WbTkwz30G30kc+g0bsbVwSlqXyA7cWhjAK3JfoztvGWBiMnZVKQgkOGPXcHzb4OSByCwkWPlNgyL3No10vVmHWofRRmwt58FECvB4bQKx316Qpi7FIuCV97ZgBuOt+9udYXzgpBkc+YrjEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:26 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/23] hwmon: (tmp108) Add support for I3C device
Date: Fri, 17 Jul 2026 15:12:23 +0200
Message-ID: <20260717131241.2233788-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: abe69e50-2763-4021-2ef1-08dee4052ffd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ftWIUC2eYPaCD1WnIVEPT7yTACei9nkufA36dEgN/5+SYuCH0FHYJbeSFRPz6OxAq/kGSuuv4JCqC++BtswNvLdwjZlJGY5x0fEva01N+OO9UjBCouRL7WIadOJIzxS8/eTfexJ2UPiuP5o+2fqbRv9fczHVDb6QLDd4mL/gjYYc8MPAlV4F0X0jf4EHvKJUNBWNyorOFwIM6uS0ZxczFEJFUf1Zf6atJQXL0+JlpO2P91f6evfpPcid/qHjI/R+JnCqPJJUBGaFS9crokbs9/aAVzA3OLzbTnI1cAn0xZOGi2c6q9prLFqXGiL7tM/NLE7uPgv1TtIqGU0qaNKvNJ58xr9xVjmX4l31A03F+7OwVogHt/n9m9uQW7fBenRnyf8luRz3ngK5688qvvMdsWUEJLG0N+MFjKPg33GYT0LPuXhb7Ws8r8Fu4yCt/eRY58v9YRCTzaE38P5YmadF+PES7gkvfs/pNDdb1UIiNwiEK0s50o9IFyVJXik1oR62GwWDIWdcy/2gTVeB4e46Wzlw5UV6bVQG2cqbT/L5StYtewY0JPa+MXeiNTiUF62K4jc4WZ146UaizUAixCnKseUpz7aQWCgN6+Yc7S4hdbx+c2+/esdqQVEQuXDM4ppeGpNrABBu7O+XDDjdDwvs+6dTmgBWQtyCBVGCgtLI2/m8Sr2fNNQis2YpyTY9n5tI1kvLHd7ExIHuEOiF1crZgRytv0oZFPpbBq5n/JDjKeQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g4AUBstXSn3txza2x7117LnBde7orPIvRnkgPlH8xC7rw68UkMHwx4haWFgU?=
 =?us-ascii?Q?gJlIdE3uUg3zdxiv+FnSESjIPyiMhb0Cw5pIwpQdBmcXdKSB5C91+NgeuLfe?=
 =?us-ascii?Q?4O4dt25yihOSPDNMllNq/xAJG7JgwHAVeV/Ww3m/QZzt05GlQ1gsGvnBkwDv?=
 =?us-ascii?Q?8rTzvgisF9X0tIVJ95tHmUIstfhQ4yvzqweqKfukvoijP6loq2wfBGGKniLV?=
 =?us-ascii?Q?Gj41xpJEzeRWOxdPv4SFRX44N6Usd9HvSIvmWCphY+as5Q5ERW5ZwoWnN3ok?=
 =?us-ascii?Q?sYD7Qah7sstpA4bTwqRwx1NLot9Visg6lGAexQtCTMrWEZBcK4zje9N4ZgcY?=
 =?us-ascii?Q?dG/HNkbXHeF9jyy5G0f8VXgxdQjyz3eOugOK4XeLecbKW8EHoOXXOGV6KHwR?=
 =?us-ascii?Q?37Z4zWJ3nVP0mAV8ZFNAEeuDJqRTzJsFh0VEPltZUAv96NC/RmLx3RWgi/NG?=
 =?us-ascii?Q?Hu1AV4/B8hNWYU/9qK0Yu3wm/9frSOspMFw87LM5o3uWjwdzotzY9ez82Fnm?=
 =?us-ascii?Q?LH426QnZXEluMr5fCNlNh3PiE4ktw8U37gmbIwBNtYbQnEopZXWTR7m74yWz?=
 =?us-ascii?Q?CP6Wq2Pol9cJ1y+H5DKUP7CBaYiEiqiaxLDf2eHYPePSeIcEKhu1KT3Wr+vV?=
 =?us-ascii?Q?1j3DQnOpweTaPvm0Buccs0ByKx1JQUSu6U80tu4Xf3y9jtFXSK6phdaTpNBG?=
 =?us-ascii?Q?S9xnt2FRIVorpAgrzy4L/HEY/mpW8PHqKl49a7eTnmQfPWrcQZJA0mhLaSk/?=
 =?us-ascii?Q?Amlz8B1HjsmkQOwMvW4G9XFO6dTfQpAMa9i+MtVH73w79MadjQF0KViXoYj2?=
 =?us-ascii?Q?CzpvBq64pEIItTj48wWy8J5pIALDldhp5UlattwOp0IO74sr38uVvA4hJbqC?=
 =?us-ascii?Q?FCVsf40yOaMAMZsGvXpz5k66UI1YubHL19niQAcZsZwKfcRbXRZgW7EdNhwk?=
 =?us-ascii?Q?KudR3KiKeIJsquoUAp60CVeSTdbxQZMGhEdaaqQY9v34X87zBdK0nJewp6W3?=
 =?us-ascii?Q?w5k8y1S69XnV+GfgaNaPrstZas3LR5OyV8jyTrqUgHcJa4WJpMEicBAtstdq?=
 =?us-ascii?Q?tfXORiasGzDWuuzxEpt6euGYuiSOK2Pu9o8lqLiZ8DSLxhm7/R6pY/4Lrj6t?=
 =?us-ascii?Q?+aR5zXcK7jrd7iBaSyZxtYVQQqTBRWWkvQj84GcEJUfOjNJaVSmO6007cK5l?=
 =?us-ascii?Q?+a24vGBWFu1zJEa20m2azGeC7Ym4gsgtlAOZ9F9STvIv+5Cks44S4vHjy438?=
 =?us-ascii?Q?TF+JUJQaglJyFUlMQQ5DsmpCd30Hbw+svlXwIS9jv1/sQaBFY3FF5sEat7Jm?=
 =?us-ascii?Q?hYBFkP+w5tJG9kPJv+eqGB/v+LN8MInHEEVgE6aVXEpmSlu13ffNxh5UeNjy?=
 =?us-ascii?Q?+n/FdiDe7QZPu/HGyiX9vpkDCBmLFRKqmtYFX47BTUjHsxd9vD3p9GUNdPcP?=
 =?us-ascii?Q?dm21BMh20Lmy0bp/HvMIYTemtIVFgLNehaKydOnDMAGhmXMKjHgRzylLirZv?=
 =?us-ascii?Q?yq1DyuHw7HeCWqteKm+YVpS9BwB5foGw4POK4Jt29vq05JQiyiTiY5bpLI9N?=
 =?us-ascii?Q?gSsY0VZxBj9kKi3oZnrGHiFc1E01N3bE6U/O4zE7+a3GcKCm/mFaJrN3e/Qc?=
 =?us-ascii?Q?I6lMFLsAAZjUZ5B2//SJgxvTA3HL2MVN+cbEYbbk4pn6qG2yZviyGQQN6UMs?=
 =?us-ascii?Q?k/cYCmeF6HVdAfaiyBDJqdgSqCnA8evBB9yzHV6wBbC+yka6h3lMXoCUBhie?=
 =?us-ascii?Q?78IsHZ06ZbH3apufj1Y3Z8vfOrnFAWkYGqtu7eUn3AMTOSHIvjHK?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe69e50-2763-4021-2ef1-08dee4052ffd
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:26.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2quc2GCpoo0EBDntCyRS+1yJD05XVr8A5GuwF/6uHrt9FKIzZP0hzcIHzeUbMXFGZL3uAWyJIhuuz/0bSzwrBbdMpK+lUbdozqETRAWfzQv16uuH99VNPMp22/kU7vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23633

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
2.54.0


