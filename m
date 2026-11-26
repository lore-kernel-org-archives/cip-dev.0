Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.497.1795708630287596618
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:57:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oDz3YybK;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw0lh69Ptn3/mS2qoNmY6VkxlDeA3C6/dUmMFY0lpfqJuuacmOYooUKNxmowmlRl+eLcqiA+xPQupc8FOToxAFoJUf89r2f1yLY7EvryQmw85BhwURyL8kk0vuY/CorUm3SjSw/oY2X7XdJ5LanwoycONGvmFE9Ml2gqIPREEar/cmXgQDFeTz5ENv67ys7u0VhgQ6UcEaBeO7vFAf0OEQ5IXIemPB3kXg2JXxMMIebsYF41ORShGY2q6guiF15F7yD3RRfLgB1I31PLQ+3WKgzoXi5V8ljAG58hECkDf6bFHCAup4TKSbtpaG2I0FnbVqg9HTH3266azZ1Jqwv7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCQ6ypv/ILkiSt9vcA7bKsqCZpy7/W705x+uFJhmXGg=;
 b=FrFAVo/8IoEMpFQsoOk4WhEcDt/LcOGCW3ApCwvWo27Ak5qlNIBCx99YqC9umblcW5s034S7WjnB4we5UHfsWGTb7iWV2KDt226GTDv5llga5LZ4El/FiinRlir6ga54lf5BsRCyvp5vGNNEP7y9flGB/4rRnpnfd7sie5+cis8PcyoOXngNrebwyRJkajN5aGKTP87yUsXLAZIM38xRpKoI+6ntY3lUOzGvBSuykWRuaSMucpw1Aa3/3AvYG2RKnVJK5Ylds24qXlWiDwt/Kf7f7HfmUIP8FvNXlVkiIbML6L+DPIDwNnezWdRxcDBCUD6COqHVshafbVdlFoZjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCQ6ypv/ILkiSt9vcA7bKsqCZpy7/W705x+uFJhmXGg=;
 b=oDz3YybK82sIjf0O7iZrQIBnH63fkFf67FILdwQl6GhxbI/RRuq0RgDMslNElPCMTuqMOsNA6QxQTVPHqCsKm+yotyaJpqe84fmXJDwF8JXWFq9stu/2IJltimY4iEQhL2dsR+Rv8TpYxbtIsyz//WQthbs6vu/rkIzrkm5pK4Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:57:08 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:57:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 23/23] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup
Date: Thu, 26 Nov 2026 16:55:45 +0100
Message-ID: <20261126155545.3834937-24-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c67004e-5c9d-4f36-8d8f-08df4bd5ec8a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: ZgqZF08HCaqd/AXRye+CR4GT02QMh6d5ZvYVUHmY+IEoTaTUpHrURaUVXDZhvEwNvc+rhYEXfPly6//MSgqLx64U3LvHP6gA8/xtJUlniAt7rvZwuaTftvLLfNV4XTtplyuQMUA31CtSt21WQXS++PaBPB/tEV4jOxRmtj7uHu6tbxK+p7p/S33wkcMWmJ9Fa6jwJyPGRopUU+R/16MxmMO2iSn/0+tIwcdZdGDLbxi77O/NA/GhzS6OTB27m0GPzxLQH8iQnTDdiCWLJUJ786e8aC+HbF76sfPa/NQcZqtPVIx7BYMltV3+RPHCV2pTPJ9UDp1gU2ufosfE6NyqHTmHvSJtDoPatuDbWuKSm3UlIm5ljIKVm/pO5bvAVpegu01yUoEaFyWGeiSDIb0JTz7WHodsEbdDpiElleXdkDjtSD5xLI2ykX+EF+UxROTtQvdSZcNFTQ5HoKjueh7TlIb7K7GcaMN90XFzrZeAa7BfPtI5a5M/gbI1XTyJo+667AGu98l75AYcutqsp5/wAOugMbNBCagJxO4C35BntJZWP4Uq98MVIrK8taLb/f2QQGvxZmRAFvErqybVl+ID0SrUveD+cEGK5g0GQL3M3Y5y7gvTrIqaKELUh+ITiq/+6YvCcE5gJvMekZGV3r8bHza5VAa2T3211uAFBYPNrAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CO4AKpKVVpbnc/Vc+89RTty9+wT4kA8DxZ374lG8RVWqRbmSZ4UI3Fg/TIwJ?=
 =?us-ascii?Q?NWgqpIqupUV4e9n5FMSILYZTBrTNfB5WbhCJaLy8rg5Sb2lV5o8jxTVPb8ag?=
 =?us-ascii?Q?7dojRIXappAgtGtd82I2LUOwPjzYI2m42a2zP9cTPh9u9SCwumxqBGgcu8cp?=
 =?us-ascii?Q?DgOuya2QZ5pFFosPZgiNvSiJ0nxgLng2N3f4cq6gBnih+/4TeeW3syhrVef/?=
 =?us-ascii?Q?DGmR7PY4091Rh3vqunCyo3cr6B5WSvW01NT3c5l5rK9uosd/nl/KmV5NTEL0?=
 =?us-ascii?Q?XKIGogKishDouKCWixgFwMi0/+U2jKZIdTVBDks1qXqai5YBz+czX/8dFsyb?=
 =?us-ascii?Q?yzBKUsj6LL8fyze1m90o9Vq3UR4JEwKpYuf1Rnpq4QgK9oH15xV1vslELKN6?=
 =?us-ascii?Q?EWiq4shYmFh2RxrCzaP24DzJtdsnYFYXvg3v64kcOK6uRrJCewem6VjKSG6X?=
 =?us-ascii?Q?4P3pKASEoQ5lrhz/8BlcpmLgfE9VzscjjRP1qQjS8enBauj8P4GJFplEpp5D?=
 =?us-ascii?Q?IJP5Da8ZDGAzQzmaOtvVnGtljMx7dyT7JJmaFL+VEF76OHX5jakd8FCGQina?=
 =?us-ascii?Q?8xGU39l5w6CE+VA/pemju3y2QSzIZaaedTgYfgduGikcGlPEmqHm4kQoAgiG?=
 =?us-ascii?Q?c3hk/CIlxfKV50fePDkYgTK6Ct3qWT7NloLIrzOMswWsKDu8DoCsAhqYd4af?=
 =?us-ascii?Q?YVI2RGLxIa/CGx27EpOo84elCMqgAIDOBEaziSfbWfMkSwUBf+lBNwxosb5a?=
 =?us-ascii?Q?qaWvYOZUUcelX+XUDDH2Y5N5DKKfx8UxeeE8xZXSUYUSWHyEhdcbBhagdB3G?=
 =?us-ascii?Q?GfswaBA/LTOeo8oiPBXbwsgsD1FNMSuQIse6jAr//M3uxzvDotLGVUzoP5Zc?=
 =?us-ascii?Q?JNua4z4oRf2fevuj9Ce4tjB5+Tf6+bQXKF3JbIgWSGc49EtK8NCPJ0JFHc9k?=
 =?us-ascii?Q?mzdvrNETD7iEyok7sDDA9iL7ZCo743t6Afdlt3CHwrca7tEpd6ippErUFHJS?=
 =?us-ascii?Q?Yu1ZMCP0XuehbcI2CN6RehefavzFwoWiK/sfI5EukTF1lrqOvOIBvu0eP1/O?=
 =?us-ascii?Q?oeYf5N6hGUlGD5xKP3j2VMUdmDtfXBaaGHEkrSTKbUAxE6XInA2IhCaMgDBf?=
 =?us-ascii?Q?kegd6YqmezAawSprAOQ9j0dWId65Fzdal3BMKx5qhJQquDESqAwB4CqGBDz9?=
 =?us-ascii?Q?PSXg4JyzU1KjsqV6sh7BgHXlyIgna7xAYF4BEw1+n6RTxjDEr1f26Q1ByU59?=
 =?us-ascii?Q?F4h2xBeZSFnF/JTpceAkU5x1AtLQWep1tBU6OJe4pDe8QaP928XnF64J7vA8?=
 =?us-ascii?Q?4eRsnV6pibCR40xqFXh6Q2JIQuSCvViWVyb90ydR5vgjP4zvqx/KSiyYpVpu?=
 =?us-ascii?Q?e8LY4JVhSCjOC1+CqS2/EcJWCOmUGEBQVK88ySf9/5uzspZCIOazgzkNJmmm?=
 =?us-ascii?Q?YVmkST0TKYKVnOQ7H60Rr0vbS4FFr/hdw130VAZjwiaHcQUvkV5PUxIGg5D0?=
 =?us-ascii?Q?73qqrAjHjgR445b5J+o8MPc4uEIF4b2QctUdg1qdRk/Dc0A9TRb+mua5DTai?=
 =?us-ascii?Q?tz2TfDj+HApyc3Dow3XouiJ0U4VdT90ooH45jsECeb+c1lDOP7Nh8R1uzLte?=
 =?us-ascii?Q?OcuSppjwkZgE3qDHDylQ0Oa7N8694L1J9Q9m7+5fVYzct36QDvwg8Nni5+jt?=
 =?us-ascii?Q?bo9G+9IKar5r2bTxp51TuhvYgoahn9G37IbP43Hq0TDTEukfNQEozNqqgsLN?=
 =?us-ascii?Q?qlYxrEGyHufegrCKSP1GplbtjQr2O8TN81U5OZ5eWnxwbLkoDWwh?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c67004e-5c9d-4f36-8d8f-08df4bd5ec8a
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:57:08.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFdHa38XS7RK3ZVQAe3hh4bJcyYZfzkdEnPyO+2KS5S+8sGShly+QYX5XDltnxI0TP7f/uTFkqGiu8aNn1TxJmvt9L1a0rUVj81yZPtOYLjZi8tjGiUf2YEQgyAB6mBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:57:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25214
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
index 08c9cd590c92..5cd33f8b9478 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -880,7 +880,7 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct=
 rz_dmac_chan *channel,
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 residue =3D 0, i =3D 0;
=20
-	while (lmdesc->nxla !=3D crla) {
+	while (rz_dmac_lmdesc_addr(channel, lmdesc) !=3D crla) {
 		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
 		if (++i >=3D DMAC_NR_LMDESC)
 			return 0;
@@ -891,13 +891,13 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(stru=
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

