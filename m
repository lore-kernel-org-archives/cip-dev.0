Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D4CD3427
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 15:25:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42382.1777994735309095524
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 May 2026 08:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=ONCTYxAH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202605051525339db6dc00840002077f-yxk_2o@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202605051525339db6dc00840002077f
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 May 2026 17:25:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=EpiE+vQITzb6pDD2V43k/oBGDn2bhIJ8rsDHpKyEQoE=;
 b=ONCTYxAHklBU5lKoYQU1ds0kJuEriWC1OyqrNim6ldqWtLh1eN56RRTQz6S05A+tG2ZWDS
 x1wrUl9gnzW9kIZE1QyUfjmGAAePi6yYH+u/cGHws/iLnr+O7Y+TYyb934frZOo4I0D/hhle
 kPtARPqScpSOwZ1p52V05WO7/1zUtoraXod3RovBKHtYNUxRcJR72tJorGyi+2B0t5x/S7EP
 OGM3Z+xoMQe9BRQ2KQys1T3UkqtZ1eAqIHMcvIigt2T3diFfog6oENbroGXn8JrSih9Lp/xQ
 L5dazIJUWO7V29+ZtX7oBeg5HxjRYrBU9MRzr+uSVJuyVErAMYoGjLDg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/3] linux-cip: Switch to out-of-tree PREEMPT-RT config fragment
Date: Tue,  5 May 2026 17:25:30 +0200
Message-ID: <0ef583915456e356671811c01fa57596015b71b0.1777994730.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1777994730.git.jan.kiszka@siemens.com>
References: <cover.1777994730.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 May 2026 15:25:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22887

From: Jan Kiszka <jan.kiszka@siemens.com>

We are now maintaining the PREEMPT-RT enabling config fragment in
cip-kernel-config, for reuse kernel KernelCI. Switch to it, just bailing
out in case the user asks for RT, does not use the CIP configs but also
does not provide an alternative RT_FRAGMENT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc |  2 ++
 recipes-kernel/linux/files/preempt-rt.cfg  | 30 ----------------------
 recipes-kernel/linux/linux-cip-common.inc  |  9 +++++--
 3 files changed, 9 insertions(+), 32 deletions(-)
 delete mode 100644 recipes-kernel/linux/files/preempt-rt.cfg

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 34fb354a..32cad6c4 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -32,3 +32,5 @@ KBUILD_DEPENDS:append = "${@ \
 SRC_URI:append = " ${@ \
     'file://no-module-signing.cfg' if bb.utils.to_boolean(d.getVar('NO_MODULE_SIGNING')) else '' \
     }"
+
+RT_FRAGMENT ?= "${@'cip-kernel-config/cfg/preempt-rt.cfg' if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else ''}"
diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
deleted file mode 100644
index f5583657..00000000
--- a/recipes-kernel/linux/files/preempt-rt.cfg
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# SPDX-License-Identifier: MIT
-#
-# >= 5.10
-CONFIG_EXPERT=y
-CONFIG_PREEMPT_RT=y
-CONFIG_RT_GROUP_SCHED=n
-CONFIG_CPU_ISOLATION=y
-# <= 4.19
-CONFIG_PREEMPT_RT_FULL=y
-
-CONFIG_DEBUG_ATOMIC_SLEEP=y
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_LOCKDEP=n
-
-CONFIG_CPU_FREQ=n
-CONFIG_CPU_IDLE=n
-
-CONFIG_NO_HZ=n
-CONFIG_HZ_PERIODIC=y
-
-CONFIG_HZ_250=y
-CONFIG_HZ=250
-
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
-CONFIG_PM=n
-
-CONFIG_SLUB=y
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 4569b897..65335238 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2025
+# Copyright (c) Siemens AG, 2022-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -17,4 +17,9 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
 
 require recipes-kernel/linux/cip-kernel-config.inc
 
-SRC_URI += "${@'file://preempt-rt.cfg' if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
+KERNEL_CONFIG_FRAGMENTS:append = "${@(' ' + d.getVar('RT_FRAGMENT')) if d.getVar('KERNEL_NAME') == 'cip-rt' else ''}"
+
+python() {
+    if d.getVar('RT_FRAGMENT') == '' and d.getVar('KERNEL_NAME') == 'cip-rt':
+        bb.fatal("No RT_FRAGMENT provided for cip-rt kernel")
+}
-- 
2.47.3


