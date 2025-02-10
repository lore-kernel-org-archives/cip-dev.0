Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B52C021A1
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.45362.1739170602436669542
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=m1dhlpEF;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170574;x=1740380174;bh=+jRq6
	pBjTZA/g6J9T9NYXpzObiQLHmv8zugfNAxez44=;b=m1dhlpEFy6B42fF2cCw+w2kcj//WKiD+mkj
	o4XPUh2xy1aaRa7QTO/nuGiCALvDUTtc2SpSRIvRVqMu9hvUiFetozN1w7rZbGymt0GoVdUfNLO0D
	MDbnYVm8nRodTAFJHI5WuyIJ8v2DHhTSX1eenFMXBJ+x0q1VNcbPFeltgBBb4ZwW/ZiOPGz+6EjRM
	NxtKohjzL7i/d7uP7vH3gzCa9Ohz8Mfdl3Bb6OgJw/2XjXY8a4RO/CNtSdveWH3JOw2lGbAZzcPCV
	0YvPK3VKWU5GANAqVBIvpTEpsDc3pxzpKTREi7KEdDXNHBWWFRKX0fISga7iNbh9EnzorpehBZCQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 51A6uDur3258935; Mon, 10 Feb 2025 15:56:14 +0900
X-Iguazu-Qid: 2yAbAvUQLMDymhsI16
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2yAbAvUQLMDymhsI16; m=a3H3MO9Uo5vvHAlyEcveR+c2PIVSA+TssczIWnNiNTI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51A6u8nV1015867
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 15/17] init: Introduce SYSTEM_SCHEDULING state
Date: Mon, 10 Feb 2025 15:55:43 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-16-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17792

From: Thomas Gleixner <tglx@linutronix.de>

commit 69a78ff226fe0241ab6cb9dd961667be477e3cf7 upstream.

might_sleep() debugging and smp_processor_id() debugging should be active
right after the scheduler starts working. The init task can invoke
smp_processor_id() from preemptible context as it is pinned on the boot cpu
until sched_smp_init() removes the pinning and lets it schedule on all non
isolated cpus.

Add a new state which allows to enable those checks earlier and add it to
the xen do_poweroff() function.

No functional change.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184736.196214622@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/xen/manage.c   | 1 +
 include/linux/kernel.h | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
index f494126aaecd..4f907fbda6c0 100644
--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -188,6 +188,7 @@ static void do_poweroff(void)
 {
 	switch (system_state) {
 	case SYSTEM_BOOTING:
+	case SYSTEM_SCHEDULING:
 		orderly_poweroff(true);
 		break;
 	case SYSTEM_RUNNING:
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d68f639f7330..d472456c6fcc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -481,9 +481,13 @@ extern int root_mountflags;
 
 extern bool early_boot_irqs_disabled;
 
-/* Values used for system_state */
+/*
+ * Values used for system_state. Ordering of the states must not be changed
+ * as code checks for <, <=, >, >= STATE.
+ */
 extern enum system_states {
 	SYSTEM_BOOTING,
+	SYSTEM_SCHEDULING,
 	SYSTEM_RUNNING,
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
-- 
2.30.2



