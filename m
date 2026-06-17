Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D4CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:25 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10921.1781685081141254903
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HxVItQoW;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.54, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZexHqzof8NwmIY86sGT52f6ZR3lGoAjg1983Bi/PPY9Qe1/vqHQoey3CMH/RzQN2GVZiP1kFWrItFwXZ9jSJU8ZmdB8GzbsokcN8eSoHjxG+PLJyFPfNJpPl4uQoJi8hFT/l54ptjjjVLihw+i/amUXdp5M6Uxu3J+KQB0IgnHaFilm8EzplHWaDHwWuInBamqha2ces06x4jNUBTFlKOsagyQUvG+eiUX7GbAPzPDEekJgIvrtpccxTccet7W/MbHwzgid0XpBgFVM3jekjaeG7Pg3NuIgTB+sZd1IbwFFqB1SkAAlk1v+MQ7jqIus/C/8pswJrbdrXC8HV/f/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plDi9J/svtOkT7B/wIesSW5SKJkUwCkqDpe4ZAyL+EI=;
 b=cMo9agz/PLHiftkJA0fjVEPiEMnSjydHEi6SKJJr0bbG75ix+tDVVL9T29e1zULFszuc0fMYH12bd9G+eBqkhr6MgUFLgVks5AhNj6HToeEM0pQ9NmE2n5NEJpwGjSjfFw0ez5b2li/2mziWMwIySfUJzlQnVvU8SA+apajRQXmCqNCtpnF0fXcFjBapsTELH2GnVn2cjh8Bo/5CehMreC04q2KoG9jd0BOhgpwrSbWKoqe5nfhlnFqE1tIgMLeFvwqC+rtJIljnBENbBQ5oafdMqE0WP7xwBnXiTtSi+rrstJFvYbFrXpdJ6cCe/LFAQOq1i4ONbEUKrjRpTTXd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plDi9J/svtOkT7B/wIesSW5SKJkUwCkqDpe4ZAyL+EI=;
 b=HxVItQoWZ/4t274ilE+rl95bO151MA0vygcDLiL4vBxA7ssBGFBhaFJL8owkhtK9T2tUWYOpRAqZoi0HcLYd5erlRCcr9kaqkPROUaWSUm9Ov7Q+RBbuUX0K8Z4igbx6Sf4s2SwOR3f+g2cCB3E30De6HqJzo3vnBI5ygmYcKuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:18 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 17/32] spi: rzv2h-rspi: add support for RZ/T2H and RZ/N2H
Date: Wed, 17 Jun 2026 10:29:48 +0200
Message-ID: <20260617083003.1071543-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 48fd9083-50b6-439b-b30b-08decc4acd29
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	HrvKg+yjxsrW6VAE9g9ttxkh0kyjnHKJuoSNmpP1IBknJ3CfgbgnX/nGr5g8iTT317X53YgoSZ0TnYinMeesXA03hD/GpyZhoJndIlJTZ6Zp2zYbwB90+WiyE3mSIyPViE4r0h8+7AU2ydoZcWVBYiIPtPWPqL0ykZNJ3gJdGZ253T3BOEvhkMrgHudLburGgFWyPCxO9SYSEuIjWh2p3OoCSfWSgZcHRg+qtHjkO6U6B2QOPmX2rQLxXqC9ThA/cCSngkINrJNtFHvPbe3n+Gt6yLtSz+JV2Lja7I/i8SM/9Cbvc4Kz6aNLnFkVqNyCJbWF5yfltXldGWdJqi4HIiiHfLFvsLJyq3a0NoPCkGBRyBokjVFQXmasAmNhy7J9bAznJGO8AZZAXOAMuGpfQGNj50zN/zJ5BImOyc0f+xnBL63h8aS186L2uEUB3fjrdwAJN2vv3mhMX5yiUkFOue/DjH9Nvb6pxKwMqHTxyxyCHWzCjwjzF0zT8kNNs2yX3S279L3nQrTAtMjkDlAzSz6vtEwDClv2gGQn+OoV0YcV2RfRWSxknfxhErrkx6WTpzRw4hh5AfbztCDPCAbPJB0He1yxjz+0LiB9rNzXmQvdYbh9IUF63Es/lW27CyXB16qBYk7AyGuRSKDnkvjDIOPjV1KXRxZssWlzmkA+F8x7x7mMpIQs7iD+nJ3mKYdVHu15lLRRS/IFPGXUxOUxrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?63AQffRTj5ojEmmFo/RHLm2f5roo/G6bLEEq+9uee4utVBdQjrI3hUoJp1ND?=
 =?us-ascii?Q?u8YTlILxidMC2h70HdoHH1TVviO7EamOG2MGMyjK1SrYYb5HwxGwZaL/iYQP?=
 =?us-ascii?Q?M+9/BDSWGSGv7sB0vMC70HkweGKBY0SiiPTAcKZwWoiqh7SK1g0CSmGDVtRk?=
 =?us-ascii?Q?7c+Zrcl5ELxseujbm0bfHzs3YL7ZggT45dW07xfYSnrWhvG2rNDoKqkNvgF/?=
 =?us-ascii?Q?8Kt3CiH5vkEOvAQuLn7xBuLx4219h7hMOrHOIRFN/PJX5BN/yQWy3k77zTJn?=
 =?us-ascii?Q?NRe3YDtbNgNzIbpFLIsGU8osjF+Ga50iUXgOODDAkGQNxNunlL1USpUt9x73?=
 =?us-ascii?Q?ljeI3BoqXiIF5yxYErxBk7jSOHPplXUDmfAqP4MyWZI2CeT3J03VSEJ1f0Q4?=
 =?us-ascii?Q?qj4a6cmVbSvGtzZqhoJbAx72Eu5I626rxylhNia6ancC+vD5Xc41giNO1SzD?=
 =?us-ascii?Q?r7tuE7otORRSjDhBKg0bdFSgqcma+BLHegUnCGUqjJL5OHmHbM+WmXT5r1JK?=
 =?us-ascii?Q?Zu2flmarIObTfhhX8YNkZRxUEaqf7tKaROk/Ttob9vdUV9hBD+8tVXUvR+TK?=
 =?us-ascii?Q?uHc1DxO6n8pSsxAwHEtvu6kNUTvAk32gco0IB0WknVX9YazM0PCjdO2po9D5?=
 =?us-ascii?Q?8iQ6zqfGTxxPVdvcfFZT8hbxyVmFOwjsUn3wYLLMQIpJ6UyTNpK5Ko7WkmdU?=
 =?us-ascii?Q?cMkrMn8C2ty275/HbypGtJbFuqWSLktNQPXtXFAKUxPfhCB0kvngPZh0Mayh?=
 =?us-ascii?Q?Z/RGwdT3nSD8VnW8hNpuLXmiOnQA4W1XhaXEMWIv4Fr0OxYAZ4Su2KFXo4/V?=
 =?us-ascii?Q?nBcolRE7KjxpDZ2EBAEfFUlK09HzsHOyGuxW8sFxwoPwy/oG+U0/9pNLeqZK?=
 =?us-ascii?Q?hRqLsXF0KbX8lHg5EeO7oNl1kvBeL85EZJYT0NdwhG19F8cHU4W0ScLc4NRG?=
 =?us-ascii?Q?HgIhl8QcJGspPZLoRylrUYjHs5U42WO6aaRKMp0vQnRTVY5YOME6CcvDmE2V?=
 =?us-ascii?Q?z/yoe0miNatEqJrIZC0dFw6MQd52isAp4hXm8IGUAmD9D5N7BHmTlUU9c3bE?=
 =?us-ascii?Q?eIulA/pdhA8e7qL+uJWzsOAB2NvNGR82NmrMQh02wiIa30epcFzh+5fOLSGc?=
 =?us-ascii?Q?+dF6N8lY6/uVY1uHEEPxBOOaHvMtTavVBiScuZD95pEDySDciIAyvbv1J89X?=
 =?us-ascii?Q?2qRYVOH6yQR7/ihZUMXHr3PjZstD5ZkOmTqMGUoNFvqsaNdtusU2LAbYT6u0?=
 =?us-ascii?Q?1bH8OwS3xd0XTcl2YtjA2i07x/4bW5CiiWF/LSxNhuY7lhDu45nOyeWlsL+I?=
 =?us-ascii?Q?3vLcQDJ6Aa8BKVNzLrSrAcE1qDV3byFu0JNk4jF4vR5l4vHANiO7DkQexx+T?=
 =?us-ascii?Q?kMfVTXU5ywE9vVssPBgFT7Q0nhLLyGYWhFlY3kycWIcBWEosavhQ6yebasiq?=
 =?us-ascii?Q?d0EHAItTLuHZSUmksUrRaVzGAJfT1OHY7oQ4Rn1cmz6163S3tFx94kH7w6+3?=
 =?us-ascii?Q?QKY56/f2mfhdMJxIaBMFBWTuvA3j0jOGna2pCPS5tTNGr17jK6sqGyfiPTDX?=
 =?us-ascii?Q?GhxO2BqtR2STMw62jNVGPkxwXuJGDYseDiWQZGvRVzWw0dzGpKkISmZniadz?=
 =?us-ascii?Q?Ckm5CHmQeafVquxwyA7Mo4cXYB2w9tm1NfsN0LjaOK3LSPHdltJeTE0O6hqN?=
 =?us-ascii?Q?jQ9Y1PZO7wYjHZX41wX0TmOKNkPZSWSYmxffnyeBUDs45SpZQ4UiBEiz9etk?=
 =?us-ascii?Q?Bx3ox6eDFwRZ8NTniWTuhNVTnZzIeES33N9VojE9ekHG5uJPP4pu?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fd9083-50b6-439b-b30b-08decc4acd29
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:17.8991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31D0+/NJ7C3HPVHjPYCzxlUInZh8wzH2iRIs4ukDtuw+eGYT3Asngb58pERMM+mTb6pp6X5r7Pxg3/zCyIxKStdTyLS1eAACg0jjY8JOZz8oxQXb/m7GE98M1P2hdJu2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23176

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 0cc8cd824b9fb7fb087a2ec6b0c80d812cc4fde7 upstream.

Compared to the previously supported RZ/V2H, the Renesas RZ/T2H
(R9A09G077) and RZ/N2H (R9A09G087) SoCs have a smaller FIFO, no resets,
and only two clocks: PCLKSPIn and PCLK. PCLKSPIn, being the clock from
which the SPI transfer clock is generated, is the equivalent of the TCLK
clock from RZ/V2H. They also support generating the SPI transfer clock
from PCLK.

PCLKSPIn supports multiple dividers, generating multiple possible
frequencies from its parent. To handle this, do the following changes.

Use the minimum frequency of SPI clock to calculate the SPI controller's
min_speed_hz, and the maximum frequency to calculate max_speed_hz.

Add a new function, rzv2h_rspi_find_rate_variable(), which is used for
the .find_tclk_rate() callback, and which supports handling clocks with
a variable rate, with the following overall logic.

Iterate through all possible BRDV values.

For each BRDV, calculate two different SPRs, one for the clock's minimum
frequency, and one for the maxmimum, and iterate through each SPR
between them.

If the minimum SPR is higher than the upper SPR limit, the minimum rate
is too high to achieve the requested SPI frequency, skip to the next
BRDV.

For each SPR, calculate a rate and let the clock framework round it to
the closest supported rate of the clock.

The rate and SPR that generate a transfer frequency closest to the
requested SPI transfer frequency will be picked.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-12-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 3c1cb76bc7b4..2f4feaedaf97 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -258,6 +258,105 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned lo=
ng tclk_rate, u8 spr,
 	return DIV_ROUND_UP(tclk_rate, (2 * (spr + 1) * (1 << brdv)));
 }
=20
+static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
+					  u8 spr_min, u8 spr_max,
+					  struct rzv2h_rspi_best_clock *best)
+{
+	long clk_rate, clk_min_rate, clk_max_rate;
+	int min_rate_spr, max_rate_spr;
+	unsigned long error;
+	u32 actual_hz;
+	u8 brdv;
+	int spr;
+
+	/*
+	 * On T2H / N2H, the source for the SPI clock is PCLKSPIn, which is a
+	 * 1/32, 1/30, 1/25 or 1/24 divider of PLL4, which is 2400MHz,
+	 * resulting in either 75MHz, 80MHz, 96MHz or 100MHz.
+	 */
+	clk_min_rate =3D clk_round_rate(clk, 0);
+	if (clk_min_rate < 0)
+		return;
+
+	clk_max_rate =3D clk_round_rate(clk, ULONG_MAX);
+	if (clk_max_rate < 0)
+		return;
+
+	/*
+	 * From the manual:
+	 * Bit rate =3D f(PCLKSPIn) / (2 * (n + 1) * 2^N)
+	 *
+	 * If we adapt it to the current context, we get the following:
+	 * hz =3D rate / ((spr + 1) * (1 << (brdv + 1)))
+	 *
+	 * This can be written in multiple forms depending on what we want to
+	 * determine.
+	 *
+	 * To find the rate, having hz, spr and brdv:
+	 * rate =3D hz * (spr + 1) * (1 << (brdv + 1)
+	 *
+	 * To find the spr, having rate, hz, and spr:
+	 * spr =3D rate / (hz * (1 << (brdv + 1)) - 1
+	 */
+
+	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv++)=
 {
+		/* Calculate the divisor needed to find the SPR from a rate. */
+		u32 rate_div =3D hz * (1 << (brdv + 1));
+
+		/*
+		 * If the SPR for the minimum rate is greater than the maximum
+		 * allowed value skip this BRDV. The divisor increases with each
+		 * BRDV iteration, so the following BRDV might result in a
+		 * minimum SPR that is in the valid range.
+		 */
+		min_rate_spr =3D DIV_ROUND_CLOSEST(clk_min_rate, rate_div) - 1;
+		if (min_rate_spr > spr_max)
+			continue;
+
+		/*
+		 * If the SPR for the maximum rate is less than the minimum
+		 * allowed value, exit. The divisor only increases with each
+		 * BRDV iteration, so the following BRDV cannot result in a
+		 * maximum SPR that is in the valid range.
+		 */
+		max_rate_spr =3D DIV_ROUND_CLOSEST(clk_max_rate, rate_div) - 1;
+		if (max_rate_spr < spr_min)
+			break;
+
+		if (min_rate_spr < spr_min)
+			min_rate_spr =3D spr_min;
+
+		if (max_rate_spr > spr_max)
+			max_rate_spr =3D spr_max;
+
+		for (spr =3D min_rate_spr; spr <=3D max_rate_spr; spr++) {
+			clk_rate =3D (spr + 1) * rate_div;
+
+			clk_rate =3D clk_round_rate(clk, clk_rate);
+			if (clk_rate <=3D 0)
+				continue;
+
+			actual_hz =3D rzv2h_rspi_calc_bitrate(clk_rate, spr, brdv);
+			error =3D abs((long)hz - (long)actual_hz);
+
+			if (error >=3D best->error)
+				continue;
+
+			*best =3D (struct rzv2h_rspi_best_clock) {
+				.clk =3D clk,
+				.clk_rate =3D clk_rate,
+				.error =3D error,
+				.actual_hz =3D actual_hz,
+				.brdv =3D brdv,
+				.spr =3D spr,
+			};
+
+			if (!error)
+				return;
+		}
+	}
+}
+
 static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
 				       u8 spr_min, u8 spr_max,
 				       struct rzv2h_rspi_best_clock *best)
@@ -557,8 +656,17 @@ static const struct rzv2h_rspi_info rzv2h_info =3D {
 	.num_clks =3D 3,
 };
=20
+static const struct rzv2h_rspi_info rzt2h_info =3D {
+	.find_tclk_rate =3D rzv2h_rspi_find_rate_variable,
+	.find_pclk_rate =3D rzv2h_rspi_find_rate_fixed,
+	.tclk_name =3D "pclkspi",
+	.fifo_size =3D 4,
+	.num_clks =3D 2,
+};
+
 static const struct of_device_id rzv2h_rspi_match[] =3D {
 	{ .compatible =3D "renesas,r9a09g057-rspi", &rzv2h_info },
+	{ .compatible =3D "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_rspi_match);
--=20
2.54.0


