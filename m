Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4FC44524
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:15:50 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13212.1784294149982330811
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:15:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fI7IzxQb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.35, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3BIcZq+M6781Uq2uyZ4wRtM/qO0d/bqV7mwPXArAaC1BldxE6Cv+18zrbZ6V6V8s4rJW1iUnEwywpR4AxuAlipz1AceUPYJ5tSXRxFOKtx0G9sLJ1vttrdnSxjqcMAwA4Z8gk6MiDEZ1rgDLAUSV2/GuYdp+MfjfWAFhKJKXmkzbh1xxJFag4CffMYBPhIF4/VF0e4jFP+sNO1Yg3nq5abm4dbDP0sD7BOWhRZ5VBrig3IVASCoXTojkPVJ1Hjpupvq+Rnvdbxf98Ro8ECBnfd0ydZ+Mjx//1WfyAw4F3rWJV/xVdv/ZBU9E5v+p4Yu13lSFgmlz2FgaLqHa28FMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmUclzBHVeL4MvqqQ6EWAUTTD4NQdbH+8hKpqEMKHmI=;
 b=sK7IfDauzRhggH7Mn+RnXivf9X/z6Ezru8XWbWfBfnyWX0nHc3YZujckz/ivJQiUrVC6+syiHk55Ot+EekbJ/NJFF6Ddad/eevSKeL/pkAcUChfVCdxaSjBMx1utB6Skn4BjqeD/XhtzwUFGrFq+Ymba31tu/3n8M8WCQOpeRq/O06s0PKAYRkFt+NLkw78MCNSV3JPnH/ZczZlZ84deRIQQPQQVOCGtri3p+9Qj1djR4n5eeV95RkloFTfg1f/J0mEitA8lW1V5trZOztAQk7WoKt+c5FHARpTaQO6/9rgFDKDGikbkS8Q5iLyquzo7k8LYkuf0QoN6zlN9yQXUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmUclzBHVeL4MvqqQ6EWAUTTD4NQdbH+8hKpqEMKHmI=;
 b=fI7IzxQbo2yfnXrSyZnmOWk5W4Mi7Si8WmDK9jreyQhuUKQABZZGDqT1LqdYmjRyKgoj5s0Y8F5KcULizlxXUroirWkKjVL1JPOD9LAC9rpZas9VfZuKu+OQiy0M+/dJXvgzbSKkdha5B+mK20w/ahqsvjeNyZwk9OhjTwI18GI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:47 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 08/15] hwmon: (lm75) Add NXP P3T1755 support
Date: Fri, 17 Jul 2026 15:14:55 +0200
Message-ID: <20260717131502.2234020-9-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: b02428ed-2c48-4a57-c694-08dee40583f5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	lROz+YiwCB+3N6aDFTqMfMGfeDD/BndIHMteP0T9T/ourNwF/C0JOGA7pP/jl57g9eHkjjRUe/iC2CwU8pR3ASwMN+8j/He0LIGm1rOeA80WJg9n3b2tJKJhvKwb7Ma7cX+dhEsDSfN11oOKiBzoRm6dM+TdGVjUDhFcdYHGmRTgb4jG/9UqNI+/5WRms0sPwRCZZnhWdepZBjafMouj7opH5QM9RAJJT+KAxETPBADk+TGM9mneb6KLz5W/K6JIeKYKHOZ4vCYjOXO8RaEJKBAfH/fQvn3cq+UE03yxfuYUqnVw72RWGXtdYVL/5mjqST549syQZ0o4v0ZauXLMjdCp7CW7xFqdVj5sW1O8eawdYYvR0EulJHEMm6U4XWC6NEm4WEaRMUMr65CuP9fl6BwVsWlXzGfAmPY81Y6PjWkpgktld1u5r1d29ngOpqA08tQ/hiioGNlpvqXjHpqabgFTISiLOz/05BUtpBDUcg4wD1f1BxWuoKvnzYvO91AmFuaK0fc5eZOpRpGAvai4G0h/HlVqKwpEYZLmUYnoQBf9wKd3IhPYACbMp1wHCnB8Ok8oax9LzRcI6MWQr+IMwRLDda+1AyfDSB4PxbhcXrZF31Sbz/MjZFhVUY6Ey1SVReKi1JYBt89rEvTgS54/Senr2tMgVKOVi4o+IuiwLyXWKIK4amWkzzpAP1bg3ae0PBUhpWHIlABJF6ZIAIICq7/cV7EQRApM37HNIuP71bk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8UQXwK2TaYwpa8hYzlcL5BnsZtYpqsvOCtdvylsGfz5wetCg+PS2GLz3BKGb?=
 =?us-ascii?Q?IR4Xp6ghyQlEl2APlVWOUVUHQjj26Fj59wxT2guEf+SpNAse1RD6cWcNWQWe?=
 =?us-ascii?Q?ykSQ2+M366erHNj23KWL7FdoFR7Tz68hxlY+eLt+alu89Zx9IOBEXAYideoz?=
 =?us-ascii?Q?aT5oyrYaHb9Uqk4S9BbhJcJgsM+X8lJd+fYvMBxmVwzn+XhHh96z074ymEsB?=
 =?us-ascii?Q?abZrz5VCr56cUuBahnrqRmv5AKvZrV01D7tr2oCdEvX33eszrf91lV5CEwnP?=
 =?us-ascii?Q?MB/Ihaf8edSmi2ieE9wNE5014EQh67N8/OoEfBJNUKdl2rQBnwTYa5CYcsNB?=
 =?us-ascii?Q?v2Wgd/5x6F222WDTYfeCT1gTSim5tAXJInCo9+FBZzXcTuNzy1BCdwBc2/5e?=
 =?us-ascii?Q?P2Cp+Gqh4BHmVSceyb/ppOWbDUx4VDBOn2L5MfikM0hxInxXaa/pBAj6Ycbh?=
 =?us-ascii?Q?eNC0awGq6b1FgUmmdq0Fvy4gt568xDGasxkI+BdpwQPRKTpf1MJPp3IWpjPI?=
 =?us-ascii?Q?YtZ8o+8R5v+Kuy9mBf5d9lX/vQnyitQ+uRGYFBMJJnP34KTccArqj8TQd2c8?=
 =?us-ascii?Q?lwWloh6CibF47x4uDqTsJcRxvr2UVrhMOdED+y1wgqXrnAdDxzW3Gs+gD6BA?=
 =?us-ascii?Q?WfDBITBedm0ywz8vZZf4AWjVlSFB5a5Vpqa7GJ/vkvJIMq2aasPMzdGw8n7I?=
 =?us-ascii?Q?bTJ6wIcyiL4Piv+ZzSviYy2zw1E7+QqWMMmib/qlzb7JoStMEo3gkMp6A5kP?=
 =?us-ascii?Q?yhG/KWQkyz6K8pApHZFweTiILJQWvPHJiTxQZnEOjlF8FH3sCqxu21xYGMVi?=
 =?us-ascii?Q?wvP0ZwVa0X3bLLbhZ/zg5Z/nU7ABhE+2FGMIthCB/7qOwDqyP0cAdXgQiCZv?=
 =?us-ascii?Q?IwhS0sUntE53aMGQFcgwHTMOfybJoPRsJT+VQA4hgTReZQWPodMuafnEQKSa?=
 =?us-ascii?Q?KQLqMjb15f8/Q59w+KNE4D7vpvib1OAv7YphvyIjAXSPLbYySSOzqxG3znFP?=
 =?us-ascii?Q?WVwxDBtpHNlhOjtLKylnC3bJOXxKPHKfcojdV4tCfIL3Yx3fC0VWmB+Qslmq?=
 =?us-ascii?Q?5LbLPZVXW4CyF3qaAqwO7yHHJfglRZktQN+EkaEkXU20KJQvj09I/QNkffRg?=
 =?us-ascii?Q?MOtRdu6eXFr+nKEN/H1Z9ObKKu7ebjUH8Hv01llU6AaHBn9AUlQQmWMBOryY?=
 =?us-ascii?Q?v8bOZQ1uSXk/YeoELDkRyxP5t2FhCGR2LtUgReV6kUbQ9KdglVDIhmlvQP3J?=
 =?us-ascii?Q?+b68CYFKGQl69ImH+bYpkBIzBgQeFW0ipU0LZ8Z+yd5f6bYFYvvFOE3dcpmT?=
 =?us-ascii?Q?XlgfuGI4PzIBy5smh4KdNZX6ZzpchtfXTNtRDsU4yoY5mKAMUCIS4eR7RcfS?=
 =?us-ascii?Q?PXBYIrF5mJh3cg+6V2gOE2mT/3HBt9fOH+wXm9zrXdCs+N7/Zm1XK0oPxKwV?=
 =?us-ascii?Q?5uK6hnO4UAGIWtf455lx5NwF2Sm6N+6ElytmSytOfEsurtUY7TfWBT8hLKx5?=
 =?us-ascii?Q?mqTSi+iWhGG6Gsq8zIj7krGc+oGhDC7tMFdRhJucrpCJxKFb4R0ikqOBq25r?=
 =?us-ascii?Q?HlPxRP/meMeyliEYK4w7R0hRjpEfPxRKPzFwBAtuOLBFBW7Nf5l+OZmPFMfy?=
 =?us-ascii?Q?0yZGAiJJAmoTKBTCBff2ZhGa7iJJkLo2bGsTQjT6CmJ11G1CL7q8XmsEFBiG?=
 =?us-ascii?Q?bAMeruY7oQDnnlhZr2XMellhzorltT3u/hGjc5XzIkM1eiszy7qbRLdw5vzf?=
 =?us-ascii?Q?7h1Im0hEUOGWGIt9i2BnBdYGye+96wLipryilBk1+FxXMo+tPNAN?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02428ed-2c48-4a57-c694-08dee40583f5
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:47.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irhc9bJJBfKRB15ntOFSWTSZpmV4WzgknSFUBowSwrSpNOIXsoIpX0TQHV4YbP3C7GuQSXvCz1m8jQMe5bjHnl7QykhvcJHFCia+NyWEghB59E1/p1ZdNDbyxgyEIipq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23660

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d3506653d01c0df1f1c86cd49fe70c98f00f1aef upstream.

Add this LM75 compatible sensor which needs a separate entry because of
its default sampling time and SMBusAlert handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20241218074131.4351-7-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/lm75.rst |  6 ++++--
 drivers/hwmon/lm75.c         | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 6adab608dd05..9877ddbbf7c8 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -121,9 +121,9 @@ Supported chips:
=20
          https://www.ti.com/product/TMP1075
=20
-  * NXP LM75B, PCT2075
+  * NXP LM75B, P3T1755, PCT2075
=20
-    Prefix: 'lm75b', 'pct2075'
+    Prefix: 'lm75b', 'p3t1755', 'pct2075'
=20
     Addresses scanned: none
=20
@@ -131,6 +131,8 @@ Supported chips:
=20
 	       https://www.nxp.com/documents/data_sheet/LM75B.pdf
=20
+               https://www.nxp.com/docs/en/data-sheet/P3T1755.pdf
+
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
=20
   * AMS OSRAM AS6200
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 2c2205aec7d4..a8f95bef68cb 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -38,6 +38,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	max6626,
 	max31725,
 	mcp980x,
+	p3t1755,
 	pct2075,
 	stds75,
 	stlm75,
@@ -222,6 +223,13 @@ static const struct lm75_params device_params[] =3D {
 		.default_resolution =3D 9,
 		.default_sample_time =3D MSEC_PER_SEC / 18,
 	},
+	[p3t1755] =3D {
+		.clr_mask =3D 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
+		.default_resolution =3D 12,
+		.default_sample_time =3D 55,
+		.num_sample_times =3D 4,
+		.sample_times =3D (unsigned int []){ 28, 55, 110, 220 },
+	},
 	[pct2075] =3D {
 		.default_resolution =3D 11,
 		.default_sample_time =3D MSEC_PER_SEC / 10,
@@ -734,6 +742,7 @@ static const struct i2c_device_id lm75_ids[] =3D {
 	{ "max31725", max31725, },
 	{ "max31726", max31725, },
 	{ "mcp980x", mcp980x, },
+	{ "p3t1755", p3t1755, },
 	{ "pct2075", pct2075, },
 	{ "stds75", stds75, },
 	{ "stlm75", stlm75, },
@@ -813,6 +822,10 @@ static const struct of_device_id __maybe_unused lm75_o=
f_match[] =3D {
 		.compatible =3D "maxim,mcp980x",
 		.data =3D (void *)mcp980x
 	},
+	{
+		.compatible =3D "nxp,p3t1755",
+		.data =3D (void *)p3t1755
+	},
 	{
 		.compatible =3D "nxp,pct2075",
 		.data =3D (void *)pct2075
--=20
2.54.0


