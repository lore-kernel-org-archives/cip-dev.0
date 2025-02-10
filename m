Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D5C021A6
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.45202.1739170602109662561
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=erlgJw0G;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=fdHkP
	njzNI7ozIGMiEunkAyWiyl6YSEi1qVfY9DfIV8=;b=erlgJw0G1aUoinbqXGYQ/O+cmXFSoaDjP5G
	h/7kpBbdFR2VJA3pkW97qypVabN3NZ4BRxfaSEUyOnp75fIU7LW5LQlFUtd2hznWRb9Wy/SE2n6dT
	dC4vPNfwmMcqqdgtV//QYwFmiZLbaAUjYV0WfG2/x8YtPHG7WuuVhi0NMTue7wZIGJe4+TEtPpsh+
	zOFQHMBMF46DVEjkfLikhXdtzkLrz5oGqh0zSSkAX7t1ATj8ifDzv0xbzIcqNr6k8xPcZuOTUGa7q
	rcMZfh1JNobtukvzSMlitgVBscr3DV7PWhu7ap0LpSJfhcCZTgTXIglUAjyFzoljsiuFW2TNU0xA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51A6uBo63387719; Mon, 10 Feb 2025 15:56:11 +0900
X-Iguazu-Qid: 2yAbyr8UnwGzlFQUfW
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbyr8UnwGzlFQUfW; m=MaKdUf6dvxZzTTYqlF6U7FRj3iX0YihVW29YRSsydbo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 51A6u7xg1015857
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 11/17] async: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:39 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-12-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17788

From: Thomas Gleixner <tglx@linutronix.de>

commit b4def42724594cd399cfee365221f5b38639711d upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in async_run_entry_fn() and
async_synchronize_cookie_domain() to handle the extra states.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184735.865155020@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 kernel/async.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/async.c b/kernel/async.c
index f1fd155abff6..23cae44a6ae8 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -118,14 +118,14 @@ static void async_run_entry_fn(struct work_struct *work)
 	ktime_t uninitialized_var(calltime), delta, rettime;
 
 	/* 1) run (and print duration) */
-	if (initcall_debug && system_state == SYSTEM_BOOTING) {
+	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		pr_debug("calling  %lli_%pF @ %i\n",
 			(long long)entry->cookie,
 			entry->func, task_pid_nr(current));
 		calltime = ktime_get();
 	}
 	entry->func(entry->data, entry->cookie);
-	if (initcall_debug && system_state == SYSTEM_BOOTING) {
+	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		rettime = ktime_get();
 		delta = ktime_sub(rettime, calltime);
 		pr_debug("initcall %lli_%pF returned 0 after %lld usecs\n",
@@ -288,14 +288,14 @@ void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain
 {
 	ktime_t uninitialized_var(starttime), delta, endtime;
 
-	if (initcall_debug && system_state == SYSTEM_BOOTING) {
+	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		pr_debug("async_waiting @ %i\n", task_pid_nr(current));
 		starttime = ktime_get();
 	}
 
 	wait_event(async_done, lowest_in_progress(domain) >= cookie);
 
-	if (initcall_debug && system_state == SYSTEM_BOOTING) {
+	if (initcall_debug && system_state < SYSTEM_RUNNING) {
 		endtime = ktime_get();
 		delta = ktime_sub(endtime, starttime);
 
-- 
2.30.2



