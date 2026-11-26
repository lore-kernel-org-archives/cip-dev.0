Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.311.1795708169248764067
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YzRwzcH/;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdSBcpAifFPnxc6qS6sQNX3fYNfUy5p9S0/45OY4W1mmH83KQZh5SY4ObuY8PuSRIgOaS8IhV76aY+zqJHXRlFYyU0vowHEIiXDoQaTDHh8GVdtXP45Z4G5fddI5Ln2wylDKTXl8VM9S9IzJHg2Gg87t+aBAvcynudCT3MbKjZNHynOREcIXWr6aHxLdgWuP2ngKoyd4i8WSR/Sh068+83M/2RjPH3mWgjYckG8ysmbNRxYqxEDK9KJYZQYKQ6RsGi9DN4biYpkYRFyTOAXlmoVooCu+mo9S5esnmndLHnJ/A4GDEVuZdl9RJXsG2+GKWrflWjop4fhbEkXMtuoNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jim8dBt7ZpJx8pKHLcDJNghnM0f6/5JXJs8D26RDNAo=;
 b=fTZ8gjcfXTBtillq+uyW/Butw6l2wvWyhjwFgo4HZTUkZCbGWW0AAoFm5C0YDeVf/Gdtv0ER9japZygqdweCEbYf6mtIwLwE3gXl7WCQlwZ7po2idEIyZFv6aag67AwNEs9bSMbPMhGWSzxu47D+8zAStwPGNLRaMyCCPkE/wGp9S96QXO5gUqcwH4pQNlgDhyCsSWm6wXUIHlcE/SJFHSP/cX4pb9O/m+TYHUg/iAvJZCbfwmO4WIMUBitElt4UdxeTY+xuPWTrLca9gI9eIcn2Q6c1LxRdnLW3FUDYnSRNj78gAgDRYlTtBXLmMG7Ax/um1S4sPREjv2L3YFmaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jim8dBt7ZpJx8pKHLcDJNghnM0f6/5JXJs8D26RDNAo=;
 b=YzRwzcH/K+8sjF1z1S0GLPa83cpbZSRnQaPEzWviEHLhZZ6Av7OttZciZpekCW7Uz9w0R6NJLGjoGFKTdnJllYqumS6RwpL/eB7OgSs1IvPhYTblG21v8D8irXHw1EDRBW9o4qHNO0W2dYAJ16WiHSu+AI05q4WCt2SCxVbrnvA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:25 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:25 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 27/27] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup
Date: Thu, 26 Nov 2026 16:47:47 +0100
Message-ID: <20261126154747.3832917-28-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: c187cc0f-2931-46c1-8b55-08df4bd4d888
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: itg6HoZyNDdjxl15abipSwQ2yS9ArMLxZlQH3gFMal36fIZEE95WX6967IIt0R+00jxv4O+m3j+1IEoVlYR/EY51z0QXwM5qXKX1b48HwoJ/Q7AAFLi4K6InVz0Wty42x7p++Yi4PkP0SVwK2cKNDR/06/luHdoesoF63CMMBFllzCZtNIann/4H3dyHo4w/cKteGUGxyuz9Cn0mXIWZ/ytactQsrAXEnkBEaQgIOORilmszxe11ivnneonOUl6HIW1LI/MkQ40xjozUxdZfxfyuKpLE+Q7iq2Pkf3aRFXXKq6jaEiBB4zLO7jWtcZlS7oOe7a2iYgDHK8+mQ2N2ritoxJmufRhaaHisreTu5RX7cCGV4swaW0yp/R5vUpWG7Js57sLr0XRoiIJ4aYA6rFiEYLYMT3AdygfJs9tYZZ4aS5z/UiKcwaOoWP1yLljDX8gGVxij02OIfq4Eb60stsew6XJpQWVnt3D4xaWErSAePM5yGBv1gFiPGuM2fZDnZ1iDnNYHJR9JsYSPg1uMWSMDaFAfQZeDBpeeGtQ7M8JtiSSVnlDEvkwxROIF4C6EbIr9UK1kH2kebUVMQDFxXLXI0uZeAog6xNJa40PEml8QI7q3OT+7umVYnUZxg/g4c4Hp3+w+St866lBSH4pbcrnJfGUlYRo7bgk0mJigfKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Hbq+vUsxfphseVH3YWrR/gDDRAB5DfqvoYrMPDJIGOzDQz/27JPavagRdjr?=
 =?us-ascii?Q?BPIkQctEgvYiGRYSZnfmOBVMVXkMTW3oG+uhtMBe7/HK7WrM707lUsVer2TC?=
 =?us-ascii?Q?3NgDkJnPwIHhPGLhmF6bnB549+JFR/36GGQbZftnwWTOY5h/VwKgwxWJ+1zK?=
 =?us-ascii?Q?L6f4YnlMlEwdTXQpqE544USDTxnqxvE84B5N6CxSaL+J/BJTrTbWrv0QEKsb?=
 =?us-ascii?Q?hwwZ4gbTvki1oYTxQWBWaID7R5EfJqbGgfK34LSVvNMDdCphMvomzIWmQj+i?=
 =?us-ascii?Q?g5je2xceG1Mxs6CitjguSy3jM6A3TvZ/dili/zqEUoWPB8jJkMC27C5qixRF?=
 =?us-ascii?Q?3RNreu/DVnDctKybZANq07Kct0iZ1jzY9FYJEutk6s8K60vcyqG0zzcj8lhi?=
 =?us-ascii?Q?YBOSgSXDa88VNXWC9bfudMPetJ/OfxY7pTW5bpIMNehhYO/YNNwyeyQaEscv?=
 =?us-ascii?Q?PacJp6XmFqAITkqi1Psb3Q7d8qVwK+0nYJUW8bbWJI0cGgkl7Rz59c+mgHdF?=
 =?us-ascii?Q?SyXhrY+JM06oIzRcHC/eT9xMARjAjeLPNaHAS5sg+j5C8JZHYHDX9nUwTBRW?=
 =?us-ascii?Q?LXbtsWDNGNJ2FUmzc1DuBurqKA21+tQiHsTZFHCEMmyKpoPJmL+eCmmBNFxQ?=
 =?us-ascii?Q?M9Wrify1dvF88WqP5rbytGlNWM9XgaBL9QDbTfSFdsRVNE6D2m9aDisAV/Vq?=
 =?us-ascii?Q?1RQ8sOQtO6Wa8bis0EVLFuAlbGpo0oLXrdWy/KzPrlz/CH93CT8vofxRyVH3?=
 =?us-ascii?Q?xl/5k70phRXCEqZYXEKG8FnHXR2L+ht9CbdpJALWk/QNkKX2oBSlZMwMm2/L?=
 =?us-ascii?Q?lPleo0HjmabG+NHis9ndm0qMI5JnWrvIne67HWHloHTcWekq68vf6qb2IwWx?=
 =?us-ascii?Q?M4BpZaCN/ob+9ekkPBUr1IVbUYpJlElo6nCHkbM13sa+tkP9RWVjmtKfKrRO?=
 =?us-ascii?Q?kernN0CyLPGSmHCssD4OMl3s0YmDIDPQZUJ3fx9nOq9C6KO8Iw0SWg9wO6vI?=
 =?us-ascii?Q?z2NBGj88Gd9SjKMu64+Ct9U9TmBAYSvJg5SQQslCL6nkoPzJBRtmnLC+IBVz?=
 =?us-ascii?Q?8AAukI+M3/7+TUDOvVgi/uZ0R8IgLFgy7M+qo3yV3O0su09WHf0CILGuWimt?=
 =?us-ascii?Q?84xYS77y/DfhZKyfFH8nKdpTs+j7tc+oxPbJIJX19xgqPd6tDJW7FkddFmpx?=
 =?us-ascii?Q?RuymZaWooevSGpgP2ArMh8bCvwaTqo2PEZGeAXZzK9nGE79/KHmXecR6vJdu?=
 =?us-ascii?Q?kx5VrR0i8XnVLeOjwTXfEfMzhdhDw8XZlH0YPyq53/QJEjQYDkNtzh9mGGRD?=
 =?us-ascii?Q?5qctrxwwYvYyk45LNgiUpPAm3uY13zyGdV6ut0qd5xNLydexyqja6I8BqExY?=
 =?us-ascii?Q?bAHpIoHyA06bJKV3U3CedwQOHlInTmEnsH2lDKkUHiE8Zn97KLJCKA+670Js?=
 =?us-ascii?Q?x578JHq4JJoZxkdJcRPOO5vspWgW5yvVvUS2aZqWJnn+Kehe5jS/Usc7Pibd?=
 =?us-ascii?Q?7EXT55eeKv81213zGll1iyL/ucBJ8hLK0fSGltkPZSfNt4ygatz45XnCAibu?=
 =?us-ascii?Q?3VnJ1EPt49aSVFzG97TaaCUmvxdNmuZTgwHzQMhoHDvTcr9hkZaTVxRrSZZ+?=
 =?us-ascii?Q?r3HvjJw5aADhCSdySKX1CEO24kNhimPA9ggsijsQsLtEoqI5BHop1SCYy90d?=
 =?us-ascii?Q?sVHCMUe2McMPpSoT5QXuaCs4uqvZDr05eBn38w8B5ENOKMe2+AijxptAM8Zq?=
 =?us-ascii?Q?2XitOeiGo0H2YPc4q4rOWUiCX4igm/eUenCrDDmEWlftDKopFA6/?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c187cc0f-2931-46c1-8b55-08df4bd4d888
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:25.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLBCa2sUEL0yQLg37np5xmUPffyp/CTo+Sho3HGJHdcRPWvmDawV0YVMACPuHRidg35HLijGjxw7KaJclFpzaa0MupDE85AVI88LPnJ9AjqxIJT74PFHcIHy1nDbjFo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25177
Content-Type: text/plain; charset="utf-8"

commit 9db8e502b34bc1df8078abd0169a4fa0624de3bb upstream.

lmdesc->nxla is the address of the next descriptor, so comparing it
against CRLA, which is the address of the current descriptor,
finds the descriptor before the active one, not the active one.
The residue loops below then summed one lmdesc too many on top of
that.

Compare each descriptor's own address to CRLA instead, and add tb
after advancing to the next lmdesc.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callba=
ck")
Fixes: 172bfb57481c ("dmaengine: sh: rz-dmac: Add cyclic DMA support")
Cc: stable@vger.kernel.org
Suggested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260922092037.224884-1-claudiu.beznea@kerne=
l.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c72e76a1d926..681495c4f2c4 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -879,7 +879,7 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct=
 rz_dmac_chan *channel,
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 residue =3D 0, i =3D 0;
=20
-	while (lmdesc->nxla !=3D crla) {
+	while (rz_dmac_lmdesc_addr(channel, lmdesc) !=3D crla) {
 		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
 		if (++i >=3D DMAC_NR_LMDESC)
 			return 0;
@@ -890,13 +890,13 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(stru=
ct rz_dmac_chan *channel,
 		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmdes=
c);
=20
 		while (lmdesc->nxla !=3D start_lmdesc_addr) {
-			residue +=3D lmdesc->tb;
 			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue +=3D lmdesc->tb;
 		}
 	} else {
 		while (lmdesc->chcfg & CHCFG_DEM) {
-			residue +=3D lmdesc->tb;
 			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue +=3D lmdesc->tb;
 		}
 	}
=20
--=20
2.54.0

