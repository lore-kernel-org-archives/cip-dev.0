Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16720EC046F
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:47 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14381.1772529761997111597
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rxhlW4fS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKdEk0ryk2R/nyvrePNTaKkKjJRX03xvGoRk1WTAKFbp+Hhy3WeAnMBpekp6hfhou0efwKsOAAu92CW0DwjVbWN19FGVc8IfXSgN0CPyy6anZWuhbQ8PIr7suzo5pcQd7ftjqPzmfWrRV4ctWFHVcfgvDqOUUS4J2QwYkzJf7A344pY4FLau1W2cs/OaYeabdl3eA9X+8okWIQY4OGG1XqEuUNwCgSQtGKW9Jbk6rxxJ9voH6JUHP98cVCeJJzL14xy1rOvBXpCjxDYNz4Y5Pjsvh5NWE+Dlu2KaGDokjNIFGUYySxkoUqcyUYVRRQKKO7AVke2Oj/qCNhOj4Nc9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bpgxz/z6rrpgYey89Cs4Wyagpsox9tIpAvaU3kKiGIE=;
 b=Kw+Jnq6h5qzsh70NRS4gvW2xLwNeAWRahKi/bTKN8lbTc20uYaFYfnAjjq8IHvk1WaCDHBjIb2BNh4bhUT4yJ4aPpS9lPEVwjtTsJjoPWoR5qhXkzBQZaR4l5rMHwkOME3jBrMuB2be+iDXezBHodnkuyFCfsXWvk5TidwAsJizTjVuus8D0uWMSC4drHnu85/RTLlPGugkaCN0aqP6viZksQvjd+yG+a45D6fd2O/AxPcUm4I6BCpTW3JnpsWPTwk95LYtE3kqKuuhFOZNvjtk7+V83mYnUIx4kPYdmttksrw6iRlO88OWNPrjMl1K5HRQ3hs1PMmo0cjyFocZsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bpgxz/z6rrpgYey89Cs4Wyagpsox9tIpAvaU3kKiGIE=;
 b=rxhlW4fSws+r0NSD4Adt6aFY4qLekggCb2yjK25hyxe0wNLrKtiJOcGktO0BA6zWNEv3EnOYJy1MHUWibKlEQYEtclZNSfd5kTpv8b4iZLYB5Pt6L/yio6hp3A3Nt5s2rl3apHT1TZN1qrWIy7lRiVnFz9r99TmCvD3rS/cYQZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:32 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:31 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 7/9] i3c: renesas: Store clock rate and reset controls in struct renesas_i3c
Date: Tue,  3 Mar 2026 10:21:38 +0100
Message-ID: <20260303092140.12732-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1172b40-8b98-4926-7d85-08de7906651e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	+xVpi2tufalkb4hHRhI0VPQPRzIUS8+UUMfIn7ihh6Le5+2jwgp1YGagsCs0rHy0P/wT4m7ZsQpSM1qoqttLsXGjeXbVXs9+VJbfk4io1dGnz2T3XsAq9Sks4g9xq5yZYWlm1ucPKGquGeE2BtUAqN+gmZNwJIqzXX8dnv5SV5IiTQ5ewxfkw6kRpJcZgB/4HnpmrIBIxs/Wn7Rcl8RQFIxwNXJRH1SxgRFD1nNNg4WYT3/v/Bd+9rzE+oRFmOROZYeA8cOj9bxSZ0C6G7NdqglBbKv6wODI2gDXaJTsKZJ2bx82KXHA8tbuXWK0uPbbclbDlcCwuVGIeIKtT+ZmbAewFD11tkEfLDiB8b7+xW14T6+m11N3Y4zrgeteGM6xW5QmvyOaRodumWMoqQrbKKpcAgO0P7DY4vHVN2u6L1faXgESCijTlUDlgiYc6d+ROrfQSPmGelc5dQF7NN+w67kX4RZ/q7SKTl4hJqoIeqrYE5b08UJYzgsc3xXEqsiEn8IBNb4mYT2JEcDnT2Tq5nezcosUzibsthxTL0UJwvyAAqQrDCcaU3BSP7Pm25yPl8hsQrsEL09rGMwaa/Ms4nQecr86cR3Np1S5ka3ngiTEWEu97nlWHNmebE0VFC2WE7qWgF0GGz5XImMLbIyCeH3qh6nlaZZSh0mI7sMADwkLBGvVjX0c0vTux3QLehTiQMVfDblHoKX0jkhcvtSURFZoaeg5rzpQOGJN2ChC4UAtJLRiaqYWy0ijtpTJLa3/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EOmbFQzJsF9AK4gsyOcgHmWQ11sEy5w5BRoKz8kCuwzDxOCqXeDullwP8Tpd?=
 =?us-ascii?Q?SzelWR/aqM3R/kBHj3h+fGQMFeCJCXGgAzupihlY5AX8iRKODAlw5eToKAhM?=
 =?us-ascii?Q?4YrP5jWoMytv22Yb1WKMSOhEepr+UnoTMcQB9egx9e+/Cxx1I5oLv15NKBn9?=
 =?us-ascii?Q?SQ3D3DoaE5aIRvizCvF8EG/WkhQKbxTu0KJI04RrRwSGaDSievwn7trxH3II?=
 =?us-ascii?Q?ZdW5XRU1pmhMsKl+vVL2qbgL4MlhOH+r4MqMVy/O6IKLuWUf1zpj/3o0j9PL?=
 =?us-ascii?Q?P0yX8/MgXhtzYpRxj1EfIfvbGH278cqZ4TKVzBd4mKtMtvSx+QhpQC1JDUGI?=
 =?us-ascii?Q?3KSdkwV2VMb/vupOBCqGmF3BaiiWt2MdtB/l2Tiw6iwXT5Iv2Tc5xMlSXKUv?=
 =?us-ascii?Q?0n+jrOUL2dr06lNOeetu5VIKRsUB6Wban7aUbrT8jrMpj6GPHrBMBgWtaehN?=
 =?us-ascii?Q?/JR8lriS1RxhM8+RExTlswLyk8LZMpMVmcAq+2a0IVwVs/SKByXpUbr6NIPX?=
 =?us-ascii?Q?PrDHLbkvP5wcyLKDX2fqY59uuX65ehlkKXPM2r/IBbF159mFVGDAtTkaEG4s?=
 =?us-ascii?Q?sy/l/c/WTOn7k4l1dWVfJOnfLLFm9tmF92Cd7hxbIVZoz/HzCfl3Skbr+nZ0?=
 =?us-ascii?Q?iynhLJQ4jsumASljU/cPrd081pUPHSaoAt2gtV49wqI7I22htI3ks4gKe0RW?=
 =?us-ascii?Q?0YFHD0QSqz2gxeXiVgG1xNWrWOb4G7DVI0tWfZoVN4mngfvPaRFmJaoZsyVD?=
 =?us-ascii?Q?1isDON9RqiB0r+ITEX/0HF9CESQZ+inYhI2mzomY1NM6ICuVfZI1zlvY2tpI?=
 =?us-ascii?Q?VQ077Dsg7XulOW/rbN/jzzIjuUy+qoBi8IqU7B5BYjMeA/ggd1aWAauV0D7S?=
 =?us-ascii?Q?6REB1ltpk3Abo51AI9xCrFO6vlD+Gwgv+UVWC03ctkwA7pzvz1nDflLT0HJ2?=
 =?us-ascii?Q?3ZZsXfnM/EZm5jKXs81SCBSXepD9eTCARSHP2Qz/RJ0oRT1w0PgvdjvKMskz?=
 =?us-ascii?Q?dH3U2LmGBCBzHS6UtCVP2FPk/y5S1VIcaUb7iEsPZKQrj1pecAqLOsaGnMIB?=
 =?us-ascii?Q?gUS6hBE0wBOglZ90pe9pm1RiWzxXDdB9nYjTxiqlv94d/Le8pVz1Bpf714cm?=
 =?us-ascii?Q?oip74jo5ngquAJp4J/EG6ToVblaBPY2xujF3yXtnsxWXuVWEzZghHAQtKyVk?=
 =?us-ascii?Q?8MUwZWzvUzp69IxGTAUQepzAGf7KtwvEH0jYXN8Zlz53yXOxlSVPYxnVkxXP?=
 =?us-ascii?Q?QiGIgaoExBAZRhUK6X1EL4+4GLZqU0clBy/dy+iFz573s1pXuKFsUSfWZh04?=
 =?us-ascii?Q?TsYqXug4H3NoOlyskUvm90jnQWmN0dxw/S/AC5WQdzLgH5g9YR3FMMTwRg+b?=
 =?us-ascii?Q?wYrZ2RGCFiQi6oJwsJ0Wv/j23cbk0v8Vz+5DAbV51iqJo0twX/3tHftAAleV?=
 =?us-ascii?Q?Sj6THqcFrlgU66ekqGSR7cMxH5TsnnPdwGpQTAOnClNvrGbhLvLtLEDtGUjH?=
 =?us-ascii?Q?39uCEp4iroo1sAgQHbCXsX0jjOEzmeyT5PwbYwfM28F8N4STFqERhjkVOxpa?=
 =?us-ascii?Q?p5kGWvTg2WUeAmJVPqprXOcsPASvZ6YEUHQ4CHSKT7TAIkkTnPXQicVE3YAE?=
 =?us-ascii?Q?b0wi/X8NMim+QH6nFSdlJQdoYajEtsgNHTmARer8UQkPIf8NOffE9PI3HPR2?=
 =?us-ascii?Q?mMjSxE/eyF7xJjZeg/IoTAn1VZTLAVWbEYOa7UxT6BUFC3SvF/D6vLACNwMY?=
 =?us-ascii?Q?KROXWmOnaS5Q6CJouw6Yd9K93lbyXUS1upzUa2OLkW1iuZIHZv2/?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1172b40-8b98-4926-7d85-08de7906651e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:31.0612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYVNReLbWcdkS3N/iWL5imWcLC+q5NRFxmZBLmY34WTesCqT0ptan0L7u3Geui8FQrZIfCRyoDMDg9Td+eUVTKIMS9YZjBEMeZxt7cmZ8d7izodCzXXu4s6VbKjsLyyF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22048

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
[tm: Only the clock rate was stored, as the presetn and tresetn
 handlers are already present.]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index b1efe19abd74..12b25811bafc 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -259,6 +259,7 @@ struct renesas_i3c {
 	u32 free_pos;
 	u32 i2c_STDBR;
 	u32 i3c_STDBR;
+	unsigned long rate;
 	u8 addrs[RENESAS_I3C_MAX_DEVS];
 	struct renesas_i3c_xferqueue xferqueue;
 	void __iomem *regs;
@@ -485,22 +486,21 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
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
@@ -513,7 +513,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
 			pp_high_ticks =3D ((i3c_total_ticks * 5) / 10);
 		else
 			pp_high_ticks =3D DIV_ROUND_UP(I3C_BUS_THIGH_MIXED_MAX_NS,
-						     NSEC_PER_SEC / rate);
+						     NSEC_PER_SEC / i3c->rate);
 		pp_low_ticks =3D i3c_total_ticks - pp_high_ticks;
=20
 		if ((od_low_ticks / 2) <=3D 0xFF && pp_low_ticks < 0x3F)
@@ -521,7 +521,7 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
oller *m)
=20
 		i2c_total_ticks /=3D 2;
 		i3c_total_ticks /=3D 2;
-		rate /=3D 2;
+		i3c->rate /=3D 2;
 	}
=20
 	/* SCL clock period calculation in Open-drain mode */
@@ -542,8 +542,8 @@ static int renesas_i3c_bus_init(struct i3c_master_contr=
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
@@ -594,13 +594,13 @@ static int renesas_i3c_bus_init(struct i3c_master_con=
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
--=20
2.43.0


