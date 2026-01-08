Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF15BCF6AB8
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:40 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3049.1767864693413910941
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OjsGVkyO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouQfS7aSttqigYdjXXPT5OPOZl3rtj6KzwVVcWJSrRJ8PpXjUmezjckXe1RT1mwis+LZy/yQwjWgGI3WYfSHlJv+epNBnnAcqASUvP6xu2rSk3EBylG5WIiILDCvmx5/RepciwNijxyoi1LR4bk82+iGXNAN/b0b8ytG4HUve8Vad6PVgIN2B1605x7tzAcqYCNX53MAwrnneq5mdMOOx2qQFJGkrgma9H9PK0VkqJPbT6zugCqP0K4pIbxqQZNKasqpT5T7OAlgkoZsO9wccBCPfCLnW6iloGQz6uZoWwXYLfhG/mAbVJlm0na//HRjD6ZVgq8CkVLOn2y8VW84Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0QEJA59WStTbCS2UPJoMnA5rhNzCMUVR9L5h1k3w7U=;
 b=TZsyVkWkFU6L3wz8X5wES/LFnqHo7UhczYITDei27rjn2Yz0rtKyJ+GV54bwU3lVp7UiyO7a5elEuEHjlutdSy+grBlRnwyVAHfs6hcVVrynZwiqOoOubiauvoDILLdcpZR9XxMhlkPVh5yCisDsxSw1E4uK13pMqFnTHDYkQmkKKWDDd5d+epMp1fYkZYQ+ULdqqXCZhmMlDlgyH5ecpYLEOhSlNfyqznVI8g3An6qQk9/wJ80E6V29Mzv/EN9M9os5FfUa2sKZYGdhOFd6tihcOQqxXbEYAN/PmQH7OrR4viJliNEctkOgsTK2VurE/F2EL+EiPUb5fKy7Uv+NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0QEJA59WStTbCS2UPJoMnA5rhNzCMUVR9L5h1k3w7U=;
 b=OjsGVkyOc5m2Dji4U300fEAfvVgrUHe0eAIE8POhq/jD6GUod6eteXhHJOFMOCkSwHp3a/Nm42/UwWkcrgSlaZec9hjIuk7KrSVrSvJHyuKwafszJXx30zzct9SXqCI818RBhB45M9FH3Z2begAKSXCIeJyAEu33tiMYm3ZQnts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:31 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 16/19] hwmon: (tmp108) Add helper function tmp108_common_probe() to prepare I3C support
Date: Thu,  8 Jan 2026 10:30:20 +0100
Message-ID: <20260108093023.489513-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8dc11a13-3603-40e3-d360-08de4e98b4d3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?My/CuUPCpene6hlLhLCJ+MZK0K/ZrSo159h8cCHUq2a2MuYBPfunCRZ7F0qf?=
 =?us-ascii?Q?BKm0UMaNIs1Lpc9l9byKAhe2GxKxdy/+DtoeY8xhT3J7NN6+EqCIKDSiiomR?=
 =?us-ascii?Q?W19DhAqjN7+9mi1xom1YkCKYStLQNUOWnEvBritvzvyBiFw9jobdERofZGyt?=
 =?us-ascii?Q?E06WUVq7HqHWoaTizzl+dnq/nff0/IqY8HzyTZLg8QiEhSGV43fWecqs9Y1R?=
 =?us-ascii?Q?iFgP54iVqRz1eHTeJ4VYxqNzTk4S2j7dxrAXaqRBegXhxMJ6AxH/wLCuwBhJ?=
 =?us-ascii?Q?uuju6AYNAh7j162a2T/xWnMydHBd5nv9CD+3gS2Zh85V3in3Cd9wJP1e4VpP?=
 =?us-ascii?Q?ky0cTUKZ5mQE7SNvAKQyojYSNf2L0U73xYrR4bFwXrE14kZ7f9cNQpTK6A3y?=
 =?us-ascii?Q?ygJXKV+XEkJBLezKlxeUVQkahLq+6eMjfXqzEs/8aLX9GFD9VHy+wet5VE3D?=
 =?us-ascii?Q?C1fuFAaqrf2kLJvP/B+CGlAw709wYEem+x7VFUITHSw3lK1VrzgWrFeT6VF0?=
 =?us-ascii?Q?K3sAMDbFOkL1N6z+i300RgyWD+BeVC78jwZi5koT7FTQYMEMyhmTbZbAz+uF?=
 =?us-ascii?Q?VEoVb6hPPeIzU55GJJZvorxal8ze4v/WyZ+aHL2tHTq2UGkZxVY8AcY14adn?=
 =?us-ascii?Q?e0JwrHWlFG73ZPGJa3d80KIzayag9a/Jh7BH5KAUPjHnU4Yzj5CB/AVx4vj6?=
 =?us-ascii?Q?hyGnszdPzQf+bVOu4prPHZs7aKSYXKov2m1yTLXdhHIAmsXL80d2Lzdk51lq?=
 =?us-ascii?Q?suOVAR9yV4meWHmrkpUiug3ahOhvDjatU1ju43xUi2RwD07brfIeqFo1dl1k?=
 =?us-ascii?Q?8INvCdf3i2aJQ46qC0KFcLVut2DlkbMmXOl0i1ELp5XlNbVIqKzRngXTGFeK?=
 =?us-ascii?Q?1sEimtTdYKwKBg7qlej/nWYDTvAerQ5w51R+Jy9z5gLAr04SEyp8UKSQPSqO?=
 =?us-ascii?Q?1aZCBDds7VVWFacIl7xpUNfprte2qMcjZECJoqFhCryczyKZb0dg7ZssyIj8?=
 =?us-ascii?Q?zUrZKDWtitf7585fSY2c3Tf9EpUiMBkprKG32CK/TtchXB5zMNH8uAxeZFF9?=
 =?us-ascii?Q?ZwgRNXL8rbgI9Ofx2/3pSuhObZTwH24NygiT4aHPT8VE5iG+wk3ZlZDf7pgJ?=
 =?us-ascii?Q?lX1FYQ7Jve4szIrUXf32qtH+CfuxARu9Q/GJn3jlwn9MvnfvTsu5rtuFl5Xs?=
 =?us-ascii?Q?Kq9lwSidu8ILJWU04vhhYHm5GLvW6qnHk1Bt8I1ws5M0mLAptu194eoZIs4L?=
 =?us-ascii?Q?O0iLs1tofsfuWjO5h+9IvV4ajj9ildZSt8IbkvV8lpEqMcVqX/W7NwcnLX7e?=
 =?us-ascii?Q?ZZeXXlRUWjbHoVxLbsAAofo6YBD+4+p0A/t0hwzeX385RTS5ORa7UmGaFcqa?=
 =?us-ascii?Q?lJBd72tXpk5iuepml24OuNXIMs1hCgBpxF32oyYFJMPZ3Y6tmAAxGvkrcF4X?=
 =?us-ascii?Q?NMWRlzcbsw4/PoSv+KDZNYRVv6WMOJUoM9BFWOrlKp2rU2/g8ejC9cOwnvym?=
 =?us-ascii?Q?mmRuVxo8t3zBcH/q/iMuDFbhZRkEq6QvP2rr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0JrktvXmGOIy48UXeDhsNELWCOI5oLhUND2kalBkless2OxATt5niYxZZppo?=
 =?us-ascii?Q?9hsRrsCdYj3vxvCK+zlqErVW/3q0JWJuMw9hPmG/6flEVgQ+KDg80Y9eg7IC?=
 =?us-ascii?Q?iJnMJB/+LJMEM/6vcVpQAx1osdxsHHiJgtQ4+vvV7nvj981jWuz0eUuKXlCR?=
 =?us-ascii?Q?JtYvFktMrgJ+hyOM0kW7pUfSuUJ73LB6/beuzhR3A4a/YOlwQyjplF7+dbpy?=
 =?us-ascii?Q?0W/Ols/AlnmLUCKSRf0hAu6WBuN0KmYigOoGNJXH/Y3ZwFlFJTzTCmN5r0Pb?=
 =?us-ascii?Q?oyIJXLZP+8rqGa6vTHEnbgzeOwH89YIVISfrv7CfbHtoqw8zddeqoMrlAZOQ?=
 =?us-ascii?Q?sBbJFWPOd2hYG6VsF/FTK3h3tGBoKh3uLQQ+DHc4A/8dZvifBt4WyeG5vCHb?=
 =?us-ascii?Q?crEH9aTriXz0UzLKLVlpf9YhEZtgOm1VsppADypby4BYqnGEkgo+rl++z6Ld?=
 =?us-ascii?Q?yuvakjqeeiaW3UNZ+aeJLpneCRHNQTeywtbLJ4Wy0zB7pWLzCZY5oVf7cqW5?=
 =?us-ascii?Q?ylRCXa/M6034QrwN7IHMOEdYxUT4kNMChvMKYpySForRUTisF+CgoOETAhD4?=
 =?us-ascii?Q?7fIuuF3o6OivLSKeQaGZ/HHp7gWbmvSo2zUZZDuWogkto3nlLw2qYgVJFzcm?=
 =?us-ascii?Q?qJevnJVavvpwMuXGQtAogm/GlYSzPARjejX4wd0GOFOWVrlV6R+HKLm+FcKz?=
 =?us-ascii?Q?J1FwMaRggzkqUp504S1DKDC1Bhtzv4UKU8fizmCu9MAiFRnshnncrnPo0h89?=
 =?us-ascii?Q?ylSFE88wUYWnzsy/Kz/PFy6Qy9+DHQSDScIsb2AP0knjalOzeScbU0NzcWaX?=
 =?us-ascii?Q?3LXn5CgyO7zMW4DMSs4mJLjAydI3cF7vl4hqT3XGSoQ3bSxVmrQQaq2qUIyn?=
 =?us-ascii?Q?nqp0FfR5/++d4lVi5JjMK8nPbhfxicZrPTZds6L/AxNwf6oHREuNxqpSs5ll?=
 =?us-ascii?Q?NmPSEeIB8i7vlXjJZj/xsZv0BUY9Tdw5/zsn3WSER2xVjmXWwiPpvLIF+Bm/?=
 =?us-ascii?Q?VX1fWiH0En5eCnw1Tinkp9zQbea2Jwlj/asDdta4IrtypVhnZP6uqWD9RllC?=
 =?us-ascii?Q?0B3S8loh1ONWKjRVkB+TsCp1djFZNvvdeOKKLPmCysPmtjqqNtWDvQoFjV+6?=
 =?us-ascii?Q?IyOZ2XKVHpPm3mxxNZneqittIPmPpo5WsVEDetYbQrwqlz5bOx6s0ZrUh7f3?=
 =?us-ascii?Q?z7QxAx0aH+QxfaPxpDHNj6mbFimxxfBLdO20yO0AK8FcZHskbijpw7vM8N6A?=
 =?us-ascii?Q?SVmbMDmzKZdnuNNbj21fnuBgCupQjqW9s8VWs/spVuSVgQTlfZZXX4xthGrj?=
 =?us-ascii?Q?4RuyG9TuV4oCv1vxCvAjsN7BR7jfxTUviP+ETsawjcnetP3wzXE4AR8rREr7?=
 =?us-ascii?Q?jlTfbziRuahXC+uKyfpzuxfqSTgoLPWFA23tIu6dsFx/52UTNiqN2xCD8GlA?=
 =?us-ascii?Q?9QXk75ZYdwXU0H8ZxpRkPteh/0EE5EU1W5chqD0K/rmR1aM++uGnjyzN5wxa?=
 =?us-ascii?Q?OoqlNrS2VGdCeew8tgsoj7PtHOXuMn/0QxSRcuuIknStseco/xnnn6jTE1AR?=
 =?us-ascii?Q?DJU/CL59xYXq7iL4IWix8dzu2BU5jMBZI0ym1U4jyJKoKagP0XaOVjxBMWlH?=
 =?us-ascii?Q?9q0aURlIAGFxkqo23kH2jTAoGx7ylov1FWamjxErLI4NVm/WzOnSyWGkB/WA?=
 =?us-ascii?Q?kj5msPekgNjZ6W3qCL8PLW69m4RQkTy+nPEG+ocSKHxNOfS7PS+aK2iBRGR9?=
 =?us-ascii?Q?akEQG5GHE4svRJ6Z6BdDylzulPgbIpvpxtsz8kUn2axL7/0ifZgT?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc11a13-3603-40e3-d360-08de4e98b4d3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:31.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUC/ZAGp7v5eX5mU6JqjdD5X+JhWDZ04bc26akMPnoamZ1zmxGOCp4ZCDiAHTH1DwwW1ncjZsWy4xV2BOFbHSMov6Pv56vPYcHN0b+boSRtF5rf6lIQdt8QjE5Qpiov3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21475

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
2.43.0


