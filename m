Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9BC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:30 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13168.1784294063355330702
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H4p/nAnx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrOiViN0md7ifvUVhs5DaclJZLjoR9NK6Xc8JipPmqha1BpUG8647RHynY0ftN3h1kTTsaooX9ENNIC+2ZzuzmDLJ2ryOAZqAAJXwgysfUcindmLkjM4rAkUlmpJw/lCCKRfHi2r/B8VFEJ+VwLGdGF6ViLANz61BVeTKMS07CuVcPXJUA/aQaiT4/m/h6zp0IWUcquFeurUyfPo/4OO7NRIEVAokfihKQF1CmeL/KXDcTwQkAsAI6FJK1TUaZ1jONGfPed5rVfihXMdsqqSietpt9TCogGws4g2VRipqqR4Mn6gzfwv1+Hx/sxCJLGBTt2OBMAR/jTxjVORjRglIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr4BSZdyH0jGPfvCsLG1NeMzAraZ2Pe+34OhhzQM+AY=;
 b=SaHDykmzKSqm4Qbs+skmt6VRXPL0yMWmZ0NnBAx9PT4JWKTY0XyKUFhXcLWGtzIiuzWHKVEIricowyr/mpUKw7/4bouwFP7603QTohXSzOj8e/WaBnkqgq0s/jVBERobI73jHu8TPq1qUc7td4XbGUR4FrapTpNgFXNRawscfJVu5dkFXc6cIf0REdqRKzc2fHatG/UNp4c+BK68y3bsr6AJ+2u8kasgQCwgG0RafIDWXw3OQ7Y4XfP2SVYfRgIb5KYCwvU1xdl3IqJ5+LFpGA6GDrk0pdBpA1bHiSVxzTH+oS8aKD62tJn8SSX6SH6n5ThiDf9vH8BSC4r6N+ksXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr4BSZdyH0jGPfvCsLG1NeMzAraZ2Pe+34OhhzQM+AY=;
 b=H4p/nAnxbGeQLqqD04Cf+1Wg+Pg1HtBJ9yIOckz4iDbQhs9HiZN8kjMo+HLiMIF79ClevoGbf+6bsWnHyzd4wK98AWZr9YgcbsDovqB3MgEmTDVtUkLngSUWzhTSXcNaZZO6rQOKtvgSu9gLkV0TUXRsEOLLJlu8x8Aar68etQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:20 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/23] hwmon: (lm75) add I3C support for P3T1755
Date: Fri, 17 Jul 2026 15:12:40 +0200
Message-ID: <20260717131241.2233788-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 469a6868-d4a4-452a-9d0f-08dee4055039
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	EkfsZHFYS7m6LGt8GRRZypTJDyHxr2eYQ/tRpqSWpXNfkO9jVWOqowKGrbaULVllDLECJ4TP04mD2MdhBA7Ddw8K8xThrrRgG+0se5vFFXGrL1JaTQIIjI5XwUueq61071DRc5+Wi0IkSm3tVcm+PeawD/HSVrlkN9YL7+2ZxkiJvLjbQge7Oo2AjpuRpMR1j/r/8FZKxd0weRbaRlJ607kK/kvSM1MOfkKmFz6W3nokw8lUjZxh7s7hqU+gQCdx65Hw3B9QE6R/83+d9MKNcfIaiqDePuVjCCT9m7tc4PWA8WleOyte8fhMROgxcGsQ4smhIIpa4P3+CIykGajMtR7LXULFGzBQFyJ2lqIbklReqOZC91ffM1T2bmhq4ta7XuQQ9okphmBPEg1o2F54ul/w6TNTHknA4NomDFQB0xd47LS/z6mNCtYevrJoKQT1QrmA02D2cc2urJMlOO+OP1qI3608Ha3CWT3IXII0UrYAMpceuyKbWh/pZcL5KCJu+Clabnp3hVMBFYkYAeaR3E2QQRFp5V7GczBb30Q5zA7i6C1jPwMTg75ZixlC3PeXNVqkuXfZEK8179ju8R4/opfvC9sn309wtduFxZXqlXc6xN/L4HOGJRthmk972T8Zp/xZ51GSHLMfd7SdTLpRR7VJEL/LGxcso/ANLqNHHjFbq1N2t7+HKhrwAkSAAcawZXMSktmhh5K6UzIa9MNMYScf1dyQpJC8fP+gmw/QppY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5OT02aO9rzsDNyhdHwoMNmaiEaR4bopWGOuCkONwfKZ4i7qi7TMscbyZFu/j?=
 =?us-ascii?Q?O2K5XsHJehUawSvhduuD/Fd/Js3knp6lbw4tIM12A3vJk8Qyory9hH0GkP3Y?=
 =?us-ascii?Q?cfh7e7KXVf0NylG//Rgne4e15nLxjjW/N564c+cVF+V1OJutWWSch98QInGr?=
 =?us-ascii?Q?47CbzGvhjpT0LUoJJkk1HfdWld/JapE5kjUdk+g2O8jThkG/fS9GmdFD+/zf?=
 =?us-ascii?Q?jjHlslKnFF+pdxbkuWwu6bubng4Ravndkb+ViWtNikscvPUJwRTCgCns0biY?=
 =?us-ascii?Q?f2ILIr2s2P7zGAjO1cWYw7G/OxjuleQF9padrOn5AWAELlkfI8odkXSYXgHU?=
 =?us-ascii?Q?Rd3BmqYTHji+ssUv9hp2C78b3xbu1fZSm9zBYSaxUA6Re+3JiJyq0SELowLO?=
 =?us-ascii?Q?B7aG8M2aVjOgbwFIIIlB87IFoAMGf0D6daq99fumzOOdkatPQAxBK2kRy6Y/?=
 =?us-ascii?Q?sEfzpfc1sEPtN4Aa6rjENRg4BBp+zapmS1GUQJpvcj6v4dj3vxgfdOM5GNBl?=
 =?us-ascii?Q?cx7dExoVr7jA+W07ntUZdWHqFwYVR2dkCxIavgc0y4l5UnBiW9Ge3Lgjg4gE?=
 =?us-ascii?Q?tZhyidZckojpNtAG7dLFhCCsDIbWt3foOBhFQ6byoIF/bjXzaG3fXNDjVea8?=
 =?us-ascii?Q?i2lu2SiA1Y6mwwfsNVd9tyC0d8PUA4AxfQG1hGVpOMFxh5siwbDahq+JhKFb?=
 =?us-ascii?Q?VQP6Hf3GdHgOV/fr/SZ8uhsOcrJKVY9s97rihv/YPVNgfUEohclku05HQXQI?=
 =?us-ascii?Q?v2m/HB8wpVWgNQMzgUc1VdvKvs/TjZtwSyVvsQR4D/s1L8Q9m+qKHgoAaw8C?=
 =?us-ascii?Q?FW5hk/y2xiscs4xB0lR1KtCFOG68oMLA8ZOiJ3HQUUWwrXWnuv/B+uzjYEJY?=
 =?us-ascii?Q?6vjD7+hStuzMStni/3DRD24kvpF7hhmXRxCBHckb5rQwbjvbkYn+WbBDg1C5?=
 =?us-ascii?Q?cDAC8HK5k/itarxY+fs0OeSbniq6dmnBqaERn8ze5BOP+T+PbEfOCzjDFZlb?=
 =?us-ascii?Q?cpEYR72j++X39WTh4ixHuQRcRDivVHnfTeHcMWCl89STyNqoGUz94Z3WHkw+?=
 =?us-ascii?Q?m0+KOaUTzIQOL5zT7NU70DrnyMlZox8S5q+R6yPjKuTnH0Vdd6yWpJIdvVGq?=
 =?us-ascii?Q?w5fGm9bCBBGk9RMkZH9h/WkLijZPRx9XWlW7W607os2pew15Drw5FGN11T2s?=
 =?us-ascii?Q?mh5XVBmiX0FtTaHp/x+bG2rJ7h7hvg+YMOK8I3euupat/wqtQp1rFbSsVzpB?=
 =?us-ascii?Q?MuGAGBWud/9UK0ayYNcGDkwUDnT48+xIKDK291gwqFTjPq+rHEOiM+LTzept?=
 =?us-ascii?Q?V27wg148BywvK3ORuBLAxA3UHkpAhzZphGF17Ty+qIlYzVZKwmB91eyto9t3?=
 =?us-ascii?Q?aCz/Qyc0RqrCc4Qr+lXB46WVn03bIXPw3H7JPXyR7Q5TJGAVwNz9yZkZjraL?=
 =?us-ascii?Q?8/Z2QI8MCvb9tZpsrj1rrvCcowV34XKHkd+df4XbxPlFARNoNImVoXXbvdm9?=
 =?us-ascii?Q?XAQned+4kjfbqrbLXP5+iBr3I7ppUqMkhe+ZGiOKDhD6ejXfFsuDplYRg0Ba?=
 =?us-ascii?Q?IQHyQmBdD9DNAXcMtcUxO4vAaVYH26EGhiiYwjKdq3QVQZDMLP5q/5fA7QDP?=
 =?us-ascii?Q?K8X2zvGyNh0RMx5d/FowV8tsyknvIMEK7R796cBcMHAa0oe3DprWCGdzBjXc?=
 =?us-ascii?Q?2JHftIqOormGqtOlpzljrJfwrkCDSOZUuinQGPcWa5M3zR/1xcCDF3et6FIL?=
 =?us-ascii?Q?CaAyattvEsDFgBV+xLyDLn7Ub5o3FJxbmhikrGN+5jzfV+g/wA/6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a6868-d4a4-452a-9d0f-08dee4055039
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:20.8294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JSf2MLhO9xJdPySNPYvQHnjWvb1Nzal34e6pot1uTXziHI9bismGBVQBVzhk3t1FI4G3EcR9yUtIAulcKnOsMlP6A5iU9V9n7KvwZ8xLRbdPFcwLJj06vMG8KsOdBpm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23650

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6071d10413ff8489c3e842b19b1e0d539700068d upstream.

Introduce I3C support by defining I3C accessors for regmap and
implementing an I3C driver. Enable I3C for the NXP P3T1755.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241220093635.11218-1-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/Kconfig |   2 +
 drivers/hwmon/lm75.c  | 121 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index da55b19f244f..c87ca5261bb2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1277,7 +1277,9 @@ config SENSORS_LM73
 config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
 	depends on I2C
+	depends on I3C || !I3C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for one common type of
 	  temperature sensor chip, with models including:
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index d96497202ac0..f755ed62c112 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/of_device.h>
@@ -113,6 +114,8 @@ struct lm75_data {
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
 	const struct lm75_params	*params;
+	u8				reg_buf[1];
+	u8				val_buf[3];
 };
=20
 /*-----------------------------------------------------------------------*=
/
@@ -607,6 +610,77 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
 {
 	.reg_write =3D lm75_i2c_reg_write,
 };
=20
+static int lm75_i3c_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
+{
+	struct i3c_device *i3cdev =3D context;
+	struct lm75_data *data =3D i3cdev_get_drvdata(i3cdev);
+	struct i3c_priv_xfer xfers[] =3D {
+		{
+			.rnw =3D false,
+			.len =3D 1,
+			.data.out =3D data->reg_buf,
+		},
+		{
+			.rnw =3D true,
+			.len =3D 2,
+			.data.out =3D data->val_buf,
+		},
+	};
+	int ret;
+
+	data->reg_buf[0] =3D reg;
+
+	if (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)
+		xfers[1].len--;
+
+	ret =3D i3c_device_do_priv_xfers(i3cdev, xfers, 2);
+	if (ret < 0)
+		return ret;
+
+	if (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)
+		*val =3D data->val_buf[0];
+	else if (reg =3D=3D LM75_REG_CONF)
+		*val =3D data->val_buf[0] | (data->val_buf[1] << 8);
+	else
+		*val =3D data->val_buf[1] | (data->val_buf[0] << 8);
+
+	return 0;
+}
+
+static int lm75_i3c_reg_write(void *context, unsigned int reg, unsigned in=
t val)
+{
+	struct i3c_device *i3cdev =3D context;
+	struct lm75_data *data =3D i3cdev_get_drvdata(i3cdev);
+	struct i3c_priv_xfer xfers[] =3D {
+		{
+			.rnw =3D false,
+			.len =3D 3,
+			.data.out =3D data->val_buf,
+		},
+	};
+
+	data->val_buf[0] =3D reg;
+
+	if (reg =3D=3D PCT2075_REG_IDLE ||
+	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits)) {
+		xfers[0].len--;
+		data->val_buf[1] =3D val & 0xff;
+	} else if (reg =3D=3D LM75_REG_CONF) {
+		data->val_buf[1] =3D val & 0xff;
+		data->val_buf[2] =3D (val >> 8) & 0xff;
+	} else {
+		data->val_buf[1] =3D (val >> 8) & 0xff;
+		data->val_buf[2] =3D val & 0xff;
+	}
+
+	return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
+}
+
+static const struct regmap_bus lm75_i3c_regmap_bus =3D {
+	.reg_read =3D lm75_i3c_reg_read,
+	.reg_write =3D lm75_i3c_reg_write,
+};
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -627,7 +701,7 @@ static void lm75_remove(void *data)
 }
=20
 static int lm75_generic_probe(struct device *dev, const char *name,
-			      const void *kind_ptr, int irq, struct regmap *regmap)
+			      enum lm75_type kind, int irq, struct regmap *regmap)
 {
 	struct device *hwmon_dev;
 	struct lm75_data *data;
@@ -640,7 +714,7 @@ static int lm75_generic_probe(struct device *dev, const=
 char *name,
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->kind =3D (uintptr_t)kind_ptr;
+	data->kind =3D kind;
 	data->regmap =3D regmap;
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
@@ -712,7 +786,7 @@ static int lm75_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
=20
-	return lm75_generic_probe(dev, client->name, i2c_get_match_data(client),
+	return lm75_generic_probe(dev, client->name, (uintptr_t)i2c_get_match_dat=
a(client),
 				  client->irq, regmap);
 }
=20
@@ -751,6 +825,37 @@ static const struct i2c_device_id lm75_i2c_ids[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, lm75_i2c_ids);
=20
+struct lm75_i3c_device {
+	enum lm75_type type;
+	const char *name;
+};
+
+static const struct lm75_i3c_device lm75_i3c_p3t1755 =3D {
+	.name =3D "p3t1755",
+	.type =3D p3t1755,
+};
+
+static const struct i3c_device_id lm75_i3c_ids[] =3D {
+	I3C_DEVICE(0x011b, 0x152a, &lm75_i3c_p3t1755),
+	{ /* LIST END */ }
+};
+MODULE_DEVICE_TABLE(i3c, lm75_i3c_ids);
+
+static int lm75_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct device *dev =3D i3cdev_to_dev(i3cdev);
+	const struct lm75_i3c_device *id_data;
+	struct regmap *regmap;
+
+	regmap =3D devm_regmap_init(dev, &lm75_i3c_regmap_bus, i3cdev, &lm75_regm=
ap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	id_data =3D i3c_device_match_id(i3cdev, lm75_i3c_ids)->data;
+
+	return lm75_generic_probe(dev, id_data->name, id_data->type, 0, regmap);
+}
+
 static const struct of_device_id __maybe_unused lm75_of_match[] =3D {
 	{
 		.compatible =3D "adi,adt75",
@@ -1009,7 +1114,15 @@ static struct i2c_driver lm75_i2c_driver =3D {
 	.address_list	=3D normal_i2c,
 };
=20
-module_i2c_driver(lm75_i2c_driver);
+static struct i3c_driver lm75_i3c_driver =3D {
+	.driver =3D {
+		.name =3D "lm75_i3c",
+	},
+	.probe =3D lm75_i3c_probe,
+	.id_table =3D lm75_i3c_ids,
+};
+
+module_i3c_i2c_driver(lm75_i3c_driver, &lm75_i2c_driver)
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("LM75 driver");
--=20
2.54.0


