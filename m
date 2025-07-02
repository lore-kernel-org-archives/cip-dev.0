Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9998EC83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.30])
 by mx.groups.io with SMTP id smtpd.web10.20505.1751452569112110536
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LNWkK4b5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GivwcnQ0ADZKooeC1jVdUtkEWvbmrijHK97j7kITcMkjCtSfGmRWqJAnJV2SHFZU8KGG69ywhFth7mw2y+lscKvGG+bTcxpZt41I9BTb5Twu8tsciLO9DQo5VAnJwYmB+kH2ePQuO+Zxf799wzaHV2oJsjfVwdTxEsInqbAINom/d+0KD+ScnvxqkPOdKDHd7ijrLJsuc6lOyIJjmeReM0ewFBw+n4wVXw67ruuzIYyuA+2iyOQpwfiVfA+UFbwxjybkW28gHAr/r+R3IWw9o+09jM4aWbnANuU5UM21tFtMbFipSTCFegoaCQWXG5x88IHDaEbRg5G0LGS+m+zdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL106PH5+t9LO5uGova4gbkc66bJVIVeWwlBNxnj+lw=;
 b=AAYv5ESNOnxC/w78OOcxHxxpjD+cRpee0CoSc8ZfdimF7OdgbYERys9AvFXUpeo9kTsFdB7pXT73qN3phK/0hOWAxZIODKAjeqXLJiFMFSZDSRYIli8fFW4BPH9hBv4gv6Yb/d3NslfuRQ097RW6lSZwtYbzQFXveD/yjmfVrpc2yQItIQhHI5mQ0Q8UDVBsndRij8Oo9SfTtd25KFMlbRHcGWr2Qzx54qBOZoQ+x9TUcVmr7hZL/zOp5nZmKVVW1gQlw0SCqawTgzphmBfJtHnp3xe7BS3W3zjnyDrcrXWujUnqT1b3o4NrWKpdraa7VBEmzq8BBY7q2yp6cC4Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL106PH5+t9LO5uGova4gbkc66bJVIVeWwlBNxnj+lw=;
 b=LNWkK4b5pG1ah66xhssNcpoJ2BsOQ7z5DoCwXlRJfwU+fMuwhDKDEzkjVNwq2rz5GZh00r0kGf9NhMnyA4atx9aLAOb2bENiMgzA72zRQ7tVL0mpkfz9wJ+xwI09YQhP+HVh2z/eT65Hd6xxyJKo5vOqCcuKLrwkh7fkLtgypbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:08 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/12] clk: renesas: r9a09g057: Add entries for the DMACs
Date: Wed,  2 Jul 2025 12:35:20 +0200
Message-ID: <20250702103525.117166-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e85d7a-3394-47cf-48f4-08ddb9544122
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FOtKyzKPkSN97tezM3xAY7lCiKJgksgI3lbTjh6CTE2ebm91bIgqcqeKWNa2?=
 =?us-ascii?Q?z4T21434uBNceT3w+KxZlBMjYcI056tG9Cl1D8KVbHzWByZz7YnJAaDawNkY?=
 =?us-ascii?Q?CJkoMkkjJR6mElopvmhxUZ7Sivr8LXPxZqC7P1ZFXi4MmRAsrvNwgfwv3Z3o?=
 =?us-ascii?Q?VInEClVvbJQAei3hEdHf+lrkH1xqjlmKCPOtJZzRbF+2nx64xjuEPZQAVSz6?=
 =?us-ascii?Q?Tp99KgaJTBDZevwfyZbJFwlEwt8QoTCn4iGGrsCAqbI8+ggxMZ3zROxhkfK8?=
 =?us-ascii?Q?HjgQ9y4G20XpKiyqTP4gF6Cp3I+Cb0qgnvTkeB2PHKv0Hb/NlOzZwZY8gp5I?=
 =?us-ascii?Q?wDkCCUvTxDEiwEMsOTo8gd83WwvJwj5ugsvNbTGpfwvNcTn4yN44GABfQYhh?=
 =?us-ascii?Q?0FJq1PJA86b95q6bYvX4HGjpjCsEbHIHLGq86qajHSblSf5E7GSLFcpHJK/9?=
 =?us-ascii?Q?+4Y+fDFgx4Tv22b7dOYApyhaXfmEVFZzLQiV2z/HocXmtw645V7J+xtQupUC?=
 =?us-ascii?Q?5TiCN4Oi2xYI+6z5ViMhaFjbPr1b5DrJubFCS9qq7UiKnWPuRse0s1nuTnIi?=
 =?us-ascii?Q?m2oFC+ASgQFNrgrQJ81wQSLPt5kP9vZBH71axzumb7AxlJIcVsDkZvR9Ah8m?=
 =?us-ascii?Q?5lAUpDfl5fsV0Uq9OYQcQ98oJOzqZ0ZioPOlBU2fULtD/R7TxZFyfWyMFrW9?=
 =?us-ascii?Q?csanK2ECVGjZD8OEe02aHA0VUf8dED2ABTCSJbmHTvvJ869VRGRcHJIEPQLo?=
 =?us-ascii?Q?9nufdEoUiNAIZ8ymlktCVzcfjTzVa8D1EnfvaSpvpeue3n99taf5fBkboH0L?=
 =?us-ascii?Q?xGDJ7pieEcFT21KffkpnNz9Tco72hT4/zBBDbf0o8iqsWRKtokzhpL0N605w?=
 =?us-ascii?Q?vWk3h3K9etL1ibIh96+9tz/gavuoZqn6EpH95p2+VJG8Vm3Jty8S1fu2ClSh?=
 =?us-ascii?Q?eQHM+zuCKfSLslts7DGQUvuEG0BsQbKiSNVqh+bb9g1cZoyGr4rPBv84W49i?=
 =?us-ascii?Q?IHTkWaVGtXqTqHUKU+NzBAO5D9q8Zjg3uswzQ+j4EgK7HaPYmoj2Z7/and44?=
 =?us-ascii?Q?ubz0UA0xdQsmvPjcv+qx4TRhThmTbt445Uw+ADDITMqwanoLV6Ea8gamyKUm?=
 =?us-ascii?Q?GuNcQ/5VPyncACzI0lH9V4sz+eshU+os3Lo8vrlojS1Js27pbmF9B9t6wLQh?=
 =?us-ascii?Q?aPxk76eGzXwiGgQN9feTzQ+Pd1PKDS0arME2jKQdV/PsDBUrOTvR3DZHVzLR?=
 =?us-ascii?Q?oxNQjPX1zGw/+/18IkJcWvxOaF1QBBznu3EVr/+pOE4T03Day3BcytvjYzfL?=
 =?us-ascii?Q?7yNoDXykOXXK735sH/C1+Qwh+eXcMihS4zkIYYgV+qJO24piUo8cMvPyCrEe?=
 =?us-ascii?Q?iXR2GseeOwGnubjyw5cK5W4h/CiiGToTmUsOCslWHtsCGzAGxhsNuG7ngA0x?=
 =?us-ascii?Q?Wwda4ubzvyZrnZV5FVE93xsv4/I1mr1L4IlcYYf8dCdbhUY+fBOli2e5r9YH?=
 =?us-ascii?Q?UgcdSKthQ9uHPsg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AdOE2fHD37fSTrNXRLeZcTokwdlrkSbCCP5tveRSYAorGfV6wpCrvqUqWP0G?=
 =?us-ascii?Q?QHmHMm7AKxCTL1IvHCoLOXfVpdensbpDxLfYABdjVu8s81M87FTZhr2oPy5L?=
 =?us-ascii?Q?+s010VFyTk6EqEzGGK4OxmNW5O41DEM6NMIYDKTVgDickMXT07SGY7fGkX8S?=
 =?us-ascii?Q?JXoEFGZCv0wbVzJ4+ZDSJ1XumSJ5++sJCbGcUzCDHXkYEf/gkCyxNkblssjA?=
 =?us-ascii?Q?SDW2MUXdmkCwlj/CTyHDtY073NdXAZisq99hDBrrCKpHBgfbdyIrqBFKAIpn?=
 =?us-ascii?Q?eL07X9mF1Q5HAtpKZEHMjK79pG4Dlgxn4nkK59sCYECWmSWplaqHOGY86wHc?=
 =?us-ascii?Q?gR5pQP6WdrXTCJkKylYNP5qE/j+JCNpzlco7aafyvpOs/bsOcQMDcJyx7Epu?=
 =?us-ascii?Q?LRECtzJBSkEa933mDLxCYjizB5b8vNcCs7UYq5CEtVJAndSbokhba0SyTDUr?=
 =?us-ascii?Q?7dJPusCdYbY0ts39Zpdza5Etx36DpYxWLl7kC2FDOYDbaN5Lk3u2t52ZpY9Q?=
 =?us-ascii?Q?XsDLy9Tmlgw9r0L7C8aNCKEmQ4V2PGiALWkvpP71FFah+eQjALI4JoRh9NTo?=
 =?us-ascii?Q?nbuBgg3zL0mpKUnK7DwFdUazcj4ajYgt2wdd1+FYY7vk78M08X9pXTzeAA8i?=
 =?us-ascii?Q?+ZYjsO81fB5G6PzwM1gE7MrbMtuyi8+P2sOohe5TnGszna5KGJFxT/EhqE9E?=
 =?us-ascii?Q?XfbXDPt4SiNgs/zksKR8bLH8oOg+5uZL/IKAB6ouuYqxm2VJPQ6mr0uVPxlL?=
 =?us-ascii?Q?1/IAHj236NrLmq0Dv+g0labhBbzgvvvESH3AAbj1H+b1h4u3aA4txHccKtxX?=
 =?us-ascii?Q?lv4PUh2Zsy+gRpIzMq65+WSckLw0ofzMNH5avzNMJYHs5qOSfgmj6lVxLsz3?=
 =?us-ascii?Q?q8PPyC+veDMzoziDjxnT80t0N9m9QizkMyl8atcELBPwd3t2++hd9FJPYa/3?=
 =?us-ascii?Q?s00bnlAdjosZGo8+Ax9B2ezevxQOPC91X63PfYCPPleLOYpKT2CHd12EQWGs?=
 =?us-ascii?Q?kbuxaZzhhqsEYP0lt2NVLmjJDwi1nNN+cNuEvXr/jcHjN4wcAQ9HoV7Om0x6?=
 =?us-ascii?Q?FVKOXjIafF8btoBPeGfIX7x7FsbBbMTo/VvC5NQyAIx2DBcf9wjuz+9S0/ch?=
 =?us-ascii?Q?2o2UKLwGKYGTzd8nSncQZT1iaNkU7M+qXSqHdNeeY5JLx6wqQCvLdOj3P0sB?=
 =?us-ascii?Q?e6C3YkTSnJ61uRfmQA7o+172Lmot3CjlWheBOshvwNYgvsGbbmp42r67Mkgy?=
 =?us-ascii?Q?7FtxzsE5sB6az09j0VjdH/ZQtuAgnZ0md1m3/Ge2jgWXZzBT4na3Rg6HKDJt?=
 =?us-ascii?Q?57EFNwqPyZkTKx0DMV4hzqvZ3LHH6tF/mQMZTqHl1mWRxj4noh/cRuWryhM2?=
 =?us-ascii?Q?asG0kIV4Q71Mds2q29QTArZqmS28RGEgu/VtMlpPntWr0pJO6/1u9gUoIQuz?=
 =?us-ascii?Q?xIkc4WhTZwS61UwMqcD/3GLieaEmN1Oy3tUwSMHCb977tzfl09M9HrzNk5ux?=
 =?us-ascii?Q?fraq0s66snvEoET+ZZs9dmCuX8X58BgjnI7nwjiqkQ5DUTxdDAD/WUk0cIYT?=
 =?us-ascii?Q?7fFkBcP5tYnsnZwtZHRqEMLKnmpPCVSTtQvGQZiQ3ENY7RscWCoP4NdeKLoS?=
 =?us-ascii?Q?WehGF0G6PL14SEP2kqsKwvE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e85d7a-3394-47cf-48f4-08ddb9544122
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:08.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lEUVieNemelMKIKhweyWHDLrBSahvA/TDzFLviUVwfLkTng6XsCWnAn4q6RksWsM+shQMgLTHx9j7kjJzDguJGwJeA1cpR12QK1fWvMjyHM1OufjF1kw7hvxG32yQy8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19292

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 4d6952981244d1e455e2469cfd93e3b5eaddc4a7 upstream.

Add clock and reset entries for the Renesas RZ/V2H(P) DMAC IPs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250220150110.738619-2-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 24 ++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index cd0f3d4d737a..031f332893a1 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -31,6 +31,8 @@ enum clk_ids {
 	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV4,
+	CLK_PLLCM33_DIV4_PLLCM33,
 	CLK_PLLCM33_DIV16,
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
@@ -39,6 +41,8 @@ enum clk_ids {
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
 	CLK_PLLDTY_DIV16,
+	CLK_PLLDTY_RCPU,
+	CLK_PLLDTY_RCPU_DIV4,
 	CLK_PLLVDO_CRU0,
 	CLK_PLLVDO_CRU1,
 	CLK_PLLVDO_CRU2,
@@ -85,6 +89,9 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div4", CLK_PLLCM33_DIV4, CLK_PLLCM33, 1, 4),
+	DEF_DDIV(".pllcm33_div4_pllcm33", CLK_PLLCM33_DIV4_PLLCM33,
+		 CLK_PLLCM33_DIV4, CDDIV0_DIVCTL1, dtable_2_64),
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
@@ -95,6 +102,8 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
_initconst =3D {
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
 	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+	DEF_DDIV(".plldty_rcpu", CLK_PLLDTY_RCPU, CLK_PLLDTY, CDDIV3_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_rcpu_div4", CLK_PLLDTY_RCPU_DIV4, CLK_PLLDTY_RCPU, 1, =
4),
=20
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
 	DEF_DDIV(".pllvdo_cru1", CLK_PLLVDO_CRU1, CLK_PLLVDO, CDDIV4_DIVCTL0, dta=
ble_2_4),
@@ -115,6 +124,16 @@ static const struct cpg_core_clk r9a09g057_core_clks[]=
 __initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD("dmac_0_aclk",			CLK_PLLCM33_DIV4_PLLCM33, 0, 0, 0, 0,
+						BUS_MSTOP(5, BIT(9))),
+	DEF_MOD("dmac_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 1, 0, 1,
+						BUS_MSTOP(3, BIT(2))),
+	DEF_MOD("dmac_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 2, 0, 2,
+						BUS_MSTOP(3, BIT(3))),
+	DEF_MOD("dmac_3_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 3, 0, 3,
+						BUS_MSTOP(10, BIT(11))),
+	DEF_MOD("dmac_4_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 4, 0, 4,
+						BUS_MSTOP(10, BIT(12))),
 	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
 						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
@@ -223,6 +242,11 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 1, 1, 2),		/* DMAC_0_ARESETN */
+	DEF_RST(3, 2, 1, 3),		/* DMAC_1_ARESETN */
+	DEF_RST(3, 3, 1, 4),		/* DMAC_2_ARESETN */
+	DEF_RST(3, 4, 1, 5),		/* DMAC_3_ARESETN */
+	DEF_RST(3, 5, 1, 6),		/* DMAC_4_ARESETN */
 	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 6811c0332812..d52f5416e371 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -57,11 +57,13 @@ struct ddiv {
 #define CPG_CDDIV3		(0x40C)
 #define CPG_CDDIV4		(0x410)
=20
+#define CDDIV0_DIVCTL1	DDIV_PACK(CPG_CDDIV0, 4, 3, 1)
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
 #define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
 #define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
 #define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
 #define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
+#define CDDIV3_DIVCTL2	DDIV_PACK(CPG_CDDIV3, 8, 3, 14)
 #define CDDIV3_DIVCTL3	DDIV_PACK(CPG_CDDIV3, 12, 1, 15)
 #define CDDIV4_DIVCTL0	DDIV_PACK(CPG_CDDIV4, 0, 1, 16)
 #define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
--=20
2.43.0


