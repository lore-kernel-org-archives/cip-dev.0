Return-Path: <SRS0=jATX=BB=lists.cip-project.org=bounce+64572+4975+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FEC433F4
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49271207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dBPsyxqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49271207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4975+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NLd2YY4521723xumM118MGpI; Wed, 22 Jul 2020 10:47:09 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23014.1595435704158275348
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:06 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832230"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:05 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0A8C64006CC9;
	Thu, 23 Jul 2020 01:35:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/17] drm: Add drm_atomic_get_(old|new)_connector_for_encoder() helpers
Date: Wed, 22 Jul 2020 17:34:39 +0100
Message-Id: <20200722163449.3513-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 453pmO0yWli6Bn4rM0LcukhTx4520388AA=
Content-Type: multipart/mixed; boundary="IuGRLlpFmaItl13nUfjV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440029;
 bh=I9gGZ13JWO89z2DJRsaQhd7BNJdD6vZR8DRwWudLFIg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dBPsyxqkz2XTWV8mFqaF9DgBMaBdOSVHTVY6UgT5GrQ6QvY0IY9+R8p/FT+DpPsywvi
 LvSjuiZxwyAAzwtXPzfZwlaP5rqiw88JRcqeGP05sFphh5dx9SebuSr5jq0y7Jh5L5OUc
 Sox4SEeGxnB2MXRG3tbEgqmu1DnOnMbR7pU=

--IuGRLlpFmaItl13nUfjV

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

commit 1b27fbdde1df172dba604855c45078d741f8c858 upstream.

Add functions to the atomic core to retrieve the old and new connectors
associated with an encoder in a drm_atomic_state. This is useful for
encoders and bridges that need to access the connector, for instance for
the drm_display_info.

The CRTC associated with the encoder can also be retrieved through the
connector state, and from it, the old and new CRTC states.

Changed in v4:
- Added to the set
Changed in v5:
- Fix up docbook (Daniel & Laurent)
Changed in v6:
- Updated commit subject (Sam)

Link to v4: https://patchwork.freedesktop.org/patch/msgid/20190508160920.144739-3-sean@poorly.run
Link to v5: https://patchwork.freedesktop.org/patch/msgid/20190611160844.257498-3-sean@poorly.run

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[seanpaul removed WARNs from helpers and added docs to explain why
returning NULL might be valid]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190611205147.181298-1-sean@poorly.run
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_atomic.c | 113 +++++++++++++++++++++++++++++++++++
 include/drm/drm_atomic.h     |   7 +++
 include/drm/drm_connector.h  |   9 +++
 3 files changed, 129 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 1a4b44923aec..d36742761ada 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1252,6 +1252,119 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 }
 EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
 
+/**
+ * drm_atomic_get_old_private_obj_state
+ * @state: global atomic state object
+ * @obj: private_obj to grab
+ *
+ * This function returns the old private object state for the given private_obj,
+ * or NULL if the private_obj is not part of the global atomic state.
+ */
+struct drm_private_state *
+drm_atomic_get_old_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj)
+{
+	int i;
+
+	for (i = 0; i < state->num_private_objs; i++)
+		if (obj == state->private_objs[i].ptr)
+			return state->private_objs[i].old_state;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_private_obj_state);
+
+/**
+ * drm_atomic_get_new_private_obj_state
+ * @state: global atomic state object
+ * @obj: private_obj to grab
+ *
+ * This function returns the new private object state for the given private_obj,
+ * or NULL if the private_obj is not part of the global atomic state.
+ */
+struct drm_private_state *
+drm_atomic_get_new_private_obj_state(struct drm_atomic_state *state,
+				     struct drm_private_obj *obj)
+{
+	int i;
+
+	for (i = 0; i < state->num_private_objs; i++)
+		if (obj == state->private_objs[i].ptr)
+			return state->private_objs[i].new_state;
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_private_obj_state);
+
+/**
+ * drm_atomic_get_old_connector_for_encoder - Get old connector for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the connector state for
+ *
+ * This function finds and returns the connector that was connected to @encoder
+ * as specified by the @state.
+ *
+ * If there is no connector in @state which previously had @encoder connected to
+ * it, this function will return NULL. While this may seem like an invalid use
+ * case, it is sometimes useful to differentiate commits which had no prior
+ * connectors attached to @encoder vs ones that did (and to inspect their
+ * state). This is especially true in enable hooks because the pipeline has
+ * changed.
+ *
+ * Returns: The old connector connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_connector *
+drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+	unsigned int i;
+
+	for_each_old_connector_in_state(state, connector, conn_state, i) {
+		if (conn_state->best_encoder == encoder)
+			return connector;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
+
+/**
+ * drm_atomic_get_new_connector_for_encoder - Get new connector for an encoder
+ * @state: Atomic state
+ * @encoder: The encoder to fetch the connector state for
+ *
+ * This function finds and returns the connector that will be connected to
+ * @encoder as specified by the @state.
+ *
+ * If there is no connector in @state which will have @encoder connected to it,
+ * this function will return NULL. While this may seem like an invalid use case,
+ * it is sometimes useful to differentiate commits which have no connectors
+ * attached to @encoder vs ones that do (and to inspect their state). This is
+ * especially true in disable hooks because the pipeline will change.
+ *
+ * Returns: The new connector connected to @encoder, or NULL if the encoder is
+ * not connected.
+ */
+struct drm_connector *
+drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+	unsigned int i;
+
+	for_each_new_connector_in_state(state, connector, conn_state, i) {
+		if (conn_state->best_encoder == encoder)
+			return connector;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);
+
 /**
  * drm_atomic_get_connector_state - get connector state
  * @state: global atomic state object
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 1e713154f00e..c0b48e25a620 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -403,6 +403,13 @@ struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 				 struct drm_private_obj *obj);
 
+struct drm_connector *
+drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+struct drm_connector *
+drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
+					 struct drm_encoder *encoder);
+
 /**
  * drm_atomic_get_existing_crtc_state - get crtc state, if it exists
  * @state: global atomic state object
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 97ea41dc678f..6f0a05b6581d 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -397,6 +397,15 @@ struct drm_connector_state {
 	 * Used by the atomic helpers to select the encoder, through the
 	 * &drm_connector_helper_funcs.atomic_best_encoder or
 	 * &drm_connector_helper_funcs.best_encoder callbacks.
+	 *
+	 * This is also used in the atomic helpers to map encoders to their
+	 * current and previous connectors, see
+	 * &drm_atomic_get_old_connector_for_encoder() and
+	 * &drm_atomic_get_new_connector_for_encoder().
+	 *
+	 * NOTE: Atomic drivers must fill this out (either themselves or through
+	 * helpers), for otherwise the GETCONNECTOR and GETENCODER IOCTLs will
+	 * not return correct data to userspace.
 	 */
 	struct drm_encoder *best_encoder;
 
-- 
2.17.1


--IuGRLlpFmaItl13nUfjV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4975): https://lists.cip-project.org/g/cip-dev/message=
/4975
Mute This Topic: https://lists.cip-project.org/mt/75730037/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--IuGRLlpFmaItl13nUfjV--
