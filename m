Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A1C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:40 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13320.1784294132163103046
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=p7lW6Hn4;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGuizAND2mbJpsr88CuOMLYiiReukXwjzzHSOgNVsoqkGMi2DdByh2LP1yiPnQt/P9urjGDlTCNuGh3g8ZHkW5BxOTEB9sHCgIzW7G5VHRsG/C9iGBGtKiouZ9yt0OfnRHoskbCm4stremjYWWVW4z1tJNc1P2tyTl8vnsT1x8UYXXWMBjrI5lKTBX8W7YsGX1nLtf5ZcrFa0uiCU/ZL9nwSPL3+9ylii8ASJNewD0L49QM9ug5ahEsKbHSIX+IHVqSu8+WcD5iJUbGu9D6bHQay7mcq87FtRCRvgTQlzJ9A6YinLzsBiBitKm2YXHOcNVOSX5wQ86irb8nOoaZ5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+MLcmyej0qyqNpMNn38yY3SFunFVM0L9dnxDrXBAqI=;
 b=nZpa9xg2hRjHEfkj/x3ZuigX7Ge8gQMVvyrU8crMq21ciehvliX04TM4oR9nCJw38qzJhRinfj4zXM1/DPCrOLvk1iqwdhh2QdexKgjPFhlwGbyfionWUo+9v0cyGNR59Z8n/g0dL26JkoknLGavs55O/Bw/ZHP85oJvQPqb4zECoJ1UhqHwNsQ+BMQTIP4wB+Th81C+R+e+ibaSQ5tZSosAQkf0M87H3fBjFaZty/9K7dI3aLzRGJ1eMWBUrGCM9BltAV+8LVCQBYgub1z1VJME1olFIXXbRQ3H+ydqGsGnAjlZHNNgSxKkDEfJHU5cnv5BCxwlZCbfxf1tjzbA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+MLcmyej0qyqNpMNn38yY3SFunFVM0L9dnxDrXBAqI=;
 b=p7lW6Hn4LA5TqQh/0PwizotH0DdqrAO8j23Lij+FgO4NpkqdRd+pfgruSJCK0+jmdDkJ8l4EheupFpyu2ARt3Vf6/5WqHsTPJ/IdSW1vi87yq6SQZg72w8sGscFQ7b9SWEI+TOBb5jXnP+LBq63A9adj5rOMndl5MCylnBzqhPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:29 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/15] hwmon: (tmp108) Add NXP p3t1085 support
Date: Fri, 17 Jul 2026 15:14:49 +0200
Message-ID: <20260717131502.2234020-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c672641-fa7c-48b2-3e63-08dee4057947
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	/wyKm2GdyBsy7lcXlvUpq21CWnXh8wDHM7gXHekM7hDEAxQ2iFpMMOX8zOoMOhCjtbR0akK0H6juuHQaiQk8K/ortdfceB5E29BFa4BvrenVLaF7lpJ3E8YFxbjzeeuGs8CPmPoQyHw1FgreNGG396MpAmxyB30+1o1kuwLVcQRrFHIjT2MxvRliKteYQgzKd4pkameRc1qBPtCf6hP197q0Bac9OvPHcNJsD6mAl4KjSVoB1KSWjmiO1PVThfM7OmJFUZLW9cDAP/KRH7ecey3McGkn0qbaNnCU3l2bNbq6lxkEisC393XriEyA9JFAZmKltlCAOmmG7VRYO08j/Kl7OruQYdmZ0cx7ZcPNHUExHhafhArzLQhhSxEvhbFTUJMT7ipTj6Q3/oZnDpbEN1NgtTCmVt3IJ8YBl+PDEOTsa1y2tlmv7WMYRimvNTzqHIX1hEF3FRNo8ECanQF3VJFRtWSf0pot86sFzD0AkE7fAhbf5iVe09FMpPVp+BfJiN35mbc+BK4nIHdiHv7aLXrm4J0FGSAsYHsQ2YqTBqUor47qYNOlOAdSD5NtplgC7BNEvZjWw58X4VRfiKyUfsiDvZ9mI8yrfxaBCZv2Hr6JS45+jzbuf7KchaAy7iLmUbeEGffKwpzuiW/IF32R60hA/l761WkF0xB5AEFu5DbKzC2YGfRvjLFaYO5vmPr0dc2RrumnxQ9hlRkT7B1xiCp0rzmnkZMPI4FxTASnLp4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ARmOtP74OvGBzDY/rx9Xph2F3bGM72N3DqpirIdLw0D1FMFomUnZKuh0Cj8/?=
 =?us-ascii?Q?Px4cPJfvaQDcJStgXrvmVSgQxTZ2F544jNu4051GYELpHMx+ZjW//g2PIp1+?=
 =?us-ascii?Q?bPx2h5Ijr+2l/Ws7BcaKOgVN+efLzTUDWqN+4I8jedY6d9Xff/3UhGnmUzL8?=
 =?us-ascii?Q?5ukdW6hGQ3ETJsugiQpEYqljB7cVaRENyng9+oiRP7dtYi7MWcjDhb6Ksigg?=
 =?us-ascii?Q?LysVb3wGlgKKINfQ+fzzbfZ5CijdJgiPIGhEvPUUJGeqvPg1AQve1cynJMbL?=
 =?us-ascii?Q?FGx8b7xvXUFoAAhXtlriXaKttbfINk0Mpe2Hdzna6evACJczhg1mjfoBF9Xq?=
 =?us-ascii?Q?D42j16hbZP2zagh/q/FvkUlcKeHW3wmkBMVc6UzFjwSs+U1Dxmt7n6abDIFg?=
 =?us-ascii?Q?ArWJrsd25HZD6ihAL2kTrOn8UyxrlTjustYINDoJr69WpTApe8VoFMSYRcbi?=
 =?us-ascii?Q?CLcyjPzWz4SU7LxIMchHqytsa4oe/Th3G69whkkNHX47P9Y/1taKKfSWp1vK?=
 =?us-ascii?Q?Gkb3byNerVGVBwhOLFoCBmJB/pnxFKk0BtcFHKvzU2H1ggvxSw4EU6+yh1bX?=
 =?us-ascii?Q?4rl+O2Dc1EWvFRSSM68xd2cVtVGP5DhoLEJdK6myGvQLZnTnRiRnwgcMyEq3?=
 =?us-ascii?Q?ZvsFQu53drM+UsBCMspBQb5/UeVnWfMrXCjVRJ5pdOeJcZSYaIjwNpXk9OrN?=
 =?us-ascii?Q?dFrwnuyKBzqdBQinq8cZUr976aiISTQcrNpMZvemuJZJkYm+7itRnJpmf4vp?=
 =?us-ascii?Q?+XxlFtj9Oo80Mn2cXJISYazf2jqeF6M+SSWWNzQHqLOFlndIX8lKNA+DqqiE?=
 =?us-ascii?Q?XQi4wJo2KP0yWdsNJWKIncPBUuT2Taddo6LZseITdbeKzRHT1wRvZdom47UT?=
 =?us-ascii?Q?ml94pidSOj4MiXD7BVfAOCnyqRZwxh9BD+vrx1OM680GTp50Pq4l5A3loqYY?=
 =?us-ascii?Q?UGZSfiXwcFsEWAnyh2m9oDnuVvG497Kd9yCnGlmVP+6Ljj53NO9EtNm03/sG?=
 =?us-ascii?Q?Ivs7ArpgJoxeL+0U28d/smKjiNwTx9suMsf+G+ODwDc664gaYJFOgfhCTeUR?=
 =?us-ascii?Q?2ndv23FPzwVtPVsTYQNtXd4DG/25G289h3rn93/TPh+G4b9GU7Wv9X3kp98C?=
 =?us-ascii?Q?/dhNoK7WrcSWytVKFXRBaAE928+Hzl/gk4XKVFnDnjWFA1ib9BUrSUvupIat?=
 =?us-ascii?Q?MnMt/ZIw6W2FQB8HOh9RyaDSbGgwXa/sEK8FuCSnRQIiyVgteBaIv150EGgG?=
 =?us-ascii?Q?HJbHddtBokFLk6Iuqr43eN5nRHQy2g4SZUUKuetucGPjdzlQnrHp1bw2MZrb?=
 =?us-ascii?Q?jvOija7HCYSEdhPpds6tshTzqYN35K2usfFySG2qJHPjVKjwZSl6il5N6orO?=
 =?us-ascii?Q?obSeHl/QFo4omi4Zh8LPwRFTS+ZDnJNfgPQv7bxrIGav44auO1papzHpYeDG?=
 =?us-ascii?Q?ci5VhMM8/fdv67U6g8phUt6ri0xtSUnJ2hlXbWaXBZhwPjC3P1ZcECGgtOd9?=
 =?us-ascii?Q?Txz9gDmby27OAtgHPldvyeyD6bh5s52W1og9yhGqzfYd9B7tDy8AD7AQrOrP?=
 =?us-ascii?Q?2CuLUW96rbaqou4OpJzE0kn3OV8bQr+iQXI77KAdqWU3iQfqfhCf1xO3FcTA?=
 =?us-ascii?Q?z0bfAfpon5lZMby0K5G5K1t9GO9JEMVrkdNcvXOoPa49+Gsopl3DDE+AMvre?=
 =?us-ascii?Q?GcQL3QMDPTcQFgRz1zHun7S/Kw94DxQBF33ZiByiEiONtY8WvGgZWyMekZ7d?=
 =?us-ascii?Q?ab6MtNdvULXUREs1O9VpwSACBD4evJNSHp7qlZl+nnMGLpOzSw51?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c672641-fa7c-48b2-3e63-08dee4057947
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:29.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhjw7c6bK3Qrw9BidUWM5N6PApDLhW62wyeVbScnhDUsXeIcXMcCxxMjhQHNpv25pH6vU6WDg7afFz6nSzYsVYzQ+mMrthOvBbaQZXtBlQL2R6gZ/YxyF31s6UE40HBL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23654

From: Frank Li <Frank.Li@nxp.com>

commit 11d35624d7696a64724160199fc94587010d7cb2 upstream.

Add compatible string 'nxp,p3t1085' since p3t1085's register layout is the
same as tmp108.

The p3t1085 supports I3C interface.

Update document tmp108.rst and Kconfig's help context.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-2-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/tmp108.rst | 8 ++++++++
 drivers/hwmon/Kconfig          | 2 +-
 drivers/hwmon/tmp108.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/tmp108.rst b/Documentation/hwmon/tmp108.rs=
t
index 6df7cf1b42f4..bc4941d98268 100644
--- a/Documentation/hwmon/tmp108.rst
+++ b/Documentation/hwmon/tmp108.rst
@@ -3,6 +3,14 @@ Kernel driver tmp108
=20
 Supported chips:
=20
+  * NXP P3T1085
+
+    Prefix: 'p3t1085'
+
+    Addresses scanned: none
+
+    Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
+
   * Texas Instruments TMP108
=20
     Prefix: 'tmp108'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 19622dd6ec93..930fb2cfdc00 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2277,7 +2277,7 @@ config SENSORS_TMP108
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
-	  sensor chips.
+	  sensor chips and NXP P3T1085.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp108.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index a82bbc959eb1..b561b452d8d3 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -420,6 +420,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
=20
 #ifdef CONFIG_OF
 static const struct of_device_id tmp108_of_ids[] =3D {
+	{ .compatible =3D "nxp,p3t1085", },
 	{ .compatible =3D "ti,tmp108", },
 	{}
 };
--=20
2.54.0


