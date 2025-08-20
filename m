Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F428CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:34 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.6])
 by mx.groups.io with SMTP id smtpd.web11.1036.1755706158993050000
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=G5wMjwf2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCF41Y7t0bbPRSkXenzaneJjE57GEiPsAJLUx4SeYUWG8p0OWC24YL7Tq1RpxcUGotr8nfnalZREv8JXQL6mk0PsGUrMyubNlsYgBVZfjUFesd/4dWXnGSr9i7jWVYFn1JzGJB98D4xVnXQMicE1PzoUpOUYBPwwqVsQDYEYlzycsLsApzgsiUAGG8QQqNcZl6QYDU5CMYwixY6sOiVRZWOryx2tElXZ8v7OCcGlYds7jcAjOzZKzw95jw1Apet5BqFTrodERzws2CMh3g6NDTZVCUbeNTMHBch4LBdJJWRxbB/aJwkgoTRUZfDJbJ+YZD0RMEwW+1XTbwcS9CAOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kqt+rht0OW0PEHCJgpZiW3uHZ1CsG1WegFH2z30Wc/o=;
 b=Qma1rMZUhvyw3dpRqrFVHmQZOWPjk7/7iDWQcuHJJ4m0iRub/v0layZkM/MoiQsQD4thXj3RMV5Bi02Nu0KqQc7r+NQgdMuMF8kVSl7yFEvMAxv1h/05zVdNaQZfzokfA+XAFz2Grb/Rop3IyYMVJaTib6OjRpQ9dYulX1us6IRutkwz7/NrJQ6dWQfzWE6VIstgqxHBymCaIwQKnprD3uwb2aQAPP7oMOQrA0AIo8uMyeWjG1T/u8er1USyeaP9K1AjtIQg4zF+Tlz3PSmw+TiR6hoIjrjwazqLK5Kpzb3DxVcjPRsMj0dVVT9ByDS3HbBqMuYnO4zFSyPjB9dX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kqt+rht0OW0PEHCJgpZiW3uHZ1CsG1WegFH2z30Wc/o=;
 b=G5wMjwf28sZlDtSLw+lPcCafbfvEt44XCIJk4unrxlOBSvHKR36LkaMd/kMy/EEIiYNFzApooGcMgRKshAKN0IaDqf9osA45gC+80zw6Rtc6fZifckyUFC/vQ36BAoRJ/ZpP+f5hXqRqDI5tubhiB2RCJrK30h6E5RyOZLXiyVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:16 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 21/55] media: rzg2l-cru: Use `rzg2l_cru_ip_formats` array in enum_frame_size
Date: Wed, 20 Aug 2025 18:07:22 +0200
Message-ID: <20250820160758.801813-22-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad47bde-10fd-40c2-5df9-08dde003e957
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?llNrDymwq5aquQQe8mcg0UTGSMmkPritwiphiE6NkogZU5T5TmLUsMR7iOoq?=
 =?us-ascii?Q?7ob1exW68Y6pV3zsCo9NWPg/JRRdv1ekzOHMbbMGevJ47TUFIeZDaSfTvCRn?=
 =?us-ascii?Q?2eG7R0dogQPSVTnay/4KRyQUD5k9Chm7dMJy3o308qCAryWd/ZDnFvTTljHn?=
 =?us-ascii?Q?85a0jJ17NqWZv/gLlPM9a9Qsc8mj2xJyWXbthoyI9jPUIBWE5Os786XeAlMD?=
 =?us-ascii?Q?aD1Rv8JjYV3nVGFplA20MZ1fzfIV9x1mQ98hgN+L5fzIKJIdrkEC4mugZ7JX?=
 =?us-ascii?Q?aH0YLl69m5UnEGRrWciZl8wzyLft/OOQCX1OZtmNEAXcSiRn8QW3NEBC090e?=
 =?us-ascii?Q?QGL7fNyE+68Vch3ZubjB/K22bYQ+HmZpF4f1eCy5KEHYJBaj+PO41771ZdKU?=
 =?us-ascii?Q?S4l93+P16i+4Na8pnWYHxE9itsHpBabHLtuDdffVn2LgPXFAN8O9tz817h3A?=
 =?us-ascii?Q?Du7Q0F+GUuy3V+2Qty9ZzLRjMAWumQbZWkA63kXBxOTp7zasiIw+sScf7AAH?=
 =?us-ascii?Q?p8nMvlyKZfTYsss0isZ5z92VBmvKTCLapUgFZa3EdqLlW/Z/czcdSey3Fs4G?=
 =?us-ascii?Q?6KMQlq0PwIROm7NrtgNaGp1ULtA0bzpbHWEuIemAmesRSOdLET9jC4NCV/pN?=
 =?us-ascii?Q?NA5VbVBjoYnnO8Rqw7L4ck/sLdHc5upivU6xGENSAh/SVm8CngME29ZzjTDp?=
 =?us-ascii?Q?FUTKrSBrbJ2MJ96DeflGyNiQgxmgiIvcmnFAHtKtVVqw8KoA/eE7AaGltMNt?=
 =?us-ascii?Q?d5qfDQMrvQWPDYDqdGZtdRoXQ6NvXZPMRi7tu25Q795iFRhojlj4rwHrqs7S?=
 =?us-ascii?Q?AEP6fCOGjni6SB8nden27NS9LGyP6GvEkKn69ZHhDd4iVGlBeO+W6H4PwmEx?=
 =?us-ascii?Q?3FEFnxtG23e3Av54AJSKDy/xiJNguNzVAnpGA2kf/YJ5AAFmyvm4xBNHe3+4?=
 =?us-ascii?Q?ipPbS4GQhVL5SDHH2ilfqUSqSXZDScYQsHtyApL8Z9R02VY3291tAewDEGn4?=
 =?us-ascii?Q?g9vxcbM5UY5LTx41BBfxASBgodgfIfyD8WY2ZdI65hF9vBtb8FawprHdzxgF?=
 =?us-ascii?Q?Z7QVU6X3N8XYbmehbd+yQ8aaQEeqd1u/a4t0bCDM0mtlmXekcrTUJJjYVRbU?=
 =?us-ascii?Q?GAW4RZQeQRFcUdNYWtZL2qatOv6/luPw+BVXaO13R9rcv3VbTWWtCOq3QJHE?=
 =?us-ascii?Q?XGGhh83GYQ8qT0vQ4r/5IfwYSdeHUOBy9E8oAW0pHdWNWb89slFU1GwXqhIE?=
 =?us-ascii?Q?9nu2TdJymJWcbkvxjZSJiFKOlCyZ4wGkkjue0vrrJGL/f3GiNXchDPZc/pgM?=
 =?us-ascii?Q?6SqOnpOFz54C/3Jp3dHJpoUI1yfzht5cMkfgyf3uW+EJIaGDc/xwww3uNgxE?=
 =?us-ascii?Q?d9uV8L21/Pv1cJ4y2OhE5+kyvtd1g2eUHbxEBhnbrxejAaDqTUhEJUO54e7j?=
 =?us-ascii?Q?kVMugRvqocHrkVLUGAV2RsE/T6n2YsntAvhmMfsc8bJL+Ap+OS6B0Pppj0aQ?=
 =?us-ascii?Q?hIhWFJHKYrMsRCk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?77uMo8WIbOkKdWjB6auWa/Vg+dKYZ0SEQJwySTRdHNCh6I+Jo5bkO34+uwCZ?=
 =?us-ascii?Q?NVcSjUbXcqGUTcGAejV/YB5I4l3ZmokiaiVuFZWYmDapp3JUCxWmmZNvlkTj?=
 =?us-ascii?Q?JAJ362jZLR9u624p6WJtArxz+oN6qZis+SbyjZ15Jzuqxw5y2XHuTFUTmVHc?=
 =?us-ascii?Q?fJDGd786m4Q+c9YsvqDWdsieiKaKGhioP9fXWAxzGtvcWBw2mgE/uMP8k2Xr?=
 =?us-ascii?Q?f0D/FndtGVYCAQJ/QK/cAWFUr8lrABzDlGibWBQ+mZM9vnyK0XQu3DOR4xqr?=
 =?us-ascii?Q?fwZd3oRZhIXTzM7cu1ygO1dDOuzx0S8HeMyqxftbpzoOzFxLomSoJ+L8FieL?=
 =?us-ascii?Q?5c1wHInzV2Ms27eqvD9pZ01KYEl6+cztpTExGmOuQetJ0aRYZR+GuKvppcL2?=
 =?us-ascii?Q?NlUcj2/ndtyvbMmhEoE8cvrVeeIGW2kxFKSOctaRwZNQM7ges/+doMDTHj/o?=
 =?us-ascii?Q?nwi5FhxHg5uZc7ySxJlX6Pf/6RasQOc372BUnY7qn0aHNMvIbDNpMKPhlbdm?=
 =?us-ascii?Q?mu1wxT4PqfPTeqK7BJGp7gd/b8+HumQisuztTw+iqK27w5uRoGFCi136ZNW9?=
 =?us-ascii?Q?A1BK0wDpigrz3BqoXCldeL6Z0+g0SMhqJf30S188qcLOuxGHquqUG5PDe9IG?=
 =?us-ascii?Q?RNkBmlig0/t2FOtbWbTo04nacCAfTOIs7HuUew1R1qlvhrWPfuNhsSd2q1dT?=
 =?us-ascii?Q?F7usu1ytPeCuyyh7AfQk9jSNkKis3Aa2fBlCuVh7GAF2SvMYY1Jn9YWwNDNN?=
 =?us-ascii?Q?EsZuKhY8k1gSiANOPo1I7TLKG8pKIzXNHjKmFXD5uY4m3z9gKZAs/jhfkz37?=
 =?us-ascii?Q?Usw6ok3tEdtgohN7l+Rf8Q5Af3NEe77mM6TtS+upVIXIsEbX18yVYev2FLZ7?=
 =?us-ascii?Q?8jLP0l5AkOZ6di0OrXtXHlfgrTvp7H8wQvvALcSJARzK6vVFi7O+zyfDY3ec?=
 =?us-ascii?Q?taFX/jAGFldxu9koKM7zPFBPQZSEeWC6lLrRWddjF+QaKqk8KvHG3DyegYhB?=
 =?us-ascii?Q?6jwbGnzWMs5oG4bbDV8Ga7+KVBG5YQbhiuxfIzK60ubT6ZWuYz6TVAcJwcL0?=
 =?us-ascii?Q?3ugbbvPYAYM3UE778th9pujL0SkKIp+eXefMDh4F91bM+4sNSMjsXPPlY1wN?=
 =?us-ascii?Q?rLDZJkwIq1YSZ82AVDQosb/PvNyY8PhfGWWPlYlQnZHzDt6/2FyJbq92LMtt?=
 =?us-ascii?Q?kXFkuRV4AQanwTku4J7BbXx5FxShrfDKQyaMAyQ0ErKlJ4YKHBePtg1GRvl9?=
 =?us-ascii?Q?S9UpRaCA5UhZBYR6XPZmsXTaeKdAKFTNR9GR5iZcCYcR4WbaYj3CM/1qVPg5?=
 =?us-ascii?Q?cqu++3/HiuN7DdQhRyRlcgmKuX11P6s3hXaIW7BPkCAGlYNSyGFFQYtrNqdr?=
 =?us-ascii?Q?zr9sv+ysM/GE9XvGiBnQgpggcoxPx4jQM9UzXGc1fAu+B9SJD4D+H4NlYDBN?=
 =?us-ascii?Q?uDgtQ7yqvO0Vx28fNzgW5omqiKhk6bhV8DyQFWUBS+vy3FjwZzKiwAzslMeN?=
 =?us-ascii?Q?Bq9GeV4X0GfugUZkkTGOpRfzpBMpE0mlOkU3yg9+Gk1SFROUNhgGhJnHE2Cm?=
 =?us-ascii?Q?IS44akxKRgMS6nmBYYasadqJpaGj2k9DRH0qJ/yc1TYOcq7QdshJqWLJVzfY?=
 =?us-ascii?Q?5Z7yNNo+tl7zE0raOnogcs0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad47bde-10fd-40c2-5df9-08dde003e957
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:16.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fcIuIrf66eW9T5Kt5ICSDU1UVsWxnzLxp3TXe6SAS4m8Yf5+pl+EH7k9BENdNXITd6ko66pj/7Bz+6xGMq60qmWs2th23VzZ004opEyX0zerrRj+IwOBcVavGrlP77s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19902

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ec37ac1ad27a361fe2c4ec61e521f2a347ef311e upstream.

Use the `rzg2l_cru_ip_formats` array in `rzg2l_cru_ip_enum_frame_size()`
to validate the format code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-17-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index a40b0184b955..07859c89be77 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -165,7 +165,7 @@ static int rzg2l_cru_ip_enum_frame_size(struct v4l2_sub=
dev *sd,
 	if (fse->index !=3D 0)
 		return -EINVAL;
=20
-	if (fse->code !=3D MEDIA_BUS_FMT_UYVY8_1X16)
+	if (!rzg2l_cru_ip_code_to_fmt(fse->code))
 		return -EINVAL;
=20
 	fse->min_width =3D RZG2L_CRU_MIN_INPUT_WIDTH;
--=20
2.43.0


