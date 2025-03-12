Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8D0C35FF9
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web10.34472.1741778753397119819
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gzK0Iqxq;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1Ka1WYR1LtXQ/xF96WdOyVO0Ohv04V8lVoVQJv52jfRqq/iEEEdbAh1sWK7QSbegcFfZ9zwJt08Ia0HUiEiQQ8AsRkN8XAtNkePafr7VI9nVxUxrlGYFHVpH28JVtruIXV2p27kq5Jrayr3BzJJ4yrbhTvbWzStRJRcCdUIiWgeAaCWPWQEHgk2YIMECFAR2KhAvorOY9b5acH6sFHJxRKqjMjShbj0CMz0Bf5FgVItID6OalNgkut3JNYzahexyjlhOAt90vtfo6AQH/5s9yasCC80MNKGh60qM/FbAurEkC8dyE+MJIUyCgm2NyN1Frg2GrJyEzw7HVA5r78viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xnWw+oSHWXQJOmrjD8Pq/xnrqez5ifrTalVyaUsUp0=;
 b=L8baAFlk/6vkzH45MzHg/Tvl3iNtZnD2/mgwD4L6EVj3o8ImOzDP3QnnUqgeL3ibQvTBoeFyOKCBbFesDrukhDX42aZZUsoW8GschxTYEJzGYZRlGZvPksDTyFG7Z03GCX+nZy0VGIVBEwOJFIXyV//r3eji5mxX3FTYzRXvGOEBxEfFCVtOHOtyx40j50w1LWRVEh2FzUIcBpK0RmHME7lReEKaZ00CsXgmwollUJAe6DiQpxaGlwHahSEu4HZyyjiGHvRZ0yiMebXbHSp2zredfJbB583u8oP/TnTUcAfgXchOHOnevntDC/nQ2ws6evuj1gfBxMve7EFMBUp7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xnWw+oSHWXQJOmrjD8Pq/xnrqez5ifrTalVyaUsUp0=;
 b=gzK0IqxqFy/7toyKG6m5yMc6Jz2+mvooXQsmmbilt+01rQNaEE0130mx+Wg463m4BQy5ZoVWq/DqWPy5mTllajOQoRQuf4ZcEAebx+xacwD0QKx8w6OpMZrtRakT3SDNb2f1OfK1yGAGX7UCqPTHytMBz4X3ZY9jYuqn+XF5rzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:25:51 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 46/85] pinctrl: renesas: rzg2l: Clarify OEN read/write support
Date: Wed, 12 Mar 2025 12:22:23 +0100
Message-ID: <20250312112302.1605750-47-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 47410419-bf89-48e0-e23a-08dd6158a513
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L1O59YKmetJ5SQUTO7c3aQp/EYGgzEWCROISz6GV9DnKlGbes0mKRtvAFIRM?=
 =?us-ascii?Q?4qxTVzA34sMgxOXhvPhwO4XvBCS3oloOBfrGLUz276XElCGKGGRBW15uC503?=
 =?us-ascii?Q?8pvQxviIKDSfG7gT3B38TlrayPtXMZfW07Q3VTTpa1Shq4PrS5ruzOdabMmD?=
 =?us-ascii?Q?5/1smahDRGTgTXE30PwkFG0M7KCax1Yd4Y4C7QopQAOhQvFzThZ5ww6tNB9P?=
 =?us-ascii?Q?j5QYqugu6otH3JypP+6IJaoJYEvuymfxspFmPhNziJNHBVKkb3dO3HLiAK9b?=
 =?us-ascii?Q?uH2cpgNwJZ1H00sO7G5QlEqD+T8KeeUS67BxQfKpwbWYUmkt0xBOfb43jszm?=
 =?us-ascii?Q?ZjIHrlK/ihQx12nectW89c3uahILJAJcreKoBB8T4LjK+n3PuKjEFk1An0+I?=
 =?us-ascii?Q?AXqYabD2wiPh5/t0U+zr1MebonXRPNmb0AtiweQ8/LPiT96mXSxVP7zqOrT4?=
 =?us-ascii?Q?3+yaGHqlSfJYHZ0DiQVYcCXdSIr49rcm5duKothyLLbpuJ52+/T56yh3H/TZ?=
 =?us-ascii?Q?1JBrBJHYJOdG1rwohcZDFmoX6RnSFqdODvVuWU9bC5IGFzcYXpHlnFfbqLv8?=
 =?us-ascii?Q?KWe+4XnmylXQbD11AGDpk9W1D/T10ZKa9nxO6WUhC4IqOCdiB8mbUfhmbPGu?=
 =?us-ascii?Q?RWYmAK4YKaQwVuAaNz+1fF86hkc3feI+0m3YFtcg7Yj3ctoSWVKP9GHiVhGf?=
 =?us-ascii?Q?43yRTHPXdXMq4fiYCNRLF1+TN1H6PWXdRkNErvJ52Sz0PKKEkP+SOsD/2wXK?=
 =?us-ascii?Q?emDwskVwSxepKvHmInYV39g8S+18xEKMY1IVKREREJt6kcGYTX8H9FdLYpsc?=
 =?us-ascii?Q?1GYzUzVjpLzVVZKJTZgUmqQfyQP1y1BCnJj9QQlQvYpq5Gbq1PBECWhTzhBR?=
 =?us-ascii?Q?z5A4l2WeVTI6GP+b2yPKAdvui23Cyd5pO3+9yQx+8T4UMqmoWfufLJ116u1c?=
 =?us-ascii?Q?scrQt17wIj/8E7QajtwV2p5g/xT0AiYcDonoRsmbowX8fIwcxch67GsV1T7r?=
 =?us-ascii?Q?Tlin7cmisGP5Sop/Exq5s/eGVuvOp9qObCWpOASAoHFRwTbn0GXtvb2ZkNb1?=
 =?us-ascii?Q?kvmQnvqjVnDMPfnrnwaN+nr1NR8H9fpXRmY55LC8z9dEvmuku2r5ZJJbNZJj?=
 =?us-ascii?Q?FavmtIxux0a4VI8YCCFKrE3EfkP+KhkTdvxX6H/4n2xVczw90CjaVuQ3Pi2D?=
 =?us-ascii?Q?75egBRRQ7L4m0W4+ZkoyC14gSFtN2s5BrzUyaJnp1vzWQpRE7Wv0axq9S5vf?=
 =?us-ascii?Q?6bjcRRw0T0rLIAlp8znNbC1XmsSRtSneNLsuChysbihrVR6O86LQP3xF/IRj?=
 =?us-ascii?Q?XRgMIjOx8yC5/U4GOGXZUe2mZpCr+hKcdUaeT4dF8Ii7LGeAyahS9aBPTPEc?=
 =?us-ascii?Q?1Xv+F8mzA5Dzn1ey6Gt/mhva6OYYUckml2o/fL5pZMnA0yNywjXLeP5vcajb?=
 =?us-ascii?Q?s5lcDVstrzE3cfBhamwAzcGeOYA/7exe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4WmG+bZ70M6iX+kbK/afJcY2LJiCaD71TrUDdE+x0UsR/CvAKjYRw3KR8r5Y?=
 =?us-ascii?Q?VBNMDDHjLuVlBg1uiuoSSE5WjPOwFLPWtOlWbhrBMyFWp1UCrIWgKE/66kKt?=
 =?us-ascii?Q?hA23FpVZGsovJ2qWPvASAoAFcFEr3NKp/p27UsXBMkZDxmBVb/8pfrbRyBkY?=
 =?us-ascii?Q?Sc+99ANruVO7RgHGH2QI0sYIp7tatbKw8VQX1JjixDBbbWwsmb/lPZSlmP71?=
 =?us-ascii?Q?jFzYwON/LMqZjrCgqU0BvMdXeSEmzLFnjn+uV6eA3wwOKE3Fcdx+ApFQalHU?=
 =?us-ascii?Q?biE9nb32nUZ+oThWDgxDuJlnwPcsbqCaS5AIgUI/RK1jvqf2uZbokDqmCqkn?=
 =?us-ascii?Q?OzlEbnZsdhLZgeNN/N2Ef9CxWEGBYvu6JjgvC2qDr0Ft8USQRHT1m0DHKOKx?=
 =?us-ascii?Q?vvmEugQfDklsFZS+ck7RZGux3LTEYYLAsFRQTiKz9YJhrxNYaldup5TeFj/3?=
 =?us-ascii?Q?Apa0ukVDGk493pPwMskuGFlB7e8eA2kSYcIDOJfFjc+9WFAPlVon02qjH0JZ?=
 =?us-ascii?Q?sLXnLyhZ2lMrdhg/5743TQEYb/FwAwhKl/yhYTTW3tgoGn6mTvkgyN8mRntC?=
 =?us-ascii?Q?tF+/f5cUwwbCeDV5dVcIdWwDyXWcxEIpI+GYqd297wFkiyyMLvn4f/lIo34Q?=
 =?us-ascii?Q?pXRCi3PYd2mICTiGd5DZpn+Gf18YA4YXDNmKoWUyUfJiao/OA7J66HFq4uwy?=
 =?us-ascii?Q?DePwwE+rMM5Pd3GV0eoxvpkIjNye7Zo6w1b6pv6UPVnGyn2fdebm7UbaDHaX?=
 =?us-ascii?Q?SUPaP2YgPPkavqgu8Ho0ixTxky/Y6AXaXHrD4suNu0UqkvOJoxnlrjG6F7wj?=
 =?us-ascii?Q?XUYDFbfYyDCgkj3N60VDvLYqx+1g+LvmbDeYcVEiNCOKOi55p71nrWREYECm?=
 =?us-ascii?Q?lCnfbbwilhC/VuYE+NkeYgvZn6RPTbd7A0jTt0V0tX+/mGsAD0nMZcDAIRrF?=
 =?us-ascii?Q?9NCObUJnwY97jMfxjNKF+bgRmHFzMUtoT2U+0zB3CV//Qq5xJ+1fSCELlxgD?=
 =?us-ascii?Q?NH1iFdecNclO61ZvHR6VuhIOeyQScduUeA8E7pGyWUigrcwD8/ZETZlCkVOq?=
 =?us-ascii?Q?/hgMtJYHlGcWBx+hJGygGhXE/bfd33fD3fnSAD1M6Z/Jo1U4iqDFTVq6gF5F?=
 =?us-ascii?Q?7zi4pM4MlcqD+cF4bSoWqslOKGn0y2dE/z7O7rC0qT3dStFOa0xs8yngSPpZ?=
 =?us-ascii?Q?6SSDY5mqJTkj/GiovD7ewmYIVwRayOpaVXZsWpsd1OrSuBlIdJZ7imGZ46nb?=
 =?us-ascii?Q?LIZQpjCXWsWEzeNRSJiUzEZGMoV9qmZH6l3FY9Op6P1KfNfNIJGshlXOk9jA?=
 =?us-ascii?Q?Mqgo8UO2NHY84z9vtZUFGn2d/Vpumhl68uN9lIPUuyLBQ0yDjeVyDZC78EBD?=
 =?us-ascii?Q?I1GLCy+9FAYB8fXoROhhv+j1J5wR5RA5WPjsYRs7AcqwkSTcgJHG65oQcegN?=
 =?us-ascii?Q?Lc0DKMNeXkP5dD0iTYR+tSFcCuAyZoahKXUJsta2BbNwkG6lGTAbgaL51WuE?=
 =?us-ascii?Q?6HclUhBV/p2Olk4ktsAXE0A1Do8jJwnKQZsl8c4s0I5PwGuF8/mGy/uQ2nDw?=
 =?us-ascii?Q?bmky1MTSGCIuEOADWsx6XC82+G9GsbI4t+9sFkByWMMkOoI876XWyrd2FdCX?=
 =?us-ascii?Q?yGgib0PV08ASBB+P23jwZdk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47410419-bf89-48e0-e23a-08dd6158a513
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:51.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpEcZc9dovaduMfaF0A/94oDisbU8OLkZczWVAzn1Qz5VtX9vnQmtEaX/1whnY+odKlwwibqStiaxz/w1tmRsGT3SN7CwRCGR5n/w0QVerle+aRGUYF0omWoN0IJ7yao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18138

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit 07dd08c39eb4b645a0e2f2440a54326b49944705 upstream.

We currently support OEN read/write for the RZ/G3S SoC but not the
RZ/G2L SoC family (consisting of RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/V2L &
RZ/Five). The appropriate functions are renamed to clarify this and to
match the callback names.

We should also only set the oen_read and oen_write function pointers for
the devices which support these operations. This requires us to check
that these function pointers are valid before calling them.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240625200316.4282-2-paul.barker.ct@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 7d76e0962e5c..5159dff565b7 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -999,7 +999,7 @@ static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl =
*pctrl, u32 caps,
 	return false;
 }
=20
-static bool rzg2l_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
+static bool rzg3s_oen_is_supported(u32 caps, u8 pin, u8 max_pin)
 {
 	if (!(caps & PIN_CFG_OEN))
 		return false;
@@ -1010,7 +1010,7 @@ static bool rzg2l_oen_is_supported(u32 caps, u8 pin, =
u8 max_pin)
 	return true;
 }
=20
-static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
+static u8 rzg3s_pin_to_oen_bit(u32 offset, u8 pin, u8 max_port)
 {
 	if (pin)
 		pin *=3D 2;
@@ -1021,31 +1021,31 @@ static u8 rzg2l_pin_to_oen_bit(u32 offset, u8 pin, =
u8 max_port)
 	return pin;
 }
=20
-static u32 rzg2l_read_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
+static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offse=
t, u8 pin)
 {
 	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
 	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
 	u8 bit;
=20
-	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
 		return 0;
=20
-	bit =3D rzg2l_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
=20
 	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
 }
=20
-static int rzg2l_write_oen(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
+static int rzg3s_oen_write(struct rzg2l_pinctrl *pctrl, u32 caps, u32 offs=
et, u8 pin, u8 oen)
 {
 	u8 max_port =3D pctrl->data->hwcfg->oen_max_port;
 	u8 max_pin =3D pctrl->data->hwcfg->oen_max_pin;
 	unsigned long flags;
 	u8 val, bit;
=20
-	if (!rzg2l_oen_is_supported(caps, pin, max_pin))
+	if (!rzg3s_oen_is_supported(caps, pin, max_pin))
 		return -EINVAL;
=20
-	bit =3D rzg2l_pin_to_oen_bit(offset, pin, max_port);
+	bit =3D rzg3s_pin_to_oen_bit(offset, pin, max_port);
=20
 	spin_lock_irqsave(&pctrl->lock, flags);
 	val =3D readb(pctrl->base + ETH_MODE);
@@ -1220,6 +1220,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
+		if (!pctrl->data->oen_read)
+			return -EOPNOTSUPP;
 		arg =3D pctrl->data->oen_read(pctrl, cfg, _pin, bit);
 		if (!arg)
 			return -EINVAL;
@@ -1359,6 +1361,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
+			if (!pctrl->data->oen_write)
+				return -EOPNOTSUPP;
 			ret =3D pctrl->data->oen_write(pctrl, cfg, _pin, bit, !!arg);
 			if (ret)
 				return ret;
@@ -3070,8 +3074,6 @@ static struct rzg2l_pinctrl_data r9a07g043_data =3D {
 #endif
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
@@ -3087,8 +3089,6 @@ static struct rzg2l_pinctrl_data r9a07g044_data =3D {
 	.hwcfg =3D &rzg2l_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
@@ -3103,8 +3103,8 @@ static struct rzg2l_pinctrl_data r9a08g045_data =3D {
 	.hwcfg =3D &rzg3s_hwcfg,
 	.pwpr_pfc_lock_unlock =3D &rzg2l_pwpr_pfc_lock_unlock,
 	.pmc_writeb =3D &rzg2l_pmc_writeb,
-	.oen_read =3D &rzg2l_read_oen,
-	.oen_write =3D &rzg2l_write_oen,
+	.oen_read =3D &rzg3s_oen_read,
+	.oen_write =3D &rzg3s_oen_write,
 	.hw_to_bias_param =3D &rzg2l_hw_to_bias_param,
 	.bias_param_to_hw =3D &rzg2l_bias_param_to_hw,
 };
--=20
2.43.0


