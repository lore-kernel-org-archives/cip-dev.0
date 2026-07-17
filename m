Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F2C44521
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13223.1784294169300438317
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:16:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XRpKgf7n;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.56, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OojQNtffI/GbXLvvtPBVxFuqeFqhRvNI9cHqWOfIWeooiV2W2JqNSFvzpvLER8mn2imd4scMfXtWeHPgSs93wiUKpYqHn/VJmJFasp0qnRlF1ROitAk+mRBYUthNNYVDW7nnQYrggn69wpzacGHL4dvFmy1rmUg2OMqIXMdv/evisOjhu/biq0QmcYL6drHeLGpaxyugLTrdIHtI1/LZuFqpET5Iaov54cjYyU4wRYAEfNKXcdRxSlIJrPV/f2JOMYlIMVWMWAPO0FO9+Amj0lXl0E+z0oNgl/mnLK374uGlT6IXBdPSvb/CDB4YRohhLHwM/Ufd0CD8BJ+OSmumAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZVJfsiIm8h4FZgOPa0J+S4yKg7SIjfiR/h0GpV/rFA=;
 b=y51/+LWjx0ui8W7W8SDpFBfSYLOKbFxhfklA1TsclcWtDuaVxDrYTaquudQy5P+J4NjGUNbkGsBek/zmi0J9jpSP1CBh+W7oGsnb+TiOl0hGEENRnF30G2KQYlu/ZGK2y3Lb4g7LkhVeLtx1nvpbgbIDYgDKR0jJgfOe2zOkYGyRwf262iDhjIKwR55FA/2KDM3B1O5kW+Ea+la4EMIU/+9jf9eJ99EA1YDkOrEuD3ImWSGfyl6uO0LyfybhgTK8m+xCtr74l25WghDhwEUBgGo/7DRCKqeq/7PNAi9VXhGKvW86k8Wi6Juq5iNCZJJd2HksYxiNK307uvsw7SRlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZVJfsiIm8h4FZgOPa0J+S4yKg7SIjfiR/h0GpV/rFA=;
 b=XRpKgf7n3GTXv1S79tZ0hoVow6aGIeJUvzTSU0b6yRDo37lse0nKuaYjlMPfOwOwTHcTQc42keDDgJb1Lh8KFhZTzDtRKIKjWOzFVt72aPlq9WA9fUJPW3Bnn7mWgdEqYNk6GlQAZ+18pWtcZCm0fLmJY7CPV0dI6GoDkDq9F7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OSOPR01MB12459.jpnprd01.prod.outlook.com (2603:1096:604:2de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:16:05 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:16:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/15] hwmon: (lm75) add I3C support for P3T1755
Date: Fri, 17 Jul 2026 15:15:01 +0200
Message-ID: <20260717131502.2234020-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OSOPR01MB12459:EE_
X-MS-Office365-Filtering-Correlation-Id: c134eafa-11a9-4386-6364-08dee4058e52
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|10067099003|38350700014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	G+D1P4XQ3l8KLK4ARhK1TxqmtMQpYg1TMql2UT3iWDgWVOZoXXKJm7txwvZpjC7UsPoauQ0tei1XoMFAlvHlEkddcOBLAHjfeqDXUpP0MrqLduHa4SjFSYq0ucHHOzJWe5VselUmDnAXHIt6OqrnpA7JjRd2uxOLOqZyKAQ3q7fu/nAEWxm8UIiY+RKC5mylNpOVCYWI6Dgnfy5PZBPhy4D+56V/nEEoESZxu3xoe37CGPTZrelAD288PlSI3EOn46GpOPuCkgA6xspCoylhMzPYbNThGPzItFlv+T0CdKR9bhjmCS7ENmVGeLiuZFXXwhxsjf2q7ZhRlrGer796H9cHV1INCo+3E4NmojRLTCc5u9dQRLb2+4UF3yEaIXJFj+4nrj3ncP/IUstu1VvLHxU4cRiu5UycqDkg8ACdqM24GtEwd/a20wcMd2GRylsUBTMFocl1rfpgg95SRF38Hdim6+w2kzlttkfIXz7o2DWGzQWN2cy+TmlW7bpbeEEdouCpVZrURWSjcfCssxE9pma7xeQWegX48CTDjvaAoAeMnwnbNovKxgS7er0xv3tmbPEG3dG3JMTZrR6u7NXrM2NfCqB53u0mFtL/VNBrUR+yCeWdmkeHDG16ktTD1xe3n47NuCwOzoNiTcloE7uwNEKNgBSciw8DJIqE78i537X+7/gxZGL0I0mIuDSO3ik2gkMFcuZJ1c1GKl9wH2PnUW2SZRSU+2Qk7bGZMyZjKWk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(10067099003)(38350700014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tPsxjSzMMNtMrM7i0JoChJgBXa/Y3XxiUyRPXpTpFJS5ERmlAvineDNBJru0?=
 =?us-ascii?Q?UYmGaqBfvaudWnvlngScEwJ0ejC4G1tJ2T7IQX+uWJLlrU719gboH+4DTign?=
 =?us-ascii?Q?vO+ztioYDwFCZ/e8/eLscbkYWFIB2I9nMN9nifd2Hoy7529gQ3NkgCUGBUyj?=
 =?us-ascii?Q?6AP5HsIFW2n1jSPHhHWWNEPJc80HV1rnYvzDJVlLiYrMK4JXJ6gXz82DqdZU?=
 =?us-ascii?Q?5zwwzj9+EoujYld/1/CXvjLXjTqVSuJ9SH/3sNq+pa8M7C/RkgwQQmqsK6lk?=
 =?us-ascii?Q?hk8RPCKiy5uHPrcz8A0Sdq2NgmAhslJPd+3XOgGr+jwSx+f4n7rn/biBxcih?=
 =?us-ascii?Q?OqeokooOK2XYeQJOyuMq3bHn/ApdbhMq5wnvuS8evzO9+M0aZkBP0JqhtbRC?=
 =?us-ascii?Q?yALn8pQ4XkeTqAPLdK2/+UZM5zVPyej2wjf9T71c6lNxZr9q0xv3kPw9lyfb?=
 =?us-ascii?Q?app9ADzcsKpSmMvrZ64kPJbqZdxWVymFq/asZVhR4mhdVUb+H6MmBMXY227a?=
 =?us-ascii?Q?RdD4JVKcbPh7qgKxAyzeLH1BjOaphThaAbNboy1Lj14CAtKIFNHHdAqfAfW0?=
 =?us-ascii?Q?xjQllV2V8WZIxxJHXMvLNoHxPcG+M18yzoA+OKEh+LZXT0KZqZ0HLVkVPsvv?=
 =?us-ascii?Q?0efcqClcz03gx6wwUp4JJGOI0tVsrhPidlOYQGqe1+qZ6Ii/PHkaa8wqk7gp?=
 =?us-ascii?Q?8dVDDOm7znIZ6Cjhm4IY85YoKds2epqtvch/xvl5hSH9ZT0Usll8L5WpzRsW?=
 =?us-ascii?Q?tSoWRrrcYtTozgQ5dklvveBJYMLGHciQidBgkYM+rCnAIXSGRhqbrOJ65iDj?=
 =?us-ascii?Q?JBSDm+Eb+weQnKfb1EbmJjt+oo3TzuQOaOmi54q+7k4SJfieiwNQ+NvsgoQo?=
 =?us-ascii?Q?luE1tCB5yU0OGRMaPsuS/Dd/RYzl9oyrDuoyRXCybYGlXXXALhu9Yp4NWAQf?=
 =?us-ascii?Q?EmASF4L9YQDSrcOmDNvKhGJvwWYjknt8nGZfdVKNqnGMlUy0O7Jl4ZSykBEm?=
 =?us-ascii?Q?DSDZiSSr9d7lrZL6fc8AtxUYldjpj4cWYsjCJaDfP6GnnpcSGTN59r/fvCZI?=
 =?us-ascii?Q?xsl4p1+CPsJmV+UXZIwDzc5pcPDg+BiS6UkO/kYxdVgYx+kQjZXQ4hBnacqe?=
 =?us-ascii?Q?wQXHm2Pighr7mutbMFjGukwc//Q1zP4KppSFqLZo838kJIqblg6lEH7QuQ5l?=
 =?us-ascii?Q?pyijrfG69Xv6qKMYR3tl23Z495PZsN3QfI6D8CN8tDeMo6L/lR4kgF/6XeJn?=
 =?us-ascii?Q?awZ/3/J25aW/mzsW4JUy4vsf+/BR0FAQG39IhJ+tAQlRmRAJ8BCi3+hoP2dd?=
 =?us-ascii?Q?rRZtR5pZHeP0x/dWDWnkfftzKnukfpF/N8sa5t01EJp649JENw8MlivG4xcW?=
 =?us-ascii?Q?GzEKEt7mr4F8ScXq/CtKubH7m3LA8l8b1k+YhglTnC2lTh9g6lE9nAZxeIvV?=
 =?us-ascii?Q?JIecdaWrNVFutI3NIe8TGCOJ1e9FZBHEWq4jpmP9UHe3Hh0XkqqMxz0aJ2l3?=
 =?us-ascii?Q?sJnQi+Z7IAwWA0IZvca34H3oMbJ/q5HZeBVHRGV9JBhzHDwA1GjCV1NovFSh?=
 =?us-ascii?Q?KhJnyagpUgbQVPXbGL0KYYRvyGutWDg19T5JIfqQXioD+5v0xO2Z9AQz4wMT?=
 =?us-ascii?Q?mhHV7qMZ/N6lVZiy3oH52yVxd0glvnTyR4CW/2du/+pwr7k5M8457MX53uYb?=
 =?us-ascii?Q?2CwAxXZ9qE5GTSlc3zFYTsIItcwu+Ibbqhdr7HGN0ttreIzxzLeWPUyHj0h0?=
 =?us-ascii?Q?v+DJ+HkFpzMGaEJHUkQD/My/eBgOwhu7QOt0OstP3zjZVVN85azo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c134eafa-11a9-4386-6364-08dee4058e52
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:16:05.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BYHHSrigPX2zo6dLWEt2OvA/WhbhOoYegygP3x2KXRGCgkluvuiZHXSH1AMsRNTsi+7RjF3vrBQw/aW+AoF+uDcaF01MO0oljCwJZENQ4qUJtgqf+9odF9BB87ANalh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23666

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
index c757d0dd546b..f26697eba53d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1401,7 +1401,9 @@ config SENSORS_LM73
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
index 8b4f324524da..d95a3c6c245c 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
+#include <linux/i3c/device.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
 #include <linux/of.h>
@@ -112,6 +113,8 @@ struct lm75_data {
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
 	const struct lm75_params	*params;
+	u8				reg_buf[1];
+	u8				val_buf[3];
 };
=20
 /*-----------------------------------------------------------------------*=
/
@@ -606,6 +609,77 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
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
@@ -626,7 +700,7 @@ static void lm75_remove(void *data)
 }
=20
 static int lm75_generic_probe(struct device *dev, const char *name,
-			      const void *kind_ptr, int irq, struct regmap *regmap)
+			      enum lm75_type kind, int irq, struct regmap *regmap)
 {
 	struct device *hwmon_dev;
 	struct lm75_data *data;
@@ -639,7 +713,7 @@ static int lm75_generic_probe(struct device *dev, const=
 char *name,
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->kind =3D (uintptr_t)kind_ptr;
+	data->kind =3D kind;
 	data->regmap =3D regmap;
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
@@ -711,7 +785,7 @@ static int lm75_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
=20
-	return lm75_generic_probe(dev, client->name, i2c_get_match_data(client),
+	return lm75_generic_probe(dev, client->name, (uintptr_t)i2c_get_match_dat=
a(client),
 				  client->irq, regmap);
 }
=20
@@ -750,6 +824,37 @@ static const struct i2c_device_id lm75_i2c_ids[] =3D {
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
@@ -1008,7 +1113,15 @@ static struct i2c_driver lm75_i2c_driver =3D {
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


