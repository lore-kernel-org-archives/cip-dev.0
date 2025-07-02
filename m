Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F29C7EE30
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.47])
 by mx.groups.io with SMTP id smtpd.web11.20592.1751452667715754448
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Gux+sKVe;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwh/epcgpomMTSKT0TurNvdisZQRRN20fEHWDWzpa+9ONjnT2IJ+ufqLh4I1APTDUhdupZOp+VvgWE6m1u/lo7ZyEVlMBjjokivetZsmGHYEuogccsDNnBX1eCt4yd35i0T8N/A6GEu7TBkcvvws26eIXA0koKgj77UhWvJ75dXCqBwXlaDxubd+KpD2LnhSBy/skurz8HsxO9gxTidEhetLKYbx8A8i/1RR3hanjrH4faijJZZ55GIbiqpgz6Y0SCrHcgykm28LvFPr+7+mdOXU8j3wBTrxCQOpqoOnSTAnyJpiE22OHDjrikwyOigeVsyEsbFzDu7xqE5I8/GD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeI2r7NUwOBY6JK9nMXbBsEICklSb8q/I1bKv2FUo3Q=;
 b=yJPa770XVCN4onOeFScFdhpSgcrjRkiNdlYZIjZ0czyK7ro5WyX6lqdPBq4K1KuYpX9D1uz4A8F2CqbMUb5zAYY35+kTGMp7OfGTZ4mrQ9YHqvca0NP865yNdBRCE40Kc6e8N/rpxsZ/N9NJp/BecYs/kUoHYFkrwox2e4Ed8KCcUaHhj8T7Rhth1uQu1MsFL6QZbyrR6e3YUlbn2a4cSdcmdPxfi531OjzdE0WisTV8gX2oBUJ0sYh6IhUmbk0xI9DDFVAodkJ2J1B+xJEwUa4Tjl4l9Q4QACJvoXKGrFCHa2kNIekiQ/l2Epmq/l3oSQqkCsSA4LNvUzvCXUL2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeI2r7NUwOBY6JK9nMXbBsEICklSb8q/I1bKv2FUo3Q=;
 b=Gux+sKVe2Qabm9ZGBMW3wv0IvCp7PtmJWoBMDNO+E9DZg1lO4I2qAM/fF/iJryAbdHYLvD+xpm0+YRGQNSosk1JkTgpr79nNt73bm1Uas5A6oDAYvaG2V3u6q+sNqDvXVxrERYQkeZ6kUYVE6iAoHxn4lR9oFLbbKDCq4Unm1zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/12] clk: renesas: rzv2h: Refactor PLL configuration handling
Date: Wed,  2 Jul 2025 12:37:03 +0200
Message-ID: <20250702103710.117760-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e24a136-c66a-4200-318a-08ddb9547a39
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hJhpn1Zr1XzwHbuBaL3ruIj8iL55U+e0TOZk/MBbRQBXAwdVN4MPZriqtZAg?=
 =?us-ascii?Q?b+rfYpGYqWE9Veja4GbGrvnUGCB3SJmXUfAFVLESlKROItZMn3fLJkB00NsQ?=
 =?us-ascii?Q?kF6DVv1/lAHS+SzPgUoTB+RXCWoxJ7pqo0KX/g+MwQXC5cZ3Xf3W7Wwc0oTC?=
 =?us-ascii?Q?l0141Mg3ZRiLdfH0UkU1jRpsxogS09bStbEZBBwKThcV6ew4yJhVxh4jfiIZ?=
 =?us-ascii?Q?PMAq2msd1Veh2sCvwIp9GHr0Adoxqtk6kblkF+BPHYJTk5rvdFbnf6z1ZiH1?=
 =?us-ascii?Q?ulkd9nv9Fyq1ToBQZDLHPT6bOHDEJNVoLhrbBN8R5jMceDmV0Cc5X5GEYII2?=
 =?us-ascii?Q?NRkh4K6rdzGNGAu6YncWYyX9qdoHHY2t9565VrFTm2HnHk4aeZKwS2BioZBM?=
 =?us-ascii?Q?lzUXbk/VSudWhOC26QsIGuVJeA53HTrV7wLtUpUWD4bSk1IcETk4qVuVg133?=
 =?us-ascii?Q?eM1Sgc/TevS0yehHF5RM/M99Z+cii43r1vkvMuPpSdkbrHh+xpu8LuL+fwdw?=
 =?us-ascii?Q?gX8nQUg0/23c1PN+UcsbBVq6yOENXU3Oxps5W4itGzwdhCFLep2STRh7s3S/?=
 =?us-ascii?Q?BBXXdCp6MESm6rjIIc9KvYTMX2a+Oo/hNWJhMddGQF0wdV3VeEvHRiD1MWA/?=
 =?us-ascii?Q?MwqzbaFT58js/y5pyxW4GIz4rQikz37pIsF1IzIa1GG9cL7SzkBhIB7vkOBB?=
 =?us-ascii?Q?R1ilDQy5IAgf0uG3We3z/1jvL0oj8IWZYp3oO7u3X8LcvwVvJ9Dc7aW5TZ8r?=
 =?us-ascii?Q?d5dq0X8f/6RQ56NBBTtduQPKKPWbbASVaDO7PkcHIE3y9FRXBVvMbYDkK4XO?=
 =?us-ascii?Q?1PmvxD+zDWyoxgfMIPv4jXN136M/A+eVG34ed06p1q0G2TNPL3h0YEfSN384?=
 =?us-ascii?Q?e2l/tnmXAZYgtWgNKtBzReWOj1lNDyU/ZFQBM4GlIEfsNH70cBymjU14QAqf?=
 =?us-ascii?Q?C1RbhPsnDSB8XkVJN39iY8VW/IKWda2eSBmGjXFecMc6yZNGh74TrY/mJHsd?=
 =?us-ascii?Q?RtqaFXw86qfvLsFCZ6O9940lCusULBmJssNjF0YnLz3piDM8trS/O/LVAJm3?=
 =?us-ascii?Q?p19ebt8Zf4iIltoTQ7FuVSdVi66z5LH3sM4AUErmuFMiPe2dsDlNNUgOQH0A?=
 =?us-ascii?Q?1a9f9dgAq/f7zmz+Iez8i0RMyWf2pAOqRBaKr2HYhTMhjMX6G19/gzjGdbiC?=
 =?us-ascii?Q?K7IhsDkGFKH8uRNVTHI56abeQtEvJLc26VSlDj+HsN+GvgWT0Q6ZTL31t8Qu?=
 =?us-ascii?Q?be94hW0VvYt9hBTHuvmcSzaHW91v/gl7mLhct/Z7TDHgPSPtyQlRo1XKKcLV?=
 =?us-ascii?Q?xM8O7bEr8dUsslO8v7LH45PUlNqFDaoNis0GICNKPGyDJl9jUSp2RWkeagxJ?=
 =?us-ascii?Q?j8AvzR21e9sfq0GIeGJ1ak6XEDSijgid82kpncjnK46ksWT8OYlCjHJhYays?=
 =?us-ascii?Q?uO3RZwTsIxg9kNMVes5WPBcHRnONCx3WnkEH6wx8lBsBvibw+asgDVuyKOUf?=
 =?us-ascii?Q?2YQx8xkOZb+HlAg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?q6xnghQAQOp82sQCSNZPHhUnhAsAiFaIdhy0qxxsz/o8SbmRRJ6RDyhK6dTn?=
 =?us-ascii?Q?Lb6oadzqfdJPvTt7wHglTjQp1ET0JOWw7PjXKv83fq5xlDK33Dv/REOS294f?=
 =?us-ascii?Q?iMEVvYe9gHxeqv0VkBcYga+Pw2adPIlXejZh3agTZFKh69BcBtSYZ1CbFbUw?=
 =?us-ascii?Q?+A0SC6vcjlJlCaurZdg7Oiw043bKpZHS6lnggsoDX9iQDMTuNwLjg1oSZg4+?=
 =?us-ascii?Q?u0HVBhPkUQxj+Yrpc5Nzh5GsOtIzsW7jFcXa7YiLISanEnKWuWkWsY9QxNcu?=
 =?us-ascii?Q?AEWvE/uOleMXukAEMmhycbQ9tBd79JDmxL0XChhS57nGY7hwJZ28TaTypuZH?=
 =?us-ascii?Q?RTZne+dHQv/aG84BsQZP1ZZYKeTCk/LVbOt3zTKKMEcOrOC6xxiBTYrVIwIl?=
 =?us-ascii?Q?OQwpG0okOvSnT8xjwM083AUCbmYLoxwpw8sxeYoRVQjDaG2rXnv9rgiymu2F?=
 =?us-ascii?Q?ylTPp9vlemT3yP2Er7Gai3EUlugMY+4EpNWZMYrLN2OAheHffcxYRYXBIWue?=
 =?us-ascii?Q?w76jlx3Yy1ZwZVsOIThRkVDuZ+PPneom3xWRF8XV3xCh4Sm8iSUB5s9Y7/0l?=
 =?us-ascii?Q?z706nkegEM9cLTkyejZL62q1h2PyVmWFaPkQEat2hFB/8odSQN8Bq6pkpvJY?=
 =?us-ascii?Q?XJCkTRAD7Un+BE2zNgFIdaLmGMsuUCIE1cfPByehoiKjeoKvzxODtGaR4iL9?=
 =?us-ascii?Q?85kTEpEMb0FjM3bngwU+qgNnb1gn5DpTsDMqrzGPFIlzeRE7dUftn80BcniH?=
 =?us-ascii?Q?iIBzIgYBSB8HGyyLMJectgBJgiJvqBS7tHa2y9wmvaHwkDbkjiDRvdgmin72?=
 =?us-ascii?Q?1qLTcYTYdrlXvBnveh9EGReRObc66NBegmPalICTZU2bakADfuNSBZqdxilM?=
 =?us-ascii?Q?A2vq6QMXBqAZ+sRRzcACpUPQ/UWruGYQzSDxnVulG6bskP+SRZtmuRc/jAnY?=
 =?us-ascii?Q?W52LzV3r3j+0u/IKzpcSyRSc/+fO3cNrI16KBa9KSaWT2mxpMhAYV5nTMKjl?=
 =?us-ascii?Q?BkVt+f/vDP441yt41ebBCtM26vNB97VNJ4xhtJSSQ9uD4kSlGzC5tCdkm0lC?=
 =?us-ascii?Q?r7kTWhgc8Guc40pKAhlt12d17thhCnvcUWIITtSTRcZA9dNjoxYpMezjmiFd?=
 =?us-ascii?Q?0Pkhy0HR+GoXTSporHrleru+j+LKECoRQTjHsxxHHCwSyRLdsWQq7VC8EazT?=
 =?us-ascii?Q?MaswtsO6EyjKhFGMku62bT3vojscbLENAsK5QR/G8FX763ivJ61lRNiUTfiy?=
 =?us-ascii?Q?u6L+TUtSUHiMFcMKtHrpCxzdtxIHGhPibqwpJmF31bz7TiKFlzmnBF3OunBb?=
 =?us-ascii?Q?26EvVDuKysrIv8PnKiYvczlaLi6duVceGDVekRtrm9G7UgzlUjaPcEmh5tRN?=
 =?us-ascii?Q?jnc+31/0X89bnLpnI7hHheCsU8g08HAtJRPWnLg7Vy7aVKeDBoBVy/xp0e5W?=
 =?us-ascii?Q?dMvKC9M8gjmZVqlfOzmX7Y6nEh9reOYShxaecYvLaTRAkVPp/yJBEyMrPlgA?=
 =?us-ascii?Q?s2GJh6pl1Th36NKQMf8XddA3iMMJEGkghdAnW9gpbrEk90gGjQlPJ7DD77m7?=
 =?us-ascii?Q?QKXG/vv7zFcBiHmGd8wMOLbwOVDcJ9/UP4a9hRwLN+aRkz7awvW+aZGsgmfL?=
 =?us-ascii?Q?wlVrdlguvlledcnk/gykm0I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e24a136-c66a-4200-318a-08ddb9547a39
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:43.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6phOMAS6F5K4LXrIpNFpHe+ffFQVGB0TLYN8irgJyNRRtoQw4WoUwU6RdukyCa7cJULRz9DVXZT4mrxKVNwFo0/lUXCI1YV+vV16araPqJmO7ftqmKne3vRAtjOQkYx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19303

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 20fc4ea6d7e379cd492a6fd5c060013a9ebdf3db upstream.

Refactor PLL handling by introducing a `struct pll` to encapsulate PLL
configuration parameters, ensuring consistency with the existing dynamic
divider structure.

Introduce the `PLL_PACK()` macro to simplify PLL structure initialization
and update the `DEF_PLL()` macro to use the new `pll` structure. Modify
relevant clock register functions to utilize the structured PLL data
instead of raw configuration values.

This refactoring improves code readability, maintainability, and
alignment with the existing clock configuration approach.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c |  2 +-
 drivers/clk/renesas/r9a09g057-cpg.c |  2 +-
 drivers/clk/renesas/rzv2h-cpg.c     | 13 ++++++++-----
 drivers/clk/renesas/rzv2h-cpg.h     | 30 +++++++++++++++++++++--------
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index e9cf4342d0cf..7b9311af603e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -79,7 +79,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
-	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLLCA55),
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 3705e18f66ad..cd0f3d4d737a 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -81,7 +81,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
-	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLLCA55),
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index a4c1e92e1fd7..54ed7a75be6e 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -44,9 +44,11 @@
 #define CPG_BUS_1_MSTOP		(0xd00)
 #define CPG_BUS_MSTOP(m)	(CPG_BUS_1_MSTOP + ((m) - 1) * 4)
=20
+#define CPG_PLL_CLK1(x)		((x) + 0x004)
 #define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
+#define CPG_PLL_CLK2(x)		((x) + 0x008)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
=20
 #define DDIV_DIVCTL_WEN(shift)		BIT((shift) + 16)
@@ -94,7 +96,7 @@ struct pll_clk {
 	struct rzv2h_cpg_priv *priv;
 	void __iomem *base;
 	struct clk_hw hw;
-	unsigned int conf;
+	struct pll pll;
 	unsigned int type;
 };
=20
@@ -145,14 +147,15 @@ static unsigned long rzv2h_cpg_pll_clk_recalc_rate(st=
ruct clk_hw *hw,
 {
 	struct pll_clk *pll_clk =3D to_pll(hw);
 	struct rzv2h_cpg_priv *priv =3D pll_clk->priv;
+	struct pll pll =3D pll_clk->pll;
 	unsigned int clk1, clk2;
 	u64 rate;
=20
-	if (!PLL_CLK_ACCESS(pll_clk->conf))
+	if (!pll.has_clkn)
 		return 0;
=20
-	clk1 =3D readl(priv->base + PLL_CLK1_OFFSET(pll_clk->conf));
-	clk2 =3D readl(priv->base + PLL_CLK2_OFFSET(pll_clk->conf));
+	clk1 =3D readl(priv->base + CPG_PLL_CLK1(pll.offset));
+	clk2 =3D readl(priv->base + CPG_PLL_CLK2(pll.offset));
=20
 	rate =3D mul_u64_u32_shr(parent_rate, (MDIV(clk1) << 16) + KDIV(clk1),
 			       16 + SDIV(clk2));
@@ -193,7 +196,7 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *c=
ore,
 	init.num_parents =3D 1;
=20
 	pll_clk->hw.init =3D &init;
-	pll_clk->conf =3D core->cfg.conf;
+	pll_clk->pll =3D core->cfg.pll;
 	pll_clk->base =3D base;
 	pll_clk->priv =3D priv;
 	pll_clk->type =3D core->type;
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index fd8eb985c75b..6811c0332812 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -10,6 +10,25 @@
=20
 #include <linux/bitfield.h>
=20
+/**
+ * struct pll - Structure for PLL configuration
+ *
+ * @offset: STBY register offset
+ * @has_clkn: Flag to indicate if CLK1/2 are accessible or not
+ */
+struct pll {
+	unsigned int offset:9;
+	unsigned int has_clkn:1;
+};
+
+#define PLL_PACK(_offset, _has_clkn) \
+	((struct pll){ \
+		.offset =3D _offset, \
+		.has_clkn =3D _has_clkn \
+	})
+
+#define PLLCA55		PLL_PACK(0x60, 1)
+
 /**
  * struct ddiv - Structure for dynamic switching divider
  *
@@ -72,6 +91,7 @@ struct cpg_core_clk {
 	union {
 		unsigned int conf;
 		struct ddiv ddiv;
+		struct pll pll;
 	} cfg;
 	const struct clk_div_table *dtable;
 	u32 flag;
@@ -85,18 +105,12 @@ enum clk_types {
 	CLK_TYPE_DDIV,		/* Dynamic Switching Divider */
 };
=20
-/* BIT(31) indicates if CLK1/2 are accessible or not */
-#define PLL_CONF(n)		(BIT(31) | ((n) & ~GENMASK(31, 16)))
-#define PLL_CLK_ACCESS(n)	((n) & BIT(31) ? 1 : 0)
-#define PLL_CLK1_OFFSET(n)	((n) & ~GENMASK(31, 16))
-#define PLL_CLK2_OFFSET(n)	(((n) & ~GENMASK(31, 16)) + (0x4))
-
 #define DEF_TYPE(_name, _id, _type...) \
 	{ .name =3D _name, .id =3D _id, .type =3D _type }
 #define DEF_BASE(_name, _id, _type, _parent...) \
 	DEF_TYPE(_name, _id, _type, .parent =3D _parent)
-#define DEF_PLL(_name, _id, _parent, _conf) \
-	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .cfg.conf =3D _co=
nf)
+#define DEF_PLL(_name, _id, _parent, _pll_packed) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .cfg.pll =3D _pll=
_packed)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
--=20
2.43.0


