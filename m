Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.496.1795708627465008110
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:57:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=a12vBswv;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QK0TvEZdMxmZvc7j5BrZIk6MPm+FxsTnlZCubahhDV0DoP64f/SduOQgSfm5QgqD/wgrbc0xfqqY1DpAmmCTlQAoLbDAVlKUu1hvJKlXLDpt1D24WNyEx4Nugy67vX837/+7bcrPNVrYI3QB9kQTnr6JhHOP3leE+FU5eKxb/6ML/ODGXFJ7bPcBMSC+3whD/F85STUX0zROMJeDLbKTB//beBumgykdTMIciUcSPTX7E5NCpfztuceQPmvV1/Z7gFGyR4GbWb0iMDl7/DRKDWZsdVLHH0iCCh7Y+Gl0AAcCulZE2TrgGyx3vjWA+wnPoLNtC+A1r6yy86C0ksdXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ/3rEuNq0VahVYp1aBljpXDb6YDdrHItHrQ4DAsGS0=;
 b=t2t5jZQ3v39s+gnBeViwVj9dt9cECw3fKC6x6nJEG1rUhMmAXuLea8rTyAhUcLJV1B5qJ6GR5gxfZybvoRQhYY5sYpZgKmWyI1G/NM5HWYHVVpk7dKadJWumn+OhJatzTnjhWGbuKm5jcYNCusooVvG7LpRgSZYNziWo443TEaNQuy64/zQulFBJtjj/Dlkox9YoBfg8cJs4az5ZGIN4d9PHQs65WvmcoP7JSQWjrYzi1Kc3qmG9X50EACl2xnvvew4mwogA+2GiD/AHQgKzCa8B7Z78iRnmYYEEwacAw0GJUD/W+IWkcQps6G6VvWWHlMzsMqGieYsN5myOzSgf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ/3rEuNq0VahVYp1aBljpXDb6YDdrHItHrQ4DAsGS0=;
 b=a12vBswvjSZrD5owxHYgvwii8+g2GXaRfw5RWW9XjrhoARetz6NbU/zpJUAszZfjvvsO9UNjWXHEo+qXaqFPKhihW6/gz4joGcf58LGDBqU3xj2vp+rR70R0Auucwg89mBjIFx+CHM4cpWXl88EmTyn2IboqGDsEwT5Wr03aqtM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:57:05 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:57:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 22/23] dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last descriptor
Date: Thu, 26 Nov 2026 16:55:44 +0100
Message-ID: <20261126155545.3834937-23-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: c50640a8-c3ba-411a-18bb-08df4bd5eae4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261026135527099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021133027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: 6P4ZidAH02jLyRMyVwiqA13ShtpGnLhP+m0of27jxMOPiRft4vylLmC9AI0xWywBCmhts65tMnwK8dgq9T85bXwNV5dQKsDosqnM/I4VS4s2vZU+TMMw5yAee7dPAogdlhFirl/ID0h7TN4BdYy+pmIetAT7FkfF+21UslW/u5u+grWwDTtE03LvuaUj9eRcyaRCURFctB+9N0O99I3s3LgTAwQK3X2OG5iZMaFRxpwA6eLiSfI7LtlvcMdy9LuXTEx509ebWWZvb2VtJP5Lyr8NBS8BjsXSrRQ+2PQs8ontbCs/cGELZJqDH/Z3sZAKc9PHdd51NQrnx50X/r6XYmCwveEBhNTyTTxThIR3YCRKHeCe8szER0irh6KoFfZLUU8nHgzFMCEFiabTsZfKuYnKdJu31ulCKdGRTgJP26meao79ya6KHEsKRZ6q5aobC9nEz4C/f36bxCDzvyjkSob9U5bk1XC/LVxnh5zukEJTF4f1pEu1AjXE7Om4xYik42DTQGGZC3yNjqXfQ4SA41bQVIdNv8Ea4kgAhI2WI/qMpec9wj0/ZNM8/YhgdvazhDqvWlSa5pShGBMtE2PIpfqyF8cJlU+seCYaqqJfKgrO5QLPA+IDGu4z06uDidf8CPUmYpKQDseRjr2X4ph9i6Ti9KMyuacvE5W1rqD8O9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261026135527099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021133027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDKPs3lX92KU7Wyye00ZKmVqq6GI7Ci5p3OKAS4DfUx6DxgiOmXpJYmdLLOA?=
 =?us-ascii?Q?kz75XJ8DJpfxg5HrTrWCt68rBbpGptQv5G1jfUtuFT14g0tGF3wheefKplqr?=
 =?us-ascii?Q?1N+T7pXNYTMPRJQ1zAP96xtrNSOk+3WQWH6tTxQl/BTg1HKVrqgx/tR+5y1Y?=
 =?us-ascii?Q?swWjVldNO4FUMm24q2TN+DWKxAGdjWr+Jzj6tLy14wLdCOzpV7d1DhdX1MT3?=
 =?us-ascii?Q?bQv8p8vZAoLjIZEqS75yAn8uK3Patp0JPHuLb47/1rcSYDKZGo7vq5I3Iydu?=
 =?us-ascii?Q?aYqsoYWWv5cbwB/wCOcZEqjF1EFLE/lplZGbe0+O2OkBYBIR0GcDmC/DQO93?=
 =?us-ascii?Q?FWDuery/bPf291xO16gwcrjVOwcNJpGli2D7Tdj+Bsq+3mc1UwLbAN+33yzo?=
 =?us-ascii?Q?a8DBROvOFRTq2BhVR8o8IHlDApqmi0luQhnPAgoTYZ4kO30rxd1jQf4BE4rM?=
 =?us-ascii?Q?nkjkrWKz/2MXaU8/pdHqU/TEI+WED2F+/QWgzGU5fSRavlApDnwGw2iUUuHK?=
 =?us-ascii?Q?FKxIkT+YhgtbKWoZuPgIQ8NFM7VtDg9vDnlqM8v37+je+wFePcyZkOZnxlnW?=
 =?us-ascii?Q?HpWAKz+e5+XbMZWBbjWccPr/fBUWzXldaOagTsSGinTL+kPWExdi7vtJN/bp?=
 =?us-ascii?Q?pktUneVIrSASZvITU2InJY1Y9njIQ7HJWO4xgyrISZqp9ddV6Qn5TfFmiIuM?=
 =?us-ascii?Q?5tWFOeckTZftJWrAtmrMtnn4lbQkGINcEqIbcGW+/Rm42yabNPAg257JEOdj?=
 =?us-ascii?Q?7fuTDtLBbCYnkOIin2mZEMmpg6/AN5zH+f6hbp/WZqkSrW8tmqeVomtTUK37?=
 =?us-ascii?Q?YV1orgMMsXWtHfU1d5+f2U5pdfWRQODBCnZRslOg6Qv5D7e93dK+fFP3iiWe?=
 =?us-ascii?Q?w83aOdZ+n6J8cV6slD4/jeZVAZGwGcmu/vYGC4mWv7b5Z476uv7kd3bS5YC4?=
 =?us-ascii?Q?1YHnfhvb2f52igONZDlS3ouO/vDBtbBMMDAbBUnHNslu0a6kJJtGf3fqjYXT?=
 =?us-ascii?Q?oHrYKiwl/oj37LoeAz3K/1xSCly83YkMRQDJzNDwgFsjw5YHfbD6/uHKSzbK?=
 =?us-ascii?Q?9a57aKCxlgbsQu1B1id9sQGLsfxQamEHNQmSmkZkvImWEq0lsTCHhDipAqL8?=
 =?us-ascii?Q?hOJLWtZjS0O+2PcJa34FIp4huY0/TaZf56e0QdwGRPAkDKAnGyQfg9quQxKO?=
 =?us-ascii?Q?d0xhy6ythGrlGqoRN0V0EEOS47bsHBYSew8+XO9vigpKfa4rvmcfVYnonYsD?=
 =?us-ascii?Q?rawKFR+JF541bu5BMEQxgECoRxSPVvF+cOVH6zCIj41WQ0HNpLT5TuGyxJF0?=
 =?us-ascii?Q?O6wOwnpdbrKzIkhaHHocRuk4UezmZshRGXkDgT8v2rCGFUQTYU56ZFs+xBwd?=
 =?us-ascii?Q?729X8YSDDPiBwPVGPDh3rdQXukpKCU8ZGN0F8NGw/YPsEj/R4jgoIHbqqvoK?=
 =?us-ascii?Q?1QH7n2a5AbXGYd2jMEZVuqdb2OYeqgT8CtUekTpVIWbN2OPYblB1JVVTqUDR?=
 =?us-ascii?Q?Fb65FL4m1pQ4957fNGe/Mfc3CVNiz/b7ilGNMghaFZJYIZkTjUhyFslBs8FY?=
 =?us-ascii?Q?Lb9CkIdmxREVyKzpx8mYZRAyT5KcRpt6eR9jbKAagqrfsyuWAT2NhLCQvvea?=
 =?us-ascii?Q?NfO9wELNsOgI2OFrRLgK3LlRHDwk7ivhDCiOwkMkoyeBRytYNbb5zeUVLBGw?=
 =?us-ascii?Q?DtC9f0hJg5LmMP87AHxE/J/jKzjQ177x3C5ihmOv30hljwEjowDaokU88W6m?=
 =?us-ascii?Q?yZG8OJ3DEYIGUfoDPxsSrtgh3pC0ZlCjnYnGEhb1QflvstcL+v5P?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50640a8-c3ba-411a-18bb-08df4bd5eae4
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:57:05.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNF76MJfwTc2b3Ft88PT/NLAlq6ZTYi4QeiaEBiec5ZZ+Em7vpw4CT9J060+dyfJL2aNxBSBlYI9PFGd3S5spgXxIyA/MSdE4bwUtUJOlDkzOYjcPkBwOgs9KN/t5UQf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25213
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cd2d36e8ae61832aaac3bddf5aafdab72821e6b9 upstream.

On an RZ/G2L-based system, it has been observed that when the DMA channels
for all enabled IPs are active (TX and RX for one serial IP, TX and RX for
one audio IP, and TX and RX for one SPI IP), shortly after all of them are
started, the system can become irrecoverably blocked. In one debug session
the system did not block, and the DMA HW registers were inspected. It was
found that the DER (Descriptor Error) bit in the CHSTAT register for one of
the SPI DMA channels was set.

According to the RZ/G2L HW Manual, Rev. 1.30, chapter 14.4.7 Channel
Status Register n/nS (CHSTAT_n/nS), description of the DER bit, the DER
bit is set when the LV (Link Valid) value loaded with a descriptor in link
mode is 0. This means that the DMA engine has loaded an invalid
descriptor (as defined in Table 14.14, Header Area, of the same manual).

The same chapter states that when a descriptor error occurs, the transfer
is stopped, but no DMA error interrupt is generated.

Set the LE bit on the last descriptor of a transfer. This informs the DMA
engine that this is the final descriptor for the transfer.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-19-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 22b42b7539eb..08c9cd590c92 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -200,6 +200,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_LE			BIT(1)
 #define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
@@ -382,7 +383,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	lmdesc->chcfg =3D chcfg;
 	lmdesc->chitvl =3D 0;
 	lmdesc->chext =3D 0;
-	lmdesc->header =3D HEADER_LV;
+	lmdesc->header =3D HEADER_LV | HEADER_LE;
=20
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
=20
@@ -425,7 +426,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
 		lmdesc->chext =3D 0;
 		if (i =3D=3D (sg_len - 1)) {
 			lmdesc->chcfg =3D (channel->chcfg & ~CHCFG_DEM);
-			lmdesc->header =3D HEADER_LV;
+			lmdesc->header =3D HEADER_LV | HEADER_LE;
 		} else {
 			lmdesc->chcfg =3D channel->chcfg;
 			lmdesc->header =3D HEADER_LV;
--=20
2.54.0

