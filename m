Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08D7C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:08 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.43])
 by mx.groups.io with SMTP id smtpd.web11.16548.1750674488358875398
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YCTgCw5l;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP4i35nGFh4L/iA8OQ7WciCaNBax/lXTcfzA92cuKytrPKa7g1WH20T+38IbrVhYSw/yGl3V9iIa5j8/0tlcUMPpUpTz3Bmyv6LQEvrtL2tCWwLytGKHonRUwG/MuXsiInauuodKwVlZJz1ugSD9/YnuAAujHxbWBwsRjgon4jFGtL8QVZ8EH8wvXxvg7ddQDljcp9JfKO+JKQBz3lMzES9GvibclUT5WV5Xemba5P97dB/f5ZFLbVeIpuy2jUKW+93Aql72vHTkZG819957xFLx1y0U6MXDPDworMZuorfk5nh1Qg4JuRG1W0U/cNf7NXupPLy0ilpFd/LTIkwBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIwROW0fn8+lg9c3SRMnXk1dmxEiC0OaMDCPqLNICwc=;
 b=dX0/MwQtUXvNIdcdRLBb/XEVVNNWH08AdGsfs4U8OEm+hiarHTg1dgnp71DNxekiZKX4vhG+8d7y1BUOuJgt3LTpxEQ1FCxN7pcScGwh04lXuWkVNfjy7yNG1ap6J7+J8/wSS1PYu6dDOzqyOTsVSRYxvWlzRqvJvEO8PpnhezQpYa+p6WnFennmx0wIq+N1fGtHmdnDila1cvENQw78qyKEwYbPgs6LOmtgHUu9wimJmb4A3+0gOCrx6b9Jsmq3xQ21wou1nBqz8uEIZnthO6DS4Sh3fShonb6oYTgG9FCLWSBzQucvmu2AfxmebtgrQlwzXbrS41Y4tQ0WYKQmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIwROW0fn8+lg9c3SRMnXk1dmxEiC0OaMDCPqLNICwc=;
 b=YCTgCw5lHyCWtrBG9g6ysiEfZUOFMC+Bt04kJ4LywBpXRQlXwlMZRa1/WjzyaNntKXK75gksnfBoCc3iY+zIUXqkjuSGdl0+rdTnmkgnCqqsuoLItMJa/tloo0qaxEsC9A5BpoL8fV8YpW1SELLzWbEqdOfxONKfEabHsTRbJ9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:28:06 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:28:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 5/8] watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
Date: Mon, 23 Jun 2025 12:27:27 +0200
Message-ID: <20250623102730.1493286-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6ab94a-e1e0-411f-85cc-08ddb240a494
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QlwWRn9KWclJ7Us9rRKYajQ7CSjMuo6QAe0BiOknUiz3MvQw7KyCIc0XPV2t?=
 =?us-ascii?Q?pRFnJnEycX1w9aC2TMA50ZwoXYyYnq5CdFM5qmevK8HwjhOQoyk72uaf/LJF?=
 =?us-ascii?Q?oQjtjkX/Y/JAv48/xM0OjsbkpHyPZrHZ7YtgGdV24fJoBP8vvzuspUUFDrZz?=
 =?us-ascii?Q?+i8bdYx3qE+Ftw6KDEwVqp7LW1mFdgle2fWF/7CziRV5TNxDOvG5fRXpjb/4?=
 =?us-ascii?Q?0gwesDi8Dutcq5lXL3WtWIrec4xY4RBE8cOqR3/mPSvLwMuTknIb4O9zBqJw?=
 =?us-ascii?Q?PxMjJfK8THjFYaBcElA63m6iK0LGK1oqfUEaByLxo4dZZ8LKvQCscVMEVhUz?=
 =?us-ascii?Q?VYsuR8eXlZkHkrfV8ibtcJ8Ym6VFjCr9F+5nTwPk4DJ51J/EGvuqX6XaS2uA?=
 =?us-ascii?Q?U0CgFewM0u5NZ7MluBK1+qaOJPzx6teWN3mB2JQwbLwc9QQeCPST7UirvY8o?=
 =?us-ascii?Q?331qw4bEHHrWz3G/iu7pdMOG0YVZKjLsEgbgbJoebWlKtjZk9llcWXMC8eAq?=
 =?us-ascii?Q?VQcCqzNDbMXYycw32sUjBWDnAgMheFKiYmrx2hPqOcEEZW09v29E2Q9z39To?=
 =?us-ascii?Q?zKO9EsHvmNM+KQv72xXqwaP+yg1TJHlqAPMTo2d5QCYOrXfk36FYw4updUR3?=
 =?us-ascii?Q?+wi24qsUKHA5X6gr2qoBnSGRqDjeF1QN8cpq3oxT3aE7/ZrDz/rj3qCy20a3?=
 =?us-ascii?Q?uGNNaSmE3mOEGniNqFnQfU/MJaDNEUCyi+jpXqR2ejPK2fyMB5iUTC7C80/X?=
 =?us-ascii?Q?V7o+l7dLWQ6W7S3MOL0FqGIYF04xnzVnrbCKp+19p4VBxtky1CSLHwjMrb6q?=
 =?us-ascii?Q?0LTFGqMIfO788DrYGY19TB/VZAKi6mcjCkYJicIFqXxdBUKHGus8TqyxwvkD?=
 =?us-ascii?Q?McbN9sEwYwaAvKAhDmCnU9bJQ08N56p+b6q8xAyGXJJdB4qput7pogVdjMb4?=
 =?us-ascii?Q?MrnRLWeR+wkCptg6PK1m1ZjcR5oRq1TUn/9vfk0F5GzK6p1q3Rq7TiX8+nyo?=
 =?us-ascii?Q?ii5RqDDQYoburLwQdIvbfaJb8RpQCoOA35lRCeliqeVIFOfVtKCLJzWHp8fk?=
 =?us-ascii?Q?/nFClmK9OGInBcB/YIxIzqT9A/l60TajJ0286wGWMUU+mj5yx73j6fGIUvlR?=
 =?us-ascii?Q?qRFuwEz2xXzBI6+15flQwfH//vtkxikxDJN45FXRbAETAJ89EHfX1XKcjc3O?=
 =?us-ascii?Q?HumPu+9lmB+5ZvenlbjDm8SeUN2BZQBwelShN1P7l10cuT7+6guneTVoA3Xp?=
 =?us-ascii?Q?M5ik39gJ2nFNp+2y1epr3AbBzCtpKFhaQRxA1qP9Z90QJ6EZpyDipWED5JHC?=
 =?us-ascii?Q?0JqNz+KJS+oBrug/uxLOVBe+274gQ++Sf1yaMQuwhAKgNuyD3QUDIdUU001t?=
 =?us-ascii?Q?KEShZa9HAVAJ8JfRsAFhZSpzLe3vFny3SW7ZUQOw9NnNjBA6oR4+dQL3GyGc?=
 =?us-ascii?Q?ai2pq5xO2/I0FcSV/qF494cDn1o57I25fo4R2B6jdBdCK5hXeQ+vKkeu6Ql2?=
 =?us-ascii?Q?CVDii6FtX2PDDLY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vPAvWo8FBRyl7eCgFmVefT5xyHbtyqkENglH4law0IO3Gv+KmtstAbC+cOqk?=
 =?us-ascii?Q?y/HsNPlq3SspG2FwiX83Q9zcR/t62snX3WP8N41iBD4iK5cQRfskBMB/RK3f?=
 =?us-ascii?Q?tWFlaoLhWTg1tBcKi1wLXc3dtopPd2wD6tjeLi0Pt29C2CpTkkn5R7BKifgY?=
 =?us-ascii?Q?7RVkpbM1fDT9nP2l9fLTbbEDU1Mxj+8S+3do1rdOfGdx3a2qBgLxKiSBNXMS?=
 =?us-ascii?Q?kuO1ZWnVcRpLn+B25Y27JxnVowszQeAGFABBABXhnoyCUgOZuhPJEpDd4OVR?=
 =?us-ascii?Q?c++Td6Ehdh88ZrP44EEOk/Sqct/jYF+vSdSUwM/OlX7tfx5fM1Di+g2iq6YG?=
 =?us-ascii?Q?JisOOz37k/nNdYgkQaPMS1cfhLuaOG61vySsEgbuVuD3aQfGNeA7vj3Dpm3m?=
 =?us-ascii?Q?YJexYK5k8Ex4WJss+2P1wnXKwOj7/A/KnYznJMdbl/D/9FghaTQpNgQZgqHP?=
 =?us-ascii?Q?0fWIv80Y+B4VQH7RFTj5fvMLmx9AwJNRsGgRc6pPvk6Kxm9IASxWbCxToGZ4?=
 =?us-ascii?Q?MI43xAku8GxZzHKGY/PwVZKM0/eWwunHwuMhdhxtT4Y29n+3XcTPe5r4kxN/?=
 =?us-ascii?Q?yFYnAFoVwV+wDAfrKK9qvOmHnzkxOHQ1S06+gON2y1ecOhvLnYx9FlA4r6aq?=
 =?us-ascii?Q?+mnPQZ03xDx2HKGlZEEwcYp4O7e9BWNlcQCqR/3tzbzXEhFh4RALR/7DHsLR?=
 =?us-ascii?Q?MC93nZfxSXKfT5jbqJpTyRsV/ReZrFyRvA9FuxN6yfOvuMqpBWIcQxnOwu+J?=
 =?us-ascii?Q?VYUpnC9WEX83h95j5WF/F5ZmIOWO0ZexZJwAhOt36WuMx4UDPstn+RueW3TS?=
 =?us-ascii?Q?h/mUlEO+cJ5hM+f8c1WGRClXFpEk76Z+oL9/aR15CNYnQ0gLqxBFnVc6iD/G?=
 =?us-ascii?Q?+i/DRO9MJhRjdarJhWC5TsqVvbX9s7+vPqlGf3y02NaOYqV0JHwDlY/blETc?=
 =?us-ascii?Q?z+PHCN2FeGCfldjXl95bF3v2YZPZKqAr8oGNzjxbrwZz0maMYk3gq4dDzRFV?=
 =?us-ascii?Q?JrXezUqBRB1+PtTttOhWwpJ2JF+DKaL8I/2hDMbsSDdio8mbo8Sf8GzKAEeB?=
 =?us-ascii?Q?D61NTDcs/o9CbZxR68c4Yrdo7UPIMZs+4bIIA9FzQkmEH2NgCAiez7zBx0FQ?=
 =?us-ascii?Q?vBB24DVvQUtOBD2i8/V5OmLPNY3TBts2/gKfd3d6Jy98ODRtI6jHZZSOOf7X?=
 =?us-ascii?Q?Wkl+GQN0kxmx3RlZOn8+HwWiziG+SKkKURehG9SrBvbb+1teNCGGaqSnQFbN?=
 =?us-ascii?Q?r+vZHs3cALs3JmSX5iCwPs1aDpuQnXRfO9n0KEDiOObLuofoEH3MyCXLcG2V?=
 =?us-ascii?Q?l8uK7mkTnjlR747MEKNifsd4mion0DQVKE4lBBqjvBdCFySohD39S4Ys/t70?=
 =?us-ascii?Q?oAvyaw8KEljPANVYrrOJNaiEiGphFe4imjmeJmxWqGvv49bMQJCEpOzRh1QK?=
 =?us-ascii?Q?Ct5wFoAC0cweTNepe58Jcgz+nDqGUy0Fov/ceLtGarQTxDj0V9jAcBIavVb0?=
 =?us-ascii?Q?FvzzrOYMhkNM8BdCBmjlZsEfB2UrLnpZZMFFXu+ALzFOMa70BBnxZGltDeB8?=
 =?us-ascii?Q?xLW50DJFJYyh+l0Xb2bdXh2NONznZ4rMiKUu1eHuFnOYm1o4/Kjzk5Q2Ug8h?=
 =?us-ascii?Q?F4OzLR+oz4BrVqLtQnD9Ytk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6ab94a-e1e0-411f-85cc-08ddb240a494
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:28:06.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23/bMFqmG2+5fVftT87hiqqgK0yudxxLzVvpFQJnOorJea3+XpF3xJWJmJYJKVhgKqkds08n5KhGFelxS23bzcNxYrNTTGP39tLwv1Q84F8dk7n9HjesIuiXa9Jsun3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19170

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 331c8349605c8fa2f9040c39fe8c40afe3fdc3c3 upstream.

RZ/G3E watchdog timer IP is similar to the one found on RZ/V2H. Both these
SoCs belong to the ARCH_RENESAS family. So, it makes sense to use
ARCH_RENESAS rather than ARCH_R9A09G057 to enable the RZV2HWDT driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20250126132633.31956-3-biju.das.jz@bp.renes=
as.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/watchdog/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a98a4078e51a..f839132e8130 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -900,13 +900,14 @@ config RENESAS_RZG2LWDT
 	  Renesas RZ/G2L SoCs. These watchdogs can be used to reset a system.
=20
 config RENESAS_RZV2HWDT
-	tristate "Renesas RZ/V2H(P) WDT Watchdog"
-	depends on ARCH_R9A09G057 || COMPILE_TEST
+	tristate "Renesas RZ/{G3E,V2H(P)} WDT Watchdog"
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PM || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-	  Renesas RZ/V2H(P) SoCs. These watchdogs can be used to reset a system.
+	  Renesas RZ/{G3E,V2H(P)} SoCs. These watchdogs can be used to reset a
+	  system.
=20
 config ASPEED_WATCHDOG
 	tristate "Aspeed BMC watchdog support"
--=20
2.43.0


