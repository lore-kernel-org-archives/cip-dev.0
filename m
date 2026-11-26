Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.297.1795708098926381266
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nTJydBL6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.24, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlkhPzPJJbs8lU1OyR80QHdn802OwlwspG8ZBdv2Cvs5doCeq8W6K4OhiWeSLMHRsR8Jp7rSxJjwvKZaG6Tb1KAZEOU8yi8MBFjvRA16B9uWn7yo1HGhTRG1TYedWziApetsmD4/DX3eJAqhyCvu4b/knUfklIhfrfPJLllSqDg0HTlubO9giV0IB81L53AjRBlvDd/o225dY0D21oplcUgNx+ok/9xsolkLVXOng5UTCEmgSkpi+079b63i8tlTVg17nZ3H6hb5UcPVCYNdMeMcSt+yqqTczoir51fm9Lr4DO1Y2/j3Pug7ewQJpYz97SaU+pDu1yJa0fXz0ZsxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KzYjClUMXsteWD9fOA2/yQ//9G9Xhzoofn3UqQlSxA=;
 b=RM9+LxDw0cGLcJjTOF7uXvYdKxXWl1kLqc6cQo7sLEkCdQZfM1zRHvWiERxy98md6T6cJIDz4+gZbZlMJnoPc93lSw9uo9XFDFc9ixfOyL7BflXsGwHXMxRY2ZWM2ABIjWNkkKQGeMeNVkvHbGYQ5EtlzKQ+x58bmCNhSYPlgTVAzpUhknaKvCN1C/xVYdvPlP8iOBSSDxi2Iy48+1Kexk7FPuPcfZY/pw2JRMg20+0cHRi1VIzk8wuE7Of67URfoD5tfhSCxQChMiyK6NoUycAzs5onBE6uIs3iYgYBty100xdLwnEz/ZKjVmvtcXolx5qncY3c2a5HykZ7plRKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KzYjClUMXsteWD9fOA2/yQ//9G9Xhzoofn3UqQlSxA=;
 b=nTJydBL6ewsA5XT1YGyv/FvOYpAJUmAVxVWG9uDJS+4h4ongLw1Wq/DDK8qmqkFWLxhjjSh/nP0arp4RVlrLwBXuOKVsCNENPIeFRCqD82fylB1MpRo3rG3wqJ8FByORm19zUkf3m+RRUbT97qGwezLb85WcuDGgfyDBJ/xVM1I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:15 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/27] dmaengine: sh: rz-dmac: Convert to platform remove callback returning void
Date: Thu, 26 Nov 2026 16:47:21 +0100
Message-ID: <20261126154747.3832917-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: afed45d4-7c4e-4844-1b3b-08df4bd4af05
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: tI0iBxMKvOyG/MlzEI53/Girz9wrGKqe6D8a+d/UcHoHyKRRe7/d9vEECvsDUNZffbDdk0w7h3hjKYCAtRuo4KdqvR6404ilo68+v0EmrNJXFNJnufbx5z7Jw0otgffGb8bhLc8HdBDMTZEVtltcEhT0T+eO21HAleUSWe8iivIJiLS9VnZo9hQn5OaH75CyZ3qH5163MsPSzomvBfxWKppA4mb7/miLg5A056LgEtwcNh1Tw9u/g8sWvBTG2zKhwltISz8JH2h5Y4nzaSyJHu6hExsdmpq4jY4Pyru2adaxfinzllQ0JU0IMHQilrSSQgK0eZUlXO9+gGo5Vlyeq4PqoqDGzeufsVWsT6d3cwuqtEi1j/MbLQ788JoUl3OTx834yk8DwJS+PqPTaZ9SjQAwJAB2Fm1Xsz2jKPCFLX64blOU3VewhS1oPQ1EO4b9zpypcHDrLtHScG63OyZ7+ossqjdYqGNHOnRnCHsps1qzudADDsSOTPlKTSLqQ0idGjrZcm6UJVj8AIem4IJwPXNxOWd7HYe9Vnbq9E27G3uY6ibMZEdBhbA3O6KmGhs3g4YxeJ/MFGq74RVJIOh2aS9UNk3bWB2XYbj8AITpM8bDziSTPa9citAboc3BK9eqv+MPu4yFmFH2qVjH+lp1bzMfWUd24ovTvp6wia59K50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XvRHRRHrZps+7kBE8h9yegxc57f86F3/1+LvGtXS4DiWR50sCWpUg+roxZNr?=
 =?us-ascii?Q?bdbXRPFN1mmKNo9G4nULvasiMvS8AX6YEJ4/KjHFzCqWWmFBR7GNBHe6yuP8?=
 =?us-ascii?Q?dIE41AkOWQq3hCJcgJFPxTeb85K9GVBg4Kmwx8cMcTyWz7LFLZ+TF/A7cuSh?=
 =?us-ascii?Q?/hMlCvKu7aHX3faxhNzbI2ZSBP/JlHGGVps//9p3CYb9G0RQSALokVyUxBgk?=
 =?us-ascii?Q?2g1kE5tQ0BKIBtbSgJMlQ79uSAq/Ej+nSZM5U5sOwNipPDwhq2tAKoxCVpaw?=
 =?us-ascii?Q?HvXYEYuN7diEKx6O+ihnEHfMfTFSMDoI2sB3CnQDdKDZP+ASN18yeJcXnSX/?=
 =?us-ascii?Q?8t6brKuL7tO8RbqEQa8TpbeJvZ77nXjIScG6PKK+wJHDkwPQ/4hWL6k00HZC?=
 =?us-ascii?Q?sxaUB34cqoOTAO8/Wo1XlG/aAhCsItaj5acgQOwfDeR3PCOCdjsXX6wyPNw6?=
 =?us-ascii?Q?uhjWWNpUhHrQKpoorRQAzj6IgXDP59rB9NcblXHAtNIRpE2ASHp56uny0tGa?=
 =?us-ascii?Q?nQwAY8OOU9LsYEAQNIFen7qWFyMTsCxkII1rXfg0SLBtNGuDgkuVk5QLA43s?=
 =?us-ascii?Q?CUE1rIz+pG7n0PQb7SVVSufQ58uYlig1i9aixSwl8ppHUrenFSqVuXEAVj1b?=
 =?us-ascii?Q?rgc1c04VzJ6A4O3PuPOlEw42Hb9cTkFbF7SA6GQ16iaYyRQI6Oarfgaaxjbh?=
 =?us-ascii?Q?8Px5Phfzj2tFEhwW4ZkMMbKrFHyUEL45A6UsyeVizDOm0d8yX2ovFMmc3DVU?=
 =?us-ascii?Q?1Vsfz1TQ7A+zCbth1sDsKmur83o8d09lQvN0djX5Gn6JnbaIWYprmha8H4Fs?=
 =?us-ascii?Q?XVgFzyFr9xEhF4CDHs0KGkn1lKBNNIGurnQQQAWNHE+CACDSe8BQzlUkySwn?=
 =?us-ascii?Q?wG3NJLiY28b0pdwaG4cfebZCFumqddiSjWWNwqB08XHi4T/AOiRE9+8smYir?=
 =?us-ascii?Q?/zxnfXlbeZ3/jeJOqgRMauJmTii6jhshnxmgBajgvZHD9A0byIUwFIb5F0HZ?=
 =?us-ascii?Q?kvpbKNilkkqnQ3FAPNDq6OsT5Xkt306Sb5L8VVk1362Srsm+sCFTTi4Q5jDV?=
 =?us-ascii?Q?BL7yAZTAfBgsJimGjTl8HqOdbTT7TMASBQ5Y7Z13Cbuwjj6L5wRccgXZanbC?=
 =?us-ascii?Q?AfsK3ExIIo/IpYY3pM/+L1OVEUuC6NMN4ArmK+drtsr2+yEke8kgnko1+M8p?=
 =?us-ascii?Q?6ZurRVQccunF6vZit6IUqU7mihY/fAx0hjU45oWJpGt+TvoPDg1bShAp8P7F?=
 =?us-ascii?Q?7p3tnWGbVJ0aT5QakwjG03koC5jB267tjlTh9jeD7YYg166YP/gXR1FcZNaH?=
 =?us-ascii?Q?s/8FtScpKnWifxSkcyo5j4Vj5C0u4soao0b1r2VuRytRTzHp1kiBXaFdF0xE?=
 =?us-ascii?Q?/qpxeP3SplOpsTqhuXGfQ/Y8ypHQ9eAYdBKsn/5DhXOielFUd4Et4mPNIbFL?=
 =?us-ascii?Q?6BIL2CAtgDqVaGZDTa89mYNjdeQ9Sl8tllbuQ3eVNoiufkUysWDQxlu1uwae?=
 =?us-ascii?Q?wtWHwU3zk3OAviSkW3YOQrVGA1uOL2WppXTpAfqbQYbFxCoEQOvqT1GqDPXa?=
 =?us-ascii?Q?NQfqF632n79SZvXgXPjExuVpHDRSi1cZR3YTiMFyt2NFhcIkTenWn8QwALrE?=
 =?us-ascii?Q?bisEu+dQdriXlRy8F9HKvwxvJFoKhheTR5TaFvHfoOmOYnfGHRFM5Yaz6Agb?=
 =?us-ascii?Q?6saNKCW3jIiO5+rmK9VlfMmYQEBV0cPTsHG+a0IFr2/hN1NR+Oh45P8pIC9X?=
 =?us-ascii?Q?0F8Ei9ZXp9RLQsCE+62bCyDOeurf2P+YFJ/gtwxCwBXHmxawWipH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afed45d4-7c4e-4844-1b3b-08df4bd4af05
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:15.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yc0A4SvFjK9JE2LcgHxrdMGZLrfjaNMJvbnmaR39VEAQdTiok8cvrppmkLgDXm2ccKrNqJRgUAien4SMauLI036sXigjioFgUn6EK23/WVBsIfINRvi1UdIF9VIuXgGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25151

From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

commit bd4205f52310a158c78171d3a5f68c7301a532fd upstream.

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230919133207.1400430-41-u.kleine-koenig@p=
engutronix.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[tm: Local rz_dmac_remove() already ends with
 platform_device_put(dmac->icu.pdev) for RZ/V2H(P) support (282d5dfb9147),
 which upstream doesn't have at this commit. Dropped the return 0; after
 that call instead of right after pm_runtime_disable() as in upstream's
 hunk, keeping the ICU cleanup intact while still converting to
 .remove_new().]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index da566fe13c3a..aec3abf49185 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -1048,7 +1048,7 @@ static int rz_dmac_probe(struct platform_device *pdev=
)
 	return ret;
 }
=20
-static int rz_dmac_remove(struct platform_device *pdev)
+static void rz_dmac_remove(struct platform_device *pdev)
 {
 	struct rz_dmac *dmac =3D platform_get_drvdata(pdev);
=20
@@ -1057,8 +1057,6 @@ static int rz_dmac_remove(struct platform_device *pde=
v)
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
=20
 static const struct of_device_id of_rz_dmac_match[] =3D {
@@ -1074,7 +1072,7 @@ static struct platform_driver rz_dmac_driver =3D {
 		.of_match_table =3D of_rz_dmac_match,
 	},
 	.probe		=3D rz_dmac_probe,
-	.remove		=3D rz_dmac_remove,
+	.remove_new	=3D rz_dmac_remove,
 };
=20
 module_platform_driver(rz_dmac_driver);
--=20
2.54.0

