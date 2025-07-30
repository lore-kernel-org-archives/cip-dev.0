Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A69C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 04:39:17 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.39785.1753892600589298132
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 09:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm2 header.b=BrLHKARN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1331196-20250730161316cf09c724b26b5bc4f1-1feplf@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250730161316cf09c724b26b5bc4f1
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Jul 2025 18:13:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=csY52TarazJEPmk/SsPbeY44Azar0/QHTLRBPgxrjAg=;
 b=BrLHKARNA7uCaaVovxHR0YJA5NPtQp7HKAibs+IDvmWS2ZIXtLI42TFUpUsd/bypG3HQDQ
 qUcWtrXvfRBuDiuGhU4DFOjcF7ybJMS3P6E9asn7/rSbnETIE7XxF+7u3fOBivBP98xFJSiX
 INB09FsvXCcsVzyHRVtGFyE66Av8NZMrZtnluyWNBY0YqHzHLTVKRkoGh24vhpitv80/FHoZ
 2hC3ocsw1sEyX+fAJomaGRfa2XhxlDXY/S6z4HbZVk7kUFJT+a4ORywIp1Ez27ZTjmxu0Cwh
 Y9ky+VL6c7i5D9vTuZGyQGizTohR7BFk9j0EDBSsISPVCVSC6e6ULGlA==;
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
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 5/5] drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues
Date: Wed, 30 Jul 2025 19:11:06 +0300
Message-Id: <20250730161106.80725-6-nicusor.huhulea@siemens.com>
In-Reply-To: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
References: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 04:39:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19628

This collects and adapts several upstream fixes to make i915 and related
DRM subsystem build and function.
The upstream fix HPD polling("drm/i915: Fix HPD polling, reenabling the output poll work as needed")
and its dependencies could not be directly backported due to extensive code differences.

Upstream commits:
drm/i915: Fix HPD polling, reenabling the output poll work as needed(commit 50452f2f76852322620b63e62922b85e955abe9)
drm: Add an HPD poll helper to reschedule the poll work(commit fe2352fd64029918174de4b460dfe6df0c6911cd)
drm/probe_helper: extract two helper functions(commit cbf143b282c64e59559cc8351c0b5b1ab4bbdcbe)
drm/probe-helper: enable and disable HPD on connectors(commit c8268795c9a9cc7be50f78d4502fad83a2a4f8df)
...

Due to significant codebase divergence and numerous dependencies, it was not
possible to cherry-pick these commits cleanly. Instead, this will resolve compile-time
errors and fixes the hot plug mechanism. Developed with uspstream as a guideline,
with the goal of addressing the defect while maintaining the stability.

Auxiliary fixes in upstream commits were not ported here as this would require
substantial work and dependency tracking.

Cc: stable@vger.kernel.org # 6.1.y
Cc: dri-devel@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 938649e3a282..9dc7505f20ff 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -304,8 +304,6 @@ static bool drm_kms_helper_enable_hpd(struct drm_device *dev)
 void drm_kms_helper_poll_enable(struct drm_device *dev)
 {
 
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
 
 	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
 	    !drm_kms_helper_poll || dev->mode_config.poll_running)
@@ -779,8 +777,11 @@ static void output_poll_execute(struct work_struct *work)
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
@@ -897,9 +898,14 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
 void drm_kms_helper_poll_disable(struct drm_device *dev)
 {
 	if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
-		return;
+		pr_warn("%s: called with poll_enabled = false\n", __func__);
+
+	if (dev->mode_config.poll_running)
+		drm_kms_helper_disable_hpd(dev);
 
 	cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
+
+	dev->mode_config.poll_running = false;
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_disable);
 
-- 
2.39.2


