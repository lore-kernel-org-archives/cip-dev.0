Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A94CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:37 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10841.1781685387499330774
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fAhNDjGq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.3, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzveUErTeouTtpds2VG2MzCbX18gSjy/AP8A+lM6oOOZHV6ebBub5wK4PvQ6BepS+dWJHX4YalEhk3nH8v3qJdv/RexYIf0xbPYPGnuDsLFVCK+qSe6C0aziL9ZjrF5aaCA5iIKlLd2WSR9aaBlAShZc4DWGGHzD7L2xlcu6TisQR/8dJPA/uuOQbTgFahJrWAneMIznnTmrz9Aq6YId4fvk+plI8gnhTyvLovGKnG4VC/vbrUXfXhG54nJRZrIKbvu3kzPzMrbzDBHpyz/9Zm+nFSBqr4olRQlSDN45fjaAO/l9jiiSOTQWs2GRps9vWY0y0+XXOF5dXZlIiJ1PmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtJLoHGIJig7E6g31E+FVq50OYCZM+saErpYmE6OPDs=;
 b=SlbypAHn0+Yye8/uc4BdUK9LFS2Tmd13FzOX3bUczx7GSQ9JWqzkIgU1etQn+2Bx13QG5i1XC2S9ptskCGDTFtPy/7Tamgl2n3Rnpky+U8j8RGCS0tHx1qhWzwWnyEeRj9bGQD6PUpjsdHGu0dUh3vpnQdDxCaRs6voKDxt/JxqrvEx5vMQWSQdI+U1jXafWumTInSU+WcJaqqruap1xzHi2WEKJsY8XtGT+ZP6SwQr4rg5Quqe6YDKSXT6ZWwrBd70JUHWW7uFhnfldz+FNO7EpN+2C0hov++D+FUlKDLPk/O78oMMEPEitrIJulqD1Ur8ZXnTg9Rqml3I79Fv43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtJLoHGIJig7E6g31E+FVq50OYCZM+saErpYmE6OPDs=;
 b=fAhNDjGqZMXGY1BkZAaupNH7Xw129kCdiOe06aceJ6QxWNxRvhw5Wf2DMpth/7+48BIw7PnCiNzztvc3Ac1KuyOaBmk40XM4/tQBIvyHMxeT2MUtieglv2n2/38y8/ygNHN/7VJ2FuubLXYMRWf5x7bo/0WZqZWYAj8XYT5KD5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 20/24] spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
Date: Wed, 17 Jun 2026 10:34:58 +0200
Message-ID: <20260617083502.1074160-21-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: 7382a37a-b059-472f-8e1c-08decc4b83f2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|6133799003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	7ynZZGuHYMgxNDXnkTEZxexA45YqFELsw7//CzpuEMjxRCbVqpGVJ7DfK0JYaPop9D5DBuFHA8foSEBgsz4vq190WdfgCMk9xWqQqlx1D2luiVn8dpZXkGsDqw6VJf6U5BXOF+fV94usI1xkuT7NJFXbv4hRLHHdxO8uNpvVwh7eUDKCZn14TFp8TzO4ct3Whir12+HKGWCdm22/un+XOSjC+4YsSgTH4SipDU1BlHgyw8oj5S/Vzsblq6nb890nqnusDgxpCB5fcTw/zlWwGqvDlRCdMiV4JnXA5u2SlWYCaFN+XzndaS8ynq9EiciYRsvizHZ/D3J0gnreT7EimPoTS1r4YGtx5KRCQwEZHlAa7jkFBgOJKIjPk4JwTSA+lXsSwsFyzkQhvqlSSOlSYPmtLB5oIeLA0CYRNktR9GlASi51m5VzEEMZTCNURIH282wkPbC1dKDsQSroycMvvGmvJAEPWxCeGQ8GVWtkxlGfnFN0dqATgP4PGPKLzFdvvqS0/O9W+yhuASaEQyQPhi6iYw71ywSGUscDdw0sDiqbHcS1XLpFtPC/AlFyh9R5xHO+Y2JbuarwOnNvl+Y/hgXf89lmSSb6m3FbUxyR/3jch7WZhQ53N9ANtiCb5cZwakaHpALxIJsqg368BantaqVItjNkW6pxAzzkhq4R7HKjaeh7wM1UUxTbHPfacGIU+y0RlVKagmUlfoiXVE3JsA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(6133799003)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x9jlldkYqQF6ayOPryJuuY4O+nK7xh74WlrJ2JjThkX7LsF+GqScOLr67d4e?=
 =?us-ascii?Q?rAwF1I93zHnDa1ulVchFlqTD6Nf2goeJIayl3wPDOdT+d68Ulc2+csfwQpbp?=
 =?us-ascii?Q?PTUSO9So2meMsTQfexizzHkjwddkX9EO3+BajFrXnHOEq04EeDItMImzcvKq?=
 =?us-ascii?Q?zJYgCYyV/6TqKB2+SG4xow2NKSZYjeDz5VxtvFcXMGVWcdpIbjWe+EuoMu5F?=
 =?us-ascii?Q?28cDr7QMmO+fb0w+fjSMP4/6EYmsFmNxxofF5I8b/zANQ8PwdKTeH6A3XPT0?=
 =?us-ascii?Q?TjE7cJGCd5LSplnay5aMeqVcwuvJaG1FKTiDU/tWSMDyMZwDiJFg2x+8/NKr?=
 =?us-ascii?Q?ysE9arvrHMkHxwxoG9YN8lhxrmLO/NLn5S2VsLV5ali2Q8MwUJSrWm0gHJc9?=
 =?us-ascii?Q?CaF2nF9nJIqFhNtEASMiFypx644p9W6im+pVIfBMNzk4+HCdUl1PullWzLXb?=
 =?us-ascii?Q?RFGvw7htnU6T/wHUnCnQl4/jwEFzEk0UonaisCBtjx283woBKOYaWw+M67Cj?=
 =?us-ascii?Q?Q1MeY6qL5lD+Td+JLD7klmG9patkxMLpZp4ZkjHyXlBcOXmFL85E5MIqgdvJ?=
 =?us-ascii?Q?18NT0Fsb4bvjyihnFHZM2y+mpCmimeXQNncL7Xkr451huIAT8kwsH1xVRJPs?=
 =?us-ascii?Q?iJMzrTynpPmS7OvZezjfbk3lcBapFEASBzdu9D7HkZYJyDGJW+AW4Q1p8M/4?=
 =?us-ascii?Q?Pai4783CnIHPWzlxnbIqX4U0/z+cUuaWFSSkNjsdWCO/IqrOAFY7nIWFw66f?=
 =?us-ascii?Q?DF6eTmi4jB6TRgOsVn0Tx4rJF0oGg9DRpkzDDnRCquUSVsMmVob8m3X4QkwO?=
 =?us-ascii?Q?xiX5w8bc9JCUo4HDMK5HkgCft2LxuWs81pb75C9Sw1m68q2i/mBQHHHLQBYk?=
 =?us-ascii?Q?LhmuyRjekqf7oQq0idu2OH9FemZE9D4RGTKdQIolFQo2v7QCTmtGLnDsNzaL?=
 =?us-ascii?Q?pKeosS/nJdJwXlnlmhFo8xvAXx3unIOqeHol/BAv9sH9w7qnGYYNBdYq1/LL?=
 =?us-ascii?Q?WJQLDksDOx0vSfQID3rR2ttJU4S1MMc2VT1wijCKsb1DT/jPiPD2QtxI22bL?=
 =?us-ascii?Q?9DuOqyldYULjsdo9OeU82gq1/1i11KgK13plRB/bJ8rHPwB0HqFt97N15dBy?=
 =?us-ascii?Q?kIpghnZxhO3Vp+gc+hdmac1i/vJ8Q4YVZ8cePhtj0WYULpGYnD4Y51dUskl1?=
 =?us-ascii?Q?SHPSXUk6WuDhoyQMg0fwJjZqWGeQg1ucV0y4P0D59CXnHeyZXp6s08w9LBVq?=
 =?us-ascii?Q?U7uyvBGCQhV4N5zbfWPo1oGoNqeSTcuSyaYgbN2WIoDFT1f8QwchyOZgsszw?=
 =?us-ascii?Q?XnHJdkq5sQ33NALbdjwh5mdtM90+eeRMYZYntls750w6P2I4bgLK21ospvcT?=
 =?us-ascii?Q?4zJsJv9hZy/Brp2QjbVsR10Pv5pskQAureR2g7ZOiCJAExYk617RJLS2fY7f?=
 =?us-ascii?Q?wVc8o1pdNddccOm2Rc1AhQDINizs+mtcxOMWBSubBzk6v7c/SgXTovsEsnV0?=
 =?us-ascii?Q?m+giJMF+DqACppaYk2ZhCBq8CiE+fPjMXLpnO7MNh1QmXoyoTAzM2ake+z0b?=
 =?us-ascii?Q?1DYNZEONMH+cl+QWeibkKkb9lTVs/4kzv79BpahpsyOKuKwnvxr1EkVGCPE8?=
 =?us-ascii?Q?VCS0bGvptpVfObR61VS2CKwrdlcWu2oBClxycUiUf+oYuYF1w+TTaDLNYq4k?=
 =?us-ascii?Q?aNvh6btOFZpq59ZQWvTfsxjgkAAcROft0WfYPWaGCjpGS4budI/p6qZcX6KS?=
 =?us-ascii?Q?0xMzWG6PPR5byZUXJ6p1GUUMNDUVvpgoFEGD/6bZUW0dx78FfJoo?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7382a37a-b059-472f-8e1c-08decc4b83f2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:24.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iII93Zdw+VMrwd7bkpJFZTBWb7FNl4CGpn370x4uUOQO9oI/4Y+0M+jEz7XA/THp7rStsvTuEO0npw/HVWMedNStHkjDImOcf1lkeay5JqCLNPYd0JqXQOFdAmssaUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23212

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 0335767dd8e7ade8a8e3028d08c4621515d47388 upstream.

The combination of SPR=3D0 and BRDV=3D0 results in the minimum division
ratio of 2, producing the maximum possible bit rate for a given clock
source. This combination is not supported in two cases:

- On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is fixed at
  200MHz, which would yield 100Mbps. The next hardware manual update
  will explicitly state that since the maximum frequency of the
  RSPICKn clock signal is 50MHz, settings with N=3D0 and n=3D0 resulting
  in 100Mbps are prohibited.

- On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as the clock
  source, SPR=3D0 and BRDV=3D0 is explicitly listed as unsupported in
  the hardware manual (Table 36.7).

Skip the SPR=3D0/BRDV=3D0 combination in rzv2h_rspi_find_rate_fixed() to
prevent the driver from selecting an invalid clock configuration on the
affected SoCs.

Additionally, remove the now redundant RSPI_SPBR_SPR_PCLK_MIN define
which was previously set to 1 to work around the PCLK restriction, but
was overly broad as it incorrectly blocked valid combinations such as
SPR=3D0/BRDV=3D1 (31.25Mbps on PCLK=3D125MHz).

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Fixes: 1ce3e8adc7d0 ("spi: rzv2h-rspi: add support for using PCLK for trans=
fer clock")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260410080517.2405700-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 6c7cbcb13502..d8a7a0a36ecc 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -50,7 +50,6 @@
=20
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
-#define RSPI_SPBR_SPR_PCLK_MIN	1
 #define RSPI_SPBR_SPR_MAX	255
=20
 /* Register SPCMD */
@@ -535,6 +534,17 @@ static void rzv2h_rspi_find_rate_fixed(struct clk *clk=
, u32 hz,
 	for (brdv =3D RSPI_SPCMD_BRDV_MIN; brdv <=3D RSPI_SPCMD_BRDV_MAX; brdv++)=
 {
 		spr =3D DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
+		/*
+		 * Skip SPR=3D0 and BRDV=3D0 as it is not a valid combination:
+		 * - On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is
+		 *   fixed at 200MHz and SPR=3D0 and BRDV=3D0 results in the maximum
+		 *   bit rate of 100Mbps which is prohibited.
+		 * - On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as
+		 *   the clock source, SPR=3D0 and BRDV=3D0 is explicitly listed
+		 *   as unsupported in the hardware manual (Table 36.7).
+		 */
+		if (!spr && !brdv)
+			continue;
 		if (spr >=3D spr_min && spr <=3D spr_max)
 			goto clock_found;
 	}
@@ -568,12 +578,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_pr=
iv *rspi, u32 hz)
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
=20
-	/*
-	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
-	 * when both SPR and BRDV are 0.
-	 */
 	if (best_clock.error && rspi->info->find_pclk_rate)
-		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
+		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_MIN,
 					   RSPI_SPBR_SPR_MAX, &best_clock);
=20
 	if (!best_clock.clk_rate)
--=20
2.54.0


