Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.336.1795708156536117027
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:49:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sAikOMiN;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.41, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4fg7H9/FwAkBQv65FkUkFXPZkaB1cjA41k+5Nl9h0hfdJ/sctmOoT/dKmd4YpGe0XhkYW5JY50ntMrB4THmULxOd6nAkrZnc8Xs2QSZdGiYdIu4Kyu1M1qcnUvY80QcjoaHCAR88tAk912b30gpr80N7kTfQDqYLh7Va5jzqgTfdUfKo0M1Fb7LOUrtAc2fMtwPO1IdxlzxtoF2ZBjg9UILqQOme/cwTFfz5s4IhYqvutwK95YHeX+oqfpULrYUo0XP64rjMLzA0tv74+qQvzzr6PkEcORA0Qjo8+wLmuO8FlSzCp7I1b7XFB+D1HCs6zIzpl19lcB4YHYVgIu27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXm6ySYxsJhrayudZ0Z3zP8KwLflfib89RbccEIvxfk=;
 b=AfundKuqqDwZ7T2QV3IhfyP8Ovm4Xt4qfdxKzJuKPYXgLuJZW1pH12vfEEpvAzcaQMA3MkhwmON8rWDpexbQ0IUQ7HHtwCFLB79ijHuX8gf81JHjiCbxVUqoYwNscTCxfayOdx8CyW/F42zU5HVzoP+rqbuhFfLXTCxVy39cRMDnuIHq6VQS/CMAnBNWkXD9haVUyOUFkEHzuWiscV1FgWzAD8CZg8js1y00MrlmQc8xlGZkmarg/u3E3c4yR/9B06dxoXJDfvpHetACdmU5AOxz6lP8Dbq5L+DTR0OWlIQN937xbywb/D691I7/gG3XC2A9UvLhPszHvJTV6XC79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXm6ySYxsJhrayudZ0Z3zP8KwLflfib89RbccEIvxfk=;
 b=sAikOMiNKR8s+1ihDGVFyfLtSjT+qDRTUn94NUXgi6stldPkpAkScxBfwFDjo0jes85dyjzPMnoey5ftfzboflA5pXwILJxhKgFumNqkLkYJi2w6HEAQFAyD/EE58MapzI4tJSeS2jRJVRMEPtdF1FTz8bG/O1evl2E6y5PweDk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:49:14 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:49:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/27] dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return error codes
Date: Thu, 26 Nov 2026 16:47:43 +0100
Message-ID: <20261126154747.3832917-24-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f404fc63-b378-4f70-a070-08df4bd4d209
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QRi5xV0eNDp3sU/alPn+nrcEXcDC7A/BO5jG/36Iz7LZtQkrWvja7zaZl6MfFFLmdbVWRy5Jma3dYYRgcB//Bsn96Et2b5kxzzLpWr5/4VQWtxsX/h73veC0Y5CjY5P2D9Gv5yWuYITFFxwGXwrdvtOi+hZATpHoUEDq7omf0UxdLR1gJ0s+d99bMf+lDp9mEflqL8CN9+61/nGHId+8hZ/rTX/PyOdg8zELXkdaaKF97udsc9UqIHaVIJvKjyBEbshrqDox0g5liV4hrNxEc3+R313e2VCs0EQZiJaPZKtdDKNeZeK1vBZqXVwcA6YRKLsl54T8vzMCYBSZlnq6kneDSAm+G+EUe+pGce+NQtF5+L3Q/vy+jMfQeSsid4ZSQwfxfxjjByVYu+RUF9d99aPzJklFkX1E8SIGXxuqgdBFHhTRO2U51s5LckH+WS6ytkdade2kjIUaXq1C0Ltu2qkK3mGNRSbvxYRwp43taum+qH0qZqiLhnn4dKM/5fYEJpLAaUH+eAd6QlAdaW85Z7pJrF5f0kxTnHtEXR8Z/tmVx2aPX6rK3pdJF9g/yv1qVtqRUHoTR8slN2pbv69EYpV+mNt7CAt+mPXX30Wdg5kcPFCVBZpzvYBgIEXaND1UzKSQdYh+sUu4uPI+B4KJc7/7B143oUV/uJUbZG/aluM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZcdJ/rgDfXw26UblJ8E2noB7NOlgdcQeyYB3oWmzJdDesDtn/eAhjC92UBJi?=
 =?us-ascii?Q?NTQyqegj6EcPeBW2x3vW33RXwpJ5p+F+Ubm9jsHHkLIVMemh9w7xKJchjxFr?=
 =?us-ascii?Q?ygz1BeCm+7N57y9dik0eACb/W77J8uAP6x5uhETxo4E/9Z6DvTJm5AtHNlrO?=
 =?us-ascii?Q?Um07sAH5hNFkMeizwdldLMXu3Isv4bY4eQ53nDRPauSspHT0TyW68jKNtBsW?=
 =?us-ascii?Q?Gb0C+0nr514wyO5cFJZ/jp41bMr0fcAw7JN/QgZhA83FK3L79grx3L4+PQC2?=
 =?us-ascii?Q?oN2JqErMnom/RGpzWBVrIrRfPxg4x5l38PNbkNGioh7Du+EUeuSRLEdzRg+l?=
 =?us-ascii?Q?QrCu9xvw4Uer/9GCaxNb1v36Vux9SXtMFl+LXE6VoAitH0mHZa4e1Uh6vguf?=
 =?us-ascii?Q?tglF+S4ubW1AkBJKVWVUiAEY6isSVGXedMvJl6cJwDivDY8hOtXp7c++nekL?=
 =?us-ascii?Q?Na0aDYLtZWZMCi7SBGjN7+c20+2wqXUVErpxNiQZ9ZbicjgrIIS0pE+ENZFZ?=
 =?us-ascii?Q?qNEAp98jzge+yQJEp18PYQj7Kr3dGw+SfE7ctxvBWuCJHOPqXA8Xnf5xKG/F?=
 =?us-ascii?Q?UhjDfxoBjlxjhue90/eKI8EtmIcJuiiJFnTc976TfQHR0Wdoy0OFKbYFBGcw?=
 =?us-ascii?Q?kSXV1Bb1Ugx7fZf8YiZWUMZvCE2Ah1ODH49uI4Rosa+FYNyAH0fGw8p0kInM?=
 =?us-ascii?Q?mYtAtXbeb6dQUf0AtcM5PKnh8JzgjUK+/W+yINnA6Lm4ENU41voGgP+b+W2M?=
 =?us-ascii?Q?MXNNE37aMFkwo0SerkLxLl6303Pw2N3IcPJCa0862CojUAK6yYK9kfe8edb2?=
 =?us-ascii?Q?6JBazp+hI6joBBW8Wp07JCDIaCVVkJ4GgYOf76C0PiIxZ+Q587ompbNw8KrP?=
 =?us-ascii?Q?MNs4OtmTFVoMbKEA49NTxJFKV1Ni8pF2AMcMpi9fkfLZyyI7DCFeoEs7YLnu?=
 =?us-ascii?Q?aqrPDdLo5hDuWuVjc0ZUPPHmzr5uW46aku/MJdHYj4thkuejJ601CPpgMbt+?=
 =?us-ascii?Q?yQgpO3D/z3pq1qRGEXSkFV0Jv1dDE9TUytWUY0FhlzIAYPruwPyNzlaQpZpL?=
 =?us-ascii?Q?xdpeETCO+JCo7dAgjSPMsdjqhFvdYCZR7gTMuGqIjAThf5k5R9muu8oYRtOY?=
 =?us-ascii?Q?T3FUIrcQ5Xk0vjXWWUbF76BVa8f5xnCjvKVmlsg+4klw7AjRaRJ7ou9bcPLV?=
 =?us-ascii?Q?6UzFG2UnBlqUfFVKO3BOdSvDgtlVLMBF2Qb0Oe9BCpvRkxILloAL3RIJax9+?=
 =?us-ascii?Q?EeS3Tn1wcVAItvusUY4zSRXbYyWJ5SSnEvIaRYJbFOvOgIidhAkYf9DTH+f/?=
 =?us-ascii?Q?WceYwC2nTTdEjEUSl3VTByifTTtt6UEIOULYpGiamWWzIfvnpBDYFYQ3V60M?=
 =?us-ascii?Q?+slwwBpCKpb36IAS1bNYLc/lqBbqijz963Wn42bj3JBlGb/gXS5lH+CAo8e6?=
 =?us-ascii?Q?PeMefB/TflqEpdQ2L4ZOF2ghilnzodoacXjMadqc80sIIjXUnH2vFbJZ9Qms?=
 =?us-ascii?Q?GS1LOJ4jJ5/8yG44sb7ltAd/hah1tlhuZhUNlqXMWOS+ZuJp8dEGDI2ZiBQF?=
 =?us-ascii?Q?7M8YR78Zxs3HiP/1dqSz0+q+qW7LhZ8weYjhXieWZMm5vnEIQIIj9W6BXXYs?=
 =?us-ascii?Q?zIQ66/G1955Wq0S6eTJh1TkVeZN6ylSpv9JsEAZiXtcvcd0Quf31xOl+iY3i?=
 =?us-ascii?Q?JeMh6qm53FF5dw0zW038/QPNAET37UGvDDfLL8kwqfUlIQMXv1msRDiRhoC5?=
 =?us-ascii?Q?QQpctWdarJvbRaKZxHR17Oo5R+NLozlo5pO/eqImQUtV4WE9VLn6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f404fc63-b378-4f70-a070-08df4bd4d209
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:49:14.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MetWTId8ChaDnTn606BgPhnjRz4Xu/ASQDN/+EUGU41qcmuNH3qLPahNJc6ER/wNMQ/sRgT70ndubrnzdXWJ7hO/x+Ki+YoVfyzSKEwZQvf7QvTa63ObaFafGhEZPel5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25173
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 16ba40151b1e6a52b28296a2173457bc6c31f022 upstream.

Adjust rz_dmac_chan_get_residue() to return error codes on failure and
provide the residue to callers through the residue parameter. This
prepares the code for the addition of runtime PM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-14-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d332907901d1..7b79795a54d9 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -859,8 +859,8 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct=
 rz_dmac_chan *channel,
 	return residue;
 }
=20
-static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
-				    dma_cookie_t cookie)
+static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_cha=
n *channel,
+				    dma_cookie_t cookie, u32 *residue)
 {
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
@@ -870,7 +870,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	if (vd) {
 		/* Descriptor has been issued but not yet processed. */
 		desc =3D to_rz_dmac_desc(vd);
-		return desc->len;
+		*residue =3D desc->len;
+		return 0;
 	} else if (channel->desc && channel->desc->vd.tx.cookie =3D=3D cookie) {
 		/* Descriptor is currently processed. */
 		desc =3D channel->desc;
@@ -878,6 +879,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
=20
 	if (!desc) {
 		/* Descriptor was not found. May be already completed by now. */
+		*residue =3D 0;
 		return 0;
 	}
=20
@@ -900,7 +902,9 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	 * Calculate number of bytes transferred in processing virtual descriptor=
.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla);
+	*residue =3D crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, =
crla);
+
+	return 0;
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -908,15 +912,20 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 					 struct dma_tx_state *txstate)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	enum dma_status status;
 	u32 residue;
=20
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		int ret;
+
 		status =3D dma_cookie_status(chan, cookie, txstate);
 		if (status =3D=3D DMA_COMPLETE || !txstate)
 			return status;
=20
-		residue =3D rz_dmac_chan_get_residue(channel, cookie);
+		ret =3D rz_dmac_chan_get_residue(dmac->dev, channel, cookie, &residue);
+		if (ret)
+			return DMA_ERROR;
=20
 		if (status =3D=3D DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 			status =3D DMA_PAUSED;
--=20
2.54.0

