Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C39D3F08D
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:01:31 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.787.1769616082935612858
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:01:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hFP0eszr;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WinO/And/tuOb8ZUO53xE/+deMIjYNneCvQMBDWgv7KWn4AjFjseWnfYpAyLD7bcjwV+spFhJWpgsCM0KskZ91MBG9m6Ncz11SI2135PzBJi9uY80DzUxq1EqpxbKXNF5txHvVNch4JZpt9xgmaa95P655ZmuCk8QktEIvAE7VH2I8W7bpI+GRrTUR547hlXwa2OCFCauYQYiZ6mPG1o2sZk2gVExN/OgHIK4Li2Mq1cmlG5RawFPQXnWbBZxx1PDXfjd67Z3lpOSiwxfqUNPqw1BrMo9wIxpxVLtFmwB3CV8ZLCyGZ4ON5rNZK9T+0PDUI6pxGmehWNwS7DBjOdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhOvlB2BxQq3yRXlHnPuyyiRk4/LyaG6YvqvTMIHQWs=;
 b=cr60thizLtSJ3zGU5kWEp21OfCiwON6dzYHERcjFpO9Ms1z77YQCxur6aVED0oDxECcvvkdIWxX2WDbguq6cc49ZWcyODg9hXcI2s1tTWISirbDtLpxgW601R/GHKobBl5AdPPTITxVTvZuBwtkqpaxIwNwGKA8GWtCXMnzZOIuQSVstNRS0r59jiy3oHnR6bB3j+OqoiKZstAGnBfk3qpPrrn22KcFUtii+3uuasnfU2WJk++Ny9qQvt655oQ0adv4ZdnH1oco4mxTD0zJdZdmgzvPhBA/sVljkPZHL1evWVXPwybB4shNuNS0W+SgsczUvSOEG1g3UljEUJybKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhOvlB2BxQq3yRXlHnPuyyiRk4/LyaG6YvqvTMIHQWs=;
 b=hFP0eszrUsnRY6sN6tsy50466wPGEGIemhO4Oa5Yw5880us8QsToX0Va5stD/MwXqzFtc7JoInhZASTCMhHQ9ytfTpVIu6cAgld/HOgD7d7XFigdON63aVFBpWZFAkGT7DQK0BLJPj0N9kqefg82Rj1ygm80UvdrqYUcwNspgpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB15588.jpnprd01.prod.outlook.com (2603:1096:405:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:01:20 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:01:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 4/4] arm64: dts: renesas: r9a09g047: Move interrupt-parent to root node
Date: Wed, 28 Jan 2026 17:00:48 +0100
Message-ID: <20260128160048.1445926-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|TY4PR01MB15588:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d0b21c-01b5-460c-dac1-08de5e867a3d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AuhqhO/IGgXNc9GSAeyCt9afcYK9hOYyppAIxan4T80q8CWJT1CEID7kZw+y?=
 =?us-ascii?Q?icj1euFnfUbLmh5ph1emgM0EZz0rRO6ANoD6BMnbnwzO/G/S1ozRU2LJYFRI?=
 =?us-ascii?Q?QRl0FK2wOKgHT/X3btN3qela26sBLxHYUfoDVjWJaqEibWd/eJTk9lRH6+Zp?=
 =?us-ascii?Q?LJpNGjnZGeV3XJMhUr9nUmVRupP2ti+qgWk4ruphDhQ6SMSbwKoxQnHzGgcr?=
 =?us-ascii?Q?vq6H+ZTGHVECWv/mCkR4W+beVNXE5soZnXYohoY+/EUyOa2l0xEXKAwXqaCl?=
 =?us-ascii?Q?PJsOePv4MnXKXZxorMAqLNZYmIXeWDYQuzCT4kLKJN1PM4FNhnE6JerJ1a6u?=
 =?us-ascii?Q?VSRfLmyDL5Q6ZNvkZhBdRwDYSCqUbKrt1Zg/DMe7OCdo81t4isnB26jI4+3n?=
 =?us-ascii?Q?STcoZb7QWg35LMm2B8oUbmTWvLwqUMpVfN1gG8lFCInzOxJ9TYs6jjCet+UJ?=
 =?us-ascii?Q?4GVf3hXNy5K5nCb7DGK12m5r+n0eMa2JHf8y1LPleDZYIMKyoT+BEKxhTUxz?=
 =?us-ascii?Q?qJFsk/IErTs1VIAneARch3C+hDYqtkfarIeC2nY2NecVg/DF3sZoTD2Dz6lp?=
 =?us-ascii?Q?kvScCAhYS0MplNluslj7qURp+WxCGY8TyOpkd/F4FhzJhEPhdpJQoGmk4QMq?=
 =?us-ascii?Q?AnrwmOK1o2m/g1xB9G96TySK11btUAUWEYJJhF5iwhao7zT+YxWlpLMHM4xZ?=
 =?us-ascii?Q?WpnHSPgGU5cw4DBxO7NXAYS01MphXU2rcG44wTnV8BIbseRTDHEaLFL83K7q?=
 =?us-ascii?Q?t2yy1f2kzh77NMfrCTpqvIq9mdkhUytOWMU1ar/Oogb227iE2fXK9itHmd0U?=
 =?us-ascii?Q?vFlk/yp9BdbwemfG1i/maZnkZcaW277XMhqkgezbgasKOfxj2vaSLLP/Nq8v?=
 =?us-ascii?Q?IuKdF1SczbFOv78pCInAEC9Lcg6tsbVIyGlr/d/apsGyipaIFI1qq5Jdd+ql?=
 =?us-ascii?Q?sh6/iVkG43/4OBnO14SoPWKH8EoDsKeeAqc7rbha/U6yHAU0A+39s9M5hMGC?=
 =?us-ascii?Q?tTKXuQhb3tAf2yRMJ5O4OO+ivmNckElFk4JR/RnKRwzGMM+su8+PEAfI6x+D?=
 =?us-ascii?Q?iWncdxx+9BvRp63cavlwmegMQ+2Jl1zHZINr1da23UUkZlZLoRf5mq79yhP/?=
 =?us-ascii?Q?bckFDravXs2tqc7xSMLGlvv6r3Nt0RLOoQsMVdWj6MmEqot7QYdE9/Pqzjm5?=
 =?us-ascii?Q?uA658ACcdAOicSJBwJQQktAwKsU/GsUwgFWyfvKqEM/8BcL3xHUeutFm/Pq4?=
 =?us-ascii?Q?x8+KpXX1qIub3gYNEq+dsXw64CPhqmXUBNODoqGE//qiAMXLMUlRB+vhq1Nm?=
 =?us-ascii?Q?Dr5Te/qiVJUg9y+8jCxiSRdmaSuA807XAFnka3AS5erHH7KPr36m4kzTfE3n?=
 =?us-ascii?Q?ii3nhH1v55CzuUT8idNeFYAQhI4xYmFdDA43qXD5/waqzYApeMW87LkLRtrz?=
 =?us-ascii?Q?gVjerAl4qZdBgRrgWBWQ2+ruX7mFLvqFI/w0qNA20YXzV+loHATYZ2XYOUFh?=
 =?us-ascii?Q?xX3QXomvZlvHw46+AvnXqvdOjznhTIFjy6cns5Laj8ie0lDvmFSkOVCucJZo?=
 =?us-ascii?Q?BStx7g1kEYoz6ESMdmR9c2o/vcaqvp6ZGsEj/7SM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k3eL8NYf5slwPGCowwbeiQdLdkIswYSzHiAXA8IFwuVo13RIlqFZ8gyJVo7x?=
 =?us-ascii?Q?Z3WvzofNOz8Up2WJQ++/tCMuWoauvFgEFovNxYyNclC6Vba3WYNaD3xuZqa4?=
 =?us-ascii?Q?PhnOeMV0p96BfOKTtmxmbJWJw0cVIL2go8AKvd2GZoMkIs9EUcmDivlHYgQ/?=
 =?us-ascii?Q?4+0xfnJPvuQKh+P64BTdnKlYGZmmcLpAYNh/9dSUEikxTeRr9g5R5zJLVyGa?=
 =?us-ascii?Q?ItPgWuaUujONmSfRPx31XBLm3fqjwJnv8WmIxxQFAaeJFawdI9d/tqLyydXJ?=
 =?us-ascii?Q?K4xg5yO9X7yd3SHLfRgZtv1zldC3faBwHezYsut9GAYBkMKBB+5P7E11biXt?=
 =?us-ascii?Q?x60U9VaCwhN79qVP+1F4tcRM+pXSj4Y+julwCXX6nFqKMvVeycMyqAlr1dko?=
 =?us-ascii?Q?yCN79dO3D2Uq50h3eMGguWvn9VzyPjlzco+8op3ubwDdri+Hhs+xvhzQy6Ye?=
 =?us-ascii?Q?OZW4QT29hSBJnYW/uoPyf+6iRjp8EcrD5hiTqaDoysgEjvR8kke2zaXGbwF8?=
 =?us-ascii?Q?LQ0kKsVcw/3UphaKtqCpW0tnb1wDm16xXYvo9LL3quod6H/UmVckEXeHCRav?=
 =?us-ascii?Q?GFox143WHzfSzsws30VryKaEO0QT8Q/BWkDKy7Wb3xAZasn7yprKChY6slAn?=
 =?us-ascii?Q?ztgqFOt7/fYfcorS+/FAklAA2nEWJjwbwZxoCw1+QMJM+jxla9iEBzWf1/Tq?=
 =?us-ascii?Q?iMYLEWLvlycR8yrAmYaSI/ExLKCxxxt+7FiDVfY0K12zeiQZhvmM6mETZgq+?=
 =?us-ascii?Q?6u687euypXKaBAtpeUYKKpdDMCgm79DAZrvfEgfb4hMj3tFpWgmD6yK+vUlR?=
 =?us-ascii?Q?eCR4TygNJeFdW/rqoKBWFWWjasQPToX7SKAhUBOdop89/XO7uvI8jTl6zlVw?=
 =?us-ascii?Q?G123fOKyblO7JLqKd/ZQOUPJ6ytnofqgZisDE23un+Hi/LZ5jEPDab+HHxrB?=
 =?us-ascii?Q?pfQTRZoIkCdUuJjW+mdYaFy4IvEoogJc6h8QzQuCEN31T4fOzcf4FJCSv+hh?=
 =?us-ascii?Q?4TpwmDN/OnaIV6ZJEdXta+1y8lKPKkxpQXNvkcT5Vn5wrLw8mZSYUgYo8E23?=
 =?us-ascii?Q?+0TGy7IxWOO0OpvufQ05W9Et+2fvxOg1CEDqms0c0YFyNJY0P+5cFmpY/Mwa?=
 =?us-ascii?Q?m8tGb5895Fyg3MBpUD/R8UxmqSX4foYFQIzjIQf6m377RVbS32xy+kVoBfFH?=
 =?us-ascii?Q?GFyTgY0fV0D9BxSKG6/1k2b4nGh44oa2NjmAxWLh4lMomkJv77fPBA7klgZf?=
 =?us-ascii?Q?PNghwgXOPAW8ROgWRzPT1gQWPT4wtD2DTJ+i1hsyMHY1PJdPmRC60DifTl7o?=
 =?us-ascii?Q?xetclXi88zIvxkIqh5bfXEraBU14hoToxRFTwk65TcBez90pVYtaI5aSkL3/?=
 =?us-ascii?Q?Y8Ye1E5ziT3CaxdmSmjYlnhRfAArTDEfzhjaisra0KFzMP+s/Ck8ov3avSPU?=
 =?us-ascii?Q?9aBs2f4TuQlLwZgoZTxAfVVOutotiEZW6pZP4gWm5MNlTxhugk7yiKZy0fDV?=
 =?us-ascii?Q?Fef2uMYRNBd2XiwKb7FOrYKs1rBlJ366MzEZHZngjmIInsWmyzq/AI0iv1t2?=
 =?us-ascii?Q?tGFszAmmdYxWrpw7OmJM+N7zy0aDQbuXPuCG7Gi+Qa6qMq3D0m3kYGPpOQFT?=
 =?us-ascii?Q?wFOZPLcvTIgXt1lpNs4CBoK/bZ8hWybg8yMdqZJvpg+uM1e+XDPtsmHDi971?=
 =?us-ascii?Q?UgEwni2b7h6eMlolCEJm2aBO9qbxktCgcWXXWjojYQc/5WwXr/C1/PwHJ0b/?=
 =?us-ascii?Q?vqUi2EnQ3QA7K/Skq+UTvHEIclOR3cvxz+dtcXdOrgdfgcVaOIES?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d0b21c-01b5-460c-dac1-08de5e867a3d
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:01:20.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DcNQXhF9UAcA7ptLs+YUGqsKcjjy4TtNGgj3Bnrr4JdDIa9uUGjQDC2aDKPMxu4gYco18IucIQZW5y6sQCRev9NACCeU7pfdtsQ8rHe17ZIrArX671KTDOGvP0ChKJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:01:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21777

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit e57389d5547ee24b472ac5c8f8a7dc21b063ad73 upstream.

Move the "interrupt-parent =3D <&gic>" property from the soc node to the
root node, and simplify "interrupts-extended =3D <&gic ...>" to
"interrupts =3D <...>".

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/87h5ws8o8g.wl-kuninori.morimoto.gx@renesas.c=
om
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/d=
ts/renesas/r9a09g047.dtsi
index 47d843c79021..c8cbe53ad4b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -12,6 +12,7 @@ / {
 	compatible =3D "renesas,r9a09g047";
 	#address-cells =3D <2>;
 	#size-cells =3D <2>;
+	interrupt-parent =3D <&gic>;
=20
 	audio_extal_clk: audio-clk {
 		compatible =3D "fixed-clock";
@@ -155,7 +156,6 @@ rtxin_clk: rtxin-clk {
=20
 	soc: soc {
 		compatible =3D "simple-bus";
-		interrupt-parent =3D <&gic>;
 		#address-cells =3D <2>;
 		#size-cells =3D <2>;
 		ranges;
@@ -1175,11 +1175,11 @@ stmmac_axi_setup: stmmac-axi-config {
=20
 	timer {
 		compatible =3D "arm,armv8-timer";
-		interrupts-extended =3D <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
-				      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		interrupts =3D <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names =3D "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
 	};
 };
--=20
2.43.0


