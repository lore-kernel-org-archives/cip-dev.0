Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39BCC021A7
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.45199.1739170601889541331
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=d3d2EDfY;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170573;x=1740380173;bh=7ik5t
	U+aigkCH+DjxsodxVPjPp2fSYh7lpQZcnFBhMU=;b=d3d2EDfYsSuwE5qp9yxTdvbvKzIo3gp1Vvl
	X5vuJ54hVyogvK0mZOho/e4byR+tG67kmFazsnec9xhuo4DH/aJN6a32fpScULSAHJRyvgXTgNUjq
	kpL7jZ45W4YMyNnOjjp7lc4Zqp7wZKsNstLTOHnZd21HEJ8z4IdYTCj8xuTFapv8h/FTGh5Yjz/qQ
	/vhypP+lwWJAEbKcQccG1g8fjkA9OgtN7531DwRQC4bD8RlRtl17CRR42ur6Zoqq0KNwyiFDYqNAt
	H+FtnwrjFzq4i0OabTmcjt70/L4ApgK/at85cDmS65rfPhzFM5yX+EBMN+jBf1qFg8pmLg43y4VQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 51A6uDYW3258916; Mon, 10 Feb 2025 15:56:13 +0900
X-Iguazu-Qid: 2yAbAvUQLMDymhsI12
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbAvUQLMDymhsI12; m=z6ixCw7oMkuV8hIiY7pyEwGC8S/FFfZk875O/LRTkb0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 51A6u6A24036125
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 04/17] x86/smp: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:32 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-5-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17786

From: Thomas Gleixner <tglx@linutronix.de>

commit 719b3680d1f789c1e3054e3fcb26bfff07c3c623 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in announce_cpu() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184735.191715856@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0512af683871..2a9ada6fa7d0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -721,7 +721,7 @@ static void announce_cpu(int cpu, int apicid)
 	if (cpu == 1)
 		printk(KERN_INFO "x86: Booting SMP configuration:\n");
 
-	if (system_state == SYSTEM_BOOTING) {
+	if (system_state < SYSTEM_RUNNING) {
 		if (node != current_node) {
 			if (current_node > (-1))
 				pr_cont("\n");
-- 
2.30.2



