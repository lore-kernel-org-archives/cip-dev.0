Return-Path: <SRS0=+R6u=BB=lists.cip-project.org=bounce+64572+4964+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEA2C433E5
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D28E20787
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="onO2UxEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D28E20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4964+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GrLxYY4521723xx3vrnKMx1x; Wed, 22 Jul 2020 10:47:07 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23009.1595435695048125216
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:00 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620948"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:34:59 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6771C4006CC9;
	Thu, 23 Jul 2020 01:34:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/17] drm: rcar-du: lvds: Add support for dual-link mode
Date: Wed, 22 Jul 2020 17:34:36 +0100
Message-Id: <20200722163449.3513-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: icDOT6RyyfqbRmRCzMeirVmBx4520388AA=
Content-Type: multipart/mixed; boundary="Qhca0BHroW2O6ncCGlB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440027;
 bh=oVVTxD15UqWQWr8FamNwHSUXNn3iAQEsprc0JXs1FKY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=onO2UxErDqDGUrvG9dCruhuKZi+5AgIAW9OfFO5Qj8CDzoymUzpeoE6o12ywzIhrtFl
 62xwk42sVZiD59iKsu/T/aXVPAtm8hXAU/2B8MaIoN7wVhJ8o8M9p+LifMe31J37gvL8z
 sw/Nwxv+KqrST3Fh651IsdQ6TbNUov/TFwI=

--Qhca0BHroW2O6ncCGlB9

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit fa440d870358fd01eeedd212a1ad918a3b2771d5 upstream.

In dual-link mode the LVDS0 encoder transmits even-numbered pixels, and
sends odd-numbered pixels to the LVDS1 encoder for transmission on a
separate link.

To implement support for this mode of operation, determine if the LVDS
connection operates in dual-link mode by querying the next device in the
pipeline, locate the companion encoder, and control it directly through
its bridge operations.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 107 ++++++++++++++++++++++++----
 drivers/gpu/drm/rcar-du/rcar_lvds.h |   5 ++
 2 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 067017d25993..0774bd00dfac 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -65,6 +65,9 @@ struct rcar_lvds {
 
 	struct drm_display_mode display_mode;
 	enum rcar_lvds_mode mode;
+
+	struct drm_bridge *companion;
+	bool dual_link;
 };
 
 #define bridge_to_rcar_lvds(b) \
@@ -399,11 +402,6 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
 	const struct drm_display_mode *mode = &lvds->display_mode;
-	/*
-	 * FIXME: We should really retrieve the CRTC through the state, but how
-	 * do we get a state pointer?
-	 */
-	struct drm_crtc *crtc = lvds->bridge.encoder->crtc;
 	u32 lvdhcr;
 	u32 lvdcr0;
 	int ret;
@@ -412,6 +410,10 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 	if (ret < 0)
 		return;
 
+	/* Enable the companion LVDS encoder in dual-link mode. */
+	if (lvds->dual_link && lvds->companion)
+		lvds->companion->funcs->enable(lvds->companion);
+
 	/*
 	 * Hardcode the channels and control signals routing for now.
 	 *
@@ -434,17 +436,33 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 	rcar_lvds_write(lvds, LVDCHCR, lvdhcr);
 
 	if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK) {
-		/* Disable dual-link mode. */
-		rcar_lvds_write(lvds, LVDSTRIPE, 0);
+		/*
+		 * Configure vertical stripe based on the mode of operation of
+		 * the connected device.
+		 */
+		rcar_lvds_write(lvds, LVDSTRIPE,
+				lvds->dual_link ? LVDSTRIPE_ST_ON : 0);
 	}
 
-	/* PLL clock configuration. */
-	lvds->info->pll_setup(lvds, mode->clock * 1000);
+	/*
+	 * PLL clock configuration on all instances but the companion in
+	 * dual-link mode.
+	 */
+	if (!lvds->dual_link || lvds->companion)
+		lvds->info->pll_setup(lvds, mode->clock * 1000);
 
 	/* Set the LVDS mode and select the input. */
 	lvdcr0 = lvds->mode << LVDCR0_LVMD_SHIFT;
-	if (drm_crtc_index(crtc) == 2)
-		lvdcr0 |= LVDCR0_DUSEL;
+
+	if (lvds->bridge.encoder) {
+		/*
+		 * FIXME: We should really retrieve the CRTC through the state,
+		 * but how do we get a state pointer?
+		 */
+		if (drm_crtc_index(lvds->bridge.encoder->crtc) == 2)
+			lvdcr0 |= LVDCR0_DUSEL;
+	}
+
 	rcar_lvds_write(lvds, LVDCR0, lvdcr0);
 
 	/* Turn all the channels on. */
@@ -507,6 +525,10 @@ static void rcar_lvds_disable(struct drm_bridge *bridge)
 	rcar_lvds_write(lvds, LVDCR1, 0);
 	rcar_lvds_write(lvds, LVDPLLCR, 0);
 
+	/* Disable the companion LVDS encoder in dual-link mode. */
+	if (lvds->dual_link && lvds->companion)
+		lvds->companion->funcs->disable(lvds->companion);
+
 	clk_disable_unprepare(lvds->clocks.mod);
 }
 
@@ -623,10 +645,57 @@ static const struct drm_bridge_funcs rcar_lvds_bridge_ops = {
 	.mode_set = rcar_lvds_mode_set,
 };
 
+bool rcar_lvds_dual_link(struct drm_bridge *bridge)
+{
+	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
+
+	return lvds->dual_link;
+}
+EXPORT_SYMBOL_GPL(rcar_lvds_dual_link);
+
 /* -----------------------------------------------------------------------------
  * Probe & Remove
  */
 
+static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
+{
+	const struct of_device_id *match;
+	struct device_node *companion;
+	struct device *dev = lvds->dev;
+	int ret = 0;
+
+	/* Locate the companion LVDS encoder for dual-link operation, if any. */
+	companion = of_parse_phandle(dev->of_node, "renesas,companion", 0);
+	if (!companion) {
+		dev_err(dev, "Companion LVDS encoder not found\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Sanity check: the companion encoder must have the same compatible
+	 * string.
+	 */
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!of_device_is_compatible(companion, match->compatible)) {
+		dev_err(dev, "Companion LVDS encoder is invalid\n");
+		ret = -ENXIO;
+		goto done;
+	}
+
+	lvds->companion = of_drm_find_bridge(companion);
+	if (!lvds->companion) {
+		ret = -EPROBE_DEFER;
+		goto done;
+	}
+
+	dev_dbg(dev, "Found companion encoder %pOF\n", companion);
+
+done:
+	of_node_put(companion);
+
+	return ret;
+}
+
 static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 {
 	struct device_node *local_output = NULL;
@@ -677,14 +746,26 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 
 	if (is_bridge) {
 		lvds->next_bridge = of_drm_find_bridge(remote);
-		if (!lvds->next_bridge)
+		if (!lvds->next_bridge) {
 			ret = -EPROBE_DEFER;
+			goto done;
+		}
+
+		if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK)
+			lvds->dual_link = lvds->next_bridge->timings
+					? lvds->next_bridge->timings->dual_link
+					: false;
 	} else {
 		lvds->panel = of_drm_find_panel(remote);
-		if (IS_ERR(lvds->panel))
+		if (IS_ERR(lvds->panel)) {
 			ret = PTR_ERR(lvds->panel);
+			goto done;
+		}
 	}
 
+	if (lvds->dual_link)
+		ret = rcar_lvds_parse_dt_companion(lvds);
+
 done:
 	of_node_put(local_output);
 	of_node_put(remote_input);
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.h b/drivers/gpu/drm/rcar-du/rcar_lvds.h
index a709cae1bc32..222ec0e60785 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.h
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.h
@@ -15,6 +15,7 @@ struct drm_bridge;
 #if IS_ENABLED(CONFIG_DRM_RCAR_LVDS)
 int rcar_lvds_clk_enable(struct drm_bridge *bridge, unsigned long freq);
 void rcar_lvds_clk_disable(struct drm_bridge *bridge);
+bool rcar_lvds_dual_link(struct drm_bridge *bridge);
 #else
 static inline int rcar_lvds_clk_enable(struct drm_bridge *bridge,
 				       unsigned long freq)
@@ -22,6 +23,10 @@ static inline int rcar_lvds_clk_enable(struct drm_bridge *bridge,
 	return -ENOSYS;
 }
 static inline void rcar_lvds_clk_disable(struct drm_bridge *bridge) { }
+static inline bool rcar_lvds_dual_link(struct drm_bridge *bridge)
+{
+	return false;
+}
 #endif /* CONFIG_DRM_RCAR_LVDS */
 
 #endif /* __RCAR_LVDS_H__ */
-- 
2.17.1


--Qhca0BHroW2O6ncCGlB9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4964): https://lists.cip-project.org/g/cip-dev/message=
/4964
Mute This Topic: https://lists.cip-project.org/mt/75730026/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Qhca0BHroW2O6ncCGlB9--
