Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573ECD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:37 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11009.1781685392250476124
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QV/0xyTk;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owXIiwepMQxI6p+SjNcUQ03OfFW9p1pJBD0GOG9XOnKepwfEKYdejmRd04Y/BjA2zgSAlefnqDlusYrvJqbg/kl0nTq+et5ihYzf0QLdljQJsl8dVMALcFx0o5v7miFwYFjutV6dYg6KRW4rMiihgjOYcX5Erk8WV9BPXV6A04asuxV4sprB4h324FLQgqSUr6M3jHL3haD2kslS57nmRwcPP0EBT9fQkfFz8lplzz0Rd+jAY7YRhJalVRsw3wrFEOxBU1WDr9QA508y0bJo3g/7BLqgW6eqgQ0MZvIgnRnjH3F/2M7uJYHN2sbetLX+8dWqQTQzA32LeobN3DVk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jhVqjbndAwe4KL+lR4iGFfFNMR5awIFZQFjGw342cs=;
 b=rlky68Ai/g8lorSj2++FoeJ3G972uQz92Ei8aVVLQbMB1u0LuBhwtYEUEpnEQuL5Ub9HMr+Rc26Fw9M53HNa/mRZCkQ8eyboyNeMiaC9/0LyZ7ru1bgduGkHt/AsdycaipriASGUG+RJcHr3sgTeNISWYJNhI1mAPooVrJ5dhKhh72WuESsXJjfsgGhMYOISmVmPm+ySe7jwaVzFWy+JTu6esCvDRutqS1ErbBvWj6Jp9ZnXksAETw74mMyhlYmcKRkitDcqfFX8vHjqSpFYuH14aJERe+Nh3RpYCRHW5bnBvhyaxlp/vq13TgmNw+d9OSckP2hENRPIGykV22rg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jhVqjbndAwe4KL+lR4iGFfFNMR5awIFZQFjGw342cs=;
 b=QV/0xyTkAMdllPs0WD0wissxjHNloI51O+Gn86sLYOZhQpemVKR9C6W+RGBUnqTRIn7h0vXUKeOm3xvvIMRjIddzQMYJcMceyVmrn5G2ogWYW0glelcHM7fpsIiUrKPxxSDZsg7tV0CoZ8XJAp127rH41GRp9lKAq5mbWUYSiX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:30 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 22/24] spi: rzv2h-rspi: Fix silent failure in clock setup error path
Date: Wed, 17 Jun 2026 10:35:00 +0200
Message-ID: <20260617083502.1074160-23-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: 910f6240-6a03-4843-7feb-08decc4b8761
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|3023799007|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YvoeP41kEdlxpoSHyKdDSBoDQcKYC0M0o8a9EtGw0yY0xhK2KNwe0WD7fJUYDq0aOlH1ACL1wPqnU0cinCroIDHJWY0WKKuu7k+BE12FnLWNLjWEmbXhOr24swJeZTErxdTM5ljgIB7b+Qta/z/rXoy6t0ZIDeDXKpmIReffaM4+MGNOhVbR2XPip6TlmdkyNyfr/aeE9gfC2oGZFqchLa4kz5XD/1NC8ZVKxWEuJawygtryCLcISqvGWPGbm89HUTeAQeYRIHMEEK/qSE6ypG/qtgzUKckX5GSPJbVIowthT6kZF6d+8Dv6t/Z4/iGs+rW3HtHBwW4GT0a8KkGKHk1QpeXYWWtNzar3SIu7sRibB5NCjlOAGfgDt8Ynntd39fd/h5cT+BRimdu4Isis1Sn0REzQIRSvCrHttAAwMRFexdPlWvUzn49l6+O1/px7S2AgTPQw3jvQxbiqXMDjPo7s0SG3d/ea2Q5GlBLc4WrM62WFr/ABwgrvcq+/s04x6K882DdhdJx7bdPqTmKMk/IfjR8ZJ3LmGzyrUl+1yrKUSPt74EQFslW/i4AErXOVrynN0aQHMoJiXLFz3uN+tJZ2+34IcxsWXd0sMrjVKdFFeFgG0buREOkWEVce4GvvY+gncQlFsXPG8p2MRG4Spre2oyNqqfsXPG6SIqNf3SnRYivwFyaXIvYuIKFnoN9OLEoPU/brLQBVpZxy1Lr8Vw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(3023799007)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ba55AoXojvxEvriAJZZZOGsvjZWN5rkqt5s3TL1MsQwqBk1y37uH10hr1RH9?=
 =?us-ascii?Q?6oYtUzcn+X1gpiAYbTT9xwc4fExDA5p6k+gS+ynuE0W3RpfztGyontcxRBMv?=
 =?us-ascii?Q?W3AUju80O7H9EbS8OIoHGTQLwyzlXGDarT+ZbYoAPIIsBiORNKZqGxvbE/7m?=
 =?us-ascii?Q?Avu3nQoWzJM7jb4h00pfxbWb8GVfiurmCWnOlkbxTlGK/u8D/maLMwZKWByU?=
 =?us-ascii?Q?6E8+1gTziqhhFfaVITyow0d4xxTo5AGsf5WbqCQMLz5sGltlk2O1Pac+eIQn?=
 =?us-ascii?Q?pCxTgR11TqEJ59Z9DNMOLduvMIYhoHn7qVJDEoOO14/119HaIvjq7Y5w9m2B?=
 =?us-ascii?Q?atQZPJrti/Xs8/Q7R7flHjMTRTm+Wb/1s13nJ6Ot3cGiTUMlWiKqkaMCZenJ?=
 =?us-ascii?Q?E+pAOjqQrvcZB8ilsNDELVuoTHdAhaHtvivPbRJ4GEuJp65kEXx7SsrwUk9Q?=
 =?us-ascii?Q?viQs467NwP+3KW1XAa0Yj+cc9y7xwuGDLjo71biFK6EC5m3sXovyILVW5TMk?=
 =?us-ascii?Q?r+bIeLEnxCvWSKu7tcAvaTUQTQh37A92dB7eMw5HhKFYmjj+ZTkrKJ7pQ+It?=
 =?us-ascii?Q?Aw46W4W7b80wz8zkYrfsgPGUPLoGBSAsyma26p1FT3UbRbXZj7gj2hjwJy0+?=
 =?us-ascii?Q?sBgPepsRpqARZjx5vMS/A5vKHQ/p2+UeJZ+/5tHqhqcNQSTEZP16+Hxd0eEq?=
 =?us-ascii?Q?e5FnIe7EU58yHvyImcRz6VxRxQWu8LR9y4rC0q+6Ig4FusrzSGWzDz6k5HDV?=
 =?us-ascii?Q?NyHQqOgq5RMmfbTUQsj3EWAa9FqIlJaCMsFhyK/GBb6JQ/rdbfz04D58K+be?=
 =?us-ascii?Q?mDC+3cWNoXXGTPDaO6gM0d+TTSIWkH3vje1IWsl3eb4zW+qCpbSuBqcK4lFA?=
 =?us-ascii?Q?tCSNzSBm2nkkErtyvj59XRr0fRm/dHmkQ1X5GiwAUNdy+kMZqXGUv7GSaVG3?=
 =?us-ascii?Q?Qv7LByNXOfliBu8vDX0fpbYDXC3WzuPnRGqp6NiH6OiQAw2qtqmXvqVfNvj2?=
 =?us-ascii?Q?2XYXrIdDA4u5LP8UA9A6UJwZcDzq7Eq1HlCVfD2YYPq36JLQXuUqcj1B1sWn?=
 =?us-ascii?Q?6pXvZ03yVWvH1wJiXQhfD6ao+hk+iaAA5L5TDH177UV0dodjr7vXaqWx9xGT?=
 =?us-ascii?Q?XPSI1NirBJRz/1Hn3HRY/OctHhckOhPjPVwnlwrBZQkpnK7jten5VksyMU3W?=
 =?us-ascii?Q?eJegmp2vi9ltfJy8ha9zGm7DAu9WrE88TUyPACKxqbTZ/NK9hSJly8kRB1i9?=
 =?us-ascii?Q?jaHBi9jiRpR6CD61C7kaQ1BDRCybrGTuISoBdSmSPeGgJQhtPFoa0K6DCqXG?=
 =?us-ascii?Q?FupdpTY2ZoqO69k01DSm+lX12ZWtTsCAJ0JFpIBazzkYXXTr/65+LEf7LQeS?=
 =?us-ascii?Q?zQvVuYY9qLxwsGkhVL2BMaDGiooyKZ1A8I6lWbIkG9/PhjSZoaIchAKqa82K?=
 =?us-ascii?Q?kxYvCVD37NaekZdtN4BMPNcpJt2pMTdIE/PFPWhpoFAEBf0tSPJsVuhuflnq?=
 =?us-ascii?Q?dlTJ0h4PiFFZz4BKHSJYKxbh72tenCX9yl+pgalLs9ozp/CCBBJ4pMHiU3L2?=
 =?us-ascii?Q?5GTSWFOIQy7yJZ2DOVf8fWfee1HmNm+TWfxmg/ASaC6QJGXjE/dimONV0KIg?=
 =?us-ascii?Q?9IvA7LecciPrD/cpPhMGaR2OfsVIk1MI6MdEFZeQoK1wqYNnT7TvnOmnNkM3?=
 =?us-ascii?Q?VRcz7OOu8V/4hDh0hfh5SlISHaTPr0I+ithelKCpgeKAsH4X6R086iYP0HbA?=
 =?us-ascii?Q?u3acU19JfotX8qIwqTRz5xw5oeGOoZA9ZxZvuC9gAiAPlnecKdSV?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f6240-6a03-4843-7feb-08decc4b8761
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:30.0065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YU39InB4BXVR/9oygZs7vVWwiz+6vGQ7WWx3lKfu9qByHiOpLagkbGvbDVhYG7cnaYk6FwFHtUuiZCCZNKLLqvPbek1r5QDk5QHPVQwtU0v9mBOZuMq9UHE3uETa4Xcx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23214

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 54900126ae0a2671f8790a7f95706b9ea95fac4e upstream.

rzv2h_rspi_setup_clock() is declared to return u32 but returns -EINVAL
when no valid clock parameters are found. Cast to u32, -EINVAL becomes
0xffffffea, which is a non-zero value. The caller in
rzv2h_rspi_prepare_message() guards against failure with:

	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
	if (!rspi->freq)
		return -EINVAL;

Because 0xffffffea is non-zero, the check is bypassed and the controller
proceeds to program SPBR/SPCMD with stale values, leading to an unknown
bit rate.

Return 0 on the failed-search path, consistent with the existing
clk_set_rate() failure path which already returns 0.

Fixes: 77d931584dd3 ("spi: rzv2h-rspi: make transfer clock rate finding chi=
p-specific")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20260425024725.2393632-1-john.madieu.xa@bp.r=
enesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index c60002f2b026..c94215a9a8e9 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -579,7 +579,7 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pri=
v *rspi, u32 hz)
 		rspi->info->find_pclk_rate(rspi->pclk, hz, &best_clock);
=20
 	if (!best_clock.clk_rate)
-		return -EINVAL;
+		return 0;
=20
 	ret =3D clk_set_rate(best_clock.clk, best_clock.clk_rate);
 	if (ret)
--=20
2.54.0


