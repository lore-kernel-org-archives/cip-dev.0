Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5FC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 14:51:08 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.61419.1723127486460893243
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Aug 2024 07:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=eO3p+9wu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1321639-20240808143123abbfa44cdee4f39577-i_eqju@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240808143123abbfa44cdee4f39577
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Aug 2024 16:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SEXWB2JSMyxu/x7xU9fhzHGlnvRVn0dnTjMP1+HbJs8=;
 b=eO3p+9wuqlxBVFSNAmp014c9clAy/R1m0khfUHvjQgIkue09YNP0UHnsoDzkqU7INpKHLP
 ayxk32AmCENfRLmMcl0NS8gHqcrd6zs47HqPfd2ZgSoH8Q5qd67CytamBJ4Sxa0tEtutJief
 ky2DNvhaNGhR+euT4ozvVaUHBBIQjR6+CmCNpkDi+q/4gzJG2e7N518L69/h46NtumV5Xh6Q
 vp0yRj439xc7l50UmBGVQh6/DVdBjWaQ8V377OWrhY7Hnt/gMPCtc87Hz4npTHvdifQ5gKMu
 IIArQj9CDHssnCpyRnGUDUC7t8On0rRTjzN7fNLwpfcM5LSl8WM1jOOA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/1] PREEMPT_RT: enable isolcpus feature set
Date: Thu,  8 Aug 2024 16:31:04 +0200
Message-Id: <20240808143104.542740-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Aug 2024 14:51:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16763

The current cip-rt kernel config does not enable the isolcpus feature
set. As almost all current rt deployments still rely on the isolcpus
feature, we should also enable it here. It anyways only comes into play
when setting the isolcpus= kernel cmdline parameter. By that, we just
set the kconfig option CONFIG_CPU_ISOLATION=y for the preempt-rt kernel.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 recipes-kernel/linux/files/preempt-rt.cfg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
index ea37556..afbf53d 100644
--- a/recipes-kernel/linux/files/preempt-rt.cfg
+++ b/recipes-kernel/linux/files/preempt-rt.cfg
@@ -2,6 +2,7 @@
 CONFIG_EXPERT=y
 CONFIG_PREEMPT_RT=y
 CONFIG_RT_GROUP_SCHED=n
+CONFIG_CPU_ISOLATION=y
 # <= 4.19
 CONFIG_PREEMPT_RT_FULL=y
 
-- 
2.39.2


