Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F85C52D6D
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 11:37:56 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.3992.1722849465879241674
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 02:17:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=CmZn/1lo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1321639-202408050917427ad3e329f0f9229c88-hmamui@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202408050917427ad3e329f0f9229c88
        for <cip-dev@lists.cip-project.org>;
        Mon, 05 Aug 2024 11:17:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9qDzGPZK0KRNuwsuLLWsW7dMYyIlCrC1pgbePkPRT/A=;
 b=CmZn/1lowmcB5AOE0hyntWUfkAb59Sv59KVjsLxhq5x8eoBJCyq8b1l1fq6fwJEH6zr7CC
 BIOju0tSaOFTOICtEK33SnQODmrU3RuXBtP/WbdQsr+jS0oOasP6YkPiNPwsz11B7cXnpSsm
 PeB4f8BI4WVuLkkP0dug/PNDjTr2SnLJ+FJT/UhaNOSrowz4A5Fmna8z2UdXcd3kc/DJOztx
 oGhrUgvoSvgQReaFta4ya06c/ZM/SdFwY9U+3ND4mHK9ZGpkI7vv57Bx5g2Ea8M1mXtJdvnj
 j31PKuFlWkvG+0gBiVVJs1WPyWDkCIq9iYn86uCFA6y5WuaZJMgxNukw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] fix(PREEMPT_RT): disable CONFIG_RT_GROUP_SCHED
Date: Mon,  5 Aug 2024 11:17:22 +0200
Message-Id: <20240805091722.6871-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 11:37:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16715

This feature is simply broken on RT kernels that use cgroup2, as the
cpu controller features rt_period_us and rt_runtime_us are not
exposed, which are needed to configure things in a way that allows to
run tasks under RT/DL scheduling policies. It further seems to be
incompatible with the nohz_full option.

This patch just disables the feature, similar to upstream Debian.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
I'm wondering a bit how that was not discovered earlier in our RT tests.
Maybe Quirin can have a look if the cyclictest also shows errors that
the scheduling policy cannot be set. But maybe it simply did not show up
there, as the setup was to simplistic and did not enable the cgroup2 cpu
controller.

Note: This was discovered while tracing down kernel bugs around
timer slack on RT/DL tasks.

Best regards,
Felix Moessbauer
Siemens AG

 recipes-kernel/linux/files/preempt-rt.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
index 4afe1bf..ea37556 100644
--- a/recipes-kernel/linux/files/preempt-rt.cfg
+++ b/recipes-kernel/linux/files/preempt-rt.cfg
@@ -1,6 +1,7 @@
 # >= 5.10
 CONFIG_EXPERT=y
 CONFIG_PREEMPT_RT=y
+CONFIG_RT_GROUP_SCHED=n
 # <= 4.19
 CONFIG_PREEMPT_RT_FULL=y
 
-- 
2.39.2


