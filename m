Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C99C88E59
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40205.1789135316738766942
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8910040F0C;
	Fri, 11 Sep 2026 14:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7381F000FF;
	Fri, 11 Sep 2026 14:01:55 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 02/14] mmc: tmio: add callback for dma irq
Date: Fri, 11 Sep 2026 17:01:39 +0300
Message-ID: <20260911140151.2119555-3-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24134

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit af728d7ae20483add9f8d3c81280dc6298a0aa2e upstream.

We don't want to rely only on the access_end irq in the future, so
implement a callback for dma irqs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-4-wsa+renesas@sang-en=
gineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 92e9bfd92bf7..bfd45856d198 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -129,6 +129,7 @@ struct tmio_mmc_dma_ops {
=20
 	/* optional */
 	void (*end)(struct tmio_mmc_host *host);	/* held host->lock */
+	bool (*dma_irq)(struct tmio_mmc_host *host);
 };
=20
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
index a000ce001994..0cb7cccfeea2 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -705,6 +705,9 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_hos=
t *host, int ireg,
 		return true;
 	}
=20
+	if (host->dma_ops && host->dma_ops->dma_irq && host->dma_ops->dma_irq(h=
ost))
+		return true;
+
 	return false;
 }
=20
--=20
2.43.0


