Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA239C021AA
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.45206.1739170602644578560
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=bSzuvNKV;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170576;x=1740380176;bh=oPbhd
	i6X+NHmZoY+32TmyHl/HKc+x2mok1HvpyiYhAw=;b=bSzuvNKVpX/9glXGFuZlm9UjDKHJTsUZm45
	XTfziGG7DzsMQ1QkYSjkSittyqoSxVE8iBraY0hPHfpyJ2W8k8ovYEx6GWz9xJHhl7lsnauTvsp7Y
	APC3lfhUIYPOVQgBsB8P18cHiQzs4FwxPw9m2gA5uAxXOstugM59eAvxIzjvTbGQl4bFo0ag8aHIh
	jWOj9PCsy7pzGRg0gFEnz+nUIy/pnt44kLsz/nxbr04l1z5bPmFomMx036s2ODMU99JFqDcsDD6x7
	B+FdINI5uCkLCuyS0Kq+kKAWjwNfbiI2OFARra78tISlAeJb+90Gp/VTjtVJfUkdhS9y8cjujIzQ=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51A6uGJ3605581; Mon, 10 Feb 2025 15:56:16 +0900
X-Iguazu-Qid: 2rWhWAeBjX3UcsnPV6
X-Iguazu-QSIG: v=2; s=0; t=1739170570; q=2rWhWAeBjX3UcsnPV6; m=PEpGbHJPdTb+kyLSpGQ0l6qlUAcFXU+N+Hi+UfiPIQo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 51A6u73v4035346
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 14/17] mm/vmscan: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:42 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-15-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17793

From: Thomas Gleixner <tglx@linutronix.de>

commit c6202adf3a0969514299cf10ff07376a84ad09bb upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in kswapd_run() to handle the extra states.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184736.119158930@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76853088f66b..9cd702320375 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3620,7 +3620,7 @@ int kswapd_run(int nid)
 	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
 	if (IS_ERR(pgdat->kswapd)) {
 		/* failure at boot is fatal */
-		BUG_ON(system_state == SYSTEM_BOOTING);
+		BUG_ON(system_state < SYSTEM_RUNNING);
 		pr_err("Failed to start kswapd on node %d\n", nid);
 		ret = PTR_ERR(pgdat->kswapd);
 		pgdat->kswapd = NULL;
-- 
2.30.2



