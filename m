Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8951DC021A4
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.45204.1739170602415473968
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=AnC3Hm5Y;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170575;x=1740380175;bh=oeSTV
	1dI+T8GrwEAkCPvGHesDTdealGcRC8KdexYD5I=;b=AnC3Hm5Y9xk8JXuJN1dIXHrxvS428YIDA5X
	HWM0a1+I4rouWYEJpr/xRVuiBjunane+Ja9ZOy+ytmw7+TxD4zJkVN/Z50cTkjbRJPDaBd29ysmyn
	CRRZLzuO1drzVvDKlRsM5AhX/RS/3S22xaF+wL90RfFL0IqCe9JQ4xPpvxB5coy/XFgOQmacv1qeg
	zVL2WA4GCXdc2h2n8aBT1/w0K9mOXhJK6BL1lTShMAzJAznbf+3y8/+psQaN7+icFG1x7KAD54RST
	DGrmdPrK0oyqKPp8/Y28QrtnJURMyRQPCYOQkfeCDfqJs3lQanb+Jx7qh0rjRtStkXCdS1wQm7bA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51A6uFb13832482; Mon, 10 Feb 2025 15:56:15 +0900
X-Iguazu-Qid: 2rWhSHZE3yt6r0xIbx
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhSHZE3yt6r0xIbx; m=Y0hJNGDdcj4uKOoeojwG12+1jPvQ2I44K5L5a9Bg+kc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 51A6u6tX182804
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 03/17] arm64: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:31 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-4-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17790

From: Thomas Gleixner <tglx@linutronix.de>

commit ef284f5ca5f102bf855e599305c0c16d6e844635 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in smp_send_stop() to handle the extra states.

Conflicts: arch/arm64/kernel/smp.c
82611c14 moves per-CPU stop message from ipi_cpu_stop() to smp_send_stop(),
but no change in checking system_state condition.
Apply the change to ipi_cpu_stop() instead.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20170516184735.112589728@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/arm64/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 36182dafd63c..9b21b6ccc3f1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -685,8 +685,7 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
-- 
2.30.2



