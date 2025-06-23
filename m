Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1478BC7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:29:39 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.19])
 by mx.groups.io with SMTP id smtpd.web10.16494.1750674568112961336
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:29:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vYLDXRo8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.19, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C40xIF+0GkAxaZBdUxy5i8viCHU3CmCKeJgis1lQq1fbImsmhp1QY9lWz7hOqML2K1taEXj3jtH2UKHQfUMVzAGMJ+ydmkuKuVaGQlKoHaI2yP6X/eJCKrzNmgYS8TWxsitvndTLjz7Fkv17aHrb3DBS7bKMprytRhaYhcPR/vw6Bf9Mb7Znjw7XD5OyRoeSSj2xiFZVdaeQwRPvka+Q8t5jfaX0FYsTDw95hYJ5nrdiFSMuUK0Bud9CoOtx5ZmztYwNui3kd0EQWkKfjBkhhrYXk8JO/roqeXWDCoeldsjmL2TjsBlqKDtEO0thfapwJfjZEVNNnNj1M3nnHkCc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxSXOptWliuzS92wuO0n1BKZE6ZVdIwgDWaZUflDL5U=;
 b=CkGAOGOz/qTWKoHPHEYbUrFqLsERCsKptBQmdtBS/xEZr3hby6Vrs73crrfxZ0uYf2mfQBBu4o3oH6sKa0AQfIKjNlCRP4x9HoAZELiwq7y5zcwb+JcldqeEArz9gVDFkykQXhXI/aexvS51bBLflwdovJhLqRDZrzwsVfuoy8bIef5mfFgamGIhlm1DntpCPgbfuErHfksnJfME0KjIvFlNAKP3fc98RKZKZVxYJI4dTl9ljB29fsVHrxWk+KUes2DkVZdOcgQMSh0Kfa4Z3tsYKUkwuC41I8b+0jtw8isxzzbBIrRdrihzFkehiXV25cPh66MXhFz+9YoKM/vbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxSXOptWliuzS92wuO0n1BKZE6ZVdIwgDWaZUflDL5U=;
 b=vYLDXRo89qRUg+9b6D3iKxn96+B8eOZjCi70sfldsKrmhfxNzSYAX6/PvusmKJhuaZW8hklLeGYLQg+nwn/l0R93ohxIX1v/iTtSqfho0mGPWTM6HkrwjcDjj1+kXX/EfKpcWtiH3nG1iW3atzBpHPXMkQd3+xHSzTZZRlCc1+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15129.jpnprd01.prod.outlook.com (2603:1096:604:36e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:29:24 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:29:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 3/7] watchdog: rzv2h_wdt: Use local `dev` pointer in probe
Date: Mon, 23 Jun 2025 12:28:52 +0200
Message-ID: <20250623102857.1493371-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15129:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb30faf-8e35-45f4-7347-08ddb240d29c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6ABovlvXFT66GgNM1zPw/oLjj0XJ24iyILQwsbkQ4xQBhXju+VyKf+E/LC/p?=
 =?us-ascii?Q?DPCC5Y4kPg1VB05P8TGeO61g9BStHjjQcI01nD53wJrWSrXyIXhTkzUeDEAT?=
 =?us-ascii?Q?i+s77tT1ksCj0rWstKu29SSxgS4/BK8cCmuGz1W/izfbgcgu6eI0NdzKEYZQ?=
 =?us-ascii?Q?pzz6jyCTkkNFP4Cn96xdaL5EqykM+GboR5zf4hlue23KMKQaznKR9q0c9D+d?=
 =?us-ascii?Q?Txe2cP0dhc/Pbek5dynSK7fprI38FUQOa1ThtjYHoRaBCxNpD8iwugDOsNGU?=
 =?us-ascii?Q?nIcSN+T2XAHmHyPmlbS8yT4Gl2uhIg4Sp+kTaOyAeuQXNZKAfb7o+yiasM4a?=
 =?us-ascii?Q?zI6NZa5pP/4trERkOPf/iqxImDUegW8AKsvS16JFIFJAxGqG9vsMBFPnfffz?=
 =?us-ascii?Q?sBm73yl7PP0RaY+OjPbBGFbBs68FXMeN5ihmTkfLJPqZN4IKVmHorXCq9lFm?=
 =?us-ascii?Q?g0aGYZs74laMRCJ2GUwj0BGhB4U7Rqpd91FPZxyLK+8yvLDqzjuczYD9dAfA?=
 =?us-ascii?Q?E8TmwTOZXJHzoAUmE5B/xRv3HusJsw1TKv3ZuPLMon7L5ZwuUWy4kKlCG2CW?=
 =?us-ascii?Q?W67tk/Vzja3oUDClOObNp/Sl1/PchTbzNZy6jWlt6jxBtEkhuNZqpQk6bDyJ?=
 =?us-ascii?Q?E5ruSjG1vvPZacf3XtnMWOuIPosUfm+wGps0FRhrFbIbXKorQbO+Ir7rNQzH?=
 =?us-ascii?Q?1x9Nd1oXOUYThJ8afzpoPR7zkty6xgbeml33joiMBpVNHOehvpmYbZRPDgFl?=
 =?us-ascii?Q?8Pf20QRsG0EpvuPa5rD6NaGsbR6BeNbn6rGLN1gD2oSJo8OCdc37zd5sQiHw?=
 =?us-ascii?Q?du7I32vMwMlNjDL/2burjuHL8C37Fq5KhgbTt/B0OQSkdZ+nL6KLkRik5hGk?=
 =?us-ascii?Q?ZMZ0JgCshvB/HOzz69bWUdEJnrLz0zpWIhtkgTlFairLo2t2DGW+vPZMZF1b?=
 =?us-ascii?Q?hCC2qF2nObqKpFGMuktsGBMCQqsOAJRNH+Fof50gtVeJnqsI6n14PmiER4Bp?=
 =?us-ascii?Q?gCEg7gdY5Yb/1w6aFhG3f18qyOkv6NwhZYJ0uDgsHaBNkmNJgyhxiO90rVl2?=
 =?us-ascii?Q?cAeY6cvn6B91y4kzB5qJGSa7XzA8L+VzMcY6dvK38QNztYN3J7pK6C5IxzWO?=
 =?us-ascii?Q?37P0wDDjBh36GzQaovKJbqxbejUjDn55x9BoGSnKPUesu3DKjKALugVxThjt?=
 =?us-ascii?Q?cmzIV+Z907o7nnBDDksdL2Ne9rfa2u/OS8Luvaj3sa9gzqJk8YjthWFeZmJc?=
 =?us-ascii?Q?qECn0W+rojzdNnNuJeOehqgvWKnLL61FB7Bqn2lle3k/RQWj9BRKP9MYCNDN?=
 =?us-ascii?Q?1Ggsx6JAWI6F0nelrIi/sTHRGa8GWGJI1+BQ4RfXdIUmLy4aDiPlZJCdMOAP?=
 =?us-ascii?Q?Fif+pUdXR5OdZNRk5k8EhvM+qIqx5AIwvh15OKIbtfzFdHK1UHk/gDx5Ud7n?=
 =?us-ascii?Q?HqVLkyYLuIClQiO4EnsVIXzEWJJa8IBLtdLu6ccwVyASjR9ylaU+Sa2EASnP?=
 =?us-ascii?Q?NnEhnzTHIBg3suQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jO/6Okl41Q0os4eW5d5YHPZlVh/ewud2zuhWbkY6+3M0Rg6G2h2cAP0GU/fx?=
 =?us-ascii?Q?/oXn8hH5PJujBRzDeqozEKJj0888EZj3dfQUdNAJfzWNzHY23PBkl7GCP8F+?=
 =?us-ascii?Q?wImucCQ6JnbqTcHXGnKMMmygK9Qq/Rpj6i/kI4iJc+RSm0gMw30k65nRQ6IM?=
 =?us-ascii?Q?Qgl2kWAorhTGWzaNYNjG5jyg2y5VSD5Ngqkdgjn9j54msGHxq6U5/1Fx15ER?=
 =?us-ascii?Q?19zf8CEEy9yleZTEgLzP6ENihBf70Q4Fv4xUObrisKH39WrLhanwC+Houh47?=
 =?us-ascii?Q?Hu+jIuLD0zrjwPKibUxFGh03pv2uH+hJ0HB/Mr+ua0r6HmPxaMK84qHVD0B9?=
 =?us-ascii?Q?PWzFSLMUgy64/TK7MsJdgpCKP2c15eA/QhvzYg/SiY8gCNPIrVnzQfaSbB6w?=
 =?us-ascii?Q?8F6RtZXucFKr4+Vxt9YY33jH3XN+3CQeT4fDNy9h5s6bwY1YAyv7iCcRNS/3?=
 =?us-ascii?Q?3XAd683fJrQgPHJKxI7qSM3gCXJK/8Cimh15vfJKwBBkJsaYJ4pyI8pvrJpO?=
 =?us-ascii?Q?MVfwIgpzR/DOOIHxA5DqK1IwVplIq19Gk1bWbJZTBS8GdwgealIuGtzPMYnx?=
 =?us-ascii?Q?FeKQxPlgbKmKswOf/pFWh6c4sVhhR+pi41/J6uLR4tNFjyAP2VkIQZiDTZj2?=
 =?us-ascii?Q?eR86Vt7kLEDlZSvfmq+KQmNte+7g6ST3cLnYdakwucEkurfMiHv0nhRzvSoZ?=
 =?us-ascii?Q?0SX5u+SJ/NSKnFnHy8m1+kCBSq87ZLMHVm9hjvVUaZfYZ1SBjgo9XLjFSzXy?=
 =?us-ascii?Q?ShKCJapvB6wOxq2S7FUbrHEME6kgQ3sa5fz78dcJuIZxGLeidPhdtSpLs9Jp?=
 =?us-ascii?Q?7ofZ0CjatuvJFzeKzRW8iGyf2VOMuyOKVXRBeyslBrgwbNHg3BDLUe2ITMRs?=
 =?us-ascii?Q?YJ+JdLaV4ZKsfn7h85TgkkIuIFBQXiJZMnOOUQ/O4audPexvYXuxGyDQARY3?=
 =?us-ascii?Q?JefHGwijVFhDfiiY66nczWvty8tuE+xM4EaaKjYm5ZXz7WKRMRYSD48cJYbz?=
 =?us-ascii?Q?abZemGoZNs18tOHb6Uxldg9Bsn4XNBeagE2dIrynLfefrPwAkFvUOVMy6wrj?=
 =?us-ascii?Q?XYYwjXHz4jq1VqDVcD66B+mYR6HNhq2vKc8Vz3lluYf76a0+kgvqG+tCDqED?=
 =?us-ascii?Q?VqNsFk9Srxt0wPtB2vTe1c0hpbzXvbuZB0iHT85W0xNVRiDFIhyKx9qFDktj?=
 =?us-ascii?Q?FAl4rNhzxNy56ctkpz1HNgAY5DpyqE87Pl3ti6uVwyIgRhUacAVKkSQfyH4c?=
 =?us-ascii?Q?j6Cp8Gu87QczbKbrBZenCQ3cKqrASqnfG2waenA6XKpRG62/vyHQ5oYLxH1X?=
 =?us-ascii?Q?Vj+1OePshAvqObxQ5tHpXkcR5rA206NxNJ4HAqngnnu90QkjBqqwqyCUK+WG?=
 =?us-ascii?Q?kmYXyS7ODpkbsRuK4NZWigApl4qFCpGCSGDcD0R8n0wgoPJIay0rdp7XXmtV?=
 =?us-ascii?Q?XDIIudoS91O6PWNiP8EZfJvqk1s9xrIA54UK6Bikbxau2sDlnnpZkjv6/RbG?=
 =?us-ascii?Q?kgMXTZWlTu7VXq2ytftLrSArgkO2Z62gn+cfEINsef6n6/1Jp70fzvCeq/rX?=
 =?us-ascii?Q?WTl7i48GNDiGmR4CbkseyQOj7AeJwjZakhQ5wyRf1OZV4LNdHl35q4BTjhLD?=
 =?us-ascii?Q?c1zWOepNsYUq3Gx5YUJrgOY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb30faf-8e35-45f4-7347-08ddb240d29c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:29:24.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wpC0k8nUVPf64p9Vxz0zk9wAajOw9bjqdmvcU84BSuglGkQOpm+thJ7TfyvILS/w8cUpGimDzBKy118l43v3fpItXDmJXR1DsuJrdURmFiJlAQ8c8fEklkztLkVxxAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15129
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19177

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1f2b24a524fc20a7e893981c1a2e12d080e90ee6 upstream.

Update the `rzv2h_wdt_probe()` function to consistently use the local
`dev` pointer, which is already extracted from `&pdev->dev`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20241213171157.898934-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 1d1b17312747..8defd0241213 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -217,24 +217,24 @@ static int rzv2h_wdt_probe(struct platform_device *pd=
ev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
=20
-	priv->pclk =3D devm_clk_get_prepared(&pdev->dev, "pclk");
+	priv->pclk =3D devm_clk_get_prepared(dev, "pclk");
 	if (IS_ERR(priv->pclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->pclk), "no pclk");
+		return dev_err_probe(dev, PTR_ERR(priv->pclk), "no pclk");
=20
-	priv->oscclk =3D devm_clk_get_prepared(&pdev->dev, "oscclk");
+	priv->oscclk =3D devm_clk_get_prepared(dev, "oscclk");
 	if (IS_ERR(priv->oscclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->oscclk), "no oscclk");
+		return dev_err_probe(dev, PTR_ERR(priv->oscclk), "no oscclk");
=20
-	priv->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	priv->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(priv->rstc))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rstc),
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
=20
 	priv->wdev.max_hw_heartbeat_ms =3D (MILLI * MAX_TIMEOUT_CYCLES * CLOCK_DI=
V_BY_256) /
 					 clk_get_rate(priv->oscclk);
 	dev_dbg(dev, "max hw timeout of %dms\n", priv->wdev.max_hw_heartbeat_ms);
=20
-	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	ret =3D devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
=20
@@ -251,7 +251,7 @@ static int rzv2h_wdt_probe(struct platform_device *pdev=
)
 	if (ret)
 		dev_warn(dev, "Specified timeout invalid, using default");
=20
-	return devm_watchdog_register_device(&pdev->dev, &priv->wdev);
+	return devm_watchdog_register_device(dev, &priv->wdev);
 }
=20
 static const struct of_device_id rzv2h_wdt_ids[] =3D {
--=20
2.43.0


