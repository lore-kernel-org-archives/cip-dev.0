Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34110.1792979250529836783
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=wGAgWjX6;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979245;x=1794188845;bh=RO
	qLxRWvFuu5CXSgfPjk1GY57GYKt0n02tpng6UztpI=;b=wGAgWjX6yHZlvQG03Cu+i5pFDdUCr73Y
	PV8+atXxTEG3zmnxpGoFB4RQcfHRYv711+Bq1yoo2o62Da6FfZOG7SbDcpkkC3QTtrBirVQT45Ks2
	PT4ylcxCSifWjormKsRSRmKFl0B0ASg1t5x2uRQiJ8sbFjGPFqEJArajmwabMiYQwR2vNnPCpZIdw
	PhK7l6B+T9AHDlygSrLJpoefVhsq+K4KRGOcObYzIrCb/rmiwKLZ/nzeRioyBD1j9lbMT5sp69NFk
	L4YrYnXdJdEGcLRVwnDjopumACpUAJsmO8ek332olvj2SuZxelZ/NUwhD3ViRILxOA/q4/A163YpG
	IA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 69Q1lPFv347832; Mon, 26 Oct 2026 10:47:25 +0900
X-Iguazu-Qid: 2yAac6huv7e12MaNct
X-Iguazu-QSIG: v=2; s=1; t=1792979244; q=2yAac6huv7e12MaNct; m=cO50mgFv4YjzIdcIvBB0+lqbVOGUhKJ9UzbvzgMRb5o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc245JJRzyPk; Mon, 26 Oct 2026 10:47:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 1/5] i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
Date: Mon, 26 Oct 2026 10:47:18 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24525
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Felix Gu <ustc.gu@gmail.com>

commit d7665c3b4f575251e449e2656879392346ca612b upstream.

The xfer structure allocated by renesas_i3c_alloc_xfer() was never freed
in the renesas_i3c_i3c_xfers() function. Use the __free(kfree) cleanup
attribute to automatically free the memory when the variable goes out of
scope.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Link: https://patch.msgid.link/20260406-renesas-v3-1-4b724d7708f4@gmail.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/i3c/master/renesas-i3c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 2086a3ff016eea..16c9b54057a9ef 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -818,13 +819,12 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer
 	struct i3c_master_controller *m = i3c_dev_get_master(dev);
 	struct renesas_i3c *i3c = to_renesas_i3c(m);
 	struct renesas_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
-	struct renesas_i3c_xfer *xfer;
 	int i;
 
 	/* Enable I3C bus. */
 	renesas_i3c_bus_enable(m, true);
 
-	xfer = renesas_i3c_alloc_xfer(i3c, 1);
+	struct renesas_i3c_xfer *xfer __free(kfree) = renesas_i3c_alloc_xfer(i3c, 1);
 	if (!xfer)
 		return -ENOMEM;
 
-- 
2.55.0


