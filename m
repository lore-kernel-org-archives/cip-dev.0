Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0569C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:09 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13278.1784294042420108506
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aakFpLzS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7SLhyAI0OU4bIg3fgpwqzjbqh8F0Gzaxe2sl2NMnMP8/4DPzqV3OBSmqr1374KmL1vhBTR+aqd2HQOnKvsA0gTrsgzfpxUeqY7No9ctEo8iWgHUkMN60Uk7kYBCAEA/DdAE4AyY6iYL+G5Hqp83B6F9Rb/xQ6iGBBf4V8hI0aUCa6zy/7BDDxakDXiCiSu4hP/w6KG37JBqsDokXrqoMifI2ni+2D1gt+/l7F1YjObYXFw+xJPK7eD1M1JK8gpE5jD9VJkY8cTBCCO4W0Jo3m/jBjpjyd0cecjuoAZ6puIaBt/ONZ36QBUKUf4TwwnQoHPuStLvwCU674QjjdCqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLbMGew1QgjmBHLrYlV/7z5eefKEjAWe4/Y1ih6YKVI=;
 b=fpruhHkaVPCPRaARfc7S4pdGAqr2CGftvLLRoxrB1KXbKsw3oLnbPgcUZXqgO9k3guLVtAH11A+ClAlMVEw67TMks+2FF/4SSD9knL7Ffe4bmT7wCQpUWoAOkVF1iG0qCQITilCJeqh1CclVeMZH3e+Ga96l8YrwxRLEIrXxmW8cubKYUmgCbv+LGWp+r8qbmUB6McYTnyFOAVXqeCb1d84d2jHbAZgqpQdn5gCh/dDDejWINIbLmnmeDufViQTTLDgV9H1dwJYHTKEDh5mKjiT85U7aT3dGQcF6TpAnkvB9NOhNsyqiimF0GRaO5K3K2Wr0+3zluDFPiaFDXphQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLbMGew1QgjmBHLrYlV/7z5eefKEjAWe4/Y1ih6YKVI=;
 b=aakFpLzSxTP6MjEQitLny/QXNm3DsG7j3U6PBVNfWApNgw1SYlnXj8PeeTWiQVfwPUf0+sK2NYDHf7Q86fltOKPblVD43kdQ4ZgtH5AleDJj5u55SPhXaakGno2TUfhmkDj45NjXb/4wTut0XEP2fnuyLfhHVsV/Uq4Gfk7bkCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:00 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/23] hwmon: (lm75) Remove use of i2c_match_id()
Date: Fri, 17 Jul 2026 15:12:33 +0200
Message-ID: <20260717131241.2233788-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d87724d-688f-4715-01fc-08dee40543d7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	1Cmyb/aTJ8zjIAfVjmkGktxeZ6Xj1EvcsrecQJ3DhuJ+ypN6kdqChE58IAfC+qF7Po3ZOGbz/g4hWXwYDXevWXRZHBDySWChbYzalM7TpBW6Mi7xADLFah2jtgO4mnDHYySy/R5iVZinz2Gw5dMGL62SC7b6X94s7XTs4xE8XuPYtvsV4YvxREMw/6dkkGZLuOUqNpNeOxcYGqzrqnOsBFy/r763dZcPKU6ZeL8MrFAdPy8NYJ54eW8NCPJg35snjus7rV6HPJ1CWDUOY3+aKney5DU+uIaKxvygDmR5kiKuQfcNMDRM18wenwxLiTEgkusbcOQrEDL0D0J5IBzEllkl9dKAYCCwZyPbmjilLRkvJuf0kXtJby+du0WNsHtTBvAshizKMQwbjdq+Eh8fJrLb3EM5DQD66BsltErgmZi7et+oG3c25HNWGI6NOB3SK5UpZa4Mt9lmYNENXGyd/93zZnb+TUEhXOmnkbTCpY7vnDp5PU0p0jIMZDnDqpK3K/R4N2Y8O3zR79PQzw/6caUhNXjl/ByzHv9FdkU8/DDI1Y8i3iTox0VVLySBKZA3FTcIknoZDolJgzu1Cq7HPgkr6XdAZsDlQe9pEuk505mIPQXjp9ojLq8KM/GriKoHaEIe2UwORuNnEa0vTb7+2EcAKOxk356vR/+MDEnVEzPFms7pq+3HdoaFtgTNsfRMk7V6Q5w6upbiJE+qwciOEjhzhcp48fF41vhY9XSxFfI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SU/rqJLDiCKRAwYSjZti4rIbfRvjCWGvvt623brC8UWsioJiX8o6tLOt1b3q?=
 =?us-ascii?Q?H1fWI05uo6jW8q3+Eu6TPGXNNTRNIvGD0rX705Nj4A+NPm8ELv0AJ/zwB2Ji?=
 =?us-ascii?Q?On5CiFjLec7uFqJqdSBt5GRwi4jb5fZ2nZhyEcR97ZG83YiIHONL96NQ4WD5?=
 =?us-ascii?Q?dwkpf1Hfwsqq7Af5UQBDu3kwUB00pO49JV0w11MyOzw6akqgWnxGbkghVXPS?=
 =?us-ascii?Q?w8z4r7MRYgVTw/odtWJrdu4g/3LUL+rgLh9NRuqdFVawqvFZS14xNOaBCZ/S?=
 =?us-ascii?Q?n37bBqrP2jGsijWWYh3K/Qj+P5E543DkifnSx2izCKogEG+GRj/eBuremM5J?=
 =?us-ascii?Q?ORvM9NxaYpcwmXiie+8WKjYoTFeTSF8AhThue7qmTfZyl/0vw88/W8ZqnBLk?=
 =?us-ascii?Q?v32IiUIzVPvWiacbd3K9PLEU+WQF9eELLR3qfksWjq+pWqpmoLFinw1gzfD1?=
 =?us-ascii?Q?uqU4VLxsCC3QZroDulnyOkN9mjJXHYlX43W+9P76UQnMt9fTMS6/gDEygA7D?=
 =?us-ascii?Q?ekZECrIr20Nbw+MF89TrDdYMy2QCbLckIu0Yxqgbq1thovL8cTmr3Pq355DX?=
 =?us-ascii?Q?223TLpS6RChzwr378UYE6P1y5rx2/mMUBYcIuPTso7NftUJjcrleWJ3NsQ6I?=
 =?us-ascii?Q?59Q6pNFwIhSqgcA1gGDfDLGvN+V56XjAP/JlX460bLlh0oBK7ANtoMl/EUzU?=
 =?us-ascii?Q?uVkXicCItp2OYawfxS2WOH4NVKf17NBHgNg/IrYUrJ1tcXuESoJpvsv3y2Sq?=
 =?us-ascii?Q?X4Qj7VD2WOe8ew5mQ6g1iul0XoppGk6Jcl6IPyH3WOA9hIop2NDyAtLPWtFX?=
 =?us-ascii?Q?NgMVHj8adaMmfm541/FVSXbJpwi4fhJkVFJBk2Qjx0k2C1cwiOFWLXUNA9K8?=
 =?us-ascii?Q?qrfyWPrOvki6naGq+qKgAUBljb8d5EMBseTo3JCUE7S86wWAJthVRfMyVcwt?=
 =?us-ascii?Q?jwJNTFtucGhhVIXkaNJO3je+2NFTQrtPo+GkozDAjFiQzlAlWPGF74J4LX1J?=
 =?us-ascii?Q?7LKNGlZ8hizOJK/Xo6utOd3lBuUREINsZkZBiMiWb769TtD3rumD8pmnhtJH?=
 =?us-ascii?Q?TYH1TLqtC+fA2qSYx6+iJ13KZVy/hYrsHPfsMtJ5uWemXXif5f+JtL4ve/WA?=
 =?us-ascii?Q?TrCkhWWt/rGrYI+4WBpR3QL0VXh3no1yAu4AQC4AU7kCk1ldRtqMJqbreMqk?=
 =?us-ascii?Q?7RVMpkjMihCPKDkcDhHy+rxriN1XDbvAmkJH3eE15i1O33eNNvKCsfwjB5S7?=
 =?us-ascii?Q?8FrEFEdwNqka5LQzeioQyPmCZliM1Ye/hAHF1mwg4umzs4cFx5rqqk3v780G?=
 =?us-ascii?Q?gAXBsg5cqhVnGoU9Fhb6Ah6JYnCV0uYzezG1VZFUH+LE7BMr/48XKX42DtQR?=
 =?us-ascii?Q?tCs2aaYZPZdgCytTrvlYHkJ1yCyCbMGwnG6IsqgWEQOA98Rcj3iFpC9kPfbT?=
 =?us-ascii?Q?xLIQ6z4szL1+4TP0Xw+yhVe4A6h+lhz40/5LZx/S07xj3OUPPXWG84V/kelx?=
 =?us-ascii?Q?fzEWMuJuyvKvLyCiwqj6p3ktaG55m1tJHYiPV7CpjIczY+fQS2KJwoot5MPa?=
 =?us-ascii?Q?o3BKKC6s6oqEcAdOp7ocDk948vL1OWuCNgNuQwZRdKmxTSpJYdYvTzSraMca?=
 =?us-ascii?Q?jAdwOVXZDI/vFr7Re6UbP6Rz1jMIeHrzAI2nLcb6u0WB4jaYvcjtdRIy0Sze?=
 =?us-ascii?Q?p1dRpUtvphUnsZT4l/YfCKq+gzH5r85LZIyQqRCapwSrLXYrxej3h3wtxhEP?=
 =?us-ascii?Q?3nx5079hN4HKV3aM9wYzW+9Kg6RRGWYrTR9MFVY7tWOBpkxH9Nyz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d87724d-688f-4715-01fc-08dee40543d7
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:00.0410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0IqpcU+Wv2tme738+Jk+5jtkDzGjnPGSaNSEPOomZMqdzHrfOAPDjA+hdIHXEkME2y7QhkDKM+1v8erlNR1yS1QgpktdXd57K78W9kWHC5ZIRpf9RPrUz/uZIR06iNq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23643

From: Andrew Davis <afd@ti.com>

commit 5178911d5c13308a0c2e80e0055c04f36a515bbf upstream.

The function i2c_match_id() is used to fetch the matching ID from
the i2c_device_id table. This is often used to then retrieve the
matching driver_data. This can be done in one step with the helper
i2c_get_match_data().

This helper has a couple other benefits:
 * It doesn't need the i2c_device_id passed in so we do not need
   to have that forward declared, allowing us to remove those or
   move the i2c_device_id table down to its more natural spot
   with the other module info.
 * It also checks for device match data, which allows for OF and
   ACPI based probing. That means we do not have to manually check
   those first and can remove those checks.

Signed-off-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20240403203633.914389-14-afd@ti.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 5eba180b66a0..4f54a50f2c12 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -626,20 +626,12 @@ static void lm75_remove(void *data)
 	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
 }
=20
-static const struct i2c_device_id lm75_ids[];
-
 static int lm75_probe(struct i2c_client *client)
 {
 	struct device *dev =3D &client->dev;
 	struct device *hwmon_dev;
 	struct lm75_data *data;
 	int status, err;
-	enum lm75_type kind;
-
-	if (client->dev.of_node)
-		kind =3D (uintptr_t)of_device_get_match_data(&client->dev);
-	else
-		kind =3D i2c_match_id(lm75_ids, client)->driver_data;
=20
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -650,7 +642,7 @@ static int lm75_probe(struct i2c_client *client)
 		return -ENOMEM;
=20
 	data->client =3D client;
-	data->kind =3D kind;
+	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
 	data->vs =3D devm_regulator_get(dev, "vs");
 	if (IS_ERR(data->vs))
--=20
2.54.0


