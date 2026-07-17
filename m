Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC45C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:30 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13294.1784294066136488329
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uxN2QVZd;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TveZVzVXYh0dqXt29lt4dZZkM644tOR+d+uTKmqnvkVAJhXUEBDtx1sNT/A3wgsJ8a9bnOgeoNB5SlIqOk9CZto6+ptOzU7ceqK5i4sh/wW5nl8q70byan1MXsR5tIhkhzVt2wBseYKwY9TMndrOxkd0JpFmEGFy2xA7+PokBLOInxmdc98aNzPVbbB8gP/PFuv9NIL4PR6Zo1k6UQDovIkK9e5AAgud05Z+lTOgQ9UCI1KlJwtH6yy6rbCCvcnabI2Gt75CGuvIwa7PzR2aPYn164h/UyGkwVfAN7IQy1+fJDJyKE1/rqx+HigIfmWU2ZYM+FqYSTxxT706ZTs4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTd9imto6OQfe4Odp8xC8D5wNtQUuPKZ0DlPX5OhP+Y=;
 b=R7omIiRxncGVegr7F2qgU+PJar7a3pTiVUs1JdLz5yCYRC4iPoAzyTWP3HQhTKUqJd4aB1bzrJKptxM4eTKXmeBbnTeyIVwBQgxYNNgKyQPO47zo5EkEXee2wxRpYVPSkXgW5XJEbm2dW01tv7zcrq/3MUbogqPks+KqlVv1ikUJsp4mOl067sfDBKzDb5yrwmd3sp7nxdUduBYN8K+0CFFlKeCepDyqjeW0JxUHCTFfsAkPZWq9UsiM6YlbCjVWQKSOwokDSlTiM9POsL6EEqeWQ7M6pCDj7knfodbLzgC18hYAclIJwm4C1gdjIXn0fi/saQEAfdSClSgB4rDc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTd9imto6OQfe4Odp8xC8D5wNtQUuPKZ0DlPX5OhP+Y=;
 b=uxN2QVZd0mmnl8tOyM191JnUdvnLmo8lxtdb0RGNS72cTNB/KQrx8O2Ar4nClsGmXYvwebPnj1D50g/S/ikxjeg89xwiFyIfu/1xG4YkjT8uSATxqdud1ZKhchiScVx0W2Qi9rFDERwEwZ8pLjmz5ODQP3iPLxPL8WWnejmZx3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:24 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/23] hwmon: (lm75) Fix I3C transfer buffer pointer for incoming data
Date: Fri, 17 Jul 2026 15:12:41 +0200
Message-ID: <20260717131241.2233788-24-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cd6857-0a2e-4aee-70d0-08dee4055203
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|3023799007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	r6N92ZFa7fHldcHZdcpdpNsyLK+4Caf8Ft3T1isQloWSK3Aq1lcZztl2clTt8N4b3r+/D9C8epWJVg1MOdYqZ/dCLkjpIRy9SePr/RX2cnnInuGOAXdlT+7NCNu6IAF8cYoDHjef5Uptgd/MnEy6YrDnnOnu0WHIfgFajoI7qOEdwbF/P706w0LBbV2uWVsI3vx2+J/gbj3DE7RNW9Ci6VJbRINDx/mq7BqOMPw/cOLkyQwCl+/RHvuJfgRlFT9r4qAlLeYjH/OBoRFbeYDfGYZhq8f0/irYthBWOEaQL0YbUwdZ/Sqe2+mxtVz2PNiWdCwUl8JbLhhJteN9AfvoaVbKtKpLvAV7VC5gfpYHXe3+AH2uGOWwiS7f3IhUdw+1g3HyIGezmaSb6WP4mb7j87UvyX8ALkzFeUsnpw26+5MsITepFrSvkp0DfPR7SgsBzKvAx92Ao+rVMh+20lioj5+xpGtComuKY4bsTszbnqWBC6aay/lJthYLlqnnPjT8cQ6OwM19A37zWkSh7UH36f/n8ax3ZIyEgiBhGWkm+dvByno1IPK8tYrqSTejqTDj1GnTIKoT2pJEamiS7IoPDHX66DcxsI/ky87gjAbVRJewejmldqqzUh+zA9289anSS0KlSNNdLpFe96tEPainmFvPN4vgBysRGjKmzsYxBG5G4B2KahjIsbmxCREP6lQuS3p+20iKz2/nVDR0XjpP+D8iTp6X5W3nBlUqecDSTCE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+cUc9o/vdSS4z09VUvrAJz1uu1aOPBjXAjGAx7um12PFQ6+wQjOkmaVOyaXn?=
 =?us-ascii?Q?+BLwR1jSW7itwvNEKDKMWb9Es6TCWavUJzG4BYYYppe2NwoUINBpl83/Nlva?=
 =?us-ascii?Q?VJ47eTrOogAZd1NXccK57l96NK3FNzey0Je+GX2X8biku9l+MsNem1hL8P96?=
 =?us-ascii?Q?AgK5YGrHlukROCK0mkPCzt3NaEU3I80dEwhDYQ59eLoZxnAyNEnZ5IpBTwXr?=
 =?us-ascii?Q?GrU65kJpWAk87HLIkOD7bfNDJXwH9nCKA8SXLe+RFdzV3t5k8A1FH+hQ2HUT?=
 =?us-ascii?Q?pJo2L4s6MZYLgTZXiEahP/+a6HPqfAQoG/Uy3wETviapK6h9RvQPs2bnanla?=
 =?us-ascii?Q?vLXHafT5vjDg3fcecbyPh0wP7AejYu+Nd7UwXOiJRoKL2m9qIfPVMqv41Jfi?=
 =?us-ascii?Q?x0EFr2QJ86V2RBqEN4j656SeV7tecgN9XOYQCKoDV5UsMzaXWsRidB6M4dtl?=
 =?us-ascii?Q?ZzaLZ6G0d550r9okwqBc/C75iN1g3johfIEjjMYcgyRTrJJpwKhK/beHRail?=
 =?us-ascii?Q?mQGgXVwnoLIUK7Fg/r/Rhbrb9XD7OmUkRn7WytDbJKSDuIyi8zBPaq+MAQ61?=
 =?us-ascii?Q?7CpSagMzLiwgLgEVdc9GYavZZLB9N8H42PCQpSVuzUvJ14yHWcxIvKxHZ35/?=
 =?us-ascii?Q?I8xmLJMklhIK8pjgemHb2U5/VGB2kadxCx/mqvz7s/wMqS7te7EEhCz2nWNi?=
 =?us-ascii?Q?znYBeSGCYDCCDHV8Cogk/j7o8MewtKECYGOtqVJSm+UFsPIy49wnquiWxO9Z?=
 =?us-ascii?Q?37HtRFJ6BbHZw+f0BOHKaoG/R1Tv9WLnZJPdqnfSkmuTe58n9d/IVahQzHJi?=
 =?us-ascii?Q?d+y2WniJx+brET6crlD/JDTLmRbGGVnrx+hOqJF2MIRNZtDneFXmnTvcfBaD?=
 =?us-ascii?Q?KCfOm1eKE5qdTAgNQD3Yt6iV7mJhGSgsPDhiUjH7kFbRzlLMDPpxKyOHU6Dw?=
 =?us-ascii?Q?uCH+n2AKGUeYSieFwBDyJHSHvjlYCJ3qdZNNhgWp9mOuuV10bjlWZRJ220GY?=
 =?us-ascii?Q?K6EVIoXC91WWHrEZ6kfme5jD9FIlO4peQDH8OeioEvYBLo0WsEvj/PUZytUf?=
 =?us-ascii?Q?up5wR846Jwl6Bf2cVyR0ggTLWuKn45GsDK3bJo7fJEiKGlyM60aSbAh7NuY8?=
 =?us-ascii?Q?J5Uh4z3YGZqYl3ESF2xlSq4nkHD/BzCRoKeogkRIrgoNCo+o8is9P215Nx9Z?=
 =?us-ascii?Q?Qms86Ds2M71KtgTos8HzDv4Ky5C6M6/uxFMOsvTpt5UqLaJ3BeDIwwWhyjHL?=
 =?us-ascii?Q?RfTQY6Uno1egQQocUl6vjaeDiFnwnAXe2ncHp/vIsSZKUoinOqIUQzCBaaCL?=
 =?us-ascii?Q?9Ot+kL1YE387b1A/I+Xe55rjpJtukmYNGksn4hXfF1KzJJCbMKbMCiAYXjx4?=
 =?us-ascii?Q?eCwrNCtDkNzgwWWaMBa7oA547/mYYB8uXrjvi/nA4mqPrwO0+zFdQIOv5zBE?=
 =?us-ascii?Q?Ci95Ptyc35ktN7uUXZE0lu/R1jL+Z8M8p+811zK3FvG5eDFm9dax42VkUxzz?=
 =?us-ascii?Q?1SGXZ9jVW2FRIE4qkgL98QREXRQql7WRFTBHPQfqq0Lb/SgA9HivsWOzTA6R?=
 =?us-ascii?Q?5Z721t4vd5TN8nIMDs1Ow9aAYOdv3lDZAD3F6+hFbsqd3CQ8MI+upcgNcf+d?=
 =?us-ascii?Q?g1ijFCH3nsN9oH0sOQrO473xEycLYvwCsZ64F/OOVaQgTm6E/JlohoGJ95ov?=
 =?us-ascii?Q?xIH/QpT59zCpVOOXUrRVf6+92/jtzFzROmhncWBWZy8kTRfydJTAF7ZCo3qh?=
 =?us-ascii?Q?vg5xbMxf3/F4vlozYsCF51kMEe4+ZOlogBS4DAM+gWs6fccjIKnR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cd6857-0a2e-4aee-70d0-08dee4055203
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:23.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMGedBmciQL/FYKDJzDB/T4ZYJttziDLC93HMALiJhdaqFMjAF7fGGDm/aqqwRWEO9EeuL7tCSYHOflv33Joi2pw/4NXOBg1Ano+7tIjZkWd6ra+ZvWd+cR+9DuPsl3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23651

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 0ddce5549012a3f3b9ddcf59822aa0d1be61e8e8 upstream.

Use the I3C private transfer input buffer pointer for incoming data
instead of output buffer. For now this is harmless since both of those
pointers are union members but may confuse when reading the code.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20250513111739.508886-1-jarkko.nikula@linux=
.intel.com
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index f755ed62c112..3e4d501ce316 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -623,7 +623,7 @@ static int lm75_i3c_reg_read(void *context, unsigned in=
t reg, unsigned int *val)
 		{
 			.rnw =3D true,
 			.len =3D 2,
-			.data.out =3D data->val_buf,
+			.data.in =3D data->val_buf,
 		},
 	};
 	int ret;
--=20
2.54.0


