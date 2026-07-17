Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F6DC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13155.1784294039337776395
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KhSBpdwk;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9TkKEP9JUyJi6OSq93QmGbVM7N6Ks3rQPJWOu0caWRfkJT6ESdT2W6LcQi+MPwus+ftCz1nQHB9IILfbb2f5mELcpwgctbLqu8RekDKbQ2LuGkvdyXiqWEjBbp7CyN9r67w3NJj/eXnpInAdltOxtAnqF0kdIkbEpUxDEg+hZ/jwWcRGOzUtOcCRUPbjU5Qh5IFQzGIqo8DRAnvBeB8UzftPZr8K9s24Jm1L/Vf7NYgvgvDBrIYgNB4JISfdoNrZ6xgRlfrK8SG52ASTUgI/ouSaAPNOEoTJ7nW9A0yk5IN0hCv1aGkwrYDpjNvTNMjfrQQe+3CgD41fAgBfjb1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPb251WoYFATkfzTugircaCeVdR0cc0MXeN0NH065hQ=;
 b=qUOP3Dqaf1hTgF2ELGoIs2LnePfZY8B3M2cJquCzS0oKBMhps2bJ0eRq9sQaH6kTu2uslPnusVmI7uPSlK0RSL4Goi73cmyYR2dlJYtv39ukvgxhi8IIkyxIaVijNvXBd2sKvJHzh2Q12ABGEy8+YsMX0bpor1wqw0yyHe530HiF73QqT92Ke+X2Se314aIQV8KY2IoMvIZAFCVW7eOHsmgUa4FTYrGwjZMe/tbYv2BE2bHwBmh9Jh0RJON0zF9UB3BHAOjVLbvJ6hqvynGKv6sXTgARSqoYHmtGyWhyew9w2Epg3aRpjNpBKjQzwSSOv3AVbynPfCr+hFj0enCJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPb251WoYFATkfzTugircaCeVdR0cc0MXeN0NH065hQ=;
 b=KhSBpdwkFSd3cK7pj2t4BBlg7UjZMBNSZqHyNUm9sGKsvuGOjClvZ9n4CFSXiwE1ZB5H9igVcu5PZmCaBB6j3xJfFziTIFVXGWep7zjG1TqFzF81T1w1SfC24KHRJ9TzFaGtlzZ/A2N9iD5Kzr7gFJ1pbY1qlt+y5LiZXo5TauE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:57 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/23] hwmon: (lm75) Fix tmp112 default config
Date: Fri, 17 Jul 2026 15:12:32 +0200
Message-ID: <20260717131241.2233788-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5954c1be-05b7-4e0d-0930-08dee405420c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ARw88SDa6iP8sccHijP6Gfdxnjd+rmBe4Ybq7roNOalx5Tvb6cwHWEKHhcgLgsqwH3fAwMmPZrH6PSyHCzSCXDll/dLhyQBhT6V3keoEQ0Wnfb2u2/e1Engt1YtxNkDDsOib+s5hYvDsDfUsKLhar1MOWegh/Pv04s5KBOvAWbfQNP0b6VpO2XlGVgbWdcsw1ZQwBD3HW+1+lkUdxdOpUJ0KORZsWN6zJbVAtXJQEVZ2g9sOJR5sDNxEXf1qmUSYfjq/lghO0GPSvcXL6k7QJA9fkG4l2pPWRBhp9WtuETqesOueP6tFTdwjlgcksMwOZCCE4EegJleh1BlVeQA7fVC5dBW4b137LhsgvpARTbusnR6Vwc+Sq0Djjw+Zpk+x/B6FQe9+zE0iUPzay1ohkVxZYDJb5B4oFYHY4Len+910KZUOTgXtViO1TqhmLTQIeKc+nBXX4gFpXeuMJAyEZoQDfMmHimYjGkWueuwNyCamoY9h2jrxJN0CDHCPbtM0GoSxZQYVUFgnfLs2u4X5PJ8xJZdl2kFsImtXHwgsQsPZHbAWq4piCrxyg4VHfaDYCOUFhzG9yVQRIVZADvQq58lIRzfdyoRDl3+q3cqhjccvIjVPrvRw/xHWCcHlou3vGYYd0bdKc1ksi/aL7JeOej6E++nozmZOefvrMvtNpFLfBZZgLH305uIkindei+Gwq2f6BOTV7RAMwGCos5xOxa//+3SfwLukuRb5i/l3Id0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fHBubt8KPaas1uCFXIKBqPkdoYh9NZde4KmJDHOgROiLiJHMWkqxjpH9PSQ/?=
 =?us-ascii?Q?JXdkCjIax2N8LRk8UzPxGw3NBa5YSU34je1MzmojHxO0e0KieOMsGseHIOWW?=
 =?us-ascii?Q?CTU+0+bwbT5eEDaAwNlSRTNkhf/alYo3QO7EYZ6l6CpJtMpzU5qVzt3FZtTQ?=
 =?us-ascii?Q?FqNJJP9I8CZmH/jYPXc4n+BhQPib7gn0q5CYHmBCJhn2kqLOZ/HBGuluoro4?=
 =?us-ascii?Q?4bkvdvEi7kWRWSaTcM3oS3ydYTbPbvjWZ6XwJpFZvk5PokeVDX60ybmDgHQK?=
 =?us-ascii?Q?1OY3ppSVL+MEUK75tWTV8JbYuWQPMC6k8UWW8BdtVGEiqpPfGoAfcZofarqU?=
 =?us-ascii?Q?thaQSnRtd6XhpJDCkGewPvUhLVex9SMiIUOv9CasXj5vGWdL9woAZwrfpSvZ?=
 =?us-ascii?Q?MIWduS1dMRDhYOVSDdJc6v5PHSD8exo8KlXYkETpOK6azKZPx0e33zhZv6zR?=
 =?us-ascii?Q?wTXgh1awA6KUzzX4XDx+6SCDW2Gzqvycq9C9KvHbccdZcPyo2NeFSB7yBKAC?=
 =?us-ascii?Q?UpwZEnwDS3GQ3xXfli6sj43b0CKwPxPAtjIYIWTpueAJCie71QAwDeaX8DIO?=
 =?us-ascii?Q?Hc+bVxssksLSnNcaQdlxQRmjPqV1HeQascHx//ZpshHyPTCDBp0HxnlSBCRU?=
 =?us-ascii?Q?9W3iU8h1jfPlZyj2uEnsRxpy4JiEW1rSYtqiExIWMgc3WkUJcszTHb44lKa0?=
 =?us-ascii?Q?fWrS1WlPuWRqQo/8Nbv2Cz1tiG8dWyl2J6JmNkPEE1Fdj12PmYMaXWa+74+k?=
 =?us-ascii?Q?Kzdn0iFaZ5h+gsR9aGgj34MCStPCeYBtcIJFV+O3Gg72zB4Wcu46iuJ/3omo?=
 =?us-ascii?Q?cLLo636X39QkXjSLGZ94944NhYB3fArPyfo7FwCFQxm4Fy734njt6W+ivkIk?=
 =?us-ascii?Q?4WQoe9eq3G5+U0KLZHlOXp7LhK0EUAXvL3UF3u0gjBbmHVjCNIohD8i29vx8?=
 =?us-ascii?Q?n9Ku9HlFMGAa77mB60ms4dXayqWtD/KQqSb0ZDpTiez+mfqrpx5Tk8QznE/d?=
 =?us-ascii?Q?sbAfxAdnzAZboJxoFCSnzOD5Q/2SXqv+hijZSAtz3+RpQMHQ8pHysGiXAtQ9?=
 =?us-ascii?Q?5+OfC4i1mKBQFOc7hMsACuKIMjrlpznzMNzUP0RcxpBMEE5tDfsxk2VPFEB0?=
 =?us-ascii?Q?o5goLbdAlHavUu/SL3BbnqItL1BR92SwjhknMDhp+JJBZBBY/5WY7Ep/DB5I?=
 =?us-ascii?Q?w5HZ9iw7l96C/Xz5kh0M6rIA7KLdXmQPaPJiy3uRNKfUt1DuTqadVLNWb+tZ?=
 =?us-ascii?Q?qU6+plv1m0cl27/aTvOSg49bJMuRoP+eJnbQQv45LnPDYX6kESUVnHMZCvj+?=
 =?us-ascii?Q?l8EpMPZttKsLZ6bomnsAt0nk6w3tEiTOm9s/mawg6d7IX8zuJeFKVUjETObB?=
 =?us-ascii?Q?QQjRtiMRSOIl4VyoonZ6jRC+4aL3pfwepJLMXFZJHyV3jdkeq/NTBcRWzgeE?=
 =?us-ascii?Q?4uIN1AgOVyaf/6voWzj31icY+Eu0ukoNK3zv5f9j8qlh7khzsyT7OpMgGZMS?=
 =?us-ascii?Q?kxrFg/rjzEoDvO8divsje81by597aSTjV73KcS9sxNrVj74TjXpkZpFk51xJ?=
 =?us-ascii?Q?xrnkOu1ftv/Yvpab1LmgsAH0kc5UVTjyP+ZaVI/GBqFCEB0y9Z741DZe3MJp?=
 =?us-ascii?Q?xUDuIjSR3swHno8fUfgBITl5WWdOT9SEykNqIjOY4FTzVeQ92cpepV36wKEd?=
 =?us-ascii?Q?DfS+Wj1TP4/Jvhw+4RGMxpk0N8r6K4hx8yzEnCDSqho2j3OazYASkFcw1KFS?=
 =?us-ascii?Q?N4348Y9ToxqRYdY2htGUly6+kABj7IQYUo13kLkCP6ktRWS/jfSZ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5954c1be-05b7-4e0d-0930-08dee405420c
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:57.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BktioeSdNO+fQYtLLV1Y5UgbboqX2Aut6K6F8a6H0hmLJyH0d0aGSyFF1jKGjgoRGI/og+vAD1KpAAPNcFD7gIytGRzBx0ytmHrLOw4zzLbp6SnK41Or48iQwd8cgLhV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23642

From: Abdel Alkuor <alkuor@gmail.com>

commit 8249a0e25dd2972e919a2552425bf4faa2581d24 upstream.

Set tmp112 conversion rate to 8 HZ and 12-bit mode.

Fixes: 35cd18048542 ("hwmon: (lm75) Aproximate sample times to data-sheet v=
alues")
Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
Link: https://lore.kernel.org/r/20240106030254.384963-1-alkuor@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index f6e16dfa11c5..5eba180b66a0 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -270,8 +270,9 @@ static const struct lm75_params device_params[] =3D {
 		.resolutions =3D (u8 []) {9, 10, 11, 12 },
 	},
 	[tmp112] =3D {
-		.set_mask =3D 3 << 5,	/* 8 samples / second */
-		.clr_mask =3D 1 << 7,	/* no one-shot mode*/
+		.config_reg_16bits =3D true,
+		.set_mask =3D 0x60C0,	/* 12-bit mode, 8 samples / second */
+		.clr_mask =3D 1 << 15,	/* no one-shot mode*/
 		.default_resolution =3D 12,
 		.default_sample_time =3D 125,
 		.num_sample_times =3D 4,
--=20
2.54.0


