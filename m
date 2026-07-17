Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39DC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13333.1784294152815093928
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GXve/LfB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOsCCbV2lKONSdcTMz2KHINtb94/fz/f+k3YSAZxzTuymJt6grTogIefcWGXpSNqX91ohHK9wesdb2aI3wuz5VDIPzLRfmA19GBqK0nkRRzCIjde4R7QAOYXvq6C3FGTaX6lXy1+NIaK4Ihr3AS8ZNqBFB9Ird2HyHpM85+Em+CvWfc2uAIEZBMXnxBQ3iAE6HMntMDEfFO35gAydViYPAYsZV0XFEWHXbDSnSu05BuvKChTATPITL1fQkLcEI77KHZgWKY4ybs8b+Foe7Ust6q6MqcMZysMAVLlwRQ6Ym/x373E8nTJaI9t7vvRbqQqNPiVGXK8sLKrceOHQrtYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04UFxV/0mqpa0lAh7rLaCCu1x/tgL5VQQipidBhgrmg=;
 b=qG/c3n3Tda9p95Yq78npx2Coq8uvdtilluxxanogTwaA7JfJUv15hX3r14/H/nWCpyJRe/wzCBYQZ26PTv0mpIy4UMH+2D61+0eHNJ1i6287OYZho/nwGFzbWagmwC5w+RbrKKwAxylbEKb152O62qAO3BaIzwZrsX3jnRBemLmOeAANLjyuMFflQLBNB9YCnA5DojE+9b5mwY0R6FoQU0csOCX96Qo3OE7j0NLdKjzbZjhoma4QvsGitUOzlviRpgfXNdf+bQKpjxNGZ3T9G4YVxdUmYIG5oJAGapAIYM3SOmTvZ092KN9udfohe5grUoyPeqgXkuO2cU3NSFBmyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04UFxV/0mqpa0lAh7rLaCCu1x/tgL5VQQipidBhgrmg=;
 b=GXve/LfBGaky8qQ2HQytadjXL2Wy8yJiKNonZtZSHQviMW/G+kGqogc+qKU6wu1VEz0NgEAqM04RwA/JsZHt+OE9uj3CDPysfGE+QKpW/evSafDRbA4CEeDpXwXxU/IP0zqgEkztKtNLAuOawPShrcA/Oa3qWm2BYHl2/ML9jRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:50 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 09/15] hwmon: (lm75) Hide register size differences in regmap access functions
Date: Fri, 17 Jul 2026 15:14:56 +0200
Message-ID: <20260717131502.2234020-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0de84eae-0ef6-4e02-24d3-08dee40585c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	FCS0iAM1A8UCaIqNtWCD7D3gdJoM+BYJYjGznDrDsXt8I+rv1jW7nh65yjKKeEB9SHXYDE8fwmCOrv8cAKgKmIg2eA4kq7KUuJR9id++rTaT/EmtHY6Px4dFmKUmdfs5ftrPJ5JhNK1CiuJTIjMnp3mLWd9R8PoVreuIPu7ZBXnbd0ca4a1Ds65+MWaUANmqrgW9gQEECT1kVBT8F/Sbi4rZxb41pndh9IyF1zWJfU+mVzPoJtpXI78xud9nr7q9nwdYE4cWja4hsFbRiMVFnr+Uv51jxfbK9gMvHwA1kpA9PPOdnYc1EDRCFP7M8TKkh8S+5DfYL78MmgjdrRV6Za3AqecCwCH73yz//llqQuqxdhpUXwFvyLhny0lITX2XHSwsvjgXr9R6mOyQJlgsPZ18bKkCkNCUFR/XHEGvEA7I1L99Pp33n1pumFGHGwqxdl7+jd7MB5izm+8H9He8yJUdLhAAJS65o0QU//oOMWK95nZgluikqdZHkmxJz9HwDTU9KvkkZfi7wA0B7NJZcNDmt8SJbGff3HPoFOMdynzs4mJFYLgUrkzcngFf8SHH/KsM2/aQSY2BB/cwtdNl+xJ109qAZUUwMGrWOle775k3o9x1iPdCCrnz4yts2VB5pBaZP01wH7wdD5obMDo0c9LauTsB4//SsE97Yc48NDt+2J9lJ3XvqizIfYR5cHwhm4hGqQIVqU2s3Rmrhzoq7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QC7C95UktHz6XzTvf3e5DuAicNtAMdXOKAu3gcQ9EnIkc6eAOb45z8cvIohb?=
 =?us-ascii?Q?PUzPP4fyoxc4TfLgjWkD7w+dmfnR8DHbGSCiQ4IpMVAP8glstYruQBz5QlTx?=
 =?us-ascii?Q?0gCHr0IsGaV+XifG6z0plGXw3sc5iaFy8OC0PmHGbUF8eTHF4SR3WkQvqjW9?=
 =?us-ascii?Q?9Ha8tk1uSav42/X6tWIUug0HslYJszLl6Deuaf4pzlNbv+mbY1xgAPcMTtB6?=
 =?us-ascii?Q?04d5krbfWeylyUakpIYA+0IETB9eSbICqgFfqiq8YcwnoK3nJPEALXOSxnF/?=
 =?us-ascii?Q?6SGEqbqAn36h2T2bl+PSkIZB5CNIzsz3Tp0tXC2qnkpArDbXDnJ61eUaolx5?=
 =?us-ascii?Q?bupIaDQvD7yXBfezd0nb2SCVlmOynd+pdKz4oMOR6kZdduSliLoWW+oAEl0T?=
 =?us-ascii?Q?UOEvV0pKg7iobST9Lf62qy1XZ5lWhvBz2zVHSl22lKBLVeQ0gKGi6z6G4+qJ?=
 =?us-ascii?Q?lX6hqAhpkjVW69MpfiB39k2a+zGYxmPnH493DEWwSaMgj8WUnikDnos57q46?=
 =?us-ascii?Q?3Gq00t23K2M81bHGJpkU+KRyklmw8icPcf8vhpn3qSt/xZYQmrqQWbYvoboS?=
 =?us-ascii?Q?Kz/SE+LQypHd2mgQrVL4JhB1Q08XyYKEWiyj36vJXTCZiJGAI+aRzhX0g1Oi?=
 =?us-ascii?Q?fr8otcMrfBy5Cri6iA6u6IiZSxe9VBfHvGKVTrY5h7ABeSgkaZ30djTD2h9D?=
 =?us-ascii?Q?IKLHnhQ8YgepEsXRFuEo/QV2JUFZ0V4ytydg095XXmv5ePKs0YucPa276/Dt?=
 =?us-ascii?Q?k1PV7cFTWFERs3kGaAbQ8SPSYy7HIteg4SJTY27gS5TfkUSOfdsg2rp2Mhye?=
 =?us-ascii?Q?2zqWlbfLLv3uTfi1rlMeeMMsUkNNhd/QlNm19by++vuk8IdyyrSaG6ru9b3t?=
 =?us-ascii?Q?qJne1SAO6OX7goRjmeEVI6mIRun8Ofop5q3ojjqFAtCw4IA1ugpltTa8wFLK?=
 =?us-ascii?Q?qQD66S7TY7twuIz6KIIdZCukHfoDlgtzp8hXMLwwCBmJNxQKi3PvXs7GX18x?=
 =?us-ascii?Q?5FnlRilcydhgN66hsCr68+FySwpH4aXISghmMFJZ3xSg3gSjA2gMyIH05dib?=
 =?us-ascii?Q?qjJMJUTZBncpTqNto8f88ND84q4OEraMJCjysjbzG501TLZd8m/qD6TRqAUX?=
 =?us-ascii?Q?X9jg0PJSlHDbUmaf9C/9xLXBh4xAHxtndH8qwxzpvVOlfeMOs4Sm5Us4aA3d?=
 =?us-ascii?Q?URh0M3k2Au2bKiKOzC2vh4QWlwhixW5RWysaACTXL/Z086LpfhpIfTvmmJgo?=
 =?us-ascii?Q?A5PS8zSOr1pWfgk0ImTiUnWNqz8pMnM1fAqg/pCAEfp1nS3C/1gc1cSnwUVb?=
 =?us-ascii?Q?P7xN54N7woGvVcdJYSCCJDx6aRqwNfmH7SOulz70IZ67ipPHki0wCfJzTI3R?=
 =?us-ascii?Q?MQ637yRyG1hN13Uai/K+A/KZg2eTyUXMOg/bZmyRT+oVCJy0GOeROTEQ97ap?=
 =?us-ascii?Q?p2VxQnkqbMF8crHNkaIgIDrnxdutnjn/VAHrrmgHeWZpLwJh33RbLrF51T8U?=
 =?us-ascii?Q?VzTQwN+Eyt/nLaySaR+DsSbu/5XwWHEOOs5wslKva6kmbrLXNQhBn3fddU1O?=
 =?us-ascii?Q?JJBCrVhO8zMAwkkq8qbBaZDPdismcDLnebmsMR/p7nlY1+d0r3+5dseQzoBn?=
 =?us-ascii?Q?x1RE+r1el5SjPVVwn0zCGRcwzgfAod/YFtruJrlmYtrawwaUQxpxLfnDT088?=
 =?us-ascii?Q?sivUXDGhejv8CQlW/eQDkI2RLkdzNAKKvC6KnHaFH0SLW1umWs2F8w6UYXqr?=
 =?us-ascii?Q?9QkHyqxpJOeNver2YcKgxhe4YNdDoQ6tYh4to4Zzo8GGnBe+Z3Zm?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de84eae-0ef6-4e02-24d3-08dee40585c2
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:50.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOrV8CXH78s8ICXovVSIKFIJksI/srU1GKe8/6eFkzEtT19j+Bdxj8J/RHK06yxu2M0SAQs+ICzJBbCPJxwA1yo15/E5FtV+4rG9HCOrYh9utRehGsb+NfZ3rjQTUT2x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23661

From: Guenter Roeck <linux@roeck-us.net>

commit 6da24a25f766e02fbfc07570b5560154818ba59d upstream.

Hide register size differences in regmap access functions to simplify
runtime code and to simplify adding support for I3C devices. Also
use regmap API functions for bit operations where possible.

For this to work, the 16-bit and 8-bit configuration register has to be
mapped to a 16-bit value. Unlike other registers, this register is a
low-byte-first register, presumably for compatibility with chips with
8-bit wide configuration registers. Hide the differences in the regmap
access code.

While at it, enable alarm attribute support for TMP112.

Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 131 ++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 69 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a8f95bef68cb..b8889392d5da 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -111,7 +111,6 @@ struct lm75_data {
 	struct regmap			*regmap;
 	struct regulator		*vs;
 	u16				orig_conf;
-	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -284,6 +283,7 @@ static const struct lm75_params device_params[] =3D {
 		.default_sample_time =3D 125,
 		.num_sample_times =3D 4,
 		.sample_times =3D (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm =3D true,
 	},
 	[tmp175] =3D {
 		.set_mask =3D 3 << 5,	/* 12-bit mode */
@@ -343,40 +343,16 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolu=
tion)
 static int lm75_write_config(struct lm75_data *data, u16 set_mask,
 			     u16 clr_mask)
 {
-	unsigned int value;
+	int err;
=20
-	clr_mask |=3D LM75_SHUTDOWN << (8 * data->params->config_reg_16bits);
-	value =3D data->current_conf & ~clr_mask;
-	value |=3D set_mask;
+	err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
+				 clr_mask | LM75_SHUTDOWN, set_mask);
+	if (err)
+		return err;
=20
-	if (data->current_conf !=3D value) {
-		s32 err;
-		if (data->params->config_reg_16bits)
-			err =3D regmap_write(data->regmap, LM75_REG_CONF, value);
-		else
-			err =3D i2c_smbus_write_byte_data(data->client,
-							LM75_REG_CONF,
-							value);
-		if (err)
-			return err;
-		data->current_conf =3D value;
-	}
 	return 0;
 }
=20
-static int lm75_read_config(struct lm75_data *data)
-{
-	int ret;
-	unsigned int status;
-
-	if (data->params->config_reg_16bits) {
-		ret =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
-		return ret ? ret : status;
-	}
-
-	return i2c_smbus_read_byte_data(data->client, LM75_REG_CONF);
-}
-
 static irqreturn_t lm75_alarm_handler(int irq, void *private)
 {
 	struct device *hwmon_dev =3D private;
@@ -426,7 +402,8 @@ static int lm75_read(struct device *dev, enum hwmon_sen=
sor_types type,
 		if (attr =3D=3D hwmon_temp_alarm) {
 			switch (data->kind) {
 			case as6200:
-				*val =3D (regval >> 5) & 0x1;
+			case tmp112:
+				*val =3D (regval >> 13) & 0x1;
 				break;
 			default:
 				return -EINVAL;
@@ -477,7 +454,6 @@ static int lm75_write_temp(struct device *dev, u32 attr=
, long temp)
 static int lm75_update_interval(struct device *dev, long val)
 {
 	struct lm75_data *data =3D dev_get_drvdata(dev);
-	unsigned int reg;
 	u8 index;
 	s32 err;
=20
@@ -497,19 +473,14 @@ static int lm75_update_interval(struct device *dev, l=
ong val)
 		break;
 	case tmp112:
 	case as6200:
-		err =3D regmap_read(data->regmap, LM75_REG_CONF, &reg);
-		if (err < 0)
-			return err;
-		reg &=3D ~0x00c0;
-		reg |=3D (3 - index) << 6;
-		err =3D regmap_write(data->regmap, LM75_REG_CONF, reg);
+		err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
+					 0xc000, (3 - index) << 14);
 		if (err < 0)
 			return err;
 		data->sample_time =3D data->params->sample_times[index];
 		break;
 	case pct2075:
-		err =3D i2c_smbus_write_byte_data(data->client, PCT2075_REG_IDLE,
-						index + 1);
+		err =3D regmap_write(data->regmap, PCT2075_REG_IDLE, index + 1);
 		if (err)
 			return err;
 		data->sample_time =3D data->params->sample_times[index];
@@ -606,6 +577,39 @@ static bool lm75_is_volatile_reg(struct device *dev, u=
nsigned int reg)
 	return reg =3D=3D LM75_REG_TEMP || reg =3D=3D LM75_REG_CONF;
 }
=20
+static int lm75_i2c_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
+{
+	struct lm75_data *data =3D context;
+	struct i2c_client *client =3D data->client;
+	int ret;
+
+	if (reg =3D=3D LM75_REG_CONF) {
+		if (!data->params->config_reg_16bits)
+			ret =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
+		else
+			ret =3D i2c_smbus_read_word_data(client, LM75_REG_CONF);
+	} else {
+		ret =3D i2c_smbus_read_word_swapped(client, reg);
+	}
+	if (ret < 0)
+		return ret;
+	*val =3D ret;
+	return 0;
+}
+
+static int lm75_i2c_reg_write(void *context, unsigned int reg, unsigned in=
t val)
+{
+	struct lm75_data *data =3D context;
+	struct i2c_client *client =3D data->client;
+
+	if (reg =3D=3D PCT2075_REG_IDLE ||
+	    (reg =3D=3D LM75_REG_CONF && !data->params->config_reg_16bits))
+		return i2c_smbus_write_byte_data(client, reg, val);
+	else if (reg =3D=3D LM75_REG_CONF)
+		return i2c_smbus_write_word_data(client, reg, val);
+	return i2c_smbus_write_word_swapped(client, reg, val);
+}
+
 static const struct regmap_config lm75_regmap_config =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 16,
@@ -618,6 +622,11 @@ static const struct regmap_config lm75_regmap_config =
=3D {
 	.use_single_write =3D true,
 };
=20
+static const struct regmap_bus lm75_i2c_regmap_bus =3D {
+	.reg_read =3D lm75_i2c_reg_read,
+	.reg_write =3D lm75_i2c_reg_write,
+};
+
 static void lm75_disable_regulator(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -628,9 +637,8 @@ static void lm75_disable_regulator(void *data)
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
-	struct i2c_client *client =3D lm75->client;
=20
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75->orig_conf);
+	regmap_write(lm75->regmap, LM75_REG_CONF, lm75->orig_conf);
 }
=20
 static int lm75_probe(struct i2c_client *client)
@@ -648,6 +656,9 @@ static int lm75_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
=20
+	/* needed by custom regmap callbacks */
+	dev_set_drvdata(dev, data);
+
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
@@ -655,7 +666,8 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(data->vs))
 		return PTR_ERR(data->vs);
=20
-	data->regmap =3D devm_regmap_init_i2c(client, &lm75_regmap_config);
+	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
+					&lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
=20
@@ -681,13 +693,10 @@ static int lm75_probe(struct i2c_client *client)
 		return err;
=20
 	/* Cache original configuration */
-	status =3D lm75_read_config(data);
-	if (status < 0) {
-		dev_dbg(dev, "Can't read config? %d\n", status);
-		return status;
-	}
+	err =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
+	if (err)
+		return err;
 	data->orig_conf =3D status;
-	data->current_conf =3D status;
=20
 	err =3D lm75_write_config(data, data->params->set_mask,
 				data->params->clr_mask);
@@ -985,32 +994,16 @@ static int lm75_detect(struct i2c_client *new_client,
 #ifdef CONFIG_PM
 static int lm75_suspend(struct device *dev)
 {
-	int status;
-	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm75_data *data =3D dev_get_drvdata(dev);
=20
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
-	if (status < 0) {
-		dev_dbg(&client->dev, "Can't read config? %d\n", status);
-		return status;
-	}
-	status =3D status | LM75_SHUTDOWN;
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, status);
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF, LM75_SHUTDOWN, LM7=
5_SHUTDOWN);
 }
=20
 static int lm75_resume(struct device *dev)
 {
-	int status;
-	struct i2c_client *client =3D to_i2c_client(dev);
+	struct lm75_data *data =3D dev_get_drvdata(dev);
=20
-	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
-	if (status < 0) {
-		dev_dbg(&client->dev, "Can't read config? %d\n", status);
-		return status;
-	}
-	status =3D status & ~LM75_SHUTDOWN;
-	i2c_smbus_write_byte_data(client, LM75_REG_CONF, status);
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF, LM75_SHUTDOWN, 0);
 }
=20
 static const struct dev_pm_ops lm75_dev_pm_ops =3D {
--=20
2.54.0


