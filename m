Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AABEC35FFF
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.4])
 by mx.groups.io with SMTP id smtpd.web11.34819.1741778712346869648
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kp0v9f3j;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fg81dDlGmXCicAf6HcPirrRAghLSjpBryWTj6gvGl9lkZgoHJ1FGx+SIwcLNldukOXmxPfxQT4WPN6zdtCRPwLDmhA1uT0/3E5Iut3g13IGpm5YZs+xY2rcD/hNs0rnndyNCBgLzxu1MWmi3fMTqaX4P02dach8FGh7Z+fiz2zb2fhZ+2RLkRDGm5BaaOmFlp+1gfzxDiOFGrqszkPyogYXQs6JHJc221KS8sn6Lb0quZYt93pW3FxGQg4KbOcrArF866emB2gNfrp6DY3b28sheQhTEzT3ehe6Q4kpLlr16Qm/gVpdt8Sj8PnjD/f2ArjI/6054Y3TCtqmndo3zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5ruAk/yMOgPOiTKlJXz5pIQzzy+tliUA6ahSi5O+3U=;
 b=gRKtv8kuK93vKUxoWKg0q1OOMNtBbIlH2MoeukXzYWkic2wZNe5ahN0g3R/3OHY7p8xUgsWFjsVHVZvkt5r1209bQj8NNmcIbNJiChFfYgWM8stjXFORpvADowRLeKH/Xg/jdDBhRvbB6iC1/fqc1ywY71/rQNjb/ygEERIHIlihV1P2Awjyyo5EebmkCdYbkUslLmCsIsjKsaKhaJpOhC7cqmOaUMr/3ZOxlpngZ9ZWtrQza6cjBC4MLM95VH2DyiqLMuSJHifSM1tU6i8Cr5iKoEexv1byXBVOz8IN4TI5GkL6HDYT9oXwifmW2kvOEw9zG8MpPXH8VMkTfs0qkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5ruAk/yMOgPOiTKlJXz5pIQzzy+tliUA6ahSi5O+3U=;
 b=kp0v9f3j1C/xtuIpEx+8WQd/GZVSUAx6Ns3q1Y7WoSYFDmZ9GZU74MfAK1OkXfCPUIrl9RSrbBBdoCpg/m8FHPugr76VcIZmnsX5Vrxs4jDGKsTzHblvUiaIiC/gCDbq8TbAKJG+VQb3stN1LUbyigewc/X7fMSGze7/JcmRkok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 32/85] pinctrl: renesas: rzg2l: Validate power registers for SD and ETH
Date: Wed, 12 Mar 2025 12:22:09 +0100
Message-ID: <20250312112302.1605750-33-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: c556d4c0-e034-4b5e-12d0-08dd61588cad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cpEfiI04mQY3HAcCco8srmUYh7ocbcGucxfncatroQ8q218eg17JmyXuOR4v?=
 =?us-ascii?Q?BS2lw1zxIEVeR5L89y5E3ro+GCSsgGr4mGpoPlPbwjRvTF7Iqnunf4nR/Y4J?=
 =?us-ascii?Q?P7rRFEN7o926NtxH/Rpw2E84YSo1fc4Gm2YPKV8AfmuwkXM3As6qydanX0Tv?=
 =?us-ascii?Q?n1fVnhBB6a7rFYccoqFRIuVQhEsBArz5bZVCT1fIPNrDhNM65c0FZ98gorPi?=
 =?us-ascii?Q?N4kASsaJn+x6wKO+ml7jSVWpGYlYyUHR82DjrEg5lUBSvBIiX9Y1JfRHX9M5?=
 =?us-ascii?Q?cgY2OP0OepFrAB9Dcf+uq3dHMevqupRWX85egHWJBzR3GPqAbdPp2KqWkgc/?=
 =?us-ascii?Q?wZLQrk8b0e90XxBAszqNsc/C4X5DorEL5g4v1cANwdEL8i3i3CR+JejMjDdA?=
 =?us-ascii?Q?nwzNuyusHCZFqVzqt/rwTZX9zZJ/SMuPVK5jViBJdSlA7857F6IG48oEm5kt?=
 =?us-ascii?Q?LkuUjNiANXGuMCk/MupniFoSw6Y5fr9i037Gz71I+1ZPWNa2zh1ZHpcGIq4m?=
 =?us-ascii?Q?H/cNAN0kv5k2TCUpw2fnKeNwYXsE7m0/N66KNdWZpYopJ7c0V2IwnZ/yIHuB?=
 =?us-ascii?Q?4FEv144CHsD7Vq8w5IHcfSHlZ9MhouSsvCnsCV/C6KJajBN/KW0e5GNGWu6f?=
 =?us-ascii?Q?jIRxb6R1tKV5xqqPyY5aTEz026hxGiGdHLvYKE6ByrXzcEfxlkBuWbyGUq4x?=
 =?us-ascii?Q?1//BhXBe2TwbRnwouf+VxWP1Lf0u5JzQMnHWDZ293AY5ZPnuqJKsgnZew3P8?=
 =?us-ascii?Q?KJivh93S5z88EoqjocYjG8EqLl6Vy9Zkb5JwOH+5yw3ls5Zsxyyx3WmCc20n?=
 =?us-ascii?Q?wM0vWiCnKnuHqPsd1yrFReV70dQEa4nHiC/hm2pQTdvAA3qvdr2hZepi4XKX?=
 =?us-ascii?Q?ihToHidWnuglqfvAZjPKJpNjC0aFGWNcZtLZEEozyykpCPB1iUjvtcznf7h9?=
 =?us-ascii?Q?w5W7mf0z2+qZ5to9gCskWeweYvfVrqT1q4Dlv9Z90SQoWw67P9ZaDrPtk/hW?=
 =?us-ascii?Q?CW7is9dg28HUWbzI9asMNf04wwZ6MB/Rt3y3Ug7lEiVH/40dyl5HON8EipR6?=
 =?us-ascii?Q?IhajayVktzWFpdaPO45wWxl4rDWy4eTKC4WAlkEk9lHNtNk4aEQC5R4zTdNw?=
 =?us-ascii?Q?4O039/Eancw3RYCBoc8x1EY+nvGF0lJnKrtcLxj3+dCmrpwwbWSEY4UZ/pWd?=
 =?us-ascii?Q?G7XCyMMkRZME7hhnb1k5+wEeDL9/i6wV9JBtXQ4FSjcwOlDk+p7davrtcA9W?=
 =?us-ascii?Q?XrLTqlH4imdhzL/m9tiXtquJYUwLcHt81fgoDUx5cWkotHIzVyu/Dl5cgxKt?=
 =?us-ascii?Q?82q4oCl8T1FtAmLPFpFbthJzDgoJ4/kVuhz/BFdpXeCQAYe66xViwSV1C2hI?=
 =?us-ascii?Q?sin4sQBAXO3+OXbD0GXq0IFEDh4iBY95hm5/t7vYhKSdW/7/Lmrt/bf0HfgP?=
 =?us-ascii?Q?5ZqLbIhkRTGI+2N8UQL+rV8yTS4imXyX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ytick9t4gG7c+mXdUDUj+oyOFACIsldleF54eLj/Mkxbyw8NYacDiDEwZJH/?=
 =?us-ascii?Q?BOs0a4VixbE21sbfbRu7MWay5Crz66tIPaXfOwbWVuzFBBXuv6AhS7QN/NPH?=
 =?us-ascii?Q?Hi7WcUWfL6hmIouGDXU33GRk2wCFI+xVGE1E2jWev29tebUz+rTk1C/NDfnF?=
 =?us-ascii?Q?mpvAPiP0hW0CDUrNXGDzV2pCy9Aue02JvM854U878r5qUAjUN5qoN+7BZAL7?=
 =?us-ascii?Q?YTmWeuBpm8Cnz4SmLbaCN6wtWmbFJDuNRWszbRl4kAw02EAg0313AuznkG33?=
 =?us-ascii?Q?jiMHoZNmGepWf9rWmxuk1qF/FHv/kGnabvwkEVV9IhJZs6jy7zpa+IwBO6zL?=
 =?us-ascii?Q?o3QBqtZN06ZvfQ9f77/9vPvfKrmhO3a7H64or999nWvs4WcSI7wX0h6ePwCh?=
 =?us-ascii?Q?L3wseU2j+/DMl4RNpREaQaYA/Nysy2+k07IkWGCTg6o4N3fyVlXZ5EzeZZ1l?=
 =?us-ascii?Q?8hZ0EDTqS5by12aHzrHLEwoUcqTxixx0VS6MrUm9WiVFKzIeFeoX6+AFcoX9?=
 =?us-ascii?Q?xrxMqLHLcYmjsLPVQB/DZIW20ucQ7ivuQizS7fUnrhMlWTR1Tw7LfSrk2/j0?=
 =?us-ascii?Q?dZUQ0f7VZy76n5VMWVBoQYLmMqCddIq8eN0oJesTqdUsrs8GTaxoincoRrPp?=
 =?us-ascii?Q?8EMFX1lHwAM84uhLkSL+cbYISIjTCllyhDjf76KZ5zuTCrVpPp19oF/C/YCa?=
 =?us-ascii?Q?yVG/28pifDfUMoBGOFmlj0DzbCunjFqueHs2D2WAhF2ntj5YzMpuMCllO3IV?=
 =?us-ascii?Q?SdfPCSDlWM1oZSnrDpSkQQKfEckxc9+mZIEoy3VKWfkDGKoOV7LyNtCN4F9k?=
 =?us-ascii?Q?SdWZK/4xqFxdvddIUSBqKvbrm4CeT80LsY7LeysiBmk6m+RmXY0VNs2gVdB5?=
 =?us-ascii?Q?V/fG6oIuuTEv/em+OcRQoTaqGokBtsncCwoA/js8oHb5ov9aGTv52oiR6AHp?=
 =?us-ascii?Q?fn6+4BdVWcX/VjcxBhGXcnGPGptjX14or8zd0t2H15+vHbZQqUZ0dvkYBcK2?=
 =?us-ascii?Q?6zdYseTptBPNG+y9DaAQSacXP5Kl+OIjwHdQWfHje4pSiFR8GCCwqh1XqA3D?=
 =?us-ascii?Q?aZ7+YI0TedxeknZBgN8fAfsLGhwKmY7RpztOPYoUU6tuuSpUzBwpswLr393X?=
 =?us-ascii?Q?EALoCPL9ZRVQpQCJ70tMO4riY7QzJSlkmJBOunqehGGjTYj5ek9TbF8SAIqW?=
 =?us-ascii?Q?k33DiEWXWFSZ2s4RJ7ZnwChrRhpu9/0Xwq/2X+oC1ljNNdsZgwag+ayfZ+0I?=
 =?us-ascii?Q?7z3orNNcQAbrVgjIV4iW55Nwv281WhxLV2h57tquDPYKbn/Onfj00J6CPqJO?=
 =?us-ascii?Q?Z4ckNjOGKEgFHCRZ1WOsGZQ34eO1PWY7U5qsX84YZJVkcR5AgFLYvJdtvw+F?=
 =?us-ascii?Q?70KnVlt9LOABPdmSLC3Tl/F6IiXEF7l86BWTByQHJVrKXYZHn248MShygiK/?=
 =?us-ascii?Q?NFck7+aJ31rziYtUt8DKj4DyfNl55/+OOcRKVkyoLk6sQ+ShREccDGBMuIk+?=
 =?us-ascii?Q?06FuoWzv2HtRWnsYIFdDfa5lgCxwxNzGg9JvXMiAUMU8SNh6FjO+tCZbkvI9?=
 =?us-ascii?Q?1lz8g+nbkWGmOiDkeCY1P/hHl4hJzJ94p0zcJmdsbEN63WOMx7gbtETWD31u?=
 =?us-ascii?Q?1DPLa86fRZtr6KXDgW/O7W0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c556d4c0-e034-4b5e-12d0-08dd61588cad
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:10.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaJvRbhtDOaKKwgPJQtPMQlXsQFnZ4vDxEm0/6licCfHiH95n0+RVK+uaSlUcgstDpbX4DLnLiWtdV54oAl6497BHoSDFozFJjgnvzRa4tqADWnSkRgCZyf8M620yeWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18124

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a3a632ed87f0913779092c30bd0ea7dfd81601f3 upstream.

On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
resulting in invalid register offsets.  Ensure that the register offsets
are valid before any read/write operations are performed.  If the power
registers are not available, both SD and ETH will be set to '0'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 0d3ffd761762..b6b53757d803 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2503,8 +2503,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct device=
 *dev)
 	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
=20
 	for (u8 i =3D 0; i < 2; i++) {
-		cache->sd_ch[i] =3D readb(pctrl->base + SD_CH(regs->sd_ch, i));
-		cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			cache->sd_ch[i] =3D readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
 	cache->qspi =3D readb(pctrl->base + QSPI);
@@ -2535,8 +2537,10 @@ static int rzg2l_pinctrl_resume_noirq(struct device =
*dev)
 	writeb(cache->qspi, pctrl->base + QSPI);
 	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
 	for (u8 i =3D 0; i < 2; i++) {
-		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
 	rzg2l_pinctrl_pm_setup_pfc(pctrl);
--=20
2.43.0


