Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21861EC0475
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:47 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14381.1772529761997111597
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZXkUM7JY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njTh2jMNz5o2yPFmJoe1CvJFbhzDJOmQT/fJrCx0H7XcJ5jLLEpcPJEPifO4XX6mpjXTPQQCcFhLa8MnLbTPp5Tb5JBx+dU2t3D6ipaHTdxPWceoi3OCxRDckMFoM05Ttkfcz53QmxtOKOMFLkRXg6imikvhjkUIKau4z4P61ZMqUz1nxwpMarLrD7Y1s0LUxLU+rtOm3mRixs/uTCFqC9fjy4Ha57CFGdgKo5VqGyXPd38FZH2aC0wIg35Gkbumrww0NypjBmv4asYYQJI77Pcoksq0Z8phdRD/m2vsp8zg3zwb2bsChlnAZ6AvlY9178YwLJOZwIsHLfrPlnSsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKNj4RyFH0a/8+7WMiJ4GfMLWdsInBQaVgj6SDQwHIU=;
 b=frZe+CHwX4/3XwVb8+EsyP/8a2grvHoA5xEz8BKNlWNZUq5alc+5W4bJc6yzcHM4cyOSbylmaaZ4NzUJh5Wqx9F9lGc76Fopupcv4kW/ka5RVsgb6cOped2o37SJmzDqb28Ckfid9FGKRYPmwE1KpAJ4nF7UE984BvBYwOHGTCxqbQo4fpHMYF10VS4133567npeh8c4ktgX34Sg2mRzkJQvLlOUaAJB6+c4cAtG2Gm2konJq24Lahdc5BLLKR/CsT4DY2/mwKHiOYoIou0zJQIsYyThFeEChxGWB8ZNuiCzNq/fYN5XdzrHza+BBHtt9B6Mn/nO4sa8XEZsWDZW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKNj4RyFH0a/8+7WMiJ4GfMLWdsInBQaVgj6SDQwHIU=;
 b=ZXkUM7JYDSFR+XXFppOVSjCtvXqbMksAe7JmfQFCpE5gt+4Odyllr7WkhhY5I/r37vRs4U81pj1akx4c2ARvUx1g6lgCG3qzdGcLOlPXj2Jduo09pluHTDvduxmStP0BcrN5ezqKpHU8hKISeNuxbQqawq1bzgzvgBSFI24sves=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 8/9] i3c: renesas: Factor out hardware initialization to separate function
Date: Tue,  3 Mar 2026 10:21:39 +0100
Message-ID: <20260303092140.12732-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7785c549-b786-4823-a089-08de7906670d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	RGNmvBVz+icCrCKEEJ81yg25LyPR+itCI9rAFXhCJcvaqYHUhP11CDeIj5d5HOznT4zI3SApX/fH16ws5MVzrf6/yFpFQLxWrByYmL+nQRYbKiJiw6tcVCNsb0jXhDAHVVIotLivQ+mvGmZFGp9Kjwmp2hF5AVbFfBRFexyu0Kc94AJpUTH93ek6MClbZNP/KcFYFUATFiGvVG/bLS+oR6WuUm7FId09/5ntCnHGYLYTdOtVvlGV/oMF3fYLwCjMWJnAtxOCqU+1M9Wa81dqLoxX/riv+VSFoPiJ1IQs8M6u9Pvke6VPVFcmeAx9GiMPgFUrJ6M3164kpRPwC7JNHp1saupTjosNoLuBgFONTwU8t8iZBX7VLAdntn8NhEkIYbAQbIVOC6kPp8mwOKomNx4cLq6PraJHiQfgnivZEd6FPTIKplV0i57mbfhTsWmKX6nuetOaUBt3baWyCM6vk3RhyyoQLLxhBcLhLwET576kFWGXqk8tu5xHVZW1chNjh3P7bD+G438QPQgNi9miDL/F/bpfmNLecPXqQNfKDgbqfRiJFhX/STH2iAqbqGBehi0Px2wecJO1XKj+w3PR/1p/iIIKwnfvINzuRRkmIJTYe1xcLVzK1LHnCQzVD+BEFN2NL7pqtq1L9QRGwPt/NkTc7lvF1CngTf3nO8+3ACXvEVZxgUlcaOUA2PcMeYXlx7E4eWG06jz7DBI1jz/yTEeBO+3v2jzFTCllt22txM94dIshblDTj07Ub78NW+KW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b630BGhr8PJj9zA2cvQK/m3vAn4Kl+pkaPM28cBw3YYvlnmWmDmrdt91FtlH?=
 =?us-ascii?Q?FKtHiXZmojbU/bv/4JNCmaBEX/XwSuhWrS7/IR5FWhohOzJWXj9/Pdtemumg?=
 =?us-ascii?Q?CAamCTx5JZVi19tYBDAW/nC1y1IwoUrtslZd3Wd8V2Dw++EWiPVe3JZyBY3O?=
 =?us-ascii?Q?D8lrdlBEp9bMx4ccg11Vdz6JeOlvdN4tYesH7oEC2bpgNBK1xtEmJ1JZyxxN?=
 =?us-ascii?Q?jGfYFHCjHJnFCcBRiIJYiYhX3F663O2LD6+u6Dw/1vyenpLppEu8Ej8Eb0wP?=
 =?us-ascii?Q?YAGbpYO7BkBfLtVUjhYxjE7rIme+k882ERU5/8lzrT74OFcqR6iKQ/kcV69c?=
 =?us-ascii?Q?uWkvItPODJiOZhh86k3pMVNwXjI/4sd3TuezvD59Qhd1bLyd3+wStXYb+Zj8?=
 =?us-ascii?Q?vjCN6mUpi81JXszmm/nN//l+xeYTH/KpXlm5vbTMua+/RnSGzvhlhW/XW0F6?=
 =?us-ascii?Q?H7ZhEa60Pq2WY+APXI5aKZOGtATBPj6QVz/DozZzE4hhuTN7QUmMynZXheT8?=
 =?us-ascii?Q?LBuZ9OVqEAGSGiuUST9VWKp3ri8sgluZhvCXNZz/65nVL01tBDdL/IpdxzkR?=
 =?us-ascii?Q?8uf9VLQLE/Dekzwfu5S4vSAyAxIF3WER7Z7HkvprPjog5NdhE2plxoOyx/qX?=
 =?us-ascii?Q?AW46giMhhml9yqwTqbvlpamnjl7PPAjnvbcsJY9i7ruIqS6luGJEsr6clqZU?=
 =?us-ascii?Q?3+el/dT2SfpJjOtE5OiROkKBcAohjTwGlmYYUcIwDpiXiHAfmHKdi9i9+H2P?=
 =?us-ascii?Q?rnfYJWCWPwWwjsDO/p33sle1GvCcu/IEKi7y/fw174CpYX+eiHfUdkQcaSoV?=
 =?us-ascii?Q?hAnbptrneZzWxJqwJMwxdROnaq+yeCaTVFObClmrRV4qjXAw8oXNbhAgnIHg?=
 =?us-ascii?Q?HZj2dmVP9hXxPRpRzpv43vgghwTlP+1ymKsa9y6Oirk6Q5XVj04lu0kB/LJL?=
 =?us-ascii?Q?NxLVaAT16alv5xxEVJ4cCJCjEQfAlM/4LVJeB62XCpASSDSJI8OML0tJiPbp?=
 =?us-ascii?Q?Gm46/cY9KU5S4DVXxkV3BXdX8dwZ4ZSRX2Rp9uW005C2dGMSWTXt3ud4wGyJ?=
 =?us-ascii?Q?B5G8eX2tb+oMw5YvrbCEaz/3w9KqriBbEAyuZIXGP+bEMbtkE6CkWfHMMzUV?=
 =?us-ascii?Q?iYX3WIsl+9R41q9evSZTPTNIjTNIfd/M2oCpI9BTZAg6UW4rB0LZu8QF8+Ho?=
 =?us-ascii?Q?D/rOvDXzfhpL+HfQW+o5atV4GxcXUIDdPGiCvOuMEmN2ndkkynZye6si4/Af?=
 =?us-ascii?Q?LYxXUV7vRRK9oJqW+LH21fA48/svqE8Mwc3g7Uh5yvntSYrkJoRNE6TqaAeU?=
 =?us-ascii?Q?TejzUJ1OpGWn3gdRYNfBhxRLg8UXcJd8w3ilkH9vzOeoej/3D/ZxHLP/nSn0?=
 =?us-ascii?Q?uA/4EUMq13QAcAHD7vvJEHzAdUST4SgVDY6jPm95xeDLT9oCoQ8Hxu48Cnyu?=
 =?us-ascii?Q?KxHpH29cVTbGCgetC0Mn/qJFJJ7eS+PU984C9itSIf7DZMCMAMKn4VpVQE37?=
 =?us-ascii?Q?GCrJ4sgxH+QFFoQjYsF1RXrpFhhdFHm6R73DSxEXfWqtU0lJDiVse6YDONfe?=
 =?us-ascii?Q?XiNJ52gmJj0YHqIv4tDqPlRzMOmKDZKyu21fC43amJFOh5JQm56tOe9FpCge?=
 =?us-ascii?Q?0N+5ItURC1zOPbpbOULRGV1yJdCGs4vwSwPtVj5bapCz3rZLMydSNrmpHFzd?=
 =?us-ascii?Q?var+VcjSHAk+KCAgHCBlV8nSIn7SnJHqocQWovUZykBSKH8n6sLXmQn/U3tG?=
 =?us-ascii?Q?RUxyBbEInQSXyhsKkN87IEvEqZXYZ58Lj90NdLihaGnUkDLNuJw9?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7785c549-b786-4823-a089-08de7906670d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:34.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcsG+N0dfMaXkebcH4n4Cornd7ESvGzmY1j7UOLm25fWK6MTlWm9zfGl86ns7i8mnJb5ApNjSo4iWRx7tM5YVIN+vmDfzcv8Oo60mEYTyz4N1JUDJ17/sjiTGtcWIu92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22049

commit 5eb3e8763e076a47ab145c5fafcf39f1ac7c7aee upstream.

Move the hardware initialization sequence in renesas_i3c_bus_init()
into a dedicated renesas_i3c_hw_init() helper.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/795327270a6ceb23e15513a2619a19ae4876cfba.176=
7781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 99 ++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 12b25811bafc..c244df4f2fa2 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -480,13 +480,65 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 				 0, 1000, false, i3c->regs, RSTCTL);
 }
=20
+static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
+{
+	u32 val;
+
+	/* Disable Slave Mode */
+	renesas_writel(i3c->regs, SVCTL, 0);
+
+	/* Initialize Queue/Buffer threshold */
+	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
+		       NQTHCTL_CMDQTH(1));
+
+	/* The only supported configuration is two entries*/
+	renesas_writel(i3c->regs, NTBTHCTL0, 0);
+	/* Interrupt when there is one entry in the queue */
+	renesas_writel(i3c->regs, NRQTHCTL, 0);
+
+	/* Enable all Bus/Transfer Status Flags */
+	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
+	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
+
+	/* Interrupt enable settings */
+	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear Status register */
+	renesas_writel(i3c->regs, NTST, 0);
+	renesas_writel(i3c->regs, INST, 0);
+	renesas_writel(i3c->regs, BST, 0);
+
+	/* Hot-Join Acknowlege setting. */
+	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
+
+	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
+		       IBINCTL_NRSIRCTL);
+
+	renesas_writel(i3c->regs, SCSTLCTL, 0);
+	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
+
+	/* Bus condition timing */
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+}
+
 static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct i3c_bus *bus =3D i3c_master_get_bus(m);
 	struct i3c_device_info info =3D {};
 	struct i2c_timings t;
-	u32 double_SBR, val;
+	u32 double_SBR;
 	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
@@ -559,49 +611,8 @@ static int renesas_i3c_bus_init(struct i3c_master_cont=
roller *m)
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
=20
-	/* Disable Slave Mode */
-	renesas_writel(i3c->regs, SVCTL, 0);
-
-	/* Initialize Queue/Buffer threshold */
-	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
-					     NQTHCTL_CMDQTH(1));
-
-	/* The only supported configuration is two entries*/
-	renesas_writel(i3c->regs, NTBTHCTL0, 0);
-	/* Interrupt when there is one entry in the queue */
-	renesas_writel(i3c->regs, NRQTHCTL, 0);
-
-	/* Enable all Bus/Transfer Status Flags */
-	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
-	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
-
-	/* Interrupt enable settings */
-	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
-	renesas_writel(i3c->regs, NTIE, 0);
-
-	/* Clear Status register */
-	renesas_writel(i3c->regs, NTST, 0);
-	renesas_writel(i3c->regs, INST, 0);
-	renesas_writel(i3c->regs, BST, 0);
-
-	/* Hot-Join Acknowlege setting. */
-	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
-
-	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
-					     IBINCTL_NRSIRCTL);
-
-	renesas_writel(i3c->regs, SCSTLCTL, 0);
-	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
-
-	/* Bus condition timing */
-	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / i3c->ra=
te);
-	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+	/* I3C hw init*/
+	renesas_i3c_hw_init(i3c);
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
--=20
2.43.0


