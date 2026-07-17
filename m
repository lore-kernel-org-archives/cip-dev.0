Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A4C44521
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:39 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13251.1784294018149120735
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=q2bODUdL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.49, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNhmChAFM/yPipZluYlsNPRMpYLhm+noI48ocPJHmaDCCiXSvjdFtThj1d1HigmaJdGhewQB1uZrAr2ZTn2mSjTzp7/mn/n7QqfJFQIEvdIVFLHY1z45D0QLhOixEHQ4lTi8S9qNZ88Ce4AtJ5Pc2sUfjLLLgtT+yDH4VWZ37bhOBmkVgkVXDBesBlQXujR7+8rGBKm0Ng/8DUlJxk1NUmTNWzkNi2YPR04P0GmYqjkAgqPw7AX3YkaT/6TI1w24Vd3KLsF/1VRoEgCyOtYR0U/rYYyffev8VmAXTBSuf7ON9IePCy+U9OVQ5RW9be5pFd7ek5R75wjJM7CaVIGUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO3G0VxUU4qzZ32QcwxVBhRFZx1c4D1il5QIu1/cjDA=;
 b=Y7ReNUNcKb6ZnO3IpnlRMUZWmayikQfzxHS39NbgJHBH+3wKKVm5XM4Rn8qwz7CPBld/r+9LWqIq7TL5wlAF/7yFlOWWw2su7it0Re1NzTtfpl1Dz3BENRctF+cYm0IsXHrgxzSz2hRkIqTv70Jt2Z4XRk6cNkTf8QQbmEake6VoFg4KNphr/DqMntpCttfkEFCjs9OiCoiyn+VbBg+8/DB7xiC3RQIbHGuF+tH2dSdL1b72pUj8Qg+o1+TIupvxfkuM/bJDAFC3G/QDYr87YLZFaGfEijfU4mX3Mo+ZeMfYurerrJ0oyZLTbYtzzb1EpHY3m6Z4+3I3F8r8MZgj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO3G0VxUU4qzZ32QcwxVBhRFZx1c4D1il5QIu1/cjDA=;
 b=q2bODUdLIa4ioff+kHQIrhhju9w7fmQqZ6oHwLhQc8SCHSqDG5awWRriFAGs3pA0Lq4NNuxyIMJ7cpZSCdSDHOte6PpObuLKKfutbYRM2nRcszHl7ifZWC2FmWApYngOzHqieYa/E0U06DC6fPyxQhDS4EElpv+bC8z3lLinKuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:32 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/23] hwmon: (tmp108) Add basic regulator support
Date: Fri, 17 Jul 2026 15:12:25 +0200
Message-ID: <20260717131241.2233788-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 027dc74e-3e22-4687-e048-08dee4053377
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	gxzalc3ajZt7V+bpp+spL+5A8gd7sVGNUyDQOq7sjyqwJ1lPxg/gJKwA+bcZ0/9VrWGPduGf1k0ahXkKOfJnLSBVnC0Zb6wBURFyZi/bGprrozEx59VP0qiy7JnxqWYHJ296qZb1e9AvytzyGAPkJWRkX8D1qSaeohjnzcpvWs2co3ThUqzajgRUqXyYks5PQmSQBnafVUbszlSc+3RCyVR+gBwnpLZXgZ23coLhyNlxI1O6HS5Lj/fe4a5l41vLwrLtYJGMUBtQkrwlfEci1afU7M//xmecje11mSI2U9VGru4XYAQgAcC/EXMiqs2O0a2ZTjuYjodT6G+eN5nz0n/7ehAnbbK1K79OnvtAyCqOyo6IJE0vU+A44F6FJDf/5OMEcaL0zlM7po13o5WbOsrQbZcNvucDPWUmExG+433vekN+JtkPKMFlXFimNPnvmBTFrPl7/gUG9Ymi1plz+UdgIE/HsAQW0CTjmVYwlzxx3YnEqp4IscD2b8H+jgqAeCkhgmiDPyCUzFQkTDBpCYv5xn9xLRPSvlqUz7EzNt0zXjsVYS41AdcilU/tuNL9AEV9Rw8zi4HK5L4GH6xxjjwzP0UtSeIhpeOvxRj0yxz6JCpQvdmxMZvSySxmHYA+0kE1a17z0xLPb8UlK1JpH6VUHwotgfAa1jwP5Y+TRGtwhv5Z79Qdn39OG/fS4Ie65Pc/7xnqqfvlCH+HLsMXbPyv+T7CQXECLKrdOduZQUI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wuaR8A4i0n61tSMo0BVcEcwPylv7anSxQQH5SK7LTQXGqCHarLy2pDhWHUN4?=
 =?us-ascii?Q?VeXQrSJELBgDrlxsOf/PUWg9W3ng+iXAqKcjRWbTqzkdu8kl6y55yGF+o+p6?=
 =?us-ascii?Q?eTqyGuC2Tk6Mc7HIze+ONMrrQ4F5Zv1vCggstpHOFi30IbcZ0RPz4E3X5g1b?=
 =?us-ascii?Q?Wj/Ljpa3CITosFJLYG9KTGowRhiubUPvfOKu409KGl2mvKfnl76MC69TwZzl?=
 =?us-ascii?Q?t3qjuWxZ/pQwvkca0wiBQVbwAkRrpJBhoyatOuEIKMBcx3PCra5kdRO77ihY?=
 =?us-ascii?Q?n4kUI72+9XA8rPDhDpgOIMvXCIU3F63VMA6tmi2XQDFFAWh3lmCJbB7q1/z/?=
 =?us-ascii?Q?TGj4j61Zb3b3cEDD0MtQKMbI3Zk+5sMcOWm0NIaCZL39EF3+6uQcVqPrGvvU?=
 =?us-ascii?Q?NuANP0rqGh3+PAqTJXzg1E3WaSwiMdVCN7BxDJ2FzWKOR2Q/AWqnfNOZ1ULl?=
 =?us-ascii?Q?Qa0JF1CyZ70z31oDi98nEb/7+jXvsCAH9jOtPmWQmSjOK7gKXDJ6V8xmodRb?=
 =?us-ascii?Q?p1oBabEwbg7NytMb/TUNxU2WqD7TRFnKPkvoQmbBs+EgS48fSweKLrfUsIFa?=
 =?us-ascii?Q?yR4WNh1G472HFSIQQQMXmfh5rYt5u/mPazf8nZiTOphQ0yYZ+QM+LPMAZbDO?=
 =?us-ascii?Q?JhrLVOQ43THo/3n9UBpNKf6NUQ653bjTsCXqmejivQmYg8Q4W6IWtezwLrwd?=
 =?us-ascii?Q?getQupRjFv5qJpJAGYN4gAC6C5j3gkxaGn3UWQTTLZuhOPFUAJnELPpr+f6a?=
 =?us-ascii?Q?mZsyPFYpaz8Z97lFF0g0QzOXdxZI+pLfp2aUdzS5H2RQZNGrgPvu0Y65SZuW?=
 =?us-ascii?Q?wISEhRW3GFGUYY9zs5uhSa9t/Sya2oEn0TdUnoI/EnFMtETNFH2/U5+D7Q5w?=
 =?us-ascii?Q?7QPojrtDsYXsl/gQK+zTbWle0ZE/keBzTQlQo07KxPYhVcoCyTEvIcXiiaDn?=
 =?us-ascii?Q?tV0nje4Hq4zEczwnVQ2eI5/MLamryc8q7kJbCSL+LWSD+hVzbEOIwQczRTyh?=
 =?us-ascii?Q?Acn60X8EO0lwPYckGh1sVhhA+21mpYFFKp1YAfWZxvZxUgnLM0vxEPjat3W8?=
 =?us-ascii?Q?ZHb3eiYNsHtYuulzCmnbNvOBbGBmRVhS/KMTl0zaw4iWFCrkDKiLQDCEGqYm?=
 =?us-ascii?Q?EKmvO0e07IqbNZtLSHLr+5MR9kRMF25lepW3JrvtK6wvEF2PYUm10LtCK3Sv?=
 =?us-ascii?Q?fKvhKutVgCy4x+PFY3VYrGok1hM24YwXaVlAz3oG/RDXt72vUisbl4jJlXWx?=
 =?us-ascii?Q?6u8GsMFD3sBC3AxW/q4TLrBEl7jbNd4WHt7lfYOz7Dc/i5sFufUGuLHpvbdd?=
 =?us-ascii?Q?Xu3FnedYEFv54ORaNW9nWnMGXSq0degxFajguyoDQPt2AGT0E/+Yt7av5TZ4?=
 =?us-ascii?Q?qOVeHQJL3HycLVGLv7WlmdQaDkNdPCtq7sP04krBhk4eyTxXnQ7tjXlIvRoI?=
 =?us-ascii?Q?bFEqOtcvT6fMMlm5yhdC3vGfkhD5ZpBlBpRI1i45P/0AbV4qNGKbuVlewPHK?=
 =?us-ascii?Q?b6mIrRvRNUsFwPBAj2m4wWzDIQVvhLvxNdDVYLOWZL6Caikoi86AGghYW9Wv?=
 =?us-ascii?Q?3SeFGh1wPu79mNay2Bx9bW6Onr075oCSgurUAaZxPP4ZGNttgjDRx0R6naZ5?=
 =?us-ascii?Q?nayfRsPqxe1dXQh+uA/bZF8vodNo8x4gk7I1zN9LWq+kYz2blRrIdoTCUm4X?=
 =?us-ascii?Q?7THsPyfaqbjDHKs2IN6vHf+T+OfrG6JyjsVevFVyxd/M5P03lpeAGb2q8hDD?=
 =?us-ascii?Q?+XlZhleuSsQs/iWxp/6vzrS20JDxjqL4F273n9i35+Ev349yOIZt?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027dc74e-3e22-4687-e048-08dee4053377
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:32.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpSIZt0gm1FC0rsishvwru/os/xaSUXsMEihsx7ChDJkgVf+6pkkmQRjeZlSG8ZXnK//hdtiW8Sb+jW41S/fKGp8fZHFpcnd9DTYEEeKz3X9Hc72Sr6n6JMVo7mAiniq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23635

From: Stanislav Jakubek <stano.jakubek@gmail.com>

commit bddbb9cff4ab97ad367692201a0abe680a59d44d upstream.

TMP108/P3T1085 are powered by the V+/VCC regulator, add support for it.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/tmp108.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 955e6cd378dd..d389b698d3bc 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
=20
 #define	DRIVER_NAME "tmp108"
@@ -331,6 +332,10 @@ static int tmp108_common_probe(struct device *dev, str=
uct regmap *regmap, char *
 	u32 config;
 	int err;
=20
+	err =3D devm_regulator_get_enable(dev, "vcc");
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable regulator\n");
+
 	tmp108 =3D devm_kzalloc(dev, sizeof(*tmp108), GFP_KERNEL);
 	if (!tmp108)
 		return -ENOMEM;
--=20
2.54.0


