Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.518.1795708605953615356
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:46 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=S0jCGNad;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcD/gaRuEZPk88YVBxXY/uviPcSE2WUbI8pe3tE4H8/xuw5MgmjTLx0telhThoHtgnEuqcLQaX7tK25zh/SQ25O8i81Brit03xq4JYCuFP68xmU2bC93wHfdA5VZQlgw7R3Z3f3k4VN2xYHO1s+VHmVC75QaeuNtyb/2BJ/dJ2olDnrbNzmrybL9WOYLOHL4TNuDD1PgzDoyk65RY4mjGLG3LKhaYNbBgD8QGloFn9tLq0GivMx6fCvTdPSYRfUbBVB/LeKJCZ5ljF2uhoK6PdiEzIUU0Q9ebPyLTN0IXinxDn3mucFTy1jMbW8ZpMdosqoo4Pg7sDUljOmRCDRKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3LVKvYwFr10D0zicMiwjLoYcQO1WGWBsP2fJ5yS1ds=;
 b=VyhHdaosDCXCgZfmoBxP6pQKaabzZCU7hGmL07U6Il4LEOtDy1YbHzwoDyW9RSk0t5GYYCkyBFwwT1mvl83tZWtSQySrzc1Kyx2kku2Pfwy1XaPb5ebZ7A7F18N86Ak4qvdSWKRPepbBKatWgbbcQgiJzL7wmBD/yDfLXPZRMTjd9wJ8KTfle2Y/1/rLllqKed/CeVYf1lkkg3GDCxH3eXxX5xyiqYZereZf4ojmZ3dpdotpK4NYXMBOcbUBMCWEYrkwo4nfvqE+9O6SCU/TtBOd/8YDkU6BVBICIMZSFpdLn1b+OiD+cJ1L4cRs+egXDys8PNjtLswRmDer5h7LAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3LVKvYwFr10D0zicMiwjLoYcQO1WGWBsP2fJ5yS1ds=;
 b=S0jCGNadbCpBeJ3at+GRJ7oob+F1TQj3CpeqNTkyjGO2y9fhDOXwxZyEDMxSW7su8/73j0WYSVElIdUfmCo5vVPl9OUd9ud99FFRlrGHC2XUa1AHyIhCCqhyZyC7PTQkPaW8rJVasuwBAa4yTvHssY7oiSDlpe7/HjPZlRMftdQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:43 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/23] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
Date: Thu, 26 Nov 2026 16:55:36 +0100
Message-ID: <20261126155545.3834937-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a5571ad-134a-4e40-ef1b-08df4bd5de31
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: qD+Sm8VNxDxE1p6S29dFkgGZzk92wQz8IXvMRzUKQRXwlCEFTBKdBFkoNF5jJMqk9hwMhGDCJfUiIjiD9+HPlNAykgxmMzcTQ3gzSFMP1CRMYc6ytXRCCGLlOa3nYZnaA9n2PydIrUhPaxV/v7g/sSh77kB6T5m/4by2OHI1TdBWFpnbE69vo0PfEqp2h0ysvtWcSDLpRQIawQSj5+0mB6ZiTIFJhEnCO2bawGSexqn1RouP64ttLWFwGIdN7u8zDZJFNErNnELskeqTYR5FpUVYrAGxr5kAM1Pg9nwMWskAIdEEzEzjlCoMLrGox/Q7eq4F027xQ1J+zAWVRYwSbCq9t3NJKe+2gJPL/V42oFNAXo8EnCcEkZ2cwJzH0rG0PbDY26+ruvZUx+JDhRRWsYAnfIQ5aTxFsMTR9deUCp+2SVCMPjUZCnfQiP4p9uquZBflmsLF9DukuYkjLtUUYrZo6vddxvOekjsNhEvVCaPnyHjk97Ci4/9hBQJu3kPtN9T98dEkUFjBD60n+s6RUovidPq2w3ZKhibcf2RbRqZdmDRQ0qzsXyOMi6SKNBVaLmbfv6b30eE0OcMO08BZ+MXu22WQhFZXQUTuaMnuy8rolqLRR5/sC1v7qbjAlwD7VL3YDrVluA5tbDgdvBf1eAHpAtSZ9+soCkrHxziwlkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEu5VOuJCryPOoQxlqWiCLkvPqEnAiKn00pZmTUFtBqcxuMihasbbN+9y9dY?=
 =?us-ascii?Q?kcDL4LQC9DHR+4MauyislScgUQ9/LJy6uAyzT31FeEyaI2QEbpdHnkrGYsIx?=
 =?us-ascii?Q?tXnA3pZDAOUZh1pbbKIQmTF6GSA432WTWwzAmQdT5BFTf3mfvimxwDFKr7Ar?=
 =?us-ascii?Q?pd+d9xgyogu6ixKWMFj6u/SOt6/GGK7tZprXqLDn2VZN8SttDUFidy+OVU2t?=
 =?us-ascii?Q?01Hfv86K1BZgTDH9TKkiQwFaxK2UldMF/rVKTEzect1yukSTC65+gNOhJKe+?=
 =?us-ascii?Q?qmqr97hUrsqqvSJeoY3Io8bdzCSMHjLWPUpRTvTlqpuDIvlGEQFxJGy64xbh?=
 =?us-ascii?Q?vqglO3XfI2MKr0iCno3GgF9xh5CNXsPFOl5UIu7aUXqz87nM8/4FgAQX7ae4?=
 =?us-ascii?Q?EPrJDu21GLEf2Z5mrvBsD3KsSC3y7H9IfAPyUU5tDJ5O9KdPPhRiYjrwOo01?=
 =?us-ascii?Q?4dwAacWdtuOg9uJYMpHkQzph9KPBHmzLZz7Zt+ryo98mbCRxRTW/atE55HHA?=
 =?us-ascii?Q?ZBDVAisQq0vUY6dLqvkZo6mHyFErKN8uLEnhntKpCA1jYsMLGBvY7b8SEvRK?=
 =?us-ascii?Q?+UVys+dlk8ugQytWSV6CEKbR3FAbLDneS1HoEkdrJ/lj2vvsSMpwYPcN2p0e?=
 =?us-ascii?Q?2SOTdF/paHu+PPnKqyYU+em9m3IAaapn2/tFWsuYMDJxqg+bH+8c0vWq1wnE?=
 =?us-ascii?Q?YHtJxCexl4enqmeFqxqIspWvkqBzm4Et7XahTCsH6kK8PG995uKDruLeul6u?=
 =?us-ascii?Q?J05JejhE+Ug1mD1hmp5Wc5yuDXVGbWiMBKAVM/0xN3BQRnmu+8ESOGKuCQlv?=
 =?us-ascii?Q?sljCylYuIvrZ7OCitG8yNM0U8VwsYzaQGCWf4WKo/MmzhXi4doCWQzWrh2qF?=
 =?us-ascii?Q?CtNxL6/YEmELwWBKNrldXueuxNsRDJ/UuUupIDlaMCP/T69t2ba398fbPS+n?=
 =?us-ascii?Q?yTnENS8LqeFMY4gc2vNER0hFPqrAtDfhp3QxDYrhlrOuzru/eQexYCbQu6Q7?=
 =?us-ascii?Q?2fLqVEj9ZVbFAVvlTXLanEekeaNDF2Z9TRUclIdlJOQRQv2pw+4aDtYv2mzG?=
 =?us-ascii?Q?JflVNSUqK0Y/TAi2oAVcDXCTs9wsqvBL5KvVAS4A70sJzxi+vEH5qeldKLuu?=
 =?us-ascii?Q?ICQHsC9A6tE6CoZ9Wm73n2Zh47yBnHqvD3QsVFl34aK1tCdSO6kdxewcjQ0z?=
 =?us-ascii?Q?JzXQ4rKsVcJa2GE/HKjiEAkta+exk51GVlfNRVtP0MNFs/wAloasuMtHTBOC?=
 =?us-ascii?Q?7rtbJ8LspJdou8oO4HGK2Gi8P+5gi3QLcTCLposzw+zubeHaSqfE03fQyiCD?=
 =?us-ascii?Q?kh81hyAj2oenrtySVfzwdg5U+AuqrAmA4q8wpbtH+S2yrypk4fWLNrlT1OPW?=
 =?us-ascii?Q?9g0EfAhjWd0u4Q2RK6UJSLc7HUtqyAJl4WZjfLN/LJIrUNm3LZLSiGhx7BiG?=
 =?us-ascii?Q?IiCfsYWK9H+kyY3mqAdtBfxSl8j3NFZPz0KJprID+e+9jRW1wyihQFl4ExXC?=
 =?us-ascii?Q?WNsR10YLFNIccrgYqzG46hSM8IryD8BEbnXqtunu/Hz8xr2W8MhkWw0FCR3E?=
 =?us-ascii?Q?qtXZ4GY0lIP70R0YGB2TTvBzBosjWAyFbdbn0cetDikkb0yxWSMLsTFH/FWP?=
 =?us-ascii?Q?oyNXOODbghR8dPSFJ2a33COUoQMmWUzLaBAkgJcgZHz5LVI9CY5Q1+xioSvX?=
 =?us-ascii?Q?Av5VDZjMp8tv/SunNILVErNoA1zwJQv5DQh/MM6WCvnXQvwYeGCUcvi/ahmc?=
 =?us-ascii?Q?1yMqybkHGShFBFRV8r53jBpzADpFZAdI+x6SKDkuHya0LKwZmRsg?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5571ad-134a-4e40-ef1b-08df4bd5de31
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:43.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3bRKJrzwP3T6Yp+drvJiK2y0s0xWFjmEaxtJNXbnvC/6xyk0CtrTOZPAz+qPLnrcU8DclGKK5FOZq2f5OQR6vgz5+7HUxtXJjN4u8wKeUqZ2SYp/ckhkCZETbfOYKIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25205
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1dddc864dfa844efaf36345eb58b121b2cdffa5f upstream.

Add the rz_dmac_chan_is_paused() helper to check if the channel is paused.
This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-9-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index aa1a1aaec026..53deaaa6db4f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -286,6 +286,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_cha=
n *channel)
 	return !!(val & CHSTAT_EN);
 }
=20
+static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_SUS);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -822,12 +829,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_ch=
an *chan,
 		return status;
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-		val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (rz_dmac_chan_is_paused(channel))
 			status =3D DMA_PAUSED;
 	}
=20
--=20
2.54.0

