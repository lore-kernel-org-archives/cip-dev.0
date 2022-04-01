X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3553.1648842163502856312
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:42:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200"; 
   d="scan'208";a="115453803"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:42:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8184F40061B8;
	Sat,  2 Apr 2022 04:42:40 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 03/40] mmc: renesas_sdhi: populate SCC pointer at the proper place
Date: Fri,  1 Apr 2022 20:41:57 +0100
Message-Id: <20220401194234.14057-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: <cip-dev.lists.cip-project.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit d14ac691bb6f6ebaa7eeec21ca04dd47300ff5b6 upstream.

The SCC pointer is currently filled whenever the SoC is Gen2+. This is
wrong because there is a Gen2-variant without SCC (SDHI_VER_GEN2_SDR50).
We have been lucky because the writes to unintended registers have not
caused problems so far. But further refactoring work exposed the
problem. So, move the pointer initialization to the place where we know
that the SDHI instance supports tuning. And also populate the 'reset'
pointer unconditionally to make sure the interrupt enable register is
always properly set for Gen2+.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20201110142058.36393-4-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 9dc9824e1f76..fc210c314e6c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1012,11 +1012,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.start_signal_voltage_switch =3D
 			renesas_sdhi_start_signal_voltage_switch;
 		host->sdcard_irq_setbit_mask =3D TMIO_STAT_ALWAYS_SET_27;
-
-		if (of_data && of_data->scc_offset) {
-			priv->scc_ctl =3D host->ctl + of_data->scc_offset;
-			host->reset =3D renesas_sdhi_reset;
-		}
+		host->reset =3D renesas_sdhi_reset;
 	}
=20
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -1096,6 +1092,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		if (!hit)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for tuning\n");
=20
+		priv->scc_ctl =3D host->ctl + of_data->scc_offset;
 		host->check_retune =3D renesas_sdhi_check_scc_error;
 		host->ops.execute_tuning =3D renesas_sdhi_execute_tuning;
 		host->ops.prepare_hs400_tuning =3D renesas_sdhi_prepare_hs400_tuning;
--=20
2.17.1


