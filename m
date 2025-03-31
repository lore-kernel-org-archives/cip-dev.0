Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FEDC36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.64])
 by mx.groups.io with SMTP id smtpd.web10.49414.1743419259557510384
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gtg7UJmb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLFPvEcm0RfYyeC+X7wxyyACrzRS3xUEkQf7iGVeamPhahaH0rRlP3AWNgi0zT0p55KgtTrKT76MUk/UBZKQ1Iy5k32lqICbVVXCV5LvpxRxYevuT/Od2JuDsITpFlln5T8awLtnqx610XYwtr7gB+TZ6BhGQq5InJ03wxW5SkG801bnGJKXwpAQunsBXkjNrvzd0HyvrEcS5aS+3CRGIrrWTd5LNiuV05CMZ7o7Om7Qg/RRErksGG7KIbT37BWvOTnoPvFsYbUKANxQiYCY1p89jnHf5qFPI4ocCIKiKjE/YfLxJNXGjLtKzEZCoDpoVUNMUcwBYUEHplL/jzGuuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqOUjZSmIp9Enl8KcSL0r/Z67HMVyjDEg+Quuc98tiY=;
 b=t810kTvFiSGy9gLYgdgJFfRP7wHDCq/vJxr1jFUtSSWGcissi+9KqRPyZS0+4d1GKDfEHeJSAeQJWPeLM07NuvGOC4TMsvlaUzKUYO1OueDaZDnjrvggDXeXjwIzuWG6vNNBdEPbdThIqh05dFDRJqsWX3jXSAmX5CeSvCMyMKN7luz8zXlawJ3+Dwv3pxbNv73Ngs4hHkFRSzS987gIM4v9lgk+sRZW+jLa5ahRRsxSsiF6qJwJXeyarbNNvkDHY7PxuJeMBDxB3KqKcHyn9l8uDWq+v72q+dHS1fcTeA+PtspTo9nGoJrrkko4Gg5NaxnP5KaiwdP49/wH3OZ56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqOUjZSmIp9Enl8KcSL0r/Z67HMVyjDEg+Quuc98tiY=;
 b=gtg7UJmbW+LLHmIe/HJD46t+3mYdlRchQ+QfWlYKVpgiHIIwVjMNy+GKZr9kyOk7MYnP1OJqqmfxJgVSYtZG2MrQ02kWE4L9RYkrohT4Z51Evrl+1MHZOFHirWyBQ6cuibbTTCEsS0hzN6bBT0ZdPUDEhtwmr/Xf04nDMH9aSZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:37 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/13] pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX
Date: Mon, 31 Mar 2025 13:06:52 +0200
Message-ID: <20250331110659.252237-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1d2213-833f-4fd4-e810-08dd70443ee3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6TULDDWXwOUvl6P3D4TAM4yHm7mV2Gt/LbyrCVD6mkS+B/7aD9eDJ/cjf2vO?=
 =?us-ascii?Q?a5vHPWp/oqiKkFnTA0YPKJLKTzxLIqmuFEnHNshSEzW7AY6GyULrzIX/JXM2?=
 =?us-ascii?Q?x1GKmn8LtgRqvwm0FFDg/VWltZzmo18hpjmNOZnHMTgYfObewzllDyUcpK2x?=
 =?us-ascii?Q?DtqdAQIrdd/+w0ikFmhGFvi4wZX53/Vh0DO9/E6073xLLZpNK9CgqXSXxw5w?=
 =?us-ascii?Q?B8XUdPV5vaOWLuAqZyvFAqSKys/QTWrfkb1FBgLjs0R5ZHIvEpsDjuZlFpSo?=
 =?us-ascii?Q?05pP8s0EPebzTsuW1nkraHx3coGtGHR8MVrQuuF68gHSL9h6nMuvte9NhyiN?=
 =?us-ascii?Q?5VRcTO8VKJEb6b83+tlZxx8A3xSGbiVNaVOKI7ZPlg36dR7ihjmfDH5g3sJo?=
 =?us-ascii?Q?0PX21NvXCrMdVPtcyN59SRS7Eu/seGphlMrZhBIgDbb8OYqqNf/49VzLKtFv?=
 =?us-ascii?Q?qufHtk28hK+YXfurI8G4gk5kRjMciSTTP1tBihyZPO2E/UwZjBDguMa/ytNe?=
 =?us-ascii?Q?99sEjDMcTMqRS70mQrzsru/+9ocRmLBxaNicbK0xzrn5vMbwWIUI5bbt1ANl?=
 =?us-ascii?Q?Wym+KwzwelUDPsAFu8BRaFEBocMHEwNzDj/haoIXHV9vP4/HrN8vkyC1E8xR?=
 =?us-ascii?Q?azeiuOiP9HVK5g/+lDFVSW7QN4z18kPgkLaZYnNtT4qvHyRtYk3eSY6pAmnI?=
 =?us-ascii?Q?3wikeavnxhK/lx0NBOyYGCRsU5fj5S4KaNxhS/JIsxggroj8SB4qD1Z+hzET?=
 =?us-ascii?Q?cXOGTU0vRrlhY8fB8U+g9HxKZAHOe+yDWLAY/oNy1XfzrpkJLIarZLP39ypk?=
 =?us-ascii?Q?0vbHudK87LSFKRXDbZRcnJSB+SnXNmz1fpw+0qywQ/t/93ilK+gArzEIRkGl?=
 =?us-ascii?Q?aB46m7VmPIV6jEWJJNt1dFHHp0ZSkYTB2HY0LFUDPN/r9GRH1GEVbon7k4fi?=
 =?us-ascii?Q?pJ+t7fgc/WEIvFGurKFYLogCTmHWpejMFs+I4NS1dYzsWV+J2P5ZuSfrnQ0g?=
 =?us-ascii?Q?GwrY0nmoi0HScAXOCf4Bubl/8W6yPv+pKFCEU06C5OPWN/+jXWxrzZLV4+2j?=
 =?us-ascii?Q?0G/BSMAnuW0T6sUl2gdZm7JFLgQgT0m+7jtyF1epHoQFtyTetKQp9Zh2hcDK?=
 =?us-ascii?Q?UjgwCNGZzyIbWl4HuK9JKf9GigVdv/8K3hxhYCKI0XQFxDoQhrtIfnuB8k58?=
 =?us-ascii?Q?W6NDWvdT3eeFFoHUDMfkJexgthX43uz2sGt0s425FTZiKLQXAaIwc4GdOkzj?=
 =?us-ascii?Q?DGaLgdvCwTIE6ekUPBWDZuHZWZJ2ZTioB5GHKPy0wuI7iTRcGt8qaFf4ie9C?=
 =?us-ascii?Q?/gqd0HwazhD1pnO45TAwykXVo0v1cSa9OW0i54vbtPG4vTixBvOP0eRMYGtX?=
 =?us-ascii?Q?fZScSyuyHoSjepdKRr5EhN2jJmn3SeFu0iWpbOzpZ7N4gFnlQvIm8tgDrA3/?=
 =?us-ascii?Q?TlSb4SO8xIQQITHaGx8BS/NkKZYz0Q3s?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?I/AdPOkT6TXBhcKAimas3rSP1csIK64X/iD8XfRwZs2CvxadCpPQSc6MKXnq?=
 =?us-ascii?Q?f2JwBPxJVNSyC9Onv5UojUVIDkHkN8l8IcQp/BrV+zLt9RcJb9sBqzbTRj2d?=
 =?us-ascii?Q?6PrSW0l3Blo3z0KHSspo6v92aoYSDUacExiyKovZI4kt0arczC7KzfG8jBeu?=
 =?us-ascii?Q?azDG1IofQbzS7wPAFSdO2fUjfsnGhTTXs17oxsMPogm6150sQrP8XL/gPVz3?=
 =?us-ascii?Q?ZldfwXQG+jhoZChzTSSQiSLa++gdk6qKE5rs/ns4HTD5tfd5yyiLLDkyw7U7?=
 =?us-ascii?Q?6AanoZZulLobMnY1n+Zu3pkpXsaia10jvhMM92pWX0b3ORGx9Xj5EbOiTCe3?=
 =?us-ascii?Q?o6EZr01lBuiUZqt0Ns4Vi54HFs22xmn0pP0D9XgVGV48b/1pdyH5arPWEuxS?=
 =?us-ascii?Q?7VWRJ4BmW6IUJs3nVbiauK6dr6Ja6983jo5CMTdxnF6gkhvuomZW9FhQayBQ?=
 =?us-ascii?Q?glkt1smSnXfWPS2PGAOl5jYS+DKAy5iFEv4QCP/OyZ+V6sZzv1R5jKmHGgso?=
 =?us-ascii?Q?ZU6ok9roHfGbZND6fc8MadOVwJ410L6/46NjEZF3wUitQPQ+OYDn34nt6cbX?=
 =?us-ascii?Q?e4nXp3DT6Ut7tAYDf3ii/bTuv0wsJZe4GoGMemfSW59TvtaNii4V2QMUXS0S?=
 =?us-ascii?Q?seepclXZiQZGsZr/bARElwo9eQN0W78fcrz7QG7VrVCLnln830qD/eaKmT/M?=
 =?us-ascii?Q?TGIhGbQXbQFoSD1iSUgcuopMquswItXyG9v6m2i8cywZqXwLeXsy3Z9Ivxsv?=
 =?us-ascii?Q?L/o37/JfMrcElQDRG2iXgDfmjCy5o45OS9Nw5JJCuOoQEIdm5UtwoNzB6A5I?=
 =?us-ascii?Q?fgbNX5X9WfqM63blbHSErcbE3xpDKpkCgGYefysMi3JxdShsEyJVvuFa81xM?=
 =?us-ascii?Q?S/mtXig3Z4OA9Gl2iH0xm2sS1J8AVnMk2jTtbM9ZSUCt8e2N/cVpUdb2Wizh?=
 =?us-ascii?Q?7izaE5O737TqremYPJ1RXQ3ge4YwSOux7RHYQlCuOt0MZ4xT5JtbkGxTglXK?=
 =?us-ascii?Q?82DyeIjA/yYREe4K7r2Hi8cnEiCUif1pinp9nk8ndA87uaY/8cRHGD6J3boa?=
 =?us-ascii?Q?anZpeNPyztVHihq1bZqmZWf3SOKd/LLnZdVhO/sO/jF6eQujcuh6E+WNOs77?=
 =?us-ascii?Q?OWZn0u5LeedkQwCvZ8X0mYkG9PUy0dr81ZMaUOPG5E+AFdEe2Fqc+3ycOKoV?=
 =?us-ascii?Q?frCW7n6x2BnV9t81sCnVdEK7ImrcwGh0ganckiDYMkUQNxw8JJWpI6Gu6r7+?=
 =?us-ascii?Q?CSZLTPNF/7yUaopVJbMTAvPeDKxVAs5xJXwK7H5l9j2jeF4DURMQ0MDBPeJ1?=
 =?us-ascii?Q?8paQuLIRzaNsKfx3Bot892ea3hnO7jg83St6oiWBO7ulqbKmX3r7kClU61FD?=
 =?us-ascii?Q?RBLDmaioSSCOHu5ZTTkG73EGLl/ygnxJR4j0Z79SnzrhW4vOEAqKwPI25fos?=
 =?us-ascii?Q?RoRhCVJ32GHM7uDtS9xZ0bQdhLO7qtAH75INCuEarAu5teHb6n+QWucnLsU6?=
 =?us-ascii?Q?1tb/yQBzhJWQvmQ+TKzhb7gu2k1IT/uD67aQfI28dqNbcSJTM5tSB5PUbSwY?=
 =?us-ascii?Q?KSvjocwuhQE+dDtBMfSFi+WrprgC/+4aomSb0JFkk+OGXKbTTVGl4fQT1HJ0?=
 =?us-ascii?Q?stVkOdVPeLz/rt7CMn43SN8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1d2213-833f-4fd4-e810-08dd70443ee3
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:37.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyMywnjbR0Ma3rJg5PLjYzFLfbNrYxF5qhtlgAOl6q9ZyytWD+HRbxVBxirLx51I2BKxkbORd7mR7V7Gn8WSp8BznyJy0Xukx6T4ysvtrtYgu/f/z0ULXvbnenoMV04W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18438

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 1d930d4bf8e68c2a7122a6d0899a99f0370c45b1 upstream.

The RZ/V2H(P) SoC has 16 IRQ interrupts, while every other SoC has 8,
and this affects the start index of TINT interrupts (1 + 16 =3D 17, rather
than 1 + 8 =3D 9).
Macro RZG2L_TINT_IRQ_START_INDEX cannot work anymore, replace it with a
new member within struct rzg2l_hwcfg.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20240930145244.356565-2-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index b47f0f1257cff..37dbecb8bc6af 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -170,7 +170,6 @@
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
=20
 #define RZG2L_TINT_MAX_INTERRUPT	32
-#define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
=20
 /* Custom pinconf parameters */
@@ -249,6 +248,7 @@ enum rzg2l_iolh_index {
  * @iolh_groupb_ua: IOLH group B uA specific values
  * @iolh_groupc_ua: IOLH group C uA specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @tint_start_index: the start index for the TINT interrupts
  * @drive_strength_ua: drive strength in uA is supported (otherwise mA is =
supported)
  * @func_base: base number for port function (see register PFC)
  * @oen_max_pin: the maximum pin number supporting output enable
@@ -260,6 +260,7 @@ struct rzg2l_hwcfg {
 	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[4];
+	u16 tint_start_index;
 	bool drive_strength_ua;
 	u8 func_base;
 	u8 oen_max_pin;
@@ -2381,7 +2382,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gp=
io_chip *gc,
=20
 	rzg2l_gpio_irq_endisable(pctrl, child, true);
 	pctrl->hwirq[irq] =3D child;
-	irq +=3D RZG2L_TINT_IRQ_START_INDEX;
+	irq +=3D pctrl->data->hwcfg->tint_start_index;
=20
 	/* All these interrupts are level high in the CPU */
 	*parent_type =3D IRQ_TYPE_LEVEL_HIGH;
@@ -3036,6 +3037,7 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg =3D {
 		[RZG2L_IOLH_IDX_3V3] =3D 2000, 4000, 8000, 12000,
 	},
 	.iolh_groupb_oi =3D { 100, 66, 50, 33, },
+	.tint_start_index =3D 9,
 	.oen_max_pin =3D 0,
 };
=20
@@ -3065,6 +3067,7 @@ static const struct rzg2l_hwcfg rzg3s_hwcfg =3D {
 		/* 3v3 power source */
 		[RZG2L_IOLH_IDX_3V3] =3D 4500, 5200, 5700, 6050,
 	},
+	.tint_start_index =3D 9,
 	.drive_strength_ua =3D true,
 	.func_base =3D 1,
 	.oen_max_pin =3D 1, /* Pin 1 of P0 and P7 is the maximum OEN pin. */
@@ -3075,6 +3078,7 @@ static const struct rzg2l_hwcfg rzv2h_hwcfg =3D {
 	.regs =3D {
 		.pwpr =3D 0x3c04,
 	},
+	.tint_start_index =3D 17,
 };
=20
 static struct rzg2l_pinctrl_data r9a07g043_data =3D {
--=20
2.43.0


