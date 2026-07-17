Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECFC44521
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13288.1784294057249986336
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vLXFOhTk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0wIUZNXFW2OeZdquLhoOocSO7PvtSwj13+EtGOXxroR4bHEkiKr+UrM93zu0OCal+no8+kfpSFU2mG+tdqSTjOPFP0wwP00AC7PsztBsSaE5Kolf+BYYowpaTDTjyKu9A6q9fe0vg3mcz6XkRB0me4w8l4q/SicCmZSddqH6u8VlLJt9S3/zI2F0JJaMsY8pWDlU5Opi9KYhYeWy6D4NMd8bAS2WC87W4IPyqTD1MQ8oypGdlW3kq87C7V2fHsdQYwca04XZUHDPmvTCApNJVRmz5EcoyJ8/SPeX0tliMDsQ9VGnWtFoDBHrruW/jYdGLswyq8Vix8UvjV5IbdW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba9vLg8uilGMjG0ZY4d+mht9xtSMJ96BmdQhnXNNukc=;
 b=QO9JTMSN3zLDPx03DqZsAogfgptHVti0m4iVQBYNXVpnInEsBfKEkS3wPJMIS4G7ExP34ZPHuF5qkqVSiUwiTgyhbT3uTkST7PHSOCC9dsOJhlq38b1SH/mdU7khBW+MOUdQrtrlrrNtwldVuDWQvq5WA6EdnhRqldBZgnFgpEtiA34/LyGeFOzRu2g1YpKt4TVyzNP2zEyyz5QyZr2cfmSLeEnpd9vfrDGawDX8KPajZgE9mwILhjQLppkzb5xKuVj+acf92zclPFkkLAO7jMfHgU+5wLaycCkUcdYrw15/ERaqS2HS4UxBvgRovHpFj3bpHyJ65WrxzSYIF0BBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba9vLg8uilGMjG0ZY4d+mht9xtSMJ96BmdQhnXNNukc=;
 b=vLXFOhTkPDhD7R+h8Wv12yuB87wQyF+ekv4Un/JcnKMD8YfjJuInTUkc6C6p7cuNF51bE5ryRHrEQKC9X+ToYs8Nyu60+l4f2+d/1XohajnbYdlbes+pO5XZu9VqTcJgBYaJmMnFsTQSKg6RGVnjA3TEb/kauXx3QWWuxzDmc0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:15 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/23] hwmon: (lm75) Remove superfluous 'client' member from private struct
Date: Fri, 17 Jul 2026 15:12:38 +0200
Message-ID: <20260717131241.2233788-21-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 916cd821-6183-489b-e7c8-08dee4054c9e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	/47m/6HIF8eM17x9mTBi0Qnpxep/hEpFDKw3rW5NhCxS7HJqpW1HbTxKUmJy1Opu6B2EZINpWIUqmkv5SDCIUVOF5MNxr7ejVekj4D+Je+CLRuzFyClptsHxBIBA9zCwExP4OOq3NLFVXJlc4NCYXjUPPAKaHucCwUHDQ6HZy1ZiXuusQ8Yk5BJ2BrbdoJCWBQlZ0j0OXmBRe/mIKWAWuoU96pqDfSJajX/07IryOK39IZGPXhs2yb7PzKuVwJ09ZLv1MVJF85Yo9lpZCbTD7E1Iw0nVZBl25n8E1anZI6J4NItA3Zzf8VdFDXOlBY/XOmyNxDRBdDBOFo19yxzavYH4kUpZ7gfeFzW/KwpOczWdamSs4bDi3gqPH0G1YvfptrajCU1DMwFEmUrAObdXnnjXM19WWnYK5xecDCdnWD/sy+DHvV+5aBXYgMcReC4Y/7uVGsr6oa6Twkt8i/0+Btd4+xhpTjhu2aNHeUo6shwxyTHWx+yMyg05YyNbUAjSajHiFrn5ydvyLAyUtzFia4QDwiofnxIcOBr3lS6KDHInJ2gzpukkwL4DrmyLZ6J4xEDAWsukpOTBHNWaw8iejh2+XTzYwjdGaW7C6dAiDb/vHkoM1qK3l2afWWlu36HtiqGkXrdZIY+5SID2Fd4v1YJN0Co6wtQIngQcmtlKffOWEGg+XPg+3wnEPcKzcKpWO4K/zPG15VIF7kv3pAFM/DXtZ/LkkSKUivN+TRE1zQA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C0vLngDNiAjKAgdY1DyOfkdovasCAIMzQlIMrQxvz0oelF0WxkNp34VNybc+?=
 =?us-ascii?Q?wCjExjwO+fPvTxTdimp8HFYzf3Mgi/JbzUR2UiH+AQXwvb89P8DIUAtsSgLB?=
 =?us-ascii?Q?hFW/ks+JiIVFmZQ656xetqC042yULffi8pKve4ADtduJdgGj5arApO1sMZjS?=
 =?us-ascii?Q?4Mmr9mZEAhM7EDTVycPWb1ctxpV9ViqTMD5Y4r3rhwaKntCRdKA8qjEYcWIj?=
 =?us-ascii?Q?UjsYlOKfbR0tinQ23N8zp4viY74WtyWTAWkb/4o3F5y0IijPDlB9kWhbInfx?=
 =?us-ascii?Q?Z4oo1qskKLvi/RUQePUORADyh0AB05TliFvR5t2wM9AdcbFoX1qR0TzNwply?=
 =?us-ascii?Q?D34epqEsdthtkdhrRo1DI6/SNRioZc7thakgJBANx1Hx8onDwwdhI3Uq0p8K?=
 =?us-ascii?Q?qOZdkMp0pXnZOWkyMKdFChxLLv8sOmPhkT0BLo05cFTlBy9MA91raouVgWge?=
 =?us-ascii?Q?unQJ0qLtFBLHGOv5QJio6vGr3zV6O4ow3ldrfPiPhnc1n5bl401CwEoMDC7T?=
 =?us-ascii?Q?kK63GtCoHsPRUCb/KaHgRRDRk1x2yN8Q7X8Mr6NEgOmyabIpEocXuOnUh10+?=
 =?us-ascii?Q?hOjMbqGiaNN0kXn5+7mMhcjMo0jucUmpiqg+/euHUgZ2MeWyUVRe8UA3vpxT?=
 =?us-ascii?Q?TQuQDe5igaCDSuHTsGhH5Ns1zHLffIFedFciQr+FNjVvgga42eTjRmtdtvi7?=
 =?us-ascii?Q?q0/KPM9es4RXL66OAf5zqieaUqJLZj9rX8tEcgp/7bHlFloW86a2QGTYu+Qs?=
 =?us-ascii?Q?XR6RQ/iQTLnCTmPGL3+LYqdqzlT98cXXAchy7mlScVyAH0NvqMqK6lTgOCIp?=
 =?us-ascii?Q?JVEHTOMBzQFPI5Q2a/VaL1E+CTPpeZ5OZpfZ95IhXOTG2Le/g5cwEtAwWXWg?=
 =?us-ascii?Q?sLkB6J3hpLZkV2c5+bkuHRNu3e5sp3fJTZAgN9ZqJoCPKJj1HK9mGoQVXcfq?=
 =?us-ascii?Q?u/2MMz5bo5/LDyi0F3tWAkQi6JRE/VyhroBsbv5EWWoAQNtcatKtc4DSaJn6?=
 =?us-ascii?Q?RTCbtJcZWO5iJ6WSc38l1dfHTLCQ0bPflLRzT81NKqD0tACPj4zgkChD68KE?=
 =?us-ascii?Q?UPk5ddA8mNvys2y1SMIzI2wagFOWt1YQrmdAZ4J7sPewJlv6ODLDm4Zbjeqc?=
 =?us-ascii?Q?cxySNBaANaLJkSGPq+nR3mDVcCDrtV+wdWQ1+FbJ22MmrYwflf5H5Pk0lV8P?=
 =?us-ascii?Q?mCJTMeZP7XV97PSyE7WT8XhIz8153bYkYqZ8k6Tn4oICfNZj94zdxXjh+LUp?=
 =?us-ascii?Q?helon4hunfPvCXfdNFHV8F0B8cChHN4MjuNP9X/PwPI0p9u9AXGZjb0ZPmvI?=
 =?us-ascii?Q?w2uBwI3wQWsqVtZWvXXmYq93BJHOy3MPkrWoDjc/fFaSTepuhwPj7qk+WaZJ?=
 =?us-ascii?Q?zOneHEGo87xfeSCKuTAiCViCnv8XJWC0BMnjBCsRoTzQKuiSrTIICU0HJi68?=
 =?us-ascii?Q?3vZCmwHvGHsYpkMhn3l8pG2NOtaOyGyvs188T5KYuXLUlfiCV89Q0m2P/tIG?=
 =?us-ascii?Q?LYJxydI1fLYe4lo2c5ZUMoYcfkPbE+z5GjdbQQ3ZMQdMIRmF2HmqH2WudJAC?=
 =?us-ascii?Q?woEPldtpK6HiAASOBazJ2htAJxI2E7XLCfodTbCIBdfFzseXEYTVZ8Tqra8L?=
 =?us-ascii?Q?9L2urO+RIFDPLq6rTAEaR1k3pGbND4AzX5Uj02NTB91YtZRnUMiR10w0KxEa?=
 =?us-ascii?Q?zAzhnpZoU43aFgpUrETG3zDCVBDYsMYycb5nIPVPJyFIGoa2CEXQ8m1Pvrvd?=
 =?us-ascii?Q?U1COGua4D0/bMafO4vUvGzpzZvjYIWoNde5stmSa7feTyBWYOldv?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916cd821-6183-489b-e7c8-08dee4054c9e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:14.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJpHxoxnF7Y8DjuKdGaiP+3pZn4IGWB0gALg8A0EJwdUyvXAiLFm5ZOmkC3kvi4YtOCebFL0aYqvdqcc+VYMfEcHrKs9ckJbFlDGjcBUm5chdxIUm3vCSHzE4kyMtwMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23648

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7a5c24da4b3c96949a6d93c3c7fa4133c6f2b88e upstream.

The regmap-only conversion allows us to store the client-pointer as the
'context' parameter for regmap. This not only makes the private struct
smaller, but also allows proper separation of I2C and I3C in the future.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241219225522.3490-10-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 0553e2e4520b..cddd940c01ce 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -106,9 +106,7 @@ static const unsigned short normal_i2c[] =3D { 0x48, 0x=
49, 0x4a, 0x4b, 0x4c,
 #define LM75_REG_MAX		0x03
 #define PCT2075_REG_IDLE	0x04
=20
-/* Each client has this additional data */
 struct lm75_data {
-	struct i2c_client		*client;
 	struct regmap			*regmap;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
@@ -573,8 +571,8 @@ static bool lm75_is_volatile_reg(struct device *dev, un=
signed int reg)
=20
 static int lm75_i2c_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
 {
-	struct lm75_data *data =3D context;
-	struct i2c_client *client =3D data->client;
+	struct i2c_client *client =3D context;
+	struct lm75_data *data =3D i2c_get_clientdata(client);
 	int ret;
=20
 	if (reg =3D=3D LM75_REG_CONF) {
@@ -593,8 +591,8 @@ static int lm75_i2c_reg_read(void *context, unsigned in=
t reg, unsigned int *val)
=20
 static int lm75_i2c_reg_write(void *context, unsigned int reg, unsigned in=
t val)
 {
-	struct lm75_data *data =3D context;
-	struct i2c_client *client =3D data->client;
+	struct i2c_client *client =3D context;
+	struct lm75_data *data =3D i2c_get_clientdata(client);
=20
 	if (reg =3D=3D PCT2075_REG_IDLE ||
 	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits))
@@ -646,14 +644,13 @@ static int lm75_probe(struct i2c_client *client)
 	/* needed by custom regmap callbacks */
 	dev_set_drvdata(dev, data);
=20
-	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
 	err =3D devm_regulator_get_enable(dev, "vs");
 	if (err)
 		return err;
=20
-	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
+	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, client,
 					&lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
--=20
2.54.0


