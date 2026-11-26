Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.283.1795708115737154810
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rg1aI31M;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pN3qOmG00UA5vZ37GbaWjixZC/4A77/Dmmgn9TNiY1uHV1eGNA8u20MzykuuIpnYQwiuKgYKpvIHgVSngsvX1GINLjeyTspCHKUaneOD4xawyTGcpZtaLa5GodEa2s0RjawCIsdsLhxIaPs/S/M0hBWk+xJ6TklqsWmCrli2j+wvg3G0xyqYemGrlhi8cq/RqrFUHNF33Hby/EwJCP/tCRWMGZYkYwK+zYtWwiB3XsK3uLpg+LtWPHSYnYReGlXK5WoKjn67FY37pb3JrKiDMqkQpoIPZVE9O9AfmWisHJUKryUnhlvy0vO209MDm7gol0UnmvVoj++0MPvUU9l7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axtylFAtGbN/D6/eykXqsAl9XMOSI0ZgyOVprXF+5Qc=;
 b=EuZ9x7+iDbe3jBUreSB36UFh39F+fAUT3fr5C7UX9YFUobTdBqUfNmknjj0aMV2E59EJpKBjej4AiHtJYePWT4ySYEg+oJL/rkX4MHU03ZQ3vybPo5YtNHlk8HZDLgNvx38lFNFDHLMSlCFsl+hUZBzhV1ob9FxTZqpmLBw6wXzsiSL2dMd11MgiloCdJgibl5CMycUsrrbwT7vYiN0PlnHgD+HxJFzwEExa+fpk8p3b1xPm65K0lkVk4Jb7I1mnONUI6mT0UVENjCTeFB2ZuAVn59PEmiwV1ta1STxDoqRPfojZ1385WThZvwACoQQRSuhgm8tJHuYUFo31slqLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axtylFAtGbN/D6/eykXqsAl9XMOSI0ZgyOVprXF+5Qc=;
 b=rg1aI31MnXfjkDOYTS6ZX051/4ZBwvBpu1viuvLbCwlHNsz3quEO4Fjo5SpIBTHczZXbJZTaMjBLIaORVa094rXAGPT4r+vcai48r0HuFZ6qNwuVZRNazX0COa4vHmSE0ND+8Jskxom0CsB4G4uRVr6FVPiVA0tICgqYdJUbQ/4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:32 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/27] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Thu, 26 Nov 2026 16:47:27 +0100
Message-ID: <20261126154747.3832917-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 54b1e200-06b7-40b1-65ca-08df4bd4b8dc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261009221227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZLPbJAtueO894EjBACWxUarFVsZlxkXjmfrXN4WqGPXWKw2Jsw6OAZzOcuhQ0GFOyTuVcsCeykOR1UbZSjDAXVyYgcqC6nED52UJV2MfT+pXJEU8RXaprq5CnH+qcSUoJtnzWgB0VQqjNFcKoz3vnOpLxDBjVOqXlDOa5lHKiGjL/EyHn+PY9dwX66qR8qLvgzLQrVC3MTelaJHQmUlGG46qnSWgNXo9hD/ME2o4sTpyphLDqmswfNA2WW6UUbUjQKVVRpr5e3YorrynQ953KVAGpkHzren+nqzpXOyt33GQdQwDIIHmBHITqi0EaiNX7t/rGcjGsf2JDjVunlEtnM5OSNbEZECb5dcyPXj1McEjq96U0Mr5M7TlYf28e+unGBj/v+CWyi0O8TiC8/Y8Pkm4ttJpMNIOzeYYvs9HZyf1YFf2gA+9PMcUD4pCzvnYQ9lyx247JKiAmcObZSSyq6u5C3bletfsMKLE5QMutcm8AabtBeBSA7IYaCMXhtbaHDJ/UBH21NvXRvvT/7U7mWzvRnriZ8Mxy/0r20oiu9Z6PyK7xh6XcOXXggqIPg/Q2efNfLqlE1bu8M0dfEXibp3P/7nYSewesTWj3UFhXZZ0GeUHNsfuhXjagSvHPqDo+hNASBHv9neAMfdQKs4H405PE3UkBaDwb9XrdRiAcdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkHMb9KRAmIEiIPQyBUc6DGVUvUX/wU1f5dflZAECneBi2IiznF0XdNXjU5F?=
 =?us-ascii?Q?gziiyE7zIrQciLNxp0Hn2f6SFSahiOJnKiT5hqfjLsLKMBMzM700wt7b3m0S?=
 =?us-ascii?Q?+iMjRoGuI9UQErc7vwsnXdJXme/fmAEbFjARzW71BJuq/PWM+bf8yZUwd2hm?=
 =?us-ascii?Q?yR5gJ9GwnIf5u5htmKvvOaLIn2od2vrufi0KIK7MZWfikvPp/eQzyxDA5piX?=
 =?us-ascii?Q?oTlPkvmeM+FEVOE2l+tL2Op+T8Njz4pXx8VOQ5U1Edmae1Fw15PWVwiFKuf4?=
 =?us-ascii?Q?5vITa3d2IHgGt2cDIw4GhxmmVXQXRVC4ATxw1zQnsrIrvcpSEFsBPVehfMCa?=
 =?us-ascii?Q?vyHHhjb3vwp6mCVZ5oQwh6JO2CA67ItcqOpGLM+SM7T6QUpli4mEJuBw63UZ?=
 =?us-ascii?Q?pqjgux2f0awVqtAOjImMfpxg2Ki9lw4lIK8DUZEju4io1qKqZCZLoUAHF24y?=
 =?us-ascii?Q?4oPW0MfSiABiB3M/O7cN3nLb+rRd0FG/U11NHKMxG2lCufqPnp0TYoikVYIx?=
 =?us-ascii?Q?ip4QfcRy9LmwINafXGdOzsTHyXDC9JPlJomwkJyDBXEkxVn+HFxDg05HmwgH?=
 =?us-ascii?Q?EUmMiHWXObdbr4L2EQ3OXMTjUwVQPgkBEbD28eY6UNXvVh9AJ6VbfCTbNKat?=
 =?us-ascii?Q?8mbmEGT1F6VkuiV+44GmtodPOKGw+4pw7EAt7tWo+oSqeRCXHBdoHlzGdcnd?=
 =?us-ascii?Q?SHBBsmzkTQ2wX9XR+8SlcLQhCJrWkYp4XMMVaSHBmBJL1CRWucXyy7yPXTT6?=
 =?us-ascii?Q?nwuLd1A/PAVqEfk9PrwbnxXwMvawzU9qpuMChIh8OHDVClI9gxcnjeaXYUH2?=
 =?us-ascii?Q?hE40GGWopRyxP3saAUt+rhj6RPbrdtjVoyhVxgMk2dHOhMgDVRd8KSSeZeYK?=
 =?us-ascii?Q?eFp/3pZ9TOn/I8qVm94PV0bQDQIjNfJOG1OD8u94p3QDnQcwYJkdkPMYO2re?=
 =?us-ascii?Q?mrY4jWGA5l1+c2KPrXzlPKIT1ikpejYWpkr5b/ksdsl8io7k8Yoxtmmsq5ny?=
 =?us-ascii?Q?TPJjXgvpyGLou3xcmTU4kxq6mcowa3QtVUyHjNYCsqOrc4MEcSh9BFIbk3rO?=
 =?us-ascii?Q?c0lSUCMrz1aZHRlLsatk6Vaogaira2yng4D1Y9IoOLoUh2UkQZlOq16lH5fQ?=
 =?us-ascii?Q?Gz/z4DhQ92UHMlIyrTD900GauC+ZgmohilSPOx6TqrcoBJfXWBnu+peDX+Jb?=
 =?us-ascii?Q?4FnUAFmSHvMGDmt3rzeAxQhiOWanOiHmZqbRCXVoemTlk+SZJvRpH4bXBHgP?=
 =?us-ascii?Q?1zOu0We64v6c1y9osLguOc/utUy9fJFHOcxhEd1hDGwjOitHIV2QJC+bl0u5?=
 =?us-ascii?Q?C4uMKc3QMZxMgTWc+mb2Ror5pYS1LcDUxvB81nlHpPVr6t7D05hA2ds5GfnG?=
 =?us-ascii?Q?iDs5lwrnJvRFZ4zgfv4dpQJlsYP+2MwjqlFcaVp+We1CStjcIcfGqF4Wb5SX?=
 =?us-ascii?Q?UKlasnPnta1ZhQJn2CzDBDy2JPOoIgsazeXRR51CeOzhCQu2t9qzEzHskqzO?=
 =?us-ascii?Q?B0voSKGhFK0wyTclu/IUo4MzVoJ92Ap0XuYeX3xdjqzwfzw+H5dCtMbGnFVP?=
 =?us-ascii?Q?W3Dee5cEU47j0b12trz7+RONF2EB9oAFPxdCkJgDA4CNxJ3s7ANsfO8b1Oig?=
 =?us-ascii?Q?9wjzP17/0rGJ5rqluhadEBFowjFOB+x+qbe0+ibi/2LqUjdh45U5VLoGSe8K?=
 =?us-ascii?Q?sccqr+VfwQAAw03igc7gyc1eMFXByxNPPYHQ2Wa1M8vOGY+G9+FivuQ2N/hs?=
 =?us-ascii?Q?hkGAqcS66JwRM3HT0eiI1Vap5myWcSq36bvTDbz9vsz6cXfLTeKz?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b1e200-06b7-40b1-65ca-08df4bd4b8dc
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:31.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxSIXGFwWPqdiSt2+Nfq0pulf6x8XoxaiDEIF35YNZxxbbk3uTUZ5u13wJqobihZCBJj/KquBEJZCVSQffuWhdyFxh63GAtMG7mjAt+E+nYKZBFMr49SOstpv761br9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25157
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit 7badd294fc82629378b153327c57b8ba453688c7 upstream.

There is no need to jump to the done label, so return immediately.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-5-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index dbc575a943bb..fddf9148277e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -704,7 +704,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
=20
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
=20
 	/*
@@ -712,8 +712,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_c=
han *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
=20
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
--=20
2.54.0

