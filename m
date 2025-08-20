Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFFACA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.32])
 by mx.groups.io with SMTP id smtpd.web10.942.1755705924351286346
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gZNG0uy4;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4Uu+dJ532KHow1R/rPXB0t4JRUH2TzNNqWV4tKKmWJ1V/vXiDQStJe4QDMW0QQnKbTVr66Gd8JQetMhk0ueXlWskXp9k370rzbsCAcenYaWWvZVLoc+9lEeJu6N82fTiXLTLM0fzSWihjkCRy32e8WlVwT0EJtn/XGeU4iwhfvnECr3rk4GO20qbR19tHuh/3CjPLsz0RWCTd49CGOQoXyCBoMB3/wNWoZ054vBb3Ff8MSWgcbTgLhkGeN2N6fmvo0S42OQolBBIvdWN98l9YnEEeoSWV+wB+Vd+t5rOG5HibfDx6rcoqlA0hf5lANBy6SfLtEKxXzDy96ygFECww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4sAhMyvVb6kZhXzQaMnXL28KT4/IjV+KxltFIofH9Q=;
 b=P+DOI1tkeOUY68eKDNF5W7oSIlzz/+uF9CYbGCgAPSLhYQP5fDjSqIgwFcvzWnmKkDjqcYYH2o1o0HyoIni1BYG+uuyI1XnitPlGWR85B9Rxi1km+4KhBFPq/Dod1WTZwws3MWxatTblHfygxPTbn3Xg3VYovNGAdPYPlUcWOfXrhlvBe59gMuCtH5yB0Gyv28XJ6eDErmCf1rgc+8VMZ0uTrgDKwsnH0Gj2aleVkOQZGJ5IOuzxC/UN3e0/Ib7k3VcmwXcBKipT80sYkVHq91jDwNcISU5JE5rYtNQaexgDpARHz1YF2OZTlzMAQGUof2LBBaB78CEL6mbNV6hPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4sAhMyvVb6kZhXzQaMnXL28KT4/IjV+KxltFIofH9Q=;
 b=gZNG0uy4M1PuRDCa++p8vDiBqF2WMBR9vSJC3yneiZv0ZrzfZUvLWEHOggRdvsGVP45hCEP5wQWibzQtUqIyjMb+bK5bLljNKd69v3KJ4o02DlQ1nQ9aRX++G5B3clfKyA0CTEHtxbLQcMpHvvPt4+r3YD2r2ZwYKEXc6QT1XPQ=
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
Subject: [PATCH 6.1.y-cip 15/55] media: rzg2l-cru: Remove unnecessary WARN_ON check in format func
Date: Wed, 20 Aug 2025 18:03:31 +0200
Message-ID: <20250820160413.801341-16-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50e8554e-0073-4947-9add-08dde0035b94
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g03lbJCdN4Si47mhqxwN0uhOIB/xJ/hlWlzL30KEnl28oGVn1eGiKquIj2VG?=
 =?us-ascii?Q?3TX8J3+8X4Y1ln+q7dQfTsHsp/UVIIeYaSoGqeA3SXrQZYqEH8NQ7AjIh14Y?=
 =?us-ascii?Q?q0ePPp00NBpaqOxX42S5TixKPz3iljXGYXacwceDci+9zWZvRZi7Z+mG+4C4?=
 =?us-ascii?Q?JgDEY3LG5aQESk4P4aNdidgw32Zfuzaf9pUwwvsmln2og1kFkeOjvPWkq2Si?=
 =?us-ascii?Q?zmiC9Z0OyMFiTfCuRQkfY2tXe7CHo0WQOW9Cd+t+gLo2yZQ5e4SHnNhoVwa8?=
 =?us-ascii?Q?VnLX0M7YMM4/nFw4QHgQ4wPkKYXF+t9uM9X9crFDAeb1Br1tRmxuMIUpRChE?=
 =?us-ascii?Q?MZGUyRlqHA56r4H0NCY74KWJ3N/J3DNW27lSicFYEPfnoS3V6CjE7FFaZGoK?=
 =?us-ascii?Q?RWgMbNRewtLvv2PpwvYS+Am7hvpRBmZcMmh7pH4402czrQtS3w3a7WtXITmC?=
 =?us-ascii?Q?I9zVvZsm6S+3MUVnUIXc3JL0pJjL3VhPClpPXPHJkvKmnGA5vRo/iPaGBzHu?=
 =?us-ascii?Q?1KcPWfA28XRv+/AnaZ/Lrhfv+Eik5TPZvj28fksj3BB5qSnJtxEGWOGtibYZ?=
 =?us-ascii?Q?jd61hYzlxEniGvNMlf6SPpojTxLZFcRQ6b5U89kQqug4uZQ7ZisoqfSv1ouU?=
 =?us-ascii?Q?nl03Deptp8ASU98tm8SARE4vaUwBQRKZfYlMiSdwF8oPL/qNA5mdVKomlLIv?=
 =?us-ascii?Q?uD79LcEgFZCqN/cvznNb7+DsICwy1TnrjDSJlwzokRCFudg2rzcIE6KxXDJL?=
 =?us-ascii?Q?4tV5idvgsMZIF6noSGJQoon96imifduF9JLTG6C82cT0mMXJuKUXi58VDOzc?=
 =?us-ascii?Q?RVRm6AnX8li7EGqLovZ9k1DLy8De3xF6eZahTC14jlZmz2rERrgs86eRkBwi?=
 =?us-ascii?Q?D4a0AnBSa07yIaVw4PzhwVRoIlzo+XfH7sPVhPRRM2pOl9/cT2AHfijZBSfK?=
 =?us-ascii?Q?HQ6P3WXMrFZ0X4ZJBqjMzhYE4+3LbzAyqJsn2z+XexDT71dCMW8Q5mu+Hvek?=
 =?us-ascii?Q?R/s2iJkNkzRLKyL5uSpqyrIcUHfX2vRGO3hXpeQDeyYqi+p8hRlR9bq+s148?=
 =?us-ascii?Q?3rs4z/t3i4omKQ8CsAl3KeQifL90ZXr660rHO476rjqPvlPQPF8k0g61U1gd?=
 =?us-ascii?Q?vj6WklSEx/3wzBAmrTkMf63Atvi0Xxvdz2d3OwE2ZK6BCDE1C4TyO8Rbokpr?=
 =?us-ascii?Q?+sBK6nJY8suY58rUt+QzJ3A+sY+MDNp/MdLHz4LdgK5TH9GAv+xD080oyJLR?=
 =?us-ascii?Q?V4N/Q5DGeJhvVpOqAXjtC/Q9LoX4KJyW4XjlA93SdVzxoNy7kXndil5Qq012?=
 =?us-ascii?Q?qW5dtltvYn0C7Tf9fBXp0Jxh6BCMypcHRJ7xLl4AsqXU1Px0WMYit2hnisy4?=
 =?us-ascii?Q?cgpW0dmcvjl3x5bYR6+TIJLE9EPKT7yLtMxqAyJ/r3q0O/cuNR2GVMLIUHiy?=
 =?us-ascii?Q?r2/EeVgYXikmAhJClNi+iiGE3IGnyj0XfWRdsbaNgrLvDbNgcIR0QIpq4VKc?=
 =?us-ascii?Q?ZGxsQx705TKuZZo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iSWAsWldtf5xO5Bc/e8ktsSqHl+9WdOAFYWtZwISP6+mf9m6kKvOSGU+a6nY?=
 =?us-ascii?Q?5tA9vOxKJhwK9Sv9kIxMnPIRRoTlBnaD5CgjmJr+8AX4PSfbe5GecWKn9Een?=
 =?us-ascii?Q?epkeOw+WsM8k1pdzS3WXf9cvFV5qnYDV37FFAHFJX4t62z4YShyES9VJclfF?=
 =?us-ascii?Q?O7rF+WaagdXNhQjzwtzSVcyA9gura2PxlIJe655ANCF/xI1f/IMWWL1VQN1J?=
 =?us-ascii?Q?OeAKnv0s5KoEnVXc+VHGegdREmzz625Q5fXzvcUG6pyUr/6evft4B3V7olce?=
 =?us-ascii?Q?ltkkMkNhvXg0P9tho5LzZZqvu8GG5ZR6dvAk4h+jBasTkjQRzTHWZp4giZ7b?=
 =?us-ascii?Q?MOqNmUkuk6whQkX6MDskOFtPGnYjaRDKLlBKqKj4Wrtza54Kzr6AVYvJBEty?=
 =?us-ascii?Q?WQPZE2DNGXUNhrc5S+8eD12b2XsHo+x8G2bmQ/W1sR6nEC/7LNdkXnyDDMJ7?=
 =?us-ascii?Q?YhRrGt544/4cIZUW5oFYwtkhHbRlWQixhYc3iJkzgL8vmhdIZ0Yb1odjN2nq?=
 =?us-ascii?Q?NuV5cxSQKfjsgU5pMTgQ5hjQu3jbrEHxvG9gjNEPqxbvdmtmYuaG/ZGIVDjx?=
 =?us-ascii?Q?zpI1DP6E/7ovwqQ2p8dD5UYRoRhK31xQSul63rOx9Csdjb+eDhiq70fTjiXo?=
 =?us-ascii?Q?tL0dSRBJyjl0d1V/aq9ol5C20WeEWg66SjieW0TiDKzT2s7rRiqYsSqIuUOS?=
 =?us-ascii?Q?RUXB2V70JZVTnE4DlYcsr/RH/B9UYo3nyXAiuqrCUBEAE255GithKGCzc170?=
 =?us-ascii?Q?RqDn/fzZz0kjkrlUMx8rx2SdFMMpmUOeq6nMhMHNdPvMLRNsHAKet85P4xGx?=
 =?us-ascii?Q?cobdrqg+vPIV6HumWrMv889vaP9PsllGU6KdPksg2xua1fUCqwoA6qA3qnHD?=
 =?us-ascii?Q?4pGYH5YIb8FjZJVCovYUKZYMAuApkKaT0qDoMyQRtzXnFHF9qJ5KZTRucU/j?=
 =?us-ascii?Q?YTdK+kupFt7si4YpfeBIZQL8CZGegcenf1l192Tpj64j9yd/rT6Yr/9kHqPq?=
 =?us-ascii?Q?V5CtiLH+Fq6dAsSZS+o7xS26txvTs62wt6+20i6cjm6GuvYYKbJLMu+D2SYS?=
 =?us-ascii?Q?DM5A36JAC2aa6YQPAsa/DEDW9OgdggZwmw1ObLNz7fcW54HoJqshGMrdPbhk?=
 =?us-ascii?Q?nPHUORlQyI3AoWcZqc3deRvKXDD4uHR8s2qWVPAfHTBxtfWt0bLFq9ovdWXW?=
 =?us-ascii?Q?qES90CRF1XW9COu9UhPG0uUVnXfmyJMUXekgupT1SbxSVZDoWBoCIzbWwl5x?=
 =?us-ascii?Q?j3tA7FA+NgzGwjh7xo9gACqQoLWj4/JvdFcb9S8jY2LwsyXGZA3R+xfWYjJR?=
 =?us-ascii?Q?l/g+NWoaSSy+BuqFLGeUq+uoFjEcV1MMWRT171veneYVkazqfMbOEgTbXK4X?=
 =?us-ascii?Q?X7duF2g6jlp15kNUR7cskSi4FV4Toi/Ex+i3H9eu0rqorX5nZPjSd/YtlbAy?=
 =?us-ascii?Q?T1bLNWF2+jTYv7e2b51YW3SPZ65t0cMAJx8XGQtg4gwVnajGHlMzGpghyRe+?=
 =?us-ascii?Q?8j4uakwI3K56UsXWh+9bwTtiQNw5p01XmALOx3FDm3APTOAd/kgmECgxQuQE?=
 =?us-ascii?Q?0/0J0eBoiYbI6aTAjSu4pDUUPTMRN45eLH9n3ReIgqxnK1WKYyj5+xblorhW?=
 =?us-ascii?Q?I7ySwya8t6r9OPokzfZaosk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e8554e-0073-4947-9add-08dde0035b94
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:18.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfNagsTj7HNVo3G5UZaQ+nb/fEI5pyMkJl7HYwrIjdMfOYtqI3T2MHZUaTUDBoANWS0KexUbRM/vCOlUP7PCOVW5PNtZfTnFYWCrxbWcMtVnwfj5WzrwUfmQ78Gvudtx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19841

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0e575e4eb6574f8530b22e8efa6419836cf1ca0d upstream.

`WARN_ON(!fmt)` check in `rzg2l_cru_format_bytesperline()` is unnecessary
because the `rzg2l_cru_format_align()` function ensures that a valid
`pixelformat` is set before calling `rzg2l_cru_format_bytesperline()`. As
a result, `rzg2l_cru_format_from_pixel()` is guaranteed to return a
non-NULL value, making the check redundant.

Additionally, the return type of `rzg2l_cru_format_bytesperline()` is
`u32`, but the code returned `-EINVAL`, a negative value. This mismatch is
now resolved by removing the invalid error return path.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-11-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 37a81dcebb32..4498c0ed7773 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -835,9 +835,6 @@ static u32 rzg2l_cru_format_bytesperline(struct v4l2_pi=
x_format *pix)
=20
 	fmt =3D rzg2l_cru_format_from_pixel(pix->pixelformat);
=20
-	if (WARN_ON(!fmt))
-		return -EINVAL;
-
 	return pix->width * fmt->bpp[0];
 }
=20
--=20
2.43.0


