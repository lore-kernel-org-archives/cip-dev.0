Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588FC021B0
	for <webhook@archiver.kernel.org>; Mon, 10 Feb 2025 06:56:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.45198.1739170601720911336
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Feb 2025 22:56:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=OjGKWIam;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=FHAeI
	ehSEre1DyNaE7gwBGK5RKji0Lu3Jnohnse04d4=;b=OjGKWIamTx8AI2I0z+dKYt6agyZemzXxTHc
	IbLR/XIpV5nJzs9czibVZGYJYpO06yJ2ysncCwA+k0TKr+4j328NdF2tJsLM8+wVH4ACqxvbA2v2d
	jKeT9m2zcIwOmRmso8RGuxdV/Kuufi9NME5HFRp/PC4YOC7hkhaCdfBELI+giDylQTb9svnG5xAvl
	R6uxd9fpRf4ks3+VuGHF9R/4jcn3JfTmPpS4YAfN9TCkIVp+/SIvQr80kgxi7OacjC1ftpyjASiJE
	vOz6gp/pyyjnHrdZOs2358QfVGvHe5cY0qYdjXLc3RCeDYTdA2F5gFjU0UprZMXuIh0HQ+eDanQA=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51A6uBwN3387727; Mon, 10 Feb 2025 15:56:11 +0900
X-Iguazu-Qid: 2yAbaKzOfppzBY90eO
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2yAbaKzOfppzBY90eO; m=Od9Sd0ZYpAI44Mzn2nbC6uMQS4rc95151elHLMzEetg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51A6u7Wa1015859
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 09/17] cpufreq/pasemi: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:37 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-10-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Feb 2025 06:56:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17781

From: Thomas Gleixner <tglx@linutronix.de>

commit d04e31a23c3c828456cb5613f391ce4ac4e5765f upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in pas_cpufreq_cpu_exit() to handle the extra
states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170516184735.620023128@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/cpufreq/pasemi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 991b6a3062c4..d1bdd8f62247 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -222,7 +222,7 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	 * We don't support CPU hotplug. Don't unmap after the system
 	 * has already made it to a running state.
 	 */
-	if (system_state != SYSTEM_BOOTING)
+	if (system_state >= SYSTEM_RUNNING)
 		return 0;
 
 	if (sdcasr_mapbase)
-- 
2.30.2



