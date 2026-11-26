Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.293.1795708140495136545
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=I30O3kd7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.47, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnH/37uCGWfTj9PpDYiFArPXgReQoyZDsIpdpmZI/ZF752ZNUHLLvV2URkqC/+1qCT+kmt2raaH0YnL14K2shwsQnZlnZDAkyJ5BO/o6986UlorI1I9q3pMuojrZpO6oes3ylk09c4MLax/p7gpXoSA929EmjxIIvE0moh/EEw5Wjcmk4xJ0BKlRGJrnLZKD592ALsBPNiDuDHddLNa3o+LPxPJBNpyJ2QJfdSj3MYPNatiQECYbAn6QunJGLA81vBNbcNl5/m22nziYmzEJlx/MVAA+0HFW35YdaGKhlvZ2a3U1TzcbGPQxAKAUCXqUHHMWYVWm8+vq5+ksXvCT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckprDIqKOlhc7agNmqlfyM1p+9GRZUqUhffOa1LiwIA=;
 b=OJurQZM/PsGZ/BhK4iykBgG+NED97zil16kMKOwRabjsBQ1pTAEGaEDhjCVnKwG8Iy8CZA4KZ3xU559+3E9aqlXkABumriQyhBTUV+MsTwSjkYQqqtiXJAkEDt7Rv9dWFHSDmzPGGi7M6KgjuHvyFsOn4verJI1B6uF4kvOz1sqj6J1/lvvcAc1AVhv6gHjgqtvxWBK+962fKlmXSUCGVR4LQTBT0iUmZ6lmd6wfIwV6V6TD+4N3HLPLystKVs4ZvpHWrbrt6iUIJ2OruIgH7Ro71CnxytpAWyIklzYmBFPs8YOPmcaRCis8cn3oXTcOtWV+mYuzx+VBDmvx6K8Mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckprDIqKOlhc7agNmqlfyM1p+9GRZUqUhffOa1LiwIA=;
 b=I30O3kd7nas/CkqEsZWhncNE911pVNsaX2d2xDvESaOLiLKDHACeErn4YjGhgEBE62enN0SKDlVcjG4D65R4d7sKGNolj5EgRqHqUt7jmYNMZ0oiPAs2DWq8lqxeEZ0rV19GzbiUQvR2wVR2deANOE9J4NUMPi3wSoOF4ve9EcY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:58 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/27] dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
Date: Thu, 26 Nov 2026 16:47:37 +0100
Message-ID: <20261126154747.3832917-18-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25c47102-89be-49e7-ebbb-08df4bd4c88e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OL/Sn4tOlfk0kKaf44MUWbVqHPUaNYFlrfdwnJnzsY7kk93TOAGzW/8R7rfraUBU8wtNKnTBc9kXdaFhL4ssCiufOR7TWxjFdzny3JQRgeQyUQSNtEXVq+f+TF3Ielao8OK16pYymFCyr+yqoYjfzVoHJ02xu/hna7wTP5TXziJ/95/TH7G54Y3m9jcqGl/7V8fJbPqn5YoDnXjvG8MPiMo0W1U11xvf7u5sKCxC3LlmqvkOa+nND3SSjsQPClqdNWsdDY5ZE3NgKP25l7uC452M2kWSYiRMRrNmehJJVg9+ROqsIglXrfY4n5pui0WJ4QfICsUwLl5ErBSr4gTQBi5KOSn+ESs1QLBO2tGSmx+vhi3uB3NjHEQnA8Fc6rQfWVj5Inz4MRgcj0dhjtzlUMy+DR00xIJ4Q/07yRSLor6/kTT7s3AhKf++6z3QhGagTK8GLUYjPGnhP07mRJhEogp+XGEJL+JrEXypGDeHT7yn6n9F+e5wgOQCycptcGspbT4Uu+weaGeSbeP+d3Y5FPcODdfMqSY8YFaTS7L7UvTgNgJ/D/zqgw6qcvd6KRW0EkKiacx+zW+buR55iYHmDytQa1YbHgVmCYs6ykTfohq9cTw6ZMqIqY+u+rYBS3V482edHZNh9e5hu9anqOLsPmy4KJeUgwVoIG+4xyTP1q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fT0umWXej1ZuSelVRzR7WAhPmZE/dxiLPipn/qmYec1IYvTnIXa8QV5vrrG/?=
 =?us-ascii?Q?5KDlcuXGE8VbXP9uGfVoUDvr7939zMdiEFhSyQxBVq36ob8WkyOPaiCec8Sy?=
 =?us-ascii?Q?3d4OyDgH7V5XU7RpSAOfLZzr08y6idvXWWGSvS4F+To7LvHaPL2E5X9S6sT4?=
 =?us-ascii?Q?HWKwVYqk1Vck3g/HEv5DcQovFXXZ0akMSisyW6Vnr6UkjKzuX+aRFX5l4MkX?=
 =?us-ascii?Q?APLy8Nm7DA59z3AOm3suYbUNJ76EveqIqg984Dbm/VgTlAbHjgsZGEENrVYz?=
 =?us-ascii?Q?ae3bsParqHHQb9AzvJ+LiFtGvKd8lOAi6k4XHpX+RoJic1QZ94e0hj1xii75?=
 =?us-ascii?Q?EeW/ulCuSzvfZ03EcLVUK6VMtTVwBcF7GDuQjlPWl3RIdoQyWSvRDzHMrm59?=
 =?us-ascii?Q?6MDIent//KE4VZ3sTZ6diJfbkOfmB+cehNMIjhFP5w1Ag4lTRZa+falZzDh6?=
 =?us-ascii?Q?SnFBtd4GUEk9Lhe/AtsVAASWWeBVe8EZOYhGQmgLjqE7PjiZjDC6Fr2Jw74Q?=
 =?us-ascii?Q?eadiI+Ud5kuxZ7rgPQBr3rLJGxTZAxD8eVRGF3XQCAa0osoA2EG8nkFS90mi?=
 =?us-ascii?Q?b4EQMDUHdv275RUG0cNrl/u6WL2VtNb8fqXtNYzi4s52To4+0AQDt1eEtf12?=
 =?us-ascii?Q?/t9AI6mffRdv0So2hCTH03dra29BOpNnsbxLMrNAmFz5IaXCT0tQHeIUvNR0?=
 =?us-ascii?Q?jTY1hv1BJ0fGDp+4V4NjgZ+Er3X6//U14NF2Cr5i/WACW/ELTWM8tEFXdkv4?=
 =?us-ascii?Q?UKSxpP01NF90a/gtN/4KW3yUy24tOw9kBgwGsLbNNUhu/DAEM+It/l/gP5Mp?=
 =?us-ascii?Q?7bkkwxpjEiubLK7bu6WY/XTUyW/7KqTN1v28N/RG7le1mnXyqBQXwHuVDa1+?=
 =?us-ascii?Q?lshjIW64a65R2JsHnsYI8uQBUeNc6/5WDZXFIqzQv7MQE6772rqZqBI30DxZ?=
 =?us-ascii?Q?8HROQRH1sWT1maffk8X8P5uZcv5Mo0rwUi4iOF1x176mHP2vhGNMaO4lo0H3?=
 =?us-ascii?Q?Wp9/15xJzEe1M0TM/s9lNdqGSxJfgtlPK7dOoDXwOaMZIIojjKroxCgOSICT?=
 =?us-ascii?Q?COHhlbdpdn0wK8mzD2td4g6moNKOTdi3aoBJOVMaYJY0TCBoXbReqe50efiF?=
 =?us-ascii?Q?kwtK6D+yujz5zZWLDfNPQHAu7piE1DAnjncRmrJVKPgVGOCmfl2/accf9vAX?=
 =?us-ascii?Q?07H3KbkoWDeMO18TMHkUhhu7r/A2pm3easqEwyOfKUC41ZR8nOkvHtUIjsfZ?=
 =?us-ascii?Q?8QodZUM8MMkxGub4d3mLqRpy/fXfCzaw6CI+H/3ex+ujp3F9me8pZiPDKilT?=
 =?us-ascii?Q?9PT75scJGvaQGYvzb6BrHX07mu0BRom1EVPT7lP6yoY1OaXftuN7r3zYt0fy?=
 =?us-ascii?Q?X/8QK2PW8F60TRPAegmYn3eDI2DdPy19Cv6+9kRMAFdOCOC+yaQ+HkzkQlGz?=
 =?us-ascii?Q?NAVKdmC44PwKq6grfIlNoeJJwAr4Ym0OdbD1Z1XpraSiZ5Y0tlAmZcJ22WHl?=
 =?us-ascii?Q?Bu4r5ZUyS7CzehtUqgWzwVzsuOvYwVQe6ezI504Nq5u8nCZ6NrUit+kwoNHz?=
 =?us-ascii?Q?4g6hn1ilA5so65OlgYg8aGa6qJ3KRaZyEflJBakKYqip3MDUtZ4UJhiv4n65?=
 =?us-ascii?Q?uKzM4y56+dDj8uEmGTg3K1+CTiTqdT5EkpNPs/6ccHwb7qrd+3pz66XvhAtO?=
 =?us-ascii?Q?hN7MosAqzoJ8hf5Owtw/2iF8P1plQZtoKpteANaHScrjvV6s1q5FP94FbdKM?=
 =?us-ascii?Q?kHZIks+O2CkwBKuLysJyF2kcRKHznfGT3iYmSnBZ6pshVSnHCGom?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c47102-89be-49e7-ebbb-08df4bd4c88e
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:58.0387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTmWXj5lFbFsPrZqpIBCMxJqfwJnLetN4qOS/PV9zet3qdQ6poYzYSFGcEilfIJzhmtw7dbl4ZDUuay/cTcVczDBgaQjDXaGJD0XwMM4lPs1v8iSkLUhU3xB8XqKACBX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25167
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7a94c109a5def4f0f25705a82ed5870f794ff4ed upstream.

Add the rz_dmac_chan_is_enabled() helper to check if a channel is
enabled. This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-8-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 0a632dc8f534..73a2b61e718d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -278,6 +278,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan=
 *channel)
 	channel->lmdesc.head =3D lmdesc;
 }
=20
+static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_EN);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -839,8 +846,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan)
=20
 	guard(spinlock_irqsave)(&channel->vc.lock);
=20
-	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(val & CHSTAT_EN))
+	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
=20
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
--=20
2.54.0

