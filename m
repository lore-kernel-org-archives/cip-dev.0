Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.318.1795708135598021946
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hBN1b3qu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IejUFZVkWNN1G5Nf2IdmzE1HWfw0fIqd/zH1OfF6fPwT3Jm4hNlJayV0EKZqtUpAtfuTHRW36B2Hg7UC9CUTKsxQuHyXMO15Dq6WEjSCBV/O29v6EowwATyCxCXjFlAMXHWw6hXd5uS52NWhPF9WjK3LasesiWn1wJIr0ED9WZiQoI/sE9KUgJo9OjylO5rJ4+AQKVw2dm2M1X/2MIn8ZfmdEy7SQQ1enSnFqhiX1NTloZ72+2CAKZOMQhToIC97pwMzBYIjbA5So5bKgbJzweL9lU/JGfo447OZOUIRCidBjs49SZ8DwfM7Q32P6U8L2uDbFa62+U8+uVGKJP2JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4mkUVvNCGQH5SoOtuFRIOkGUhPBX3d0JgnxZLIFO/I=;
 b=IZ1X/HLHdkYDUZVfx830RxOaTGiAKav+6x7K7mkpsawrVTQVC9IV75sMXRR5Vxta/+q3tsa+HSJWn15E0bTVORhZNsYEA7KFAuO6c6P2qH8DwkzlvHGfucS/nDvuNdrHS0hvv85CX3yWBfA3gQFsg3TJjd7QvjssLcDzCxuFpsLsOXXaO6Br5MA4mtNnMz4gExUdrpGMw3UNpUPWpSKPc/6sY76OlWnwpb6NkQMSdZseCmXiuEstGKuyJaq232VAwO5NijbirgpN0GcNncYvDtrjs/mfYy4+WbuqM44mS6rlBm4VbIQhbfEtd9YcRpUlzOX08fgbv7pGdOPIrJvGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4mkUVvNCGQH5SoOtuFRIOkGUhPBX3d0JgnxZLIFO/I=;
 b=hBN1b3quA+DLt8PzdpxeHBbudBmZGWHeGy6X20/9xOlXrvDfTvsPblg9AK4d5ByRDQAUuWznM5dqlX8Ftsdt9KnZxT8DFTLV9ihe9SH+T42nj17G0yFqwEyt1ReG3tUF3OVDIxd6xcil45dxOKnQg/R8fpVpZGXrm61Ho1v4Eyw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:52 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 15/27] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Thu, 26 Nov 2026 16:47:35 +0100
Message-ID: <20261126154747.3832917-16-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: 726f1a34-4878-4c81-7963-08df4bd4c54c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|260925022911599003|260925021311599003|260925021911599003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SRGOiwI7roYC66VctDd5wtz+1wIeQol6zuHi1NaURp+uQUo/Ffg7ELW2O2LetwZizLJIQb3SLyN8V7x3xtX734nIJaaCb9mfyjICNpUSbbccr5uU5BNDWaxaz3RMzB3OAca7KKK6/a03lhBrymLLz/bUXqch6KMfKdCfJcZycRygAN3oFqrQ+op/UMokr4Mrk6hQzPcgapKqGNaWejrQ0+titVAqXYAH5pGhyKcOm/irJywlDoqX2fpk525UwtJtVXU5G/rVr3DC02eHUUenHlwZ8iBAl53O4ZqcXXDbAHUdIK53nej/kV3l6v1WJyhLXo9OWCm7xybU16bcrwrdJp1FHnXgWZZm5Jt817Ee/N4oBHYZeBoOWZzc3dTIeAbOb/U8UI25/MhE36yK+XDms6dK6V/vCaUUuPE42q5oE2SMgHRkTioqHVR7VZl+UR/jnIxiwAAXWT4zho2Lm8klubyGqNOdWXs/Y88wsd3NQVtjSGFRaRgSlkRsCHE0CSsp3vDWBDlSdDsWJEGnCuBaBf655JInr8DLpk+XLrsM9qNdjR0MYPgE6JZvExdmR+csMNPzb9FKtDWkNiPRPam39xkFu4QjH5jpRaSYouRbxzLDOmkl9Y0XK1ZdgSwPWOCQTPTdskb992mKq87Z4olks5NRopXeXs3vmB+25o3ij/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wex+M5YDCN5k+6TAMKp6bWKJ5AaBXdaO+M5iyZyhQDJ9gB/ksoDv2BtMbXjS?=
 =?us-ascii?Q?mdhUhVDiI7PsdXic7ItH9aShNXdQrMNwnJZHjc1+qPkC4o+hiOqmvrk62Dco?=
 =?us-ascii?Q?XFGBdIrgp/gV4sRV1xoHy2QlnKdYld7gqFKl5qBV7JcIfol9j8sv+IzCktne?=
 =?us-ascii?Q?cc8OyygCP/Irbua0B27grGFtiZqISQAnr1TfYDOvm948r18frzmq43GGQdDy?=
 =?us-ascii?Q?tzczpAib8Gm5CcK5qhZ0RmaWZ4bEK76oqhhX6c8jWsYeBgM97HZ/yaa7+uPs?=
 =?us-ascii?Q?Zo3m535FZz1o5VN4D1X/znb1fCci4OLN8aDWdDfR1m9ggNWUejucI8mGYg2a?=
 =?us-ascii?Q?Pe1fz1yNDJAMYAOFD0jgTiqQyrNMXcF0oQ4eo3Es75MqQZQk3l+swQzPn9Zd?=
 =?us-ascii?Q?pjNW+dHrMderaORhZ/bWqEQsefm6JoIFOz3H9FgUv7XO6iLmmyDNMHlrGmCM?=
 =?us-ascii?Q?3nHCk2zwIoU8mCyu6CSDOQzkMaUZKIGCEbC2NyxC4btq4CwyML7kKxF92dtr?=
 =?us-ascii?Q?PICJlObfGvX5DKrJXPO7muu3XTB8c4VtHah6oa+VQmCU3iWME9L7bIb7CAnC?=
 =?us-ascii?Q?99OKrBoXgB1OsFuc6Nh2CE4MMrZqQ6FdnhD7WA65BaqQEYCXKc4zUDnOc/65?=
 =?us-ascii?Q?Eqa2DYWC1i6ufdlWDqob4pMpKGhHZW3e47UflHIDqYX1rZFNTxmf4AWpJKpi?=
 =?us-ascii?Q?cMxc+ReLbLkJ799n4FAnFlW66l2PknNqNb9BZDqxvtATDAxL2QHg/3t8a040?=
 =?us-ascii?Q?fh/BD633r0pteABwqIoYnf1L92KhWLpELruCIz903aTK72R0XiLWPkCxD7So?=
 =?us-ascii?Q?N0nw5bSbEV83Lb6wr6/NOsIMl5o0eBaXn1Gi/iLwmqUkSgZBUzV/9by31Gfs?=
 =?us-ascii?Q?eJgJL/4QGxtoS/kwdPY8VJjt5Jkqbbemwo4NKbd9ddh62Uv36lhdRE8hq4AO?=
 =?us-ascii?Q?SMOYcJR4iUUXFDTLirtEmuDkRcBJoG2m6Q4OhttaZoCr00FoLb0pQmXiGe3V?=
 =?us-ascii?Q?kHW99PyDFmh4MRIxqUuHZZmh6bqpy6+O0Zn9c3LGhl/Hp/HGi0H++yrmz5IU?=
 =?us-ascii?Q?o7FVzVS47qLOmPksO70cCwDpRCjCbZ17yUpMRqs3tSskWffb3vVNhKpt1mHg?=
 =?us-ascii?Q?EjRShnCTYoI5tOqJ91rtY3W6Y0wBxNGEKawI68WwomdNeOaqTBoqgpE5IJBh?=
 =?us-ascii?Q?fw36OWfERJWARWhx/xaP9lOmgySd5SF59twcCsH3mX6LqwsGwJR4RfsyyMpy?=
 =?us-ascii?Q?7njc6bb7dlIOWJ+gm5zyyY9d5ISsqafD9EdG6jpeLYzPtwDBb+IyItsuBos0?=
 =?us-ascii?Q?wGxDcotloOC+yyGZ+tJ6GCw4bQpbK/wUynHZryAhSNeQv1FKjlnmigYjsv6L?=
 =?us-ascii?Q?BC4sQVFqaICOQDIoDep9TA3gbfallnAL8E/yUJwMxW/NC+jNZkTQ0YAy6Nbq?=
 =?us-ascii?Q?XxQDNlt2bC9Ee0AS6744n2l+Z3VziQu7UC2vyhbuy0YT1XpDwRwIN/2vExBi?=
 =?us-ascii?Q?EBgwIVDm/pcZiYIrRQDgmxwTLEfuTyoIPe2jpGuCno4gN8MqSr4/LkuEeX0k?=
 =?us-ascii?Q?Sfk75vDrfxCNB/graZhaBebqXfJU+LqBtaboMY0A5k0vbDljXyYe6I/SV4Nw?=
 =?us-ascii?Q?dimkgcwuJCP4Wn1L/Yfi7P5MA9kihK3l1augxEUY4y7Ky5H4Ufqqtp9VFYmh?=
 =?us-ascii?Q?75A4CcsGlXqJT1wtaY4rnNj9Zfij8Pc2AaTZJpdXdO2iElYAjDuVvuYSh6MQ?=
 =?us-ascii?Q?PNIYKtD2MomKBfX9m70pdJQvdB4v7HsaLXsngAxioaX3SaGkcdj9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726f1a34-4878-4c81-7963-08df4bd4c54c
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:52.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7h/6WtjobPhIDjIpEPJZTZf8ABrvvIccwXjTv2I799eGYvb+rld0WCUJOe+YHFtOSGOYw4ZURoZotxmCxdDYuD50/iEmHvFOyTE4lAkuKEUayb2FwacNu4NcMA4ZYeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25165
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 32a69f1487819766d2084ed32b1350b18f971c10 upstream.

Add a the rz_dmac_lmdesc_addr() helper function to compute the lmdesc
address, to make the code easier to understand. The helper will be used in
subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-6-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 882a8d84219d..196fc5aba6c8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -258,6 +258,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *chann=
el,
  * Descriptors preparation
  */
=20
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmd=
esc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
@@ -283,9 +289,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *chan=
nel)
=20
 	rz_dmac_lmdesc_recycle(channel);
=20
-	nxla =3D channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla =3D rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
--=20
2.54.0

