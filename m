Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD4EC0478
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:37 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14392.1772529814325488562
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=obf/Y6jr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKdmWAvsojnhUocU/QGDXkV3eVOOHnCrrsaZKy1gheGJE0g6sTtFdaZfj9RgxngFkeER+A58vm58VfEaxi/lzsLnZstd0oMUcJ2sjUHavdF5h4o1IsdnXBUXb8GtNimahn9X2IKMvPn0kEYEI77PbSk2YmCHsEfXrUOhJT2SQB+I+D1Uyhyi4tbvVBC7kPQNyEdptu2TivkM/vYYavb2ltmtzajyQ7HAadqbE7nEhFCtxy8U1Hf3C5eo99tcIAi/qyRYq5yLj/RPbsyXFvvsEHJoW3xeHCTICTghYktS1TLvnca9wl1yYTb7IPyBRgLGl+ox2IHKyyga0Ktlf3TRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/urZE2aeQTsCbT10LOBwm72LAkzxSmq48wLBrq1VrI=;
 b=qMybt+FsPeEDP3hCwe2fW6o1Lwi7K8bztixDfNcXWMBr+JeZANj7OiRdqg5n4YD25eZO4mL8FU3rvaC9s8LFGtOHSdM45xiSg1XmGq8tdOPnvxN0RQeA2MlsZmPvK/lxyltuCORN1yCKpzJ+T71rEmSCe4NonV54eRgjjMFugOztUfqJNBG0QMKh/47ELM8sPO4P74oqIfE1aXh0SbyBZfn7vc+x0dGKk7CGcWlKN4FGk6V/w7nKvA2R5SPUddba10f5Kw9391N/XORqe3tCeAWdrRHc/GYWDWK65p/bRBNvNkGgR0A1tNQqaN4iNbP4ujqGtBoAV1MbCkuEz13tXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/urZE2aeQTsCbT10LOBwm72LAkzxSmq48wLBrq1VrI=;
 b=obf/Y6jrnjDrQdMpZj0oPnqE2vTkWza94TxLqsrB8V8J394xroAIYE8N+hg8+jGKCbQupajMjoAu4zBICvU2ubDQp5SxYYV7piKElPl6iWm1lXJWEm6oQL1UK+mO3pzkUsfExgt0RAMcLdIEDJBFvFHbdwC5H5+j09GuKt+dBBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 3/7] i3c: renesas: Simplify return statement in 'renesas_i3c_daa'
Date: Tue,  3 Mar 2026 10:22:55 +0100
Message-ID: <20260303092259.13301-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7926cbe4-db4b-4c07-d0c8-08de79068a62
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	Bp6lEx45Bs/NH9Rcx+pccZGuvq5AugiBXi5Yy8EfuVru2K9ChAU4U86NAXuJOOmQwsMh2l/wroByP9B9tQuJqjjKvU+l5UavVy3MqgaauMLTTenZY94MHBbPgoZygvTjQ7cvIVpx+DfVZoqPvyV/ZbKbx1UrjTCwU73npAuW880H/IrSLMttbZf1QCQTHTQ6nVXMTYZxfaDep8iaGiU8zHwJIegvR2QFsUuOPR7S1weNOhB2SDyu5NL1Qbtjt43o2sqBWgAw7TVx3uDSJXe7v7fs5vAJjP+HhE+QAvjJSJgn51pR70TZkoRGVYz/swP+GYWda/tZBqc5dPXA6p4WCycBa+W9SUUZvdoYLBddvVEudi4ySut1LvkbYPWAUF+yv9yJZ5ClRMIByczV06PzhUS0Nymx7OEBNJZJDZqgZAUEdPLR5R/SQRHF2gswRK6p5zIpbULe1cGoedAc1J2cXnDJTMy0iqlQFqSfE9HIMvix429sRMW9//7LzcQDtZ3qkgTKpHMMIwbh9lB1EtOwq8jOgFkSKqUK1zpoEe6t1cm3aM5/yHoqUrDRhoR878C2DhwEE5RVdCn45v8j9jZhbPePpS/nOhTlUCFN+4yFHeH5Q1RfnQr1aZLeb8zltDofFOBZvrNRmUGC6JdEmZhSTmMvA05mLZ4ri2v4nVrAbcrRfMIlBqd1CpppZQakDqAGOeI3NgBVASh7Wrp6p+d9sYFFOK3sXv21rxqXllNejbL7SzA9SZ3+y4XHIafOitylcdSndC+m+RuQaPmmDVEv+7nKi+im8WUs9gxLPFjeS1c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jLU7/7ZDIrCdRJ9Q+lLDCo7+xD6Hu5ATlYCTlVc7PZ4bKwG0xinIF40pJniQ?=
 =?us-ascii?Q?L5CeNWYL3onSGySsqJGS0KyPjhg0yABWTmLNufbjxS18tLXow+p+NFgsCB3e?=
 =?us-ascii?Q?GxHiU8YSAyy0Js5kprY0YMPZPidrxStZUANW0aLudpQJyqrCWo1cWQf1hPqq?=
 =?us-ascii?Q?XGIwtAXQ6Ev2Tu73U6dc/CoxDb8t1cQBEZ0jENftIKBVFUPNwDTVRqyfr8fs?=
 =?us-ascii?Q?XrR8KHthpGYATa22eFuUa/MCrrR693jKq9ENAe84n4tXFuZnyUW3Ic0jvfYZ?=
 =?us-ascii?Q?kr2zH7+otRmF+xnkjlTi/4aFb7tTZSTR03cUBckhBqiLLEZWYDdZ0Mpmk2Za?=
 =?us-ascii?Q?GKhg+e//YC3HpXQIaPod87YLntK1lG0CpY7WCU7511dtwnX2HtNHdfVrosGo?=
 =?us-ascii?Q?/AgMd0eybbwunt9eFd+TtdG1z5ZS4V168kVYU+9ONY6d7oYSmXj0MyolC2XM?=
 =?us-ascii?Q?rcg1mkUEnODNN77hw5fX0Nj6sHkE3cARqzqaJGCCxjbdnZnqS3nbco+zMa/p?=
 =?us-ascii?Q?ZJ2hfmpKsjiGFWHAFq/hMO65Pdsu9NjqS9QH6ARH/v/m8foBKtKbRqZc2I82?=
 =?us-ascii?Q?WKQ1IuO9NG267eBbgUe+cYa8X+dXc1KYaAU2evI77+9UBcTM5AVgDRsX2uTR?=
 =?us-ascii?Q?zOu5M3XEPCZLL/pIhF7AZ9v1IekD68G4TOI/A68T14hQCF+7gW2t8RissqYU?=
 =?us-ascii?Q?TaBxKt5V+fa/t7pMRB0A6s7zDJ2YboNs3moGRdiiAkSdzBEW63ot9gS9s8YI?=
 =?us-ascii?Q?pwu416rhkw7TSEQnCXrZWOfpbde/CEYb/1qxSytgN7ukdOrQXRljGfJ+XVAq?=
 =?us-ascii?Q?NK2W2josJEXTyTMSL8JTj9bSlq0f0DH4JzA1MQ5YGR9yj+HXEggfYwecB7H4?=
 =?us-ascii?Q?ifSGnBTemVuHYlfIcDY2XfBLRZkg3sg3eTxaS1H7r1EYsgh94xfOSuptnOF8?=
 =?us-ascii?Q?80HwAJW2bZAToElArGwTrWMwwhtWv5ZNRR/gxO99hrVzAOd0zDn/JJcnv2Ob?=
 =?us-ascii?Q?XZXxij/db3kx5dQ4LCKfdAVP9za43kwpswqosfwoFmhK/CGZvVupb2GnVCA/?=
 =?us-ascii?Q?Ku5tyVNyP8Oinf0ywMert6lz+0M2D8jIk3VUpa3a4kRYke129sRzQbJCtLsv?=
 =?us-ascii?Q?3XARWGJRDCeQrxirETqS1cyAAv6gyEnJhCXQrWC8RfUq6jXeGJkRKJBu8K3K?=
 =?us-ascii?Q?khxZ5KnOpklMKSaElK650x31XdZnCFcNqfsfcZwLVEmDCfV70fn+3a1wnPeZ?=
 =?us-ascii?Q?oKU/gyO36KvTBKTCHVKiKV1Uqb1FLHyM/zxdJ5NYp48OCS74MQRRA86ljin4?=
 =?us-ascii?Q?Mv+5HpVCfrHnHkENt+jLRew2Leejqmw+GSkiRKEuhzQBTsDJbc+frngBH6bL?=
 =?us-ascii?Q?wEBw0piNjAMboXveVDco1AgXUW8LyfQTinsitV5bYEADloO+9ggdBFSwao68?=
 =?us-ascii?Q?zwXNKeEmymtneIWSzKhm3mrYuNSK5ypAyePPKaPZgnRYRFB6olA7cSCRKWsg?=
 =?us-ascii?Q?7pWXxGNueQh9oB0u0a0jbQg6j+cmuAfkawB2lqCzFQAz1rkfLIqYuiEpnV4G?=
 =?us-ascii?Q?fphikqFjX5OcPY6Bxe/qA0I+YpwnqJgT9w+oFa3QBRtvVlZqRTO346Y47hfe?=
 =?us-ascii?Q?1eYbXW+kbgsidL+oC/Ry0a53iP/XL6wUUccmThLyLushz7yLAiLbWqEqIN59?=
 =?us-ascii?Q?nWPT9b5jjyqzIr2Aryx6zHJc7YFNUzN/S8wYU61tW4HLGFXwiZBav8RfiNrC?=
 =?us-ascii?Q?0Dq66B7detBYo3SSseNue55YbeD18KRq6KwJ98+G279rQMap/nFs?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926cbe4-db4b-4c07-d0c8-08de79068a62
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:33.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQpONeEARXvoU+3GBs4hQNW6TAPT4HUSbEOLZuYyi/oZd31tA6sqXRhj9lQzqUfXQc6iwF4PVkjGT0HXydYK6ltzflt4vx6ePNLtHmmypTDjznjVVd1s36+sUdfu7u9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22054

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit bc7dd24c114e37c67061f4651bbbbbc57106c617 upstream.

There was already a bail out for 'ret < 0', so we can always return
success at the end of the function.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/aIyzJ7HOENL1qp1l@stanley.mountain
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250803211256.18513-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 174d3dc5d276..275f7b924288 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -679,7 +679,7 @@ static int renesas_i3c_daa(struct i3c_master_controller=
 *m)
 			i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
 	}
=20
-	return ret < 0 ? ret : 0;
+	return 0;
 }
=20
 static bool renesas_i3c_supports_ccc_cmd(struct i3c_master_controller *m,
--=20
2.43.0


