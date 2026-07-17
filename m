Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6ABC44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13281.1784294047217631671
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tep3P14X;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.71, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWWnsuCojdzBTrfM0UohCUsqFlr4WFn0bEr3n2dKv1UAEW38NC3kMgaQT5COPz5RMVHiB3Zhd90HRl/0yQdy71UQi/QnJ2ocLyQD7tZul8s3OBjQ15vezJvzrUrCRhqMWXe9UD0+7EHrP8Hj2GGpzye/v71dY6ElNbE4StSSDYwr73m/pofXbwi1wJ22Sy6QSuTfB2Xd1/3WGLHNBJ92Leh99Gj5SwpdLr0e47E8R/oYaNFIIiQ/Af0b77hKrGHTejo0yUoIS8Eb0XcGpKkAMvfuzMm5PjVBD9QtnkJ5VQPiTQ8n/OXG2AomNQqcnznJqqd/LiRDXNstBXHL3+dtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCEVu28g+xorgB9bvkKIm8cV+Ir2LxXLoNW+65B7+90=;
 b=vHTEjGaY1Ns0h9NHLJfdAkxy/OVgW7RqnzCqcPcluEt7CnzHt0CU8Mqvci14TCS82P/KhrOkbAJtkxf253nFQAmWEZAcT7wqHJUy90792EGjmS4kSzpFoCSm04ow8cbD3B/D5ZkFKTijUJ2eVYtJe58ByKce0U520qdusc+Z9k6zwH/NhCh0SEq0vRtfXMpqAJlnsOnShEEPXRdRwrJQcZcfhIGKESDaMc5QdK7Cwrwo3mh9B9nh8Pr1IgWygw68lQiYhNBJxBh0XlQvm2zjcHy2eKvT6TZ7u64oqSiPT1sQakyipzwZhe4HRC20KhcBXKpRlEsQ3uBXTvjaTRx4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCEVu28g+xorgB9bvkKIm8cV+Ir2LxXLoNW+65B7+90=;
 b=tep3P14XffnIqOsUTglO3EerFK+DuALtUuEeiMI6ZUnalEhEd5W1Cp3+tVuj2pXv2atj+BjYs9AlRmKj2OZLE6QaXFKmYYv6sCRcjBezYVNdxW+a8gPmab+cpSQKEeE1tEOdFoljBYVfjhlElqR8REjA/eyFFozmH3obM21mJYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:06 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/23] hwmon: (lm75) Hide register size differences in regmap access functions
Date: Fri, 17 Jul 2026 15:12:35 +0200
Message-ID: <20260717131241.2233788-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2352a724-8044-42ca-f1ed-08dee4054769
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|6133799003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	pT9HPQw7+KiurqYu9C9eVHd2VMcQXBtaNurqOu9RTItD7SkMuibQcuiIrHklGhPc1jQZ/rHz+eTjp32Oujp6M2sxK/yTTznHCaOBAX1wUYz7gMQZxhpkcjIC3lyf3EMYjNECPcOjIKc8T2RZLMxQca4/EqwxO2idnc00YAr+Zd3NEQGQdn3QH26bBJ5bA5Cpb56wFIzFWcB/ps3E2cDAd649rw54nltulUSIhG5Wxi1LDArYaw8KLpDa4+WuEDDPOsEBoDuSq1rvmUWu9geVnWn3Za3fOlKdw5ruzh/+woy7ytsMOb5OmyRoniLuQonP1naQzl2ezCp8iUAn/SD+o6jQld1FXs0TkU3pmn603dlpn2tHAj/PP9PFPkJQBulT0kN+Fq255RXIkLRtUaH7QXAZCA0L1OfaSsJPLVqdTK4bdSrVHG7ABHdTmbGQeSWCXE1SCf9aaJuuPuwcXESz1g4Y7OPlh81sOqcq/7M+KeBMQTqvUdX0I6L9k+IY8h0bWoMDeBZFLJEf+VACOVl99p/NKJye+Ii+9296qidPSLCS16idVPHXQKNh9b3Lem1VqyHfVAV3lIaGESGZAPZWdpiY52HjuHy8tSva8MuZBTvc8jGL0+n8MHOn84UMxgUTcYxL49Gzv0OM9P7B4/xskfncPYylIEw84SYLNk+C6I/y0bvYPqz0p6DHnf72MvOwuaiMkAqKy5KZYxjq6chENEM1uX0xrlVqoSTrd2+XBkc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ubI3Nigq3i2MiISJI4a7XmXaFO9VocoCYAFFIDHgRVBXjL33JYMOCE74QyE1?=
 =?us-ascii?Q?ofirDIIIVDRgBLAzAYOmRmb13OD5rJaohvuhNYsA0PQJAFYA4SKWBDxE+UEz?=
 =?us-ascii?Q?BsQ1oAXED9JK/YjeqpFSsznS17YmQrK1GY1oUKUowtTZUD+V2ofR/gTUm2v4?=
 =?us-ascii?Q?r9BK8TV7/+VpdTzzqbt2IximNK3Rj/QwNc1z9XDbpwSIC7/rbN/ATfUjbeaY?=
 =?us-ascii?Q?ZWMnbGk3R0juX2aVIH1Kogdszm0k8ldblnuVh49BwYOF7nHO+fTuV79POzZ3?=
 =?us-ascii?Q?2tbPm0wBUmEqrNo8g9DzwSAED+p6JBB5XR18PcvPEmR6WGQzZqitPF7AqZbJ?=
 =?us-ascii?Q?QQjv+0fcM/1FoEzOx9XvpZjcTmlkVKMBN8QaX1pGnwdqz2rv/T88y7IkblmL?=
 =?us-ascii?Q?ERziXw0c0sm4MITZZY3D5fR+wjk4VYwBAv3NoKWC9tRkxTLNnXQNvxa002LI?=
 =?us-ascii?Q?Qxt32cD6n8O1vWWx/VxpaN0h1v+abl0Xr/BOqjD3kl72jWVLz2weM2aQGuhM?=
 =?us-ascii?Q?hdgoq6yt8rynA64WNeQGm5t8Gf83RVD+bdoapdxzetligaXjCO59AdqQnLBl?=
 =?us-ascii?Q?1GCNxoT+E3KS6tT260Bpkw9OSvLQKHfQm2n9PlUlwDawUxIamAQFWLLGzvAv?=
 =?us-ascii?Q?Q7vKY86e6zaKEndbJcWpXML9NL3tVqE776xIcz0P8leddDiDJIeiBz9Jib/g?=
 =?us-ascii?Q?t5HgojiE8OUEHafgA0LoVA1+iwedwjhGT6C8Azm/B60SQ73u2S2TGvx5LQXN?=
 =?us-ascii?Q?AE+9EwySzN0UPRThMccP66P9qi60+8s6eO3MB0K1bc7QaMS0r60NA0mJYmpG?=
 =?us-ascii?Q?syd96+768Qk57PXWTgIZfF6MUkmY9tUfGsiIVFzt05GvNWmueOCybHIP8daz?=
 =?us-ascii?Q?5ctooA+aviuj32Hx8p/KAslgKnhauCM4szLzwN69LJvNXOngSYQIbzydel4+?=
 =?us-ascii?Q?EmAKYnrV77W0qt22yEvWn0lIz0hTbxJT67KolbG1kdcSQjDqsN2gbbAlLgUO?=
 =?us-ascii?Q?DYzY15NYp3X3BUTdwSYcg2Tjuc5aIy1ITeQtPMTNAVKRPjc+DBjL8dAbcz4J?=
 =?us-ascii?Q?ifbNaMvC2A2pQMPX3WeIqHdB6aXO4kKbRoYiPV7akSlGgcTEgx3dQj71IAoH?=
 =?us-ascii?Q?vv7ht3L/41LEKsfvoYd93DkQ1RBwdCRw5DPOO4g4yQhCztdcQ99t8z4HjC49?=
 =?us-ascii?Q?dEkYlpk6kpsYHuOhWjNF5h7gwR5ayCwjP5X1X768aCW4oi5D5JB7d7jT7mwk?=
 =?us-ascii?Q?m+zyF9m+dqO3rfo2cVfYhab1mhqXOv7z6tyVIFWLMXouwtLJ6G9cWTuIixaF?=
 =?us-ascii?Q?Jkj6Tc1HDsvVq8lM10ggaZVBSlN9rXgFjQtB9xbct9QJ8ajRO0PV2nBssnw4?=
 =?us-ascii?Q?fdkctus8hHCcYK1l+3amBddwFgU27CagpJ8PdGYEZrl8IuUNnEQLZYW3u7Hv?=
 =?us-ascii?Q?LuUqLBaXm6hXdIWnqFLVlo8vsRnUgfhbbp6OqZ/UOwo3SJTy806b13ha5tQl?=
 =?us-ascii?Q?tM0kd/7bho4TdB1uongW8rVlshjDNipWSeI2JgObLKWcZqqRX2uq7CrhE+dD?=
 =?us-ascii?Q?CADKsh/EMBdfF4QNXj5PZL86xCy65EvD5yxDKNb6I8o23lqixJJPJh3kA6uK?=
 =?us-ascii?Q?eABdhDaHFmgKSYL4M5GEXsfAVR1Am7w+Cddj9cm9qfCFvPm6O7XNDE/CaL8O?=
 =?us-ascii?Q?kJycEIXuF0JluryJxhXdi/GJAoBTGLq9XDnbDhpm3Dx0xyrcL9j5wOObgPzh?=
 =?us-ascii?Q?vcKtDM+3iEx/ErQhlAJx4CMtpOBCd13IOIM5c7XQwmKmUpsySZKS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2352a724-8044-42ca-f1ed-08dee4054769
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:06.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU2Vb5w91kyVaoHz1QUM9/PxPcVYjD/8PXgZNIj9n3eWryYDfwlOtljOqYSpJ0jkG4T8QL35skSY8bggSh0B94Nj3KtJvVPWcj0E+vMFdGXdk5wStyddy0S4auDb3zHi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23645

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
index 1d0040e3276f..4bb3d2959593 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -112,7 +112,6 @@ struct lm75_data {
 	struct regmap			*regmap;
 	struct regulator		*vs;
 	u16				orig_conf;
-	u16				current_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
 	enum lm75_type			kind;
@@ -285,6 +284,7 @@ static const struct lm75_params device_params[] =3D {
 		.default_sample_time =3D 125,
 		.num_sample_times =3D 4,
 		.sample_times =3D (unsigned int []){ 125, 250, 1000, 4000 },
+		.alarm =3D true,
 	},
 	[tmp175] =3D {
 		.set_mask =3D 3 << 5,	/* 12-bit mode */
@@ -344,40 +344,16 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolu=
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
@@ -427,7 +403,8 @@ static int lm75_read(struct device *dev, enum hwmon_sen=
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
@@ -478,7 +455,6 @@ static int lm75_write_temp(struct device *dev, u32 attr=
, long temp)
 static int lm75_update_interval(struct device *dev, long val)
 {
 	struct lm75_data *data =3D dev_get_drvdata(dev);
-	unsigned int reg;
 	u8 index;
 	s32 err;
=20
@@ -498,19 +474,14 @@ static int lm75_update_interval(struct device *dev, l=
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
@@ -607,6 +578,39 @@ static bool lm75_is_volatile_reg(struct device *dev, u=
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
@@ -619,6 +623,11 @@ static const struct regmap_config lm75_regmap_config =
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
@@ -629,9 +638,8 @@ static void lm75_disable_regulator(void *data)
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
@@ -649,6 +657,9 @@ static int lm75_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
=20
+	/* needed by custom regmap callbacks */
+	dev_set_drvdata(dev, data);
+
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
@@ -656,7 +667,8 @@ static int lm75_probe(struct i2c_client *client)
 	if (IS_ERR(data->vs))
 		return PTR_ERR(data->vs);
=20
-	data->regmap =3D devm_regmap_init_i2c(client, &lm75_regmap_config);
+	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
+					&lm75_regmap_config);
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
=20
@@ -682,13 +694,10 @@ static int lm75_probe(struct i2c_client *client)
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
@@ -986,32 +995,16 @@ static int lm75_detect(struct i2c_client *new_client,
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


