Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3FC44516
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13200.1784294135081355039
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FxKExW1G;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.22, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j71ZhK18EsXgH9A3QHiXhsb4S7xrgB9/6DmkZFOMzvohA9dUmodOcMHrtGmr8pMZ8vXzKFGmjHOyU62aXcpsWsctRxBQD1/uJbWX5QuANGnwDYC+/5wsJjtzgQuiabySjP4C+i+v7MbMOT3pnksjXNEi3VPd7K/FfZE1Y/1t9bpqeHSIutSz+sRkYESu8sp5OeICL3qnFZm8qjtQUSJ9sN062PeXn4ukg1U8qKPtzrN+TQgSw47ouNOMmNdqnXu1j1tPXxZdbcnpSVBcktFWL8ySDjkcIv+aoX22s8Q/I3u5jkFj6RQ1hJUmpTgujxUjAtwf+bGpm3dtdxddeTpNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVulX+rVPh4SEGmGjumsoMVtJr2iv72xRlHfU2BVD7I=;
 b=MD7LH/KjWydOKdnO0MRQDoA1PLwjPRAAA5x5PagdQ5CSU5y2Muo+6C+rrX6Fq+BLaQj3qVsrgzOwbJuvYZYTK6JnPdRf2E2dmtkgrXafKHKUZNA5lNYW0T2HIV8EyTMOMcdbschM0+iDmp3lMhWwgx1pSRjwbEJblgcm08ufsxb3Ecb17ACz16aluBqr0a/x3O8qyDuXaG5Ty+PubusWlF4WdH7/QqE7a2U/gXDv222tIqIIzHOt34/5RSV0MzkOS47ADnZmpZBYBHGAtCVGucmxXAwZppKAReuUwUSjw0q7/tIx4IF/E8+Sar484XW3ifLItMa+pT3OziGIItomIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVulX+rVPh4SEGmGjumsoMVtJr2iv72xRlHfU2BVD7I=;
 b=FxKExW1GXV+LnJqn6rXwFFSSdiJm6P7Hj75rQmZ7G4TkhoWWRTbyWI7z9H2/hs2p8w66gE0keshJHepLcXudJJ4z6YyFEy35gCP4m3L8OD/OM2dbUhtbYgT0gtkmeEDg9WNxXXSQaQLP6AH5SZ3cZWlZVOz573Lu209LumFCfUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:32 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/15] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Fri, 17 Jul 2026 15:14:50 +0200
Message-ID: <20260717131502.2234020-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f1660325-6f6d-4dc1-b761-08dee4057b0e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	/dgMx1m3j7o0o3cnITq4urqbyF7G+j7qkulIXZ4tBIjYah3GSR8qnBkiUQJk49kWSIO9uyibTyK0HxhcBlPhBf+JNHZZOLZjlFPcA9gRNbGg+MGtBZNcEXZlk65e1o8l4CA1gu4GfvgRL122QOP8M6cGgaGk02YUt1YCOWaZBizfymRbUIlErVjn6AEVCUQTvqNO7D2v6l4HU/3yyGsioyhMODngRiqnG8oe69kcDFGnabtBUzo+MIOhkaKeetwgxTsp360ieFACLc4vOUc4bcMg1YBl2HGGUyxdZn94mjJrBWnUJtcebzYfL4LSwQiENvc4Um6K4fB3VMM+jhJoHcvjOzJFM26E8RocKMi5NN6by/0JQJ+mdPpgR1wMprtrMWIO6TjZgiSZmwxDkolKVTto88umOFf3SG8+j8WR7ZUY/rm5du/V55JDoy35oBn/ajnSthJTVw+E149ZGugAEWXedMd4RrKMfFHXsT4iPdh8QuuFDPtUcb2qJkJWR5mA9YZD8ydegHANTePkYXX3KADCg2/5seHccVdmuR6ZjL+iloi//IOpLUO4oM4XPAGy3q34NCdyEVz/PBMejxL4yJRgJxpT+DXHST+NDnfxB5AgyjIX8LoMrlzYFoiUeIBHMZNsddA93ZnesJ60LSU8DHYqvvkWWJC+fw5VHe2VrXTLl3kjRMKLt5eGbsTID9wkrAdDfSfkYl1veNkUbm1+3clqyCA9pYiG8GgheYLdqiA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0rodKAH0n1OqkGHTyNGGEZq4LpJut0wJPtF8N0jiaKrxeRIx9xTaKj6l1gBN?=
 =?us-ascii?Q?QfB4CX//G/ZXhm5xTh1Hemj0oTtPqgWQwv5eOyPRzgIY3rM7hTwjK6aC1VlY?=
 =?us-ascii?Q?ljzBUt6cTlzwJmKpDcefwzTxOiB5X9fZZZj6DXyAoB8SoOg9hZI5m3Zj0ytg?=
 =?us-ascii?Q?rXJIKnsMgbd6bF9gu3T7d6zm/0iUcJaM3maHiWY/QOhtW19m0IVn5HZKuSFF?=
 =?us-ascii?Q?NJx3QIUkMQ+r8w32cvAnp60EDMAgp9Vs0QmXw+g3hqbrlPavAalABgCGtAeF?=
 =?us-ascii?Q?HKr4Gc0Qm6dWh2ocaXvreUidwU97AzQTPbbxxC7d8aPmMwJlnAjxDuRUFRI+?=
 =?us-ascii?Q?qX3uLNkr4AawrQ/ztRdGdp60ySIE+de58y2gbAZHomMHdEftwju9MsUuH3IN?=
 =?us-ascii?Q?+Gjp5C/yuUFvfFBWlVYv7EgVYfe2WCphwEnEgG8k9qcPj1J2q+zGz0WsOFEf?=
 =?us-ascii?Q?/SwbULeCi/ligwMDstopMTpJiN124F6VH/3XMV25cgKVr1NYiv/EnjYCnmKn?=
 =?us-ascii?Q?h8HnGDsqv072ajk9fpN4JD6irtkwZbu08pjT05coSTuCswVAR3wYfSZbkmqH?=
 =?us-ascii?Q?K7fNsQOIjYREbmbSHzOG9aZLTMev9/anPMFw6mIhrLkib9VjSKMewyiqnyPB?=
 =?us-ascii?Q?4wgaKcs6wUyUWunmG9oHO/SAZG9dXGN9DoI6uSHSo4ApEkaNW5y+hFIMheOZ?=
 =?us-ascii?Q?pWjCvHbjzmfUIC/KoQUJRfx+8KOcie68bkny6NY73SbCq871QgWfWlUBVVkc?=
 =?us-ascii?Q?d04LvTpKioqF0rZrqRpJpQ40JkKM1ziAPXSusTqr8yo2Wt/5u6AVKs1lmu3s?=
 =?us-ascii?Q?/YQ0NH3PIvntFwGagJkiQBU8dwYpOPjp8bWTn+S/q1v2e1yU6gD4xP/oWxrV?=
 =?us-ascii?Q?DC1attz4WknK/JBfZiUxsPKhp9mAASpxO6L8oCWfLxcFlSX4l/YHRjsIoL5e?=
 =?us-ascii?Q?jg71c7ZHjEY4lRuG77WY/UkFvUsC1P4dT2K9xki+xN78cahg9okGoHcbnana?=
 =?us-ascii?Q?zInZWnDDdXmIVp7gxKTUWUZZBVT6uddRASrep9bxm99WWM4kZnsfvqckc4Qr?=
 =?us-ascii?Q?LReJIDp2n3u+3cVzNja7uY/6rIatoZ2hlHjtD1Nlqzu+M+Il9BQOOw+3pYTn?=
 =?us-ascii?Q?TE58qAerZwPNrY1DPEQzk/wVDzM+YXRyuJlKnr/WbJTY9wzCY/59mCRZawPk?=
 =?us-ascii?Q?N3ocZQxyVNYopev12OQMBAJLwufuTgmidDLftzhTyL4Xf2R8cG/oi4UE9M5e?=
 =?us-ascii?Q?P9KrSoN7kWWB5fEL+Rlf2ApsbACqwdvwDYvJfKmtoo3JpZOZMIS2DarYvPo2?=
 =?us-ascii?Q?TB52+ZZKRpgNWIok7OaBW9cIdIVoISyQMRAhpwYPmil+cEO3e6tA5G1eC6Vh?=
 =?us-ascii?Q?+QbWfgWnfflU7x6pCgcyVRrmsiP3+xMr+Jgu5rjf9AbFc5uSbmuFZfoCIB5S?=
 =?us-ascii?Q?mUQ+s0K1mSzTCwWGuLZDoYoiUJC3Muxr01XoHyjlgxKKBJQiDTXtXh0hjQk/?=
 =?us-ascii?Q?I2qZLNR6yZKq+gE95+tt5TobDlE2cUEToeb5ngoNFQO081ptHpnh9BVSeYLg?=
 =?us-ascii?Q?jqwj6ZP9O6a39hWa/5GDnr9NJGe2ZsfyG6jYsXWaK5AgQy6OK7gG2ezdx6YN?=
 =?us-ascii?Q?28mfQq4eXDpnzxaWOwmSdxVBCEd/lsK8D9z9axaoRfUqZSfyikII/1nRVo9b?=
 =?us-ascii?Q?5vSVzOGFaGr6LtD2fZ7knCCD5LrBVx08z+NAhLEeE1ZvSiMsiNv0syXMt7Zm?=
 =?us-ascii?Q?F1fKIxVVSfMblSaCniNLw2oQnj16to6MpG0i6Wrt/9WuScdB7Wiu?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1660325-6f6d-4dc1-b761-08dee4057b0e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:32.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9Q59YSXvN6nlk4pO/+9Zfl0JW7P2Y4KGAj4l/cgNC9UbLs1wRSN+NeMr5t7XfBsd3tfERVpg5rlJAPxvJ8MNIFtcUZ1EvS1E5cOmQD21aExeASO8h8hGAzMH08D/tWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23655

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
index b561b452d8d3..bfbea6349a95 100644
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


