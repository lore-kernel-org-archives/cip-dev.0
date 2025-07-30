Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2EC87FCA
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 04:39:37 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.39793.1753892600143497351
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 09:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm2 header.b=iIaJRT+c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1331196-20250730161314544bddabb8590cdbf7-kmoghd@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250730161314544bddabb8590cdbf7
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Jul 2025 18:13:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/FpSd6XrEiDlegW7TGUbZc+yNUb5v89AQii/650dub8=;
 b=iIaJRT+ccdwMSxtQ0LahuNcmrmJLW+d2XTD3d4FczQ11pSmyFkOSt4wZ/ax2EwnSCCS+ob
 L9oP7O5DwVwfuFyzO2w4CzWDoOr147DQqywYz/KnG/8KrI1ghYlq8p+dHQsE9GFGSwsRlxQn
 1Xjv69PVnzY1CXcH/uSsXFXk3m4J7le1hArDXgwR6Z4xqSLNe2SMkNvMWB0m75ZsGX8SADHR
 QR82HglZUd6fW8g0DVAf7/6p6zYWzlBkoH99WbCE2LFWf2ozRKEZaCcA3ilvhrk2zg7ky7B3
 BsNN8tgZktek7TtfGc6cfey+CAJA2OHfONnJ9eMrlNjl90sn6dwI4ocA==;
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
	Jani Nikula <jani.nikula@intel.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 3/5] drm/probe_helper: extract two helper functions
Date: Wed, 30 Jul 2025 19:11:04 +0300
Message-Id: <20250730161106.80725-4-nicusor.huhulea@siemens.com>
In-Reply-To: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
References: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 04:39:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19631

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

commit cbf143b282c64e59559cc8351c0b5b1ab4bbdcbe upstream

This is not a direct cherry-pick of the upstream commit. Only the helper
functions required as dependencies for "drm/i915: Fix HPD polling, reenabling
the output poll work as needed" were extracted from the original commit. The rest
of the code was not applied, as the codebase has diverged significantly.

This partial adaptation ensures that the required helpers are available for the
dependent fix, while minimizing changes to the existing code.

Extract drm_kms_helper_enable_hpd() and drm_kms_helper_disable_hpd(),
two helpers that enable and disable HPD handling on all device's
connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230124104548.3234554-1-dmitry.baryshkov@linaro.org
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 787f6699971f..938649e3a282 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -244,6 +244,45 @@ static void reschedule_output_poll_work(struct drm_device *dev)
 	schedule_delayed_work(&dev->mode_config.output_poll_work, delay);
 }
 
+static void drm_kms_helper_disable_hpd(struct drm_device *dev)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		const struct drm_connector_helper_funcs *funcs =
+			connector->helper_private;
+
+		if (funcs && funcs->disable_hpd)
+			funcs->disable_hpd(connector);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
+
+static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
+{
+	bool poll = false;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		const struct drm_connector_helper_funcs *funcs =
+			connector->helper_private;
+
+		if (funcs && funcs->enable_hpd)
+			funcs->enable_hpd(connector);
+
+		if (connector->polled & (DRM_CONNECTOR_POLL_CONNECT |
+					 DRM_CONNECTOR_POLL_DISCONNECT))
+			poll = true;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return poll;
+}
+
 /**
  * drm_kms_helper_poll_enable - re-enable output polling.
  * @dev: drm_device
-- 
2.39.2


