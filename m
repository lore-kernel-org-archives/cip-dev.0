Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD4FCA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.17])
 by mx.groups.io with SMTP id smtpd.web11.1062.1755706193134486591
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LxuCLriX;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bm3RdNhVJAcrN1iNG6CejBdGD9HN0/TsA87nbrsJ8VoIw+JmWuTxMN/MxCV54vwX6kc61lg9+LJ6fNG3fjDNPk73kXoTcF/SnaKwTF5Euv2rVWlyPaSyv+bkpr33FeJ18X3cvgqW7t9KH8tyKWTPhzMrVXnbvGL29zdPwbkpMqu8W+ZdKgxptdf+g6eI6MpYKnZkn3Hiun1W8IkyLVPO++n5LJjfNUS9dv/0j+C9FMxTNtmtSUtUSctmjuPkYkSiz3yTWQ4K6p7N6pGbcOk5xC4uX0IAVEzJVA336A8HwNvjXwYuv8GFcL7r4JyhHuEPW7XREkRia0DkPoZqQVWKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jd5AvO4A9jWFG3SKXT7o+33BEPOmeQT0p2oyyN/X08=;
 b=JW2aq9q7CstLdE1i2ggOVBmIHdZV5WUOVtAjTkwFJyEkD6xkuMYMs3kD6aY5q/FKHMMoa3PDsv3YBR40cvvSSRFz2mlj7zCft/hFgftgTvDxD+NlA4RwFKwQhKDbHH34cIB15NKRvmfeM4cDb9ztwpjlrcTzIy0tA0iHNc2ei0qsqcLGtvI/QxPaOmjGPMtLdwtcXQzKoh4q6d/VsW65lbmSAhajxQ27QBUEM4Gmjwdmp4aGab7doUR8TgFYocjWS2YLsEKfApoTVnPRxFAKfKdZAS8AMlLCC3uEli0KmGo18KXUw+FOWO6BNFTe8Z/g2SEnMB+84SzI0Te/OMmF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jd5AvO4A9jWFG3SKXT7o+33BEPOmeQT0p2oyyN/X08=;
 b=LxuCLriXnF/QQDEMdelaBYs3TJub6WtVvRMcGBbrK76TgRp3M6cmjzSKLM22gKjJ4AfFz05jOZdMFNQZxbsE4C5I4DXlkSouqawRz4nJ7FMDgIpPWhlgRdNx4ZbHSjo0KsnbNJnrxWarySOiaMvWJXoUGn70+gafVMnqSdJ2ZOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:51 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 35/55] media: rzg2l-cru: csi2: Skip system clock for RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:07:36 +0200
Message-ID: <20250820160758.801813-36-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fa1019-050c-4145-8f06-08dde003fe08
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jILk8imfyXiI3sS7IF86GYuaRLvn0imF35q7Hdxn3jX/KZZ6ppR9U5ZA3Q3D?=
 =?us-ascii?Q?PE0E4LuetEO2jtAV1FcOtSQD9cTo27nON4G7n8P8TT9xtou6TOUZfchLwYW0?=
 =?us-ascii?Q?QzasrgacyxGG07LN0k13o3wCm0iRoQIirN5sStEaL9ZEIoyxCOIafkEqlgH6?=
 =?us-ascii?Q?iEsd1plgdYzq12LNFAGmWzRsNvsdr81qER+TIF4jr1CuNwzQ/oDcywxPPgJL?=
 =?us-ascii?Q?DCqhPlo0kU4ScZtpXqCE3e+PHSB+0jAs3tXs185pxl3bkgAM5eCus+fxdrZ9?=
 =?us-ascii?Q?YN7+3Ztu0FZtVmnJeYMZbMrUHLHdO38Ufd8RT6KVSYtBGnAjXgJ5kaXMCasf?=
 =?us-ascii?Q?KnkdOaa9kOVch0S6EkFLm4q6QhXHpbgLcbxQQ84h6nMgQMO2XESN+SHtsSmn?=
 =?us-ascii?Q?ASiOwKbq5dUx41L5hBe+PGQkqCV2fybHY6WMP/37HhXudvEP9+ycdr2VbN/C?=
 =?us-ascii?Q?Ueux0vgy2lp/D35ACK/qs2eE5fTEmZTmYow/HvLQJMBsMuUtCGXyoNVwJ14i?=
 =?us-ascii?Q?Sp+b5ghEfVYJOJ1+FUCd/hQ9ly894xhSvAlzautBDB3NlZ5CVo3EcwBa+1Z4?=
 =?us-ascii?Q?EqhlXr11kKNbj4+kVohMlBey8W2bCSGnNTcqnvoXbuyWopbSuOXpau3Ip+Td?=
 =?us-ascii?Q?NnhzfNkCuUaGFgrFNhLFmdX0Vjxb6PxIkk9xuub2uvJ+btDxBa+2LwOuMZgX?=
 =?us-ascii?Q?wD6YwEa6d5xWUG3wy3fUERb1b7EDlmMO44irgFp2iLwI3fU0DmaxtAX++ff5?=
 =?us-ascii?Q?2WdjthkNLNv+EwHYt0wErHG3exzKp7hd70IrW1QG3MlEOgA+niZn9MSTrfzV?=
 =?us-ascii?Q?x3eAi2yfwJqYZyAgqhTFJdKOQRAa/5V55jRkFL6uHYpwkoTzLEt7HoJm6cvk?=
 =?us-ascii?Q?v+mi9OQPUXL2CMDjH2MfGWOHkt9HT5aK7Vu29O3mEPI4b+JUpMvm0b0qsCma?=
 =?us-ascii?Q?SA2uhr3zEc/LysKnXjs0LWuJE/7D0Tn9mVsUr6nYtvigeIkbMJgdWnVYzyPA?=
 =?us-ascii?Q?DMyIEm3tniBcWykx6qw4iIdAq8AeJHcGvNAzzP8UqDUCnyfWO+CtAR/l+GDl?=
 =?us-ascii?Q?Qb33ol4UChH5p4/jv/YjbPuyekb57W0WB1Ctq+0BNZe2/ybqp3wa/L8S6OYU?=
 =?us-ascii?Q?sXYrUfP0tARKIhqhP9k5Es4INS+WMAH+Y/ZfqA/OO8DFO+a8XFFPlBf0IJmB?=
 =?us-ascii?Q?8FgqMJka1MgYpAgQ+U3yyn+HOu/hhaFxHg54EiqawjjipuablO7ACEghGhWk?=
 =?us-ascii?Q?EBezn8ZpbEUADzM7o94IgHa6nkl4dCQ69AxyEdzMgpQd4QtYn1rMLYusO5AW?=
 =?us-ascii?Q?FuLHM/PzYYZKAoW6EAaG1AhwfD641pDUyS2ydKyMgUwTYDYMegpY2c5VNoPM?=
 =?us-ascii?Q?hY/0FzjTdv5r4Bv79I+lkGerbgLAbGlNi+7Qio1pA+TPGLYVmeShatBcx3LS?=
 =?us-ascii?Q?pN1SYudRfv8+KriEcltCnDNRukXpwlcub5WDT9pYywk0Y48LABayY3ycWDQI?=
 =?us-ascii?Q?jPTenFTsVPQDk+k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MCIUAmwj3oAmNWUJcZ9UY3AMzjpDehJYwtmKoIwYTUW+ASrKiqMI+zJoqRfu?=
 =?us-ascii?Q?AvH75ZF/1efWCFzDJsZ7BvgvJ1ZPpKcgSaqmwU0S0x59DVOX+6zUSsMS8fob?=
 =?us-ascii?Q?OIO4rFifheKpQz1QI5IIOf3QOjU0sFzhI4fnoSGzUrHS8D+3fZ4jYbrJ9qlj?=
 =?us-ascii?Q?3EaeodXcLZ/OazVMocJ5HP42NyY5YoOb7HR+qkhgSTc7vpDZ1WOZ+d86rcT3?=
 =?us-ascii?Q?2GyGUVZHuQCH2NWvxemTqxdUstLMkG/S0D6Y1aEuyUNx/ZHlXlUFipUK7kBu?=
 =?us-ascii?Q?tbCZlzFVyYCEZ3IATCQpeJ2PemqOfF7v7UHPh3WPTJC//f0wVyk05k4fINRP?=
 =?us-ascii?Q?icErN9fxYT6t1J5YaMdhgWHmzEpIegvVDJ0PVonzxTGUjR2URqXN0xPP0QJa?=
 =?us-ascii?Q?ZVvCUSQU2eUAj4ehF/XKxzE4i3CpRJm/p+uyrJ9fgu1FmNHyMmPxoHms98Hb?=
 =?us-ascii?Q?95M5fhCbKl9Ws61Vbp/9k7I+C60PW6uGgLu5p0BfyZqR/SHrcmKRhLlRQOcK?=
 =?us-ascii?Q?wPN/VSRjzeZJIAuoXtgGE0piz1KnnpI1r8DcAJrhWr5iNor4uyvnY/HpvYs/?=
 =?us-ascii?Q?cAL/TgZDC/QgUSGE5Ne2gPpKYcG9GrFC38a+xU90h8qxMkEelClEXsjEXoCY?=
 =?us-ascii?Q?Ai1fE3Q0ebRMnuK53eOPsXQMOBfT0EmcHpyCSMQyzzXOJhQj4rsjm7cveytp?=
 =?us-ascii?Q?P0nNJ3LE+3pR/5PuixT2//50XBxKYO+PlpUWB2jr0uu0H6kGz/3JcqMaJ4RH?=
 =?us-ascii?Q?FlZz80Nv5UxQEbDuKv+IkMqXIzo1sURechKw18oDVWIYOTW84rISAzLNp5cY?=
 =?us-ascii?Q?1B1lc5XCH+T7BlI6Nv8dX7V5+ELLmTyK5Ee9oi6mJSR7D9y8pzVYx6ikv4MW?=
 =?us-ascii?Q?q3IrzLaCk+8yItxd2jvf4ufN6tiVnrZhjjzv0ONIIcf+tuGJ0vMmeGnQb82C?=
 =?us-ascii?Q?SMNgeJTua3i74iGdKTIJjqToAToYlxffGTU85sEsj2vpL5Qaj/kFa1wxYyKu?=
 =?us-ascii?Q?5LDWPYt6XP012VjJlxgTyR82iLYI82fnVLVn9UhUPvNPIr+aXPGp6zxE14gV?=
 =?us-ascii?Q?YE3Zu/B949cjYHk8UTOeiyBlsu1LoPOoWckhh64BW1UpIPUoVsUJNkjZsCXg?=
 =?us-ascii?Q?q0zfJIJpbAenyfznRKGXlSvN0HYWhjnMjoQw7DbAwb5kLYNNMNt2GskEAN5p?=
 =?us-ascii?Q?57y4tEmSYWUbsVVgcF5zjYE+4U8AU1OfYXO6Kqz1hAjpPxL1ntHrsG49Hyht?=
 =?us-ascii?Q?Zj5qilBXDGPBC34WfQTw5tJRb972xr+iZ8Klc7iZXCJaAHmfbtvQdx8YnyVx?=
 =?us-ascii?Q?LnnyDwu+JLa9Y7KaMQHEYm9mjYRyinKqU8yKQTHcoq+pIpF9cZqIXDFGbgiI?=
 =?us-ascii?Q?79rPGZBvJS6fmY5tg45DCrZ59bRoyxWTOiWPgFk/dWCYX4AlJhk9pubHmFod?=
 =?us-ascii?Q?9DHSns935qm5pWy0pZGgfcr2TUNnQG7PBU9DQeFAfy3frLt4kaOl3kgIL4fl?=
 =?us-ascii?Q?BsOqbItueYvDCghpjI5Qm5YoZKnAwnkvksaua+4tF5PFjjPF9CNwE0mwh/sU?=
 =?us-ascii?Q?fx2JI5kWyzFOqd3nnZmhIiwBsEG4wKqFkkTGSNM6inOv+6XigwbUcnHjWQhe?=
 =?us-ascii?Q?vP6FGhAAelfqNynbtvZpnHQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fa1019-050c-4145-8f06-08dde003fe08
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:51.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXimE66XpQM97CuEFXtILmxMVgvFtmMxAeDUI64jW/kTFb6nrX8quiYu0Tt1ffYJOWVWmGRTPyIZquLQb3+3aCuWpgHjxVMm2tloXeJoD4xMI6OK8DBmDhK7Qin1sfQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19916

commit ed472263fcc48f72e32cb494061bf8b8c333891a upstream.

The RZ/V2H(P) SoC does not require a `system` clock for the CSI-2
interface. To accommodate this, introduce a `has_system_clk` bool flag
in the `rzg2l_csi2_info` structure and update the rzg2l_csi2_probe() to
conditionally request the clock only when needed.

This patch is in preparation for adding support for RZ/V2H(P) SoC.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-10-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e02e8107a33a..88f904b2eef2 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -127,6 +127,7 @@ struct rzg2l_csi2 {
 struct rzg2l_csi2_info {
 	int (*dphy_enable)(struct rzg2l_csi2 *csi2);
 	int (*dphy_disable)(struct rzg2l_csi2 *csi2);
+	bool has_system_clk;
 };
=20
 struct rzg2l_csi2_timings {
@@ -364,6 +365,7 @@ static int rzg2l_csi2_dphy_enable(struct rzg2l_csi2 *cs=
i2)
 static const struct rzg2l_csi2_info rzg2l_csi2_info =3D {
 	.dphy_enable =3D rzg2l_csi2_dphy_enable,
 	.dphy_disable =3D rzg2l_csi2_dphy_disable,
+	.has_system_clk =3D true,
 };
=20
 static int rzg2l_csi2_dphy_setting(struct v4l2_subdev *sd, bool on)
@@ -801,10 +803,12 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 		return dev_err_probe(dev, PTR_ERR(csi2->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	csi2->sysclk =3D devm_clk_get(dev, "system");
-	if (IS_ERR(csi2->sysclk))
-		return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
-				     "Failed to get system clk\n");
+	if (csi2->info->has_system_clk) {
+		csi2->sysclk =3D devm_clk_get(dev, "system");
+		if (IS_ERR(csi2->sysclk))
+			return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
+					     "Failed to get system clk\n");
+	}
=20
 	csi2->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(csi2->vclk))
--=20
2.43.0


