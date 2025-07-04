Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF5DC83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.21])
 by mx.groups.io with SMTP id smtpd.web10.8386.1751619991645494488
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Rg4xGy7y;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.21, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txiKW7i38c6czf+9W6HOeX9AaxA5lbciA+ZloCO0Yd+aVTahkl/y1bgOIXPw5p6HHqQw3zK6xYqbFdrhP9/4fPPrDZYqsxNIo8lWssJvgMnEgSgDeDwhuDK/BGfyBgm8cj72yVj1255PseiK/xtUw6Ws4FlHJjq3znmnrtOurpbhWlISlf7+gT6W/osUDquIa+xM/twPhwwpAd08GXwe8rVaFgbgf4CfkwVpDYQ6hsdLCajwdD1HA0xkO+fxq/jN3jN7TWRPCSGCZKeFuS0NNrKla4cNrENSKs6GSkE2TbKuxnvQEFDpo8PxHNzZFe3QJ13C9k3zBHqoRxZIwwq5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ0i2HtAXx1rPWNOmg3VMNstRus8nomAYrWSQR7ySTE=;
 b=tkL4fcAwB1jvyGNmoBF1se7rFOjKYqnAwyDBhC1hkO90nLHaQckzSQTqKZLxmrIv1fjWuvpyrINdl2HmWwvZegyf9C0HdAADTuFjwxiPGJhybYJfCFRWP6M091jPDmTFbS/GJLpPheTKMAHg6VYAB4dMVY2exi8OvFg/aZjHnv5ujOYkK7clQsaetZhoOOAaDVFGnSnoLvOQUMWrCoklWKoNOGbcjmodgaBJMjvzOPpdazodSo3RU0qRLrUnsbMEjYO75IMZxH5NSoWllsqu13uToDRKWNbmholmWutD1zhEQ7+/izCdXHYeYAkEJKvNqJBpklWHZm1uoe574bhHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJ0i2HtAXx1rPWNOmg3VMNstRus8nomAYrWSQR7ySTE=;
 b=Rg4xGy7ytKHo40xrwqmR2tq9KK5adBeRrYzN3GnOeqSNDHlDVrP6FLiFNmQvgfpR8sdE9zsQ5H6Q6cQC4B7lWf6qQiJIjDkqfcqh+JXu31M+/8dIOgR5x1oTKIH108Y1BrjGV6e9YFv7d85555EOtih/LXvCmHisbydtQDylZAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/14] irqchip/renesas-rzv2h: Fix wrong variable usage in rzv2h_tint_set_type()
Date: Fri,  4 Jul 2025 11:05:46 +0200
Message-ID: <20250704090556.669652-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYYPR01MB13039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b943a35-55be-4e36-ce60-08ddbada0f85
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mjkrFKHG3GscFJSXB+hjtZrcjHsFothSedYtkdYMl0k90WZsxTejmbCmgiAK?=
 =?us-ascii?Q?2NVMWBCNAUiNBMst+st+K3ZYcxtxT5AMVLFZZqKo0Pm1jkUWy7SxLONKqph7?=
 =?us-ascii?Q?Ri+YY2KG09DmFcmeJhetnZmwmZ+EcPmk8P6jKR2LVxW5hY2jiFuWUWd8qr5C?=
 =?us-ascii?Q?uX4mUIeg41G1N+RWThh0on/caV6PHLVqoFCoBLsWDOPtIUtIrrCzFzt6MFrW?=
 =?us-ascii?Q?r4cy+w3GQCb7Z8zFg/6JdVf6KpyICdAXJYFMnAdH1zpV594T+NO8SfMBIqu0?=
 =?us-ascii?Q?j5cUDbVNzmk+zXQpZyOx37S7G/QI5jmUJR+cJyV5JZXO/tLUKPIVEp740MGw?=
 =?us-ascii?Q?5v4gZlPTZkbB8t7OuVrnOH/QINd2Uh6D2SyV1rYsC+aEo7fqVftj4IuhYSq8?=
 =?us-ascii?Q?JCwKu5e7KWLV2aqfAbkkmM+KVd13ddg4mNU6v0/sUs3ANww0U9/NeBr4AMGG?=
 =?us-ascii?Q?MAjeLJ8WuhmzFMkbVyt/lkpDxJ8OkLo0or8+nwYiMtsTSrws7fVIsqtoSezu?=
 =?us-ascii?Q?HLvrOmq9hiOryzaR+jMUXPOt64wJd0kA1P86mlpfzxls3aCnj8i+us3C4jaR?=
 =?us-ascii?Q?9/P/i73QJ3Is7UHfcQxgkO7IiPlaUbeHQZIldBI6s4RhknTPoH0kCnIt06zl?=
 =?us-ascii?Q?yMFyE4uIDubJPQuz4mu/SBbdCM1nGVYNsILgF6p4ESd1uVAib3Rok/e9C56G?=
 =?us-ascii?Q?HKLUjW5S6AMfS75Z1j8mTjKc74lWQQxRjO9gvKJBvllH2QohzsP16/AZu2if?=
 =?us-ascii?Q?k4zVwX+EjI35rwybUAUfS2mdZ3Kpjlcsk+ajy35iO5q54+XzLxGt591Z/5VD?=
 =?us-ascii?Q?aJutcqbBxWeHpKRicWZ8Q6XZ8pFzzE9QIemI6KArgun9PTd8jYZH9OZUmF5z?=
 =?us-ascii?Q?wdJln3Dc7u7HGOf+OJx/JeDiUHg3zH7zo3/nNLE5Wa7M9BCcx0kJj5k1xTG5?=
 =?us-ascii?Q?+C0bVlsg9Srv3dZd0YJ9UYMnoUJIzIsY/FrqDljqTfXgf8F71bKuGEPF7cQa?=
 =?us-ascii?Q?2Fe2YJ9D3NTqd3WwqjUxo46+mKXu0QYGcaZpIwS12fkthhK5C4n1OWdYZIZX?=
 =?us-ascii?Q?8YdGSclsIo0TsIh8UCcAIlFoTJEOABjMGmQCpYBmnslm/h63N6Vc1iX2coK4?=
 =?us-ascii?Q?TRk/uUy1WV3EAHouAlmtAsY34c5wEI5JMXbv3g5AfVQZ8ExaDbsgL7EV8IKO?=
 =?us-ascii?Q?OmDN7ZceC7iI4NEVu4bzoyxcpiDp8RU2cP4A6LVBSgoA6hGbQQTV1VtSsv8+?=
 =?us-ascii?Q?N7xW/fX3uQTYXQv+B2yeCQbSJYMQsQgaUwNXnkBKBFZjhY8edMbQUnxdlNpB?=
 =?us-ascii?Q?OK87gR6RMF4lBIN2aR5DJVDZ+bP11oRtRCWlBei1LbTWAlWOwCCxl4zSkXQr?=
 =?us-ascii?Q?ujWiGc58DUzK96UuXPaWc9OB5tNOD9e4tS3hog242YDUP1LffGM2ANVlXASk?=
 =?us-ascii?Q?Vga25qgVoCf9aBpydoOvaM6b2+NcMnva?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KSorX2DEvYkngHSvO9D6QMkQiBl7FexrtjB4jfIUNg+IFZgk6NP09mkpG+qu?=
 =?us-ascii?Q?HjTeqTvQThpR+p+GFX0aWlG2bu15D/ZxUonX4wlzkikURoPhCpGiC2GwQuJo?=
 =?us-ascii?Q?Huwb2buzyqOMkkyFdoLSLtSMbB6v6IXC2q35HSD8Q64TtXfQ5NpvlFdE9Fko?=
 =?us-ascii?Q?0XncjoW6+QRPgnI+fzoU3+cmYoQpMKPf2fcJNErhB9kjmIIR8peMSU0ow1Yf?=
 =?us-ascii?Q?wGLLIGgg/iDQ2rMy2cRCL8kpfxLD/8IeyUVgTH81vPPvWeAvTCJtIq9A0r2Y?=
 =?us-ascii?Q?HBw5vppm8RghlOIiWv3soWiG1eBERYVbyA/nRg8LB7wc5c4O3Dk5C39PIBNt?=
 =?us-ascii?Q?AfU6D2N/ahjTPTQo2J/piWd8YA8dmA+rBcgeptSMezXFY0F5qanGwjZ9iA4M?=
 =?us-ascii?Q?8SQF7l+DfgSVlNDFl6hzjAT26rIZtYZi7+ZsFtb+MP3PRzkt+45hjS41IXWP?=
 =?us-ascii?Q?GFcMCUugkkCUc9mGk7VeLPJXxrlgAaQKdRZt7XHkj0D0KkOvri3TSB5lzAjs?=
 =?us-ascii?Q?QuVDcJHS9htvbLdwfupZspiOkxT7z9UjrS4MfHxKKFfpm6BQPLown+XCrsUK?=
 =?us-ascii?Q?YoVp+GM0dPaJ5hCgZsWXOaOQHo/YLheWcOAPfM8THKxA2AL0zYrK2sFhScCV?=
 =?us-ascii?Q?WFgx9sWe2vlKHUpF7+qTwrHKmSxDgNhThr86vokM/7/Azi5TSlHjdyUCEMoc?=
 =?us-ascii?Q?xb7W/qw0ocDe0yfJHMoeZVD7j5L+8F2jP1iWLWNOSI18EjVrr3omTBK9V2Qe?=
 =?us-ascii?Q?/ZvoMCiGM/bvc1BeJKGFo4QPVVjafv75QijWY6moMAzkEKkSjwc4xCn6YXnx?=
 =?us-ascii?Q?0d9RAcz5RRWWyCOOk/X8OwNyBfo+MhU1/6CIOo8tfMDQOfhmSTx67AozyTNx?=
 =?us-ascii?Q?to/LAFHETyhdVg4hAEVSyjaCnrfbhS/GwXCU0BsZZk7H6ulwFZ6ibnDYSxFW?=
 =?us-ascii?Q?QiNab/8whjXJXNySIGVDUXQpETQtYAqWLTpUzirKABCgC0Gt1aU0WCg/+R0Y?=
 =?us-ascii?Q?k/9EIEE040hvjWClxOhw6col1E14Wzmx34tViYvzxyFyFPmAQlKqJoYnJhx3?=
 =?us-ascii?Q?RDYqHFwAlblBw7FIg86PjXBYTMEqo11/evbFkrJGvZmmCpKMipHH+LpzNqX1?=
 =?us-ascii?Q?yayHeZsYwIQs2EdOvJErZxxYFZQxPJGi/CnRF8T1rjndMbTCMBR2mDttKQ02?=
 =?us-ascii?Q?yO1Z0irJMm5rAq8sr2llVImN1WbXcbPNUd1LllhulhDS8TGzDjmE3teYefRn?=
 =?us-ascii?Q?infBKxhjjgsa/9ihpLdInWyhj1qqsjIjJwCETdRh9TxlAUTnUkxbgXUmg2VY?=
 =?us-ascii?Q?SJ5lQ/nHykRe+Lz/0CEx3oVjCj1MwiYjNvg280InxezqSghp6LoKk6uWJvgr?=
 =?us-ascii?Q?gXIuE4eDJwETbPY3BAzJA2cKxT66n4CsmquPc8BRIPPsgh1JJU2LSTaM10Bq?=
 =?us-ascii?Q?/s5xtsvnl25zjoLXDSId+i7v+a4aE88yUnzIXNrOXFwHw3c1iODS3psD4xu4?=
 =?us-ascii?Q?gaZMa6I5RdlD+NZsIYSYeNz3EEacqNB9S7ucrVYTTSeoyE9hBnE8qPt3sF9e?=
 =?us-ascii?Q?gL+RqpFrYqwUW5LO/vXis7ZMNfwTHLmWtEmnNnkvvWGdp4znItfJ6cYZtslR?=
 =?us-ascii?Q?kvzQU7JBm3GeLIri9jg7y3U=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b943a35-55be-4e36-ce60-08ddbada0f85
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:28.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjI43Aeqj7D0XrhBZz7oZFeovdc8WhM04B1laxivezgWz2qBBko2y8MdjCD2DJ1R/bnzYVeUkwCNxSxGg06ihDTYWoveS0xLRI8t7tCRmcjSuIqBpfit3d0IyLthF5bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19333

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 72310650788ad3d3afe3810735656dd291fea885 upstream.

The variable tssel_n is used for selecting TINT source and titsel_n for
setting the interrupt type. The variable titsel_n is wrongly used for
enabling the TINT interrupt in rzv2h_tint_set_type(). Fix this issue by
using the correct variable tssel_n.

While at it, move the tien variable assignment near to tssr.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) d=
river")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250224131253.134199-3-biju.das.jz@bp.re=
nesas.com
Closes: https://lore.kernel.org/CAMuHMdU3xJpz-jh=3Dj7t4JreBat2of2ksP_OR3+nK=
AoZBr4pSxg@mail.gmail.com
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index fe2d29e91026..f6363246a71a 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -301,10 +301,10 @@ static int rzv2h_tint_set_type(struct irq_data *d, un=
signed int type)
=20
 	tssr_k =3D ICU_TSSR_K(tint_nr);
 	tssel_n =3D ICU_TSSR_TSSEL_N(tint_nr);
+	tien =3D ICU_TSSR_TIEN(tssel_n);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
-	tien =3D ICU_TSSR_TIEN(titsel_n);
=20
 	guard(raw_spinlock)(&priv->lock);
=20
--=20
2.43.0


