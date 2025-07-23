Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B14C83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 02:00:50 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.13907.1753275892245996295
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 06:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm1 header.b=EppArLmg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1331196-202507231254484309cff8f34aec2294-lvnf4h@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202507231254484309cff8f34aec2294
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Jul 2025 14:54:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4sIkjUFdplID/OJt5EesmMMoEvv+ylpd9wa/5CTYhMY=;
 b=EppArLmgKX9iNDHtuPxnAewBNG1GwO7bLjfaLAxln+iMBtqDWYSAdoCCjRZoMLiFitLcjg
 4qS4ffircHRmDRDaBJcw+xv5v3zRwKbxWEJYfWX33txy3AzP9GC4kqtDsh0GLcu/QiIVdl1m
 +n84Gxvo4Iaak5xSAVy6ej4xPxFe8DKlAV7q9PEbQFCrIuJXC1OseO+B4CorwgU4q11/h9u/
 0DjPpXElFBDZac5RRRgUw9R5Z39cg6k2yVFtZga5gE3rCsDfY1OfZ9Gl7AD33MnyC/yJLDyX
 yIRHOzZMzpYg3WZyH1CeD9fVeblFYZr3A1s19kpmFC3HRrQMx8c3YUsA==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 3/5] [PARTIAL BACKPORT]drm/probe_helper: extract two helper functions
Date: Wed, 23 Jul 2025 15:54:25 +0300
Message-Id: <20250723125427.59324-4-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 02:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19578

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Extract drm_kms_helper_enable_hpd() and drm_kms_helper_disable_hpd(),
two helpers that enable and disable HPD handling on all device's
connectors.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230124104548.3234554-1-dmitry.baryshkov@linaro.org
(cherry picked from commit cbf143b282c64e59559cc8351c0b5b1ab4bbdcbe)
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Partial-Backport-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 787f6699971f1..938649e3a282f 100644
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


