Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA17C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13342.1784294164396030479
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:16:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DBNSImA4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yamaZwYrfE1s66zCO1gCAM0AthajMb7jIl55hKrQeKPQloXrYUbDu7Z/7r9Fqc4Z0M5qRlKIWusUNWs82nOCpfJb69ELhuR/ayDnVqd7WB864QbdZrgfi5pRQRYuEa0iHkZNGHKQSImk/DeTu1G5htujmlmmX4LXHwlD0yzv3xF3uOJyfeMuZ7ij59KYVudWfR24Lr4hzOgF2PPPH2S0pQvu4ggq/YA1CvvPzxiWl8FvIbAGANHAWJr588O4MZbFhvEotZeRhRYelQUfKw2AZDOqZGX6oQQxU2ee2gLkF3XslM/Ki0ttV48p9ryMnPdyqdULNI+FtrNdFZVOoNXPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lR9cIJllQxR02klQBL+xuUwaRUbJs4eUHNUiIgJkhI=;
 b=UXrbrjc8dgfZ+jnZH2pRmcoMGl3ta8P9LWUy+SSIqB3iPxseq/17tlRlOl9TKO6pePw+X+sSTaZF6WomB+IiVGT7pEiHl21nHxNzGiIzumxImF1wyNiM+xRvJGQhHSoeMyxEuuOsA76V1xexiRE9bLMrAvrnLb+ugHrvn3Lw7uTvj6WEdw2uad2P0AILH3Xog0WSUEAXjlME1P5jmSMgN5AB4ZNEQd0o7NDA/d6IZEpO3IrIXy21KH1L0yLmiAa8lvUi645fZtQbY+YcaMq+rqFgO79LkDVcr1oHT2qHvGl0ItnxSS1p9t0l5VPJ2jJHdqHSRddixfU6eBwhQZTCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lR9cIJllQxR02klQBL+xuUwaRUbJs4eUHNUiIgJkhI=;
 b=DBNSImA4Z0iwEq8SGqbdXbDexS3U3h/D816aMmipqzx/sBgdHPKamT0JQxEr5UoGmbThBwgH6v9jdzSqIWlxpZbzPYNIT2XP0GmhVbVBt1TG4rEwQFyIb7uqrRD+Qa/WCN4iUlz3y6EFiBh6yXV6l3tueVBL0PEWPJH88uCFZOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:16:02 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:16:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/15] hwmon: (lm75) separate probe into common and I2C parts
Date: Fri, 17 Jul 2026 15:15:00 +0200
Message-ID: <20260717131502.2234020-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7df98d2-e674-4920-83fe-08dee4058ca9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	qdUFqzXL2jLrNFZrI0elwem7oRclw7uTsoUn6TbsT6JedflhVGUIrg9NAgytIiZb3m0LE8Tka5KhPguExqKnbMBuKLRmBmRcJfgmEC+rjycqNAWe0cUa9M0XQNhzf5fDwITyiEYav5zGMk5m49TDalFuM+q0KhVwptgf8sAhy8yXxciCOCx0pv2AF7p9ImMa/Hne8V5vCZUyzaInKxfpksTKwg74jrRZit3Tl5jGhfCWecQb9FgdLmxRUVGnzTwwZuL6XZBGJZcncPo6dmMhcG0aJs03MwxHag3Nk3xlKBPQtl5h4xgZMFH2lkXO3D1zy++qC5N3yZjd3O5rIbwuaSvXDgk5kTqGIRR8iszIxT7wZM06lKDUbtDF/P+AjP5zY5XYy1EMCk+T2/mBGVTbGDExbjoZhQx0WHeuIvdZpWsozZfLCkDDjMZhfSQrLbwljfNrElUZcbIq+gtkXJMuJAPn+CRl4uwiqJWOLMp1PwdOoVbinqdjcbLNLslWW/nG44V7N/sLEizsSRV5jzJ71m0E+9CLpzDOapDX5Zg3skJrih/jkNjCd9l2wWQv2G11dY9AY6vkW4VBjP7lJtRkwQO+ha2rUQ/eE2OOxgarT8uXgaylw8Yz9eKx04rnLe3+uIH69oy/++U1aiBfGNBuBrn0WBc8eWCiUA103tX14CKz9nOpbLPvKyAEmNcJJuVEd0KMvZMXJr7KGvXMNRu6QKj2GYVc+AlwZIRnkuvGSjI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mDR0ps1P8xS3qKCg9joP/rdDnnghkNNS8PdW73+ZW6uwLyv6H3QDR/exOYIS?=
 =?us-ascii?Q?HIJhUHuhPc1tvCiEhQ6zrtOOopytD3nsODnTte5TH/v0Mw7OjM2HLwbVHEZZ?=
 =?us-ascii?Q?ewE+ntoPB/KU9CjProsfYPf96iRiueGJNICgHKXGWop2bWBPBVCz5ET04wpx?=
 =?us-ascii?Q?THyJerXUg/dP8y9IVyMgm2KKygy7IaPJtmhmTRHTKhKJjm1ZdMQ6yx+ENJax?=
 =?us-ascii?Q?kvYRkuDffvF/TnN2SQc2SEc0FRbi6O1+RWux3vlTd1s0iAt5mm01RRFyBNpO?=
 =?us-ascii?Q?/RFKneXrpPqQOk6WJ32RhLmNZ3mnv/ImdSvus/FMr2oNw/Fyh1NL3mY7PuQY?=
 =?us-ascii?Q?mFSE7eXaOCiqpZ+7EQTAKstZqI9vJmlhmAGBei7NwNhm1XNM8suhvSn+ro0h?=
 =?us-ascii?Q?QXcWGraGQx++xyn6XaDtW2Ph++DE+G/vU5s3SokCwvCv8dnTjRPnU7hfCHt2?=
 =?us-ascii?Q?ZBLEQMp1WnJo/pDdOECHrVVILWmIN/6iWStZFX3e3JKGEhX5Pv/IHRy+6nAh?=
 =?us-ascii?Q?O3InC3ajrWYwTnwUS3Q/3Uyf17zxHCIj6yqefM1Zf7nXqCSY65SxX+6mdSuW?=
 =?us-ascii?Q?lbQeAJKhX2Ny8Lt0sNG7Oyq6SCX8W4vaKuyfM0H3k7cMN4QkfEFZXT5ylnxB?=
 =?us-ascii?Q?ksxfj+UEgY4D8NlIrlZIvFfXjCKixkwRfxCxAJLhfJa4RrVMUxynrf6fT84w?=
 =?us-ascii?Q?8UphWKBQW92oR9YE5psCR7ZwwhYvAW+T6xVVpxaR5prMr152rg88qcVekQUQ?=
 =?us-ascii?Q?eDRWpdktfCkmGxVrCi/b9n/tMsSsmCM7a8vuZL01sBjJMCaIzG0FjKtyhMRK?=
 =?us-ascii?Q?xs2Iina7PIk/CBHLHGNqA04B+t2k6pSXt1TF1sPmOoQnUFFjQoN8tj9aywS2?=
 =?us-ascii?Q?H99s7gwTa3AotLOXYmf6emsq9BWKUkbSeYiWnJLS8dKJKuphSugdBz70cIew?=
 =?us-ascii?Q?YY8NjK1gZ0oo0INYg4ZAvkBOIWDvyiALhPz9Fid9cIWNkkMlSHlsFuKR/R4S?=
 =?us-ascii?Q?6/Vpjyh9Jz8MNpyL7XU4nHKLDghHs1xk3pnOZg1whowLD1OS9RJq/2QFJ/U8?=
 =?us-ascii?Q?cN2b+wOJaYPrvVlc2eMIo5h9nG5lHLl8nenJVfVchs6E5BCoxBsN5f8UFPXI?=
 =?us-ascii?Q?XoOiZ38XV7Vc9Zo8oe+bfP5Xa9J2K8JVSSCMwk/fqfIiqhZ4eC/h34nwZ92R?=
 =?us-ascii?Q?jI9YoGA/IDNd5PvEb80v+bnhA+9PwpopaS1kWcKbe+wAQujTzIpoUTCVosMj?=
 =?us-ascii?Q?Vvcppdrrhpl3/AmF+NRWNf7dmumt5i6I7vS3mHYpVJc4REchstUC7WQoTmJ3?=
 =?us-ascii?Q?1EUXYOVJrtCPIsqNgehDRTUCjTy2LeATJXOIS7Dkcmec1hil2UAyC/qTFzkN?=
 =?us-ascii?Q?tsqgnPfmhDRmVAS1hOA7LjX4PMgMjmRoDM4vhy+Jr7NgwsfoHXkTKr97t13i?=
 =?us-ascii?Q?cjTsI/2I9ITzy/LGgi/gfp/SjBdHvXUTfNA+HiqttzbOzJcSCAMaKkgiRj5a?=
 =?us-ascii?Q?FB4bjGyxo4Hfo+VmE+HpaGgfakjin3gi4Io3V7BYEJUtkHHnwkmPD/YH2H31?=
 =?us-ascii?Q?TK8E3xDwr5WFsXZ4pAMHMn0y3v1SkhNzwR039Wqn1kV6Ya8jdoeSDleZQSmO?=
 =?us-ascii?Q?22Wm3K8l3Zz3Op8AoVdO1PsqqFBE8lPkZ5hSoUJ1pFENEcCKywFyaWA0xF5T?=
 =?us-ascii?Q?Bojq7RohiafCww14efoT+dNQz2zpNoygqvYu/cyNb43MCgz53Dff9wBKueeJ?=
 =?us-ascii?Q?l+EM5WxS6FefZwJm860osDluldDzYbM4/cjqF3qt5tt34ztKz/vr?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7df98d2-e674-4920-83fe-08dee4058ca9
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:16:01.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkacl+vdBp8lkWVNEnN4j1B3PsTg5WnHLbJId5exfV1P2VtZXRQ+UGrrfWMp01T/zwqr1wUGSAl4WuySyE2HfcgNq3HB8EK7C/rkpGGC+yRR+m6Gx5kAKOzPvHPeja80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23665

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc96dc1a1cdad999ccd84a7ea6d5e0926c26d8ce upstream.

Put generic probe functionality into a separate function and let the I2C
driver call it. This is a preparation for adding I3C support which will
also use the generic probe function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241219225522.3490-11-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 0f034110daed..8b4f324524da 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -601,6 +601,11 @@ static int lm75_i2c_reg_write(void *context, unsigned =
int reg, unsigned int val)
 	return i2c_smbus_write_word_swapped(client, reg, val);
 }
=20
+static const struct regmap_bus lm75_i2c_regmap_bus =3D {
+	.reg_read =3D lm75_i2c_reg_read,
+	.reg_write =3D lm75_i2c_reg_write,
+};
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -613,11 +618,6 @@ static const struct regmap_config lm75_regmap_config =
=3D {
 	.use_single_write =3D true,
 };
=20
-static const struct regmap_bus lm75_i2c_regmap_bus =3D {
-	.reg_read =3D lm75_i2c_reg_read,
-	.reg_write =3D lm75_i2c_reg_write,
-};
-
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -625,17 +625,13 @@ static void lm75_remove(void *data)
 	regmap_write(lm75->regmap, LM75_REG_CONF, lm75->orig_conf);
 }
=20
-static int lm75_probe(struct i2c_client *client)
+static int lm75_generic_probe(struct device *dev, const char *name,
+			      const void *kind_ptr, int irq, struct regmap *regmap)
 {
-	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct lm75_data *data;
 	int status, err;
=20
-	if (!i2c_check_functionality(client->adapter,
-			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
-		return -EIO;
-
 	data =3D devm_kzalloc(dev, sizeof(struct lm75_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -643,17 +639,13 @@ static int lm75_probe(struct i2c_client *client)
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->kind =3D (uintptr_t)i2c_get_match_data(client);
+	data->kind =3D (uintptr_t)kind_ptr;
+	data->regmap =3D regmap;
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
 	if (err)
 		return err;
=20
-	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client,
-					&lm75_regmap_config);
-	if (IS_ERR(data->regmap))
-		return PTR_ERR(data->regmap);
-
 	/* Set to LM75 resolution (9 bits, 1/2 degree C) and range.
 	 * Then tweak to be more precise when appropriate.
 	 */
@@ -679,20 +671,19 @@ static int lm75_probe(struct i2c_client *client)
 	if (err)
 		return err;
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
-							 data, &lm75_chip_info,
-							 NULL);
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, name, data,
+							 &lm75_chip_info, NULL);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
=20
-	if (client->irq) {
+	if (irq) {
 		if (data->params->alarm) {
 			err =3D devm_request_threaded_irq(dev,
-							client->irq,
+							irq,
 							NULL,
 							&lm75_alarm_handler,
 							IRQF_ONESHOT,
-							client->name,
+							name,
 							hwmon_dev);
 			if (err)
 				return err;
@@ -702,12 +693,29 @@ static int lm75_probe(struct i2c_client *client)
 		}
 	}
=20
-	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
+	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), name);
=20
 	return 0;
 }
=20
-static const struct i2c_device_id lm75_ids[] =3D {
+static int lm75_i2c_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -EOPNOTSUPP;
+
+	regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client, &lm75_regm=
ap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return lm75_generic_probe(dev, client->name, i2c_get_match_data(client),
+				  client->irq, regmap);
+}
+
+static const struct i2c_device_id lm75_i2c_ids[] =3D {
 	{ "adt75", adt75, },
 	{ "as6200", as6200, },
 	{ "at30ts74", at30ts74, },
@@ -740,7 +748,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "tmp1075", tmp1075, },
 	{ /* LIST END */ }
 };
-MODULE_DEVICE_TABLE(i2c, lm75_ids);
+MODULE_DEVICE_TABLE(i2c, lm75_i2c_ids);
=20
 static const struct of_device_id __maybe_unused lm75_of_match[] =3D {
 	{
@@ -987,20 +995,20 @@ static const struct dev_pm_ops lm75_dev_pm_ops =3D {
 #define LM75_DEV_PM_OPS NULL
 #endif /* CONFIG_PM */
=20
-static struct i2c_driver lm75_driver =3D {
+static struct i2c_driver lm75_i2c_driver =3D {
 	.class		=3D I2C_CLASS_HWMON,
 	.driver =3D {
 		.name	=3D "lm75",
 		.of_match_table =3D of_match_ptr(lm75_of_match),
 		.pm	=3D LM75_DEV_PM_OPS,
 	},
-	.probe		=3D lm75_probe,
-	.id_table	=3D lm75_ids,
+	.probe		=3D lm75_i2c_probe,
+	.id_table	=3D lm75_i2c_ids,
 	.detect		=3D lm75_detect,
 	.address_list	=3D normal_i2c,
 };
=20
-module_i2c_driver(lm75_driver);
+module_i2c_driver(lm75_i2c_driver);
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("LM75 driver");
--=20
2.54.0


