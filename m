Return-Path: <SRS0=1xN2=BB=lists.cip-project.org=bounce+64572+4961+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1502C433E1
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85FC20787
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aMydnC+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85FC20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4961+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p0QaYY4521723x1wKYBYWt2m; Wed, 22 Jul 2020 10:47:06 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.23134.1595435708098355441
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:08 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620959"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:07 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F14FA4006CC9;
	Thu, 23 Jul 2020 01:35:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 08/17] drm: Add atomic variants for bridge enable/disable
Date: Wed, 22 Jul 2020 17:34:40 +0100
Message-Id: <20200722163449.3513-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QU8HeeHjnNBXvVTPDaQARRf5x4520388AA=
Content-Type: multipart/mixed; boundary="5xIJC7ssr6v5R9c8E4Mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440026;
 bh=SFjlYprNhzbOUgjcpK7aIRxPDWn4sQNj7QY7AAz+f1I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aMydnC+l30eUB5w+Xs0CUR+/S3jqOECD0yACfl8qUslrG44PoDvzW63x/MOlO3Fi4+T
 OblKkpS/OkzAgFgw8bA6YcuGcS0FVicZYeSmFleIlue5OnrO2cUcWiJZQFDB85mpXhCod
 XYkqpfD6q3DxvDhDsHgRkdFz56dK783nkEo=

--5xIJC7ssr6v5R9c8E4Mg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sean Paul <seanpaul@chromium.org>

commit 5ade071ba13e3bb24e3a9d5f8d6a3cf145deeb18 upstream.

This patch adds atomic variants for all of
pre_enable/enable/disable/post_disable bridge functions. These will be
called from the appropriate atomic helper functions. If the bridge
driver doesn't implement the atomic version of the function, we will
fall back to the vanilla implementation.

Note that some drivers call drm_bridge_disable directly, and these cases
are not covered. It's up to the driver to decide whether to implement
both atomic_disable and disable, or if it's not necessary.

Changes in v3:
- Added to the patchset
Changes in v4:
- Fix up docbook references (Daniel)
Changes in v5:
- None

Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-4-sean@poorly.run
Link to v4: https://patchwork.freedesktop.org/patch/msgid/20190508160920.144739-4-sean@poorly.run

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190611160844.257498-4-sean@poorly.run
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |   8 +-
 drivers/gpu/drm/drm_bridge.c        | 110 ++++++++++++++++++++++++++++
 include/drm/drm_bridge.h            | 106 +++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c22062cc9992..84bc8af8fc71 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -951,7 +951,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call disable hooks twice.
 		 */
-		drm_bridge_disable(encoder->bridge);
+		drm_atomic_bridge_disable(encoder->bridge, old_state);
 
 		/* Right function depends upon target state. */
 		if (funcs) {
@@ -963,7 +963,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
 		}
 
-		drm_bridge_post_disable(encoder->bridge);
+		drm_atomic_bridge_post_disable(encoder->bridge, old_state);
 	}
 
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -1262,7 +1262,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call enable hooks twice.
 		 */
-		drm_bridge_pre_enable(encoder->bridge);
+		drm_atomic_bridge_pre_enable(encoder->bridge, old_state);
 
 		if (funcs) {
 			if (funcs->enable)
@@ -1271,7 +1271,7 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 				funcs->commit(encoder);
 		}
 
-		drm_bridge_enable(encoder->bridge);
+		drm_atomic_bridge_enable(encoder->bridge, old_state);
 	}
 
 	drm_atomic_helper_commit_writebacks(dev, old_state);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..190f43380e29 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -348,6 +348,116 @@ void drm_bridge_enable(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_bridge_enable);
 
+/**
+ * drm_atomic_bridge_disable - disables all bridges in the encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_disable (falls back on
+ * &drm_bridge_funcs.disable) op for all the bridges in the encoder chain,
+ * starting from the last bridge to the first. These are called before calling
+ * &drm_encoder_helper_funcs.atomic_disable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_disable(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	drm_atomic_bridge_disable(bridge->next, state);
+
+	if (bridge->funcs->atomic_disable)
+		bridge->funcs->atomic_disable(bridge, state);
+	else if (bridge->funcs->disable)
+		bridge->funcs->disable(bridge);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_disable);
+
+/**
+ * drm_atomic_bridge_post_disable - cleans up after disabling all bridges in the
+ *				    encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_post_disable (falls back on
+ * &drm_bridge_funcs.post_disable) op for all the bridges in the encoder chain,
+ * starting from the first bridge to the last. These are called after completing
+ * &drm_encoder_helper_funcs.atomic_disable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->funcs->atomic_post_disable)
+		bridge->funcs->atomic_post_disable(bridge, state);
+	else if (bridge->funcs->post_disable)
+		bridge->funcs->post_disable(bridge);
+
+	drm_atomic_bridge_post_disable(bridge->next, state);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_post_disable);
+
+/**
+ * drm_atomic_bridge_pre_enable - prepares for enabling all bridges in the
+ *				  encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_pre_enable (falls back on
+ * &drm_bridge_funcs.pre_enable) op for all the bridges in the encoder chain,
+ * starting from the last bridge to the first. These are called before calling
+ * &drm_encoder_helper_funcs.atomic_enable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	drm_atomic_bridge_pre_enable(bridge->next, state);
+
+	if (bridge->funcs->atomic_pre_enable)
+		bridge->funcs->atomic_pre_enable(bridge, state);
+	else if (bridge->funcs->pre_enable)
+		bridge->funcs->pre_enable(bridge);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_pre_enable);
+
+/**
+ * drm_atomic_bridge_enable - enables all bridges in the encoder chain
+ * @bridge: bridge control structure
+ * @state: atomic state being committed
+ *
+ * Calls &drm_bridge_funcs.atomic_enable (falls back on
+ * &drm_bridge_funcs.enable) op for all the bridges in the encoder chain,
+ * starting from the first bridge to the last. These are called after completing
+ * &drm_encoder_helper_funcs.atomic_enable
+ *
+ * Note: the bridge passed should be the one closest to the encoder
+ */
+void drm_atomic_bridge_enable(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state)
+{
+	if (!bridge)
+		return;
+
+	if (bridge->funcs->atomic_enable)
+		bridge->funcs->atomic_enable(bridge, state);
+	else if (bridge->funcs->enable)
+		bridge->funcs->enable(bridge);
+
+	drm_atomic_bridge_enable(bridge->next, state);
+}
+EXPORT_SYMBOL(drm_atomic_bridge_enable);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d26eaa317fc2..97b17cb9cc51 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -237,6 +237,103 @@ struct drm_bridge_funcs {
 	 * The enable callback is optional.
 	 */
 	void (*enable)(struct drm_bridge *bridge);
+
+	/**
+	 * @atomic_pre_enable:
+	 *
+	 * This callback should enable the bridge. It is called right before
+	 * the preceding element in the display pipe is enabled. If the
+	 * preceding element is a bridge this means it's called before that
+	 * bridge's @atomic_pre_enable or @pre_enable function. If the preceding
+	 * element is a &drm_encoder it's called right before the encoder's
+	 * &drm_encoder_helper_funcs.atomic_enable hook.
+	 *
+	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
+	 * will not yet be running when this callback is called. The bridge must
+	 * not enable the display link feeding the next bridge in the chain (if
+	 * there is one) when this callback is called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_pre_enable. It
+	 * would be prudent to also provide an implementation of @pre_enable if
+	 * you are expecting driver calls into &drm_bridge_pre_enable.
+	 *
+	 * The @atomic_pre_enable callback is optional.
+	 */
+	void (*atomic_pre_enable)(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_enable:
+	 *
+	 * This callback should enable the bridge. It is called right after
+	 * the preceding element in the display pipe is enabled. If the
+	 * preceding element is a bridge this means it's called after that
+	 * bridge's @atomic_enable or @enable function. If the preceding element
+	 * is a &drm_encoder it's called right after the encoder's
+	 * &drm_encoder_helper_funcs.atomic_enable hook.
+	 *
+	 * The bridge can assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is running when this callback is called. This
+	 * callback must enable the display link feeding the next bridge in the
+	 * chain if there is one.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_enable. It
+	 * would be prudent to also provide an implementation of @enable if
+	 * you are expecting driver calls into &drm_bridge_enable.
+	 *
+	 * The enable callback is optional.
+	 */
+	void (*atomic_enable)(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state);
+	/**
+	 * @atomic_disable:
+	 *
+	 * This callback should disable the bridge. It is called right before
+	 * the preceding element in the display pipe is disabled. If the
+	 * preceding element is a bridge this means it's called before that
+	 * bridge's @atomic_disable or @disable vfunc. If the preceding element
+	 * is a &drm_encoder it's called right before the
+	 * &drm_encoder_helper_funcs.atomic_disable hook.
+	 *
+	 * The bridge can assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is still running when this callback is called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_disable. It
+	 * would be prudent to also provide an implementation of @disable if
+	 * you are expecting driver calls into &drm_bridge_disable.
+	 *
+	 * The disable callback is optional.
+	 */
+	void (*atomic_disable)(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state);
+
+	/**
+	 * @atomic_post_disable:
+	 *
+	 * This callback should disable the bridge. It is called right after the
+	 * preceding element in the display pipe is disabled. If the preceding
+	 * element is a bridge this means it's called after that bridge's
+	 * @atomic_post_disable or @post_disable function. If the preceding
+	 * element is a &drm_encoder it's called right after the encoder's
+	 * &drm_encoder_helper_funcs.atomic_disable hook.
+	 *
+	 * The bridge must assume that the display pipe (i.e. clocks and timing
+	 * signals) feeding it is no longer running when this callback is
+	 * called.
+	 *
+	 * Note that this function will only be invoked in the context of an
+	 * atomic commit. It will not be invoked from &drm_bridge_post_disable.
+	 * It would be prudent to also provide an implementation of
+	 * @post_disable if you are expecting driver calls into
+	 * &drm_bridge_post_disable.
+	 *
+	 * The post_disable callback is optional.
+	 */
+	void (*atomic_post_disable)(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state);
 };
 
 /**
@@ -323,6 +420,15 @@ void drm_bridge_mode_set(struct drm_bridge *bridge,
 void drm_bridge_pre_enable(struct drm_bridge *bridge);
 void drm_bridge_enable(struct drm_bridge *bridge);
 
+void drm_atomic_bridge_disable(struct drm_bridge *bridge,
+			       struct drm_atomic_state *state);
+void drm_atomic_bridge_post_disable(struct drm_bridge *bridge,
+				    struct drm_atomic_state *state);
+void drm_atomic_bridge_pre_enable(struct drm_bridge *bridge,
+				  struct drm_atomic_state *state);
+void drm_atomic_bridge_enable(struct drm_bridge *bridge,
+			      struct drm_atomic_state *state);
+
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 					u32 connector_type);
-- 
2.17.1


--5xIJC7ssr6v5R9c8E4Mg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4961): https://lists.cip-project.org/g/cip-dev/message=
/4961
Mute This Topic: https://lists.cip-project.org/mt/75730023/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--5xIJC7ssr6v5R9c8E4Mg--
