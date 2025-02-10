Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEF2C021AB
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.45203.1739170602361431836
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=aCX/vASB;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170576;x=1740380176;bh=tzD5U
	nyZwjInSLknlehUgMLUsGKRRIAWVDJzXwhh1Dc=;b=aCX/vASBJa9J7XHQjiqmCgQEmBa1/Mt3afV
	FetRNRM0/CdH6cNoiF9NHl6IGAFW73LaeReYLptonu6qfMQwBGcoLqJw8xd3AnAY+/2FW7nugcryo
	/AHnsR4p7IrwVv96rmGvtAx9ook1UeMMi2WfyjM1M0DCoepeNbyKf1oq3kKZi3+A/pJmuF/zzrpg/
	72ALg5QdbS5ake6ktMD638UENnUZfINf64PSc2JZrkvQp/F6I4M4gUJ1Q+4t/SkDhnEttr2+EbeMo
	RApCuQ6ZDsEx2VyxtFT1+Vnik4n7UH8uUVzoqJCVhGeCuj8c5EaMQ6rNDNjbBBduFdd9Ns824T5w=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 51A6uGw33587747; Mon, 10 Feb 2025 15:56:16 +0900
X-Iguazu-Qid: 2rWhWAeBjX3UYC8AJ6
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhWAeBjX3UYC8AJ6; m=YXkk/oYQcG59h4NUfNxnbqOT6lCvTE7NmT2B5wixTK0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 51A6u7He859155
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 05/17] metag: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:33 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-6-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17789

From: Thomas Gleixner <tglx@linutronix.de>

commit dcd2e4734b428709984e2fa35ebbd6cccc246d47 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in stop_this_cpu() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20170516184735.283420315@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 arch/metag/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/metag/kernel/smp.c b/arch/metag/kernel/smp.c
index c3c6f0864881..0bc03c257fe6 100644
--- a/arch/metag/kernel/smp.c
+++ b/arch/metag/kernel/smp.c
@@ -565,8 +565,7 @@ static void stop_this_cpu(void *data)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if (system_state == SYSTEM_BOOTING ||
-	    system_state == SYSTEM_RUNNING) {
+	if (system_state <= SYSTEM_RUNNING) {
 		spin_lock(&stop_lock);
 		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
-- 
2.30.2



