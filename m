Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5205AC83F17
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 02:01:10 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.14299.1753275892420355601
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 06:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm1 header.b=ZTQ4b7uP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1331196-20250723125448447b7fb5cd2e71ef1d-ew3ffg@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250723125448447b7fb5cd2e71ef1d
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Jul 2025 14:54:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QoDheIrvNRDAEQPiC6JaBemdqxmI5gWE5MYCKu9QUZg=;
 b=ZTQ4b7uPo5GL7Pq35+AjVSgeEHTgrlgB8TH12XNeNEE44ZKzyd9z67b3pyfcEFNhKjZuKE
 PbdEyWVjBfqSDFWRQuSUIkRPnSX9EkQbpEFYNW7FGGd233hBZdu40jQG7S27DZ946EmNqjdf
 lswBOAciOmxvNUuGwyN2/FQ9L3hoz3hI1PaqM8pz36B2upgj83j05ZgyJdMwOTr6o2wUswTe
 UkeE9u2IDJ9D1n/8bDZLjhYLMeNSoTcAHEi+98/T9iRMsABknNCLOXOxqJOFW7jkuxHhz6mc
 o6W90+TwUnACag268oQHmWHHoUlqvM1BjDEQlzE8ZTn9P54mxaZY955w==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 4/5] [PARTIAL BACKPORT]drm/probe-helper: enable and disable HPD on connectors
Date: Wed, 23 Jul 2025 15:54:26 +0300
Message-Id: <20250723125427.59324-5-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 02:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19580

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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
Partial-Backport-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 include/drm/drm_modeset_helper_vtables.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 6f19cf5c210e5..54f4848a655ab 100644
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


