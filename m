Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A1C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 04:39:07 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.39783.1753892600239981142
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 09:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm2 header.b=fP8bzklG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1331196-202507301613112cb2df381ecfb92088-yimbfe@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202507301613112cb2df381ecfb92088
        for <cip-dev@lists.cip-project.org>;
        Wed, 30 Jul 2025 18:13:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=aNY5rREpntN5KY99m0InyXuj1Ii+MliHCugcFt3V6Y8=;
 b=fP8bzklGBtCw0ZPPEI8/7MCk5YmKagpw9Yt0tKUrqZU88pAtPjaW5O95OAdmpcTdL3gUKb
 GArFDTi/iS5gkr6ImiVKXh31VKlMD8U/GlGVp93lK7XeUUtXGOUaYATsvzhFSZL68XNMLxuY
 B/nLChTvhnFaRZItLdK8q5Ic62UGanMaVsYB5p+fgsqY3YUsiHCKFVpU7VPD1JlVF5X6/MIK
 E1jLEkpwPB3elRwT1a2Ar5d3Y/W+shoOHBPa3dFS7wqIYrcrlH/hwZW/gr+fH5wJUWVFGCqy
 dmn3BcA87alI6MH0cTq56UeaRp/pUBWTU8e0jxWh6dyrWyQlzftMmQdQ==;
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
Subject: [PATCH 0/5] drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues
Date: Wed, 30 Jul 2025 19:11:01 +0300
Message-Id: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 04:39:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19626

Hello maintainers,

This series addresses a defect observed on certain hardware platforms using Linux kernel 6.1.147 with the i915 driver. The issue concerns hot plug detection (HPD) logic,
leading to unreliable or missed detection events on affected hardware. This is happening on some specific devices.

### Background

Issue:
    On Simatic IPC227E, we observed unreliable or missing hot plug detection events, while on Simatic IPC227G (otherwise similar platform), expected hot plug behavior was maintained.
Affected kernel:
    This patch series is intended for the Linux 6.1.y stable tree only (tested on 6.1.147)
    Most of the tests were conducted on 6.1.147 (manual/standalone kernel build, CIP/Isar context).
Root cause analysis:
    I do not have access to hardware signal traces or scope data to conclusively prove the root cause at electrical level. My understanding is based on observed driver behavior and logs.
    Therefore my assumption as to the real cause is that on IPC227G, HPD IRQ storms are apparently not occurring, so the standard HPD IRQ-based detection works as expected. On IPC227E,
    frequent HPD interrupts trigger the i915 driver’s storm detection logic, causing it to switch to polling mode. Therefore polling does not resume correctly, leading to the hotplug
    issue this series addresses. Device IPC227E's behavior triggers this kernel edge case, likely due to slight variations in signal integrity, electrical margins, or internal component timing.
    Device IPC227G, functions as expected, possibly due to cleaner electrical signaling or more optimal timing characteristics, thus avoiding the triggering condition.
Conclusion:
    This points to a hardware-software interaction where kernel code assumes nicer signaling or margins than IPC227E is able to provide, exposing logic gaps not visible on more robust hardware.

### Patches

Patches 1-4:
    - Partial backports of upstream commits; only the relevant logic or fixes are applied, with other code omitted due to downstream divergence.
    - Applied minimal merging without exhaustive backport of all intermediate upstream changes.
Patch 5:
    - Contains cherry-picked logic plus context/compatibility amendments as needed. Ensures that the driver builds.
    - Together these fixes greatly improve reliability of hotplug detection on both devices, with no regression detected in our setups.

Thank you for your review,
Nicusor Huhulea

This patch series contains the following changes:

Dmitry Baryshkov (2):
  drm/probe_helper: extract two helper functions
  drm/probe-helper: enable and disable HPD on connectors

Imre Deak (2):
  drm/i915: Fix HPD polling, reenabling the output poll work as needed
  drm: Add an HPD poll helper to reschedule the poll work

Nicusor Huhulea (1):
  drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues

 drivers/gpu/drm/drm_probe_helper.c           | 127 ++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_hotplug.c |   4 +-
 include/drm/drm_modeset_helper_vtables.h     |  22 ++++
 include/drm/drm_probe_helper.h               |   1 +
 4 files changed, 122 insertions(+), 32 deletions(-)

-- 
2.39.2


