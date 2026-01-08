Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A7CF6AA3
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:30:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3012.1767864591212715982
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nUjzqBxB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzJut6znfkzjWBpKHiX3/YZc2sK6NO9Ztufw0dqg1jlhub8KG193NmuHxdjvI7fqKTx32Qc98K5GyQ4Hti0GPza/6J+9kSDfDC5WRz3YWhIYwX62HQDh6vl3JuYpu3EU37UDffPpP5ight+kl8XtONjqPVItOR800dNI0vgXRgCS63c+VVnMGUEavFRyZjDNEDY5PIviQVRiawLiej7wY93jKN+DUPOxI0bqZ8M1UtH1jpaldh+j2mATDBR5951MF35CYL6B0UNT18RZetGgnoebazy7chZG7kRrC9/tueT0AphRX4jY+uK0xV0eo4gZtm+4n13Ih/xKxJOR77yA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADj1lK0OMFqILyu8pDtuWq/WclGmTL2Ly6MmLCrKcGU=;
 b=XL0lbnbz4doXQygjuUggw9QvRSqvFliTX42PtAxIZwJT+3LE6YCZjlBRME7BUnNbB3EsW+6cUYyo88ChlyC5sKzCB9Y+yfpEQBVodzukGRc88XFnnp9Gxd3gVHrSvs65lo6e6tIMBZaHJulEEWNUZ9YEVPVgIj/k+X4r2GmxggpZRrA2DApEeChCxgiCB8L/2zg0xt65SilIAZdkd7ZexVjCIcwSz2/0Ik7gHi21thahTqDUgBN/Ig7ATTXAurcYqjCpwzO924JPed/HTKs6N2shbXe60aJTxnite9VWc+RORZHjt3MfVCnuEO9GAcs5iEYi4c/URafuQPIM1efCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADj1lK0OMFqILyu8pDtuWq/WclGmTL2Ly6MmLCrKcGU=;
 b=nUjzqBxBABwi0jsYSWv6hL+EgWGwWXrBNkKDjIivzZqVPb1t3d8issVyJyfdrfEth6O/QAISRZFCjogn+AQgzL41q1j6Rq7ZIFuQKOKhOF4qXB2sQk5zOevOPxacTZDJL/gn0R5vZeX90HHeo8rYpEblP4ulr9xV+Z1IaMXpKEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:49 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/22] hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
Date: Thu,  8 Jan 2026 10:28:22 +0100
Message-ID: <20260108092823.489287-22-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 5149553d-aca7-4f79-b487-08de4e9877d3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Gi8TlcZZmMO5SoD+b02sr3x1oL6y/LyPhgMsFA2MDBNEJLzNKS4hrXjmtshm?=
 =?us-ascii?Q?5pY/MmS43AwSDuXmMmvYAb9j3ma6wNSnX4b6ittbfNdiIEJPas2tWFUmFXE/?=
 =?us-ascii?Q?4NIPVNoX53Vbrf7qWSM2AyLrdUoVzRbGCAgAKiVxvwI238fqTXasOGSYhhYI?=
 =?us-ascii?Q?xo5oyea5wWOarnxG2+xdbZyffSwjuCQrYLGu82D/EtOilZfB4faWgyEpCiWI?=
 =?us-ascii?Q?PRR7De+7YI+p8+8DYZ493woTTayS/NKmhJdrsZ8Ci5DQU9dyJKHs2G70V0hH?=
 =?us-ascii?Q?6y9O4WLh3p8uMTXfj/owV28CQ6/6GbPhfESWmk/FDexnaLJ3qT35PhkPnajr?=
 =?us-ascii?Q?avPFTwSYYtaFG/VJUBFAtTTpivzIwSiIYQMD6JykHLiavixNzLBZPvvXbMwQ?=
 =?us-ascii?Q?1QutCXdSSARvPBSi4I84bR50VceUGQSNc6vjZrrdOg82rbuq8gLOjBBC4lXT?=
 =?us-ascii?Q?nJTmHiGRfPxvITC0AQzMrxOM8mjSRcodxXPC6NWHupJXsw+Q7oD+UtmZ4t9Z?=
 =?us-ascii?Q?qQyQwd+4AP7IcsQc2oTdXRCQL2UVW4wvpsp+9vWn7r/kcoyhIMq76HeSz7zH?=
 =?us-ascii?Q?INm+BC7jZ659q5FED2e9+KELf1gKJBmd9oRmFWF0gihaujr27BCipbf8AK5j?=
 =?us-ascii?Q?5UNtsd1FICnImoRHoskNM3sbyiMCpUJ3LcQ/oidUF/KKD0kowf81PdMve2HT?=
 =?us-ascii?Q?wlOtiuaIb6zohnv6NcqehoBubx8xruPaZ+IhN0HUwDqoIZ8D33K68oi5qgyN?=
 =?us-ascii?Q?gB15oMZ2JkzMZ2s8zD5j7PNXzDovaURL7qeG1/Uic+yzz7n+1QSJSrH9TLrR?=
 =?us-ascii?Q?YeL4VXG07Uj5pDeOYqcYDCl6ubWxIaqPTYPKeUoskvOyQwWrG55fK+DMByYW?=
 =?us-ascii?Q?cIaQKGluOLEP1l4aXizydf7UzD28oOPrZR2unmq3IqwgiYt6koJHG67rE9/o?=
 =?us-ascii?Q?eW22u/gVuULK+2lcZdb0hlAv66BJOKXDmBraKX58EhhZ3yTlukCfJqEs5gHn?=
 =?us-ascii?Q?Kpm6Xq/LMVUlM+60GZUIqNUnS8mZlbz97bPv0vdfXMjYsajUL6PEDN+UQMZL?=
 =?us-ascii?Q?Bc3Incp2M+XZPKu/UPjzXtIyQzVaGapOXhKBLcxySJzUHAyt131BSg6IFkcU?=
 =?us-ascii?Q?hojyLiiSvQe7fn6v6WfOTD7Nd+uyKnUT+nTfYXVni7zXIMQJHZ7JChBPh2Ui?=
 =?us-ascii?Q?ubjxZeXvogcBxhk5zva+KfDFyZv0r+SkmLIn6tubCrQc+xG8fBzZyQrRt2UV?=
 =?us-ascii?Q?C2PObo5z1fOI6dx3gUNpyCgwo3zAwtssOmgAJMFbO/ViGJFTptD1KnCRSGdG?=
 =?us-ascii?Q?6Bdf0JWBPE065k2PhOWN98n+KHkIOcWWeIal2XniaEIlWdZUzXmCcw3QctrN?=
 =?us-ascii?Q?i9ie2IU8g5RJ/4WROY8NX4Qc3dG/kCYq99h06yp34iqCzdBDWS944tfPfVnG?=
 =?us-ascii?Q?hVPkbRwJltca7uYizaMXq/V8Myd9JMFZbqPWG5DS1gN8bbp5joOAaGit9hOB?=
 =?us-ascii?Q?w1kUEWlxnXBACnjVzcEjTHpDav3YJX/6KAQo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QE4762UAh1aMrO4U0Ddy6cPGbHujwzwCTCnmUmGxfZzWoE9c3PjAfnrkr8Xu?=
 =?us-ascii?Q?3V8u2FSKqz3rRKXbT7Q6k8N4Tt5AjtfDYg369ibB63NHG0H0LeJ1dspnVk7u?=
 =?us-ascii?Q?z6hA6YV7jdBo9O1YSO/lJyK2PH1WkOpEYO8Il8Ka6HtsKExcw7aROR9fJ/I/?=
 =?us-ascii?Q?4oup9mxWyT8stH3ubjTevMMfIB0s0jrO/Jq+CaIvZxqJPCGUb8l//9ru6b44?=
 =?us-ascii?Q?rss4p/3ppB8aYn3hRFgpevt0TbbwX0pvJ5jW61jGtu7OpQkdnVGQLrpt9+ZS?=
 =?us-ascii?Q?VsIW9lmN81TOLI6q+LDGZRhgceGgqq5F7B7xSv+4VMARpV8O285tkDjlXsQv?=
 =?us-ascii?Q?WeK9lVfAiH69hWg7tZPOYeWtwtKT7JmKQrW4qPzQKtHoeO92gt6/JgZ/N0v0?=
 =?us-ascii?Q?LdkbuLilF9nBDoVXFeAEx+95VUf7iTEsgtdNGPRfykXMyKmm2o1fpxZqb3RE?=
 =?us-ascii?Q?NcBiDDaGNoLQSh6OVUidlBpl5rRWE9f+lwXlu49MpPe1Kc2b4xABi1lGJrdq?=
 =?us-ascii?Q?dge2Ct+onZWx4fjqE88G9m4moV53nwWGYyx6iXl2WPjFr3y/cmz3uDUaV/Ix?=
 =?us-ascii?Q?77sq5KZhyHQx+hoxe8otBzcgnzrXMbHz07WCRxDZbFRAkQ3BYgZsVBxXqZue?=
 =?us-ascii?Q?Yne/mlJRRWCU4L8KUM/VxIQHGoAo3pVvMcL1aFeXOp+8AClvZ1XZzDh0qP39?=
 =?us-ascii?Q?Mj7McvZYoKBy1w9O2if5ogQZ3V6+OcV9HZ8H/B483M6XK1bfqrYxO32BWMZi?=
 =?us-ascii?Q?v9kM5dOj7ecSHv2yQQlkhV4ROg0BQs/tkxeaLWaY6SWaPYPa/5PXMzKeqKsa?=
 =?us-ascii?Q?Lryi3u842ffQmqH08nxqIDEgfs9uwt/5tnlOyngn/r4bkqNhazkmCXtph9uB?=
 =?us-ascii?Q?CPkkltBx6KLkoS5LamRDobu+R5HXXdv8YX4v0GSwPktZPVvOlbwJFLpQQznK?=
 =?us-ascii?Q?k7D9uAwfA3rzbA1sik2iTkh7IeqaYYeAeCzCl7YSsekyRHB8HY8ho0DrnGGT?=
 =?us-ascii?Q?YkV5+UWC/PNr09qUWGEQKowCSEvEim7gkNpa/nLhKd/TX/27XX7pyckm3E/H?=
 =?us-ascii?Q?tSFWUt4S+T5Hpb0sNvuOc7LnjfzydmyTn6e78t+lz6K78kIFogTybCj/xRfw?=
 =?us-ascii?Q?MlDQVxGeg3mRi8o/XG60JVyWude5gpe3sVoDx+xG5LsCIilpLGKYmM/URsXh?=
 =?us-ascii?Q?F1OanPc+AfpqgnOLtnYqqQAVIaAdjfaVaylDw5xBc8048qR6tYB3mI55zssM?=
 =?us-ascii?Q?bKeF9gdd/wMeLmo+DBRZ9rW1lOrn63+kPwMxIqishoGHVUiltWZ0piostnhD?=
 =?us-ascii?Q?Uip+t+zmq6cEMfv4PeOtCOrKxWU/erwsjENxvdWt5ukKdZXd7YJUvy3bQjw6?=
 =?us-ascii?Q?k+T1axBiJovMyCqhGkFeiFZO2FEdnQ0FW6C8Er7h9VvGmREJ9g51RemQG8JL?=
 =?us-ascii?Q?5EnAE1P89Nbgu1/4TROI6m0ewA3+4ELTR0GvFeQBpKKn1yuUl69tYFQaS32Z?=
 =?us-ascii?Q?uBnMoF6Sq4O8BIje+uE6usmrPylQXD2+c/GSh0qrfmgrduD5pMoBsNYIycOF?=
 =?us-ascii?Q?e92It3tnjouWwlmug5IqfdlaSMJVD7OW76ldda8tFioLY4OlRsm8gIDxWclJ?=
 =?us-ascii?Q?MWCRYeW/Luy85T6Fw/0ImLwGeW/SZrhXJPkimmcJGUDPbsAaivlv31E3TQU9?=
 =?us-ascii?Q?PFprHY4eydHxYZ7rU8V9844o4jDNOLZWdiHwaDYPrBaSCLZwhIsjIgjDrdhz?=
 =?us-ascii?Q?JrotUhnpHLLWE38uuK9M8uC6bRqQ1/LpyDKGwFFPDzixQBCbiYte?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5149553d-aca7-4f79-b487-08de4e9877d3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:48.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x2K2kiWvTpyFyJyUnnagYwzTv1Sbd+CeB3yBolKibPZX64HdqP4K5BVe0S+CfhKUcrc6Rf1ZDmjISBJlaY0UJRS/2Relst2hsqHrkpPxDcxyNfZUPK7WFcMFlx7lH/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:30:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21457

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 8281d627905dc72241ca3969ee18f3e029e96d00 upstream.

I3C device probe fails when CONFIG_REGMAP_I3C=3Dm:

	p3t1085_i3c 0-23615290090: error -ENODEV: Failed to register i3c regmap

Fix this by using the IS_ENABLED(CONFIG_REGMAP_I3C) macro in the code.

Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <20241121121819.393104-1-jarkko.nikula@linux.intel.com>
[groeck: Remove #ifdef entirely; it is not needed due to dead code eliminat=
ion]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 55277ec7c54b..955e6cd378dd 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -452,12 +452,7 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev=
)
 	struct device *dev =3D i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
=20
-#ifdef CONFIG_REGMAP_I3C
 	regmap =3D devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
-#else
-	regmap =3D ERR_PTR(-ENODEV);
-#endif
-
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to register i3c regmap\n");
--=20
2.43.0


