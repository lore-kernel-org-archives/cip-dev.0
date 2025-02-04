Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1D9C02192
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 00:48:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.105241.1738630097756370055
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 16:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=SWgqRXJ3;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1738630063;x=1739839663;bh=BfVd1
	Kr9aFB9e0q+IARJRTODnRHHsOmAQ5YFSacC2G0=;b=SWgqRXJ3uTOLrBAh28J+gSmKI0DAktFH0Pm
	UdQ+pcOeM+4773MwLjE7ohwmlm4pP1dLb4e0uYDmEpWZw/QwLxZPeLSzh9qSjVrvBUtdJ0hw273wo
	efYqULSohcGFolLxRofW6YHK+EDaUB3P6AcL5TOSrnGxDaZRtMQHvpP92+RyKh+AGgGS7WMj8f5r0
	gBhEghoizKQcJ8Jf5mvHoi7TNPQamEj3wlpT5l5HUFACrps8YkmKxVNYgYyCkaSLfvKqzZRMvq10x
	6X+Mmp9dMeCuYEMyLo5ClRE479he3tDxc+BYxjKDGvmjUopT8tSpkBcygkmCXSbfy8U0r4CwYd+Q=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5140lg8D1755166; Tue, 4 Feb 2025 09:47:42 +0900
X-Iguazu-Qid: 2yAbAvUQLBamBJJ4Jf
X-Iguazu-QSIG: v=2; s=0; t=1738630062; q=2yAbAvUQLBamBJJ4Jf; m=EYnyDhiFJwSiMT7AaAO/x4s1cYkkAhXV1xRMnXaGgyM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5140leal1589797
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 09:47:40 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 4.9 v1 1/2] init: Introduce system_scheduling flag for allocate_slab()
Date: Tue,  4 Feb 2025 09:46:03 +0900
X-TSB-HOP2: ON
Message-Id: <1738629964-11977-2-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 00:48:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17739

Between v4.14-rt and v5.10-rt, allocate_slab() is responsible for enabling
IRQ before running the following SLAB allocation functions if
    system_state >= SYSTEM_SCHEDULING
However, SYSTEM_SCHEDULING is introduced[1] in the mainline v4.13 and
it's not reasonable to backport all related changes into older RT kernels
from functional compatibility and longer term maintenance perspectives.

Thus, as an alternative (but non-mainline) way, introduce an extra flag
"system_scheduling" which becomes true at the same point as
    system_state = SYSTEM_SCHEDULING
in the mainline, so that the existing system_states and users of them
are not affected.

allocate_slab() will use this flag for its IRQ control by the upcoming change.

[1] https://lore.kernel.org/all/20170516184231.564888231@linutronix.de/

Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 include/linux/kernel.h |  1 +
 init/main.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d68f639f7330..2a15e829aaec 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -490,6 +490,7 @@ extern enum system_states {
 	SYSTEM_RESTART,
 	SYSTEM_SUSPEND,
 } system_state;
+extern bool system_scheduling;
 
 #define TAINT_PROPRIETARY_MODULE	0
 #define TAINT_FORCED_MODULE		1
diff --git a/init/main.c b/init/main.c
index 9933fca3a5c8..4f382179b61e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -110,6 +110,14 @@ bool early_boot_irqs_disabled __read_mostly;
 enum system_states system_state __read_mostly;
 EXPORT_SYMBOL(system_state);
 
+/*
+ * This corresponds to system_state >= SYSTEM_SCHEDULING in the mainline.
+ * On PREEMPT_RT kernels, slab allocator requires this state to check if
+ * the allocation must be run with IRQ enabled or not.
+ */
+bool system_scheduling __read_mostly = false;
+EXPORT_SYMBOL(system_scheduling);
+
 /*
  * Boot command-line arguments
  */
@@ -401,6 +409,10 @@ static noinline void __init_refok rest_init(void)
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
+
+	/* Corresponds to system_state = SYSTEM_SCHEDULING in the mainline */
+	system_scheduling = true;
+
 	complete(&kthreadd_done);
 
 	/*
-- 
2.30.2



