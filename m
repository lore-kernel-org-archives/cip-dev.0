Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2DEC83F17
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 02:01:00 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.14297.1753275892057536049
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 06:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm1 header.b=UbKDpbJA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1331196-20250723125447cf5ecd717e72344007-olp5wf@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250723125447cf5ecd717e72344007
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Jul 2025 14:54:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LE3+0AIR5ifMVaBXt4QetfhIe/IlOZ44SlT+/gozdT0=;
 b=UbKDpbJAcscj0QexmrxvnGtDhH2LFbyHKKcRyDznQNyJOZdDX1EMS7tEKJSsgvdeoVT47l
 YNMIchn09JgWa9igSU4NelItmIdyIT9YBgczUR6WOdMX7U11Xwle8AQS6c7LzyebbeUT17Bg
 u9ZJSqYwhsGZqJ1H+vp3ArWDcvqc5eLWVozKagX5dUvyb4FaCPWxB7Q+u918ruA+cdVak/d5
 fJy7FC74axA01KFYehwg27XxgpNOL/vHadO0UC8oXm3TdtbAyoLedqf9MCEfyRhXGr0ncxEe
 R73WzcQbpUJcmkXBk24xkA1VSeUh+3uw0BM6c7UXPcjWLTX06QwxhvaA==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Imre Deak <imre.deak@intel.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 1/5] [PARTIAL BACKPORT]drm/i915: Fix HPD polling, reenabling the output poll work as needed
Date: Wed, 23 Jul 2025 15:54:23 +0300
Message-Id: <20250723125427.59324-2-nicusor.huhulea@siemens.com>
In-Reply-To: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
References: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 02:01:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19579

From: Imre Deak <imre.deak@intel.com>

After the commit in the Fixes: line below, HPD polling stopped working
on i915, since after that change calling drm_kms_helper_poll_enable()
doesn't restart drm_mode_config::output_poll_work if the work was
stopped (no connectors needing polling) and enabling polling for a
connector (during runtime suspend or detecting an HPD IRQ storm).

After the above change calling drm_kms_helper_poll_enable() is a nop
after it's been called already and polling for some connectors was
disabled/re-enabled.

Fix this by calling drm_kms_helper_poll_reschedule() added in the
previous patch instead, which reschedules the work whenever expected.

Fixes: d33a54e3991d ("drm/probe_helper: sort out poll_running vs poll_enabled")
CC: stable@vger.kernel.org # 6.4+
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230822113015.41224-2-imre.deak@intel.com
(cherry picked from commit 50452f2f76852322620b63e62922b85e955abe94)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Partial-Backport-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index f7a2f485b177c..6ba2d7b0cd1b7 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -208,7 +208,7 @@ intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
 
 	/* Enable polling and queue hotplug re-enabling. */
 	if (hpd_disabled) {
-		drm_kms_helper_poll_enable(dev);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 		mod_delayed_work(system_wq, &dev_priv->display.hotplug.reenable_work,
 				 msecs_to_jiffies(HPD_STORM_REENABLE_DELAY));
 	}
@@ -638,7 +638,7 @@ static void i915_hpd_poll_init_work(struct work_struct *work)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (enabled)
-		drm_kms_helper_poll_enable(dev);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 
 	mutex_unlock(&dev->mode_config.mutex);
 
-- 
2.39.2


