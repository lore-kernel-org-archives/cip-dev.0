X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3553.1648842163502856312
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="115453820"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6497A40061B8;
	Sat,  2 Apr 2022 04:42:50 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 09/40] mmc: renesas_sdhi: don't hardcode SDIF values
Date: Fri,  1 Apr 2022 20:42:03 +0100
Message-Id: <20220401194234.14057-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0e08a411585214360938022ca3f50a9f1cd91753 upstream.

Use a macro to name the hardcoded values. Also, move the SDIF register
definition into the SDHI driver because this is an SDHI extension.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201111100244.15823-3-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 7 +++++--
 drivers/mmc/host/tmio_mmc.h          | 1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 0d46896176c6..c061c68c41d1 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -49,6 +49,9 @@
 #define HOST_MODE_GEN3_32BIT	(HOST_MODE_GEN3_WMODE | HOST_MODE_GEN3_BUSWID=
TH)
 #define HOST_MODE_GEN3_64BIT	0
=20
+#define CTL_SDIF_MODE	0xe6
+#define SDIF_MODE_HS400		BIT(0)
+
 #define SDHI_VER_GEN2_SDR50	0x490c
 #define SDHI_VER_RZ_A1		0x820b
 /* very old datasheets said 0x490c for SDR104, too. They are wrong! */
@@ -381,7 +384,7 @@ static void renesas_sdhi_hs400_complete(struct mmc_host=
 *mmc)
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
=20
 	/* Set HS400 mode */
-	sd_ctrl_write16(host, CTL_SDIF_MODE, 0x0001 |
+	sd_ctrl_write16(host, CTL_SDIF_MODE, SDIF_MODE_HS400 |
 			sd_ctrl_read16(host, CTL_SDIF_MODE));
=20
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
@@ -529,7 +532,7 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_m=
mc_host *host,
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
=20
 	/* Reset HS400 mode */
-	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
+	sd_ctrl_write16(host, CTL_SDIF_MODE, ~SDIF_MODE_HS400 &
 			sd_ctrl_read16(host, CTL_SDIF_MODE));
=20
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9546e542619c..7ff41185896a 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -42,7 +42,6 @@
 #define CTL_DMA_ENABLE 0xd8
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
-#define CTL_SDIF_MODE 0xe6
=20
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
 #define TMIO_STOP_STP		BIT(0)
--=20
2.17.1


