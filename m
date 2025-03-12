Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70631C36000
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.63])
 by mx.groups.io with SMTP id smtpd.web11.34872.1741778828767795445
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FCBLPF60;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvJJFHwAVE5xFOC+jL+Prez9OlxWcN4QobacF8GnzZR0aV2Ma/fWR5vgcp7IsQzJqecfOFSG/7ZNakiPOctDadCIOEhk1zRqZ35h4XX2nHc/BiH+BVSP9nWciNJArmRDC0kmDT7mqFgL0x73Kd9HSAnCNnXpiBffdRdAVPxGwDapLgK2ISf5TTIBQ/MKME9E4XVaP550pN/K4W3VLs9nLrB3rL4MTNUuEwH56qjFNoJ3UhvwcSD8G/Nq1jaVlbyms1KqJW8Zy4Ewhog1neeWsCT/I20KZHO7my54f3MlWV6gRrsrajTLpmomUK7Zk7FastHOSMfJ4kHi6flY6Zwyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26InnTN8EjTovqj7z/2RUG+mC2Xwqz42cMoF2exaqE8=;
 b=fqXF6xqW6+V1m4jdgHWgdWdg4HPZVfApOD4AJUOA00gH4zL+0/3YoIOd/mvzzpAgDIm+rXzHdHq+n4QTHYTjfz70qJ/Lf5abR9PV8VkhdEH8YEIMUCAsNzTXOgNLg3eM/4VzIBRMJad1HYNGX6lLESOFfXt4NILu9lXuiWevGUEoyFtYQOAulsXKgK/5zr1DKsHdMIPF3+03h6Z80ezT/1Qgyd4wxPmjZ5vFyMHQfpt0w/QMNtMbg34zgKMvzR1/8adivEqzIkr1gwc2FDHohaDzp5JrCouoZUjK+QTKcgO9kWO0erOGHFwagCOt/A/IejigO+rbtm7FMnA0/p+ESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26InnTN8EjTovqj7z/2RUG+mC2Xwqz42cMoF2exaqE8=;
 b=FCBLPF608BNtrvhGY8J/9ucw7ak8gTrwn6tT8JSkxK9iboQmP5E2pMMSOxdz02xT0efa92IXEoBm+drm1ANrK3JxvYo78xtVrS8Bl6013kyDnbUjA276v5o55hyZRKMurMr4YQuHbAmt0IciMFFrODZWEgSYlvSAL5kOygp2KaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 72/85] serial: sh-sci: Use plain struct copy in early_console_setup()
Date: Wed, 12 Mar 2025 12:22:49 +0100
Message-ID: <20250312112302.1605750-73-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf440d3-cf25-4012-7c0e-08dd6158d242
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?frtjUHnmcC1TrB3i8ftFezbKxovyAGkbun0VnJs8h48wqyFOPfftrfrXYjs/?=
 =?us-ascii?Q?y42hboI0ZL6ghvzBPvK1LdvOr4YPX9+mZRIWsZVL+Lpezsk486dFKFP2JHOo?=
 =?us-ascii?Q?I/bZAnSykMiDMRWi2FanGQAKUkA1XwwjkAZ1YkKuyTffBMxiN9+cdYICE6a4?=
 =?us-ascii?Q?RpQOkZ7IyRUibau0dKzEuaygNN2czaPmxPV+wDtEdf9YOGzGqNw7eApYlUua?=
 =?us-ascii?Q?9tkla0dD5345xWHYl6tHQe9hJAXzbkfgooLuVXbGgckM3quQTy0VgC3Q990I?=
 =?us-ascii?Q?gswfCjqc5StW+3BLNMOZclQtotTrhk0Jt6WDfIq3+qD1jiKaB2ll/S7y0xL1?=
 =?us-ascii?Q?KOOphMEfotOJTL9WemAD1GujWub5bxAoz9VAdHBFvbIRm1IduBiaR0wamcmH?=
 =?us-ascii?Q?5eHjUZ4hzYCoumkcgO268VOPBEGWCQQrRppD0Fr9YUfkXyUvW/udUNsEGExR?=
 =?us-ascii?Q?sAPMtUJjxQN+YLuugOVcUQ+Gn/gBJ61dN83x0N2Dq3d+kMFyBc0J2RSClE8B?=
 =?us-ascii?Q?b0tU7b/1q+NryLwM1TqZetznm0sn7sB+bH3kZ0CNSWB6Y/5nSu8dzvuikENf?=
 =?us-ascii?Q?eLj968CXpF7Drfgs6bqAVsC6KvnI32dEwgNJQ2YW3Cue24VjEJlN1+m4FuFu?=
 =?us-ascii?Q?Z1XjDPAWWeLNLFCNJCh8er82+13g8uB8rDzW+Yh/5OrMQCirQdwPABkCDHzS?=
 =?us-ascii?Q?ZJPyqGThctHZbPgK5Ox0GftJ3ALaqNw9AgZRqSBELPMa5qI0u1q4548MTcrH?=
 =?us-ascii?Q?IvCzWI2FUtBPQ+yvVhkVxTMLKlcPNV9Dr6G09LWP+J5mwZHFxb59vpggC/EN?=
 =?us-ascii?Q?EPq5OvEHjn66pftvE95kvZiD/Khrmv7KOZut3wHiDWZLXjahW0s1jIy8ar+x?=
 =?us-ascii?Q?ms+OVxgPa0BoWMWbWubIpeXHlq/h75Wf7Y6/xB6v8RF+cBJRryecD784U7Jq?=
 =?us-ascii?Q?7cHevdojQmwQVs+OWzT6WK45D43NW087J21Tzgux2WmOQ0Z5OStZIMBUuZ7h?=
 =?us-ascii?Q?P554ZtuBIKhRs0g5riOsPdwd7IBh/FUtB3KtQJqiBMZXw+3sd5D8pZor1M2w?=
 =?us-ascii?Q?lVLFwcsFRQDqhsOJQD6UTynDiDSFD6hC3eixfhFeamBki8aS1Ijc7J8iNS4e?=
 =?us-ascii?Q?rXlICTPj2lm0zNy4lxDk2/enikKNumFV7U4/qdsS7tD0qrsfIU7UjLOtcYKm?=
 =?us-ascii?Q?qIe/Z68YCN4+a8uZ8ye9GWJDwcCqW9mFW2YpEdiHvZRWSlzAdy3oqhW9X+W3?=
 =?us-ascii?Q?arotqV7tgWdGUEymriULfQBXJ5XGbTWU3X4MNh9//324W0z5OHez/CDECKGT?=
 =?us-ascii?Q?xAZmRCmbfcsKNoseMzcldhF5pgb/QEQ46MI9US/9rK6w7rbj/4QBCvAKHosC?=
 =?us-ascii?Q?CxkrhLn7mul64SrZX5zGqJoS9JESY9T432ByocUuZV8py/RNsN1+Y6B0GxDg?=
 =?us-ascii?Q?hHhKN+MQ4DlKg2iWfp4ccjlgBAzVHtP1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i82R69K3/h1sMkDNyVs9h4pflPAiZEwQPJcPo1vCFyWoCSVL81SgOvVXmjWS?=
 =?us-ascii?Q?ME8lLXXsVmBbCVdlRpkTsM7LCV5qw4JLXaUg3eSNC2fSvdZCvHOpXav2pIdd?=
 =?us-ascii?Q?doVYiGjanQh484Xs9P8KePFoqX/y5az6UY2sub1ZRdHXugzD4/e2mAN6bn6R?=
 =?us-ascii?Q?3xHNzZL6uJ9/dxDFTBDYF0dyVgedwr2kBoVqhlRkZNHmQ9rxAI1vFko8clT+?=
 =?us-ascii?Q?yU46jeNVRy9bAaLUoOMZX1alAAYzZqKqTzKLre80c2ltBzGKbe+pP8p0xmrj?=
 =?us-ascii?Q?k9i/6EQsET9ebvJ4s1T14iKIZJb4icvEFIXoBPzG2KZZxPviLxClm10+W9TP?=
 =?us-ascii?Q?+88yNs5Dk6puXX1bb3ffrJGJ/OTinPVPYdldjVseQmNbemT3wl3+kI7iiIME?=
 =?us-ascii?Q?5y+knrQEfB31cCYPkZvCuJfj27RgXLnNqVG5xMFlP9rFijkhNGmEf6T5lnmd?=
 =?us-ascii?Q?jchk4zBtBXTaocr9fxrqrroXsdsFKIpBWfUGpAAyR92sHTfvsHmN8ioZuqBm?=
 =?us-ascii?Q?NAV8J3mikkNpwRweLBiJ1Q4u7LdfJGQlvSUaqdiSq8npksBIfj2TACWFMPhl?=
 =?us-ascii?Q?9IP2GEeyL9e4oy8q9hAwfkihhaoQkwuASa0nW8lasXzDjlb9OzM56Zv89GF7?=
 =?us-ascii?Q?G6UtWKcwyZ5QKrUiDLKpkj0UlXYXeRd8a/2kfFLj3ZHdPi71FH8J3qwP2B/E?=
 =?us-ascii?Q?XnihNhbTHuue4As7ffBX+Knryy0tXUnb+ZMTG01c8TjtoEr4XhegETt/3iPM?=
 =?us-ascii?Q?wyC0v5b7fhjPIGOI8OQumjqr+khlf49OE6XnByG3BmfxoXeaCuqiTD2ch3Zo?=
 =?us-ascii?Q?4fwyeobR/qlY7QeuLeqrQ2rZIOkja14akwcfg8Imlmj9alZcTDJvK3QBr2SP?=
 =?us-ascii?Q?9danblMXnzmBiGrMX+3ecQ93GCC/HD6mxRqqc52qxleLo73PoEr1Nht5Hfe2?=
 =?us-ascii?Q?hT1Ju9WxN5Y3G5JsQzVaon52+Qxy1iZqO9V4MPkeXukxEriTiJwRh/DjKZqj?=
 =?us-ascii?Q?NwLvqjLJ330hGMKVhYIawXDtA44PmBXXh8lXdI12Cu0YA4XPwGEuWYJ+T8oj?=
 =?us-ascii?Q?Durwh+KOx5SMA5qccX5Jd417sd8edpQ8ANCdCDHEV17ebkRjHMEwGqFk/6ZQ?=
 =?us-ascii?Q?9PNmpTN1vDBQLWKw5bHdLFDzvtJq1zc/XpdHA1B9wslheOiLX9x3vT6PbVIJ?=
 =?us-ascii?Q?o2S3cfYBko4StDWshvrRmcNzD4c/Bwh4AGpSHjUr7MNg7fX0GJwy93NLpk6P?=
 =?us-ascii?Q?3grQrl/HIw/89cDBXHw3RHCllMQEoxI0ChensliArsiKwVB4otgl1mKRz/yD?=
 =?us-ascii?Q?k41++sk/z/rn/43j0kA0m38dwCWdiSWiL+ezqvLAeSA2lh95S2GZqf4a9lhR?=
 =?us-ascii?Q?235ldw2ZPpCqgW2+nxGy8SdZYTPvNWl3sDQl0dHO56iMPNofOmvEEnvA8XW1?=
 =?us-ascii?Q?xJ3BQhaKErUNG/xf4aviQ+bDNI3ABBzw0chtXdqqGufh0zWyi/6gwUIjbcpY?=
 =?us-ascii?Q?IrcVZtOfPJqjL8mAKVeO4q8YHBnKdNtSlDEc1Th36dgsRvwmwK2D1uj8LSEd?=
 =?us-ascii?Q?/fw5Omb2PJMRBoEr0TH632Fs89E/5FGDCE0BZbxAolD/ICdzfG8z3OBSoNon?=
 =?us-ascii?Q?kVScAMtQOltRQe/uFyElLwI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf440d3-cf25-4012-7c0e-08dd6158d242
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:06.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frD99vs+MXBDtO1INQyd+TNCAwL/5WuOh/uVLu2yrgVo8T92Gs9sKM1G7RsDB90qIBa8R1Z4iziclD1Xm0Ml0jLld8OBRiK33rxNDOWO78WtGOo4MKjMsCJYEg3zxiVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18164

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c1117a2fefbcce30cced3a180585e0adebc0fa89 upstream.

Using memcpy() prevents the compiler from doing any checking on the
types of the passed pointer parameters.  Copy the structure using struct
assignment instead, to increase type-safety.

No change in generated code on all relevant architectures
(arm/arm64/riscv/sh).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/e097e5c11afe5bd4c01135779c9a40e707ef6374.17=
33243287.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ff69124e5336..d1140fec861b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3566,7 +3566,7 @@ static int __init early_console_setup(struct earlycon=
_device *device,
 	device->port.serial_in =3D sci_serial_in;
 	device->port.serial_out	=3D sci_serial_out;
 	device->port.type =3D type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].port =3D device->port;
 	port_cfg.type =3D type;
 	sci_ports[0].cfg =3D &port_cfg;
 	sci_ports[0].params =3D sci_probe_regmap(&port_cfg);
--=20
2.43.0


