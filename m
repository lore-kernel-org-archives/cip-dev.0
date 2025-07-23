Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6025EC83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 02:01:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.13908.1753275894061954177
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 06:04:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm1 header.b=MglFjfvd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1331196-20250723125448c0b5800eb7dd859138-w4oixt@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250723125448c0b5800eb7dd859138
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Jul 2025 14:54:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CmWKiW941gwJk+MvXALLibbPKbxpDHZXMVyouz/PIFY=;
 b=MglFjfvdP0OdzgaajRsGdNfiknoawldc6yA0RerKkZHyUvhXbaIJa4btp3dfs6kA3kfOSf
 bhD6TJSjvcE28v+OwQ6jtyjM5tmSMQZX1bMoxPi6uXq4Ee6KLqxXcuSbRJ5pMsrxyzShEhsN
 B1wqeGOsajgAaGAqDP+jPxFHepJ70NcCVXvo02+VXHXI8rGB6DTlP3Bs0cKpvZfHSRAH+gdk
 dczP/ZnZQw4Y2sh6IXjCF/lIRvXI3pTVo70R5Ihb3+UQ73+/g9I1QwbYz77F26APdt03A5Hc
 TJ5N3XMJA7nCU9DBXg1G1e1ocuf4lWOyKfo9D8o78h1A4W1GPfIogeVg==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 5/5] [PARTIAL BACKPORT]fixes for i915 Hot Plug Detection and build/runtime issues
Date: Wed, 23 Jul 2025 15:54:27 +0300
Message-Id: <20250723125427.59324-6-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 02:01:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19583

This collects and adapts several upstream fixes to make i915 and related
DRM subsystem build and function.
The hot plug mechanism is fixed by
"drm/i915: Fix HPD polling, reenabling the output poll work as needed"

Upstream commits:
        drm/i915: Fix HPD polling, reenabling the output poll work as needed
	drm: Add an HPD poll helper to reschedule the poll work
	drm/probe_helper: extract two helper functions
	drm/probe-helper: enable and disable HPD on connectors
	...

Due to significant codebase divergence and numerous dependencies, it was not
possible to cherry-pick these commits cleanly. Instead, this patch will resolve
compile-time errors and fixes the hot plug mechanism.

Auxiliary fixes in upstream commits were not ported here as this would require
substantial work and dependency tracking.


Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 938649e3a282f..46e664e69bbf3 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -304,9 +304,6 @@ static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
 void drm_kms_helper_poll_enable(struct drm_device *dev)
 {
 
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-
 	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
 	    !drm_kms_helper_poll || dev->mode_config.poll_running)
 		return;
@@ -314,8 +311,6 @@ void drm_kms_helper_poll_enable(struct drm_device *dev)
 	if (drm_kms_helper_enable_hpd(dev) ||
 	    dev->mode_config.delayed_event)
 		reschedule_output_poll_work(dev);
-
-	dev->mode_config.poll_running = true;
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_enable);
 
@@ -779,8 +774,11 @@ static void output_poll_execute(struct work_struct *work)
 	changed = dev->mode_config.delayed_event;
 	dev->mode_config.delayed_event = false;
 
-	if (!drm_kms_helper_poll)
+	if (!drm_kms_helper_poll && dev->mode_config.poll_running) {
+		drm_kms_helper_disable_hpd(dev);
+		dev->mode_config.poll_running = false;
 		goto out;
+	}
 
 	if (!mutex_trylock(&dev->mode_config.mutex)) {
 		repoll = true;
@@ -896,10 +894,12 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
  */
 void drm_kms_helper_poll_disable(struct drm_device *dev)
 {
-	if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
-		return;
+	if (dev->mode_config.poll_running)
+		drm_kms_helper_disable_hpd(dev);
 
 	cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
+
+	dev->mode_config.poll_running = false;
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_disable);
 
-- 
2.39.2


