Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531CC83F0B
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:06:56 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.67])
 by mx.groups.io with SMTP id smtpd.web10.8398.1751620008487414782
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:06:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mPV22uhh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.67, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoIU/hXYFwIvaLPXcFnWd+sBzSL0sX7dZ7uXzPViaoi+122qJoJy9h8CvhhdicyPoOTY3cVqhxg2puJKAnRsmYs4sq9HgBPoEARQvMWluVFscTajyChluET4oDPQopkabNKEk46RHdLc7BNmYv4ImFoecZKwRMqFC800Fio5F+CDP5PUUhG9BjOr5D2tvr0jiLFlVVsPC0Cj8+VBKcW71Czx0lyg3Wh+Ur8yvFupCvcMsHCmRXCp7UDDyB8bU3g8ont88eKZ3BszUmMe6e6HhaKYM8eDRBvSQ3ktVEXYdfPf6M9ryMsO2QG23M8KNMZwtfRvxQ5Z4m2E8xlIqbPGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=032KxJNc2oqjuyouQ4ibfChIm5nHBbZqS8kK3mOQaGs=;
 b=XWTQIRAFlBrlidWj3aWcTPU0ecp61MCpQ8rxlKe1iEh/Qcywqm8JrO6E3wViYLovLXtRNZtASZaxDaoQe9hgZdYC1xE6SnYsSIXa3aPYcRTMbWF60cXk18HmHxxNn6i7OfDiPPNg9dmDGoIYy+lS8r61elS5/x9XBO8+sO0nXKfZtSyvy0Am+HrmSJ1lPAkYJKMkuuzspquUTJZ2xmQuROreOwfTqZcAjb+RjVJKHOeErOG02GJhH6YN8+qBvVUQj9HNxZ66OJwDEbEJtk6q16UN9RN3vNais7pPBWWMBR3SEGOhQJ6naKzuZ/T7uk/7OvrmaX+TSsOSZ3bHrT2kHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=032KxJNc2oqjuyouQ4ibfChIm5nHBbZqS8kK3mOQaGs=;
 b=mPV22uhh2EH0uAVAJH5CXjXnRWIfgOA6yD3mpq3VPrTPWGHvjHdjG2AyodjvWZWU0Id0d0AaCGEhvcbiQXnWQREEJAT32mz+fhM5PALA8A5+4df+Nj8NLcU5D0HZfjMjbgJbvLqBGCqOc3m4WDlw15ea03l2PlsWyaSEpEadfa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYYPR01MB13039.jpnprd01.prod.outlook.com (2603:1096:405:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:06:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:06:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/14] irqchip/renesas-rzv2h: Update TSSR_TIEN macro
Date: Fri,  4 Jul 2025 11:05:52 +0200
Message-ID: <20250704090556.669652-11-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e36ef6a-dfb3-43f0-4dd7-08ddbada1a44
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2tnokJSzJuqQYwnSSdFhn1VXBVQK4BAH0BkvaFgMXKeKtTSdqHvo1gP/fttT?=
 =?us-ascii?Q?IRJQf9HIen8cBYA8MW+l2EFik3pFly+6JnYouI7P6RMryc/IwlgRUUnYCeCT?=
 =?us-ascii?Q?01B6N1sAVantobmE5mAziTDm8xrVDUviNH7MSTuycFndJgvQOGD6JH+LMA2M?=
 =?us-ascii?Q?t4PoNUQi5wbJ0LExTwUaUViJ+nxhh2yfP0s0UMQPujnjqw2eY2CUUwEM99cw?=
 =?us-ascii?Q?fBCztiYDi1GWAKy2h2fx072YftXDeBTf0rNWKBMHDpJAoXpSpIGzys4+x4u0?=
 =?us-ascii?Q?BCfYqwm1vZp92NItsRLneCSTWzlifPiZ72W3Z/u3jNjEuJAhDVODVYVlZI8b?=
 =?us-ascii?Q?MNkLD6fgFNBhgj6Xvd7HrDpgKCvkk7xZPx1jv610y4KOShlP6eXcFvr58qqx?=
 =?us-ascii?Q?e/5/NTb+3egJjLc7ArJrD6747mf/bwS2AepvIiDq2fQpQhLYRy52/3/exOeh?=
 =?us-ascii?Q?kzkulAap5wYeN8cm+ku0ZNRVpUzN/8Pb9qBhKbYIYtGB1oj+DLE7lvVoHPgo?=
 =?us-ascii?Q?NpdOGFFvSWi0nw+T7rXzbi804eA36Tyy5kpwKn6CuRC5+aGtBlM4wjTujeJI?=
 =?us-ascii?Q?4SPGj53i/+3jLZOUAb1TDtuSHwsL5x+D/17z7BOfJRAEwD3sUBWcoL3AMEAe?=
 =?us-ascii?Q?8uqCRvMgyHvVRYSzViwLksQLPSRrCvu0m7PvpE38VwUIwm1myY5xdtoVLXx9?=
 =?us-ascii?Q?8XZ9U2sn2qBNWKEuz3hmowpDUIIaxpzQ3oof1bi0vG1SdSoh/4mCHQCU4hpP?=
 =?us-ascii?Q?F86WMSNsjtXbk3uShe5gl5ZJg7DQqbanG23DTmXNrwHri6ZQxpPo8kl2V8U6?=
 =?us-ascii?Q?W+lb/xQ9mQfRnzJeIa5S+hdXGTaxt7JgE3WSnCoddPsZQeZdg5+uW52WXw3S?=
 =?us-ascii?Q?BNkFuzBgRVe0Z6hDElN36F2usZwaO/3M51xHJ6WlSOV4TgayMJ628GbKcRxk?=
 =?us-ascii?Q?s9qRN+eRysWtlaGw2p2bc7f1BjMAzP/Ug39NK99/Z5BdN1duTuUUCl0vJw25?=
 =?us-ascii?Q?EWlDudOmHGqIPIyUVNwJ+VlEZp2MhBCrjpT2PoPEvPk5tAVoWn/V6MpI5zrY?=
 =?us-ascii?Q?2HXm/AklLVQnil6VeN9rqQNRiNj7NSWJx/SfveXdqC9jLx9j5eE6YK3AVeuh?=
 =?us-ascii?Q?gJM4vfCb9/CoaolpnvlcKoNOHE9CQbGBw8IQ7SLaGLU41HslpV3Wd7B09GA6?=
 =?us-ascii?Q?62YnwgmpZg2L+Yh2AH6yL+TUBF7cqmpk+jq4UN4TInVAfTJFx6yfoE1U33w9?=
 =?us-ascii?Q?ZSkekfTjv4IC89ruc2vdPj+oYu1SmAy8qVjRzoPo1TrlNf4/ruq2/kuwcoC8?=
 =?us-ascii?Q?K9eOhX/qzfNJ/s53UAJCrsDc3tt7s/6QV91ZttaTYODHyU3NZ98nHkR+dxuR?=
 =?us-ascii?Q?kV0Xg1T8LlRUFNVuZe/Vp78feNoQvF01nmYZwPN3GMeI3bCaoYqeEttCbPxh?=
 =?us-ascii?Q?Hlvh3syl5aDIxo5B97h0vFwAxST1/Zu58LJ6OrSc6shzq/GumUf9mvYfvlJK?=
 =?us-ascii?Q?XFsIcoH7pVqhwB0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?e4z5n5NH11bn20njCvgws/iHkvoWM2z+cuzjmhYYwRXTn7z7bt/Jmzo1X7Oi?=
 =?us-ascii?Q?PvOxGR7DhIGy+qwllo5l1yLJRoEFFfH6HxBAWAiqvaLV8u9nyWLNHHZwzhTc?=
 =?us-ascii?Q?tDgbIIHASq/XF7V3EVxaZqiifaDAqCJXx/YwEB7fW9GhwjHxteDSW5SFbQQB?=
 =?us-ascii?Q?tc4nNN+SlBE9r9yJQ6njaTBDHIjSVgJlIrOdNBJZyse/MOAhIFEyVku5Qw0G?=
 =?us-ascii?Q?5KViF/D7DgAO+bhYKlocM2q+t/uoJlX3Rn8OwYjNqLKiVba8vrbp0lkwjeaZ?=
 =?us-ascii?Q?Ino3us4jsXDDky0qnAQGSLTQzkAGdGOeSWN0+0ojRBrOGS6+AHyYtzczMlUA?=
 =?us-ascii?Q?mO5tI4fGznCmchk1Is/GuJgyKmGvsylW8Ne3/PahcdS7hq3eFkMWmF2iYLjP?=
 =?us-ascii?Q?7PxjDIbScriJxEyL85WKDCH77+dcWR/zT4PqvQ1uYUosl8VNhLHTFfMxWC2s?=
 =?us-ascii?Q?8F+qYqRHk/bf2xCz2dp1+tpIwgDxJc/uUgiMao/2wxEalFS5vSOrWKzOixmT?=
 =?us-ascii?Q?vxEcDuEnWLicvVpQybBpvFi7inouHbq28gcxMW37hGXiSJK94kFNAnrnV3Er?=
 =?us-ascii?Q?iQP6wD1+Owgx6WeV0inrwH9bJ0XnGxxOrbpoubIBlzyTothfxcwRsXLyTlmv?=
 =?us-ascii?Q?KnnI2d1Ph7hDJpn0j3h/h3vwedvrJD27MeKy7h1X5E9RVwmgj4y3GWCvpL/1?=
 =?us-ascii?Q?F+Ju2TryYBd2NcA0d14JoLBvCOwvUZ6Cj7g7oM2aGdxwXW8z3J4qLQJKjjuQ?=
 =?us-ascii?Q?G4WkNvr5dfLSd2PeFcQUvw9Eej+2xIPngHBHeGvtAQ9tEqdRaqyFCy6/8t2u?=
 =?us-ascii?Q?XfGeb5ARik28lT1zO6QrTavM/o4CUsAUKKvhR6lGEGj1sz89hgnlfnX5QIfO?=
 =?us-ascii?Q?TeDiez2rHmGLqNkRo7dRoPMK3jjqoVhyeRBgZXyLlkGcCgK2NsyGAfi03/6I?=
 =?us-ascii?Q?/2K6UUo1p7Zs3rORk889C2Fw93HuXybS2oPLOWB18O/7RgVsVRkBdSogHdkQ?=
 =?us-ascii?Q?k8QxQ3Ie1dz3GtuXRXOIAh1DUlujy5MoM0f3wkKkg1uiX5ByLWLkCGLdpks1?=
 =?us-ascii?Q?a5cQWUzxf7peyeabmgY5zp+Ya3p6879M4BDuvsysPrBm8KUCPTa/8YqMttNs?=
 =?us-ascii?Q?QYOOwQKlBmZnDBBOUqn/oKXjfPuRszPbP3UpfYecKLCAAXZLjIxXO26JGOsn?=
 =?us-ascii?Q?k7SsABDjuWjxF8M1w9DcsWp2d+J1SdhzWyNsJQkI67QO//xtZimvOrs+i+oX?=
 =?us-ascii?Q?bKbMCO2Fmi7mRhgjp1Gicy9JalwPpLJp9tCpfySOtNumOfOw03IY2ViB57bt?=
 =?us-ascii?Q?JSMNDYPEulxnyYT+Uc2Wn24tZZduienlxtJukY7zn5iM5hwHj/J60aupkRJM?=
 =?us-ascii?Q?lXvMzmVD1yZ6wrefCdgN62Qsfl2g5k123QRPvPBCCB2rFGk12Be8QD3s+GOi?=
 =?us-ascii?Q?QUcjj2s7qgUZRrnDDI3/h2Jy2CNXhFLxQvEwNhZoql+YO33os7yX0C09RlnS?=
 =?us-ascii?Q?y9wxcPCOtF+MvQe/sXrfROMEWfo9Xarrn5b/zc8tOFXsPOBybQPsh3AoCrxH?=
 =?us-ascii?Q?uEMcNOQGLkSDnhM2gb4gy7EE6ZmJWYyGicVNI1F+yc6KBVnAaGACOB+W0qMY?=
 =?us-ascii?Q?DSUZDZj3ICW5J8b5+h33YeU=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e36ef6a-dfb3-43f0-4dd7-08ddbada1a44
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:06:46.4464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdDdezUhvJrWAOyDmY/F5+wnVJSnyiTSyQ3VgJA2Dw+URDWdDlg2UlvI3p5LB5ZcJXB6xjQaFzL5L/5rEjKuXvAeRWQqG9MIETuHeMxS7XbpuoOUoIVpd+US7pS1UgNy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:06:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19339

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 76c3b774734feb8224b78721e0c67a54760a75c5 upstream.

On RZ/G3E, TIEN bit position is at 15 compared to 7 on RZ/V2H. Replace the
macro ICU_TSSR_TIEN(n)->ICU_TSSR_TIEN(n, _field_width) for supporting both
these SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-11-biju.das.jz@bp.r=
enesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index df26026f33d6..301d15756504 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -66,7 +66,11 @@
=20
 #define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
 #define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
-#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+#define ICU_TSSR_TIEN(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) =3D (field_width); \
+		BIT((_field_width) - 1) << ((n) * (_field_width)); \
+})
=20
 #define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
 #define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
@@ -153,9 +157,9 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d=
, bool enable)
 	guard(raw_spinlock)(&priv->lock);
 	tssr =3D readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
-		tssr |=3D ICU_TSSR_TIEN(tssel_n);
+		tssr |=3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	else
-		tssr &=3D ~ICU_TSSR_TIEN(tssel_n);
+		tssr &=3D ~ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
=20
@@ -314,7 +318,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsi=
gned int type)
 	nr_tint =3D 32 / priv->info->field_width;
 	tssr_k =3D tint_nr / nr_tint;
 	tssel_n =3D tint_nr % nr_tint;
-	tien =3D ICU_TSSR_TIEN(tssel_n);
+	tien =3D ICU_TSSR_TIEN(tssel_n, priv->info->field_width);
=20
 	titsr_k =3D ICU_TITSR_K(tint_nr);
 	titsel_n =3D ICU_TITSR_TITSEL_N(tint_nr);
--=20
2.43.0


