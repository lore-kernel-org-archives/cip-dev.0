Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D76C87FC5
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 02:01:20 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.14296.1753275891336258450
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Jul 2025 06:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nicusor.huhulea@siemens.com header.s=fm1 header.b=nnkLC9Ts;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1331196-20250723125440c9737d84866ed88e5b-bg63ac@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250723125440c9737d84866ed88e5b
        for <cip-dev@lists.cip-project.org>;
        Wed, 23 Jul 2025 14:54:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=NJcAvc0OyCViRWQNE6JcCAf94xD01kERFmcciFPLJGQ=;
 b=nnkLC9TsHkJrqcq13IBRrJ/stkusneJQ33c3ceCzZIVyn6dSJbQJOum7SEm2aEAN8YFmxk
 EpjkLouDeL52y2WcuobCcXmHBFTb/2Vx3OjCloFYJfVGWe/UVJYDca4rkd6SZsahVHdHjANb
 5/AbCg11plzjIXiBRhNBV+D47sjNKAjTYaXxIKGRNnfhd2SgotL3PVGPudaSw0ShQ8xLYzrs
 9Ud41/vSaDsbRZn5kqCqHFIY1VnHlC4ES4ssH3GlKFcAeR3xPYad5Yg74bTeUMOaMbxLZIsx
 Wjr7809ke2i7wsOC0F0Os6m9Pw37rD/Ns27xhes4Tb9u3ZSqTjfmtOzw==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 6.1.y-cip 0/5] drm/i915: fixes for i915 Hot Plug Detection and build/runtime issues
Date: Wed, 23 Jul 2025 15:54:22 +0300
Message-Id: <20250723125427.59324-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Jul 2025 02:01:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19582

Hello maintainers,

This series addresses a defect observed on certain hardware platforms using Linux kernel 6.1.127 with the i915 driver. The issue concerns hot plug detection (HPD) logic, 
leading to unreliable or missed detection events on affected hardware. This is happening on some specific devices.

### Background

Issue:
    On Simatic IPC227E, we observed unreliable or missing hot plug detection events, while on Simatic IPC227G (otherwise similar platform), expected hot plug behavior was maintained.
Affected kernel:
    Most of the tests were conducted on 6.1.127 (manual/standalone kernel build, CIP/Isar context). But it also happens on 6.1.145-cip44
Root cause analysis:
    Through testing and diagnostics, it appears that the HPD finite state machine or polling logic in kernel 6.1.127 is marginal for this edge case. Device IPC227E's behavior triggers
    this kernel edge case, likely due to slight variations in signal integrity, electrical margins, or internal component timing.
    Simatic IPC227G, functions as expected, possibly due to cleaner electrical signaling or more optimal timing characteristics, thus avoiding the triggering condition.
Summary:
    This points to a hardware-software interaction where kernel code assumes nicer signaling or margins than IPC227E is able to provide, exposing logic gaps not visible on more robust hardware.

### Patches

Patches 1-4:
    - Partial backports of upstream commits; only the relevant logic or fixes are applied, with other code omitted due to downstream divergence.
Patch 5:
    - Additional modifications to ensure the driver builds and resolves run-time issues
    - Contains cherry-picked logic plus context/compatibility amendments as needed.
    - Together these fixes greatly improve reliability of hotplug detection on both devices, with no regression detected in our setups.

Thank you for your review,
Nicusor Liviu Huhulea

This patch series contains the following changes:

Dmitry Baryshkov (2):
  [PARTIAL BACKPORT]drm/probe_helper: extract two helper functions
  [PARTIAL BACKPORT]drm/probe-helper: enable and disable HPD on
    connectors

Imre Deak (2):
  [PARTIAL BACKPORT]drm/i915: Fix HPD polling, reenabling the output
    poll work as needed
  [PARTIAL BACKPORT]drm: Add an HPD poll helper to reschedule the poll
    work

Nicusor Huhulea (1):
  [PARTIAL BACKPORT]fixes for i915 Hot Plug Detection and build/runtime
    issues

 drivers/gpu/drm/drm_probe_helper.c           | 125 ++++++++++++++-----
 drivers/gpu/drm/i915/display/intel_hotplug.c |   4 +-
 include/drm/drm_modeset_helper_vtables.h     |  22 ++++
 include/drm/drm_probe_helper.h               |   1 +
 4 files changed, 118 insertions(+), 34 deletions(-)

-- 
2.39.2

