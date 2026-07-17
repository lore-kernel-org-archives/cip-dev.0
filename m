Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE59C44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:30 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13165.1784294059855765321
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WgvwBZMB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3RzZrGoWyYsEkEnYpU9bLxzlDiDXJE/ADZ7aFRG2RP9XvgcS8/vgOAufgBXjo9d9n0M+GN8FaNTls8UuNWTWYYTMmXaHh/S3ZtUrdERoFFm0IVQ+HmDTA4UWLUbbiVlrhlX2V3CTED/R+3NPOzoLplyD37esHOQ58JdAPP9NZcDX3nMjgsFDDB6ZhHNEesaZxg2qNA5MAXD4LGkrQRWpVoOcE2Ny2VjfwnaMIcuK/Qp0vo3YEYoA9a8tIbB8rPttDkt93N7zpAIdmg8Kabx0cMkHeYsV+sryPtVFISnDffiqN6KdDdwCTJJsVgicYlViF+HPpdf7WLyxPB63SDpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsfIUFEgGSktO5Z/7w6uCn3ZOLVPTxmN5CNVHnSaYe8=;
 b=h9mByskjFEJvS+p+E+UatTmVSNt5leOJ8BBt1XF/batoYaKA9TOgTf6WFi+mS/9u2n/JGUnYPilvh5+gZ1L1fM1H+xuAcSwwVBrKdLdRsKdzzNgkv1uCVnohEyrIBuisBHvQHwJidOvlIqsVQHtsM+/JvtVL0WTcoG5SqSLTBr9ch+sfS5r08quuLHqcZO7JU3l5HbRlt+8xuTynpLltnBo9Io2KgnvHpERVVz4j6CUg7oqYOzF5Y3WJ3QVspdMZQ0ES9JZmshVxbNWoKJK0y6BDFFT5+vD9aC2TU0dS7PSmKFnRzQ17LrCQDuLaFwvYBfn67iv6Titcjya1Hj95WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsfIUFEgGSktO5Z/7w6uCn3ZOLVPTxmN5CNVHnSaYe8=;
 b=WgvwBZMBTbf2ewV6GntiaSKr1vOsJahAR+ZADWgap/U+B6l0WgH5RfmKypKZX22XLnXc0v5e3NHI/HBXHcjDmKEc92bMembpoNa+gNMzp4xjkd4YoFCDknA+gj40d7p0hvzIA5GkQMoCBW7OGzLXlBRtgBjQaZw2Syb570S6Ogk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:17 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/23] hwmon: (lm75) separate probe into common and I2C parts
Date: Fri, 17 Jul 2026 15:12:39 +0200
Message-ID: <20260717131241.2233788-22-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1d27fee-cd6c-48c5-5b06-08dee4054e73
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	wMiH+EWoOaJMDGfGb008VIe7Z0F7jrCMOTPuml9gxWxaki7dvngXp6nBRp1DxYpJa2BF23DpHgmE35xnUCwwHEzDnDhZLxd6Ty1Z6t0ygQ7EzgAI0SELDk7y8VQeLT0ixBMTuGPkXs1SVKPfHrvkcP5PJPscW6WKRpwpExm1bw0uEIR6GzeUJsIvcvG8Yjf9EqwUd26BsJnS9kNWxsmsoVySLqmcCw8K0RdqWTR1R6bjmpB4m5TD9Wy7KJ7ZvoDvxduk+RAEZChNadG6QgEQs9+gqOOKzgxLWAmuzbBPDLZp66wYr8elYN1W2I9ErGxn/6a10UWK7T4mJEOhHlzB62YUxuYWWiK2+QriAyzVAbK6rl/ZgNXGul8l+54eKeslgpUHcQsIJOcgiuskhUNlmXF+RJFBcfLK7b2yvwEpO1MkwTYSvc/pRsycsB2foaGSXI4A4Gv5whsXAmGZB6QP+XKDSOc9I+xxxSA2U0FtcZ4/H/C3EEULblAusx7AqlQli++wXd+C2lnyzij0MU/JrjMcK6Ala1cX632cEfVFOdxgx/wyqqzJlLFCkG17tpIIbLuwaIJN+LxUPsLpVxkAkYncnVcy6IacuwOuYMkYfHCbl1Mot+1JL+H2uk0FwNY0cdjNI6diYX0x2tYnORJvF4fvKNOg2dgV7ArI8L23TvA28DZyHDC+V+lpyOAEFQsDf2Dn4BhSz8juebA3xLSHP12VlAJbbdXdcsKbxIfMhuM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bA36hkl0cnq3IAjjJbo0fvP6f5Rs2eSVQduM/RHQOtPXvU8sw/kV1+M1PfQA?=
 =?us-ascii?Q?yaKEgKSsKXOYnrZnu3kPqn/aCjA0m194JLOmUsmXOGu965cpXXUDxHepdmWp?=
 =?us-ascii?Q?7rY312sA8jZpU/cJr9ikMm6HMi5zwqDKo51yZYUsXpJTGf+YKsxg9MqXAUJ6?=
 =?us-ascii?Q?5lcVmOuClZ2Z3LA0YYTkyRCN0cCFjtrbJBvsPYtxqvGGaYzpD4oZTv38jgOa?=
 =?us-ascii?Q?cnUuiDBw1GfIhUOlkmZXWBvGinSPrVFEOHJl9LtHx8ObEMPGXzS6OLeGFSgs?=
 =?us-ascii?Q?jsw4z59yEi0/xie0Mlw97apgv6Ke1m435httZ+BWxgJLghEgNFUcEwSbunfR?=
 =?us-ascii?Q?s/6bTfdICBh++vT4g9mSqPJvQb5EI5ptS2oy7F5sdr1PaZcN3rPJ3H2B8Nr1?=
 =?us-ascii?Q?ICm4+ndKVnlY/L7NB4AZ2Zgu+p6l8ptpxfT/E1172lI+TTlg5ifarPV/Vqp3?=
 =?us-ascii?Q?2AdSrCD3qQOpWY6oaUm0nFzSvgte+jL03456wm48E6lRn08GqWYbrFJfOwtO?=
 =?us-ascii?Q?6qTyZYXThQqWTofb8xy9+DW0b+OrOvaK0PzldweBHPnl24np02d7NZMS5NTe?=
 =?us-ascii?Q?DN3nyHaqH+ZNCD1iCgZap6satd4gcVNCrnnCA6WXKUquVoa8+T8w6VmWY1yy?=
 =?us-ascii?Q?oWTVkH2ej0XHPd4XkfdSYeSYpmDbwxVhIR4hqaXMcMNuYcfIlHplvJOFZ3+F?=
 =?us-ascii?Q?Cdd/km1YkwOiS6u7RIV/ah/exby2fgB11lJaTGnDzTzclVb3UJF4TSvXOelx?=
 =?us-ascii?Q?FSNCRb28Ht8QDljq1VwUBYScpSNsNVvQgUvJRGKY4f+ye+4UIM22JpW+dde5?=
 =?us-ascii?Q?h3o9+qikXkZa3KingaTSTS8T+//cTISOaPdUJnX1yi+owzUY/biybBje0ZMb?=
 =?us-ascii?Q?r22KkR9nlDBAWjD0uzZ2wd44xP8mPZ8X3Wvqic/PkyxPWrjfqNiOKFFGdosI?=
 =?us-ascii?Q?eoobSEQHI486Nwf70nDNmzQQzBy3Cy24YP1xxqLCV1FIjwc7a6ytQ71v9TZq?=
 =?us-ascii?Q?ZyXLo3oprfxQpuqExa2WRqmLM/CoLg3wHOiJNbX31nnvThNGTbfUmwIXQp+9?=
 =?us-ascii?Q?ik89VBcOLCvw5FeuuBLNw5ycOrAfhSDnErZiJHuU73iXE4kqX5nsUcE/+Cj3?=
 =?us-ascii?Q?VFrxq0c2yotLLKxu6cNdsCYFHwxL6yT6CF8e6e7fehh+wWVhUYLAQwQF7HtT?=
 =?us-ascii?Q?3Ybva3vKbFlLx/dG8EF9IXmiqSQbN1UfKntwB/VTYlxEJAX554I9Ou0BG+mN?=
 =?us-ascii?Q?3ZyJItoyGW/Q9u1FMm/VcF/YD/54LRiUeWdwuBt8Ng5qHSAlxGto+FXzMICb?=
 =?us-ascii?Q?IbceGKQ2xsY2V76Y6OkQdvq2C0W6tx4p9SSkfV1jWJAleFcj3i57NkzkpUoJ?=
 =?us-ascii?Q?R5YP2Y96al6sfDNXL0zmyzEoleIA6dZCULKJgKgqlMrQ8kruIG8sRNaCfbPT?=
 =?us-ascii?Q?dEMUu5H5K4A+/3RFFu8QZSts7ENJIYHctGPyJ9JPo4v+okpSj1bn/B3CRGdq?=
 =?us-ascii?Q?YIGoYXbFRwcPVVrwpPxvh/j90O8CW48pM2rcAWLpfOv73am3HsV2aFzN/ynt?=
 =?us-ascii?Q?uS5+TjC9IOGdyBYNb5JiutQdyyBUB12Q15Rpivp2FtOli4JR8lc+QPT7b/gJ?=
 =?us-ascii?Q?/Nx8/Fwv5xEtDvi7qfnMBmA/TNNc5O+1yq5avsZSKMLeLv/mUWsdiTWGLvVp?=
 =?us-ascii?Q?Gh+3hGJny84XPr3aKcCt43Lp+vNOvkb0Tl5aNJaegVyOMq49dMzSF1h3SJt4?=
 =?us-ascii?Q?idb6c26++T8Eqh9+94AzqkkIEL/vzCf07SsGe2EOUQzJ8ADmpa2v?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d27fee-cd6c-48c5-5b06-08dee4054e73
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:17.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JamRzxeEgPxRKZt5I3JcqG5YdYIXH97RxUnh4PqiTtI1hmeMajYRrzJz7HAO/uDV6y7uLNlY96KGXodP8EZxsfe0neOGEjqHdkI5LM1OOrULSvn4cIPUW01ibwVLRGWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23649

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc96dc1a1cdad999ccd84a7ea6d5e0926c26d8ce upstream.

Put generic probe functionality into a separate function and let the I2C
driver call it. This is a preparation for adding I3C support which will
also use the generic probe function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241219225522.3490-11-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[tm: Use .probe_new instead of .probe]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 68 +++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index cddd940c01ce..d96497202ac0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -602,6 +602,11 @@ static int lm75_i2c_reg_write(void *context, unsigned =
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
@@ -614,11 +619,6 @@ static const struct regmap_config lm75_regmap_config =
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
@@ -626,17 +626,13 @@ static void lm75_remove(void *data)
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
@@ -644,17 +640,13 @@ static int lm75_probe(struct i2c_client *client)
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
@@ -680,20 +672,19 @@ static int lm75_probe(struct i2c_client *client)
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
@@ -703,12 +694,29 @@ static int lm75_probe(struct i2c_client *client)
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
@@ -741,7 +749,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "tmp1075", tmp1075, },
 	{ /* LIST END */ }
 };
-MODULE_DEVICE_TABLE(i2c, lm75_ids);
+MODULE_DEVICE_TABLE(i2c, lm75_i2c_ids);
=20
 static const struct of_device_id __maybe_unused lm75_of_match[] =3D {
 	{
@@ -988,20 +996,20 @@ static const struct dev_pm_ops lm75_dev_pm_ops =3D {
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
-	.probe_new	=3D lm75_probe,
-	.id_table	=3D lm75_ids,
+	.probe_new	=3D lm75_i2c_probe,
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


