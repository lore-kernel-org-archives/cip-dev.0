Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646FC88E5B
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40055.1789135319503093295
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:01:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5017243F3B;
	Fri, 11 Sep 2026 14:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB3E1F000FF;
	Fri, 11 Sep 2026 14:01:58 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 04/14] mmc: renesas_sdhi: remove outdated headers
Date: Fri, 11 Sep 2026 17:01:41 +0300
Message-ID: <20260911140151.2119555-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
References: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24136

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 583e48372eb1370cf24195a2236878810df58d4f upstream.

We moved quirk handling out of the SDHI core to the individual drivers.
So, no need to include headers needed for soc_device_match et al.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220320123016.57991-2-wsa+renesas@sang-e=
ngineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/rene=
sas_sdhi_core.c
index 0b47198edb3f..0be49d90ed28 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -27,7 +27,6 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl-state.h>
 #include <linux/platform_device.h>
@@ -37,7 +36,6 @@
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
-#include <linux/sys_soc.h>
=20
 #include "renesas_sdhi.h"
 #include "tmio_mmc.h"
--=20
2.43.0


