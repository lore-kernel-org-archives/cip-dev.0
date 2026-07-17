Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F8BC44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:29 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13241.1784294007839851741
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WTs4n4QO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA8bfQQAf7N+sXPCIRyV1wiUzGcY+mhTwARGAwjcQ8wfCYTto2X6YeRE9AypODwdF8u8/YO+MNwqh4INPM29jyBddjC3GzykopEC+302s+K4y6ppatQ29sZrIrZOopY/mKTycU0ebGlH2mhocz+FL5HFRv5NBM82jIKGRxm6ejwTDmkzseU6lWOE3RY6eqWlNe2z7T3VsVXR/ZT+lIYVWZmWHkJbN4SgMKg4q+mojjztZpnJqqOBF+H+xHXpor2pF5GypV4vkackuc3AG4gazy4vSwDNEA55IvDhwvCLNyZKdc2kuq8JKiW8AOS/f4hGyoHEKvZnxA/TexYo7PiDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svIWhpC3JGhGneY336SgPe4HX3VnBYjvdOLcW/owOgk=;
 b=ENNHAtw16EsYKUHMsjrRdSdWSVCpHJIdrb+ifv/sV44bVGTkUF3v8IwPmlVlllmQLLBwYk+JgX4eCyUlrSQam9KjDhNyNJXcESfc9r76pLIm8kUq4YO7y5W30IbSWbqg4S+X8F6KGqvgvshSHRpcw+QbMDiaVdfzy9Gr7DcHJ3nlqUZJvktIr8ynmpWvFrZYOIE94JnPtbgMhiJ61vMpOaAoNATANXQ86n2VOxcGz10tjKEflxhBfE0mM9wy8JGMJuybt4DTqpMhrMFh32xh2JFtp6Wyd9HpaW1J2zZPy8oJRtYmVbneQVV4A7BBrcRv+BVjGFSSQl+af64JSHC4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svIWhpC3JGhGneY336SgPe4HX3VnBYjvdOLcW/owOgk=;
 b=WTs4n4QOQ012B8xNGRqvRdaupp68Z4E8YuOHqAPids3zKB+dYqPsH8T1eYyvCMILH5E6RqVWzRxebS+ulgN1fGM/oGPAah3YGjNI0uqMYBA6X4pevVwoL+sj9oK/A+3BpIE0tLFjnIKzWuQ1g4FJ4N1TJ0V9vtkMSY4qQZQKYh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:23 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/23] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Fri, 17 Jul 2026 15:12:22 +0200
Message-ID: <20260717131241.2233788-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 682000dd-c054-4951-bfc1-08dee4052e2d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	lfX4/kj5AfF7ZPbu7mKAf9W0fpMAYHwTb0m7HLDUFEm3Rv+tBwxZvsQdAnmrO+2UwFcmh7UGDMXj1kpBPJrxrj+HMzRYyeOH/3jU1EC93oOSJH2xG97eWU9bNv2kqfZ0cYl49lieiCnEt8JrXTSLi4wpIEQahTL8Q4xOt0rnSSUJdEHPblO3YvIDGTvci43BPaLzCpNi3cy8jxY1xPnnnI7eUy6ELBEjMkjNhIIG/jbv2LqgapHrmk61p2C/XEZmJ0sAO8Evo8U5FgAIkWLfGpiqvT1KQKQBoD1Cxgo5/ytOP5Svg5FDxVtsje1lQ4FEIhT8G7qD3gfgW+El/4hG+MQZelo9h1WKP5Ea6+OHdWfkt0r0ueQXMlWmQDJ/8s3mg4oV+iCG+BqglnWjO0NTwqPp5Gzx6GZ588IYT0kJ7sORIMX68O9+RTi7yOeQCqUSkUujsWY96/DfYJk9Q6boclVbJ0Pr/f3k7bKlDlnDyVDYAzIyvYclF9Kfg8iCNek8G23NWdOjJ7dAFKL5CrIvdKuXD4AZyJrpExAgjdMoxZfXFcgLy6ENsuTGyHCi4O9F4FfatxdtMzoLuUjPswhU3WU7R+V4yDLwdcBC5WEtAMvZmRzBOpStf2Xuq+mnfSW2ZQK6O+JQ9LFx05/iFUtFx0zoT8vPBPLAWhgYxsSkohnDZLN29e7tsYCRf8rd6H1k6bcN7dtRppK/zAM6Ui25nZ2SwvuyZdv9k8sSoNsdi/M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qukC284J7E4GcutWst2u8/dBNzzMV8WyuWNmhwGfbtz+/P+zS7lfSOicWoNU?=
 =?us-ascii?Q?A3v0T4L12AfmDT6CcIORmxP1ygAbRvoto+qU2+F9bLvMWGcG5D7SHOyHQ6Pp?=
 =?us-ascii?Q?b7FBra2DKVF6SqsZsVn7jYNQ3faclb+X0ihQ+TOcShKeEpSgE6c7LE2kAdQ2?=
 =?us-ascii?Q?bY9GVofXPIsHAuIl7yrUNnZJZTWm1Sif8mJfmmD7t+VN37rxGgXnPzKBBz0a?=
 =?us-ascii?Q?zqydCWsd/7y3Yy/7mPYGntMebUPX7MMzu6joCsApVdJD1v3vYoRF3imxlAyF?=
 =?us-ascii?Q?FwFUhBge3JzcQ8Ft3rAJWAF80YSjKCkGgHqPzEHmfNEjepmIJez4TrLqKCYB?=
 =?us-ascii?Q?4LtHYTatidsme2jLK6AKl/y1Q+e1AR8Y/NVehDTcA1Yqbj2/kvkhvYEqjTAg?=
 =?us-ascii?Q?3iidHQgqLpz4FQXQCvSeW2FI2CyF1mYR8HfGzWK0KGprK4TLjoCgouCoISNC?=
 =?us-ascii?Q?IBfK9FbR/1OwZSHjyxO+mVZLkGcDPibqbCaGYrARt1CvFipdWR1ninUMDTn7?=
 =?us-ascii?Q?1ifz2pL1L5QLIZCmkjusXFQxNhjP71qhvIkOVsnCTm3TdhwxCWwhPOk89ktC?=
 =?us-ascii?Q?Y+tS9mkJduSZrk5z2oUHA85xLM7VU1W3BSmLlJAjU1jrasYQ2HW2vgSPoTom?=
 =?us-ascii?Q?Hz4EhgI20wukkAIQ0H5zbuD+qASdYw2ICMWZ9yrgIXZR9P9DRNCg0Z458vx7?=
 =?us-ascii?Q?xt8Vs4E26t6aAkz/8Y3lgjXvvHdy05cVTNoz1njuB4qZi4A8QiTwQ0A3FB1z?=
 =?us-ascii?Q?aXC4WDR3aTCkdS9RW4P66Q99/yGxnGZIT2bsIzq+sMbuHDa5KHFS3BV3MO7k?=
 =?us-ascii?Q?i1iaK49JBhE8A1x5M/iMLzWianPj/ViZRb21ArJVrl7EaEVuYsrsLTLVBET/?=
 =?us-ascii?Q?eybw4vU7RL5LmCySATAOXb4aE+pakKfEPsfrryyz/tCBIw88THe/61kLTYAW?=
 =?us-ascii?Q?RnOV97bFjQ51UXKLiVJVess729IyNIRBYANqMyW4xbNnaXAf0/Ne71Sfzx13?=
 =?us-ascii?Q?Q9a2eaaORXHja1vJFiLeUtqAuS+34DAuyIRX4CZneLQERwWHkcxJCUM7hYt1?=
 =?us-ascii?Q?XELAruP6gVPdcnIblUMx2JcC5ATKGoQtsUFkrzA7ePKYv3M5ZJ73XKK6ZvV5?=
 =?us-ascii?Q?3/XRWgkvGChsFaiUj8NmOh1G8ow/XrEArkCGZ5W1Aj3Q1c6VE876e+ND0RAb?=
 =?us-ascii?Q?6rT9adGqTV9pX/vmhQMr3kLyvRUBxGGc8HAyzbgoMK1JSQcaxdv7SFeaarAH?=
 =?us-ascii?Q?jF9AoALHOVpRuFfivECbWEYCCCayY1YsE5EqN0g2BcwsezkxJxw8mqcfjRYC?=
 =?us-ascii?Q?csEsbu3Kh0Ot1sxQegKveJMxoz6WbKIcHrwTsKcI1XueJXx8bfkPLFevJhg9?=
 =?us-ascii?Q?2rb532oE3uridAV0TGbV7+C/z1dOn0S9Pl6Wxky2+YC7pDjDbVBBkB/WYP2o?=
 =?us-ascii?Q?GdnGpyI1vVSTui8elHcFWydu64EFu1wwlBRvRQo258J8kBJZMiB2Orqfd8se?=
 =?us-ascii?Q?eTyeYmlwD6YAyUBvjrnCitu7p2QDfb3L83IIWehsZXEbgiOXVWBi+1MA+k0Q?=
 =?us-ascii?Q?6mTRFjSXLxhbLkZlO8UJ5/JwJhKdT9SdAlkMuA7AOoINMpgDD5djQ4mJpVPp?=
 =?us-ascii?Q?wjfyeuSbLkanEGRZgDwGON09idkB/F+8MNybXxoYMjXPOvxa/3ptOx7HrvVR?=
 =?us-ascii?Q?4PFTzHuZOiReuVfYRf8W4H0xQxSf1HPomzpvLqWvVcrDS3QlqmUMGj856G0R?=
 =?us-ascii?Q?XxjYiq+Yi4KNgzh4TKducLfEDYoOxJaIQdGLPG7UMCdKJYmmGnNx?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682000dd-c054-4951-bfc1-08dee4052e2d
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:23.7370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXbBpLXfN7qXNx6dCEw+3F1lH66gYbzxUXODSL1Eg+ItMJ0kbTWUvV2N2JT6IbKycQvS2oy/cO70OwId4HNSBNNouKDamyE8nFSZTBRrxQUDFezMkwrgEHkG+NWieXa5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23632

From: Frank Li <Frank.Li@nxp.com>

commit 700f3250198d51093884254220a96777a922dd47 upstream.

Add help function tmp108_common_probe() to pave road to support i3c for
P3T1085(NXP) chip.

Use dev_err_probe() to simplify the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241112-p3t1085-v4-1-a1334314b1e6@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a8d9a4e00eb0..63c2eaa59d21 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -323,33 +323,19 @@ static const struct regmap_config tmp108_regmap_confi=
g =3D {
 	.use_single_write =3D true,
 };
=20
-static int tmp108_probe(struct i2c_client *client)
+static int tmp108_common_probe(struct device *dev, struct regmap *regmap, =
char *name)
 {
-	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct tmp108 *tmp108;
-	int err;
 	u32 config;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WORD_DATA)) {
-		dev_err(dev,
-			"adapter doesn't support SMBus word transactions\n");
-		return -ENODEV;
-	}
+	int err;
=20
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
=20
 	dev_set_drvdata(dev, tmp108);
-
-	tmp108->regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
-	if (IS_ERR(tmp108->regmap)) {
-		err =3D PTR_ERR(tmp108->regmap);
-		dev_err(dev, "regmap init failed: %d", err);
-		return err;
-	}
+	tmp108->regmap =3D regmap;
=20
 	err =3D regmap_read(tmp108->regmap, TMP108_REG_CONF, &config);
 	if (err < 0) {
@@ -383,13 +369,30 @@ static int tmp108_probe(struct i2c_client *client)
 		return err;
 	}
=20
-	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev =3D devm_hwmon_device_register_with_info(dev, name,
 							 tmp108,
 							 &tmp108_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
=20
+static int tmp108_probe(struct i2c_client *client)
+{
+	struct device *dev =3D &client->dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return dev_err_probe(dev, -ENODEV,
+				     "adapter doesn't support SMBus word transactions\n");
+
+	regmap =3D devm_regmap_init_i2c(client, &tmp108_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed");
+
+	return tmp108_common_probe(dev, regmap, client->name);
+}
+
 static int tmp108_suspend(struct device *dev)
 {
 	struct tmp108 *tmp108 =3D dev_get_drvdata(dev);
--=20
2.54.0


