Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31CBC79F80
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 08:01:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8994.1788508862474424384
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Sep 2026 01:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=AmFRFOX4;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1788508847;x=1789718447;bh=5L0q0MexMRgweqAV8ZJBvUf7/mn/PUoI/XZ4xsKIJFs=;b=AmF
	RFOX4g95qcahYzHegwKJWhkvzT20mMifsVQcrb8EjdbE7LVjLnIxTIw8vvRuf5/ENeAuYKUommmfb
	L05nqKj45DVJAPRivkxdBOztuq51xQ90DWfornJSJNyEsQJJSlUuSvDKGAsWxwIeJULAoJUXHdryJ
	69Ey9XcFI882UhA9Dg9WTTZIjVhJpmXhhkApsYf/gpoSsz7sDp0FTMa6qoE1msIZkVuWVnwxSFzM4
	3fMdq8uNIbMqRJdAOvvqgIo+QnxEeQEVL9xsQxJHvKjSX/gHJH8tl7HVCnq0Y8GhcPvKg7UdYjKIM
	5dHrEIj263QY7XHOw98v1bluavEjOyw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 68480ktJ1341906; Fri, 4 Sep 2026 17:00:47 +0900
X-Iguazu-Qid: 2yAbeCtgxEPKFP6VZE
X-Iguazu-QSIG: v=2; s=1; t=1788508846; q=2yAbeCtgxEPKFP6VZE; m=JWpJyfyJ9NKop+MqpPOhcMazyuuungoKZZzWTWtltfw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4hbpmr531wz1xnZ; Fri,  4 Sep 2026 17:00:44 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com,
        biju.das.jz@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.12.y-cip] can: rcar_canfd: change the initializing flow for clocks and resets
Date: Fri,  4 Sep 2026 17:00:43 +0900
X-TSB-HOP2: ON
Message-Id: <1788508843-19240-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Sep 2026 08:01:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24094

From: Tu Nguyen <tu.nguyen.xg@renesas.com>

commit bef9004c5b91debfceaea2841855a4ebe81ff2b3 upstream.

Testing CANFD on RZ/G3E shows that many registers do not reset to their
initial values with the current flow of deasserting resets first and then
enabling clocks.

Based on the HW manual, clocks should be supplied first and the
resets deasserted afterward.

 section 7.4.3 Procedure for Activating Modules: RZ/G2L
 section 4.4.9.3 Procedure for Starting up Units: RZ/G3E

So, update the order of the initializing flow for resets and clocks
to match the hardware manual, resetting all CANFD registers to their
initial values. Also update rcar_canfd_global_deinit() to assert
resets before disabling clocks, so the teardown path mirrors the new
init ordering.

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20260625135216.130450-1-biju.das.jz@bp.renesas.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[iwamatsu: Although this issue was fixed in the LTS commit 869eb255e499 ("can:
  rcar_canfd: change the initializing flow for clocks and resets"), it is not
  applied correctly due to a patch that was backported to CIP.
  This patch is intended to reapply the fix.]
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/net/can/rcar/rcar_canfd.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a0480807f41b7..951bfbc2c949e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2004,20 +2004,12 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	u32 ch, sts;
 	int err;
 
-	err = reset_control_reset(gpriv->rstc1);
-	if (err)
-		return err;
-
-	err = reset_control_reset(gpriv->rstc2);
-	if (err)
-		goto fail_reset1;
-
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
 		dev_err(dev, "failed to enable peripheral clock: %pe\n",
 			ERR_PTR(err));
-		goto fail_reset2;
+		return err;
 	}
 
 	/* Enable RAM clock */
@@ -2028,10 +2020,18 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 		goto fail_clk;
 	}
 
+	err = reset_control_reset(gpriv->rstc1);
+	if (err)
+		goto fail_ram_clk;
+
+	err = reset_control_reset(gpriv->rstc2);
+	if (err)
+		goto fail_reset1;
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_ram_clk;
+		goto fail_reset2;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2069,14 +2069,14 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
-fail_ram_clk:
-	clk_disable_unprepare(gpriv->clk_ram);
-fail_clk:
-	clk_disable_unprepare(gpriv->clkp);
 fail_reset2:
 	reset_control_assert(gpriv->rstc2);
 fail_reset1:
 	reset_control_assert(gpriv->rstc1);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
+fail_clk:
+	clk_disable_unprepare(gpriv->clkp);
 	return err;
 }
 
@@ -2091,10 +2091,10 @@ static void rcar_canfd_global_deinit(struct rcar_canfd_global *gpriv, bool full)
 		rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	}
 
-	clk_disable_unprepare(gpriv->clk_ram);
-	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
+	clk_disable_unprepare(gpriv->clk_ram);
+	clk_disable_unprepare(gpriv->clkp);
 }
 
 static int rcar_canfd_probe(struct platform_device *pdev)
-- 
2.53.0



