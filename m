Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF8CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7013.1778751747074522382
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WrxdEqQW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.4, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaIqsk2wqtItshWgnAp84pG16kCVMvfAUnXGD8cVlVsWIQswGtRjnkeSwZfW00r3rZLZN9Z5KGuMiS5AJIuHBTGOwSbtnqhv9uHUXzu2ZfLcf5OfWntJQ4H7MFfW80XSnC6g8CAAHLR/YPr+uGga3IEuH6yb/WQWumEV+1tHQmXlftAmy5WR3LWCD9ErhFa2BMSr9kkuaGukG9oe93EgdLMusbrxGnQ1MGLUfv42vpXWWhUJnJbReqD4jjNWHg8ZyZI2aU0ucyHGfxbMFDDHTljTDr5wpI9l3lPnctd0GefVK30Dw7/15HlrQX2iwQpHzbj+bt7+La5JAmaJtlZtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVqaKyNvvWGn7RchRYqnTIw2g0p2n8k24jDndlFMPxU=;
 b=kcXW/aXAbtCx3TvuD7CGC1YKN1eGKPI5F6oU7OtPCKnL2XrkPYbqxYCbGlccosIOBqCEUgdamgCSbrzR8B9nLo5vqEzeX+EZ5J5mjURrBf++iWoJY6sTUb9IYfMEnrzS6Vwyr+rPyjzFd0zm8HAcAXCeD4I53cmCVS+xHC9gmCl+GibL3VUfo85iuZQ8VqNoQj3v7rmykqiEmf5jNpj8ctbg2wZx/66TCztRxrUXl2yZ3einI/HTAT92RRwrVajMyCQV3BtICWbAGH0wGRwdS+uaq3XD5uCDEnQzHeVIW6kYd/gqpQ7eYrTHB5iZbMfuNWOi7s/sUO/c9q/vy4p+TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVqaKyNvvWGn7RchRYqnTIw2g0p2n8k24jDndlFMPxU=;
 b=WrxdEqQW9rjJUwog/KXLSCZ2L/q7tc1Foe20xXFq+BA3N0CgNNHJ4qkywgpHmNEJEQjaD6c7WWMQnQ2t7SY+eyH22swkLRP6b179UDH54pAFspbrAO3sIPbKe9B/k+d39Q+7a8HlPu6/kEqA2GpdBjdeSOJlmB+70+LKxx/VDS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:24 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:24 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 01/17] clk: renesas: r9a09g047: Add PCIe clocks and reset
Date: Thu, 14 May 2026 09:41:36 +0000
Message-ID: <20260514094152.2215176-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f81ea10-36f5-45a1-243e-08deb19d1a2a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	FJvTlk0YedsaHkDIhy8QfUS4MpWa0YZ12ih3ayM0/XSiqBPnIGYc3N3qP/rLCkQes/VmV/PrwKE5yYPv881GUSzub6OYxh7/WWnptsINggWWsHr7ncx7lxFjIYehAI+vgJpSXWokptYDig0NRHj7LSulR2rMIqRtJCQ+h8Kdq92mRombivrjtL/kJerNQ4qMKQKxo5M36XthXwb1hybOCKqjtjaDQvI6Kp9nAKpsXafZBlv0Zh4gxoEKJcatNuxV97JcdHXnSyNXaY27py4xcBot+yDgBIWKcTN0GgoHU6N7DwgMaaL4HtaREamWTxdvQykkvsXeIbz/L6e4tR2b0Y8MCidNmqhuqG6Keb/IMESy/0WV2wJtt1tSmtGlPZ611ghVm21hekF3xcAbaZGHHLryINZQZm+d44sSGnX1+W5QB1MMXnD4e+VDPzEOV5ryYIaqOkEGRqrWWflFuRLU/NwPpJvujS0pRPxwEJNxwvwuZANYn3MC5gzMk7EOYkkhSQ+qYIA1XxlskkZFo9zRjnO2HGAsIGkDBEKyzSckH/BRUaJUGeLoXI+XEeinHZp3M30zkwdejulQCVhpfxVvSsjdZ+zTnGarw18FThCXcaEVrcumzGQwCp6zIWmRqBOCxqopj9cE7vFU0cNKb4IJME2Me2aCm3kOuJzvJbNbIFRHNfui7c2scb49Zex5+NxohBUf9KvOabL2DM6zkQFdOQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?k1Mv3SjCspOSzjJ3vAzwhmTty+LBS2Cw0j1KWXxQAKwKeXb4yNXNwGfcCW2p?=
 =?us-ascii?Q?iBagOsARg5cIGN0KJQTMkwTdkq4r2g/YJZWSYl56kgonstPp6hztVEpDfMTW?=
 =?us-ascii?Q?vu3oBLx5LZypLVKfeizCNu+0G6RHupFoyBz8Pg2QKqFd0D9JwkDcdjB6Nqst?=
 =?us-ascii?Q?A1Al9CzCJt6kDwVlAH5USmwL3GzqLT8yxRU7m0BOuJL7namsxw3sd9Ozx4WA?=
 =?us-ascii?Q?4eIYMb3heX2C8pGdQ5f23oMSoHoXX4UoPHZcsmMmjdqeb84jHBg/JUMSh8WI?=
 =?us-ascii?Q?XHyRcZ601fEH6h1NRepzPs+RoZSQJug9AmV8DT1KSr9ghhfXQy0tUC4L4ZjS?=
 =?us-ascii?Q?Ov1ES7sFmmigoJzq+cgeG/mLFbrisf8p5IL8tJYsLK3Ou+K9iJqhwAJuJCZv?=
 =?us-ascii?Q?jfrMFTHQYawApcuETFJYWkUYKsggVoZLA+NfS2qv42rKlE9907UM3L2+N7Qu?=
 =?us-ascii?Q?W5xR8crUvGEDe3ife1fBsG3RdM7KNPCOhCu/VQKwjkEln4kXONakaxnIjqv9?=
 =?us-ascii?Q?DOHzKPpPhjTBe6fk6BWe/BSz+ZiqQ4Facto9tzbF3MiLDr9Z30gfYwzXPneY?=
 =?us-ascii?Q?JR8/hin0UTsmR7kGMF/gyHhc9EQKk9mKE/s7deE/vz7TbR79XntBCAY4XH8h?=
 =?us-ascii?Q?4a2Ow8oUggaAIH4jKwv6D4sNbiMLWIiuEBkRYFpYQRwasxnKq4ZuCjWQtZYh?=
 =?us-ascii?Q?UH6NSZY/szi21T98UlAanE0VbsxR2JG1MxlzWOuotISUDuwtlXrL8dlh7aTB?=
 =?us-ascii?Q?thkxXVLD+GlxiDn18BZa+GhZ80qOk7UMsYl3ciYb4KKaTjM4U5T7wM52N+GN?=
 =?us-ascii?Q?FGS5QTYvDQmgZxk1Il2A0EK+1QrVCp95TDNSJh22ukG0wzbDFO8BgnWOa5bH?=
 =?us-ascii?Q?T4AtY9o03lOtllCWQgap4+umYH7offWYwUbq5UBSVWWUtMUVTjh6GFJgkv+4?=
 =?us-ascii?Q?gcFaIdAhfcmHfbvhrXMLX+DEYSaNkiIC9kFFTjo4u9ebStTSaV8fZMHvWxxy?=
 =?us-ascii?Q?E8eG+nIDT/dX5hvKZBH/tEweG+5nlT/PFtBg5rJOYcK7cJcFVB6526+OS82I?=
 =?us-ascii?Q?KEROwwn4MAHZdV+79RsUkIN/2tx1jWWc7CRU7ESQX7CeE0q8yPAwBsKJzoK4?=
 =?us-ascii?Q?NpMqAx0ixLjEywQIRuQcI79V95Grh4qQ6lQkVUPBAz1+bjJhFDVg2xlyg6FA?=
 =?us-ascii?Q?Ya8xDxPuWEYcr/MOtO3G8JOAMJwzMPaG25wH2VbLZeRwR9nQzpCs7nTFpOJz?=
 =?us-ascii?Q?Gq/+b1d0B0PI147uyVB1U4l/JnZ9g1exCTBB4/B0WVWEAq3ka2kQlH/A/jIB?=
 =?us-ascii?Q?7MPd2I47ki6uddFTp2xUEXBbx5qFLj3+d4N9CNq61BsFMcNirq3CI7Oi29EG?=
 =?us-ascii?Q?kNT3RjLDvOlcTWRaI4bjbSB16yWsTMpKAyyZ02BR03LwjfwWu0ebT82Eb9AV?=
 =?us-ascii?Q?n4kNajpmM6iQ3c0/ZIFY/JouBpJLASfQVPZVHupr5ZX7Y7AooxPTFUbzuf+9?=
 =?us-ascii?Q?7bEVAJV8q4Awl3+PpFtVeJooEvT/gv6/DVo18Bn92Xbp5OP6KIVFfFRsuOmo?=
 =?us-ascii?Q?tM4PI8idGp4CNH2l3w9B3Hu2VNohPWgW8gEGcZEU9IHDxS9if2fiPP8u1xqZ?=
 =?us-ascii?Q?U+pnikXj/EySsJYE/2buUFuur83XG8mOJkOHMYb63E8dJ4LnhgsMYMwBcOOi?=
 =?us-ascii?Q?WEgH+KAtbPC3BKgN+/1TJdFHVFaMVVue3Jx8t6RGZBPgSN/h1Q4PBQ++cmtp?=
 =?us-ascii?Q?Qeu9MCkuV9zReiGSxlDiVQLUQ04t1J4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f81ea10-36f5-45a1-243e-08deb19d1a2a
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:24.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P3ka+XFUsFEidc2koxfRmGUtBb2cYvsd4O0Vm4+yqIDNgsdtcudY/K3VbmMQQxPc4BNEH3Sy59mvMWLii8/J9uKQrq8splx1X+AgGs9M0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22953

[ Upstream commit d85cb4ff46c7b7f393b30666a41fff18962ba21a ]

Add necessary clocks and reset entries for the PCIe controller.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Link: https://patch.msgid.link/20260318085119.44717-2-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[john.madieu: Fixed cherry-pick conflict]
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index b112e436433a..728a72093d87 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -408,6 +408,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(6))),
 	DEF_MOD("gbeth_1_aclk_i",		CLK_PLLDTY_DIV8, 12, 3, 6, 3,
 						BUS_MSTOP(8, BIT(6))),
+	DEF_MOD("pcie_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(15))),
+	DEF_MOD("pcie_0_clk_pmu",		CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(15))),
 	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
 						BUS_MSTOP(9, BIT(4))),
 	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
@@ -479,6 +483,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(10, 10, 4, 27),		/* USB3_0_ARESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_0_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
--=20
2.25.1


