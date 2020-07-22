Return-Path: <SRS0=YkF+=BB=lists.cip-project.org=bounce+64572+4968+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A556C433EB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156C3207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="O7jnGhPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156C3207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4968+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JHfoYY4521723xrhstYUg5K7; Wed, 22 Jul 2020 10:47:07 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.22865.1595435717655545977
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:18 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832256"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:17 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9004F40078CA;
	Thu, 23 Jul 2020 01:35:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 13/17] drm: rcar-du: lvds: Allow for even and odd pixels swap
Date: Wed, 22 Jul 2020 17:34:45 +0100
Message-Id: <20200722163449.3513-14-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OLizzdSjvwehpwMoJFvTXdb5x4520388AA=
Content-Type: multipart/mixed; boundary="AVrV7MhWaAK7Y3smyV6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440027;
 bh=UVTijI4f0BSIll1cgb94CmZMryMLgOvveWh+8YvWhhY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O7jnGhPtEPBJ6gvDV6E+Y/ReYFYxpTfoOb1vZGW5ebm68Pig4oimaetPzw983nmWbIG
 L2Xj7Le5uNGk8UQMV7IzCjhbm936+rQ+SobXkJXXETt3wnsNpkDb2EOiUZoGUsA2gg6fG
 YFBcFthEtjM0rSfNhjLoOLpu04VzZF1ACYk=

--AVrV7MhWaAK7Y3smyV6f

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 59c1f061c97e70d81b046e90b259589b645bb87f upstream.

DT properties dual-lvds-even-pixels and dual-lvds-odd-pixels
can be used to work out if the driver needs to swap even
and odd pixels around.

This patch makes use of the return value from function
drm_of_lvds_get_dual_link_pixel_order to determine if we
need to swap odd and even pixels around for things to work
properly.

The dual_link boolean field from struct rcar_lvds is not
sufficient to describe the type of LVDS link anymore, since
we now have information related to pixel order, therefore
rename it to link_type and repurpose its usage to fit the
new requirements.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 77 ++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 12d2bbbb02f0..e4d0bd043613 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -35,6 +35,12 @@ enum rcar_lvds_mode {
 	RCAR_LVDS_MODE_VESA = 4,
 };
 
+enum rcar_lvds_link_type {
+	RCAR_LVDS_SINGLE_LINK = 0,
+	RCAR_LVDS_DUAL_LINK_EVEN_ODD_PIXELS = 1,
+	RCAR_LVDS_DUAL_LINK_ODD_EVEN_PIXELS = 2,
+};
+
 #define RCAR_LVDS_QUIRK_LANES		BIT(0)	/* LVDS lanes 1 and 3 inverted */
 #define RCAR_LVDS_QUIRK_GEN3_LVEN	BIT(1)	/* LVEN bit needs to be set on R8A77970/R8A7799x */
 #define RCAR_LVDS_QUIRK_PWD		BIT(2)	/* PWD bit available (all of Gen3 but E3) */
@@ -65,7 +71,7 @@ struct rcar_lvds {
 	} clocks;
 
 	struct drm_bridge *companion;
-	bool dual_link;
+	enum rcar_lvds_link_type link_type;
 };
 
 #define bridge_to_rcar_lvds(b) \
@@ -452,7 +458,7 @@ static void __rcar_lvds_atomic_enable(struct drm_bridge *bridge,
 		return;
 
 	/* Enable the companion LVDS encoder in dual-link mode. */
-	if (lvds->dual_link && lvds->companion)
+	if (lvds->link_type != RCAR_LVDS_SINGLE_LINK && lvds->companion)
 		__rcar_lvds_atomic_enable(lvds->companion, state, crtc,
 					  connector);
 
@@ -478,19 +484,38 @@ static void __rcar_lvds_atomic_enable(struct drm_bridge *bridge,
 	rcar_lvds_write(lvds, LVDCHCR, lvdhcr);
 
 	if (lvds->info->quirks & RCAR_LVDS_QUIRK_DUAL_LINK) {
-		/*
-		 * Configure vertical stripe based on the mode of operation of
-		 * the connected device.
-		 */
-		rcar_lvds_write(lvds, LVDSTRIPE,
-				lvds->dual_link ? LVDSTRIPE_ST_ON : 0);
+		u32 lvdstripe = 0;
+
+		if (lvds->link_type != RCAR_LVDS_SINGLE_LINK) {
+			/*
+			 * By default we generate even pixels from the primary
+			 * encoder and odd pixels from the companion encoder.
+			 * Swap pixels around if the sink requires odd pixels
+			 * from the primary encoder and even pixels from the
+			 * companion encoder.
+			 */
+			bool swap_pixels = lvds->link_type ==
+				RCAR_LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
+
+			/*
+			 * Configure vertical stripe since we are dealing with
+			 * an LVDS dual-link connection.
+			 *
+			 * ST_SWAP is reserved for the companion encoder, only
+			 * set it in the primary encoder.
+			 */
+			lvdstripe = LVDSTRIPE_ST_ON
+				  | (lvds->companion && swap_pixels ?
+				     LVDSTRIPE_ST_SWAP : 0);
+		}
+		rcar_lvds_write(lvds, LVDSTRIPE, lvdstripe);
 	}
 
 	/*
 	 * PLL clock configuration on all instances but the companion in
 	 * dual-link mode.
 	 */
-	if (!lvds->dual_link || lvds->companion) {
+	if (lvds->link_type == RCAR_LVDS_SINGLE_LINK || lvds->companion) {
 		const struct drm_crtc_state *crtc_state =
 			drm_atomic_get_new_crtc_state(state, crtc);
 		const struct drm_display_mode *mode =
@@ -584,7 +609,7 @@ static void rcar_lvds_atomic_disable(struct drm_bridge *bridge,
 	rcar_lvds_write(lvds, LVDPLLCR, 0);
 
 	/* Disable the companion LVDS encoder in dual-link mode. */
-	if (lvds->dual_link && lvds->companion)
+	if (lvds->link_type != RCAR_LVDS_SINGLE_LINK && lvds->companion)
 		lvds->companion->funcs->atomic_disable(lvds->companion, state);
 
 	clk_disable_unprepare(lvds->clocks.mod);
@@ -658,7 +683,7 @@ bool rcar_lvds_dual_link(struct drm_bridge *bridge)
 {
 	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
 
-	return lvds->dual_link;
+	return lvds->link_type != RCAR_LVDS_SINGLE_LINK;
 }
 EXPORT_SYMBOL_GPL(rcar_lvds_dual_link);
 
@@ -704,17 +729,28 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 	of_node_put(port0);
 	of_node_put(port1);
 
-	if (dual_link >= DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS)
-		lvds->dual_link = true;
-	else if (lvds->next_bridge && lvds->next_bridge->timings)
+	switch (dual_link) {
+	case DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS:
+		lvds->link_type = RCAR_LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
+		break;
+	case DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS:
+		lvds->link_type = RCAR_LVDS_DUAL_LINK_EVEN_ODD_PIXELS;
+		break;
+	default:
 		/*
 		 * Early dual-link bridge specific implementations populate the
-		 * timings field of drm_bridge, read the dual_link flag off the
-		 * bridge directly for backward compatibility.
+		 * timings field of drm_bridge. If the flag is set, we assume
+		 * that we are expected to generate even pixels from the primary
+		 * encoder, and odd pixels from the companion encoder.
 		 */
-		lvds->dual_link = lvds->next_bridge->timings->dual_link;
+		if (lvds->next_bridge && lvds->next_bridge->timings &&
+		    lvds->next_bridge->timings->dual_link)
+			lvds->link_type = RCAR_LVDS_DUAL_LINK_EVEN_ODD_PIXELS;
+		else
+			lvds->link_type = RCAR_LVDS_SINGLE_LINK;
+	}
 
-	if (!lvds->dual_link) {
+	if (lvds->link_type == RCAR_LVDS_SINGLE_LINK) {
 		dev_dbg(dev, "Single-link configuration detected\n");
 		goto done;
 	}
@@ -729,6 +765,9 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 		"Dual-link configuration detected (companion encoder %pOF)\n",
 		companion);
 
+	if (lvds->link_type == RCAR_LVDS_DUAL_LINK_ODD_EVEN_PIXELS)
+		dev_dbg(dev, "Data swapping required\n");
+
 	/*
 	 * FIXME: We should not be messing with the companion encoder private
 	 * data from the primary encoder, we should rather let the companion
@@ -739,7 +778,7 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 	 * for the time being.
 	 */
 	companion_lvds = bridge_to_rcar_lvds(lvds->companion);
-	companion_lvds->dual_link = true;
+	companion_lvds->link_type = lvds->link_type;
 
 done:
 	of_node_put(companion);
-- 
2.17.1


--AVrV7MhWaAK7Y3smyV6f
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4968): https://lists.cip-project.org/g/cip-dev/message=
/4968
Mute This Topic: https://lists.cip-project.org/mt/75730030/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--AVrV7MhWaAK7Y3smyV6f--
