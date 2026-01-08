Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F3FCF6AB6
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:40 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3051.1767864696336786136
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LguHJZKy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYW6hFIpONfIiBpCNfxvs9nKj2Qy1y6hcpOrD/Z8FJp81t/lNvckVMgV7YYri4Dq+wvtPuZcdxi6iJVJGxUWatdvxvfxVYE7wEfiAenWGNh5QuFovkv1+wAMbk1b8HGOO86B7OLdIw0osHKmyHTDsxt/OyjPurI/u/4xm4IOfIO2L4/p/STEXRAgKp3i5shcQgcwiynuWqH4MQyOPsJQukz/WK8LkqNR0hULjF8ervgNAx2AD49ZbkjX0yvSQNpUPEO69szYHCtMh/bcPKbLj+9iKW5p/jZgwnhRMWB+/tgbJ4nrc6RofhvKXdxjPTLntV8/VZZVBnmhgFgz/G/kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DYSob2tcfxkq2KLDwUgcYyFZ1BV9n4XwD9/LE99pgo=;
 b=SXqWp6lbHCFLDSPKypaanRTnH0sLX3NXCnIAdKxMb6hCkhAuyGiIOYi6YPuIXruL9XT2UjG7GHpsGtkOaow1LqVYlQDX1UENs8AdKL0qZ2PHdRqGW82ZqPXqgFLsJTuHcxZDi7k7Cp1n5mVX+KhGTuqjuaLh7+MESSRMFFznD2fUOhzNSSBGrBGFzNToQmo08jCZu5sFuqFFbKVMc8mDLzbukDx1m+4VjmW6wqiO6gDA9UctT30+vqM6FbI8YpRREQzR5PE98aMgL6g+HdsG+Cai+/bP/Px1ZDkP4FYfDchyo+vPpdIwgu6z4OPmfuiqu0WSk1x9XWC8wAaFBXxO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DYSob2tcfxkq2KLDwUgcYyFZ1BV9n4XwD9/LE99pgo=;
 b=LguHJZKyrtv9oJO0DN7ih582GiU6eprFkrQcjAvlu6yYHXY3SeqISoTkX/4Tysp50HXn78cjeYOgRnPp0YA9JddqecZbu24pvpcBPkQPWQVU2iO0BwnYpmYAL9n1wx1qGlppUX1VkXUyy3fgqz3nuhTC6E6D7IJiR/TFCGD71gQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:34 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 17/19] hwmon: (tmp108) Add support for I3C device
Date: Thu,  8 Jan 2026 10:30:21 +0100
Message-ID: <20260108093023.489513-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85ae4533-cf51-4514-a1b4-08de4e98b689
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dSMCmEj1FbKUXCAMWrU5NwJfjwWRFdI9J/n/rUvCvS2d/gBbkVebhzdsG10v?=
 =?us-ascii?Q?YwY/Yd2AkkkALuEHICM+Z0tx3MFNHTwrMxF07e+83CXfOwuBcPP7EgwbqHe8?=
 =?us-ascii?Q?Fiadlearyr3ybFB1gbzwqfT1Y0v2p3rvzNKiDk7mpq6Rng0LymaV/PTSth+u?=
 =?us-ascii?Q?rmV0u14bXUmbA7OdjiPuXDVHzAtNdDgFBsDe9MYnl5mjiVsKmUlm46eQn20s?=
 =?us-ascii?Q?wrx3nZ1pysjHnxtS6mOZ/WNrsTfft9VyuN3KRo08tV0iR2xLzxcLrCci4tOH?=
 =?us-ascii?Q?Ag2ASISgKLOp3RMya7zupoSVJjPXzleSop0cvi8bB3VEZUs4LXUIYngzuTUo?=
 =?us-ascii?Q?A/J890sJmpNsjFJ30DPRNMPC9OM0ZhGjeLZR0LDjt6SUwaOOokdFJR6y+90b?=
 =?us-ascii?Q?aCesZ2Q/MfAxSMLmBLqy11Wxgyi+HMc/tZFyU7QtydZ1fFWmHRu6FaxzgtZx?=
 =?us-ascii?Q?DOGCEyS+Vnfdtg0d7qZ3VgffN2E3k4ixeHXXgBslRr6q+3CA3f1OFqRoD4bQ?=
 =?us-ascii?Q?Qqgs30Gz8f0/23TfSV68YhXcSBj1pIUs0xlkW85tnBqqu8sz8QhHDSPRkYWl?=
 =?us-ascii?Q?Mw//2X2zTswdCpcxnN8c9aJK5EgF2cgWs9JH9G4eKOVEA5fXJGOERbUO7GWg?=
 =?us-ascii?Q?zqohSEzGy44W8ITXz9+4jB58/20PlTdI5VdhICsnZ5ckqjVnAjLvbU46QPUb?=
 =?us-ascii?Q?GW8AS73DKTheKL1M65N6eco5mruHkRBxwUlyh8elWW+vbeY2g2KjFvLotE6R?=
 =?us-ascii?Q?UijWa4lyUpXiJ5XhWKULWpj4NyFOf1Gk04sfOdlZ3SMtYQBB5a0iGU44WK8B?=
 =?us-ascii?Q?jtx/yuhmfmq2IAWh9eWsa2wC/llJ7gts27L9h8/ZnpAs57QpSKwsqHLCmN9j?=
 =?us-ascii?Q?+8pKxdxA//1rZEwSwOv3QhqDFUWPfj+zErEH6TSjqZfSl8e/JYgJ1q4MJB6z?=
 =?us-ascii?Q?8cMo4drVYOPxEGi/LO9D4b4aO68O99Kv0Y/41I1tAgaX+ENAElCCv1ITHWKn?=
 =?us-ascii?Q?/xrEFX1cLjt1/aTXqNtO/eaOukk7KtmiwmYSov2GbTFQK/jPdcOghNIWfsLO?=
 =?us-ascii?Q?h9exwvQY8PdUj7MvItfhM27FyHxyCmdOoQFlJoG3KqYNlgIOczGQlrP0bK00?=
 =?us-ascii?Q?k7DV8NXcXkLxAgHO4XvSQaeBoQJXhNMMvoY+xxvRC0RrBMLT6wBE3SSqWflV?=
 =?us-ascii?Q?NLp1XH1M0tkERdt7MPhBvO/c9jm9Z8Y1IqRNOW0OYbWDDlVvDp1dmfuXYW0z?=
 =?us-ascii?Q?HLR4HsNQQYpuvGcw0U8ny77DY+BGRyLhaBKA+WnkW2pcfKcY4ThtqMuiCWPR?=
 =?us-ascii?Q?F4s3A1c0qN7Q9AO13Vhq4cIvMJ/Y5IRryd2KJ9QzWbynfONUpewTP7ktG466?=
 =?us-ascii?Q?KBNvg3U1xYbQ/uEcNduTb/T8k62fO0UIhgTATSSCLi7/NHsvxb38VOxDxDh+?=
 =?us-ascii?Q?42jTDu1r1Y9dyfQSP4SskaBBnrYP8gbnn38nXPu2y82xtTj78EG+iv4Es0Eh?=
 =?us-ascii?Q?40xWB6wbZn0ZL4lIip6CuUyomXeoPVNodwiZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bHXC3ntColNAUN1kGwk2378eV4RozFDQVSt5R21alaPL81cYwzlZ2ZX0kdTU?=
 =?us-ascii?Q?lVbVF3hHlwguP4tYDUl79UsJt6tykL2gw26+sbJeSy8l2O/QUztPBGgtOjTp?=
 =?us-ascii?Q?o8i6zY0UtbTPztvMZc8HVDKzBrXzMy51SvEivxcg0p+7F3EfnjnBoV39mME4?=
 =?us-ascii?Q?L7lrV6D6tmoZlz6Dlu6fpc4kWqbbV4YBxmfVfzHcx5VbIN2L9H4k1aFExnhz?=
 =?us-ascii?Q?3wtrWyRzMUskV2TaB2ymH6PEb+ZP2msItZviVzWtw3IpO/o+lijUwZpkxKKl?=
 =?us-ascii?Q?S5+Dz0iKMtfClXzZEqp42I8tC5Nm3nVnt1a1As6O4Vthao1NeNACawii2wMj?=
 =?us-ascii?Q?r9qthxoxKhGkfjzxCM+/HQhTHTWP0cNnVRKlLbU7ocI9nt9vLEOS2oX6WsG0?=
 =?us-ascii?Q?Q/W6YJiq0aC3nCEVYDo7A+MjbuvhIH98M9C9LMKVCLfU94w0V7SMQoyIDtlC?=
 =?us-ascii?Q?axKQIVZtz4h5uSdM55fjSbtq1+WIVU11Qk0H51XFdSfOMqHdQGZWMKb/kB/s?=
 =?us-ascii?Q?aNLTE4j9GsteIzDjWycbjz6mWfJM6aRB/MsGbWrpnhFIpUVjbXi35uAVVDue?=
 =?us-ascii?Q?5m8wm14vumuIilWi//H4lBNOOiPcODwBfv1ypU5DcEmVlYuICQMePW0hpvn6?=
 =?us-ascii?Q?Uc+a0szevbo0rtLALL9gxnA6I23Qbk9a9gqxKMhLDiRuGZhc1I3StHUykRLU?=
 =?us-ascii?Q?poPwYf9LRfjXtgPiPkT4rrxawLU79CYVyzylIzpVWQeXC1z0HZDzI/Htkg3K?=
 =?us-ascii?Q?hBkuN0whqxunnBdyUO4nuyuEd8RYFAbjEKPH6gVjQia4en5SYA+LDvKLwmXE?=
 =?us-ascii?Q?/HMjFrrON3sNTEgbF6NF9Oj2sAtpN3TIe8Rh/Eh8wPrFx9V9v33qf+WZOnJN?=
 =?us-ascii?Q?uPOKM4sbS9UjOIabrj3xPnIwE/S8wZsGfbNL9i0cabblzjYMTA3sXcX2CsuI?=
 =?us-ascii?Q?ia1JM8U8xvQ54vtv8zAymwhmqGI6cQtOkKv3Qw9U0aAqu25JTKrTLYvrHgft?=
 =?us-ascii?Q?4/B48wndS7efuvQka7g+jptWZjV9YlUHdM+Di8F9USL/aFBwNqmrNSGimtCe?=
 =?us-ascii?Q?94IETXalriTxHurYTPHdW2N2Xg/YyqMpw90kGrSqGg/e/MWmA0H3Im3Yewg/?=
 =?us-ascii?Q?fY80Ie7xr3Wpu4R1rp6DTJYTA/SJSqHN+NnhI9aqJ7SJ/Wk+aCzLfvGx26Im?=
 =?us-ascii?Q?wf1zafeC8S07/f+xcEEsrx9gtZFft6pMC/b3M2lXGaEjMSOye5xI0v/p7ftr?=
 =?us-ascii?Q?U4PGwVLK7Ici1p/9BQae2GMQk5DHFtXSEGaWKiduDdf/WifBUXDZ9Sv16QrA?=
 =?us-ascii?Q?MCMPh9cB61sRIYM9ibu70T/I2TPZwYTSCyzHrdKCbaAVdWEG3gAPJhQSaiif?=
 =?us-ascii?Q?Zscx1d+DNNlsAm/4CqqeLNN8oFQJW0Owgkl0Sfi75g4geYELqem+5hvdyK4f?=
 =?us-ascii?Q?TeAzfW/43ZvfircjenD+C5f9PkoVqUr6JNXnfCuyI8Sglf+V27z8K02Hoxp+?=
 =?us-ascii?Q?sV2R6YkHzJsikjRNA6KItylA+ndk+6lWAx3AA0Xw1NaB5n0g3jcqZ9ydb3kc?=
 =?us-ascii?Q?McYtfKznYMBldP4tqNFwYyPMP8xiwumZUCtrywhOCOeXEK8AtoA2MoZhN8n7?=
 =?us-ascii?Q?7FEIwgoT5StFIZGzPpofmDbe1h839pmHXM2LMHilCAPx8NSAlqky0k5iMvCL?=
 =?us-ascii?Q?zgFlU8eEHrJsfyKTCmLrGtgyfHg+guJRpPMlGhe8Yt1oZSRej+yv+2cLwehu?=
 =?us-ascii?Q?1MW8lDQm8VHzh8lw824PlcGW+SEsxF/Nnv7ARX6A8w/wuwFw0OZ9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ae4533-cf51-4514-a1b4-08de4e98b689
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:34.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUC5JfPOrITJICk2gefEWzasXykVIQWYGoubSYiWtJbi5UbND1u/fqwgJjfqEDIATEcHjOXq9vHe56Wvq8Krn2PK1hdGgxrIRqtvbF+LPPdiVNQgfXOF9snfS1f0NvN1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21476

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
index 6cb831da6048..c986cda1c7dd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2275,6 +2275,7 @@ config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
 	select REGMAP_I2C
+	select REGMAP_I3C if I3C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
 	  sensor chips and NXP P3T1085.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index bfbea6349a95..1f36af2cd2d9 100644
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
2.43.0


