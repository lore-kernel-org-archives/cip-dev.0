Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F9C87FCA
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 04:39:27 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.39794.1753892600242934485
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 09:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm2 header.b=OQnyxUHD;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1331196-20250730161315c8b8c6650a7268b1c0-_xe2bd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250730161315c8b8c6650a7268b1c0
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Jul 2025 18:13:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=YFPzJYoDv3cX+8o/GvSkSkoQ51LHu7AECjzM4Hsiq/U=;
 b=OQnyxUHD5CsAuL9spD+tylm+gUMS42osIg5+Pz8wfGHWjkYP3maOoQjmUpfjRO7BEMe6XI
 n+0RNaAGAvvn+PgdgU6NGC9zs6VnMjXQT/M4wBBHHWrDoosgfSArgqwu9xUOnok6qCa2+Wdy
 33WMdR11z4kiDcMbb3w6b0GmUMjojVuJL/yVvPlQKudonxYSknWC+33q2A0hYbUUISPgUksw
 DhAbgeQLKWz4WLnVeOgrHgrRMVrbWSiNoS5t45uSN5CFtuX/luPAfM5Z5ShoF+MFkteMAWq/
 e2IjBnekR2aNq1Fyab2hgXllDLVC8abdxIIyTOvWwfEOqoB4uiGexfmg==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: cip-dev@lists.cip-project.org,
	imre.deak@intel.com,
	jouni.hogander@intel.com,
	neil.armstrong@linaro.org,
	jani.nikula@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tvrtko.ursulin@linux.intel.com,
	laurentiu.palcu@oss.nxp.com,
	cedric.hombourger@siemens.com,
	shrikant.bobade@siemens.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 4/5] drm/probe-helper: enable and disable HPD on connectors
Date: Wed, 30 Jul 2025 19:11:05 +0300
Message-Id: <20250730161106.80725-5-nicusor.huhulea@siemens.com>
In-Reply-To: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
References: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 04:39:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19629

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

commit c8268795c9a9cc7be50f78d4502fad83a2a4f8df upstream

This is not a direct cherry-pick of the upstream commit.
Only the helper functions required as dependencies for
"drm/i915: Fix HPD polling, reenabling the output poll work as needed"
were extracted from the original commit. The rest of the code was not
applied, as the codebase has diverged significantly from upstream.

This partial adaptation ensures that the required drm_connector_helper_funcs
are available for the dependent fix, while minimizing changes to the existing code.

Introduce two drm_connector_helper_funcs: enable_hpd() and disable_hpd().
They are called by drm_kms_helper_poll_enable() and
drm_kms_helper_poll_disable() (and thus drm_kms_helper_poll_init() and
drm_kms_helper_poll_fini()) respectively.

This allows DRM drivers to rely on drm_kms_helper_poll for enabling and
disabling HPD detection rather than doing that manually.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20221102180705.459294-3-dmitry.baryshkov@linaro.org
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 include/drm/drm_modeset_helper_vtables.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 6f19cf5c210e..54f4848a655a 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1144,6 +1144,28 @@ struct drm_connector_helper_funcs {
 	 */
 	void (*cleanup_writeback_job)(struct drm_writeback_connector *connector,
 				      struct drm_writeback_job *job);
+
+	/**
+	 * @enable_hpd:
+	 *
+	 * Enable hot-plug detection for the connector.
+	 *
+	 * This operation is optional.
+	 *
+	 * This callback is used by the drm_kms_helper_poll_enable() helpers.
+	 */
+	void (*enable_hpd)(struct drm_connector *connector);
+
+	/**
+	 * @disable_hpd:
+	 *
+	 * Disable hot-plug detection for the connector.
+	 *
+	 * This operation is optional.
+	 *
+	 * This callback is used by the drm_kms_helper_poll_disable() helpers.
+	 */
+	void (*disable_hpd)(struct drm_connector *connector);
 };
 
 /**
-- 
2.39.2


