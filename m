X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3553.1648842163502856312
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="115453815"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D337940061B8;
	Sat,  2 Apr 2022 04:42:48 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 08/40] mmc: renesas_sdhi: improve HOST_MODE usage
Date: Fri,  1 Apr 2022 20:42:02 +0100
Message-Id: <20220401194234.14057-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 4533c3eb893d8d6881f792a855fa5e11d5ddf0c2 upstream.

HOST_MODE should have a CTL_ prefix, too. This makes the code more
readable because we immediately know what it is. Also, remove the
hardcoded values with something readable, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201111100244.15823-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index eb33bbf368e5..0d46896176c6 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -39,7 +39,15 @@
 #include "renesas_sdhi.h"
 #include "tmio_mmc.h"
=20
-#define HOST_MODE		0xe4
+#define CTL_HOST_MODE	0xe4
+#define HOST_MODE_GEN2_SDR50_WMODE	BIT(0)
+#define HOST_MODE_GEN2_SDR104_WMODE	BIT(0)
+#define HOST_MODE_GEN3_WMODE		BIT(0)
+#define HOST_MODE_GEN3_BUSWIDTH		BIT(8)
+
+#define HOST_MODE_GEN3_16BIT	HOST_MODE_GEN3_WMODE
+#define HOST_MODE_GEN3_32BIT	(HOST_MODE_GEN3_WMODE | HOST_MODE_GEN3_BUSWID=
TH)
+#define HOST_MODE_GEN3_64BIT	0
=20
 #define SDHI_VER_GEN2_SDR50	0x490c
 #define SDHI_VER_RZ_A1		0x820b
@@ -60,26 +68,26 @@ static void renesas_sdhi_sdbuf_width(struct tmio_mmc_ho=
st *host, int width)
 	 */
 	switch (sd_ctrl_read16(host, CTL_VERSION)) {
 	case SDHI_VER_GEN2_SDR50:
-		val =3D (width =3D=3D 32) ? 0x0001 : 0x0000;
+		val =3D (width =3D=3D 32) ? HOST_MODE_GEN2_SDR50_WMODE : 0;
 		break;
 	case SDHI_VER_GEN2_SDR104:
-		val =3D (width =3D=3D 32) ? 0x0000 : 0x0001;
+		val =3D (width =3D=3D 32) ? 0 : HOST_MODE_GEN2_SDR104_WMODE;
 		break;
 	case SDHI_VER_GEN3_SD:
 	case SDHI_VER_GEN3_SDMMC:
 		if (width =3D=3D 64)
-			val =3D 0x0000;
+			val =3D HOST_MODE_GEN3_64BIT;
 		else if (width =3D=3D 32)
-			val =3D 0x0101;
+			val =3D HOST_MODE_GEN3_32BIT;
 		else
-			val =3D 0x0001;
+			val =3D HOST_MODE_GEN3_16BIT;
 		break;
 	default:
 		/* nothing to do */
 		return;
 	}
=20
-	sd_ctrl_write16(host, HOST_MODE, val);
+	sd_ctrl_write16(host, CTL_HOST_MODE, val);
 }
=20
 static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
@@ -800,7 +808,7 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_ho=
st *host, int addr)
 	case CTL_SD_MEM_CARD_OPT:
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
-	case HOST_MODE:
+	case CTL_HOST_MODE:
 		if (host->pdata->flags & TMIO_MMC_HAVE_CBSY)
 			bit =3D TMIO_STAT_CMD_BUSY;
 		fallthrough;
--=20
2.17.1


