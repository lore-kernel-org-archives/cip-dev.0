Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA3FCA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:23 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.20])
 by mx.groups.io with SMTP id smtpd.web11.891.1755705922345479249
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lZxNAcIS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kvg2VSdhIRpIeFm+CZmWfOrDKAXsQkhrnC3si+sTdguSlKbK6VvBdeIn8+lXvH16TYyMWjXHqdNVeqz9/7HYLHcszgqg1NzC3Y+81BuKwizc5YD22RlvPPz2qfA84yKx66s98nVG3EwDTDa2QlYvnLbxLod6GpfcPAgM2OoRS3d7h3wf5QWEMNwyJwI+Lo7OxS2TKH3yeaqQmdSYM9sNtM0zgt21CnO3NEjy5BQlXl+NI1NE+TN57zEhaZ4cWrUshOBJI2I/Tnt5HAVd+HoG9OnL1jcK4nuve5lr2YxM+wVmNk8VJxcuK+SHuh7wkLCKvSg/GU7i668Zx0lgaIhTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbfBRvtVyFf9SE9mBtCZqnK2NTvQm3VYHQOEUpWCl/k=;
 b=ul1YdbrFkiEyv6zD+jRT4HGw/1IAMWDeaQscBZCo7yRNMKIPr7NkHaqB7t+ZmimvIg2mQYwKqDKJ36BNX2WXhnD62AtZWy4qhA661oe9cZEuZsQVTs9Y5bpqHwPT4ZpgXxbhdiqH2Gksp+LZULjgReoQmQE9ccC+Fh4fo9VL0Vg9we9loXkbYMMOLwCIFyQT8cVSAAxWgiN5UEWFv/olqcfMB+ZSQeC27p2eFroffdw3hMI4Njr15uQF2PA6qBx5x+MciPXnfdeYzAaqlJX//sYD57MGveUhKVLQMYHZpua9B5dtSM8zCVPHDV0+KwBVmoNClpzJwC1dJFKQ1vLuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbfBRvtVyFf9SE9mBtCZqnK2NTvQm3VYHQOEUpWCl/k=;
 b=lZxNAcISwY8LTJQtHXfOI4lIe2Z/01AFIO0r4oxEqfoUz+yU0SE7vDBLirt5fmDFSKniItUE1EgnxVuO5YWto/Awaknbyc5OyXqf/Vh0Ox8WCvXc3/ZUgKf7UU4N5aSM8l+fzYMEaYsjgFNtmGkDA8uveXY18NOhscd4MnZquSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:20 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 14/55] media: rzg2l-cru: Remove unused fields from rzg2l_cru_ip_format struct
Date: Wed, 20 Aug 2025 18:03:30 +0200
Message-ID: <20250820160413.801341-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ea8960-f2e7-4cf8-a075-08dde0035a2e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e10uFlwj8rnhUaNXP6B0x/tdAJHq9pBOGN/FhPTg4EeS/f0kJH5YotuWxHK4?=
 =?us-ascii?Q?p2DiC7mbcHdaT8cDAxc9G3ktSzpUWY5VIQV5JJ92+23fE520bxzPotQmOA4s?=
 =?us-ascii?Q?TS5vUmRagAQlDOJa9SbBNml3FHdaGefldsoTvySZ5ZklQjIKE1lCMY1cdlsn?=
 =?us-ascii?Q?T+hhwkK/+DL+DY4+dAn4wdX1Q31BcLsApsKjVbt9rNzh24kAvu42cEpIu46T?=
 =?us-ascii?Q?trcXoiJrVk4qyDNBR4b2Est/FuMwwoRx/uKqibsXwShLLjkMz4+2O9bnm/El?=
 =?us-ascii?Q?9w/tD0lTPgO58jO1l4/3rH3nXsgHB6KM4+n7MHFGPf3SFIjWyBykoAKmTVKl?=
 =?us-ascii?Q?qprjHu3t03utkfeomeFk95iFZHAwxi4X5bzRhpwK4fn9w3RtGmVpC8cJI8Ch?=
 =?us-ascii?Q?lsd4n3aAba7go9K/Ufad6Glepq26du6tmeHNfCBbzWdsPu3HaqHlTJ+Fp+T5?=
 =?us-ascii?Q?L/XnO1PMI84ShKTyWwD4A5nzhUEFYSSq5iyG1Hi2WAxwYmrY3JwnvMVQ4JHH?=
 =?us-ascii?Q?kCRFj4Tufn6/FySBi9Z6CI1yFNCBr+G8Nv+IcdHrcrrjnAfrf/fElOaaqFWe?=
 =?us-ascii?Q?iBRyQWhQ8ZWBv2vrPB3CmnevTX6SNapksyBzF3C6Y5tD1+CPju4Z/LQEeZh7?=
 =?us-ascii?Q?N4tTLD2VVkCBH/Ig9gkg8Qal+ujzK5zp8YeX1u7g5taQaoLA3YEelZ1ZShbP?=
 =?us-ascii?Q?Sc7jK5i+7Few3GHp8bHlOe2DVbCbn3al+3nRH7zojbNuhXKxmGeCwz4efKtd?=
 =?us-ascii?Q?1MpMCmYsh6r9vd4ohaXvzwvLYeJYnqIgenUInH0CbiGgkPQ9WhBzxkt2rxUX?=
 =?us-ascii?Q?uJ4+8FGSF+n0DNRR3ZmPUceBhBVv/fGKl7aDSX0hJw4puINQVk5mrRfTx0mL?=
 =?us-ascii?Q?XswhD6Rw+NXQIi0RxPsi8GIRQix7ILER+2fblijwZMhejqip5hiMZLLd3svZ?=
 =?us-ascii?Q?4XJi1tF4HKBfAB6Yi1xoB4pW/nm0Wovoj5mAnAhh3jl+4UGCQfMjVYXIcPyv?=
 =?us-ascii?Q?jqYU/qbddx/FHHSpbKqhfIJJKToNqMNY+v4g2G3tjcC697Zea7kdjVzQxWdH?=
 =?us-ascii?Q?ti/TAJaUxqM++ualq6pPWu3D+urLljWOHDjAJINYQ+0Z14NrfxSt6RQpe2vZ?=
 =?us-ascii?Q?JK3dzFrikVyl9y8+RtERlPVrb2IzrJDsCnVIILSQ4ZFeE8YnKVdtkVW4xCM8?=
 =?us-ascii?Q?ORlTBWYhmCozjfjCDUQ1Q1VJST3WIqnCkPMbqrtatiNQpwRONQA2AF/iqvNO?=
 =?us-ascii?Q?kTIbylpk0FtVxXoMZKIbQ08lQHpLI2mfIfopmY1JQcISaVFfiquc13jfM4Rr?=
 =?us-ascii?Q?LXSyopVEJanvwwvATdtbxr0Ql0AguA4HFpWc6QP8PuQKkvCcmOIvQJSWJilN?=
 =?us-ascii?Q?KV68ipW8rm/laZrkPyG8u/FhSkF0AUoHBhdkzq5da+g6HUEy1cmrcl2DHGju?=
 =?us-ascii?Q?q+VwAbmriWKfzSFKNbnmJNbFAW5PPeI9fuOW/Y69WpFBhWAC6bYXDKcnW2sx?=
 =?us-ascii?Q?s2Yed8Vv6bssJts=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?80ocN8arIXtVZpKIKJiSy4VCOZGC31vMD25fnguaPiRHYs76DMoVNR48Mkf4?=
 =?us-ascii?Q?8pxg1Dp0sCifiF20CUhfXKGTIxKGuh03trD6LMdrvhCZ7lOfclUBtA0XP1Ty?=
 =?us-ascii?Q?miPZHp/DF2EpUEA0ZQNk9PDuHka1Fok+pDsRHhDCfFLKevtM+ugvbuqh5iIX?=
 =?us-ascii?Q?uo1K9xsGrAtgSWdXO4hi2pJZuorXtDdACgxSR2YnYdgbH8lppAejomNtUBxB?=
 =?us-ascii?Q?r+yxzd05dDHzNnZJUskvwS6dw98vjXkcHK5I+yMlvON8y4tUAwgU5iLTVlCq?=
 =?us-ascii?Q?806DolYnll7PwAEzlEujSxjwQ3RUhk16XMnFcW8O0Vkx3FGUQCrR1qdCuNc0?=
 =?us-ascii?Q?NmDUBOJq8YanSMkU4J3R2DFQUSb7EW8O0nEzLTo4/KU1n7FL9Yi42l/3y9me?=
 =?us-ascii?Q?rmCZYV97Vw3dIQV5Asrl4LuIeg66naD7/+u/3kr3s4oYO09gIYJE3DKMAnBP?=
 =?us-ascii?Q?ZSCs/WYxHGIEUeMgxO69Mh+5fFJ59STWUkUc2+4jaL8RHi/tMMI3jrcHeF0g?=
 =?us-ascii?Q?8H+Lr8Z1abTpmPDoWxrrYzhAyLtI4yNqCQMb+999ac9gdCkJMkl6h2nf+vNH?=
 =?us-ascii?Q?Cu+V97CgLhHG2nLkLb+CJMZed8Vys83VqTtEL1Ukw1eYsYUgo9R9BSXMYuH+?=
 =?us-ascii?Q?D+iwRPa2q1qWCtBHy4twP90UrMKqwLlNuchz2Hr1NyuPekhL6O2F1s1YEpWM?=
 =?us-ascii?Q?3XDV/Qp0tKEKatlNts+EGsLSvGMmazB9ALp2cwZENNmISFSoxNyCSvsc5g9F?=
 =?us-ascii?Q?a/O12E9gmL+aZ2TGLx07yxDA2xThKihCBNJZyiw7GS5ZHVR07quXMXRNhOoG?=
 =?us-ascii?Q?jPs0/CKAhv9pIAQ+OW5bXLx9ClpXSj+3yJRl+DKXzSHOumLIUdOHiQxyYi8Z?=
 =?us-ascii?Q?20bKINmo/9W8g/bxs2rvy2ZyoJ4Cz8DSbLk71979FrkPYeAC3hx2WvXkzub9?=
 =?us-ascii?Q?ksse49S4V+Ofs0dCbZ1xPesonGccV+CeMKO8ZoctR81ZErKhF30BqkAMr5QG?=
 =?us-ascii?Q?Fn/+XOzwEi9la/m4+Xdy3AcJ+AoB1+oyAKtPCgQsR+tTdAWUi8m9pXkTM667?=
 =?us-ascii?Q?cvKe3DSqJi1+0eXYjYSIj+HhKhK49DiPS2GBvNgm4b9ELcn61foZoVOvPJjb?=
 =?us-ascii?Q?SmfMwyqLJWVAvW4MvKYAiO+KcOXf8/aevV8fsnTxAlhqFsyK/tssg6Uiu0Hn?=
 =?us-ascii?Q?ScqnUclgDDLNgx3PRinhb/criaIQiJX8QAfJ0b+TKWEQcM9C5o/z1+814v6X?=
 =?us-ascii?Q?J41veqHHRe6jVz2D3RY2s6uPmu2e/rU1sKOfIsVfmRq4rdiVEmHhR6jBw3S4?=
 =?us-ascii?Q?U5OcbzB28wv/WwVXDt6vsh6Tso7FtZ9mc4jVoE8lIu3B3jl6q+2mUwb2cfbg?=
 =?us-ascii?Q?PzLONb3dJxRjvAAlSck95ziuqMqhMIKlzp8Lv1eh4j6dKrf8svCUpGtNHGTX?=
 =?us-ascii?Q?PguUQ4XeLs8kgWo5vEbiQ5MovXxsyFCootr5iZhRaCkNtUa1C9ofTlbYJTdL?=
 =?us-ascii?Q?SA73Kl5libQpD+qUw0Ui0xoSYJucvq9nJ7GVKKP+kuEzpi5ipup2VSgWCBZW?=
 =?us-ascii?Q?wby26PEwyAAOOiDt1rBUwOxyTH6HlYNh+50eJr3SdAmNnrvq+5E9EvWgxo1U?=
 =?us-ascii?Q?HMeIqzFtBu+RPja3DvClK2U=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ea8960-f2e7-4cf8-a075-08dde0035a2e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:15.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxUbI7KIceKwZFf/8+QCaG26tcaNxeoIWlniacJHjFqkVz1dv8jo/yC7mOhLJA2xdeMT363p46ro0OwnngoKRralXVLGAo1nJFKrgT5s3L15qvqjHKhipwA11Io+ebRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19839

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 40516958d7ec1b3b92d6db879d959eedb8205a4c upstream.

Simplified the `rzg2l_cru_ip_format` struct by removing the unused
`datatype` and `bpp` fields from the structure in `rzg2l-ip.c`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-10-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 0edf005418e5..800e6258e627 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -10,12 +10,10 @@
=20
 struct rzg2l_cru_ip_format {
 	u32 code;
-	unsigned int datatype;
-	unsigned int bpp;
 };
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
+	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, },
 };
=20
 static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
--=20
2.43.0


