Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB2C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13276.1784294037242529929
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EneOvly7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.51, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tktwThAzRFmexgU1t0RpTmIc+S3W8Ppw1cAg44eUuP28KcAwx5X49O/bTWvWJrx4D48bEQX3T12bk33pBr+LDjecyzXMDkMQnd4bFVsBZpMiFaZppfINb+dVKpaxybqxXdud7h2D0RgD35HjyaWHiMkYrkdKmK9OZUTEG3Dn/wuPpkgHc50I+DrEL9jD5N1cstU3e4MypQ91zlLobQ3hYZYRZz0OeqICroay/PmzYY8EUkreSckj4POPc7Q4zikKCBzcwjxAT3mb2JgBbb5HwFujNebn1WtFzHR2GZf6VMIGFx2adJ22rjhmLdrTK/Z6WlG8RgRhdSZzvXUDbq3hiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aSXstW4maQqugIJVR3gjM1JTOK42jBpEo7O+ays+/o=;
 b=ahgUMaR70QbdVNr4CRX4tpTjsDJcVYOa/LNXDc5d9OgAGtUasmJA8nD3e3qlCPB+jZJJnkpyrzcDdHl9cfw2849M52nadMcZLX5mTNWpdci22EfokJ8pxzu8VhOfIsslvn5ExRKpjaj9LejB/48LL3qlM/Ogw3Wb6vVpeGc0ee8u3vjyQFtHa2cOG2sqGah1EtpF8Bw1UwFsK97hYj+fmQ6jY6dRdvLXN/V43+Eee3H2ubHjkW7qMVbpeVBkMNVgpjAvwFjhkq3LYW4dP6++gjirwl8ZMbL4N6a51c2W6PTSUfI4XEYWEXlnChxcoM3xMfcvCQniGhzwMBHa4eB8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aSXstW4maQqugIJVR3gjM1JTOK42jBpEo7O+ays+/o=;
 b=EneOvly72fdvdoV+lVCEeVAgIxlDosSJOQ4FHmzqusgOfCiamRAiKCxJIYygTVuqZ0EvgCdYC+lu1U1HQeCUsNZHVxMj9Qoh5f8NAadUYvMufvYjPiCjdl57m0A//uxH6QWUOM9wgf7tRxu4Z3ydAmUVQcudAaWz/y01huWqslg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:54 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/23] hwmon: (lm75) Add AMS AS6200 temperature sensor
Date: Fri, 17 Jul 2026 15:12:31 +0200
Message-ID: <20260717131241.2233788-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2777ac20-2c33-4840-74a9-08dee405403e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|6133799003|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	tECpHnG38SYW3NnTEwrj87O+C3SgiMM7IJqWIpLGYawxVaNqu42s+na4RJw6rmFBS7Qr80aV/rqkBQp1qYK/k5hDMl/tHdWpkEAazLbe4Y8Ba616wF1knhhHxiC+fg033lKWtl6bm7fHvCY/FQ1nS3TtNVnBV/lizwwlipq8CWrhR7kTnUR1PTmORv9v1kiJAh4VSIkKz/H+DZiDWpaLAwVj9UhVfCZrm5kv0m2CRuPdfxgEJm784XeBGWsUBUGsYN56BNY1MSXOEhVVVIz35RkAjmjAateP2nPky+8tCNNxjj/YMoQAGcsuc10TAAACrgh5bQUGQMyYu/bT5L2Wj4czT/HEyfxEW/+3fpCiLB3ManPGwfI4F+vPSQACVICnGoaUrNLkPq+VVfKdALGFQT/qvmTjbjcCsy0xu1JJ8006b6LnSEHlfRad/o+RES5qkdQyrH/QhwjNaW1RejEFMJ868xlWCy8xyjNW0qOCI082lALI+Rjdl4CiJFzHkHoNeIgIWVcNpfMDTg9/PpBxkV5kAFvqxggAL/AfvMXe2yZ/uGlnwt+RVD7JSYa1ciA0/YD9vzZDXhEJdl7USV5WxNQMxV0Cu1LB2YJaup6uHOnEXWk89fkj9j6p8AWE9uJVc8mJCbm5aL5M1hqE9c5rgs1ODqsy7aVFIuQis+y/JY9e4YMfH0CITsVCk4zNYTs6ok8uVr+6kzEdZV6jp9EF0v2R6fkS7vlml7FTUzrUU98=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(6133799003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zL1CWqEHMM8WtCiXyMIH4/dggvJTAOU2wudDNkNOP8fDHHDDwD0mxs0muANj?=
 =?us-ascii?Q?mcgj2STHpVJ0mGVKirynXQkJHY9BTgSlVDk6iClMVW0quDPuS006Pi4MyCgV?=
 =?us-ascii?Q?61iQGJGYKFeOl3423/JJoqgEGaM+YJxRUxL10Wn39j2eOnBge7HTc3he94XH?=
 =?us-ascii?Q?AkroIau93nfnaCZ8HfenOkT7AU2vIC6lnnCwjZdleEsK2mACWe1xUpvWOCe+?=
 =?us-ascii?Q?K+4lbtxJGUz/P8gY9Ggxs6wEBkNJntkUy1SSuOUaPcAKwfWMOPFrIWlrpgtp?=
 =?us-ascii?Q?zo9ScNiWR2wiNwg6IsJV06HJGZBS2ZjFODSqLI/1WSI8IxReUJV1AzyTwClZ?=
 =?us-ascii?Q?lfnkb4nT6TBZGfe1Bzebi0bjKlK9pT7lt1K5s2uYMnShjHmy1SY+PdwxUJli?=
 =?us-ascii?Q?Lc80bjE+dDAnt03nqBFV1DBadHqLu6/guI83FhTNZ0BDQDXT4ECd99ViidqP?=
 =?us-ascii?Q?PiKIeXK5kXV/90IsGtVVdDLRgSCoSZQN15q3CE5lpMxB0DkzVrByXOBcO/PB?=
 =?us-ascii?Q?0eD0+j/yBGiV/Ljq4N64+Fx0TuDfhj7nueU9TGuKyoUEMKuF/RYAuDrb4Z4A?=
 =?us-ascii?Q?5u7xVcSKotwN3Q4Ln9K8UgNp17LTFKP9kZeM79fvDtVo/o41IO4sJfh4xKTd?=
 =?us-ascii?Q?yZpEZWZwVzMxWbf6HHWLjdhH7eAJxE/nPKXRa+M7oFTSWYD5BvEyA2goxdT8?=
 =?us-ascii?Q?5R9KuRpmYbo86PDMlTlueVgxH7XktEl4CjgwzKDKbYs46px0D5wMgnaTcpvt?=
 =?us-ascii?Q?XR7mZ/35AO2NYFVwhKV+CeIifN6Q8OP0P0I7eCoG5lcBhBajeqySGFuaUtjN?=
 =?us-ascii?Q?fEcE0QjBKf9d1BrL/K+0VgUWaNlCO6dSSY7V3x4x1LNbSki2PfnihxRJnt3x?=
 =?us-ascii?Q?/++yvGTVEn+WBTcB6bGV/v8IzsNfCC+9oCuBPNREOxPzFE35rh3LNVOizNOa?=
 =?us-ascii?Q?mS8Jr+fxalxkiQeTKSSf6blguQltb1CNRlwPUtgEi/qq6krLR/ETb88zgRiS?=
 =?us-ascii?Q?kckuYG5cKigEv47hbq+wxOBNHjZ/SIsZudiZ1zbP8buhGBWdBzw1pHv6Lq1y?=
 =?us-ascii?Q?TY4t8hiwb2Y6i9WnfOJtzZRSPhT6+lIHRt8abtLM5TANyPwX39vcnonlP3iF?=
 =?us-ascii?Q?Z1Ky7i4O9yp0pyKLQdG7NnB23A1r4EL99X/PsQy8PUXKRDtMqDYkpf4Pjxsd?=
 =?us-ascii?Q?Lv01JfvggU6DafZHImNhs6mzUR1s+mHN75GWQe5rEkg2csqKWFDyLBo/7A6y?=
 =?us-ascii?Q?ojwPhtdASYB+Q34oKLut0Hl/cXrVkquymWaKWougTgjOd3kYjlzueOD/2jAO?=
 =?us-ascii?Q?Bs4X5DSDHnGKQ4t0sAEcrBxgxCYxOYrrdQE9tsHrqbfDY1hAFu74Sc9nMNR/?=
 =?us-ascii?Q?Zoj/XfGErtWkQskk6g4UKGXHGhkp0vwCUjWUCNrMQEJ0o842YIN/24Sz1g2Q?=
 =?us-ascii?Q?/2ojd6THOrgkzGVDt0GJzJfNbyJy9BGhWMABuVwyeRT/f9fGWNolQzIvX3wY?=
 =?us-ascii?Q?mIK589NSYPYhAUcgj16l6ukQSnYb5sim91gfOWVCi9u4lHC98kQGBNMp74en?=
 =?us-ascii?Q?MwpCnKrkPEa1INFYb1Z7/+k2fYm3UamJJ66Prx7i78SJ9JxyIRzwo+zFki4r?=
 =?us-ascii?Q?aWjNZEx62iu0M+sRjazIZg/jaGI7hR9ICKWlqc8mIjqWzFbBp0HEiokoPl+c?=
 =?us-ascii?Q?3hZHHCaI9gcDCEd5ZXMn5374hrQcNMLRajYa1vFYQ5qczlq0bSBI+3Y2MlTi?=
 =?us-ascii?Q?ndU2Nt1LuupITDrbCa5EAsdvQPSXpasUIOTmpYDr01Xf9Sk7ypa4?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2777ac20-2c33-4840-74a9-08dee405403e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:53.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVewwcykH0/L1ZXRWISx3TUk09nz3/DwfLUQtbzHoWMj3dqqaUWNFWp9Lk98wSFcER8skiPRuMn3pXYtVlUx7SRXSDJV6cnhZdJl8KmAfvu0MgbglL6JT8jHBt7jFCfo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23641

From: Abdel Alkuor <alkuor@gmail.com>

commit 4b6358e1fe4668e88cd654b345a2a62da9d373f7 upstream.

as6200 is a temperature sensor with 0.0625=C2=B0C resolution and a
range between -40=C2=B0C to 125=C2=B0C.

By default, the driver configures as6200 as following:
- Converstion rate: 8 Hz
- Conversion mode: continuous
- Consecutive fault counts: 4 samples
- Alert state: high polarity
- Alert mode: comparator mode

Interrupt is supported for the alert pin.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Link: https://lore.kernel.org/r/d1686678991bf8ee0d00cb08ca046798f37ca4b3.17=
03127334.git.alkuor@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/lm75.rst |  10 ++++
 drivers/hwmon/lm75.c         | 108 ++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 8d0ab4ad5fb5..6adab608dd05 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -133,6 +133,16 @@ Supported chips:
=20
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
=20
+  * AMS OSRAM AS6200
+
+    Prefix: 'as6200'
+
+    Addresses scanned: none
+
+    Datasheet: Publicly available at the AMS website
+
+               https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.=
pdf
+
 Author: Frodo Looijaard <frodol@dds.nl>
=20
 Description
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 58f8be462816..f6e16dfa11c5 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -7,6 +7,7 @@
=20
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
@@ -25,6 +26,7 @@
=20
 enum lm75_type {		/* keep sorted in alphabetical order */
 	adt75,
+	as6200,
 	at30ts74,
 	ds1775,
 	ds75,
@@ -55,6 +57,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
=20
 /**
  * struct lm75_params - lm75 configuration parameters.
+ * @config_reg_16bits:	Configure register size is 2 bytes.
  * @set_mask:		Bits to set in configuration register when configuring
  *			the chip.
  * @clr_mask:		Bits to clear in configuration register when configuring
@@ -75,17 +78,20 @@ enum lm75_type {		/* keep sorted in alphabetical order =
*/
  * @sample_times:	All the possible sample times to be set. Mandatory if
  *			num_sample_times is larger than 1. If set, number of
  *			entries must match num_sample_times.
+ * @alarm:		Alarm bit is supported.
  */
=20
 struct lm75_params {
-	u8			set_mask;
-	u8			clr_mask;
+	bool			config_reg_16bits;
+	u16			set_mask;
+	u16			clr_mask;
 	u8			default_resolution;
 	u8			resolution_limits;
 	const u8		*resolutions;
 	unsigned int		default_sample_time;
 	u8			num_sample_times;
 	const unsigned int	*sample_times;
+	bool			alarm;
 };
=20
 /* Addresses scanned */
@@ -104,8 +110,8 @@ struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
 	struct regulator		*vs;
-	u8				orig_conf;
-	u8				current_conf;
+	u16				orig_conf;
+	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -128,6 +134,15 @@ static const struct lm75_params device_params[] =3D {
 		.default_resolution =3D 12,
 		.default_sample_time =3D MSEC_PER_SEC / 10,
 	},
+	[as6200] =3D {
+		.config_reg_16bits =3D true,
+		.set_mask =3D 0x94C0,	/* 8 sample/s, 4 CF, positive polarity */
+		.default_resolution =3D 12,
+		.default_sample_time =3D 125,
+		.num_sample_times =3D 4,
+		.sample_times =3D (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm =3D true,
+	},
 	[at30ts74] =3D {
 		.set_mask =3D 3 << 5,	/* 12-bit mode*/
 		.default_resolution =3D 12,
@@ -317,20 +332,23 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolu=
tion)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
=20
-static int lm75_write_config(struct lm75_data *data, u8 set_mask,
-			     u8 clr_mask)
+static int lm75_write_config(struct lm75_data *data, u16 set_mask,
+			     u16 clr_mask)
 {
-	u8 value;
+	unsigned int value;
=20
-	clr_mask |=3D LM75_SHUTDOWN;
+	clr_mask |=3D LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
 	value =3D data->current_conf & ~clr_mask;
 	value |=3D set_mask;
=20
 	if (data->current_conf !=3D value) {
 		s32 err;
-
-		err =3D i2c_smbus_write_byte_data(data->client, LM75_REG_CONF,
-						value);
+		if (data->params->config_reg_16bits)
+			err =3D regmap_write(data->regmap, LM75_REG_CONF, value);
+		else
+			err =3D i2c_smbus_write_byte_data(data->client,
+							LM75_REG_CONF,
+							value);
 		if (err)
 			return err;
 		data->current_conf =3D value;
@@ -338,6 +356,27 @@ static int lm75_write_config(struct lm75_data *data, u=
8 set_mask,
 	return 0;
 }
=20
+static int lm75_read_config(struct lm75_data *data)
+{
+	int ret;
+	unsigned int status;
+
+	if (data->params->config_reg_16bits) {
+		ret =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
+		return ret ? ret : status;
+	}
+
+	return i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
+}
+
+static irqreturn_t lm75_alarm_handler(int irq, void *private)
+{
+	struct device *hwmon_dev =3D private;
+
+	hwmon_notify_event(hwmon_dev, hwmon_temp, hwmon_temp_alarm, 0);
+	return IRQ_HANDLED;
+}
+
 static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 		     u32 attr, int channel, long *val)
 {
@@ -366,6 +405,9 @@ static int lm75_read(struct device *dev, enum hwmon_sen=
sor_types type,
 		case hwmon_temp_max_hyst:
 			reg =3D LM75_REG_HYST;
 			break;
+		case hwmon_temp_alarm:
+			reg =3D LM75_REG_CONF;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -373,7 +415,17 @@ static int lm75_read(struct device *dev, enum hwmon_se=
nsor_types type,
 		if (err < 0)
 			return err;
=20
-		*val =3D lm75_reg_to_mc(regval, data->resolution);
+		if (attr =3D=3D hwmon_temp_alarm) {
+			switch (data->kind) {
+			case as6200:
+				*val =3D (regval >> 5) & 0x1;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			*val =3D lm75_reg_to_mc(regval, data->resolution);
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -436,6 +488,7 @@ static int lm75_update_interval(struct device *dev, lon=
g val)
 			data->resolution =3D data->params->resolutions[index];
 		break;
 	case tmp112:
+	case as6200:
 		err =3D regmap_read(data->regmap, LM75_REG_CONF, &reg);
 		if (err < 0)
 			return err;
@@ -503,6 +556,10 @@ static umode_t lm75_is_visible(const void *data, enum =
hwmon_sensor_types type,
 		case hwmon_temp_max:
 		case hwmon_temp_max_hyst:
 			return 0644;
+		case hwmon_temp_alarm:
+			if (config_data->params->alarm)
+				return 0444;
+			break;
 		}
 		break;
 	default:
@@ -515,7 +572,8 @@ static const struct hwmon_channel_info *lm75_info[] =3D=
 {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
+			   HWMON_T_ALARM),
 	NULL
 };
=20
@@ -623,7 +681,7 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
=20
 	/* Cache original configuration */
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
+	status =3D lm75_read_config(data);
 	if (status < 0) {
 		dev_dbg(dev, "Can't read config? %d\n", status);
 		return status;
@@ -646,6 +704,23 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);
=20
+	if (client->irq) {
+		if (data->params->alarm) {
+			err =3D devm_request_threaded_irq(dev,
+							client->irq,
+							NULL,
+							&lm75_alarm_handler,
+							IRQF_ONESHOT,
+							client->name,
+							hwmon_dev);
+			if (err)
+				return err;
+		} else {
+			 /* alarm is only supported for chips with alarm bit */
+			dev_err(dev, "alarm interrupt is not supported\n");
+		}
+	}
+
 	dev_info(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev), client->name);
=20
 	return 0;
@@ -653,6 +728,7 @@ static int lm75_probe(struct i2c_client *client)
=20
 static const struct i2c_device_id lm75_ids[] =3D {
 	{ "adt75", adt75, },
+	{ "as6200", as6200, },
 	{ "at30ts74", at30ts74, },
 	{ "ds1775", ds1775, },
 	{ "ds75", ds75, },
@@ -689,6 +765,10 @@ static const struct of_device_id __maybe_unused lm75_o=
f_match[] =3D {
 		.compatible =3D "adi,adt75",
 		.data =3D (void *)adt75
 	},
+	{
+		.compatible =3D "ams,as6200",
+		.data =3D (void *)as6200
+	},
 	{
 		.compatible =3D "atmel,at30ts74",
 		.data =3D (void *)at30ts74
--=20
2.54.0


