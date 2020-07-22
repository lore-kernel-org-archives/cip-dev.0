Return-Path: <SRS0=Y5wb=BB=lists.cip-project.org=bounce+64572+4974+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D21AC433E7
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44434207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SiuPY/Ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44434207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4974+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dCZkYY4521723xcjhsKPjUQf; Wed, 22 Jul 2020 10:47:09 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23014.1595435704158275348
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:10 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832236"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:09 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F071240078CA;
	Thu, 23 Jul 2020 01:35:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/17] drm: rcar-du: lvds: Get mode from state
Date: Wed, 22 Jul 2020 17:34:41 +0100
Message-Id: <20200722163449.3513-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TBVoPTJtppmaPHdHJUZ01mzXx4520388AA=
Content-Type: multipart/mixed; boundary="eEROKms3QQbMlAPlYXPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440029;
 bh=ubxolEprD5aBrz3pFLtYth5n0+ei6UivwrRrkyiUWJE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SiuPY/Ou1QQpuecUBWYFqZsql9idyzSd17qS7zMfB4BoWxNsRZ38OZTL+SBElSKNE9E
 ooyYTTjoUxVeGeiKpqvU3GGedsU3bs16ICPGF1Rq5KEXMP6UKQMW5jOPlKZZAj28hFNIY
 7cBQ71t8leJnMd5MZGDQCwtTPFUX1mJ6oUs=

--eEROKms3QQbMlAPlYXPF

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 593885b085d699c9f49992c3ea50f372e0c7008d upstream.

The R-Car LVDS encoder driver implements the bridge .mode_set()
operation for the sole purpose of storing the mode in the LVDS private
data, to be used later when enabling the encoder.

Switch to the bridge .atomic_enable() and .atomic_disable() operations
in order to access the global atomic state, and get the mode from the
state instead. Remove both the unneeded .mode_set() operation and the
display_mode and mode fields storing state data from the rcar_lvds
private structure.

As a side effect we get the CRTC from the state, replace the CRTC
pointer retrieved through the bridge's encoder that shouldn't be used by
atomic drivers.

While at it, clarify a few error messages in rcar_lvds_get_lvds_mode()
and turn them into warnings as they are not fatal.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Tested-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 140 +++++++++++++++-------------
 1 file changed, 74 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 2558067efe22..aa07af7d944f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -63,9 +63,6 @@ struct rcar_lvds {
 		struct clk *dotclkin[2];	/* External DU clocks */
 	} clocks;
 
-	struct drm_display_mode display_mode;
-	enum rcar_lvds_mode mode;
-
 	struct drm_bridge *companion;
 	bool dual_link;
 };
@@ -398,10 +395,53 @@ EXPORT_SYMBOL_GPL(rcar_lvds_clk_disable);
  * Bridge
  */
 
-static void rcar_lvds_enable(struct drm_bridge *bridge)
+static enum rcar_lvds_mode rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds,
+					const struct drm_connector *connector)
+{
+	const struct drm_display_info *info;
+	enum rcar_lvds_mode mode;
+
+	/*
+	 * There is no API yet to retrieve LVDS mode from a bridge, only panels
+	 * are supported.
+	 */
+	if (!lvds->panel)
+		return RCAR_LVDS_MODE_JEIDA;
+
+	info = &connector->display_info;
+	if (!info->num_bus_formats || !info->bus_formats) {
+		dev_warn(lvds->dev,
+			 "no LVDS bus format reported, using JEIDA\n");
+		return RCAR_LVDS_MODE_JEIDA;
+	}
+
+	switch (info->bus_formats[0]) {
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		mode = RCAR_LVDS_MODE_JEIDA;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		mode = RCAR_LVDS_MODE_VESA;
+		break;
+	default:
+		dev_warn(lvds->dev,
+			 "unsupported LVDS bus format 0x%04x, using JEIDA\n",
+			 info->bus_formats[0]);
+		return RCAR_LVDS_MODE_JEIDA;
+	}
+
+	if (info->bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
+		mode |= RCAR_LVDS_MODE_MIRROR;
+
+	return mode;
+}
+
+static void __rcar_lvds_atomic_enable(struct drm_bridge *bridge,
+				      struct drm_atomic_state *state,
+				      struct drm_crtc *crtc,
+				      struct drm_connector *connector)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
-	const struct drm_display_mode *mode = &lvds->display_mode;
 	u32 lvdhcr;
 	u32 lvdcr0;
 	int ret;
@@ -412,7 +452,8 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 
 	/* Enable the companion LVDS encoder in dual-link mode. */
 	if (lvds->dual_link && lvds->companion)
-		lvds->companion->funcs->enable(lvds->companion);
+		__rcar_lvds_atomic_enable(lvds->companion, state, crtc,
+					  connector);
 
 	/*
 	 * Hardcode the channels and control signals routing for now.
@@ -448,18 +489,20 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 	 * PLL clock configuration on all instances but the companion in
 	 * dual-link mode.
 	 */
-	if (!lvds->dual_link || lvds->companion)
+	if (!lvds->dual_link || lvds->companion) {
+		const struct drm_crtc_state *crtc_state =
+			drm_atomic_get_new_crtc_state(state, crtc);
+		const struct drm_display_mode *mode =
+			&crtc_state->adjusted_mode;
+
 		lvds->info->pll_setup(lvds, mode->clock * 1000);
+	}
 
 	/* Set the LVDS mode and select the input. */
-	lvdcr0 = lvds->mode << LVDCR0_LVMD_SHIFT;
+	lvdcr0 = rcar_lvds_get_lvds_mode(lvds, connector) << LVDCR0_LVMD_SHIFT;
 
 	if (lvds->bridge.encoder) {
-		/*
-		 * FIXME: We should really retrieve the CRTC through the state,
-		 * but how do we get a state pointer?
-		 */
-		if (drm_crtc_index(lvds->bridge.encoder->crtc) == 2)
+		if (drm_crtc_index(crtc) == 2)
 			lvdcr0 |= LVDCR0_DUSEL;
 	}
 
@@ -512,7 +555,21 @@ static void rcar_lvds_enable(struct drm_bridge *bridge)
 	}
 }
 
-static void rcar_lvds_disable(struct drm_bridge *bridge)
+static void rcar_lvds_atomic_enable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state)
+{
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+
+	__rcar_lvds_atomic_enable(bridge, state, crtc, connector);
+}
+
+static void rcar_lvds_atomic_disable(struct drm_bridge *bridge,
+				     struct drm_atomic_state *state)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
 
@@ -527,7 +584,7 @@ static void rcar_lvds_disable(struct drm_bridge *bridge)
 
 	/* Disable the companion LVDS encoder in dual-link mode. */
 	if (lvds->dual_link && lvds->companion)
-		lvds->companion->funcs->disable(lvds->companion);
+		lvds->companion->funcs->atomic_disable(lvds->companion, state);
 
 	clk_disable_unprepare(lvds->clocks.mod);
 }
@@ -550,54 +607,6 @@ static bool rcar_lvds_mode_fixup(struct drm_bridge *bridge,
 	return true;
 }
 
-static void rcar_lvds_get_lvds_mode(struct rcar_lvds *lvds)
-{
-	struct drm_display_info *info = &lvds->connector.display_info;
-	enum rcar_lvds_mode mode;
-
-	/*
-	 * There is no API yet to retrieve LVDS mode from a bridge, only panels
-	 * are supported.
-	 */
-	if (!lvds->panel)
-		return;
-
-	if (!info->num_bus_formats || !info->bus_formats) {
-		dev_err(lvds->dev, "no LVDS bus format reported\n");
-		return;
-	}
-
-	switch (info->bus_formats[0]) {
-	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
-	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
-		mode = RCAR_LVDS_MODE_JEIDA;
-		break;
-	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
-		mode = RCAR_LVDS_MODE_VESA;
-		break;
-	default:
-		dev_err(lvds->dev, "unsupported LVDS bus format 0x%04x\n",
-			info->bus_formats[0]);
-		return;
-	}
-
-	if (info->bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
-		mode |= RCAR_LVDS_MODE_MIRROR;
-
-	lvds->mode = mode;
-}
-
-static void rcar_lvds_mode_set(struct drm_bridge *bridge,
-			       struct drm_display_mode *mode,
-			       struct drm_display_mode *adjusted_mode)
-{
-	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
-
-	lvds->display_mode = *adjusted_mode;
-
-	rcar_lvds_get_lvds_mode(lvds);
-}
-
 static int rcar_lvds_attach(struct drm_bridge *bridge)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
@@ -639,10 +648,9 @@ static void rcar_lvds_detach(struct drm_bridge *bridge)
 static const struct drm_bridge_funcs rcar_lvds_bridge_ops = {
 	.attach = rcar_lvds_attach,
 	.detach = rcar_lvds_detach,
-	.enable = rcar_lvds_enable,
-	.disable = rcar_lvds_disable,
+	.atomic_enable = rcar_lvds_atomic_enable,
+	.atomic_disable = rcar_lvds_atomic_disable,
 	.mode_fixup = rcar_lvds_mode_fixup,
-	.mode_set = rcar_lvds_mode_set,
 };
 
 bool rcar_lvds_dual_link(struct drm_bridge *bridge)
-- 
2.17.1


--eEROKms3QQbMlAPlYXPF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4974): https://lists.cip-project.org/g/cip-dev/message=
/4974
Mute This Topic: https://lists.cip-project.org/mt/75730036/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eEROKms3QQbMlAPlYXPF--
