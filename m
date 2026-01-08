Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBDCCF6AB4
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:31:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3057.1767864699084185097
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:31:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aFo6BnC5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tm7fRSFKnApyXBjvya/WSuq1LiexxcxWL67/ifuNK7Y8Ihc6mBDuO14HpQe5tIc4+2o7XNDkHK5ji5GHUNdqrzUV0svZmZx4YaKnmJLIMuVtSxb3A0cP/prAzvfapgwDKaba9Xkeb7QQahr/0ccOostQUszSEfxReS4idWPpzNWGQ8uipc3/z11LOJBOeWKHLMS+q577ZLcU0DJvXiKD/nMmV4y3EVSGMMaD9VarX34E8VPmAo5FAW9aJt5f8IN12+yQXVliPY5m1tRMjksEcOP43d1ECxpUPUV+yQdRV6wcrADaCs5Ff9bVH/XwPApWP+3F+HODF2uY3M+O7iUBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWv3LJ5WwkVYSUNy2LoQLekJAHKgouYlcqODBxOgs00=;
 b=TWz2+YjQLzJOBaLa+PCj+xuWnXCX8qtc0JPZ6M4iACS17tCrHtCixS6X+KjpD7nz2KzlvK154tnx00alP+rbU6EVKy6U9q1mlNg23EiMmqTPMpki4l+Zkel538A43bfhjg5/KX4EfbkCvM8yox1JGvetouPY4IedCPHtdzAYLFeMns4gJm/hPtgeArVxctg9XLGJiW/IAtxjPhdSfZvHTed7FH0r8TQ1bO0Orj7ee07SVjA97eB55puNQzz0CYfB/+gF8gcaOy1jk/sJN+xRgQH/jhOyM68Cugy+GD8LUG6BCrTY5LGvdwYkBAA0FKkazzbdiqAonT8EKx0two2q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWv3LJ5WwkVYSUNy2LoQLekJAHKgouYlcqODBxOgs00=;
 b=aFo6BnC5xLwvZxQ5Ez/5WVtqS0FPAqaHuZ5CQroB3313GX86NlJF3l6X+zGd9sNB9M7gSOSjC7TOePkk+JL0w9PS8TCoThQMLiHVWngp3DtmM+MsXABL3uvYqzrt/SGO26EQKodfdrjz7PAOUXMCobJLBTEdKJNdZPxMrEVqtqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:31:36 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:31:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 18/19] hwmon: (tmp108) Do not fail in I3C probe when I3C regmap is a module
Date: Thu,  8 Jan 2026 10:30:22 +0100
Message-ID: <20260108093023.489513-19-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6e64e4a-0439-487c-b977-08de4e98b83d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8iqDGSUU0C0lozbTcd+0qYDOQ+G/YVsRS4HwJPG3YB3yStkiyrpusp3fFbJ7?=
 =?us-ascii?Q?AmTrzCxuSl47aD+W7bY7wYu2kvh0xm12Q8XthPbXQIdzWWLnMhUCW15sBIpe?=
 =?us-ascii?Q?4K2LFdw9bj+qhBA5GODsY8IXrp8vTxf2ImTaCdfgr+XON1OzGpLWXgovXkXU?=
 =?us-ascii?Q?3foHSBsGcC8JKXNlPqAsSp7lIu0Sihfc29Ea1fH8hWHC6NyHY/F9iZrzLsnt?=
 =?us-ascii?Q?Nux70PniNQUnx7wzB3oivSvLKpMCjb+T3X3sPruqMWlEMJ7UEOgVIKB0QWoL?=
 =?us-ascii?Q?d7kpkC36lcd3wa2K9mqEZ/KNqVMHNNRhNsFOWwp9ciA0AVrKBd1npd7P7zJS?=
 =?us-ascii?Q?aWbmIZCk8viJTbgUXh7y6fPU9VzZUVOowjlTZ8mhXpF8ujy8h22F4WQkkPg9?=
 =?us-ascii?Q?8ijS83sNlUIUZj+Tk0sqymnbZkm4cNTAm51ONVi6K8BjTQzRSKyfqDhO4va2?=
 =?us-ascii?Q?Ji542WseSYGrYHKrfH1KHxtDiSfj6l5uj0Cqxck6ijM5FoqGZl05tzY4O/DU?=
 =?us-ascii?Q?ILVrofby9S+bTlQ3TaTpo+3eE9eQSnDxeQ8hrb+Yi9wXBZHrLD5qE94amKiC?=
 =?us-ascii?Q?GSNhLOJA/AkrDcDHlA8ZIA1E1azmV44wnFV5lnIXBWSqvGduD/Imp/RtHZsb?=
 =?us-ascii?Q?5hXb2UN3oV8r0uVL1xn5uN1e1GilfshdJudCKmukgLCKGs7DvOo5f2V9gfDx?=
 =?us-ascii?Q?8W3MgWiL+FMHlWLEnWJz25flEOO1txz2ig4EAmFxUK9Lm3e22V5qjXirmd2Q?=
 =?us-ascii?Q?Vk3IfhTtkAqB7MqzzreGONk8PCbVmAAOAGr0VN+xHJ3+8Q9CzqlRywMcSoay?=
 =?us-ascii?Q?peIyS5aughM2KRci4QH0k0nJ9GJVKupeRDZd87XCrrf/FuuaLsm/rfNZBZRu?=
 =?us-ascii?Q?6xy0wnQ3uVIX/gGDK/tqcD1rwZRjf4VdNjDB+KAQEbX3mdwL+efZbK+ZbxDa?=
 =?us-ascii?Q?6GOa+EnlQMv/CPFxBm7LD3bfbDJl4SoAacBaL9E3/KQV4BbEGHFYDotAOgZf?=
 =?us-ascii?Q?G3E991csg4FCiPyQHRjT4pVJ7m6q8RiUzwS+DRCe8RxsqxMyliH7fbNBFTak?=
 =?us-ascii?Q?SY4Bu86/mN/uiA036eGUcraxaeoEon8aXhQxGuEO84BQVduT5dzWonsXKfbk?=
 =?us-ascii?Q?zMtS8pah03Jau6kMnbpGj3sc77cP/wsDSTbHegpXNgZJzWbwmqLsjWXFs20F?=
 =?us-ascii?Q?D8TyjKWeGVF4uWoExEZa+CjKKe/l4yBzSjsgObuoaHrYOr7YPAyWFeRrsGY3?=
 =?us-ascii?Q?IQ1saZUhhaBjrZWhR1kyrSYIOx7M0al2pzxOhtbaGuWkMg1gOnoFDeMsnv8N?=
 =?us-ascii?Q?HpKVQot78oPYVzdrzy63wCWy/Dz5DPawm5GvKRwfR824MwLZktUt/i8igMGF?=
 =?us-ascii?Q?WLKJ1+AR5mLPiz1xtIzDE6PyEF7cKxUvuJxY5rJV9vfHNwfngXx+Zazvf4GG?=
 =?us-ascii?Q?H403ZaanvkCltnru6yX61RCToKAmT1s9x1kTfGnLUCfvBdiAqTSpDT9fclz0?=
 =?us-ascii?Q?1EX5VMLPrft0VLRssIc8Od29UIMQMiWylTnI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n47ycFyJYFjWdxaHXvd8TZ0Yi35Et3YcVeH9dReo6WHvT1A/avpEp9N558rz?=
 =?us-ascii?Q?fHt8ULKtk3T6FBcakBXoAH/mytC38MD2rzLJriJ0Gy4CzWjDmT7pXv5NvNGe?=
 =?us-ascii?Q?PlXjhseCqTjMH+DXKzSA8eIL1QROzWQF72GBX/G2EgBa7CKuJxtj3pUK5ilg?=
 =?us-ascii?Q?SKuRBVpxQWsyndq0VY3FDej4xVw1jbgWo7GIiqXJBCKw2D0oF9i71YQkiH8j?=
 =?us-ascii?Q?fbKi/IieWuAVqDF+rNr17LHRpVTnpGYYLQEa9Oe4TVKHCGRT6awsfaxDYcYw?=
 =?us-ascii?Q?/dkzv0cOGL2tBqU0r65lj9H90Rr8hVacJoGKO5EkeOv1Kaf9IOAcFBayUD2N?=
 =?us-ascii?Q?qTX7TlAKUYzsyN8NN7UibOVEdE4hLhH1RF3Luwjwj0sm2xQ+IkEOi0esqDQK?=
 =?us-ascii?Q?Jux8aDfKw5/6RXL5rzs6AMLhMlaII1wXCTU39z+oY6QIYu+IhwhqWMLOEJ4n?=
 =?us-ascii?Q?gvkhKrr0TOdoxb7UlJRJMsJlCwCpzX8s9zUvpHLgiNBbQW2WopXGrgBfUsWh?=
 =?us-ascii?Q?DQwV/UBJ7wqScUc2FBgh6cPMpobOsxlS3p5UHZAC/Xh17acShcA/F6WkI0Kl?=
 =?us-ascii?Q?sKyAccun6OTUQDLzvQ9SDgGRjKXPYxBr0H8wimYf4fPaHVpnzVIwsrEaEMkd?=
 =?us-ascii?Q?DruTvDvBDZt1avLPAswBu9Ox3Ps/+7jtgkvgzJqdSEIPuf2F8RJduVMM00yI?=
 =?us-ascii?Q?jZqPIIskCZdnTv+TKMujTzN80jhlo7bmy0y0yOomnOE/0gCVpy10SQL40MtD?=
 =?us-ascii?Q?dK7Ha4Ft3sJBBs3sjQekyxc0JAPwrtCgQvokT76P3MSabZjMx9glWcFq++vh?=
 =?us-ascii?Q?Joz0yiwbyyJtMn7R90mNWh1wBCecgvNnrkB53zMRt4msbpdNjtlKx8m1Q21/?=
 =?us-ascii?Q?VcY2BKvJwEHLf/e9/3NL8g98rHdTCoqPFNtOzkbgwVGzis9VG0T8M6gz9P5B?=
 =?us-ascii?Q?Bjqk7XDSHSSg1/mkfvCSWu0NWU034h9DhmMtAkhu9aauhhZfJCid2Nm+Dfv4?=
 =?us-ascii?Q?7nA/RrpKj4/5lRdk7Hk+SZVOUvk9iKScLB6KgF6evFUbAAllFOzl4Q4jeisI?=
 =?us-ascii?Q?DdYE8UbXr4s/A5Iid1YyNe5Zfx2YTT9T5jY0UlEQ72p+NPRZp+y+7k3F6GQ7?=
 =?us-ascii?Q?90c9GkDr4vVFpc9STWLBLWKNksaEweSkfa5OXRW1p9ETSMKJ1IqzgS4YxlVH?=
 =?us-ascii?Q?+TAE+H0tY8lpfLMDwscMxq8FQMs1BrRTLPTk0DBPhgmLTUmucRujsttw9R/e?=
 =?us-ascii?Q?sk/N+pgXXbqjx1vz9+saVnMiy39xWMFYgGCFQqhP9+7HCpl4XKMUVIVFEkwL?=
 =?us-ascii?Q?8tl7ArTwiLL1EuZ4wuWlGdHtkbDL8tYo53Ox+DOgmA95BX0UkCpX5ZjTG5Tc?=
 =?us-ascii?Q?qjKAWPgamHgE7rkEVI7PG6Qk4JRuh+iqm+2cvEYsJyQmtKgWsQQ9zT910wTB?=
 =?us-ascii?Q?9ddrk4zwFRvgpsB2r/arvlAKec3L2PcZESZU9TD/eZiwPneFHorY2zQfOk5f?=
 =?us-ascii?Q?SfaH6+XVeGpTJjOtSux3JlvDl5Bxx52SAPZFLAQVhpznk7qG8+qzsIzPaZRI?=
 =?us-ascii?Q?gkwh9PhDsgbG1Rw8rJRNIK6CNV96oVF3S6DvYZ86KCHnox3G4jWJlNSn4rOc?=
 =?us-ascii?Q?e7TuDvxCRUVuTJK3QC5DORd7281/bcTz/x41bP/IC5YF+cU/Oqn/hDrNG5FM?=
 =?us-ascii?Q?osyUwldTBR4MEbt2SvB4qYvxbVscXgjYNBL1CLXmA+MI3sq/sJUYtEYbqQ4b?=
 =?us-ascii?Q?ckzIBBoAuvTYvBejySmtJfX6HmMaZiT/Pk95AO9jU/6Cd5EO+/R7?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e64e4a-0439-487c-b977-08de4e98b83d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:31:36.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkRwVPojw36vt3j16qaYvDekRjBL3/9VvKlaoPOzw0kFTvS0NrCq3T+mwG0tBzcW52wB9SSsE4IqMoR8AJkxx/q65j90bMqxV9/miUz0037hA+jmZ5SBAO67yE6G3EqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:31:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21477

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
index 1f36af2cd2d9..fbe673009126 100644
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


