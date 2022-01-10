X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000"; 
   d="scan'208";a="106554183"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2C7EC4211C1D;
	Mon, 10 Jan 2022 21:23:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/61] ravb: Remove checks for unsupported internal delay modes
Date: Mon, 10 Jan 2022 12:22:39 +0000
Message-Id: <20220110122331.24114-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 44e5d08812805bcb0f37e18f6c4eab1174a9d053 upstream.

The EtherAVB instances on the R-Car E3/D3 and RZ/G2E SoCs do not support
TX clock internal delay modes, and the EtherAVB driver prints a warning
if an unsupported "rgmii-*id" PHY mode is specified, to catch buggy
DTBs.

Commit a6f51f2efa742df0 ("ravb: Add support for explicit internal
clock delay configuration") deprecated deriving the internal delay mode
from the PHY mode, in favor of explicit configuration using the now
mandatory "rx-internal-delay-ps" and "tx-internal-delay-ps" properties,
thus delegating the warning to the legacy fallback code.

Since explicit configuration of a (valid) internal clock delay
configuration is enforced by validating device tree source files against
DT binding files, and all upstream DTS files have been converted as of
commit a5200e63af57d05e ("arm64: dts: renesas: rzg2: Convert EtherAVB to
explicit delay handling"), the checks in the legacy fallback code can be
removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/2037542ac56e99413b9807e24049711553cc88a9.16=
28696778.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/etherne=
t/renesas/ravb_main.c
index 267533123140..541f4ebf7135 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1971,13 +1971,6 @@ static void ravb_set_config_mode(struct net_device *=
ndev)
 	}
 }
=20
-static const struct soc_device_attribute ravb_delay_mode_quirk_match[] =3D=
 {
-	{ .soc_id =3D "r8a774c0" },
-	{ .soc_id =3D "r8a77990" },
-	{ .soc_id =3D "r8a77995" },
-	{ /* sentinel */ }
-};
-
 /* Set tx and rx clock internal delay modes */
 static void ravb_parse_delay_mode(struct device_node *np, struct net_devic=
e *ndev)
 {
@@ -2008,12 +2001,8 @@ static void ravb_parse_delay_mode(struct device_node=
 *np, struct net_device *nde
=20
 	if (priv->phy_interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
 	    priv->phy_interface =3D=3D PHY_INTERFACE_MODE_RGMII_TXID) {
-		if (!WARN(soc_device_match(ravb_delay_mode_quirk_match),
-			  "phy-mode %s requires TX clock internal delay mode which is not suppo=
rted by this hardware revision. Please update device tree",
-			  phy_modes(priv->phy_interface))) {
-			priv->txcidm =3D 1;
-			priv->rgmii_override =3D 1;
-		}
+		priv->txcidm =3D 1;
+		priv->rgmii_override =3D 1;
 	}
 }
=20
--=20
2.17.1


