Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.297.1795708098926381266
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZuzzfVFp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.24, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD4qoZq9TMBPZg1S8e15e1LMilFtE0JQgpWnlHXEPmwxwjNs+YvkbECm9mUzvS8mvkPoV1ET9EKhpVoVXFM7L1jyjQtmLNQAmwb4Q5vUNgFyhi8ZMyJbN/9GcsAVrwMhBXyXhIpWTTnUSp9KommshVuW5FpcdNacNIJ5uSVF70Ha0XtHTlhJQH7DfUEHJzWGHCuXyCG1ImJl4N8RHXxHzzvo2t4wK4lJWAVyLksE1eTIoNbYKgYu5JlZQINKOIfpmeNqpPOCRkL9IWUrbKgm69I2TIZEr9mvnOFpCPgJQ3yqy6ls0xhjGhwHMZz0MuX0iSkp/uJGpo/F33yVCdrCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HsCv38IXqeHPbIE+jJbJVm23wXloU2ZDva3A5dV3uU=;
 b=sJMD81xtNTvSlE0qm0WD56hnmT2m3imcyIUyqWMg7JV7qOhyc8iGCj+lIPvZ2UlhJNOsDzQfNhEe+/QIq8UyG86QNt3fSrer/d175ZuQRf8CHUqbRi6BuGU9eXHlAbZv8+ihGqQP+F00EcYVK1NOpICV8415+0yU/qoXpNtl7WBI6We/KX/y3cpAiCApTtWOQRQZKJ29RpeJwhjB9qIhFIG+y6urNdlE37NRERCCKHlJHGlfxfY00q2exsWz7Bzcsl4wtnfDR16UFCYAM9U+weyjV4d7au5clOX5eqIIDCPjclTAbXJLZ/aB5zHX30LjojFK+7Z+LMd/bUij0ViBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HsCv38IXqeHPbIE+jJbJVm23wXloU2ZDva3A5dV3uU=;
 b=ZuzzfVFpq+TCkKGkDJHO8tlnSEK8pR1I/RyQQeoUq6WCPgSbG/pf34hPad83hrBYABBm/Bgsgg7pEWZqQIlzKQbG35xDSaxj2satekLWf6IVVusykXwbPZfTR4VpJUiOK4b2H/5wnKsam2p9dLy8fakHtkFlRTDTEyOLiqxafdc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:18 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/27] dmaengine: sh: rz-dmac: Avoid format-overflow warning
Date: Thu, 26 Nov 2026 16:47:22 +0100
Message-ID: <20261126154747.3832917-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f4d9d6b-1629-472b-18fa-08df4bd4b0a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|260925022911599003|260925021311599003|260925021911599003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: i9rqs+mW3RDYSmn8PodL+KQDOuRstJoXXSSnD+yjRIGnbtiaNrKSNlXVEek9EIY6z0YjfT5qtTp8rXebZs9PSorqDljoQmbFVJriwaKa8DRrRJolVo09n+Ym/Zc+9QtxWOoY7Vidcw9Qrchxja12WyL5Ku7C7cZ3d8CQ2qW7gBr5gnBw/8S7Jktx5Bq3X6BkewvzlPu6sjiWyoJg0L9Q3HMfRrHidLvy31qAPh5DBP5KkhGm8DB/aEpcL+jdiHbcYvdpOWIWtXsPo/FWxDikmQSs2y10JSFbkkl1IzotWcb3/DGLOymDoIa1SP+W5ZYLi9Wk0rDe8idHE5wMV8dXOus5nIpyt5vWbUseb0y7AnocvLcOK7zsrxCLTBx2k+LuP6kAwfZyn/s6U4RDpAc45+/jhEoCVlNFaATuNDPss4XhgrHLD2cH0Y20EXdmRVuPW9Jn13LzjXqQWVN7Y4ypA6VE20wPjIQMyRJ5hYHuDvf4/SP5XiDY3TeNJEabmJtLlFBQYxQNqkx2jeiHsbZwVrNNQP6qSpLTkJxj0HvFijtGMUcKZ6Gh90vEXAgA2yFFgIX59b8h3ICFnHeeLhVCcPBhrDupuYnEeOO4tC67MacLpf6J0YG7Fw3iivEDXFE5T+s13k+qgHLuOPKKwB5f4BIFm6G7/vLYxzEb7uIj76o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CeJPMf+8ugSL9KzTTZENf2Aql4s8WSsJR4iFYJGNurnGQohnz4ckz2Onn5q?=
 =?us-ascii?Q?/cKANN90DP7eLcg1PbD9jLZHeY5MqHyg+mCGQ93/3FjZpe/FgN+6+jBZhzNB?=
 =?us-ascii?Q?LggyE6MGgyg5s9imuLAZdUZ1FplJIkIaoQpB5p0LuLGQfdVbvOLRq5GNM0gN?=
 =?us-ascii?Q?fh7PiGe/VyoeQKtXlG4VROC9owl7XdMX5crrGs+rCTt0pSvT5o/vMom4Y1PD?=
 =?us-ascii?Q?cL5XFal0TgMPclkofoUoG/RWwdjMlrz38WMNg9YYfROVFht4tGPhXddxWGyK?=
 =?us-ascii?Q?ItSVYdDimHVUBjYPuMhB88fE3XrlNBbXsorijy0fDxbWlsIYecHD3DvFIKNV?=
 =?us-ascii?Q?VHoJ6EykkDaVSOD65fgIHFHo+aUcfoQ4/1NkkqElpmsB9avFYqky7GlXKUt7?=
 =?us-ascii?Q?+BZyw/oAXeUFdeZ6fI+g8zkoC9d+FD6YrQQdjV8CjljBf4vUavaRYY4mMmje?=
 =?us-ascii?Q?f0jN6ENNkHfHwaw1BseRk+7hO3ADGHzlHEPTlVdA5yxWD4NveHSfB67MAOR1?=
 =?us-ascii?Q?BQfDPZN/9KhJ6gyIfBImCaHMACBmslokQLbwP9j0povStsFORC/V3DGqsRvJ?=
 =?us-ascii?Q?vpsqjFhEDw92t4iYyzZ/A/lFsjrrh2XaWsf82DstwKwO1pu3bHU8wlYQg0ck?=
 =?us-ascii?Q?wUUV+Keq+iyuoPxSW8y6hmZMJaDp7T8eTVPBx+Zsh1SRh0MhpI1C+o5MdkZG?=
 =?us-ascii?Q?MfCQJ5KXcsciBMKzUXdc0HG5yMHoTH6PM6+YTTZGP153ctdaPqGnwyaDg8He?=
 =?us-ascii?Q?IwmyqvgdvKMnUQMYoCMBkA/ykLHJxgBQVfZ+wGxN+gseZv9PyeWGO45l5ffo?=
 =?us-ascii?Q?lDs8OY4z+ENbnQmF0LfM8qn5J+FH2pQ+K45UN7O+YvZvgjZuwxr0Vx2IzH57?=
 =?us-ascii?Q?qt2//jRxqPfSkhMkgg9uGWeqP3Rz2S2Ke7X2BYfD8lSYtHG7oPFv0rBwaP3j?=
 =?us-ascii?Q?BNRPFi/KSaQJmOl4+/a/+HFKGIVqHbqLn+Gp/6l8+XIsqZbvSOjI8Opp9w4x?=
 =?us-ascii?Q?AXzTFo1lszXGOxXZ+u6UQLc6ZzUy7NTs82dWg2mzyD0HksTMk9oVfjViBgQ4?=
 =?us-ascii?Q?z9xPVNxL7cXneMatTr/UQKpYqbiZr0/XrUaQ66D38GmaVfyHVOQmn3xv1Bzo?=
 =?us-ascii?Q?9eyM7bR15+yA0SEjoKaQJh3+6L8div43a40PU4yDxXyLy6cN2KxlJDP8Iuxg?=
 =?us-ascii?Q?aIYHy1SILLtElRn0AidIhzS3RTWXF3eziUJIm0nvjvJdX45i6mvY7jBryuSv?=
 =?us-ascii?Q?mteAU5Q0UikHayreySLNwfF5j9X2BRUYHdN+C4AVYJkkp+olrW9kmZxoeFU0?=
 =?us-ascii?Q?+f4V78+jMjcEWufhIgYOsLPgcwd6YmKf76WqBK6kszO26REpn5jatJIF7bjv?=
 =?us-ascii?Q?+ojUfLntNW13GtfO7MCZNYNPbdtVoHtag07CrghJtOrVyxkaIlAAcR+r1/Au?=
 =?us-ascii?Q?CgMLHxKaDDF7/3QvSRkkOdfDMGFTpwr2PfkkrMav8dgHb0GOTjnRvwd2v382?=
 =?us-ascii?Q?DzQvQ/gzHgHUIJo+nWzUIMl1vyvfY16rWmvCat5Wxdpt/9io5m4tBc2AQw5a?=
 =?us-ascii?Q?R8DbBVM3rJLGYIvRpF4W1loOFEpTnEZrKZnoEGo3kDx5rQJL0m+Yv5WwAcMT?=
 =?us-ascii?Q?qV6KZ/qFCJBnvR5nj/lSUyH+r1DSp/3m/HqT9ad9N8P4btZ/19ICX18/RVKp?=
 =?us-ascii?Q?j4iBedoWON5JZlzw5Yv7b03HZGecMrryXqhJn869Qv5Yru2+W7xzyrExrA0r?=
 =?us-ascii?Q?h7tQofnij9puuxah3BRO3KdNG2Jue61qe0fiY0W6mbN/WIxm2F2X?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d9d6b-1629-472b-18fa-08df4bd4b0a5
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:18.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nI6UiqKOGAK9fvIxV+bndPDt0EJkh0mV1LIi3XP0Sd8jY+GlBxRVuouCCSHla1yeJQWMyMh1mlcfPrb+uDW++c8fjO9EpxXFSF79C4ycN04VctQY0bRHSkquITLI1i1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25152

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c4d6dcb3b6250ea546a952ad33382daf7cd32425 upstream.

The max channel count for RZ DMAC is 16, hence use u8 instead of unsigned
int and make the pdev_irqname string long enough to avoid the warning.

This fixes the below issue:
drivers/dma/sh/rz-dmac.c: In function =E2=80=98rz_dmac_probe=E2=80=99:
drivers/dma/sh/rz-dmac.c:770:34: warning: =E2=80=98%u=E2=80=99 directive wr=
iting between 1 and 10 bytes into a region of size 3 [-Wformat-overflow=3D]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                                  ^~
In function =E2=80=98rz_dmac_chan_probe=E2=80=99,
    inlined from =E2=80=98rz_dmac_probe=E2=80=99 at drivers/dma/sh/rz-dmac.=
c:910:9:
drivers/dma/sh/rz-dmac.c:770:31: note: directive argument in the range [0, =
4294967294]
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |                               ^~~~~~
drivers/dma/sh/rz-dmac.c:770:9: note: =E2=80=98sprintf=E2=80=99 output betw=
een 4 and 13 bytes into a destination of size 5
  770 |         sprintf(pdev_irqname, "ch%u", index);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While at it use scnprintf() instead of sprintf() to make the code
more robust.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240110222717.193719-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index aec3abf49185..8bde48cce20a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -800,11 +800,11 @@ static struct dma_chan *rz_dmac_of_xlate(struct of_ph=
andle_args *dma_spec,
=20
 static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 			      struct rz_dmac_chan *channel,
-			      unsigned int index)
+			      u8 index)
 {
 	struct platform_device *pdev =3D to_platform_device(dmac->dev);
 	struct rz_lmdesc *lmdesc;
-	char pdev_irqname[5];
+	char pdev_irqname[6];
 	char *irqname;
 	int ret;
=20
@@ -842,7 +842,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	INIT_LIST_HEAD(&channel->ld_active);
=20
 	/* Request the channel interrupt. */
-	sprintf(pdev_irqname, "ch%u", index);
+	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	channel->irq =3D platform_get_irq_byname(pdev, pdev_irqname);
 	if (channel->irq < 0)
 		return channel->irq;
@@ -930,9 +930,9 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	const char *irqname =3D "error";
 	struct dma_device *engine;
 	struct rz_dmac *dmac;
-	unsigned int i;
 	int ret;
 	int irq;
+	u8 i;
=20
 	dmac =3D devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
 	if (!dmac)
--=20
2.54.0

