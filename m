X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.3718.1648842160078866267
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="116465324"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:46 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB3E140061B8;
	Sat,  2 Apr 2022 04:42:45 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 06/40] mmc: renesas_sdhi: merge the SCC reset functions
Date: Fri,  1 Apr 2022 20:42:00 +0100
Message-Id: <20220401194234.14057-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 80d0be81102405f1172f9b017feef323e5931959 upstream.

There is no user of renesas_sdhi_reset_scc() anymore, only
renesas_sdhi_disable_scc() so merge these functions into one. I guess
the seperation was cruft anyhow. The BSP doesn't have it anymore and I
can't recall the reason we had it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201110162151.37622-3-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index da8c9cf5a942..9eb3aaeeffc7 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -424,9 +424,11 @@ static void renesas_sdhi_hs400_complete(struct mmc_hos=
t *mmc)
 		priv->needs_adjust_hs400 =3D true;
 }
=20
-static void renesas_sdhi_reset_scc(struct tmio_mmc_host *host,
-				   struct renesas_sdhi *priv)
+static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
 {
+	struct tmio_mmc_host *host =3D mmc_priv(mmc);
+	struct renesas_sdhi *priv =3D host_to_priv(host);
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
=20
@@ -434,14 +436,6 @@ static void renesas_sdhi_reset_scc(struct tmio_mmc_hos=
t *host,
 		       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
 		       sd_scc_read32(host, priv,
 				     SH_MOBILE_SDHI_SCC_CKSEL));
-}
-
-static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
-{
-	struct tmio_mmc_host *host =3D mmc_priv(mmc);
-	struct renesas_sdhi *priv =3D host_to_priv(host);
-
-	renesas_sdhi_reset_scc(host, priv);
=20
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
 		       ~SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN &
--=20
2.17.1


