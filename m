Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF7C021A5
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.45205.1739170602474730499
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=br51Xz3i;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=b8rrf
	MXIzh/6gB/7BIug22meGebSbUh7PWeoHodsWAI=;b=br51Xz3iZcURVQ7VFWDs/bRTbCF1f4cUVE5
	gsxGtHiMrCFJ8ilSMmaUebb8+CmTyfo9gYdy3r58IB7by14ziMdByvmKE4qudPK8CeLBL3mUGXNaQ
	+OMfwCl90oK8kxOfcMjoTe5rGRUAB2OZj4wyaD5wpXRW0lT8S3HpOhsWXGae/2i/XgB1TjguY66o0
	V22egeAr/zn1A36UFg24VVw9EwQvd/ul5I5KNbAOEiDKqwAmw5DsW0y/+0w2i+eeGL5fxXU1HigG5
	hTkHwtv21XSJJzRA0E+AICusXOh7vccmGWyp3/rlDjcg/vQC2QjT02N1RKTy9jnOz0geTrf+U9fw=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A6uANx3587290; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2rWhqikycnTS8B6ZlK
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhqikycnTS8B6ZlK; m=QJxngnsd5z1jHW2IqHw3hANCAKlwKNbBxxbFR6RYx9I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 51A6u7Eb182827
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 06/17] powerpc: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:34 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-7-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17791

From: Thomas Gleixner <tglx@linutronix.de>

commit a8fcfc1917681ba1ccc23a429543a67aad8bfd00 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in smp_generic_cpu_bootable() to handle the
extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170516184735.359536998@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 19ba60ab1807..5dff1a750e49 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -94,7 +94,7 @@ int smp_generic_cpu_bootable(unsigned int nr)
 	/* Special case - we inhibit secondary thread startup
 	 * during boot if the user requests it.
 	 */
-	if (system_state == SYSTEM_BOOTING && cpu_has_feature(CPU_FTR_SMT)) {
+	if (system_state < SYSTEM_RUNNING && cpu_has_feature(CPU_FTR_SMT)) {
 		if (!smt_enabled_at_boot && cpu_thread_in_core(nr) != 0)
 			return 0;
 		if (smt_enabled_at_boot
-- 
2.30.2



