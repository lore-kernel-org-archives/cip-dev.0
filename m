Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F1CEC047C
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:47 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14398.1772529821689641264
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=c9ZX5RE7;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.55, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfwJ/BNaQLnEggkEiucWhksm1RnS6+QKsnyrrhS2XleWZiFTO1hmVfVkOUUgA105xRS9Fjk/bnP6CTGDu62pchw++DUj3Mj5O0WMujErZF51JKlg0Y+W7C4qcYTAog/T1cIMHXzHtHP8AGtCaLhT6voYoA/qRxDcJ2yYNpU6xChUfYPKjgSAXKWjNDWhV8g0miSvfHIwYQUgzIm0rHbGMFuJiiLcZDUveFh6XThjTNzYdEdI3zDOv8iNRQfOAF+kx+T760c/gYcmKQ3przPNKzp4x1I4hwtX9tKCSwWTaqocccjQWuqCeWwDTiOB4wkVZG2WF28cOGHzN/+wOnlczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW6c+c60J+kmuAo6KwilAc3JxZRFTRVXy+sKWkIb5SA=;
 b=cB7yRjtdsDNueP9zzzq0uDxWJm1hGcaHULKGVPlRkKKzZmzD1rL6jts5JMYEgRwodfgBADHGEkQrPBbEjfpcVGbP3OosgHrT2inZ9tYf9VmmdIds2SY2hlqh6+UsvKkYp8S5xf6TS9EmocrgTpk7geomX2IDh7skBSpvqDXn1MRdEZrvUnawv63rNiamS6e7nqdJdYg/XwYVUJmvY8z6oZ8AyEzgaIFM26hCwMOnuevHymCGU4W67m+DH3uxGYV/Hp73nd77rb+36yGqMPBIY9baXn9HTW0T82vq6CWefQO6HycEvPUqU/NkXVebXZkCGpFMdsS5DGlVbISnGL03hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW6c+c60J+kmuAo6KwilAc3JxZRFTRVXy+sKWkIb5SA=;
 b=c9ZX5RE7SyTemuUkleqUegbGbAWpZlWKDsK8yvHuJfXuSUrGCu2Q+OykWmE7nSytl3mUaoXWSBYOP5RgK21N74ivNvFy6CeQjpoabv9Sn2AyLyPKlH8ra90QIhPV37j6ByQPMHquyqCW90YtPGnTjUpwKX2sCauyJoo1CtGyaQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:39 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:39 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 5/7] i3c: renesas: Store clock rate and reset controls in struct renesas_i3c
Date: Tue,  3 Mar 2026 10:22:57 +0100
Message-ID: <20260303092259.13301-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa8fdef-b513-4413-c7c3-08de79068e09
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	SWnTPSnSEm1XSS8lcBv6G6G//VmGxJV7jgb4iyO2o7NGp5s1tDRxpjWF5SSo/YpJ19ji0nfKMzpYOHZMQ/B3ZOumr8viW6B/oY6gcAHwF8DxniEnHyLUvIQuNpFyxBoMcbNcJXQi3GRiC44bMD+EpaYC9u9kiT6e9wPpiF7tFumjlRlimJu5X1acCDJ2nAQ4xkjOrUGLKoa+ok6yZzzeMCsxYpyn+QLaQXjw2SJaDcw0Y/gNokJx3f8kstmzukVgaP+UbYnQofYLbDsLxkzIpv6HPVVw8A97F1yw8bXOntZxN6fEcoFDaYImKos6MGC5fpbuO8WvrIP/RFMdv7g0xAhV4FPZ0uhpuHv5fRgCrhThCLJLerX7lesl6ktjWbDSjSUu4H4t+QfVWMvbc87Iyi0DHEcUuvURwKsPAVtiQ12Q+ToVVMwhSC8N53uvj8ug5qjEv5Hws4LhpW36k/Z9w8ExD59Oq9h6lNfVnWfdCzICthp6pXMmqg9ZFvup39xA0qHxHAB2gWmgrl1n8t8dl3kW+pnLimAiD3QqLF3YZNRevYicwCf2CPuhvVBJJ5VCkOqqaDwELx5wpj2eAoJNvK7NF/+3BePWRUYuvRmwPWzMVOYXUHtXCukd7ALraAq0OG0Pe705S5vZ+Gaw888gArz/PcWTGLnEVoYTxebSAhnHXItO4ezimaGXQdwCT8jFP7hPx46YTRqbz5/w6QXJcJlyZZ64e9hJAjDb4RMo9VHnbRwMDvAnELEZbFJlv+Di
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FavdwO3jKTQcDd+bHa7FtVuR7XRIE0EH3uk0uzOarZgLKqNW73v4VdpSTafT?=
 =?us-ascii?Q?urlfHo0+Ly+A93KFOaiaZA+mo2W+CmbaR6LQ1y3Am4ahIdHEMr90nhVKsHYC?=
 =?us-ascii?Q?0MeqOjdtzgjgwDmF4g94j3Szxgy6rl8lIqLIVjT71XyDmURywEfAI5S1eWqs?=
 =?us-ascii?Q?+dfciZx13IC2BStmAa4RWJHvgZsKYnXL1Lr1K+lFpxpVUOuyPsqzRZUkOsz7?=
 =?us-ascii?Q?WOiGwI4CjAMxungVvDYO3udUvvCoY9R6nWAOgcRKtL9dmpf96e2s18+1JQ1s?=
 =?us-ascii?Q?P0H/v3XQq7NHwwUJ2/pnpJyaVzVs5N5xCWkA+BeE78wAU9de0YSR6VjDYxgI?=
 =?us-ascii?Q?sA251DwJDPdrlcs92am1nIyyjDkiQuuOgEN1MGV3qq7w+W9zxW33KHtqu92S?=
 =?us-ascii?Q?Uka2W/WKYQ4O1GjPSdODoEWJj3av1fReglU4hD3prjob26AZCQ51ELqAW4sk?=
 =?us-ascii?Q?DLxHNzoJV4mxNBeet0XBLGPp+vBQ9G6DLIvoSnL5m8d3jDTWOo7fEawGo1kG?=
 =?us-ascii?Q?RjDNqDi6mOc7kg673eXooVTD8X/oNiYj7/tR2T1Yucepsmpxv+eNWdVtEUVk?=
 =?us-ascii?Q?2IzIDedAh6RsQoKOgyPRZ3Gz58w+zi5nXp5MHkaGS5N8VU2305GSFVoShG0o?=
 =?us-ascii?Q?av7YLeM9x4PL2w0IRWcs0xIT/8WGXGVYq/KHdfUBWe+kYGMQXzNdzy1byNGi?=
 =?us-ascii?Q?ebFeaz0Ot5Xk4Bj+PZnZ2Sa0TDnW32oUvUK3/Q2pk1cSxQTddS2xa0J3KLaY?=
 =?us-ascii?Q?nlr42m/sPBgl1ezJdiaJ4b6GmJxbC9FDeV6mxuUIAts7b+475uCK8cwQgjcu?=
 =?us-ascii?Q?sWogaWDwn25ICVEXLN+cpOFe1VbTi+yKi4w1Z9n3eM4uDV+uuR40YdsVFTtT?=
 =?us-ascii?Q?5hTetppG+0clkE11GVnE6mPwpwlpjJVxWWGg/mtF/DeDK3faK2irYt9yJ7+5?=
 =?us-ascii?Q?Sp6sU9P+0C5tqbWIDwKZkMpNY/XkJaxoq40ctefnFtKAFdzM01tW/tekh4om?=
 =?us-ascii?Q?yFBumwD4EfdGk1TZPD/Mzy5hakF/2Nbox6K6/XVFnCOKavjzdVxmKauRs/op?=
 =?us-ascii?Q?iHklNkc/n5MfJmDljyO5MbnXXK+6TO9Hg5yH6SdEjovUYraKps959umr3KnA?=
 =?us-ascii?Q?ggn9sECO04XeqKIjaFJcJGuYHuWOpjziZPcL0DXnTWnSQGFm3QiELD1tPy8h?=
 =?us-ascii?Q?wZtmXfxEfGWxNsiybJnK0Mkt1HwVmosR5SGlNX/xKawJ+8yPpinvlqdsz/hZ?=
 =?us-ascii?Q?97C/VSeehGdTrVh3iK+3HDryWWmabldRIgLp8mNoFkYXxEJ/n3thuNaqpxe+?=
 =?us-ascii?Q?pa9NpXH3k53tx+RnQEoGMrbkoAMM7OwRfB+kH/Vx6PvSe16CcT8bBQJWOD5v?=
 =?us-ascii?Q?piE/eOiwprHHbXlSIhTTmegGvaQA7NIZrHn0mBxjUM3cRVuz9qZNcLHHRhpr?=
 =?us-ascii?Q?sfvg874s82porYDA2lI8aXr4Ts4y6DC/aVA+p6MoGjm+pYcQUzbUgyxpfyRN?=
 =?us-ascii?Q?3TAMT3SgzfKgCu1q/Psp+lWL5AXb6j7YScpq1g+8AuEikN8yuV9XirAlEQGH?=
 =?us-ascii?Q?yL7aPP/yIMWj2afV9nzjy8U8S/izgSz3bbOx6VkEsDbXhIh39IS+IMfci2kC?=
 =?us-ascii?Q?sANZ2MsPKohhYrUd/7WupZSXN/Zcau3C370EwqwJl2VNCKe9+/2vnxvzz9FX?=
 =?us-ascii?Q?a+WG63kYyLm9KBsRjwDuRH/xSWcgy93W0rpsH5EJYQY0ezPWcalPaA5ngLHt?=
 =?us-ascii?Q?QYNhcf4qPgwMgInPCB8jGUZj23EV7Ep+gwONalbhVYugaIIvLrHQ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa8fdef-b513-4413-c7c3-08de79068e09
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:39.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erv1hlkgQfLtO1Ff+unESXGVCvRs2iVFYAu+lgtAUsNS/JzxMxqwkipWd/RqPwjZ+B6xHf4S0peYl2XAJMCNv+IElu6KB3KoDK9UeS79n1PdyWkBGdfnCYwQQBhGLXSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22056

commit ff4e4f03f0089635b3476d68f5b8833ea67adad6 upstream.

Update the struct renesas_i3c to store the clock rate, presetn and
tresetn handlers. Replace local usage of the clock rate and reset
controls with these structure fields.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/9e1da95dd9137590c752ecd9429925afcbeb918b.176=
7781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 496783331773..5cb194c7b400 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -258,10 +258,13 @@ struct renesas_i3c {
 	u32 free_pos;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
 	struct clk_bulk_data *clks;
+	struct reset_control *presetn;
+	struct reset_control *tresetn;
 	u8 num_clks;
 };
=20
@@ -482,22 +485,21 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	struct i3c_bus *bus =3D i3c_master_get_bus(m);
 	struct i3c_device_info info =3D {};
 	struct i2c_timings t;
-	unsigned long rate;
 	u32 double_SBR, val;
 	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
=20
-	rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
-	if (!rate)
+	i3c->rate =3D clk_get_rate(i3c->clks[RENESAS_I3C_TCLK_IDX].clk);
+	if (!i3c->rate)
 		return -EINVAL;
=20
 	ret =3D renesas_i3c_reset(i3c);
 	if (ret)
 		return ret;
=20
-	i2c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i2c);
-	i3c_total_ticks =3D DIV_ROUND_UP(rate, bus->scl_rate.i3c);
+	i2c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
+	i3c_total_ticks =3D DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
=20
 	i2c_parse_fw_timings(&m->dev, &t, true);
=20
@@ -510,7 +512,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 			pp_high_ticks =3D ((i3c_total_ticks * 5) / 10);
 		else
 			pp_high_ticks =3D DIV_ROUND_UP(I3C_BUS_THIGH_MIXED_MAX_NS,
-						     NSEC_PER_SEC / rate);
+						     NSEC_PER_SEC / i3c->rate);
 		pp_low_ticks =3D i3c_total_ticks - pp_high_ticks;
=20
 		if ((od_low_ticks / 2) <=3D 0xFF && pp_low_ticks < 0x3F)
@@ -518,7 +520,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
=20
 		i2c_total_ticks /=3D 2;
 		i3c_total_ticks /=3D 2;
-		rate /=3D 2;
+		i3c->rate /=3D 2;
 	}
=20
 	/* SCL clock period calculation in Open-drain mode */
@@ -539,8 +541,8 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 			STDBR_SBRLP(pp_low_ticks) |
 			STDBR_SBRHP(pp_high_ticks);
=20
-	od_low_ticks -=3D t.scl_fall_ns / (NSEC_PER_SEC / rate) + 1;
-	od_high_ticks -=3D t.scl_rise_ns / (NSEC_PER_SEC / rate) + 1;
+	od_low_ticks -=3D t.scl_fall_ns / (NSEC_PER_SEC / i3c->rate) + 1;
+	od_high_ticks -=3D t.scl_rise_ns / (NSEC_PER_SEC / i3c->rate) + 1;
 	i3c->i2c_STDBR =3D (double_SBR ? STDBR_DSBRPO : 0) |
 			STDBR_SBRLO(double_SBR, od_low_ticks) |
 			STDBR_SBRHO(double_SBR, od_high_ticks) |
@@ -591,13 +593,13 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
troller *m)
 	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
=20
 	/* Bus condition timing */
-	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / rate);
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / i3c->ra=
te);
 	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
=20
-	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / rate);
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / i3c->rate);
 	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
=20
-	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / rate);
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / i3c->rate);
 	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
@@ -1300,7 +1302,6 @@ static const struct renesas_i3c_irq_desc renesas_i3c_=
irqs[] =3D {
 static int renesas_i3c_probe(struct platform_device *pdev)
 {
 	struct renesas_i3c *i3c;
-	struct reset_control *reset;
 	int ret, i;
=20
 	i3c =3D devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
@@ -1318,14 +1319,14 @@ static int renesas_i3c_probe(struct platform_device=
 *pdev)
 				     RENESAS_I3C_TCLK_IDX, ret);
 	i3c->num_clks =3D ret;
=20
-	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev=
, "tresetn");
-	if (IS_ERR(reset))
-		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+	i3c->tresetn =3D devm_reset_control_get_optional_exclusive_deasserted(&pd=
ev->dev, "tresetn");
+	if (IS_ERR(i3c->tresetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i3c->tresetn),
 				     "Error: missing tresetn ctrl\n");
=20
-	reset =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev=
, "presetn");
-	if (IS_ERR(reset))
-		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+	i3c->presetn =3D devm_reset_control_get_optional_exclusive_deasserted(&pd=
ev->dev, "presetn");
+	if (IS_ERR(i3c->presetn))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i3c->presetn),
 				     "Error: missing presetn ctrl\n");
=20
 	spin_lock_init(&i3c->xferqueue.lock);
--=20
2.43.0


