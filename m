Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.300.1795708111635227837
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=tABs6JbF;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.17, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9mJ8zxeYPQXj0qfcL47OBilDN7Gg+1CQF5MQMNGs0NTeiSYSvGGL4fIV22y3JDy96SikFWG1X+kQtj4i5SZ1GHaf+oQSHuOlY2gJEL5HbTHmUMO2CJo5ICY6F+Mv6M7pWRHMs8v3Hzz4drM2xdlpxX4N1Ad+lkCDyB+pPPf1Qnp3lRZEwUynqpreXNza5TkAuncvdeb0sLGK1ji+lu3k6xpv2qoocKiczmZzpaaTMob7gGrSpJsdfiFeR87NwA2iVr3/80haf0RGck6wpMU3H12DbFxZKViszUovJqOXX2wLT1Vg/ueLMrElkZRlDEHokxJ9YME2sGJEQUAzA1wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSf+hYqQx4KtViQs0MYuj62Jt1vQ7TnqwRcpMkuacbY=;
 b=HHCYZefkMmcBDcIvqFdQKLhx/W/bFzpt9ivAYvQ+cy/fs6yHFEtbEHOe/Emm1rTZ/aIzxlXkZdyVSPlUP5XB9MCmrYLfBILhz4z4PNJtYi9J778EQ/p+GKMe+zIQck6bA9LuqUqGRfzbOsdVpzUCDS/VEw7lgq7FZjs3tH0Hd2H43nh7rXoAGRVx8fPboOXdtgBW3KSYPfe2itbSNhfvHQnA7PySVg8bhS8mizbbmmEbeZ0mKDzAU9XPSBXWG70W+j9c623DMq9tpXf+NrzDXNpworbXC+jT4zL3tbglRJxPUo2+cdiCtKV7U7aYkjSm0yiFScOMdbD3MaIk3IYiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSf+hYqQx4KtViQs0MYuj62Jt1vQ7TnqwRcpMkuacbY=;
 b=tABs6JbF/ChR6rRmRbrfH2vq46HltypxI80XJ5k17ZbjAVSBYn2+NMgcdqF8a+GXqPrfrM6Km7FBR8n3AHqSOlLcFz0lJMo3bC1RRDIlIMvYYSw7v8vswc+DwBP6V1NtNT3G+o0Fisxz73D75L3nguvPtY6DQx+5d/akGuUrIkc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:29 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/27] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Thu, 26 Nov 2026 16:47:26 +0100
Message-ID: <20261126154747.3832917-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: d061f654-300b-408e-c86a-08df4bd4b72d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: q/qlfbcdYLGoQ8sySFDQREY9zU8qsJ8qdrb2Dm6BbnyOAo8sqRhZP5hxIpYTYWrzp/i9EUDGRX78xGxVdgfpbX5iIoKEPBm/J5azmPGyiiVGuXArI0GfoSSrLnmfJaBRaLcsML2Qc2524bTZKHCn0WzBUcOwCLa71ah5Mb9g11spFez0s8MwVzKz+UwoCcMVY99+JM5aFZCFnSz4bJ4pZotWd4utVI3kybkMtPhWAyHTw2qZGFaPPkmP73c0cDB5wCCllu/xnNQ7VVKQZRQCxg7ia/5Ppd0A8TLJ8syLzG8KsM8dkic/Cqc1KSW0R3BQQp1S4JLcOyVoCMi3dGI8DtsvFo9nvbUWOCYcfbBoQWdK0ZTart7x2M3EQ0qMdzh7JgHq+9P9VoVffzkbFbL3PbB8R4DsqRF8ToGn3W6w30Aj1ts1nsKEeJ4hdHAZGDpnA2ZcYhbSugwW7jb5zJankheF2EYAKsiLVLwH3CLcv7HbIoqBT+96jmXBZhkevH/YW/HREMSuC0LFxeswnu6O6qSnMtYYSThwS+AZw8p01IKbgPiWzfulVDY/kJPLbRu627n/3EqMgkRcadWQgUrpPc00eJr9EEe7suV5CWZzr0BfjM8MoBCw/CsTBqBvtX1H76Jr1+aWCiyp7l6Pw2zNGRYRilI7Q/hevCbXHXiYSa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmWihMg0fkhMKtjFxS04opkhd5NSKxvCe42lBTL4XyQPWT37uIwMzsuKh7+9?=
 =?us-ascii?Q?mgzIEYU/V+ubnkk6/E8BVrcrtrAdN9w9pGs5bq16IdqpNRkp3TfqP210+CTI?=
 =?us-ascii?Q?1gFnG2oDeroYfPfio4qaB4GwZ+skuUVQKzT/qG3ptj/jQbxs9+VeAIWS2TNS?=
 =?us-ascii?Q?I6BkwGUMQqxcrwPNj5ZEbpK9Y/tYR+Do0c42lmmbT9j3iYJgM96zYR9g8KKk?=
 =?us-ascii?Q?PBklLZUAFYk1anc7E3s9pP/kHXWY009k1vYFxLYyj28guEOWB5tCdm3VqRvk?=
 =?us-ascii?Q?kFas4OOPmUVUjWLYKh5Bxo9+fPIT/laOby6h36cvRl6HuCB5drVFLc905nue?=
 =?us-ascii?Q?pDaYCg5ayVxYn+ksSPQ/alxGhwWZfAaOv56z5mXzB2W8BK6/gcFUig/OwRPI?=
 =?us-ascii?Q?e0dSbH/sZP5cR25GclLHuEv9BdKlH30QpJFD4cuhs16xxNpF4RVLLu4M9o8m?=
 =?us-ascii?Q?Z1xCzo8Zc8zUgrShG20RGwGtZ1VnZB2rut/UdNw1pCSbSjSmsT18BNEtwqm+?=
 =?us-ascii?Q?W9JqM91ZCBuEiGoI5Ld7DM68+lnT/873c9nF6T44Wyc1tjirjvolmHc41ldx?=
 =?us-ascii?Q?DohTx6rEMaKNMS5L9qKiI45FuxiacVXPNeTyKB9/qcby7rKl6SYuIexITlUD?=
 =?us-ascii?Q?QPnw4FDvpW2zjuvIl4C0oigAOxp2cWHbZJPpw1ZlP1xcDqnoidp4uuwYoSYc?=
 =?us-ascii?Q?QQeqrDmkEkj4N7wVw5uJWZ68vyBM/Fq9uEI16Fzgmd+U1u2zP/Y05zukkbt3?=
 =?us-ascii?Q?nNcrsMnDCn0lnciam/2Kv4BSLahk3YtvBMhvFo6JPCnCvAHJEb0pJBd6GNyg?=
 =?us-ascii?Q?31FBpZgUENkUFiJVa/GXgqMsEVG8Nxk55bVHQzrAzy6eU0CKMGAxI5QaUoQJ?=
 =?us-ascii?Q?YIVEfNLklC9v/6YKjUmXXRaeKyYxcP97TU+qEo9RZpInhluzi7jjMeVFbNLi?=
 =?us-ascii?Q?3aT0Jftd3H3faJn/UKc38yhgKBK0IdhGeaRMqMHVWzaKRvR488tO8A7kPR6O?=
 =?us-ascii?Q?QGjDwmA29TX+IwQFpSOvwkMIoTqQmlZvOApnDDt1kVQt8Nzr6pHmmEwa2mmt?=
 =?us-ascii?Q?u3g0cOeD6aW+aem5MVv/hSiaJhimbDwoph7Y/89LTPaBMzGdC1h3z0gZ2C3R?=
 =?us-ascii?Q?XU30V2baNhy7tDFe8ZdD9jojly6SSV+S5kVUzLY+ScC684TOTjMt8YjSGr7o?=
 =?us-ascii?Q?+DDD9J5KF/NLtgVkhXmLMPOBMCOlBSO0W03bBTyhhU9Y5SO+FKW0YUjLhKIP?=
 =?us-ascii?Q?eM+5NRz/3CEPODtfejJf8ml5usx1g6SeveOF24o5I8xOybtHJvWgv5S0bybK?=
 =?us-ascii?Q?EEqgt7YKuSakc/N4jG/vl33TpsFlPj9mQ7m/9RsbKiv+BShNs5Y5hd629KI8?=
 =?us-ascii?Q?Vg9GMneFu/ZDvns+VdFE5bQ+jKWQdVnuoNTglcnQejKzvO9lw+SVUght89z4?=
 =?us-ascii?Q?pj2bjkP4M+bUL7YJ65E6eFnUgXxX51Th2KqEE+vYGF25VXWOmjLKXjECrQzQ?=
 =?us-ascii?Q?Q0F71llytvpDPxjim82GBhqCEqbroRWDIlM1DLKixHv0Btg+ChknxrKsTT/r?=
 =?us-ascii?Q?28buVx8PfKvhbEmtCzMaULYx6YKSDUjeepRayKkTOpIMX+VwSS8iG4SWnjx8?=
 =?us-ascii?Q?8bk5cwux+xIcx2tWaWFW7a12r1klZV3MPEtE7bIW2OXt08ZvKS6RpH9211Nk?=
 =?us-ascii?Q?Uztw+qOxlt35iKl/+rQMDFTz8F+4UO91P0Y3Xm9XbxdHAlbxcSkdeYF14Q7S?=
 =?us-ascii?Q?gqODPeY3arWvFENpR0gauYJtjqlolbOsqR7aXBG10VwGpgh0twxz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d061f654-300b-408e-c86a-08df4bd4b72d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:29.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFSbrdcX2haEL97bY17tUO6TXwYf0XtEq+9OfaIbBaHDTBAGjpntlFHNSsHvjRlPbpBnQhr2Ss3nwLx5Ev0pSV/xdENB/Kkhfvw5exlett+vQwuUjWAwVFQ64FwgwLmA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25156
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit be342fb7f2bb5f641419fef3109eaffd469b0d44 upstream.

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-4-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index dd24908bb2d8..dbc575a943bb 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -695,7 +695,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -707,8 +707,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_=
chan *channel)
 		goto done;
 	}
=20
-	chctrl =3D rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
--=20
2.54.0

