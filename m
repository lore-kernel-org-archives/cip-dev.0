Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03CC44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:10 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13341.1784294162206399374
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=syxJmtGH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a47MT0NAh+iLcheSgA4xftmx4G3b4ccwxKEUV5KHCo+HKxBOjTUIV0czp87rdl0KiMdfzJZIhjvbOt7lXECj+/q4KgVTikR4EgtFki4pqn7UqmcIZIl/ivWNgGm4dtQSVvCDv1ktoI48XMEvAXXdJWL06kw5nMUNYqALGlocSKR+PCpOuykiyWeVnxNBIxKDtfLyisrYKHc4Ts7nreThoSzBu6V5uB6QswbR9X6HWJjP1hn62ARibLpHckJC8gSvTnTmmSO60VWXJtu7L6tzcQGMWlatQ2qc2ReF7+CnUsaWPH3SZCRHIg3Sw6yajWw6mWcgZRP8bCmjuDxjeYBXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaINrUKsH/8oLiTATnFZKBpu0u2z7HLFupMySZpJ2rI=;
 b=DhT9LOFDhe9UPMtnTjCmKOfzUDwke5hUhuvK0cI50YIT9wNCAJuq8krpjGF8/8rsXzlqtjB9IDxuUnqF9UPwt0Idr8jMrcttcYcwoYikdG44AglbqH8y/d7KvtesmNHA1tcpecy7yv3WoZbY/AxSS3tlpl2x2H9zWQ/mxmUZ4EU2uN7oBTvKpcafDz0uEzd4zSSHAM1SKtfL1j1VoKmBR7nIv6aMcU5O3ROQe00VZ1w/9Cgo1ORO/5EANPWyLdZWzMGe/KdtXz1G9OkB8lVvWXAaG8Ib3h6OiFpLUkzOMwb8zim7aiD8uWMIyyip/eBiJjA6a5LFp7DRShLGzNLS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaINrUKsH/8oLiTATnFZKBpu0u2z7HLFupMySZpJ2rI=;
 b=syxJmtGHVpu/1+3AOu6vxwu2AdMUULbfZ4ngPpiNgTAWyszyBY+cX9jyaXemAVUzThplbKHDNUPxnWj/5cjNRUtPzDzKFpCZjCx6jM6ouFcXPtYepWprp5TWnV04XxPEEKOppPzPpCyWmHgf/ANoY9z2gGLNq/86x763+A+iDJg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:16:00 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:16:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 12/15] hwmon: (lm75) Remove superfluous 'client' member from private struct
Date: Fri, 17 Jul 2026 15:14:59 +0200
Message-ID: <20260717131502.2234020-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1921cc45-59f8-41d3-c968-08dee4058ada
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	6GCJzM4tsDT66e8g4XhvmQnxRGBJcZHsxiyv2I5vvPbNzvM4qnffXCMRdtXWPiOTzF6DSyhrG95mv/88K57x21gIoXI6+7uOTwnlDPlgeRh+p6pzxOnjiFyU/47JqeGTblWQ8v5PoY4hRZCnCoKC9v1jLYxeAHXhUh27jnFxixkyGEQ+WHIT0eIVg0JXGM8grJ8L4qbmwKPdjOvjKAeksbyUdMpWci284ZzorF6iiaRT+BOr0Y/E3dU/jQVlKQuUcSmVd97wjO21EqWUz56ecXRxVilcpQXYJ5VQAMe37Mgn1bh4pqWVXnLp4IjwViq6KUxxa+g8szbwxktR+UeaxyNhUKG1yIQTZULlEvjeJSE118tvCwpRSWxAqDDAYEfurQi+4qwtjc/HRvzlVRsK0qCh5yWI0YDs+a+39NJh9rJf0dUiFuDF0qnR+VftoEqWfN1/T91zepkbZ/8/jtBNCRfMyRs3/dvir7aMo2vX03oY4Z1TayueX/Mr/Gubjyt04XiV2sn7y22oSkKR43sQTwG2jKxruZy7+aobkuFuATuliHJ/wCf8olGV6wM791ZvjDQNz4N+JSBE/YgPu0OWEsfjFMzlhRAAPFdjgK2J0w4qTxjRI7WDH5Vlcgm6GnK16MX5oqdfSycVxq17vTvo0RQZI7ALNSKeq1Wp5a6WMd4FuGjgPAvfJUdkEFkJuGVfZIjwF+hSaGv5HJhi426Tt/E+lLR2UyHk5GUG261ngwA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k9WrMGDgJ1pdwTMFnyZma6z4ovoy3lom3zRxwWU3vGO6uyes6weecAUBR+zn?=
 =?us-ascii?Q?QyND3aYtrnfpn+zpJR4FHjnkY2zimYH4bGOkDz8Qb3Yt2q44SKKYIThX9iKT?=
 =?us-ascii?Q?0YF77wFLt7QbmJiNVCqVmHbkYzfF9JGJ9P0bUSQAlDof3M+64RSFFdXKS9cv?=
 =?us-ascii?Q?7hDH8BvQzniLAz+MfzMELiMIV6UVfb63wSmEl1naFKe72ps3/Dn/XezsiCng?=
 =?us-ascii?Q?BDjxcDmGOTSuFVpO1vsb11kMM3xCCRjimzd7KD4aA/fMzTGl0AmJtrA+OLCR?=
 =?us-ascii?Q?J7fL2raHXu7sQdN42y20HA1Q+NdTDosy7MBKEWoe4eE9bbP1Xph2N7xOYBaU?=
 =?us-ascii?Q?LXYFHW1RHvq6pmr/l8It54oMv9itIB8WSf/bS96ypcNZPfhXPhpcsTbENBVb?=
 =?us-ascii?Q?ZqZnz+OpowubHbfyT5SdBmYUuMjhUjT2PjAXjqf7CXt7VyPHvOjGsvISjxG8?=
 =?us-ascii?Q?poHYvon1gTCC9qZoZvpT8tN5WfBYUZen164oRN5+EW+6iGtaRA9exZPhZoM3?=
 =?us-ascii?Q?k2TagvTIAH7kcAtD8wV6zIs8IwV+G23bhWbqHgeDjjla9RDoUdpWdBKRO+80?=
 =?us-ascii?Q?fC+u7J9zbw+jAWkhnt29qarkCMSN5gfUEvLBqEKMnzVBnMc8WLMqmiitSDb1?=
 =?us-ascii?Q?+1FsO9JIx8+y3viZSy/0P88GdW5WbuYZza/vRW5xZrtYbofKkEzmYTlbtJiJ?=
 =?us-ascii?Q?2GnbiI94iH23SHJHjIvqf6sDNxJSPWDx+ylYaTyRutxhSFmjAn4MZb/7MY3+?=
 =?us-ascii?Q?FSBLfzRH8cZoe8heb+Cr6VlEV+Ew0oB6QUCAsseUL2QyOJxPiD/dq4d+OORI?=
 =?us-ascii?Q?hjmNdtl23AUlz1i+NfwJexAu1q5GFT2NGXGbcg+M93VOshytSJPZg5iChqAa?=
 =?us-ascii?Q?ioKWCZ+ps3fPOiz+cwx26QvU/hF4G4fgPOpQUaDRnWOI7b8KC6tLj7EJcbBe?=
 =?us-ascii?Q?Wxttlx3AL0PePLfpqGd1Byb4skaeL0cxBzakTkneQyeYt//YdQL+GQDyrWlP?=
 =?us-ascii?Q?ko1ujLh0RgcrcvnG/HjgF85RuwhawwrciQ7mADlwgFnBtKCxKVE4tB1JhZp4?=
 =?us-ascii?Q?dC+IpCL8E+IpigPOBCLdy30APrr5UNg2RiKPMNdtfW++ziUYkuz7K4nERI81?=
 =?us-ascii?Q?PaiPdwjxkoT8q1Pg+KGC4mxK2yvpG/RChgXs4qoUoKVN/ampSCmhz/lwYA3E?=
 =?us-ascii?Q?+bvvnHX6uoG0uGBAQNuh8MHGMEJrEcgAR7dUSoQ3R1swqhkVbO/vBeo3i3Nm?=
 =?us-ascii?Q?ryyn8xE6nBi8jZULFpvmo9hvlxrUiSDhWNlyr4A0646A4NuO9/COMNHWTAvH?=
 =?us-ascii?Q?m5q/F1CL6JJ17hVxNpBePD40ChOPqSeUJsAcVSa7aALHnOJJcfa2f6Jttt87?=
 =?us-ascii?Q?PhTDVG0wHxDtq2ENOPIJbhCCssaxRpM9eoqjTzeSodl1zb9Q5S6YvBQconYM?=
 =?us-ascii?Q?jl89Qj/eJEl0psSdg/9Rzo1P5qc/o/Tghj5vXbI2BuRfbOmPWed+w3CgDIDT?=
 =?us-ascii?Q?o3eLrsOYNZeJCuSsBtxkkAhC/XxdHAw+F2wBnYtNatmSvAmvkPo612lUztlZ?=
 =?us-ascii?Q?8RPjo0/KqN7978XVOoXgERh4a23OpThYPptn3tCdylyV5NR+SZ0urDTLSgnD?=
 =?us-ascii?Q?WmH+UBnsYats97W+gKKzpjFFqszd6uK0+nGtC4oSUxcuDedAPQahpxvy0iT4?=
 =?us-ascii?Q?6Qs71niGUFNcjDbszamRDKnegVaZiKHtyTKY6cbR5YFEPOcbbLD98ycM+Hw+?=
 =?us-ascii?Q?Uzn3npDqRiqfgHZXzETY2XSg0le1BPB0Ky7CRNqwbWKDfE4lHW54?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1921cc45-59f8-41d3-c968-08dee4058ada
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:59.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce1iKUXOw2kU9zLpYgG4OLpiIFXC8w9kKDLOmh/8lGEM7EgGLYto2VysW7OxwgmpCwitchIHEjflWTEfv89U17i13qWurjlmQHu5kyIg6YzJHUcCqA2o8ZrjqwFfn7PS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23664

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
index 4d0fd1c93c63..0f034110daed 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -105,9 +105,7 @@ static const unsigned short normal_i2c[] =3D { 0x48, 0x=
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
@@ -572,8 +570,8 @@ static bool lm75_is_volatile_reg(struct device *dev, un=
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
@@ -592,8 +590,8 @@ static int lm75_i2c_reg_read(void *context, unsigned in=
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
@@ -645,14 +643,13 @@ static int lm75_probe(struct i2c_client *client)
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


