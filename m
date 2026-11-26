Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16115.1795706765652055498
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7409542363;
	Thu, 26 Nov 2026 15:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5598A1F000C0;
	Thu, 26 Nov 2026 15:26:04 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/11] ASoC: renesas: rz-ssi: Drop the & operator in front of function name
Date: Thu, 26 Nov 2026 17:25:47 +0200
Message-ID: <20261126152553.1298561-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25143
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c7a4c368e7135046c358ff15c4f7897e2522dedc upstream.

There is no need for & operator in front of the function name. Drop it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-4-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 568c6a892ffc..1d93dbfb5149 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -1197,7 +1197,7 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 		goto err_release_dma_chs;
 	}
=20
-	ret =3D devm_request_irq(dev, ssi->irq_int, &rz_ssi_interrupt,
+	ret =3D devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "irq request error (int_req)\n");
@@ -1214,7 +1214,7 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 				return ssi->irq_rt;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rt,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
@@ -1227,14 +1227,14 @@ static int rz_ssi_probe(struct platform_device *p=
dev)
 				return ssi->irq_rx;
=20
 			ret =3D devm_request_irq(dev, ssi->irq_tx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
 						"irq request error (dma_tx)\n");
=20
 			ret =3D devm_request_irq(dev, ssi->irq_rx,
-					       &rz_ssi_interrupt, 0,
+					       rz_ssi_interrupt, 0,
 					       dev_name(dev), ssi);
 			if (ret < 0)
 				return dev_err_probe(dev, ret,
--=20
2.43.0

