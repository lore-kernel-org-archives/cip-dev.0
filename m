Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B661CF6A9C
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:30:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3013.1767864595471825187
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JLAuuuJ4;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfzJOk/i0OzNCnPPNJqVQiFMZtb3Gw+Ww0BFGnDjFj/kRlAxrZHoJ9skAXa2gCqOQHBj6oUsOLUqkHTJS0R8jWEpoqz8ADGDBjvwYbKrOZxtUGG1GeIF9bqa2qAbAgMT2GUQY8Z2eU0hjxC3MKnjFfEHRi6vf/+e7HhBbV4t0wbMLEpBACmkGmNJ6+dN9J5KIJySzpU9zL5g5EmbjswPIlPDUa64mGJRe7G0JEs24IqM61EHVjajODQDIWkZgsbEGpKjG39A2zI5yBQgUYQnP8YrxH0jTrBvyGDju+AhEjtC/8PR8fAWKbNMu+h5PfvD70NgyR1SyfS+ITOpQAN+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itiv+HW06N1wMxaoNEoTHM6N/2y75ZrfWdZBL2ebl7Y=;
 b=UvqLl2LpLW4J17pkE0xDxUHQsXHZPuAgWe1I8JlSqIBDqBJsL9EOihYoURL80yg6mXFDsBwO7JmIFJyIJ+CWRO8e1xLNY82FedW3q5nU0XWB2AmWKNuNFCYI4BnSgghwTqzTYO1xYBGuFTVPQCVgRiBZMhw1/iizZut0Ao6mb8FR5iTpPp7LEvaRhvxB8maR1SFOEXpm0eo4zpfAAE/fDyAgky2At58hadlse5ALaCbbT5GQfWZHExuGd6SfAvMI2F4ZEFm3IqBjMr+inxkz6Ibjj+G9jHmXf90KDHtb4jtDNzThc7/RYZTzhIJRGYVqf+a1bkc3kV+c+S8gtXbaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itiv+HW06N1wMxaoNEoTHM6N/2y75ZrfWdZBL2ebl7Y=;
 b=JLAuuuJ4RRixwbAUyc9lkPvHMLxD55M2/xdBot5fDD77NgrHnIkTx6dVvidkGf2eBYFw5BmnBpXI5eUm/VudWMxBqLU6dRsaxHplk17eGUxDKVRGrs2BPCW7OJjtgwHrfnOkeX2ITC9m8wYa+m9WxSS3sRHcD8vFr/a+jlYk9I0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14326.jpnprd01.prod.outlook.com (2603:1096:405:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.1; Thu, 8 Jan
 2026 09:29:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 22/22] hwmon: (tmp108) Add basic regulator support
Date: Thu,  8 Jan 2026 10:28:23 +0100
Message-ID: <20260108092823.489287-23-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14326:EE_
X-MS-Office365-Filtering-Correlation-Id: e638c70e-c6f2-4add-3efa-08de4e987980
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7AN51McDoLCc4UBh4W/vv9MAWL6EO7Zbu73uQcu8xhz/10lBRn1+k+pRouTf?=
 =?us-ascii?Q?tUfu32yUT2kRwPJxi1vfsCb/Psny3MumAKyhzKHP4ehdFtj7dr1eCiVlAgS4?=
 =?us-ascii?Q?NCrzrjXpR6T0rLNK9GDOGKdIE0xireiNRa1u2Go90kaEIM4B6YaRc8tsBZGh?=
 =?us-ascii?Q?Kjn6672LXoXEOGA8/s9BX4s0PlPtI14mzcBWefe/voYvbLFqlm2FiFBUMzGv?=
 =?us-ascii?Q?0xif2XUvNhQcHmRBVlc28jH6xFlWgcCqXYsHamJ4voyJXrfDMWT7I1UZBLoL?=
 =?us-ascii?Q?lbCsMYI+fTa1m4xskB4Lo/ijSWBBBfWOMFgWzgojvREy+e5FUWuxaQ+ALgq6?=
 =?us-ascii?Q?yr8XEAaScKGrDGyswEA/WDlQs7PNqbzHINbvEkuSXVc/cJER6u3omhImcFTH?=
 =?us-ascii?Q?eDJGj1RfiI9B1tXANpATSGfo5tlxYmqwDRpNinc8EoqRql1tpxZm0jf4UOZu?=
 =?us-ascii?Q?bCWZs1qi+feJNAAz/8wrpFb7xw+0Ynxmh+w5YXAQz/wJet552MCZ0yuAnKGG?=
 =?us-ascii?Q?Lv58PSlO6Hx6251FFvYqoBbx+M1Icw5Qrri6fjmrfncZJoFIhFEzumYstTbD?=
 =?us-ascii?Q?GE2Wa9p8MZ0MITImYO5QI+wtPOfklQUNrBqBi5MvSqPpza6bCSbPLlNTujk9?=
 =?us-ascii?Q?mc2FHjsBxAC0lii02rW1jci8FiEd4PWmyNRMV9TcIRE8ti/1derYoXJTxerZ?=
 =?us-ascii?Q?W53cuFNtEUTFNCg59DsvF9Qi8sLYIG8FgqOrcLSc2TZ70U6RJNj6tzEApYdh?=
 =?us-ascii?Q?PSh21x1VKPyqMYpFmbBTxfZTMNCl+a0btMlpKfyVXQOmcNxTc3j63w/GBEtt?=
 =?us-ascii?Q?k8KYgey4bpMN1DZgPYDhD+TdWW+zaIzMXXGJAYpJQOveLv0rh11nMj5H9sxz?=
 =?us-ascii?Q?pTq0+5ZZtH4L8XMqixWPS//0c1s8TjvHmU+4ybgYbUr8xIhV/lcZH7uA4MyQ?=
 =?us-ascii?Q?SzExQPqXVyij32OehoS7nS7a74zzB49GkjKIMh4wIQu0+YdKB+nUZM2rdI56?=
 =?us-ascii?Q?WFGWrQNudvQBR7tdSCG78BHapaEp1RNA4ts18lDRuoFJVel7oFm0s3UgCfh/?=
 =?us-ascii?Q?NGsw+QPyKiNv/QfYIr5h9rSsug91lfnN9qRM6vpGEsokaIeh69l2Cuc8ackb?=
 =?us-ascii?Q?e7EqpbNv6tdOc0WOqtmczxAQvmsen2RXu9a2wIXPnpUJnUVdTLJSErH9lRJz?=
 =?us-ascii?Q?EWUzm3sfypwa7GM6BtI8MfDplwG+8aRu21wXn1BrHRxxDX47EsPHx1/TY0AZ?=
 =?us-ascii?Q?OQ5mGaXsAThPNaYQmhdWM7iAiUQXWde5Dos1T0GGvRkqT3mTgDWrapH7hCjS?=
 =?us-ascii?Q?AT2HgrQb8Ks79GdbHCeVxH5PuA5bqbCh4hHv7aavI/k5+nkmoDSMCEZxIova?=
 =?us-ascii?Q?kLFbPTtiFDXADQcBiN9BHz/x/aqfscor9MzDHuQoDSQNn+7CdDd5wft2B4Yk?=
 =?us-ascii?Q?PSIFV5f4kGiuWd+16ZCHCq4DDFGpJAwUMwpfgf1yYEhGqbjoM4H9cg6ekCi2?=
 =?us-ascii?Q?jAyAclYb76HNfXUhGeKncAvyoGFmH+lP2jS8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQEv9eooIQAZICkpHWbEPpxq7NelRbTYTdDuE2J7bmEk3Hhls6z1kn3+n36C?=
 =?us-ascii?Q?ocVrVtw6c+vOuylsFuM97Mlwzkg2PzCmYvUoU/Q5cJmHXP/f+5+IyKPXg2a8?=
 =?us-ascii?Q?gOlMNOY7lBOnbHU342WbqfyVpbvZLw807CvCevhSex6wTOxZymQHQgj6bcGY?=
 =?us-ascii?Q?EYK6bkr7vQ14b+0q5CZqNIUSIkbQojlyAc1nTgxM3RkRkKd9JHHe4gIh71QO?=
 =?us-ascii?Q?1hGN6lN18LwAhtOmsF66ZUNaXsJwUw0HL9d28eKxudKW6wIDObRQu4QTNRhM?=
 =?us-ascii?Q?drUaS1kmRAuPU1WDolhkmSJycn3YrrRuI18Spmr9ZC8dJBTyyNajEYFtYeK+?=
 =?us-ascii?Q?vIPRtYXGNoBhUQIt1REe8tX95aDiD5MUJxmRAd1pBAu5Xlz3Y2/pEnqdVPBu?=
 =?us-ascii?Q?KiyaQhf/a7N1AjkQjJYcE2/CQGPrFSKB921AnW8Ze4i27BHk8DjjGgaDq05g?=
 =?us-ascii?Q?rW+8ORwCdiG089X8Pie4cjlZd3kOXId8iBTiRXB3cf9hyG0TCwZnFE6tZwEj?=
 =?us-ascii?Q?Y4pjVTMA0CGNw4RDYhm7rJOGauT+vv1qlFMJxfSkEXyDXv8w08f3e9CkGxpT?=
 =?us-ascii?Q?U3ctEGcNkYY+v0ZvRL5erTanIWDKkE8HrUWBXeLYpqNPXUkBPCOUY+bLnkZW?=
 =?us-ascii?Q?4kgro5t8MmdEATyhaxwPxXXQpaH4yKo4ozfDHmlzVDXW6wZPB5rVNHNjG16I?=
 =?us-ascii?Q?aqDxpk+FQ1irNDkwTJAKlaqN4uWkup0dZd0R61PMC5mVEMLF9gr024pUOVhl?=
 =?us-ascii?Q?DfrgBLRGN65D6QK332mt1zTcYxvdkM1so4+cZg229XuR3iwESPWNUifRL06E?=
 =?us-ascii?Q?tYsKt1IS/OiVyd8LbG3lcNWYBDkBMoQ28LQdrrNWKgX7kOQXHrDmm9w19dOt?=
 =?us-ascii?Q?yLbCXil1+uEsLA+/FVGBs22w3LjgGHqUKnuG058S1dQ2zLYgAS9zcOMUZ4up?=
 =?us-ascii?Q?ZGoqjxU1JLzYQjMZIcHWDGV+Zg80LG7sd2+0bm4v9wthqWmypG0nEOHhhrzF?=
 =?us-ascii?Q?vSz/SGPakd0yyxhh+1sG2TvBsuKi7ELLkq+oXF5DMujbSi2+PnNqVxtyNYZZ?=
 =?us-ascii?Q?iGucDxnKtDPKevgbQl8ATerNGAzx7ItTQS5fVHAMyrdUobM2DENZkzJwYC8L?=
 =?us-ascii?Q?okraQrCiK95bJv9VMbx5xZvFQgKzWh/014jdf18Zh9rWR0Ahne7pSxu/tDsV?=
 =?us-ascii?Q?H+LDD32I0Gm23T6YonsOdV0XbivHzLSt7DCWvjtF917YbPAucy8+TgF+W+21?=
 =?us-ascii?Q?z7WCxS8hAXWKZSdb1t4InTkCVDFlP6haPVOKeBWnmWwrm8pkANopDp2SLp50?=
 =?us-ascii?Q?kMP70Q9G9juqpWVbcnMGRHgf+NHGE9TWOmppudj+MXHD7Y4OM1/eS3PKM2tH?=
 =?us-ascii?Q?XzyW5ZjgwTrXJ1ByR59kMTx/cd9uByn+/VGicQePspSJWwGtKKQacUrQYrbv?=
 =?us-ascii?Q?wENgw7s5kezA/lG/dnVJLQMmUqONsfxtAyotZyBNSLG0eIuGVyURKAdeAj5a?=
 =?us-ascii?Q?ZIOV7STkpKNXqyWCrHE7o1s/V/6AryV+DOxtbYTKfOx5HCA6VwT1Jdk50T2M?=
 =?us-ascii?Q?HNecUCLdRxikZcXUU9GXx0gQh+hEGiaiPITClrNAeSFqtYRA/N10FbdXxr8b?=
 =?us-ascii?Q?X3N9D0EEX0JTZLiUMIuF/6trumRZpx2E0USmQrC8o9zN76WTDjArelIcnDrY?=
 =?us-ascii?Q?iDFagim9DNm0HVBzLfQB+dPtf4mflXkWen69iUws6IcNfl610Hf272j//j4W?=
 =?us-ascii?Q?fioapiYWuukrpb//buzWcv7Kt2jg8QXzPspfc131SL1m3Hh90W2L?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e638c70e-c6f2-4add-3efa-08de4e987980
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:51.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN/aDHDfL+BWyh/f1vDrijpIYhAZnYPB1+o4uFyV/6d36qiqYnfQKPJKlu9khoksRZG/Z3CR4K/IFpcFsC9auv9vuT28Nb5iDqD9QVSgjocy6rQizzG30wioQPB0gL4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14326
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:30:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21458

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
2.43.0


